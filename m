Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97214C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:10:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLJb-00045G-DM; Sat, 02 Aug 2025 19:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJY-0003su-Ec
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:57 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLJW-0001CI-Ot
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:06:56 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2ffa8e58654so1963290fac.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176013; x=1754780813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RixljIz+HOjrys5KmnaZU9bK0ysdxVWlZPGtRGwn11E=;
 b=aCePg2QdHgJB+gmHlW2MaZnyAs/4UV3IoQI7IE9C1SOD2/hVjtpZj3PVlIaablTF1e
 xRhk8eI2tvvc0u3xD0y6tHXb6SEgAyCiZTLAyLFZTMHH30A/DnkB8WenkrQZ0TEGeC4r
 i2N3ER9nUPMKbDzW7NhottLYPIbBqKBYP3KfffbewZZT/is0CTPRSDHrIqDxkyhJiaGT
 XymDPPg/en99mmsT0MPxlLiE0hhZz8LK/EwhkRPKeR6TRprKfydJdmdb3lkMGhiXVHEc
 SdUF7FiFDmBMBKhZ2tTY515qJPwI748a3oPaD53MmZbA6Ig44ZSvSZdtSmYtTwfJ7hjB
 yHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176013; x=1754780813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RixljIz+HOjrys5KmnaZU9bK0ysdxVWlZPGtRGwn11E=;
 b=aw2/vlUjiqB6vQZVfZV6lMtLk4x1eA4aSHa0moBQal++NysymJioOs+2Ntr+Ga0Ism
 +O1AGCl/HP+S0JrMDud7W4ILFfiCHzkmpj8SilXokIHfWbmf50Alqk7TY8z7bpmJEYPn
 XaKJU5v04RiID6m2xCD6uj3wLiv+kMVhJtJIJN+EW/wVvX6nrikpauBaG9tLISKsXqzw
 je5pgPCfpFiT7I84i4A7wFqoGSKYqQhCabMzbWWfhH+I2ngYR5y84jAgjdwCjCi8vDn/
 y0gQXWWNjhO1KWxyRaRwWkbJ3HKRYTpbSjWLA3xJZPXxnvAToVw3F3j90FFg1VJbiGti
 DKVQ==
X-Gm-Message-State: AOJu0Yx1gZt9imdNUxy3HYJJeCA94lY5N/vRJI4U8NLCn0gebRgAua7/
 w3BgkIUzhA8KKX2nfr25YaI5kF/08qkcQtMBLtrcYRPUbTiaLIJ64wcYtBGl89iVbSHYVy+o4PP
 G2qbyOJQ=
X-Gm-Gg: ASbGncu9HDU44iJdjtHB0+OmWBY+XM1h+hUzIvBLJv0Ez5k4fGBVEy5S98Qi89s5ARC
 NlbPPSLv18JYgiY/FwRAM0JWg+QPXC+cY383QkpogCv/UkcqCBInWZuuy6vUKHXixcN3pnu9VY7
 pN76mZNqBwTw8d0cMuAnqTlcerGxmVeZpJ9x7rKJ6Ulq+YinDX96qqSldG9b6AcAVtpBF9CPiKy
 LRjI9iRjnv3xL7Mzp0odvZzIFFQVheBSNH1mwN+FM3UdO4340trBelLKHBixtSBlhxNWsPqcWxX
 lndjgD7YJrJqB4qxqyJMPxljBta2Q/NzdAss0Wg1JuwNEZN8NQD2B7wgmsBlJMlgV5XUgrm213R
 XWt05rVVMWeeeSf0vNPZYjZMtPn/zsHHnJu3wnTfJFigsSb2BXyo9yE2n/IJ6vuQ=
X-Google-Smtp-Source: AGHT+IEXEFWGlyDnJQT6JXvs/UPX8g/R9DvQVV91kvrw/pnNWvY+h02eI6y06r2IBl7rPP8gvtzIkQ==
X-Received: by 2002:a05:6820:1e84:b0:619:a34b:3e25 with SMTP id
 006d021491bc7-619a34b4276mr756272eaf.6.1754176013308; 
 Sat, 02 Aug 2025 16:06:53 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693b48sm1093401eaf.19.2025.08.02.16.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:06:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 29/95] linux-user/aarch64: Create init_main_thread
Date: Sun,  3 Aug 2025 09:03:53 +1000
Message-ID: <20250802230459.412251-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Merge init_thread and target_cpu_copy_regs.
There's no point going through a target_pt_regs intermediate.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/cpu_loop.c | 14 ++++++--------
 linux-user/elfload.c          | 10 +---------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/linux-user/aarch64/cpu_loop.c b/linux-user/aarch64/cpu_loop.c
index 030a630c93..4c4921152e 100644
--- a/linux-user/aarch64/cpu_loop.c
+++ b/linux-user/aarch64/cpu_loop.c
@@ -137,10 +137,10 @@ void cpu_loop(CPUARMState *env)
     }
 }
 
-void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
+void init_main_thread(CPUState *cs, struct image_info *info)
 {
+    CPUARMState *env = cpu_env(cs);
     ARMCPU *cpu = env_archcpu(env);
-    int i;
 
     if (!(arm_feature(env, ARM_FEATURE_AARCH64))) {
         fprintf(stderr,
@@ -148,14 +148,12 @@ void target_cpu_copy_regs(CPUArchState *env, target_pt_regs *regs)
         exit(EXIT_FAILURE);
     }
 
-    for (i = 0; i < 31; i++) {
-        env->xregs[i] = regs->regs[i];
-    }
-    env->pc = regs->pc;
-    env->xregs[31] = regs->sp;
+    env->pc = info->entry & ~0x3ULL;
+    env->xregs[31] = info->start_stack;
+
 #if TARGET_BIG_ENDIAN
     env->cp15.sctlr_el[1] |= SCTLR_E0E;
-    for (i = 1; i < 4; ++i) {
+    for (int i = 1; i < 4; ++i) {
         env->cp15.sctlr_el[i] |= SCTLR_EE;
     }
     arm_rebuild_hflags(env);
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 9586873954..f93afbdcea 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -395,15 +395,7 @@ static const VdsoImageInfo *vdso_image_info(uint32_t elf_flags)
 #define ELF_ARCH        EM_AARCH64
 #define ELF_CLASS       ELFCLASS64
 
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    abi_long stack = infop->start_stack;
-    memset(regs, 0, sizeof(*regs));
-
-    regs->pc = infop->entry & ~0x3ULL;
-    regs->sp = stack;
-}
+#define HAVE_INIT_MAIN_THREAD
 
 #define ELF_NREG    34
 typedef target_elf_greg_t  target_elf_gregset_t[ELF_NREG];
-- 
2.43.0


