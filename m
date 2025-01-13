Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779E2E7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 00:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX8dP-0004ha-81; Sun, 12 Jan 2025 19:48:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dG-0004av-PJ
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:44 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX8dF-0000lL-96
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 19:48:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so43334625e9.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 16:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736729318; x=1737334118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6Clg/N9h/uY9sG75mKmNN87S01issR08U/shM6098E=;
 b=qHxs/dOedUTiTcJjNhREer6+S0x0TK0losO7ZyryVYbJWM8EMQWvNIDRZ0Aa0N89fp
 TJIqv0n1V6av+YmSeaiHJeV7CA7Yb8Kdt+PES4XkWxHSokAqsPVkk2kA/UmkkdQKCZyH
 CZ1RO6GLP68vTB+orxbcXGwQDHF4lpzI2ohEn10cuQoucGG7gdMVLKq7vZeXcC2ZBaTs
 1W03CiwieIuHbB7oXJgWFoprqIQW042CiDhQLc9bwB243yY+YDFvjtZdZGyUN0QZObQG
 Jna4AXFDhXGocJafgWTsA0udv9Kp6ZWA2Nd0kJit5US9NwCpWma0CWbLRvW6hu6krWB5
 1vpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736729318; x=1737334118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v6Clg/N9h/uY9sG75mKmNN87S01issR08U/shM6098E=;
 b=BvZT9z1sysUb5a4oBUGvBv5W7/bu3rreLVhDCd5ujXK/dDXq4VXhnNOhg1byNZK9JL
 dBkeK8Z+yUi/tcKikC2T8xHqqyZ1efXS1nw2Ld+auogne2//7eifteMg2DyxJjGXfjyF
 ZJHRDYDbODo/PHZOi7pmVjCD9nOLBwob0BiMCpaVj0884Ynn9MVe2d0dYEe9yfNyZiVA
 Urj0ji4SuPkayefTurp2LQs9EmzIeSV35TRIgGhnh9ly8VCPLrXALsa/fXPwI4xThzFu
 wNmQ84WhU9KT1zD070CswC1yIe1Rfu4fPkfRu13nuudjI4lG9TWyUrvHNBxQmr2hSX0K
 mU6g==
X-Gm-Message-State: AOJu0YwQFhpoRkLYy56Qwb+QErnOAUxMBvyshn6O6p55IVGHr3nKA/aV
 ravQOJZLpDSseaUD/QiM61fccm9a7HL1uwf2Z1CK3CJfmkOg+ayx0iCjkoSNUmO0YphBgisDDHy
 PlJQ=
X-Gm-Gg: ASbGnctDIs7CJ72it3VizKvAdlDe3Q+wMDyyPBPGbDTq24Kqh6N7+nc5zwk/t7b0Mhj
 WKms/uJT8LvAbZ0iRoNWuHqe4oWp+jT6PKG/BUo6govcgrRW0teZP90A+0GH+E8xaD6WVJ0oEz8
 JCsllRbV5zY6vyGa3E3LdCjIvd1z83JwZRmW/8LooFh2r8AG5Zs48G1SfjqODl3eZ85iMUqYxxu
 WOjCx2uNkioGpCide99HtZCr7SRSLwu6M5dg3FrFzGPY/4SiYF2zOwc5BfnZJx/WhC707SW0wjc
 rYr0sYPJvDigkBz6AMtSXKmDrOnw3OI=
X-Google-Smtp-Source: AGHT+IFfdVdQKpy0TwgzJRor6r4TqD7hz9G3DdJgVD0QXxOYq2yx6VaexUrCBHDyYO9tY/nGybpywQ==
X-Received: by 2002:a05:6000:1f81:b0:386:7fe:af8e with SMTP id
 ffacd0b85a97d-38a872fb17fmr14396971f8f.12.1736729318623; 
 Sun, 12 Jan 2025 16:48:38 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d26a7bsm130244375e9.0.2025.01.12.16.48.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 16:48:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>,
 Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 08/23] hw/mips/bootloader: Propagate CPU env to bl_gen_sw()
Date: Mon, 13 Jan 2025 01:47:33 +0100
Message-ID: <20250113004748.41658-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113004748.41658-1-philmd@linaro.org>
References: <20250113004748.41658-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
declared bl_gen_sw() function.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index 9f35b23653a..30e6422d331 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -195,9 +195,10 @@ static void bl_gen_sw_nm(void **ptr, bl_reg rt, uint8_t rs, uint16_t ofs12)
     st_nm32_p(ptr, insn);
 }
 
-static void bl_gen_sw(void **p, bl_reg rt, uint8_t base, uint16_t offset)
+static void bl_gen_sw(const CPUMIPSState *env, void **p,
+                      bl_reg rt, uint8_t base, uint16_t offset)
 {
-    if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_NANOMIPS32)) {
+    if (bootcpu_supports_isa(env, ISA_NANOMIPS32)) {
         bl_gen_sw_nm(p, rt, base, offset);
     } else {
         bl_gen_i_type(p, 0x2b, base, rt, offset);
@@ -285,7 +286,7 @@ void bl_gen_write_ulong(void **p, target_ulong addr, target_ulong val)
     if (bootcpu_supports_isa(&MIPS_CPU(first_cpu)->env, ISA_MIPS3)) {
         bl_gen_sd(p, BL_REG_K0, BL_REG_K1, 0x0);
     } else {
-        bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
+        bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
     }
 }
 
@@ -293,7 +294,7 @@ void bl_gen_write_u32(void **p, target_ulong addr, uint32_t val)
 {
     bl_gen_li(p, BL_REG_K0, val);
     bl_gen_load_ulong(p, BL_REG_K1, addr);
-    bl_gen_sw(p, BL_REG_K0, BL_REG_K1, 0x0);
+    bl_gen_sw(&MIPS_CPU(first_cpu)->env, p, BL_REG_K0, BL_REG_K1, 0x0);
 }
 
 void bl_gen_write_u64(void **p, target_ulong addr, uint64_t val)
-- 
2.47.1


