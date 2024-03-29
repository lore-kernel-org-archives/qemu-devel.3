Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D59DCCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKlD-0002b4-Nq; Fri, 29 Mar 2024 18:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKky-0002Xd-Vf
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:29 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkx-0003WG-Ek
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:28 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-5d3912c9a83so1389060a12.3
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751486; x=1712356286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejHwqcq7dcii+cbZ+/7NcB0t83Y0TWbs/BL3Pfvrwv8=;
 b=NY67hsNfLI40yG49X5YV8qvr0STHr/wUqWQTwGCwpEv58Pwm/Xu3K/aYofgq9vjhAt
 PsEjSr96vQCVM2CYQHkEs0X1HtzEQHUnxwtkh+pkGzVSt/KfZ1CZCteks74MLCn4Pj85
 wxJnWVgzqR68mwCT/YrKU+6j1riOfQxnYIsAHAJ3fyxOCW0L8Kl/Ncou2bC5JUzI9SAn
 AcvziNVG1ieHyetJY/ZmERBFUjjIRFmlV96JeBiU7tVw3U0j1RWpM/7FiJG0hhDvWDev
 jAzIVq4nDqUBCLvueHDLeo0pOOdtSoVUzf5ts8VfPI4o4Tw0ScJY50qxxj+Dt5NdnzcK
 Opyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751486; x=1712356286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejHwqcq7dcii+cbZ+/7NcB0t83Y0TWbs/BL3Pfvrwv8=;
 b=FQSPDTbv14wm1TYcVf39Z9LkQtXe3fPrmsx4efYX3LhKmHykMf2m5AA2ewdTQ9IdTT
 MLHGyqkKnVueFSvtOhm+tuNxP0m+Ks08NZ3CVbg6EB3D1BYdyNBjg9h3w8YQ8IF4wzlI
 Ci21KjaJ9WlcIg9fYOM47m3+ctZJoK2XmhnQZN77WbYUkmloyfiBETAOlTotl2Cwj68C
 y5znbkKVymaSJGb6dsHwNrP5upEfuK4VRsd/zZ62qZqYBQXWCVrivYRAuIlQce0V/Boj
 UPVseuczpst8iHwuF+vq7qgRr2XCWziwxbtpFCpOFN377IAuxDRGoCTWgja2XFEHECQg
 4I8g==
X-Gm-Message-State: AOJu0YzrdO7hhxPsWSvu2J38t511sxeQjbUjAWO/wnwCwCZ+OekdksiM
 VtUpT0/ZEeSeKpmM1MMzpHTmg/ieGNM8eqqhc6mVn6VjHakXNjZdQQriLHCZWZfbqgBJ/WdpDaI
 T
X-Google-Smtp-Source: AGHT+IHhwo9S/Drdqgzvf4LqVDOO+EpW7ilYiNT2s9f6yhdZk2QnrInJRnNzjES5b+NUvRdAa100KQ==
X-Received: by 2002:a17:902:e789:b0:1e2:408c:776f with SMTP id
 cp9-20020a170902e78900b001e2408c776fmr935276plb.0.1711751485860; 
 Fri, 29 Mar 2024 15:31:25 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>,
	Helge Deller <deller@gmx.de>
Subject: [PULL 08/18] target/hppa: Use gva_offset_mask() everywhere
Date: Fri, 29 Mar 2024 12:31:01 -1000
Message-Id: <20240329223111.1735826-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Move it to cpu.h, so it can also be used in hppa_form_gva_psw().

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240324080945.991100-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/cpu.h       | 10 ++++++++--
 target/hppa/translate.c | 12 +++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index a92dc352cb..a072d0bb63 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -285,14 +285,20 @@ void hppa_translate_init(void);
 
 #define CPU_RESOLVING_TYPE TYPE_HPPA_CPU
 
+static inline uint64_t gva_offset_mask(target_ulong psw)
+{
+    return (psw & PSW_W
+            ? MAKE_64BIT_MASK(0, 62)
+            : MAKE_64BIT_MASK(0, 32));
+}
+
 static inline target_ulong hppa_form_gva_psw(target_ulong psw, uint64_t spc,
                                              target_ulong off)
 {
 #ifdef CONFIG_USER_ONLY
     return off;
 #else
-    off &= psw & PSW_W ? MAKE_64BIT_MASK(0, 62) : MAKE_64BIT_MASK(0, 32);
-    return spc | off;
+    return spc | (off & gva_offset_mask(psw));
 #endif
 }
 
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 46b2d6508d..e041310207 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -586,17 +586,10 @@ static bool nullify_end(DisasContext *ctx)
     return true;
 }
 
-static uint64_t gva_offset_mask(DisasContext *ctx)
-{
-    return (ctx->tb_flags & PSW_W
-            ? MAKE_64BIT_MASK(0, 62)
-            : MAKE_64BIT_MASK(0, 32));
-}
-
 static void copy_iaoq_entry(DisasContext *ctx, TCGv_i64 dest,
                             uint64_t ival, TCGv_i64 vval)
 {
-    uint64_t mask = gva_offset_mask(ctx);
+    uint64_t mask = gva_offset_mask(ctx->tb_flags);
 
     if (ival != -1) {
         tcg_gen_movi_i64(dest, ival & mask);
@@ -1430,7 +1423,8 @@ static void form_gva(DisasContext *ctx, TCGv_i64 *pgva, TCGv_i64 *pofs,
 
     *pofs = ofs;
     *pgva = addr = tcg_temp_new_i64();
-    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base, gva_offset_mask(ctx));
+    tcg_gen_andi_i64(addr, modify <= 0 ? ofs : base,
+                     gva_offset_mask(ctx->tb_flags));
 #ifndef CONFIG_USER_ONLY
     if (!is_phys) {
         tcg_gen_or_i64(addr, addr, space_select(ctx, sp, base));
-- 
2.34.1


