Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7623C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 11:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiAss-00084i-7N; Wed, 12 Feb 2025 06:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiArs-0006iU-Em
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:31 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiAri-0004q4-S7
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 06:25:17 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-38dc6d55ebaso467827f8f.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2025 03:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739359509; x=1739964309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDfJ2Ax294CnyEXRoPzMDNsGf/a2aySSWaKYSBHH7B0=;
 b=VYEq8Bp4Aa5JUD+YcySSvPLf/3ZvkD72Og4oD7cz/oyFYk8XgsEPl+VO6iKT3NK2xX
 W/tvQRXvTz20u88BUDQBJ21QGGlQijcpXvDAa11VpmnRQpBTO2hITXQNbevLCnSJyzQC
 u0ELq6YwOfEQOmu1fo0Y1guvFS3SM4QlG7EeANJs3Hz7ZorBf1Er6IFt97nMBNUtE3qo
 oG26VUZsKspWzMeLOJvAsftNKVFlqssQ7322mD1BghAC6bjxOOp2n3yT3xj6GSFibNtp
 YZaP58rxdub/F97nABEuEEjPZ8CWEGP9uOWYWV7KCGmhUe+MCkCWcLM9D4h2Pg2sDw90
 lVGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739359509; x=1739964309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dDfJ2Ax294CnyEXRoPzMDNsGf/a2aySSWaKYSBHH7B0=;
 b=KXnjA56cdRGKvDMnCgBIr54aswYZ/zZ3LaH6wCTI+kOdStRI4fzemQ5T96rXSnKeKU
 L2PG7yBuMJfhr+Bqtyyh+XslbeamJxAQSzZ6x6eWPXcc/9Tr9T63VDFYL5hFzy/aBrXw
 LDmyPAKgguY5Vgr4M5tEgpwE7oCUtq/K5s15ouuQboOjqORM4BXKKRQxbcdbv+9bEHN7
 JiO0FNEGGte9B0m96jQS7ckB5DFrwf7ZNum+nLUWc2470lh9cQbg7TDdB048WOik0qLB
 IIwOiLGMuXDrrDqiFXNQQ02cMiX50PBwS8PEOFTXHR0FEDkHYp8Gq89peVyElUGahXzS
 461Q==
X-Gm-Message-State: AOJu0YyBDYemX+9sjFdGfx09RMKIahvuq7bqJK4TgL/MjHkbDxfT2YOx
 XDbnErDzbwa9xuN2Y8LSdCdNW9WmMQbAmCYGpIIfQcYwa5uGQFIjbtCV0/kpfvaINbUmRYwgYqi
 5NsI=
X-Gm-Gg: ASbGncuVoh7YD+aWhjU1BNrT3YAJOPCHuWMyYI4ZK32FVgr8SDAL2Wod9r4OmPqrHkQ
 rrGyXwrqfEzA4aReRvNqzFjt9M0n6Qtyk3Ea06jP5QZ/x1rQq/hc61xMFBCNIBLlOXQr5Pdy3le
 4QSv/cIILZ4ncSonHPzGXSboPTjDe7JpicCBR1gnv8ncqz5WL4iS+t573I3oKtCAOY1wcCyEjAs
 k1MO4Xf6ylH+9Z8AIjjFOSqQ4RY31pQ25gMO/U0AVdLcnpaDsRC4fXipfukI3wiaUmRcKzcECDx
 uOf//FrZeAMD6G1uSFHcRhIGsSAHmXfe5DOdmyUzfQ/p5zaceCvdbNRXht+sPbZo2Q==
X-Google-Smtp-Source: AGHT+IFohKL4pHFVBESBD0es7sHCOakPMgtCPiehVbmj5s2aTzVdKWG2DBOUdS2zvgUCiKyvz02ESw==
X-Received: by 2002:a05:6000:178d:b0:38d:e363:494b with SMTP id
 ffacd0b85a97d-38de439d6d6mr5888296f8f.8.1739359508651; 
 Wed, 12 Feb 2025 03:25:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd4342502sm11629832f8f.26.2025.02.12.03.25.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 12 Feb 2025 03:25:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 11/11] tests/functional: Have microblaze tests inherit
 common parent class
Date: Wed, 12 Feb 2025 12:24:13 +0100
Message-ID: <20250212112413.37553-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250212112413.37553-1-philmd@linaro.org>
References: <20250212112413.37553-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
 .../functional/test_microblaze_s3adsp1800.py  | 24 +++++++++++++++
 .../test_microblazeel_s3adsp1800.py           | 30 ++-----------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/test_microblaze_s3adsp1800.py
index c4226f49cf3..650416e0c09 100755
--- a/tests/functional/test_microblaze_s3adsp1800.py
+++ b/tests/functional/test_microblaze_s3adsp1800.py
@@ -7,6 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
+from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import QemuSystemTest, Asset
 from qemu_test import wait_for_console_pattern
 
@@ -20,6 +21,11 @@ class MicroblazeMachine(QemuSystemTest):
          'day17.tar.xz'),
         '3ba7439dfbea7af4876662c97f8e1f0cdad9231fc166e4861d17042489270057')
 
+    ASSET_IMAGE_LE = Asset(
+        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
+         'day05.tar.xz'),
+        'b9b3d43c5dd79db88ada495cc6e0d1f591153fe41355e925d791fbf44de50c22')
+
     def do_ballerina_be_test(self, machine):
         self.set_machine(machine)
         self.archive_extract(self.ASSET_IMAGE_BE)
@@ -34,6 +40,24 @@ def do_ballerina_be_test(self, machine):
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
index d50b98342d7..56645bd0bb2 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/test_microblazeel_s3adsp1800.py
@@ -7,35 +7,11 @@
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
-        ('https://qemu-advcal.gitlab.io/qac-best-of-multiarch/download/'
-         'day05.tar.xz'),
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


