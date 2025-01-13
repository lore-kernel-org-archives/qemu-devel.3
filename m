Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDC6AE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8eP-0007GN-0V; Sun, 12 Jan 2025 19:49:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8e4-0006S8-GJ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8e2-0000vF-O2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:49:32 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4364a37a1d7so39839095e9.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729368; x=1737334168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dPxKQ/F0F5Y9fVdADeTYJnxnJvYLv/MwkaYYc0aiVY=;
 b=bheoitWtdxQbkerkqlsOZHi1Nc2yJeg2Cnam8mTC7Mtdp8JnAdECzAfsDn5+zh6DLX
 2N1Te2io1oj6dSnv2V3M+iOpxg4D5cimdfAvvjgYKCOOfP0ofyCZmQhrpgxcwZiOqwi4
 Q6mi+rL1AxJ0H4LO4pZQ06Fm27lK97ILdNCGf0q8us1YeTMXC9uAI06SAQLOfsDVTwqh
 YourvnmkTBdWs6HR5qNo8rsQ/QyoucCF//23yZfOrn6pY7KUd0ErhguEOnyk5Rq6Clda
 jzsCsCtORIRHeHp4YaCEJ5HF/uqfd60oyk55RYJUQnJZO8I1uHnGT6GL3hWt9pOcXy1O
 4qTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729368; x=1737334168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dPxKQ/F0F5Y9fVdADeTYJnxnJvYLv/MwkaYYc0aiVY=;
 b=bOCuwnTfuj2BACoiWWOiKXDwi5EK16vemeX022pJLWI2vl6Arl8uV4rwRWbXV7BVPa
 6eGr+q6J5So5QO6fiIv0cZxYvWcNM2AK1b2yKuELzRhZvMbadyHa0MvCBuQLi0DfV+13
 ba94cB3c+3BwB+Ot5ybHrKmeGDzXS0Qgy3+yJeBs++YSpPXAYfyMllz06WGmuDMc1kiX
 MLL9mHO6UHv01WxWph4AdHGOxO5ubX21+IOxWRh4KdXwMROlASGWsv4IwadhSpp0pTNZ
 XDoygfrewKKOgZZU8xQWEvw4KtB0Y9QzG3MDFdGz+k9TaTBWWJsncJX41QQEQEMEwfDL
 kUPw==
X-Gm-Message-State: AOJu0YwRaXMhRx3hVYOdqjc2p1j0xThBWtohdea/6D+HIsrADl0B4ZRH
 nlJruFTIv9auBRfzvkNnCpYPrDhDfkP1DyFOWSy5tfAPhXEEA9DXcm3PtwZfuRdB7LhNiilT7Qc
 NYZI=
X-Gm-Gg: ASbGncvPAw++rttnejTY9RMAGW2bC59NXSnpwk3D5v/p71iqmg3WsvB2c/E1+BI16jO
 Bys/Mkjt4YxNr+kGbFMnWAFd36Ti4oVhvgaGKGTezxI+Dx2Jucst67hOMW4DLrPw4e2JvCBm826
 BLv4NOHLNviLfFQw/ZZxJbtcbdTRGspce5Jc4p30FIa3yZmyX3sQFlnbLkKkpwwBfrc4PRmroeR
 pyWV6UKooCN74YE8Cec6CtvpTl/PKYo7ZB1PpqjNCLa3Dxto+jFj4fZM5tYsf8apVh9wnJsqivX
 WX7Ed2Teet4figprjX4Jd6pcqcTs2qI=
X-Google-Smtp-Source: AGHT+IHkLaGjvjzOp2PJNqamaQOL4GM9Dzw9H5a8O0832ed9Tgdp4eOWkBGYyQ/a7w8+f1NpWDnViw==
X-Received: by 2002:a05:6000:4011:b0:386:3835:9fec with SMTP id
 ffacd0b85a97d-38a873306cemr18348103f8f.44.1736729368552; 
 Sun, 12 Jan 2025 16:49:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38325esm10765264f8f.27.2025.01.12.16.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:49:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 17/23] hw/mips/bootloader: Propagate CPU to bl_gen_write_u64()
Date: Mon, 13 Jan 2025 01:47:42 +0100
Message-ID: <20250113004748.41658-18-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
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

Propagate the target agnostic CPU pointer to the publicly
declared bl_gen_write_u64() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/mips/bootloader.h | 3 ++-
 hw/mips/bootloader.c         | 9 +++++----
 hw/mips/boston.c             | 6 +++---
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/hw/mips/bootloader.h b/include/hw/mips/bootloader.h
index cc2ffe3ab2c..946580f6f5c 100644
--- a/include/hw/mips/bootloader.h
+++ b/include/hw/mips/bootloader.h
@@ -24,6 +24,7 @@ void bl_gen_write_ulong(const MIPSCPU *cpu, void **ptr,
                         target_ulong addr, target_ulong val);
 void bl_gen_write_u32(const MIPSCPU *cpu, void **ptr,
                       target_ulong addr, uint32_t val);
-void bl_gen_write_u64(void **ptr, target_ulong addr, uint64_t val);
+void bl_gen_write_u64(const MIPSCPU *cpu, void **ptr,
+                      target_ulong addr, uint64_t val);
 
 #endif
diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 6f0222faf48..c5bad03b528 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -303,9 +303,10 @@ void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
     bl_gen_sw(&cpu->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
-void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
+void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
+                      target_ulong addr, uint64_t val)
 {
-    bl_gen_dli(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, val);
-    bl_gen_load_ulong(&MIPS_CPU(first_cpu)->env, p, BL_REG_K1, addr);
-    bl_gen_sd(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_dli(&cpu->env, p, BL_REG_K0, val);
+    bl_gen_load_ulong(&cpu->env, p, BL_REG_K1, addr);
+    bl_gen_sd(&cpu->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 3a06b776fe8..09c4dfade12 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -329,19 +329,19 @@ static void gen_firmware(void *p, hwaddr kernel_entry, hwaddr fdt_addr)
 
     /* Move CM GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, GCR_BASE_ADDR + GCR_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
                      boston_memmap[BOSTON_CM].base);
 
     /* Move & enable GIC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_GIC_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
                      boston_memmap[BOSTON_GIC].base | GCR_GIC_BASE_GICEN_MSK);
 
     /* Move & enable CPC GCRs */
     regaddr = cpu_mips_phys_to_kseg1(NULL, boston_memmap[BOSTON_CM].base
                                            + GCR_CPC_BASE_OFS),
-    bl_gen_write_u64(&p, regaddr,
+    bl_gen_write_u64(MIPS_CPU(first_cpu), &p, regaddr,
                      boston_memmap[BOSTON_CPC].base | GCR_CPC_BASE_CPCEN_MSK);
 
     /*
-- 
2.47.1


