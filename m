Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C8AC0219B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 16:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tht5j-0006Wq-4z; Tue, 11 Feb 2025 11:26:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5T-0006Rb-I1
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:15 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tht5R-00035l-Fk
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 11:26:15 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38dd14c99d3so3213889f8f.3
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 08:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739291172; x=1739895972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3EPwG8dd2j64xXzy/tTpfAvYyh9xU2jE/gdTFjY80Pw=;
 b=oIJeKJzQloVGhbFMWUv5JyXBvSWf1gG9sCKZZzSunOGO47qCJnQ5zkKyQBmU+FHFCu
 NeIIxNDpxQ7Zn8Fr+7+NpNuKsN25R6pxfk0LKaskQFEoAJx87PhScA2lulYY6ZQbBdnl
 TwXU4cuiEwgdza3NHrgykHjSnkMUcU/YZGsTIJXp/ODV1hrYkPvVU32MchX5F2F17W4x
 HeNYzR1CCCZ85c5fYTxB9OZA3bn1jStf41DCthRXGuraWrAXaCuvYAG7FYhZbyhZ7WIq
 nd3NUjVnOjlqCe1OAKpRnU4Jv9vUG8PC+2NKVH/qjeyoU5IAC9qLpI9c/jkKBvbDVJNb
 msHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739291172; x=1739895972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EPwG8dd2j64xXzy/tTpfAvYyh9xU2jE/gdTFjY80Pw=;
 b=gRoV5Q5+yK3QpcA4wKu/TLG/7qz2VjmfzN77FyeQ+yEYIWjiWqUOtnFgCB06eWpUSS
 UgFI7u/NT9ewSqqfiR8hvAY1VFB8sNFxG/+iDr9Zi8Qqd33FKK7K6yaGpEdCVE8kSCSs
 yqsvzGsS66NIu2HWKOdif8uQLZQA/9T6oca8zvzPb2rFOMpsIjpX2ZMe0ffBWTtmI+LE
 68xoDbhMVKBZ5OzjNWnzuu5MYJK4vUbpMMs2BmlaUBP2e+gPjRJS4ZYBL7q5TFvt4Vgw
 0FXGS9L8x90o4HJ0x6WDTUdTTce+HrEtsYaGzejojvYsHICHnZOvraeIaGbFIirZHLEY
 YEHA==
X-Gm-Message-State: AOJu0YwZ0IezT7mawvL5/rnNJ5Pvn0tF9/m+QFqApnns/oD9OOUtUJjp
 ljxWl8R3jVcRGYPMHxGHz//oHU3uPSI9ZxPI4S1FBSV1Jprl2tViP2BHed7kJwgBEXKORktksB8
 1
X-Gm-Gg: ASbGncsSFwDVswQ6A74ZY/9U9uzpXk+m4g3EXkn9UAnhay8U5FHCz/Mm/jhTQ141P5M
 sw2vLswVTG2Rb7CpCctM7uo1tZGeO4wAPnHVs0laAxtuxFiPOH7+5HyZKvqRCgl8VwrR3Na5fbM
 l36xYdONAwESzsW7KWi2JqWo8/v3xdK/OcrwCbAMBq7KXKetlKW+SIBozs7KDihcp08spdgXrXu
 cPqEi+QVYjtrGY2eJPhuh7xC4Jmlw1Wcl96Pfmssq8R+W5Rs0ZKnk+t071qy8SsTAWLk6noyPbe
 daDYkM4uq6F1IAGHUVCa
X-Google-Smtp-Source: AGHT+IEyMGw36MedfNb4l2Srd+yqvvo4mkBUPgw4dXcSpB0+WY5BFHZ3fkTSA12mFWIlcfvJWz1K3Q==
X-Received: by 2002:a5d:6d83:0:b0:38d:e1ab:d785 with SMTP id
 ffacd0b85a97d-38de1abda3fmr7274669f8f.14.1739291171952; 
 Tue, 11 Feb 2025 08:26:11 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4393f202721sm82660455e9.21.2025.02.11.08.26.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 08:26:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/68] target/arm: Add FPCR.NEP to TBFLAGS
Date: Tue, 11 Feb 2025 16:25:00 +0000
Message-Id: <20250211162554.4135349-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250211162554.4135349-1-peter.maydell@linaro.org>
References: <20250211162554.4135349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

For FEAT_AFP, we want to emit different code when FPCR.NEP is set, so
that instead of zeroing the high elements of a vector register when
we write the output of a scalar operation to it, we instead merge in
those elements from one of the source registers.  Since this affects
the generated code, we need to put FPCR.NEP into the TBFLAGS.

FPCR.NEP is treated as 0 when in streaming SVE mode and FEAT_SME_FA64
is not implemented or not enabled; we can implement this logic in
rebuild_hflags_a64().

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h               | 1 +
 target/arm/tcg/translate.h     | 2 ++
 target/arm/tcg/hflags.c        | 9 +++++++++
 target/arm/tcg/translate-a64.c | 1 +
 4 files changed, 13 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 51fc50980b3..24b0a5fcb9f 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3214,6 +3214,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
 /* Set if FEAT_NV2 RAM accesses are big-endian */
 FIELD(TBFLAG_A64, NV2_MEM_BE, 36, 1)
 FIELD(TBFLAG_A64, AH, 37, 1)   /* FPCR.AH */
+FIELD(TBFLAG_A64, NEP, 38, 1)   /* FPCR.NEP */
 
 /*
  * Helpers for using the above. Note that only the A64 accessors use
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3be3fcbe728..0dff00015e8 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -157,6 +157,8 @@ typedef struct DisasContext {
     bool nv2_mem_be;
     /* True if FPCR.AH is 1 (alternate floating point handling) */
     bool fpcr_ah;
+    /* True if FPCR.NEP is 1 (FEAT_AFP scalar upper-element result handling) */
+    bool fpcr_nep;
     /*
      * >= 0, a copy of PSTATE.BTYPE, which will be 0 without v8.5-BTI.
      *  < 0, set by the current instruction.
diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index b3a78564ec1..9e6a1869f94 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -407,6 +407,15 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (env->vfp.fpcr & FPCR_AH) {
         DP_TBFLAG_A64(flags, AH, 1);
     }
+    if (env->vfp.fpcr & FPCR_NEP) {
+        /*
+         * In streaming-SVE without FA64, NEP behaves as if zero;
+         * compare pseudocode IsMerging()
+         */
+        if (!(EX_TBFLAG_A64(flags, PSTATE_SM) && !sme_fa64(env, el))) {
+            DP_TBFLAG_A64(flags, NEP, 1);
+        }
+    }
 
     return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
 }
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index f9b62a2c4fd..d94a0022e4c 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9742,6 +9742,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
+    dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


