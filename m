Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC9C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:39:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiC11-0004kt-Fc; Wed, 12 Feb 2025 07:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiC0D-0003v6-Hn
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:38:05 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiC0A-0000ip-O0
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:38:05 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38dd14c99c3so2530230f8f.3
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 04:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739363870; x=1739968670; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b9KWIiGOWq55nxx0C4B7NMOGhhvAoCPOGFcu0xxlyb8=;
 b=Zacuj7DS+BGVYQG9fnH5CQ2ChWJV1w2TcxjsKri85l9gUhxtORdcc7bm3UUGl1fUYp
 oZlNqMMwI64Uv20u78VPSZ0Mv8g7qyfbYc2CCJdzJ/GisugZcX0k/Vjd/I+uhFoBM5j7
 JgN5rlefydXqmX22r6saDKd5ysyNO3maD76AYL/B4OWzboxNDHwKJtthiq6nD9mt+Pe+
 90mYgVK4awdOv2yaWGt8hhTi9Smo8jbiAVyNHndePI4XCMFi02ZVWVcIJUaQMzs2mxLD
 Tz+hHZJy9Es4X5kOfH4eNntSjj9aBCmJ+b85HTKiKD4+iFbCG9lkIDWtb98h9g/jRjrA
 6Icw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739363870; x=1739968670;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b9KWIiGOWq55nxx0C4B7NMOGhhvAoCPOGFcu0xxlyb8=;
 b=Fqjll/T12ItbjBu/vV3Rh5LY9sp6BNOVf6Jb/erioCC4CCTu4jvjWrJPz8xXcEF0Ne
 +Ww+ZAXvsOPrAsI4imNfVCb+Uy72xscL90CYt4pG3C5A10BkejO2x28dH+uyC6qRbYld
 PX4SL0gOUudHCiEJfEtrzxDY6qBvGVqAmmm6PuwP3EBieiNyBBTdTJckYxPX8pfcWgP6
 Bhfm+OzBLm2L9/enCzoe9k5GpKWKGr14cSrvy3ymsdmtm6jKSyOlLKpAeGqq4twYuqGX
 p2NQOPv93LZAoDjpvgeMyTi7zwTNt2/d9HOUk/PExxnrDG04iswSk4Dv2bbjK+WNwsSI
 LvhA==
X-Gm-Message-State: AOJu0YyearC+VzeTNpxLGIEuCTxJ08sIX15vtM0XNA5DVa1JiOyD4r/m
 HUqxkxxy14LCLPY+jEYfWg8qLKUd7lE5VVp+VPPyRTME2M6PLYxFDRI3Tmq20+KabONl3Dm/7dw
 jZCI=
X-Gm-Gg: ASbGncvxU6x6kChKQ5nspuD4K2c59eTss19KLcffnzSmGVa30Frmjd6nE3GDMq9LJ50
 4/1vTFQDmbXvjLQ6X2JPovdTfW0jvMg6Dcm2cF3ExzMDRs8012aFTnENlZvOmez8W1Il0g1TUSd
 dqo+ewqq3YF8OKQf8TDpMNBO7JL0NSsFRMb74uVF754wo/5NlejzbqNVrV5nlhFUO/HoGvGN04b
 UgDQICuFtQOX9pKo3bqOug/4OTb70284IX46JyVsU8Tj44a2zCjzztSdAeV8KtV9Kg2gwB3JdTs
 b0XL80urdRvhrb7hgUgyyPMn8nEZOc/fcC6bEVLqyAX3GZrJsUyJLqnUD/B+eUOvKA==
X-Google-Smtp-Source: AGHT+IHKFQM86ErbvsoTtLf/SkXAcCX6piqEd4Bb4oLxXkbbDx+MOOYJ64vk34Rv9CuFO3FbaGyqaw==
X-Received: by 2002:a5d:64cf:0:b0:38d:b57e:7202 with SMTP id
 ffacd0b85a97d-38dea28d854mr2723465f8f.31.1739363870257; 
 Wed, 12 Feb 2025 04:37:50 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f221c4145sm322697f8f.85.2025.02.12.04.37.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 04:37:49 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7 10/10] tests/functional: Have microblaze tests inherit
 common parent class
Date: Wed, 12 Feb 2025 13:36:59 +0100
Message-ID: <20250212123659.52764-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212123659.52764-1-philmd@linaro.org>
References: <20250212123659.52764-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Have the MicroblazeMachine class being common to both
MicroblazeBigEndianMachine and MicroblazeLittleEndianMachine
classes. Move the xmaton and ballerina tests to the parent class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250206131052.30207-16-philmd@linaro.org>
---
 .../functional/test_microblaze_s3adsp1800.py  | 23 +++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 29 ++-----------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c4226f49cf3..177c8a685bc 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,6 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -20,6 +21,10 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
     def do_ballerina_be_test(self, machine):
         self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
@@ -34,6 +39,24 @@ def do_ballerina_be_test(self, machine):
         # message, that's why we don't test for a later string here. This
         # needs some investigation by a microblaze wizard one day...
 
+    def do_xmaton_le_test(self, machine):
+        self.require_netdev('user')
+        self.set_machine(machine)
+        self.archive_extract(self.ASSET_IMAGE_LE)
+        self.vm.set_console()
+        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
+        tftproot = self.scratch_file('day13')
+        self.vm.add_args('-nic', f'user,tftp={tftproot}')
+        self.vm.launch()
+        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
+        wait_for_console_pattern(self, 'buildroot login:')
+        exec_command_and_wait_for_pattern(self, 'root', '#')
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
+class MicroblazeBigEndianMachine(MicroblazeMachine):
+
     def test_microblaze_s3adsp1800_legacy_be(self):
         self.do_ballerina_be_test('petalogix-s3adsp1800')
 
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index 60aab4a45e8..56645bd0bb2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,34 +7,11 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from qemu_test import exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest
 
+from test_microblaze_s3adsp1800 import MicroblazeMachine
 
-class MicroblazeelMachine(QemuSystemTest):
-
-    timeout = 90
-
-    ASSET_IMAGE_LE = Asset(
-        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
-        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
-
-    def do_xmaton_le_test(self, machine):
-        self.require_netdev('user')
-        self.set_machine(machine)
-        self.archive_extract(self.ASSET_IMAGE_LE)
-        self.vm.set_console()
-        self.vm.add_args('-kernel', self.scratch_file('day13', 'xmaton.bin'))
-        tftproot = self.scratch_file('day13')
-        self.vm.add_args('-nic', f'user,tftp={tftproot}')
-        self.vm.launch()
-        wait_for_console_pattern(self, 'QEMU Advent Calendar 2023')
-        wait_for_console_pattern(self, 'buildroot login:')
-        exec_command_and_wait_for_pattern(self, 'root', '#')
-        exec_command_and_wait_for_pattern(self,
-                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
-                '821cd3cab8efd16ad6ee5acc3642a8ea')
+class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
     def test_microblaze_s3adsp1800_legacy_le(self):
         self.do_xmaton_le_test('petalogix-s3adsp1800')
-- 
2.47.1


