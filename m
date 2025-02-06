Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF957C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg09g-0000de-LK; Thu, 06 Feb 2025 06:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09X-0008Rd-O1
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:41 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg09V-0000uB-Es
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:34:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso5212515e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738841674; x=1739446474; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yAMhBvq7A2sY4fwGEsHhx6BSBdhRyxbY21rGxZGSxvM=;
 b=ocTCYsG5vIN9FnMvPVEsJbgcjqie4rPjWP2D2lCxcB8PTy/46XRR188mOnKpGG6cTE
 3D6jMePsh/4bezIQHCUyRLKv3a9ycXofNDZGaOOxmnQyfScDORsHE7+T7JZzrSLJjG3/
 7dWsQVfC276iTEFK0tTy+sxor8GhttXL149569XhxwL4E9SrUhUpn69k9rdWq+5T2+6g
 4tgjpnM0g/yBt1+nVC0c3IPHOX+mF1NMceoW+Wxnpzr5rFZyKjgOiTyY6CUnmGlfh8S7
 FCQF/pKa3LRPxuWSzqealzRX1+cB4Y/uMhozBpUcY5IC/2lKygST2II+W/5DlBZB0Urc
 2BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738841674; x=1739446474;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAMhBvq7A2sY4fwGEsHhx6BSBdhRyxbY21rGxZGSxvM=;
 b=BSxz9Tzrdp4zIOhBDnyDkfSYduTgtoBJYN5fKpDswXa4+NKOblOFmi7FcO0KpO++wL
 5Vio9MDhIUk3NL5NaauKjis2tToxvYXMkxMe1NKJRCmZqBDzXWhVJFZWGaeQMCiP/pWJ
 E+iTPbEjuXRsUa+5fKFTnLJlE+YujIKBTeVvzFS0NpNzo2HlF1rLGr8ZXMzIAWL/dJ3C
 gD0K5T2R9c1KV6/0aAYNl0p7YClh8yaDRaAKpK1N4Y0GS51n1Y/4l4exGzpXclEXOJKG
 feiylXmVyvbV8xxAyIfccI5+IdUrJKSedM4jMcbYdqcJ2ANcaXGK/2a+rsFjmW2vtEJl
 44sg==
X-Gm-Message-State: AOJu0YxFrj0Lv+TqfT1WPC5f6+XYozz+irL7WdYnIeHodU5FUKpCBOkN
 wPaiWHfJjTvnNBUnKZ6xXr+H42MwED0yFQ7hqj+AAfX/l2UNTWprjm0SvRO2DvIeSvm7Mtz5hNp
 MYu0=
X-Gm-Gg: ASbGncuZxDKI9U+DOKGUCEv/aezBLvb4TNyvzC9F3WcFhs/dyvE7W3bP5w39G7QVRDu
 wNfIEAjtnFosRgu64RXfM5YoO29rYH6llOKQL2vq0pmkA6svwYIH/tSL2x+gWCZbTMERzfMqo0+
 knWiW6l2YOrU6lIpke6AiSY+QopMAxyyow9EYPSQdAP+oBdV+BTHmxtlHMnDr6yrNn2z5YcuKYq
 hYY1Iek3ZCGxFGoWK5A0Zm7bDGm8ij/biypY9rtHzANJbAJwLBrSfU7XXMOjeMFT8xYDFYLJPTh
 SFXkd7x2o55LzftjbgiiJAgnyxlpJ5W9AZWvNWUfh6j+PPf4VMO43lqYoc3o9BHiYA==
X-Google-Smtp-Source: AGHT+IEfGvV2b1BPGx53WX/PLS5iBl0xNOj9vyBurztjteOF2A9+qzHUiIYnL3G/zvkmUW40W+h2IQ==
X-Received: by 2002:a05:600c:1c14:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-4390d43d8e1mr62990335e9.14.1738841674368; 
 Thu, 06 Feb 2025 03:34:34 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391dfd8047sm16124075e9.33.2025.02.06.03.34.33
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Feb 2025 03:34:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 15/16] tests/functional: Move microblaze tests to common
 parent class
Date: Thu,  6 Feb 2025 12:33:20 +0100
Message-ID: <20250206113321.94906-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206113321.94906-1-philmd@linaro.org>
References: <20250206113321.94906-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Move the xmaton and ballerina tests to the parent class.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 .../functional/test_microblaze_s3adsp1800.py  | 27 +++++++++++++++++--
 .../test_microblazeel_s3adsp1800.py           | 26 +-----------------
 2 files changed, 26 insertions(+), 27 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index 2eff31f13a7..0447097c048 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,6 +7,8 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+import time
+from qemu_test import exec_command, exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -15,13 +17,15 @@ class MicroblazeMachine(QemuSystemTest):
 
     timeout = 90
 
-class MicroblazeBigEndianMachine(MicroblazeMachine):
-
     ASSET_IMAGE_BE = Asset(
         ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
+    ASSET_IMAGE_LE = Asset(
+        ('http://www.qemu-advent-calendar.org/2023/download/day13.tar.gz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
     def do_ballerina_be_test(self, machine):
         self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
@@ -36,6 +40,25 @@ def do_ballerina_be_test(self, machine):
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
+        time.sleep(0.1)
+        exec_command(self, 'root')
+        time.sleep(0.1)
+        exec_command_and_wait_for_pattern(self,
+                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
+                '821cd3cab8efd16ad6ee5acc3642a8ea')
+
+class MicroblazeBigEndianMachine(MicroblazeMachine):
+
     def test_microblaze_s3adsp1800_legacy_be(self):
         self.do_ballerina_be_test('petalogix-s3adsp1800')
 
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/test_microblazeel_s3adsp1800.py
index a3e8d7ca48e..56645bd0bb2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,36 +7,12 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-import time
-from qemu_test import exec_command, exec_command_and_wait_for_pattern
-from qemu_test import QemuSystemTest, Asset
-from qemu_test import wait_for_console_pattern
+from qemu_test import QemuSystemTest
 
 from test_microblaze_s3adsp1800 import MicroblazeMachine
 
 class MicroblazeLittleEndianMachine(MicroblazeMachine):
 
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
-        time.sleep(0.1)
-        exec_command(self, 'root')
-        time.sleep(0.1)
-        exec_command_and_wait_for_pattern(self,
-                'tftp -g -r xmaton.png 10.0.2.2 ; md5sum xmaton.png',
-                '821cd3cab8efd16ad6ee5acc3642a8ea')
-
     def test_microblaze_s3adsp1800_legacy_le(self):
         self.do_xmaton_le_test('petalogix-s3adsp1800')
 
-- 
2.47.1


