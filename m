Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86356C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNI-0008OX-MT; Tue, 11 Aug 2026 12:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMt-0007pt-Nl
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMl-0000T5-NO
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2W+r9PJ3k5tM53YBGI0ZX0z6qHZTYSfbcrwc8qKpBA=;
 b=WHAYtlNdaUcgq82Ax30vo3giCKuymgdrRBoi1HBsIlLsarsS5ESC/0TopEsxiYElOaPrP0
 0Y8i9GvevI9hMfmMJUq0xEulNICK+YE05sWq0VlK1J9TFkjjhSfNgfFC3xFcYvYKop5tKP
 1haJsUo+no21/p8FO0VPETDD/3g6Avo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-uaCUFYudPyGE91nTg36jsQ-1; Tue,
 11 Aug 2026 12:30:13 -0400
X-MC-Unique: uaCUFYudPyGE91nTg36jsQ-1
X-Mimecast-MFC-AGG-ID: uaCUFYudPyGE91nTg36jsQ_1786465812
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 302C91954B07; Tue, 11 Aug 2026 16:30:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5EA88195DF91; Tue, 11 Aug 2026 16:30:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/83] tests/functional/aarch64/test_aspeed_ast2700: Add USB
 EHCI test for AST2700 A1/A2
Date: Tue, 11 Aug 2026 18:28:28 +0200
Message-ID: <20260811162938.1403216-14-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add a functional test to verify USB EHCI support on the AST2700 A2/A1
by attaching a USB keyboard device and checking its
enumeration via lsusb.

This introduces a helper routine that runs lsusb in the guest
and validates that the emulated "QEMU USB Keyboard" is detected.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/aarch64/test_aspeed_ast2700a1.py | 7 +++++++
 tests/functional/aarch64/test_aspeed_ast2700a2.py | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/functional/aarch64/test_aspeed_ast2700a1.py b/tests/functional/aarch64/test_aspeed_ast2700a1.py
index ddddd2d47a95..adbbef5cf11e 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a1.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a1.py
@@ -118,6 +118,11 @@ def do_ast2700_pcie_test(self):
             'ip addr show dev eth2',
             'inet 10.0.2.15/24')
 
+    def do_ast2700_usb_ehci_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lsusb',
+            'QEMU QEMU USB Keyboard')
+
     def start_ast2700_test(self, name, bus_id):
         num_cpu = 4
         load_images_list = [
@@ -161,10 +166,12 @@ def test_aarch64_ast2700a1_evb_sdk_v11_01(self):
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A1)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
+        self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
         self.start_ast2700_test('ast2700-a1-image', 1)
         self.verify_openbmc_boot_and_login('ast2700-a1')
         self.do_ast2700_i2c_test(1)
         self.do_ast2700_pcie_test()
+        self.do_ast2700_usb_ehci_test()
 
     def test_aarch64_ast2700a1_evb_sdk_vbootrom_v11_01(self):
         self.set_machine('ast2700a1-evb')
diff --git a/tests/functional/aarch64/test_aspeed_ast2700a2.py b/tests/functional/aarch64/test_aspeed_ast2700a2.py
index 0fe04a6eca7f..5f9073c89754 100755
--- a/tests/functional/aarch64/test_aspeed_ast2700a2.py
+++ b/tests/functional/aarch64/test_aspeed_ast2700a2.py
@@ -121,6 +121,11 @@ def do_ast2700_pcie_test(self):
             'ip addr show dev eth2',
             'inet 10.0.2.15/24')
 
+    def do_ast2700_usb_ehci_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lsusb',
+            'QEMU QEMU USB Keyboard')
+
     def start_ast2700_test(self, name, bus_id):
         num_cpu = 4
         load_images_list = [
@@ -164,10 +169,12 @@ def test_aarch64_ast2700a2_evb_sdk_v11_01(self):
         self.archive_extract(self.ASSET_SDK_V1101_AST2700A2)
         self.vm.add_args('-device', 'e1000e,netdev=net1,bus=pcie.2')
         self.vm.add_args('-netdev', 'user,id=net1')
+        self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.3')
         self.start_ast2700_test('ast2700-default-image', 1)
         self.verify_openbmc_boot_and_login('ast2700-default')
         self.do_ast2700_i2c_test(1)
         self.do_ast2700_pcie_test()
+        self.do_ast2700_usb_ehci_test()
 
     def test_aarch64_ast2700a2_evb_sdk_vbootrom_v11_01(self):
         self.set_machine('ast2700a2-evb')
-- 
2.55.0


