Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476EDD148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibu-0005WC-A6; Thu, 08 Jan 2026 00:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibr-0005LM-L1
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:59 -0500
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibq-0005OU-0l
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:59 -0500
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-c1e4a9033abso1602523a12.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850257; x=1768455057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TukGEmMKpnvEasDlzBdFYNNO3/Mmmb//jnacHIC6uLY=;
 b=c2jcuIXxELAae7BmWUCViN8+1PUpg5PrAoc72kaWbUS83PQNjb44+KS5BPFgn34J+S
 Hfsir/k2AA9xxtfiVARd+5lPzYXHxh6VJ5iGTVrQoSpM+0qftA9gLfWyVMgjPzREXRc5
 KCtw7/Zez8hgTKtNMaaASwA01+jLFuxJqmDwwM27pI0naMB1UI1X7TBx7+LjNk8SeIZt
 K7txSp93jRZtre6R3GCbUdoFh+5aSsgRa1tPeEf/ruT6jjPx7OY5xPuis/wIy99Ak2m2
 6HIjcMDdHqEj5Bdwms+cfzvVkw3pzz0gQAoDnLV1adyPukfvMvLcjMaZRc7/x0trL7nW
 efUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850257; x=1768455057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TukGEmMKpnvEasDlzBdFYNNO3/Mmmb//jnacHIC6uLY=;
 b=MbH6Xp1ifvCafkSIEw3z5MDjHASh+f2iMVudGwigR4BbN/ik335BxTRMSYmWEqOth3
 jiXYklXlePDLLae8UtjQM/1KFdXYzAL+BKONGppZD3/67QmsL4P1JFy+8OvXOEC1Q+v3
 7UmbX9H+Pycg6KT2adNMT2GF0WeRFsK7nNjlx24daZTOp38TztWFdIDQ8iEWpCpWazNo
 TSIh8Saz9sgtn52gyscKqx9Yka+kyNQSpg/oRCmNbeBvVrDpBe03Z/mDB6zGrD69szQk
 R1hkQ9DOfOMOZ4SvDOFJhmET7v5RAhZAkBHpo4B2+o81K5VP25dsA0lIsiifVuW9yhqm
 5pzQ==
X-Gm-Message-State: AOJu0YxBswCwAQ39gqzRMY6QzqcLsgrMkwqxhsczagAZsMRC7azGIsbo
 gC9t3VuG3ojo55Ddj5rvbMAkj0Dhd3JBPyQmwpatWUz0fuCXMiDydylIzQbeJgbDxc1j4X85y9Q
 eifCZ5ng=
X-Gm-Gg: AY/fxX40NI3VQJSr2UI/y5TijD/cpHg4btfpgeLTeOZnOdToQBQHHPpCenMto2yWmNw
 ybWFGn50oUQEvGjFBdMo3T0wp9uUmvSLcaG2R9raVEFEC+Dw9SKP/83RgFoS+IcS7eNE4aR5Y/O
 d/2vXXUb01GdMgXxrQtukDbvCeprF/Rwmr2WVW/AHGjIEsoyZqt4tJ0FKVi1RdhgKSiP3ESReil
 9CsGsFyeIWoCpA6Wm4hHIv5+nTeejy6VsuG/4ExFofo50i8tchLnD0KUpUg/3ETG6fLCRehSf5N
 j8GS3bSjHoz6YpkmrwLnw4NzpXdSf5IoyW6W/LNcOMGXUV5L0ua264ZBXxyTtzvLCpA2Ud93+P3
 j5rQhQbikFVciG+5GuNgavOIkoDfM2t2ThkDR6+eAo22sWLZ13c85uBo3EBU0L82mZqbYB1CcxR
 uo1V0FZdi7IEfra2OEwA==
X-Google-Smtp-Source: AGHT+IHFLY6NQ+02OWYAhpQPBlW3Gf91wTKmLotJarAPnU2zUXJLQ5fVYckxt2m9vxlSWOZwk7EzIA==
X-Received: by 2002:a05:6300:218a:b0:352:4411:6785 with SMTP id
 adf61e73a8af0-3898f9977dbmr4647808637.44.1767850256605; 
 Wed, 07 Jan 2026 21:30:56 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 17/50] tcg: Replace TCG_TARGET_REG_BITS / 8
Date: Thu,  8 Jan 2026 16:29:45 +1100
Message-ID: <20260108053018.626690-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Use sizeof(tcg_target_long) instead of division.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op-gvec.c                | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 4 ++--
 tcg/ppc64/tcg-target.c.inc       | 2 +-
 tcg/riscv64/tcg-target.c.inc     | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
index 2d184547ba..9c33430638 100644
--- a/tcg/tcg-op-gvec.c
+++ b/tcg/tcg-op-gvec.c
@@ -607,7 +607,7 @@ static void do_dup(unsigned vece, TCGv_ptr dbase, uint32_t dofs,
     }
 
     /* Otherwise, inline with an integer type, unless "large".  */
-    if (check_size_impl(oprsz, TCG_TARGET_REG_BITS / 8)) {
+    if (check_size_impl(oprsz, sizeof(tcg_target_long))) {
         t_64 = NULL;
         t_32 = NULL;
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 10c69211ac..c3350c90fc 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2604,7 +2604,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -2731,7 +2731,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
diff --git a/tcg/ppc64/tcg-target.c.inc b/tcg/ppc64/tcg-target.c.inc
index 3c36b26f25..b54afa0b6d 100644
--- a/tcg/ppc64/tcg-target.c.inc
+++ b/tcg/ppc64/tcg-target.c.inc
@@ -70,7 +70,7 @@
 #define SZP  ((int)sizeof(void *))
 
 /* Shorthand for size of a register.  */
-#define SZR  (TCG_TARGET_REG_BITS / 8)
+#define SZR  ((int)sizeof(tcg_target_long))
 
 #define TCG_CT_CONST_S16     0x00100
 #define TCG_CT_CONST_U16     0x00200
diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 31b9f7d87a..9c4f1aba7f 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -2929,7 +2929,7 @@ static const int tcg_target_callee_save_regs[] = {
 };
 
 /* Stack frame parameters.  */
-#define REG_SIZE   (TCG_TARGET_REG_BITS / 8)
+#define REG_SIZE   ((int)sizeof(tcg_target_long))
 #define SAVE_SIZE  ((int)ARRAY_SIZE(tcg_target_callee_save_regs) * REG_SIZE)
 #define TEMP_SIZE  (CPU_TEMP_BUF_NLONGS * (int)sizeof(long))
 #define FRAME_SIZE ((TCG_STATIC_CALL_ARGS_SIZE + TEMP_SIZE + SAVE_SIZE \
@@ -3109,7 +3109,7 @@ static const DebugFrame debug_frame = {
     .h.cie.id = -1,
     .h.cie.version = 1,
     .h.cie.code_align = 1,
-    .h.cie.data_align = -(TCG_TARGET_REG_BITS / 8) & 0x7f, /* sleb128 */
+    .h.cie.data_align = -sizeof(tcg_target_long) & 0x7f, /* sleb128 */
     .h.cie.return_column = TCG_REG_RA,
 
     /* Total FDE size does not include the "len" member.  */
-- 
2.43.0


