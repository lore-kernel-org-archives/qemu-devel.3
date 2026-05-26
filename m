Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0079ECD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:23:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0H-0005DX-8v; Tue, 26 May 2026 04:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0F-0005CH-F5
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0C-0007XN-KS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AOIh9+j8SX6nATu4YMNyspTFt1ElE2GFmG4S309qu7k=;
 b=VY60ex7fPHgNWnAuv9oV18E1n1WcTxlL26wC1+ICE15+/AsOKIOqfLYqI01fHw0Mqzs8fp
 IEf+zgcqsgw9rMtsw8H8TQ1K4aDZYKNSWLy7wXPOQ5DrmDgGLqcLQI5KrATWrShdfVZNdu
 5yf0B7VI7ycs4zMd7IoHYHv9w4mmbEk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-X4TZW7T1PGCrKJEV5tpyug-1; Tue,
 26 May 2026 04:19:00 -0400
X-MC-Unique: X4TZW7T1PGCrKJEV5tpyug-1
X-Mimecast-MFC-AGG-ID: X4TZW7T1PGCrKJEV5tpyug_1779783537
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59B091956094; Tue, 26 May 2026 08:18:57 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A580180056E; Tue, 26 May 2026 08:18:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 02/37] tests/functional/arm/test_aspeed_ast2600_sdk: Add USB
 EHCI test for AST2600 SDK
Date: Tue, 26 May 2026 10:18:13 +0200
Message-ID: <20260526081848.651835-3-clg@redhat.com>
In-Reply-To: <20260526081848.651835-1-clg@redhat.com>
References: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add a functional test to verify USB EHCI support on the AST2600
SDK machine by attaching a USB keyboard device and checking its
enumeration via lsusb.

This introduces a helper routine that runs lsusb in the guest
and validates that the emulated "QEMU USB Keyboard" is detected.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260504025342.1452605-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/arm/test_aspeed_ast2600_sdk.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/functional/arm/test_aspeed_ast2600_sdk.py b/tests/functional/arm/test_aspeed_ast2600_sdk.py
index d787e90d1024..01548dd1354d 100755
--- a/tests/functional/arm/test_aspeed_ast2600_sdk.py
+++ b/tests/functional/arm/test_aspeed_ast2600_sdk.py
@@ -40,6 +40,11 @@ def do_ast2600_i3c_test(self):
             'i3ctransfer -d /dev/bus/i3c/5-1234567890ab -r 8 | grep 0x | xargs',
             '0x12 0x34 0x56 0x78 0x90 0xab 0xcd 0xef')
 
+    def do_ast2600_usb_ehci_test(self):
+        exec_command_and_wait_for_pattern(self,
+            'lsusb',
+            'QEMU QEMU USB Keyboard')
+
     def test_arm_ast2600_evb_sdk(self):
         self.set_machine('ast2600-evb')
         self.require_netdev('user')
@@ -54,6 +59,7 @@ def test_arm_ast2600_evb_sdk(self):
         self.vm.add_args('-netdev', 'user,id=net1')
         self.vm.add_args('-device',
             'mock-i3c-target,bus=dw.i3c.5,pid=0xab9078563412')
+        self.vm.add_args('-device', 'usb-kbd,bus=usb-bus.1')
         self.do_test_arm_aspeed_sdk_start(
             self.scratch_file("ast2600-default-image", "image-bmc"))
 
@@ -81,6 +87,7 @@ def test_arm_ast2600_evb_sdk(self):
              '/sbin/hwclock -f /dev/rtc1', year)
         self.do_ast2600_pcie_test()
         self.do_ast2600_i3c_test()
+        self.do_ast2600_usb_ehci_test()
 
 
 if __name__ == '__main__':
-- 
2.54.0


