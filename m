Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C02EE644A
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:32:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socQ0-0002VE-5v; Thu, 12 Sep 2024 01:31:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPs-0001xp-AV
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:52 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1socPq-00032W-EK
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:52 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2059204f448so5548445ad.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726119049; x=1726723849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KVGV+7BfoES8Sd+h3N/5t6lr9vkAfRxdpELYtSFMO/M=;
 b=oKp17mrXMWwa0LA2u3dXS7X7o4NGvpFkJXsabxWFQgkf+3m71rciXENVO9xYPvgElX
 BTbJsBEQ+3kZzdRyDeJsiUtSNSO4J6hc2O9V1JR3SHITMW9o4O/j2d4Zp9mFsAfGc8YH
 xxQGCueL1MvTnymtTLHEXsT2VwbgutAVjT6x6QcYKnTBJPPfceb6AhZ6bLTtBSlzvgwn
 beB8Ho359uHxF8rVB2EZ0l9bwAsxBC4y3VyoJkq/Assci8ZpOUzJcAu15W7gDwrTyu4P
 06sOYRIcVYRNN0UvcXXX2veTTbWtR5atJVvcmLiJPp5CzNS5/98xiuSys20rQUN/eGFo
 +WrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119049; x=1726723849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KVGV+7BfoES8Sd+h3N/5t6lr9vkAfRxdpELYtSFMO/M=;
 b=M7KppRZFVak1kjkSye4a/tz+Rf1iLwtysei8Yl5dHD3ORckcg/8ishd06tOQP+V40s
 ynLSN11tf3xOoOKo8UwXcoUXkNI+eJw+j+NDc40dIi1fLbn9LwjFKpJMKPtWkpQO8GPY
 qtxQ2aKk8sMz2DWzrQLtdLrWCqVp/kdxe9xl5sv53U9ua6IB1zWTUH/5unB1by4sHLkF
 9/r2FKLMzAtymKWOqBhjlmuc//l9LyEACAogclRRTSr2kRcrKl3Tv+xIMFr52Nf2f9AW
 Bolh36KaXheuLMoD9EtBVukO3JOWCwdZhdXEchkLq9Q2WnRRRIvJkQkL0pm0pVqFQVOK
 jpsQ==
X-Gm-Message-State: AOJu0Yx5e5IMuN3ZwwmOxelvLRy0ClKUn3tCF0lOY1G3i6ZsyW3R33CY
 4F25naW1JnLwNfXrGMfq7uY18UaKA6zYyG0UzRm7aQiL5lYp4EKVqwxPRaGE8dbU5Txyzi8rhND
 q
X-Google-Smtp-Source: AGHT+IEwvKQPFvKndr2I6gw9Fu9P56lM6LetUtCUxfQVvTF6RixyVdz1Yvgm2dWRSxIk7cT3phB6wA==
X-Received: by 2002:a17:902:bc82:b0:202:4712:e838 with SMTP id
 d9443c01a7336-2076e34805fmr19958105ad.14.1726119048850; 
 Wed, 11 Sep 2024 22:30:48 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9e1dsm7513155ad.236.2024.09.11.22.30.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Carl Hauser <chauser@pullman.com>
Subject: [PULL 4/5] target/sparc: Implement STDFQ
Date: Wed, 11 Sep 2024 22:30:42 -0700
Message-ID: <20240912053043.1131626-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912053043.1131626-1-richard.henderson@linaro.org>
References: <20240912053043.1131626-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Invalid encoding of addr should raise TT_ILL_INSN, so
check before supervisor, which might raise TT_PRIV_INSN.
Clear QNE after execution.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2340
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Tested-by: Carl Hauser <chauser@pullman.com>
---
 target/sparc/translate.c  | 28 ++++++++++++++++++++++++++--
 target/sparc/insns.decode |  2 +-
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index eb0158a11d..b80f071533 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4531,17 +4531,41 @@ TRANS(STQFA, 64, do_st_fpr, a, MO_128)
 
 static bool trans_STDFQ(DisasContext *dc, arg_STDFQ *a)
 {
+    TCGv addr;
+
     if (!avail_32(dc)) {
         return false;
     }
+    addr = gen_ldst_addr(dc, a->rs1, a->imm, a->rs2_or_imm);
+    if (addr == NULL) {
+        return false;
+    }
     if (!supervisor(dc)) {
         return raise_priv(dc);
     }
+#if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     if (gen_trap_ifnofpu(dc)) {
         return true;
     }
-    gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
-    return true;
+    if (!dc->fsr_qne) {
+        gen_op_fpexception_im(dc, FSR_FTT_SEQ_ERROR);
+        return true;
+    }
+
+    /* Store the single element from the queue. */
+    TCGv_i64 fq = tcg_temp_new_i64();
+    tcg_gen_ld_i64(fq, tcg_env, offsetof(CPUSPARCState, fq.d));
+    tcg_gen_qemu_st_i64(fq, addr, dc->mem_idx, MO_TEUQ | MO_ALIGN_4);
+
+    /* Mark the queue empty, transitioning to fp_execute state. */
+    tcg_gen_st_i32(tcg_constant_i32(0), tcg_env,
+                   offsetof(CPUSPARCState, fsr_qne));
+    dc->fsr_qne = 0;
+
+    return advance_pc(dc);
+#else
+    qemu_build_not_reached();
+#endif
 }
 
 static bool trans_LDFSR(DisasContext *dc, arg_r_r_ri *a)
diff --git a/target/sparc/insns.decode b/target/sparc/insns.decode
index 5fd478191a..923f348580 100644
--- a/target/sparc/insns.decode
+++ b/target/sparc/insns.decode
@@ -645,7 +645,7 @@ STFSR       11 00000 100101 ..... . .............          @n_r_ri
 STXFSR      11 00001 100101 ..... . .............          @n_r_ri
 {
   STQF      11 ..... 100110 ..... . .............          @q_r_ri_na # v9
-  STDFQ     11 ----- 100110 ----- - -------------
+  STDFQ     11 ..... 100110 ..... . .............          @r_r_ri    # v7,v8
 }
 STDF        11 ..... 100111 ..... . .............          @d_r_ri_na
 
-- 
2.43.0


