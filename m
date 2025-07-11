Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B16C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 02:05:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua37Q-0004Ru-L1; Thu, 10 Jul 2025 22:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua379-0004PM-Aj
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:57 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ua370-0001yS-Up
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 22:03:50 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4a77ea7ed49so32301571cf.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 19:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752199421; x=1752804221; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MiPWa9uaGLjoes/vVDyCJJ6uwyxHojbLGx3x8hpB+zg=;
 b=Bi5gQQuadYw6kXoX9saJmrOl0ikl4Op4Dg7Dm7/Da3q60GMjeaTwszhNYH83vLQHAF
 6Qpy77KAaqGe9i6GS8c9lIt73htPcOCGUxNsXrmWyaOK4f+g1cTi1G1Xa1mNvUkhc8Me
 xWjn6c8HZjFtc9p/2SxSzdy/SQxSwlMLkACOtpXGCCMnHzyPACEq4/oQILZSMWgK49bU
 +FxYFvuopQyYaxgmcnPicWwHVSrttdHxe5fd4oksyJqSv4NqbkxOs3e49KyYocNkZ2Vm
 CvI9ERHvNPm7Q4BbRWXIVssVFkbOK92FMQpybnn+iklXUEuFF5T31IIkdkMww3ZDqtDa
 ueIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752199421; x=1752804221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MiPWa9uaGLjoes/vVDyCJJ6uwyxHojbLGx3x8hpB+zg=;
 b=Nj68LcIzamzb8vosBlGIeDuqXws2u5MQZ+YwPYWncwoD3N7toahL5x8slu1ByIiB2f
 aQE4LGD/5Q81xb/TRcseyamgEZ4YWl8dfpJMIFe7OrFLKqbS/rFtkIwPTMRvmIGgOmh8
 UmLAwhJLVcx452Nyd2h0ILwkSfb0n+CglXUAHrB0BuCxx4j896kHARzQL85EMZDmIu4l
 AGp3R8FchCopzdWnVOf6HpjoJ52vHPN2qZ09L0ypqwBZNAvLx4UyTidFcxoXGaPWccgG
 TxjXt1JLNaVqg7ezuuSb4SCokjOYJn8UPN4lgJoI0G+iW6ekp0g6Z/J/l5rvuX0DfC+4
 Rf5Q==
X-Gm-Message-State: AOJu0Yz2dedrJmmcn240wHKlb+KrteTqtNumX6ht7yvvcRyXmnSuwtXf
 GO6h23an+PknAG0RN301T3j7BvRAdm31xDZ1NS+YkcXBfPFU7IlKQV91zit0rg==
X-Gm-Gg: ASbGnctAU1EB2ww1uYuuVCPDQk8Z6I2xFHCqq8Xl/IuisFqo+npqGGyKO5Dc10yv8+s
 VqZ8Dnkr5DiHtFDOPQu1pW7Vn0gN8KTYfynVN140jw9gqKEuur8NbHGGngDCOeb3T+qg5hgk5sM
 kMtJ9qI/EZ0pZtdjLduXyW1gziZXfKsmryx5k6GW48dJf3qjy2pxidp4nvO9jvLYc5yjqbujdYf
 TLOrKzOystHiGTNqkgqPXOtWGaT1nOl55A5ii2TyzFFV1Dm23ay+Bmo2YVFNQg0YrINgI+8c4gb
 ttFOF54c8TuqBVlI/VSuTV2TA1Yy8q9LWEiyKALioKHuWzt7re2Kj6+Fu+HepMILfdlxeRqmJs/
 hqA0jsWS6JBobZrAlX87f9SbO/FZpw0xnsHTwUMD4SB0MKv0=
X-Google-Smtp-Source: AGHT+IH3leWE0/lrL+9u66JjmJykJIcwoKXHj7RZGNjmbyESkkwclTAxlr8XtMm26unRExhe27xT6A==
X-Received: by 2002:a05:622a:8c08:b0:4aa:cba2:2e5a with SMTP id
 d75a77b69052e-4aacba232d0mr7234841cf.26.1752199421150; 
 Thu, 10 Jul 2025 19:03:41 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51f:a700:7eb2:b315:2597:18f1])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a9ede76d41sm16125761cf.48.2025.07.10.19.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jul 2025 19:03:40 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH 2/2] tests/functional: Add a test for the MAX78000 arm machine
Date: Thu, 10 Jul 2025 22:03:38 -0400
Message-Id: <20250711020338.586222-3-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250711020338.586222-1-jcksn@duck.com>
References: <20250711020338.586222-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=jackson88044@gmail.com; helo=mail-qt1-x831.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Runs a binary from the max78000test repo used in
developing the qemu implementation of the max78000
to verify that the machine and implemented devices
generally still work.

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 tests/functional/meson.build              |  1 +
 tests/functional/test_arm_max78000fthr.py | 48 +++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100755 tests/functional/test_arm_max78000fthr.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index e9f19d54a2..f837c6ddb1 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -131,6 +131,7 @@ tests_arm_system_thorough = [
   'arm_cubieboard',
   'arm_emcraft_sf2',
   'arm_integratorcp',
+  'arm_max78000fthr',
   'arm_microbit',
   'arm_orangepi',
   'arm_quanta_gsj',
diff --git a/tests/functional/test_arm_max78000fthr.py b/tests/functional/test_arm_max78000fthr.py
new file mode 100755
index 0000000000..a82980b0f7
--- /dev/null
+++ b/tests/functional/test_arm_max78000fthr.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+#
+# Functional test that checks the max78000fthr machine.
+# Tests ICC, GCR, TRNG, AES, and UART
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, exec_command_and_wait_for_pattern
+from qemu_test import wait_for_console_pattern
+
+
+class Max78000Machine(QemuSystemTest):
+
+    ASSET_FW = Asset(
+        'https://github.com/JacksonDonaldson/max78000Test/raw/main/build/max78000.bin',
+        '86940b4bf60931bc6a8aa5db4b9f7f3cf8f64dbbd7ac534647980e536cf3adf7')
+
+    def test_fthr(self):
+        self.set_machine('max78000fthr')
+        fw_path = self.ASSET_FW.fetch()
+        self.vm.set_console()
+        self.vm.add_args('-kernel', fw_path)
+        self.vm.add_args('-device', "loader,file=" + fw_path + ",addr=0x10000000")
+        self.vm.launch()
+
+        wait_for_console_pattern(self, 'started')
+
+        # i -> prints instruction cache values
+        exec_command_and_wait_for_pattern(self, 'i', 'CTRL: 00010001')
+
+        # r -> gcr resets the machine
+        exec_command_and_wait_for_pattern(self, 'r', 'started')
+
+        # z -> sets some memory, then has gcr zero it
+        exec_command_and_wait_for_pattern(self, 'z', 'initial value: 12345678')
+        wait_for_console_pattern(self, "after memz: 00000000")
+
+        # t -> runs trng
+        exec_command_and_wait_for_pattern(self, 't', 'random data:')
+
+        # a -> runs aes
+        exec_command_and_wait_for_pattern(self, 'a',
+                'encrypted to : a47ca9dd e0df4c86 a070af6e 91710dec')
+        wait_for_console_pattern(self,
+                'encrypted to : cab7a28e bf456751 9049fcea 8960494b')
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.34.1


