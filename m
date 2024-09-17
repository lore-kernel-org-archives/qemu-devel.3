Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEE65C3600C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVYs-0001dS-KY; Tue, 17 Sep 2024 06:35:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYp-0001Kt-DM
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYn-0007G8-Ey
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZcfVKoeae24MG5eyTk1wCTBA/OGBxqokEt5gUe0kV28=;
 b=Td08Al6dtzeDH60a1wxBOH7TWNrVa8cKplBC8tjKJRITYIgE3gyU4++ivd42CrApUrNxv6
 AWao4zxZLH2WyTLE/PYNr0A7J/bpdUfnJjU0ldv4P75kEgacdNjDXYcwCx35cqXFUCAdYR
 ytrdAIdZX4U95uoHzhHpdLiZQr/x7aE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128-Dip0trEUNOKbiSB-qgMovw-1; Tue,
 17 Sep 2024 06:35:51 -0400
X-MC-Unique: Dip0trEUNOKbiSB-qgMovw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1AA41956089; Tue, 17 Sep 2024 10:35:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 30A6019560A3; Tue, 17 Sep 2024 10:35:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/17] tests/qtest/hd-geo-test: Check for availability of "pc"
 machine before using it
Date: Tue, 17 Sep 2024 12:35:26 +0200
Message-ID: <20240917103540.149144-4-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

In case QEMU has been configured with "--without-default-devices", the
"pc" machine type might be missing in the binary. We should check for
its availability before using it.

Message-ID: <20240905191434.694440-5-thuth@redhat.com>
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


