Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C412C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyqz-0005oM-HS; Tue, 25 Aug 2026 17:38:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqx-0005mA-1A
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:43 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyqv-00051b-F1
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:42 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id 1976B80DC3;
 Wed, 26 Aug 2026 00:38:40 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-j8uGpPRU; Wed, 26 Aug 2026 00:38:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693919;
 bh=audUauMQ7mR1OoEWJhW5ZME203rf9Hd0Q7JXrwKu9EY=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=sBimIEo28IjzqOtf1k4pPNJPYuXGUu3bF+iGTQd8ssK482Kq5+/uMbAAcM4xwZcCC
 xjgVNBDycqZYX5v93Qjcvhs2U3uM/NboUkpRg2DKZFV4xPoDNklx3ZeZ+9MSx9rC1h
 cxBkLc+d/MtC8W36NjDqjNvBrbp1ToYRKRIJ2aNY=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: [PATCH 09/30] hw/scsi/scsi-bus.c: use new migration APIs
Date: Wed, 26 Aug 2026 00:37:49 +0300
Message-ID: <20260825213811.3725682-10-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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
 hw/scsi/scsi-bus.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index deb43d5560e..d455c0b46b5 100644
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
2.43.0


