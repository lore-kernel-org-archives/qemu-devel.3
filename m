Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3729CC0218A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2025 16:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1teGY4-0006CT-4w; Sat, 01 Feb 2025 11:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXv-00064t-OA
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:40 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1teGXt-00016B-7e
 for qemu-devel@nongnu.org; Sat, 01 Feb 2025 11:40:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso30161555e9.0
 for <qemu-devel@nongnu.org>; Sat, 01 Feb 2025 08:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738428036; x=1739032836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ABcSaamNLba6tj+/HdzqsCS4/cyL464U3gesfB5gldQ=;
 b=hPGqWKgeYR6jkUX6YUGNCUkQ1lJLKfVz8pylPwWDXurwSIXqwbOeiSbNOEcCUeyUV0
 o8MQSbC66LEWTh2g2RYKl8UcOYldWi37h9PJcRNHmr42IcuZbpb4qeIvhfqyggW7nNnP
 zYgfoNqVGluCmyHeyVhnv4cp3uIFU+yRzaQa6IgXIvn7yxobeLAnjfJrJGw6TghWQ2ky
 L9i37BcCDXtmK6FX8Ppxz8gF8JAsDgdu+6YtdjemuqB2mNwm6EBg53wxBasbReh9vQlT
 mcfXYkU3VyU17Ro/3LMM7k9of66THXBP/L+tIKEocT6/Xwlz+oI2m28ydYoHyiknNl24
 ZAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738428036; x=1739032836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ABcSaamNLba6tj+/HdzqsCS4/cyL464U3gesfB5gldQ=;
 b=LNJ9xlBQ3UkVEzfhCKVAgjYoV7vwJQo/mh0WEh5M/nFJ5HAHWKVMLFOgo8QI8dvVLS
 bqrBFV78VGGVWxvw59eeK8i4Qbuk03itgwHH5MKrEFHfrOi7C9b2sxvy05feoBgyZpWg
 1ZyAdJHA2WkUVDelGR59ntbmZAKTrcs0zMR3z39Dj4MmRHwcdElPByaQEEiUNaH4BlG1
 Uu5FCZf//bBlQsmPyQcDZJLEH/3xxHx6Y3DhqBvg5rZofal0boazMmsyVwZTZewaIXMu
 mKN6qP8Y1gMNaJF0OQblmKJWrCPHr6yHLeg7WYDpvmFSFXTArAUr5ilD005qyjYJKP2u
 BjlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8NggCS0BXlHUpf8gYNNsUWPCRZRSF9OrSrSutxYw4Bu/imRj8aot9y6t8VDAnRL5geINsyBXCk4c4@nongnu.org
X-Gm-Message-State: AOJu0Ywt8BEaBZA+OAwtIqcq9vemElYwynUzHux834ywOPYAbaZfCMEG
 vDe+MmsWh21d1xlwCPpiqHwfJV6WeWjZWQohUbq2HO0pyu7n+NZg1rLjEUyDk1A=
X-Gm-Gg: ASbGncvTRblg8TDnwDyxnHkOklWau+pRMEkGxbkG/nbYTIOfUXt1JsA0qXK6n1vI+rj
 479p6yxvhdl19o7ddytkwzLYYDFE11rfeY/a3dyZcvp6tk7Kjh24ZedxnafPfThud/f2fgA2ami
 4avnVybM6Q1Xfpauux+Tvu0jCVT67dNcSVaccTJGwWs20qMPRjAFuiwwNOSx0XFQ6yXkTgJEQeu
 WAHJMLLrfZkBZz/1Ve8p82S7oZDGv7DrqDFG1PUTiuIfWasETkjC1XJ26Qd/iWtcnixENZ1Xz18
 uKbHlhwp+/t2TbAYy7jk
X-Google-Smtp-Source: AGHT+IFYfXQpgd8XfnmXugygjfq2R7Q+bMrmr7cgR8Xhi1finlMLK2yBdDcAZCD4eBBfVCIs/woIxg==
X-Received: by 2002:a05:600c:5119:b0:438:a432:7c44 with SMTP id
 5b1f17b1804b1-438dc40b281mr121715665e9.21.1738428035710; 
 Sat, 01 Feb 2025 08:40:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc81d74sm127401525e9.37.2025.02.01.08.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Feb 2025 08:40:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/69] target/arm: Add FPCR.NEP to TBFLAGS
Date: Sat,  1 Feb 2025 16:39:18 +0000
Message-Id: <20250201164012.1660228-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250201164012.1660228-1-peter.maydell@linaro.org>
References: <20250201164012.1660228-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
index cfb16151577..f562e0687c9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -3213,6 +3213,7 @@ FIELD(TBFLAG_A64, NV2_MEM_E20, 35, 1)
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
index 1da6e2b9456..e000ff83cb0 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -9753,6 +9753,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->nv2_mem_e20 = EX_TBFLAG_A64(tb_flags, NV2_MEM_E20);
     dc->nv2_mem_be = EX_TBFLAG_A64(tb_flags, NV2_MEM_BE);
     dc->fpcr_ah = EX_TBFLAG_A64(tb_flags, AH);
+    dc->fpcr_nep = EX_TBFLAG_A64(tb_flags, NEP);
     dc->vec_len = 0;
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
-- 
2.34.1


