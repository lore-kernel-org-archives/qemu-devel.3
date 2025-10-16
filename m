Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B305ECCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mzf-0006o7-RS; Thu, 16 Oct 2025 08:22:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MyB-0004xf-E5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:38 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mxv-0000Mw-V5
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:20:34 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3f2cf786abeso621758f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760617208; x=1761222008; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=efjfUDxda0bLG+Gip7aM7BOQIHWdvXM7weuV/MMKUWY=;
 b=VmcgpEZeU0XTjiqcqY2dhccCNcn43aHuer2q4ly1JpB6/vKuCxbkvAwROLxucuZwFz
 0Fuioo7MVxzGY/ROrGCDN0rb9Ss/k2/RHk+hOvQIihZ3LgIqAD49m+fhD/cFYz1fXbK/
 fU8fto4sJg9tyY9KFfyDvVeRi1gqKD4smBWar7sea6eKaxii1Z8kNwKCiNgAGODk2Vfu
 CQx1qcRnXTAp5erMg6ghPEzMNEmCIRkSH2S44fM9S5qqMN74rM5qIP1TEhoqk9PpH4qK
 8l+0Fi/zmEKrCXjYwcT1FfDex/ViGrmDjQlVaXgbZDPu3H5+NAEK1/hyP26XNjKKXHlK
 VaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760617208; x=1761222008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=efjfUDxda0bLG+Gip7aM7BOQIHWdvXM7weuV/MMKUWY=;
 b=p4uLaAgFZ/8s5Um+Jljp/0MM06qA1IHCyOdFyXy+HuHTkmDsA6EXTK+h7/gHzdLf7L
 Kf0/L68PpaAPvPBiLSzy+trcYuATIV2bJKc9l8OZuP45+F4SnGqQp5b5+Hf5XP7yI1q1
 ela1dJNABgVl74TZHpIeISiW4nFgmgWdged4v9pO132+oB2i4f3MrODFcHxjq0xYnuMT
 gWeWP3GHm7P0Zbq0VKOwzifENIjhdM5J/+cGuq0Qsn3HFTR9l0p9An98jx1LmPOMNDkc
 4wXzSxyc16/9pdsKY4rZYGBybJVpyRRRaf+fYN7iYivZJuxFgSTf+hV5u24Vbx01NVhb
 7+jg==
X-Gm-Message-State: AOJu0YxwzMXHWHh4CkpdH/j+icHKJTJMLPfu/U0S40bODWppAivegTYO
 KQaaT0IyaSUkuFvjvlud6SHFuuib2UK+Zw3n6HhGc0mp9pjTWdwi7+YbCjgRASXJzL6FjxRM7tx
 oZr4CGIM=
X-Gm-Gg: ASbGncvjq10b0cFmKtbI1B1sgUCgz6cWwC59Qd8/sRRXVBqu5nzRZYQKYhDoVpmOswg
 tm2NFC8mNPkFuxwAwwgEepMS/KzKfWDASP+q4nLHAtd+lqXUmo+vLjD6OyoZc9IzHM58O18VNSV
 0bwjZTxqkeNkGsm8fZS7Dw/VCCnsXvHCsP7H62WbDZFu9pgyhRg4w6ECTEP4sfLA4mHNunhvsHw
 zaJ06wWUTfNVIyd+O5JxHAudo2PSk18agu2Zp06mGEx7/EcSNLHsOofTygT/aDGWijVQO3JAsQp
 OMaStpGTKG5Pzr081BNh/iwsI2uGehgucjYQaBHmZ/U80eycdj4oKw7S+rjqPD/RDmRQiy1+7nj
 Lu9tLGFAAbPSIzNC3RjCSTUxUndzH1x6wPArwB/Ne//Sg7Y7+JxYzKlskjAsQnruNG+PbExLITk
 AuXQoiTrD/JGetRFv3gDcwNW32KACgV59oI8luZzwEK5TV5ifi8E/x9A==
X-Google-Smtp-Source: AGHT+IFyI/Mn79utkKMxhjfmGeZ2nUxD2I+UwvCCFzfzURg9GB4fx5ZEfGx2OxlVoXk1QxdnZyG8YQ==
X-Received: by 2002:a05:6000:2203:b0:3d6:212b:9ae2 with SMTP id
 ffacd0b85a97d-4266e8e91b6mr22410615f8f.63.1760617208106; 
 Thu, 16 Oct 2025 05:20:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57ccb1sm33916901f8f.8.2025.10.16.05.20.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:20:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 59/75] target/tricore: Remove target_ulong use in gen_goto_tb()
Date: Thu, 16 Oct 2025 14:15:15 +0200
Message-ID: <20251016121532.14042-60-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

translator_use_goto_tb() expects a vaddr type since commit
b1c09220b4c ("accel/tcg: Replace target_ulong with vaddr in
translator_*()").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251010052141.42460-2-philmd@linaro.org>
---
 target/tricore/translate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 7c6e3095971..dd09f0651f5 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -72,7 +72,8 @@ static const char *regnames_d[] = {
 
 typedef struct DisasContext {
     DisasContextBase base;
-    target_ulong pc_succ_insn;
+
+    vaddr pc_succ_insn;
     uint32_t opcode;
     /* Routine used to access memory */
     int mem_idx;
@@ -2811,13 +2812,12 @@ static void gen_calc_usb_mulr_h(TCGv arg)
 
 /* helpers for generating program flow micro-ops */
 
-static inline void gen_save_pc(target_ulong pc)
+static inline void gen_save_pc(vaddr pc)
 {
     tcg_gen_movi_tl(cpu_PC, pc);
 }
 
-static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index,
-                        target_ulong dest)
+static void gen_goto_tb(DisasContext *ctx, unsigned tb_slot_index, vaddr dest)
 {
     if (translator_use_goto_tb(&ctx->base, dest)) {
         tcg_gen_goto_tb(tb_slot_index);
-- 
2.51.0


