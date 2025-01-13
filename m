Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E98E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eM-0006sN-0W; Sun, 12 Jan 2025 19:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dy-0006CW-NY
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:27 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dw-0000tc-HF
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:26 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4362bae4d7dso26415745e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729362; x=1737334162; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnTQGGFB/yJvM735W+46gpi1tDgppAHE7XXXP07EEYQ=;
 b=mWH1Fht0jgzQkeIzTnC4o3reDUAGv0D6gU8LU7kWLNMF/zee6PNDbDTpYkp4jbfcKA
 rG6GqYtiYf7+9jsEWflku9V8HQ58O2jUUwIi/KiEN0ZWb/e8P5P4jefpGCpgfnBWIlKI
 GfgDc1ZKeyc2FY/3NZNHtxGSzc3yhMDFxkQaxKycNyJKRLScGODIFnanZsi/83Oep8/q
 3SVHl8cjdmoPL+eNqWjv0tT5DvEsscCBVxc0zk1ae5HuMNsX0tKeCSzn54+CbSBnm4/w
 Hds3+POq6bH2vEKt/01W72rsv59g1EMfAqAAtHaDiDK+/NujZBsv0PeCE/fKYyeUMfy9
 huMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729362; x=1737334162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DnTQGGFB/yJvM735W+46gpi1tDgppAHE7XXXP07EEYQ=;
 b=m3H84Bb0FAdHEQTmZIPuljE6lY//uUG40JmMBC08Wb59rIVH79ghF4R6mEfpLSg8l0
 3SGeakmRQsIQAWhSK9llqg4LowEz8jQBhgDj+n7To+nLX2YATGLDNwUHUz6ZSWq7XDRu
 SZEhkBJMmb73La5aFGq58dmSnWec+tx1iV3bzMWSQzKx5oDCkqNUoiOZw2/9XirF8+JX
 XDQA5kWxSbPDoC4QBoqw+JVuLPzQd5iaeAyfzeeIxMGfi9Rk1xFpqFW+pDzh0mxiyqGV
 obMMT8fZLxK15lkAixyaj2bJeOkKNowDBy+QFOcZNIARLyZVYkQpEZAl4zxzxBoYQFoY
 fDkA==
X-Gm-Message-State: AOJu0YwqeDmTd5O6yNPutCvGIQvXCagSpsRR8UL+ceDT6PxpXOovPS/4
 RjHb6GXiifhJmASgtDUizpcUGKrHOK03cWyDs4hTO5gNcEdt0VZQAz/Qn6kFs8/yDyoIVfTO2cj
 fjEo=
X-Gm-Gg: ASbGncvsYcxs2yMSDIyVupTEtC2c1fLvskqWgMgfsElra4DlC41IddJjMpqhi60qLDb
 r7yqQkecoxUdx3RJideaOFGSVIvRt8cpTaMvqdPDzIrmUYvy0A0JTKmMz5s5A5A1O778J3LQHYI
 hQLJnmv1jdq+E8EKmIMeExQKpgLMX0Eamfb/k4c93j+gHh8P16gp0aW+1sUEo5npND8KWN12EUB
 9zpP3cpLNOx8DUXvsnq6e2Tb0hf0GFAQeRvaaF3Yu6kfMHT41QTNUHLdUDGCl3WSCf38L/CRqj2
 l3PttTj3VKO7dTsierij1ljbxKyvJHg=
X-Google-Smtp-Source: AGHT+IHONZCVA6soNUrGSpYRy4eBb1zfGylUuf4MD8eEsJ4nqz1m8t1K/YzuoAU+rkHEjAuk3Ve4FQ==
X-Received: by 2002:a5d:6d8e:0:b0:38a:88be:bcb4 with SMTP id
 ffacd0b85a97d-38a88bebd23mr15668163f8f.29.1736729362500; 
 Sun, 12 Jan 2025 16:49:22 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1b44sm10901970f8f.90.2025.01.12.16.49.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:21 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 16/23] hw/mips/bootloader: Propagate CPU to bl_gen_write_u32()
Date: Mon, 13 Jan 2025 01:47:41 +0100
Message-ID: <20250113004748.41658-17-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
declared bl_gen_write_u32() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h |  3 ++-
 hw/mips/bootloader.c         |  9 +++++----
 hw/mips/malta.c              | 18 +++++++++---------
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index a7f174e16bc..cc2ffe3ab2c 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -22,7 +22,8 @@ void bl_gen_jump_kernel(const MIPSCPU *cpu, void **ptr,
                         target_ulong kernel_addr);
 void bl_gen_write_ulong(const MIPSCPU *cpu, void **ptr,
                         target_ulong addr, target_ulong val);
-void bl_gen_write_u32(void **ptr, target_ulong addr, uint32_t val);
+void bl_gen_write_u32(const MIPSCPU *cpu, void **ptr,
+                      target_ulong addr, uint32_t val);
 void bl_gen_write_u64(void **ptr, target_ulong addr, uint64_t val);
 
 #endif
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index c4fd85b9f42..6f0222faf48 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -295,11 +295,12 @@ void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
     }
 }
 
-void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
+void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
+                      target_ulong addr, uint32_t val)
 {
-    bl_gen_li(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
-    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
-    bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_li(&cpu->env, p, BL_REG_K0, val);
+    bl_gen_load_ulong(&cpu->env, p, BL_REG_K1, addr);
+    bl_gen_sw(&cpu->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
 void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
diff --git a/hw/mips/malta.c b/hw/mips/malta.c
index fe9e06f48f4..5ccff2cb0c1 100644
--- a/hw/mips/malta.c
+++ b/hw/mips/malta.c
@@ -636,29 +636,29 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
     /* setup MEM-to-PCI0 mapping as done by YAMON */
 
     /* move GT64120 registers from 0x14000000 to 0x1be00000 */
-    bl_gen_write_u32(p, /* GT_ISD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_ISD */
                      cpu_mips_phys_to_kseg1(NULL, 0x14000000 + 0x68),
                      cpu_to_gt32(0x1be00000 << 3));
 
     /* setup PCI0 io window to 0x18000000-0x181fffff */
-    bl_gen_write_u32(p, /* GT_PCI0IOLD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0IOLD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x48),
                      cpu_to_gt32(0x18000000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0IOHD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0IOHD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x50),
                      cpu_to_gt32(0x08000000 << 3));
 
     /* setup PCI0 mem windows */
-    bl_gen_write_u32(p, /* GT_PCI0M0LD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M0LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x58),
                      cpu_to_gt32(0x10000000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M0HD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M0HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x60),
                      cpu_to_gt32(0x07e00000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M1LD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M1LD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x80),
                      cpu_to_gt32(0x18200000 << 3));
-    bl_gen_write_u32(p, /* GT_PCI0M1HD */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0M1HD */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0x88),
                      cpu_to_gt32(0x0bc00000 << 3));
 
@@ -669,12 +669,12 @@ static void bl_setup_gt64120_jump_kernel(void **p, uint64_t run_addr,
      * Load the PIIX IRQC[A:D] routing config address, then
      * write routing configuration to the config data register.
      */
-    bl_gen_write_u32(p, /* GT_PCI0_CFGADDR */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0_CFGADDR */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcf8),
                      tswap32((1 << 31) /* ConfigEn */
                              | PCI_BUILD_BDF(0, PIIX4_PCI_DEVFN) << 8
                              | PIIX_PIRQCA));
-    bl_gen_write_u32(p, /* GT_PCI0_CFGDATA */
+    bl_gen_write_u32(MIPS_CPU(first_cpu), p, /* GT_PCI0_CFGDATA */
                      cpu_mips_phys_to_kseg1(NULL, 0x1be00000 + 0xcfc),
                      tswap32(ldl_be_p(pci_pins_cfg)));
 
-- 
2.47.1


