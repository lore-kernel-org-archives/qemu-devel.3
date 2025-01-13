Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E0FE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8cw-0004PK-5t; Sun, 12 Jan 2025 19:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cu-0004Ov-Ep
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:20 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8cs-0000iw-FG
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:20 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a88ba968aso3123126f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729296; x=1737334096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RaLd62FWqL+hLOLg3wMqHXBcHhygEQ6lOnbn557VnfU=;
 b=Bln4nT2gsqnj45JuwV7gPFg04XHta5A9o5MiNyFZpTdBRqdmAHimdTVRJDR76xKwQh
 GrQepBwijvx8jbZPS/w4LnvNZ5R7tZ5omTydP6qziEDia4Oq/HOl+gWjFhOWs2uWSi8Z
 S3uGq2VezZ+Lok6o/KdeZs98b9M53Szk9Yk0dcl8NI/gv3/K4tR7LPLPAI4u2ggFrVho
 09/akvmXYR4k1esyCZ/MW1h49ZdkNguFR0aWNipUxyjg+tNy994BMvBZ5It0wc7QR817
 F6nW/kOQhXClITrEGI0Evzka7w288HQk/XBoeM0kbRNVZ4ej6zLfTB9IHKRpZtJoZbJt
 HcTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729296; x=1737334096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RaLd62FWqL+hLOLg3wMqHXBcHhygEQ6lOnbn557VnfU=;
 b=fpeVwLn6dcYuh+3fmK70Wo4N7+m5yGKQTc6dxy1SkPywn0rvx1iuM9URF43rb9iaBA
 1G8jh2vVthax4e6WIQ/+qEzhczRgReUR3YVgZGbI0ACbXG5VzCcDrsDXwwlwiJ6yDyM7
 Or58vEM7xefgpu6ei2qkcax8Ook70s4eLx8SHmx5kRVMn0UjasEJjOaoQLbzMELEmAac
 9aje1U6KnYQ5nE0vU7F3PZPp/SbrcWWMl3U7yAMMQuunDtta2OIv2AyYc8qM+3UmQSDK
 6gwp0M00QdcT7oUOvmj7hx7di+S0saPfNMKs6K6wDY+f5LS7GpqdwkbUwigIDMLaqJRR
 qLVw==
X-Gm-Message-State: AOJu0Yy2Klvf9FW1n+HU4JoHzWPymow/iZRzi2mTI8nLETlsq9csbJ4c
 fHKkp+7izu0DLKBXryl6lVKtYfz2SogF3aDf73mUq8waQpnjBDu4dCwBr6TzKJO/neE/r1Cdx51
 xLZw=
X-Gm-Gg: ASbGncuZsa7PWuezldNeoqWA/QckIvj1x947jUyfPVfJspR+rq8HvvmoVk9nNeAY6jE
 HqkooXrE2XiiDDOaHcKfuAe/6+D5lI+QiWfu40TnfrD1E4hUXbM3ylfK0QlKTcg4ZLVyCA+ZQ+/
 8IJQSEBFz1j2tnWYv/ZQkxvvPMOrq+4C7+oHOwX2T32hSU+tZUeMenQ1xtrevWWAkGmxnXbmXdi
 FmFwbnfhkzN2/pp1KMwWRTQBL0AdGAzNzsIFKOX0MX4+wT8d/1hsO0KdUJ2tWn3hsJ7+eZmscpA
 Ze/fcAuqVut0pm06DdMW534AiyEZZn8=
X-Google-Smtp-Source: AGHT+IEQBvyWzkoQVjdmfmIfrw/yVEGP6lHCidH6Y561kN3oQGNTNDTy3rKw9FwrLDkMSjWO03wIew==
X-Received: by 2002:a5d:6483:0:b0:385:fabf:13d5 with SMTP id
 ffacd0b85a97d-38a8730d55cmr18261118f8f.25.1736729296324; 
 Sun, 12 Jan 2025 16:48:16 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b8299sm10825477f8f.74.2025.01.12.16.48.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 04/23] hw/mips/bootloader: Propagate CPU env to
 bootcpu_supports_isa()
Date: Mon, 13 Jan 2025 01:47:29 +0100
Message-ID: <20250113004748.41658-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Propagate the target specific CPU env to the locally
declared bootcpu_supports_isa() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 1dd6ef20968..918ce7795c4 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -49,9 +49,9 @@ typedef enum bl_reg {
     BL_REG_RA = 31,
 } bl_reg;
 
-static bool bootcpu_supports_isa(uint64_t isa_mask)
+static bool bootcpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask)
 {
-    return cpu_supports_isa(&MIPS_CPU(first_cpu)->env, isa_mask);
+    return cpu_supports_isa(env, isa_mask);
 }
 
 static void st_nm32_p(void **ptr, uint32_t insn)
@@ -69,7 +69,7 @@ static void st_nm32_p(void **ptr, uint32_t insn)
 /* Base types */
 static void bl_gen_nop(void **ptr)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
         st_nm32_p(ptr, 0x8000c000);
     } else {
         uint32_t *p = *ptr;
@@ -120,7 +120,7 @@ static void bl_gen_i_type(void **ptr, uint8_t opcode,
 /* Single instructions */
 static void bl_gen_dsll(void **p, bl_reg rd, bl_reg rt, uint8_t sa)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_r_type(p, 0, 0, rt, rd, sa, 0x38);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -129,7 +129,7 @@ static void bl_gen_dsll(void **p, bl_reg rd, bl_reg rt, uint8_t sa)
 
 static void bl_gen_jalr(void **p, bl_reg rs)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
         uint32_t insn = 0;
 
         insn = deposit32(insn, 26, 6, 0b010010); /* JALRC */
@@ -196,7 +196,7 @@ static void bl_gen_sw_nm(void **ptr, bl_reg rt, uint8_t rs, uint16_t ofs12)
 
 static void bl_gen_sw(void **p, bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
         bl_gen_sw_nm(p, rt, base, offset);
     } else {
         bl_gen_i_type(p, 0x2b, base, rt, offset);
@@ -205,7 +205,7 @@ static void bl_gen_sw(void **p, bl_reg rt, uint8_t base, uint16_t offset)
 
 static void bl_gen_sd(void **p, bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_i_type(p, 0x3f, base, rt, offset);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -215,7 +215,7 @@ static void bl_gen_sd(void **p, bl_reg rt, uint8_t base, uint16_t offset)
 /* Pseudo instructions */
 static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
         bl_gen_lui_nm(p, rt, extract32(imm, 12, 20));
         bl_gen_ori_nm(p, rt, rt, extract32(imm, 0, 12));
     } else {
@@ -235,7 +235,7 @@ static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
 
 static void bl_gen_load_ulong(void **p, bl_reg rt, target_ulong imm)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_dli(p, rt, imm); /* 64bit */
     } else {
         bl_gen_li(p, rt, imm); /* 32bit */
@@ -281,7 +281,7 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
 {
     bl_gen_load_ulong(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
         bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
-- 
2.47.1


