Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB7EC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr1-0005pw-RM; Tue, 25 Aug 2026 17:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqz-0005oN-IR
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:45 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqx-000531-Ua
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id A608380BF2;
 Wed, 26 Aug 2026 00:38:42 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-C6uiMCf3; Wed, 26 Aug 2026 00:38:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693922;
 bh=vLlNeGxhkaOTLOWrbu3++IHaogXUp5T7e/JCST20a08=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KC5SoRNXONrzfgPgM3+Ingp3C+U4kMq9QBF2eTfslIn3/gd3I7N/5WA6GH3yP1Ui+
 Vf2yMpWMmRh/TTPPNQakJ93zegUCnYAeMMyhg2kYniH6oTYYkgkxLdX7yo5y7iN7mo
 AofC8xQz4h1VaFmj/C82bKD0vlYnn+Nh6wFxWwjA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 12/30] hw/pci/msix.c: use new migration APIs
Date: Wed, 26 Aug 2026 00:37:52 +0300
Message-ID: <20260825213811.3725682-13-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
index 1b23eaf1007..4dcb7c36770 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -685,25 +685,26 @@ void msix_unset_vector_notifiers(PCIDevice *dev)
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
2.43.0


