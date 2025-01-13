Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E736C02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYf-0007vo-45; Mon, 13 Jan 2025 14:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYY-0007BQ-85
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:57:02 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYW-0007XO-Bq
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:57:01 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so2559139f8f.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798218; x=1737403018; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8lF9ZX3ePxEP+Ja3OcSq5ETj9a2lfeHBgYz0T+6A3ww=;
 b=U/ziuPYszkmxRtKLFAkX2MuLO2n+i8cpzebh1utuINIdn5QdndGaqf4pHyd7+oWRjT
 XM/lJYmx6wbx+xPPmCdWX1PwqIAK1eG48rBs+h4qOVX1TkHspUjTXbHjrpv3ktgUbCHA
 zZTypc1BqdZb5GMBVRk7OREb/bd17A36tbkcDgwwfLLdVzOh+iWMEyMmI5SmBcMxsfva
 x1pmiu8QTWb9/zXX4eI8vzA+yFELcumz2cc9UZcvYcACHI4AEsivaJaV9+N3rs4xIpC9
 2GcdyYCEA75jcBRssBMmgUAEe+7QfebSn/EZnx4fdZ9sGgIf8gj/B2nJlk9qqtPOfKLX
 Lg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798218; x=1737403018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8lF9ZX3ePxEP+Ja3OcSq5ETj9a2lfeHBgYz0T+6A3ww=;
 b=a5tNi4MbwmkalUynkn8/UhyTsv9DUeqSLRLNlPNBMKsJMwF+LSWuSzDgYG9Bo0HxS/
 /CNw1dDwv+gQMpa83+OdBqalFdyHhjEBKQoH/Y3ffOhka8KSEO3TXhjx0Z8q/SPnuxii
 8St9OFjD292Mo5hrCOyFc1JV+3g+vhsoen5EHwarIEn0lWB4fUOW+Y6OGxbMek5WxRyI
 luSyFENQRLoi2reB7waMJ9Yce0S0QUCIQW82yWaQae19h4FOjHyIR5ijiZiBAfWvPjhN
 d0RMR3Aza1RemDAmOFTg7gA/+iyPOPoqLcCAFMphhPzLLaK7GRckfEN1lCtQeHX4Bb8m
 KyhA==
X-Gm-Message-State: AOJu0Yy3F/pRgONZ2pi7ITP8gfBpMuMoNb/HwujkdbK9EfJUxwj3ckFc
 M3tTlZyhYkSoPLaFEOEd+tbgGIiVudcUfZ4J+zjCJ1LwaUTiOuJ+m5xvQxmTZvNYodCGfDHBcKO
 Axqo=
X-Gm-Gg: ASbGncuaVeyMYsdjN6J2r/25eoPfRW+iYaxzpV7Y6b1L20kLOoIqVosy1wccW22HXgL
 ONj4zs1Zjm6bWIhtES3XRc9ZCqEeUlqFgOND0AOSQvIGsd5Z7XoNIJOnMzj2uZGJXdt9LCv0b+l
 w+JkmUEHNObRLG6Dt7S3b+RagXqRVy/YnM2v0qTBA3HqZqSp0SzDfmJfBeFyrmBMZWMTfUAJQ2F
 YoNKeSFSKGQp5hnf9Mws99JmhjLZaaYE6YMu6yABPomqizYGf3YQ9PbJ3XQUlh3+CyZ5z9zhmeH
 7LeVsxJilbIKlTYy3fTlAV5YlcDPAM0=
X-Google-Smtp-Source: AGHT+IG17ULvwdMlxCAA2RAsl2iu3HvUY2KU5QRylnKWJolEfGIArgWXAkCp6U/Za/dR1THXGQ1e5Q==
X-Received: by 2002:a05:6000:1561:b0:38b:d765:7027 with SMTP id
 ffacd0b85a97d-38bd7657304mr6340960f8f.41.1736798218246; 
 Mon, 13 Jan 2025 11:56:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2df2faesm188925685e9.26.2025.01.13.11.56.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 18/19] hw/mips/bootloader: Propagate CPU env to
 bootcpu_supports_isa()
Date: Mon, 13 Jan 2025 20:55:24 +0100
Message-ID: <20250113195525.57150-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
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
 hw/mips/bootloader.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index a54af8160ef..f02e5aabe48 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -49,7 +49,7 @@ typedef enum bl_reg {
     BL_REG_RA = 31,
 } bl_reg;
 
-static bool bootcpu_supports_isa(uint64_t isa_mask)
+static bool bootcpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask)
 {
     return cpu_supports_isa(&MIPS_CPU(first_cpu)->env, isa_mask);
 }
@@ -69,7 +69,7 @@ static void st_nm32_p(void **ptr, uint32_t insn)
 /* Base types */
 static void bl_gen_nop(const CPUMIPSState *env, void **ptr)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         st_nm32_p(ptr, 0x8000c000);
     } else {
         uint32_t *p = *ptr;
@@ -121,7 +121,7 @@ static void bl_gen_i_type(void **ptr, uint8_t opcode,
 static void bl_gen_dsll(const CPUMIPSState *env, void **p,
                         bl_reg rd, bl_reg rt, uint8_t sa)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_r_type(p, 0, 0, rt, rd, sa, 0x38);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -130,7 +130,7 @@ static void bl_gen_dsll(const CPUMIPSState *env, void **p,
 
 static void bl_gen_jalr(const CPUMIPSState *env, void **p, bl_reg rs)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         uint32_t insn = 0;
 
         insn = deposit32(insn, 26, 6, 0b010010); /* JALRC */
@@ -198,7 +198,7 @@ static void bl_gen_sw_nm(void **ptr, bl_reg rt, uint8_t rs, uint16_t ofs12)
 static void bl_gen_sw(const CPUMIPSState *env, void **p,
                       bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         bl_gen_sw_nm(p, rt, base, offset);
     } else {
         bl_gen_i_type(p, 0x2b, base, rt, offset);
@@ -208,7 +208,7 @@ static void bl_gen_sw(const CPUMIPSState *env, void **p,
 static void bl_gen_sd(const CPUMIPSState *env, void **p,
                       bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_i_type(p, 0x3f, base, rt, offset);
     } else {
         g_assert_not_reached(); /* unsupported */
@@ -219,7 +219,7 @@ static void bl_gen_sd(const CPUMIPSState *env, void **p,
 static void bl_gen_li(const CPUMIPSState *env, void **p,
                       bl_reg rt, uint32_t imm)
 {
-    if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         bl_gen_lui_nm(p, rt, extract32(imm, 12, 20));
         bl_gen_ori_nm(p, rt, rt, extract32(imm, 0, 12));
     } else {
@@ -241,7 +241,7 @@ static void bl_gen_dli(const CPUMIPSState *env, void **p,
 static void bl_gen_load_ulong(const CPUMIPSState *env, void **p,
                               bl_reg rt, target_ulong imm)
 {
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_dli(env, p, rt, imm); /* 64bit */
     } else {
         bl_gen_li(env, p, rt, imm); /* 32bit */
@@ -294,7 +294,7 @@ void bl_gen_write_ulong(const MIPSCPU *cpu, void **p,
 
     bl_gen_load_ulong(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
-    if (bootcpu_supports_isa(ISA_MIPS3)) {
+    if (bootcpu_supports_isa(env, ISA_MIPS3)) {
         bl_gen_sd(env, p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
         bl_gen_sw(env, p, BL_REG_K0, BL_REG_K1, 0x0);
-- 
2.47.1


