Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07F94E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:51:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dp-0005pi-0J; Sun, 12 Jan 2025 19:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dm-0005ga-MQ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:14 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dl-0000qf-1s
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:14 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-385ddcfc97bso3205405f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729351; x=1737334151; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLpUfFvaCy7mLELhl3n8PPeN1TDF+RaDGuZ4JtW2qZE=;
 b=UvFUxL2hU+4OuNAHFD+jKvnzFDzoaBO77LB/PjGiTqBhha2d7rzvHLviXBKyqxqAUH
 4ljN0SxzbPFoKWS/OihII25N9NmNFAAF1k/xxof/mF9L0gc0kFlSNv9VewfaMxD6QROr
 SqfpoVjMSj7saT90JqgupL4Z33MwutFzW0+WJZtRm7agspwSpd/M8etJuODgecoCAjUc
 Kb+gJ3rHIUoqrXvkrsUKs/6JfScl2TjuVReXI9ts3pQpDPthGrBUiAWx3E+iacNJgnx/
 GimTfta9y43+2/WsjW2v1WazzOgLX3/3HT914wuuPICHSHEVV7OifLewyUaRb2Gwej7H
 rPZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729351; x=1737334151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLpUfFvaCy7mLELhl3n8PPeN1TDF+RaDGuZ4JtW2qZE=;
 b=HP7ZSmJpcdnS+jflUtMpRMDVpfw9Q5nJye8u1op7xqVsS10Hc00/MIK60nMVjZs+kT
 SGzp5FYNKTC6/G29XMjKK7gxKxZQiN7cpESfytTAvOE+uA0iNrBTATZAhWC3RVV9Icr/
 GTXWxNGGTUOcPMFMW+/6FEax29j9nH0+FFyPKBeipceF6t/WAjuNKhM5/MoZHcdtewJC
 68zj6ztZsXuedvPXkd/LOqVcuM0obdxkBPjotRpzbkE5d/odtt0iV5w/l4eysB+kBeoh
 cF6EeaiAirZPl2mGwH2kKoXDOuDATqvoLgQi9wn/NPyHrhW9UcL1qVILpsqjXzCLmkYF
 vDWg==
X-Gm-Message-State: AOJu0YzgA1mVwJRMrmGZ12XlYE9Co64zMLuF6PtIwn+9j7QX3J277wUe
 ZVUlTABPEFt81kjb/x7Nx/JfElh/YkeXZ35kdjpWQG/YhNtsVc7EqT4rSmGSg4SUUP+U4TJHqa/
 93zg=
X-Gm-Gg: ASbGncu6SJfb+4FS6JMZO7glaU/vSwtJBhWfHXL1Bw+hs064id1/jQkjZxAJ8Znejgw
 OUCFBXhc3vwyyWvY2F8S5GSPx2v+2IiHbuVDl1pf2vT0S4RkwQZWM48uM9lFmPTxeKGxX1sBm3N
 ZF6XkYUZFJb5wAMXyyLS5hF7ZiwYDuLHuPYhReWx4N9lskD5aZQAhkZE3U+Q8ELoIyj9jLKkxei
 lpjDIS/SF5WPL2xkK0k/2PNT7O8i9oTmDMfauZzuTlUhvHCPPbbS51DU+1b5Wm+3sDH9nFEMeWK
 qkpcE+ixdleigD8wd03sweMrpy42V/M=
X-Google-Smtp-Source: AGHT+IGyV7w8ZMwA666tYizdiM6nYlJvXXmx6UkK/twhkxNM6OM+76mVpghV3xT7Q6UrvA2rOHYqBg==
X-Received: by 2002:a5d:47af:0:b0:38b:dbeb:63a2 with SMTP id
 ffacd0b85a97d-38bdbeb64acmr1820182f8f.55.1736729350992; 
 Sun, 12 Jan 2025 16:49:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fc51sm127732735e9.7.2025.01.12.16.49.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:09 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 14/23] hw/mips/bootloader: Propagate CPU to
 bl_gen_jump_kernel()
Date: Mon, 13 Jan 2025 01:47:39 +0100
Message-ID: <20250113004748.41658-15-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_jump_kernel() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h |  2 +-
 hw/mips/bootloader.c         | 14 +++++++-------
 hw/mips/boston.c             |  2 +-
 hw/mips/fuloong2e.c          |  2 +-
 hw/mips/malta.c              |  2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index daa2b92e249..6b58eafb8bc 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -13,7 +13,7 @@
 #include "target/mips/cpu-qom.h"
 
 void bl_gen_jump_to(const MIPSCPU *cpu, void **ptr, target_ulong jump_addr);
-void bl_gen_jump_kernel(void **ptr,
+void bl_gen_jump_kernel(const MIPSCPU *cpu, void **ptr,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
                         bool set_a1, target_ulong a1,
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 6f055228392..9804051ab2d 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -256,7 +256,7 @@ void bl_gen_jump_to(const MIPSCPU *cpu, void **p, target_ulong jump_addr)
     bl_gen_nop(&cpu->env, p); /* delay slot */
 }
 
-void bl_gen_jump_kernel(void **p,
+void bl_gen_jump_kernel(const MIPSCPU *cpu, void **p,
                         bool set_sp, target_ulong sp,
                         bool set_a0, target_ulong a0,
                         bool set_a1, target_ulong a1,
@@ -265,22 +265,22 @@ void bl_gen_jump_kernel(void **p,
                         target_ulong kernel_addr)
 {
     if (set_sp) {
-        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_SP, sp);
+        bl_gen_load_ulong(&cpu->env, p, BL_REG_SP, sp);
     }
     if (set_a0) {
-        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A0, a0);
+        bl_gen_load_ulong(&cpu->env, p, BL_REG_A0, a0);
     }
     if (set_a1) {
-        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A1, a1);
+        bl_gen_load_ulong(&cpu->env, p, BL_REG_A1, a1);
     }
     if (set_a2) {
-        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A2, a2);
+        bl_gen_load_ulong(&cpu->env, p, BL_REG_A2, a2);
     }
     if (set_a3) {
-        bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_A3, a3);
+        bl_gen_load_ulong(&cpu->env, p, BL_REG_A3, a3);
     }
 
-    bl_gen_jump_to(MIPS_CPU(first_cpu), p, kernel_addr);
+    bl_gen_jump_to(cpu, p, kernel_addr);
 }
 
 void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 63dc654192a..3a06b776fe8 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -352,7 +352,7 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
      * a2/$6 = 0
      * a3/$7 = 0
      */
-    bl_gen_jump_kernel(&p,
+    bl_gen_jump_kernel(MIPS_CPU(first_cpu), &p,
                        true, 0, true, (int32_t)-2,
                        true, fdt_addr, true, 0, true, 0,
                        kernel_entry);
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 16b6a5129e7..b87622ee6e3 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -179,7 +179,7 @@ static void write_bootloader(CPUMIPSState *env, uint8_t *base,
     /* Second part of the bootloader */
     p = (uint32_t *)(base + 0x040);
 
-    bl_gen_jump_kernel((void **)&p,
+    bl_gen_jump_kernel(MIPS_CPU(first_cpu), (void **)&p,
                        true, ENVP_VADDR - 64,
                        true, 2, true, ENVP_VADDR,
                        true, ENVP_VADDR + 8,
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index 37be2330eda..fe9e06f48f4 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -678,7 +678,7 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcfc),
                      tswap32(ldl_be_p(pci_pins_cfg)));
 
-    bl_gen_jump_kernel(p,
+    bl_gen_jump_kernel(MIPS_CPU(first_cpu), p,
                        true, ENVP_VADDR - 64,
                        /*
                         * If semihosting is used, arguments have already
-- 
2.47.1


