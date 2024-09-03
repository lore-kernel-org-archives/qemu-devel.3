Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36861CD343D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 14:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slUMN-0008GO-RH; Tue, 03 Sep 2024 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slUML-0008Fk-5n
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slUMH-0001KQ-Kt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 10:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725373092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=K28f85OF7zkU0H6qIirLcI0DpptYKyrPwwXV223w+tA=;
 b=KZ59kO5mMNc6fbEADXDx7tGtW0pDwdAaUxJJkvoD0hXNyt/IuVWseTEFCkaozhV+5IuBtl
 seW7QVKBCYQ3sxFqnUhIZupyXMZTn4JMFHSsPKc3F0mFYI8eRzGneHnjgZkosdc7MmJO7h
 AWQlMzCJhY3hzWiyJTY3xAp6k0jn3hg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-qwpU6bKFPnmtL7rp0fhzDw-1; Tue,
 03 Sep 2024 09:42:20 -0400
X-MC-Unique: qwpU6bKFPnmtL7rp0fhzDw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33B7F1954B14; Tue,  3 Sep 2024 13:42:19 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.86])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 46AC91956048; Tue,  3 Sep 2024 13:42:17 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
	Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH] tests/qtest/hd-geo-test: Check for availability of "pc"
 machine before using it
Date: Tue,  3 Sep 2024 15:42:15 +0200
Message-ID: <20240903134215.205014-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

In case QEMU has been configured with "--without-default-devices", the
"pc" machine type might be missing in the binary. We should check for
its availability before using it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/hd-geo-test.c | 71 +++++++++++++++++++++------------------
 1 file changed, 38 insertions(+), 33 deletions(-)

diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
index d08bffad91..85eb8d7668 100644
--- a/tests/qtest/hd-geo-test.c
+++ b/tests/qtest/hd-geo-test.c
@@ -1074,17 +1074,26 @@ int main(int argc, char **argv)
         }
     }
 
-    qtest_add_func("hd-geo/ide/none", test_ide_none);
-    qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
-    qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
-    qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
-    qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
-    qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
-    qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
-    qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
-    qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
-    qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
-    if (have_qemu_img()) {
+    if (qtest_has_machine("pc")) {
+        qtest_add_func("hd-geo/ide/none", test_ide_none);
+        qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
+        qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
+        qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
+        qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
+        qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
+        qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
+        qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
+        qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
+        qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
+    }
+
+    if (!have_qemu_img()) {
+        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
+                       "skipping hd-geo/override/* tests");
+        goto test_add_done;
+    }
+
+    if (qtest_has_machine("pc")) {
         qtest_add_func("hd-geo/override/ide", test_override_ide);
         if (qtest_has_device("lsi53c895a")) {
             qtest_add_func("hd-geo/override/scsi", test_override_scsi);
@@ -1104,30 +1113,26 @@ int main(int argc, char **argv)
             qtest_add_func("hd-geo/override/virtio_blk",
                            test_override_virtio_blk);
         }
+    }
 
-        if (qtest_has_machine("q35")) {
-            qtest_add_func("hd-geo/override/sata", test_override_sata);
-            qtest_add_func("hd-geo/override/zero_chs_q35",
-                           test_override_zero_chs_q35);
-            if (qtest_has_device("lsi53c895a")) {
-                qtest_add_func("hd-geo/override/scsi_q35",
-                               test_override_scsi_q35);
-            }
-            if (qtest_has_device("virtio-scsi-pci")) {
-                qtest_add_func("hd-geo/override/scsi_hot_unplug_q35",
-                               test_override_scsi_hot_unplug_q35);
-            }
-            if (qtest_has_device("virtio-blk-pci")) {
-                qtest_add_func("hd-geo/override/virtio_hot_unplug_q35",
-                               test_override_virtio_hot_unplug_q35);
-                qtest_add_func("hd-geo/override/virtio_blk_q35",
-                               test_override_virtio_blk_q35);
-            }
-
+    if (qtest_has_machine("q35")) {
+        qtest_add_func("hd-geo/override/sata", test_override_sata);
+        qtest_add_func("hd-geo/override/zero_chs_q35",
+                       test_override_zero_chs_q35);
+        if (qtest_has_device("lsi53c895a")) {
+            qtest_add_func("hd-geo/override/scsi_q35",
+                           test_override_scsi_q35);
+        }
+        if (qtest_has_device("virtio-scsi-pci")) {
+            qtest_add_func("hd-geo/override/scsi_hot_unplug_q35",
+                           test_override_scsi_hot_unplug_q35);
+        }
+        if (qtest_has_device("virtio-blk-pci")) {
+            qtest_add_func("hd-geo/override/virtio_hot_unplug_q35",
+                           test_override_virtio_hot_unplug_q35);
+            qtest_add_func("hd-geo/override/virtio_blk_q35",
+                           test_override_virtio_blk_q35);
         }
-    } else {
-        g_test_message("QTEST_QEMU_IMG not set or qemu-img missing; "
-                       "skipping hd-geo/override/* tests");
     }
 
 test_add_done:
-- 
2.46.0


