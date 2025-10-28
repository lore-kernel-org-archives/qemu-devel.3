Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E9DCCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstS-0002wU-KS; Tue, 28 Oct 2025 19:14:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstP-0002vR-NW
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:19 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstI-00016z-Mc
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:18 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E109A81755;
 Wed, 29 Oct 2025 02:13:58 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-RnhBXWm1; Wed, 29 Oct 2025 02:13:58 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693238;
 bh=peA71T7i9sOO5KdvHDZvmvhSBq1lY7n/g0KzoECVD0o=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Yuhr3aF0dCCoYRl4Gd1l37QWUk5Z0UiIdWjp4Q3GUCP3TsshcSkKtZnOyqZXjdfDI
 m4/+fVSqowOI6E1Y9yn2YEzVEMlPybu7LSdd7jhom2RqnP+NdM4I+vmcE6u1GFTSwo
 eNHOZG8dgw37Zw0KOqjgvXCmHt2e7JBjkfZx6+qw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 10/22] hw/pci/msix.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:34 +0300
Message-ID: <20251028231347.194844-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/pci/msix.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 8c7f6709e2..b915edf35c 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -679,25 +679,26 @@ void msix_unset_vector_notifiers(PCIDevice *dev)
     dev->msix_vector_poll_notifier = NULL;
 }
 
-static int put_msix_state(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field, JSONWriter *vmdesc)
+static bool put_msix_state(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, JSONWriter *vmdesc,
+                           Error **errp)
 {
     msix_save(pv, f);
 
-    return 0;
+    return true;
 }
 
-static int get_msix_state(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field)
+static bool get_msix_state(QEMUFile *f, void *pv, size_t size,
+                           const VMStateField *field, Error **errp)
 {
     msix_load(pv, f);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_msix = {
     .name = "msix state",
-    .get  = get_msix_state,
-    .put  = put_msix_state,
+    .load = get_msix_state,
+    .save = put_msix_state,
 };
 
 const VMStateDescription vmstate_msix = {
-- 
2.48.1


