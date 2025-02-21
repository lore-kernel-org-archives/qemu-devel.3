Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA2C021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:07:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTg3-0004lM-8v; Fri, 21 Feb 2025 09:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlTg0-0004dc-0C
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:06:48 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tlTfx-0003ZR-KZ
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 09:06:47 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso21649245e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2025 06:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740146803; x=1740751603; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=otGMBD+B4/VET7RFn8bZmOFcmmLMoF/BIhvFgKTCsGs=;
 b=YhqaN6FTMmWrU4m1oV66ejG5GeVFPODtMwHYesVlEd1zoPelSjsqtsAOj0HPsrCYID
 SjmS0ovn1GFXSzV8f6XBNfj5WXE9vaAu/7yTB876FbZ0OcqYzK6Z4t89nXpAFNApLEZf
 uGubA4eaIT1TAi7bPCChRV96DBjHpnzZiG4A/F8g/xCwA/8c25MyDEpv6AMyT7Xtj2H7
 KPTLtY+NaXoemdPES1CAkdHRuY8bNSt9D3hzTH8ltIOpincgikLNtkpe60kUW6XZMfq8
 KQFzFi1JyfZyYsPXy9lKcYlRJ9hSFPy5l07GYdu9m6u7QUmIKr3xZYf6j/iz66gGFY50
 lQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740146803; x=1740751603;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=otGMBD+B4/VET7RFn8bZmOFcmmLMoF/BIhvFgKTCsGs=;
 b=GFDtMgSQFAswX0yAabZMqMtb1cELlxy3B9c3/CSqEYNd3yQ8iSI7izOJOToxGBUo/g
 c3T/BSgUUmZPD1liqIaHOP1v4FJN/PRGuja/PsAXLpTAYALwIhQv6ef2Em9ziCVRHxvJ
 M6CqAsKYwtmJ6l8f56lKRV6f1DwAZRcozelLiF+s+zdD6hXaHYv9/9AvMO+nACcig6q/
 zCALE6DcvZNzybh1WBxtCEMUjFODGJTUE2Ma90R4k03+xjdgwQ0703CTCg3H09cRA9Ll
 lkdQEnJZwvUs2Y/bcup61ZMPls9KwQy7vzbcmyAsKeXR9NMioUvK4dBKWDoCTJdqu2E9
 KXbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgjPkD2bJEwUYjwwlTQSZnh2i26Ks3AlDbH7rCRKJ1w50qEo0sSYjyYsqOv+otgOEBDV3g5GUDZGCu@nongnu.org
X-Gm-Message-State: AOJu0YyGWGiBNq4gpuhYUB/z9poraSpJkagtnDg7rifX7yL+eZTD7Ezn
 EjWLzhktzSB3aQkuqjWbyFbwTdkwRdLZMJcjWZqeReNimoJjaF3GW1a6DRZgCffd3Lec2YcsLLS
 z
X-Gm-Gg: ASbGncsgE+4g9Cab/PeH6Shfg8EYr3LdNdoZUyqDEGdh4UfA9HlOZ2Z2yv4QZLhtwrf
 k5FSeAkKSdXMaKkQFf7JFvJZOy/iY0nAdEGERududZSErSYtOr6YZT44efpvqcEWXwZPGL/71GS
 5tSBwYwcIoH1HNRoCbwohNrEpDvYnNrmS/EgmxgUyqP+cXdMIekIzZmi0ca6UNLR7zDkokoAWtO
 GkJFF30e9j47BUXAM9a7JmmJ/OwKlAtmSyEZxWfywtsmLK0PTQ6e++R9Pvr+1hlh0Z7w+papblE
 lAoL2tY2UgvqC1A+AQwXW6Cy6MBcTk2H
X-Google-Smtp-Source: AGHT+IHUyabaJWnT/v6+/FvGd+1xtO5QcZCWPi2Z5hxrJ8eXvm8IeYOEHPHCQINQUlrZSrP/aKDEWQ==
X-Received: by 2002:a05:600c:46c9:b0:439:93d2:72b4 with SMTP id
 5b1f17b1804b1-439ae1f159fmr40024825e9.16.1740146803111; 
 Fri, 21 Feb 2025 06:06:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4399c5f901bsm40455475e9.3.2025.02.21.06.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 06:06:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] tests/functional: Bump some arm test timeouts
Date: Fri, 21 Feb 2025 14:06:40 +0000
Message-ID: <20250221140640.786341-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

On my local machine, for a debug build, sbsaref_alpine takes
nearly 900s:

$ (cd build/x86 && ./pyvenv/bin/meson test --setup thorough --suite func-thorough func-aarch64-aarch64_sbsaref_alpine
)

1/1 qemu:func-thorough+func-aarch64-thorough+thorough / func-aarch64-aarch64_sbsaref_alpine
                      OK 896.90s

arm_aspeed_rainier can also run close to its current timeout:
 6/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_rainier
                      OK 215.75s

and arm_aspeed_ast2500 and arm_aspeed_ast2600 can go over:
13/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2600
                      OK 792.94s

27/44 qemu:func-thorough+func-arm-thorough+thorough / func-arm-arm_aspeed_ast2500
                 TIMEOUT 480.01s

The sx1 test fails not on the overall meson timeout but on the
60 second timeout in some of the subtests.

Bump all these timeouts up a bit.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This at least gets 'make -j4 check-functional' to passing for me
for an arm/aarch64 debug build, apart from the gpu test hang which
we're discussing in a different thread. Whole thing takes 25 mins...
---
 tests/functional/meson.build     | 8 ++++----
 tests/functional/test_arm_sx1.py | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b516d21cba1..effa31701cf 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -15,16 +15,16 @@ test_timeouts = {
   'aarch64_raspi4' : 480,
   'aarch64_rme_virt' : 1200,
   'aarch64_rme_sbsaref' : 1200,
-  'aarch64_sbsaref_alpine' : 720,
+  'aarch64_sbsaref_alpine' : 1200,
   'aarch64_sbsaref_freebsd' : 720,
   'aarch64_tuxrun' : 240,
   'aarch64_virt' : 720,
   'acpi_bits' : 420,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
-  'arm_aspeed_ast2500' : 480,
-  'arm_aspeed_ast2600' : 720,
-  'arm_aspeed_rainier' : 240,
+  'arm_aspeed_ast2500' : 720,
+  'arm_aspeed_ast2600' : 1200,
+  'arm_aspeed_rainier' : 480,
   'arm_bpim2u' : 500,
   'arm_collie' : 180,
   'arm_cubieboard' : 360,
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/test_arm_sx1.py
index b85bfaa178f..4dd1e1859fa 100755
--- a/tests/functional/test_arm_sx1.py
+++ b/tests/functional/test_arm_sx1.py
@@ -44,7 +44,7 @@ def test_arm_sx1_initrd(self):
         self.vm.add_args('-no-reboot')
         self.launch_kernel(zimage_path,
                            initrd=initrd_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
     def test_arm_sx1_sd(self):
         self.set_machine('sx1')
@@ -55,7 +55,7 @@ def test_arm_sx1_sd(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=sd,file={sd_fs_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
     def test_arm_sx1_flash(self):
         self.set_machine('sx1')
@@ -66,7 +66,7 @@ def test_arm_sx1_flash(self):
         self.vm.add_args('-snapshot')
         self.vm.add_args('-drive', f'format=raw,if=pflash,file={flash_path}')
         self.launch_kernel(zimage_path)
-        self.vm.wait(timeout=60)
+        self.vm.wait(timeout=120)
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.43.0


