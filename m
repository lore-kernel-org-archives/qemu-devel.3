Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 550DFC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:49:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEyC-000451-Mf; Wed, 26 Feb 2025 05:48:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEy6-00044K-OT
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:48:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tnEy4-0005y3-6j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740566922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Bv4KGNzaRNdltTomx4xPiNEFg+nRE++rpyehasEsyDM=;
 b=FmEtRFzFAJ+43jD/FBbf8dCUqByl+HXrpOKC7YtdU0kgNEYHB2JXJZAq1UBtmvq7GX2A87
 xYnTlRMPK3EuyNkwjaBnZEvm/wFASP+9kGw5K+U1QEu4Av751J9l4O4/PuVYz9k9a+HZ3K
 9WkVVytjsz2C8leQfxevehyOhWhBJCc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-_VdysMRKP_CUQIqdeo3XpQ-1; Wed,
 26 Feb 2025 05:48:37 -0500
X-MC-Unique: _VdysMRKP_CUQIqdeo3XpQ-1
X-Mimecast-MFC-AGG-ID: _VdysMRKP_CUQIqdeo3XpQ_1740566916
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65C54193578F; Wed, 26 Feb 2025 10:48:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.144])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E516E1800359; Wed, 26 Feb 2025 10:48:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Subject: [PATCH] tests/functional/test_arm_sx1: Check whether the serial
 console is working
Date: Wed, 26 Feb 2025 11:48:33 +0100
Message-ID: <20250226104833.1176253-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The kernel that is used in the sx1 test prints the usual Linux log
onto the serial console, but this test currently ignores it. To
make sure that the serial device is working properly, let's check
for some strings in the output here.

While we're at it, also add the test to the corresponding section
in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Based-on: <20250221140640.786341-1-peter.maydell@linaro.org>

 MAINTAINERS                      | 1 +
 tests/functional/test_arm_sx1.py | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 05ec99adfd0..098daea6f24 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2000,6 +2000,7 @@ S: Maintained
 F: hw/*/omap*
 F: include/hw/arm/omap.h
 F: docs/system/arm/sx1.rst
+F: tests/functional/test_arm_sx1.py
 
 IPack
 M: Alberto Garcia <berto@igalia.com>
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index 4dd1e1859fa..25800b388c9 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -43,7 +43,8 @@ def test_arm_sx1_initrd(self):
         self.vm.add_args('-append', f'kunit.enable=0 rdinit=/sbin/init {self.CONSOLE_ARGS}')
         self.vm.add_args('-no-reboot')
         self.launch_kernel(zimage_path,
-                           initrd=initrd_path)
+                           initrd=initrd_path,
+                           wait_for='Boot successful')
         self.vm.wait(timeout=120)
 
     def test_arm_sx1_sd(self):
@@ -54,7 +55,7 @@ def test_arm_sx1_sd(self):
         self.vm.add_args('-no-reboot')
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
-        self.launch_kernel(zimage_path)
+        self.launch_kernel(zimage_path, wait_for='Boot successful')
         self.vm.wait(timeout=120)
 
     def test_arm_sx1_flash(self):
@@ -65,7 +66,7 @@ def test_arm_sx1_flash(self):
         self.vm.add_args('-no-reboot')
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
-        self.launch_kernel(zimage_path)
+        self.launch_kernel(zimage_path, wait_for='Boot successful')
         self.vm.wait(timeout=120)
 
 if __name__ == '__main__':
-- 
2.48.1


