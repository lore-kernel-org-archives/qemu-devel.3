Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08B4CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDstN-0002uG-1E; Tue, 28 Oct 2025 19:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstJ-0002sS-Ne
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:13 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDst7-00015L-Sk
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:11 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id CA6C98175A;
 Wed, 29 Oct 2025 02:13:56 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-jWYe7vL6; Wed, 29 Oct 2025 02:13:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693236;
 bh=eUNtf8Fv6YhCPh7tMB37uPwoLbYqG4nreTVa98r1+AY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1CpmAHDqwQXnBVXWoWDipZfxTgwvrT5+6YW4XkcyXQc95ATqB7EDorf4bY7f4r1i7
 OKs1lssa5AYHZYGr5NS++SMHkGkoRjHk4lI42065IQmbPw0Iay1lFPaXunjKk7WIH6
 oot4NRUsChZ4S+heL2M8QgLXR1RSs+ISpMUDSvA8=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 07/22] hw/scsi/scsi-bus.c: use new migration APIs
Date: Wed, 29 Oct 2025 02:13:31 +0300
Message-ID: <20251028231347.194844-8-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
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
 hw/scsi/scsi-bus.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 9b12ee7f1c..d8d4b8ceae 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -1888,18 +1888,19 @@ static void put_scsi_req(SCSIRequest *req, void *opaque)
     }
 }
 
-static int put_scsi_requests(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field, JSONWriter *vmdesc)
+static bool put_scsi_requests(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, JSONWriter *vmdesc,
+                              Error **errp)
 {
     SCSIDevice *s = pv;
 
     scsi_device_for_each_req_sync(s, put_scsi_req, f);
     qemu_put_sbyte(f, 0);
-    return 0;
+    return true;
 }
 
-static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
-                             const VMStateField *field)
+static bool get_scsi_requests(QEMUFile *f, void *pv, size_t size,
+                              const VMStateField *field, Error **errp)
 {
     SCSIDevice *s = pv;
     SCSIBus *bus = DO_UPCAST(SCSIBus, qbus, s->qdev.parent_bus);
@@ -1938,13 +1939,13 @@ static int get_scsi_requests(QEMUFile *f, void *pv, size_t size,
         scsi_req_unref(req);
     }
 
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_scsi_requests = {
     .name = "scsi-requests",
-    .get  = get_scsi_requests,
-    .put  = put_scsi_requests,
+    .load = get_scsi_requests,
+    .save = put_scsi_requests,
 };
 
 static bool scsi_sense_state_needed(void *opaque)
-- 
2.48.1


