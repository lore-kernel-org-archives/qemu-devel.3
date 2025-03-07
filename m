Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36705C19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 15:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqZII-0000vu-TH; Fri, 07 Mar 2025 10:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZIF-0000uu-Hc
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:20 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqZID-00089m-HZ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 10:07:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43bcf9612f4so16469715e9.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 07:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741360035; x=1741964835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rIwmQF35hYwgON9JLC3NfuNYRtNZnkx/8hFBCdAWebE=;
 b=Yj5J8pArVlXgZfm3UvwuCPjIJGPpnJptdcz/fhlQLRuxBah26pHfiJsqkL0xriHt9x
 VtEg37erg00hBetuJQ9Ixm2SaBEE5mKFiMUWtiIHYLDkSCr0wKTiEgUvoZ23W7tO1EgN
 +zWDIrN101XBrJ6dRMLeXr6he1WytVkEiPmqXjWvv71VI7CvXd6MG065Y5xJsZBYZPJ+
 BJuN1HnzksKtdwUhv3tydvaY2eVHJhZsffVvtghjFq07uooF0rl8zQMgTQaC7Uzd4CCL
 MEarPU2ebPQXzWnRl34FBHpbwbcoUl54B7AjbaBIQ9BHmtwjdMhGNN+3L/V3Q0+cF9QE
 YzPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741360035; x=1741964835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rIwmQF35hYwgON9JLC3NfuNYRtNZnkx/8hFBCdAWebE=;
 b=nhCuH8bFe7k99MLFejr9ORHsHwBGU0NMogFDJ7hMKlZrFGLX2QbI2jC39WLTI7sha+
 vajvHPAA1eIBYuFQDW2ode61eOYHrfCaxe6ZOAiIWKZblDq3wo/K9m4zqqszFUJwxWQf
 OqqVGWrs3SWwfxvRoG6/qLWTTEpLzfAJHGmLcVglu6E5yaITl13EROvlNpUjKm8KIR48
 sEKCbxywxt5X2skyQ8YqCZsdiqRrSK4uccxFoRDyWrkvd7u4+Azkb4fi0kQOmtGorIit
 fjrSh5Ox0reDNxEp7xrj/sp8irFYi8iJ5mqLnb9q1M1/+cGU/iT1dg43Ob5oBQagLKuN
 ijxA==
X-Gm-Message-State: AOJu0Yy+ntlfxfOKEfGu6M4ZE2dy4tcBiNyGz3MN/iMiONOzNvf5oiGh
 3XJ5IA0sj+zIk8Hnsrij7mw9X8bCnmP97VNPXEIqdC1tTAMwk86XVP5zPgGolujm+54W1Z1zoWR
 1
X-Gm-Gg: ASbGnct4HjGls0tmNTKy4bhBhJwhgKRuDX+QBlvlEouVbRhWZst/qRYgmvflnY7EveY
 mzQSOJEbtN5iuzGBtoaEFwcZzTBUFdw3RWsgtneTOJLyf/RPbNQLVvvvKou25qpGZvj59oPCwlU
 BmJvAQV7utBR8UYXzzD9BsuS2eCbzrUUvsTP0u+EaSZNZoyzGxzBxsP3qdp3NMjs32bW6anailq
 UA4QLA9edHNdJTWvmx3+FTinIAVY3gRE0eWIsMVK4EF3MeKBQIUMCioKUalOvl2BrdRydfReX9j
 oLWgTWdcMjutAq2e8Z1baDQ4sHG6sbz2rnYBHyzvYm2q+64VUjI=
X-Google-Smtp-Source: AGHT+IFqTOgIuw/RO92V7XXqoQMiwcpaymB5c2qqQV2oZyGyWEwVslopCyqQe9lD5mC2WriJeHaCDQ==
X-Received: by 2002:a5d:59a8:0:b0:390:ea4b:ea9 with SMTP id
 ffacd0b85a97d-39132d98be4mr2743830f8f.39.1741360034779; 
 Fri, 07 Mar 2025 07:07:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c1031fdsm5443627f8f.89.2025.03.07.07.07.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 07:07:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/21] tests/functional/test_arm_sx1: Check whether the serial
 console is working
Date: Fri,  7 Mar 2025 15:06:50 +0000
Message-ID: <20250307150708.3222813-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307150708.3222813-1-peter.maydell@linaro.org>
References: <20250307150708.3222813-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Thomas Huth <thuth@redhat.com>

The kernel that is used in the sx1 test prints the usual Linux log
onto the serial console, but this test currently ignores it. To
make sure that the serial device is working properly, let's check
for some strings in the output here.

While we're at it, also add the test to the corresponding section
in the MAINTAINERS file.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250226104833.1176253-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS                      | 1 +
 tests/functional/test_arm_sx1.py | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5df6020ed54..699cf59e0b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2010,6 +2010,7 @@ S: Maintained
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
2.43.0


