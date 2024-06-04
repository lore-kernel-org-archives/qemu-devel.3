Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A87C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 16:19:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEWrh-0004sk-IA; Tue, 04 Jun 2024 12:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEWrY-0004r5-3Z
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sEWrW-00011Q-0y
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 12:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717517890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=O4ym7cKHkoDUTOBI0TvbnBN/bOVlZEPR+xZtHwjnfeA=;
 b=aZK/GZmBQkDyIWxnTkyi7dHHwNQsZ5yrYuoAk/mOnW4HWo3Dx2PIHAOEqpSwsNq4b3rRKs
 dBEeZmRzLrCuTMTiBZ7UUX39c8VistD0KjAydJHN5/e2NxBIvT8DmwvmifXPk304pjDEFp
 EAkUxJzMTnGWjhbRyHEfg2ckF67RYtc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-xHsR9Y63NLed0cZMRZjrfw-1; Tue,
 04 Jun 2024 12:18:09 -0400
X-MC-Unique: xHsR9Y63NLed0cZMRZjrfw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0FB31918DC6; Tue,  4 Jun 2024 16:18:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.193.234])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FE261956053; Tue,  4 Jun 2024 16:18:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org
Subject: [PATCH] scsi-disk: Don't silently truncate serial number
Date: Tue,  4 Jun 2024 18:17:55 +0200
Message-ID: <20240604161755.63448-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Before this commit, scsi-disk accepts a string of arbitrary length for
its "serial" property. However, the value visible on the guest is
actually truncated to 36 characters. This limitation doesn't come from
the SCSI specification, it is an arbitrary limit that was initially
picked as 20 and later bumped to 36 by commit 48b62063.

Similarly, device_id was introduced as a copy of the serial number,
limited to 20 characters, but commit 48b62063 forgot to actually bump
it.

As long as we silently truncate the given string, extending the limit is
actually not a harmless change, but break the guest ABI. This is the
most important reason why commit 48b62063 was really wrong (and it's
also why we can't change device_id to be in sync with the serial number
again and use 36 characters now, it would be another guest ABI
breakage).

In order to avoid future breakage, don't silently truncate the serial
number string any more, but just error out if it would be truncated.

Buglink: https://issues.redhat.com/browse/RHEL-3542
Suggested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/scsi/scsi-disk.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..5f55ae54e4 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -58,6 +58,9 @@
 
 #define TYPE_SCSI_DISK_BASE         "scsi-disk-base"
 
+#define MAX_SERIAL_LEN              36
+#define MAX_SERIAL_LEN_FOR_DEVID    20
+
 OBJECT_DECLARE_TYPE(SCSIDiskState, SCSIDiskClass, SCSI_DISK_BASE)
 
 struct SCSIDiskClass {
@@ -648,8 +651,8 @@ static int scsi_disk_emulate_vpd_page(SCSIRequest *req, uint8_t *outbuf)
         }
 
         l = strlen(s->serial);
-        if (l > 36) {
-            l = 36;
+        if (l > MAX_SERIAL_LEN) {
+            l = MAX_SERIAL_LEN;
         }
 
         trace_scsi_disk_emulate_vpd_page_80(req->cmd.xfer);
@@ -2501,9 +2504,20 @@ static void scsi_realize(SCSIDevice *dev, Error **errp)
     if (!s->vendor) {
         s->vendor = g_strdup("QEMU");
     }
+    if (s->serial && strlen(s->serial) > MAX_SERIAL_LEN) {
+        error_setg(errp, "The serial number can't be longer than %d characters",
+                   MAX_SERIAL_LEN);
+        return;
+    }
     if (!s->device_id) {
         if (s->serial) {
-            s->device_id = g_strdup_printf("%.20s", s->serial);
+            if (strlen(s->serial) > MAX_SERIAL_LEN_FOR_DEVID) {
+                error_setg(errp, "The serial number can't be longer than %d "
+                           "characters when it is also used as the default for "
+                           "device_id", MAX_SERIAL_LEN_FOR_DEVID);
+                return;
+            }
+            s->device_id = g_strdup(s->serial);
         } else {
             const char *str = blk_name(s->qdev.conf.blk);
             if (str && *str) {
-- 
2.45.1


