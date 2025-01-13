Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570BC02183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYY-0007Et-Nk; Mon, 13 Jan 2025 14:57:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYB-0006QO-Ru
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:42 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQY6-0007VJ-O2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:56:36 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361c705434so33966945e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798193; x=1737402993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4DRhbEjhewGcR2ayXK2M7BVOLt5ToixmH52KcERFSA=;
 b=iZwJJDtsVzzY1FO5UJcCZE4L7WSqsZaum/Ox+Dw8YlejzC7nzx3gYgcYcKgZOJZNLZ
 VQZ3h4YkuvD1S5JA3z9Wcv71chU40tmO39AaEzUE0sqXJyAWS3er9jtEUFCo9RmN19gG
 ANimFVxESzlxsg8DII1c5Yt8T19BBFVhy/ObSwij9ZZB9snomVrW2NsLOypXB2C7XM2I
 81iaXX6sIe8HtKKotsQ9iccc9ztjTGA8jmf+dNJqAaxfaIZw8B6kvNMucyPZbxLXPUoU
 +x6nZE3cpAdtq2slzYPFEOw7TdStKu7pRxYEnMGI2PVsUe5zfHJgVLcUwNcGNSYzVVNa
 NMCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798193; x=1737402993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z4DRhbEjhewGcR2ayXK2M7BVOLt5ToixmH52KcERFSA=;
 b=JdNJ2jJFR3XVA0bIQo2fuFn2KcYzl4VCG5QSemi4j1c3oCogTja4bZT3LDYJ+3e/WE
 rsx2Bpp3B6QzXIG1e7iehDVsBspnd+wkwJX6EmyOF1qj9NIkJ3KSEFo2Bk+t5soLYnb0
 NuJSIH08ds4ejMluQOKdxxYMRRNS2Pe0PVT4xkE5yo52P/bRaE1ig2PWQdRmmZAHWIHq
 HHeRp/4xT3Is32cIkrTdoVcXM41OnQImEs5A79uziJTYlwCjcEFkbicGnUqqKy4w9P1x
 IPFDOpjkrCO/e4Mdrwq9Ua3Vi2zfvFKD26MtVBxjdhUkoL47uRWJ4jpyXnUd+Ijg0+z/
 GDTw==
X-Gm-Message-State: AOJu0Yx5AAkGxilVsFv084XY21MtGZ2tUK5mzYVZJJ1Wc2KfciNdnLHJ
 FGFKbm/DCJsL6Dae2WYlAEcgz6GT6MdKHVViBD0j60UWptYExHNC94+XNUhLxLDc87YTfbwJcRk
 kFCk=
X-Gm-Gg: ASbGncs8/Qv/gwxBHt9hhjadrg1ZfVRIdxfU9BFgP+OX0RnXwMiiD6Io3Tz5du+kavt
 ITnEveYR13Oj23a4VTLwXfz47PCiBgBusfJQyNGp80C/uUMxjnngaDemEmY/iLas6oYvH1om5NJ
 yGhEUaZC0cahGDW35qWj6ItsIQqmenG79wkxsjD07eQb3hupGZyopxnclQVGXAbA8AJXE+ObmQw
 SqfeQ+lISKaJlruOZ9Ow/RAQZga2CFIGwc4j5yM/OWBQW6DfUjr7u2DruaQVPXmf9BUtKS1WV8k
 2NF/hCxpG1sVbGCPdQcBIFjFXbOl1l8=
X-Google-Smtp-Source: AGHT+IG3PfSbxVEpDMsIm/TdQgLMgWcLI5R3Hp1p0hReST+TYZPsF8/bkkQu5LO7AGqie0UDBDwjCg==
X-Received: by 2002:a05:600c:3b2a:b0:434:f623:9ff3 with SMTP id
 5b1f17b1804b1-436e26a8c3cmr215032275e9.15.1736798192927; 
 Mon, 13 Jan 2025 11:56:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2ddcb5bsm190228695e9.23.2025.01.13.11.56.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:56:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 13/19] hw/mips/bootloader: Propagate CPU env to
 bl_gen_[d]li()
Date: Mon, 13 Jan 2025 20:55:19 +0100
Message-ID: <20250113195525.57150-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
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

Propagate the target specific CPU env to the locally
declared bl_gen_li() and bl_gen_dli() functions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 198506431c5..464ed5f4f1a 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -213,7 +213,8 @@ static void bl_gen_sd(void **p, bl_reg rt, uint8_t base, uint16_t offset)
 }
 
 /* Pseudo instructions */
-static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
+static void bl_gen_li(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint32_t imm)
 {
     if (bootcpu_supports_isa(ISA_NANOMIPS32)) {
         bl_gen_lui_nm(p, rt, extract32(imm, 12, 20));
@@ -224,9 +225,10 @@ static void bl_gen_li(void **p, bl_reg rt, uint32_t imm)
     }
 }
 
-static void bl_gen_dli(void **p, bl_reg rt, uint64_t imm)
+static void bl_gen_dli(const CPUMIPSState *env, void **p,
+                       bl_reg rt, uint64_t imm)
 {
-    bl_gen_li(p, rt, extract64(imm, 32, 32));
+    bl_gen_li(env, p, rt, extract64(imm, 32, 32));
     bl_gen_dsll(p, rt, rt, 16);
     bl_gen_ori(p, rt, rt, extract64(imm, 16, 16));
     bl_gen_dsll(p, rt, rt, 16);
@@ -237,9 +239,9 @@ static void bl_gen_load_ulong(const CPUMIPSState *env, void **p,
                               bl_reg rt, target_ulong imm)
 {
     if (bootcpu_supports_isa(ISA_MIPS3)) {
-        bl_gen_dli(p, rt, imm); /* 64bit */
+        bl_gen_dli(env, p, rt, imm); /* 64bit */
     } else {
-        bl_gen_li(p, rt, imm); /* 32bit */
+        bl_gen_li(env, p, rt, imm); /* 32bit */
     }
 }
 
@@ -301,7 +303,7 @@ void bl_gen_write_u32(const MIPSCPU *cpu, void **p,
 {
     const CPUMIPSState *env = &cpu->env;
 
-    bl_gen_li(p, BL_REG_K0, val);
+    bl_gen_li(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
 }
@@ -311,7 +313,7 @@ void bl_gen_write_u64(const MIPSCPU *cpu, void **p,
 {
     const CPUMIPSState *env = &cpu->env;
 
-    bl_gen_dli(p, BL_REG_K0, val);
+    bl_gen_dli(env, p, BL_REG_K0, val);
     bl_gen_load_ulong(env, p, BL_REG_K1, addr);
     bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
 }
-- 
2.47.1


