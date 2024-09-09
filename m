Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF51ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 18:07:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sninL-0004Bp-PO; Mon, 09 Sep 2024 14:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninJ-0003pN-3t
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:21 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sninH-0001wt-4z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 14:07:20 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7c3d8f260easo2238172a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725905237; x=1726510037; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ms6V/0srD/nMNjMgzm5FTu/ZmmO4rz8+JUXESCUp5U0=;
 b=k5iD4GTdAdXAiiLPzAmkSWfMvci2c80ftkhjWu141LhbDiEvxZ8qWP3kZcmGRottcS
 I5veNyR4KF2Sbhvt/M6TJiJxaz6aTHPvpVNEjNpwpF1Gj6RTNNym1NPI5g159GQS4Pro
 FHld5wbJsfR3kNC8bfgkXolALE4IoX8araQJg7ZUqde76xm3ojA3sy6MNq92mxVGAHLm
 3Lx0nXVbubFI7Otj+c24CkgL0bCan7YGMEigbLayblm0WvNsUIQwVmSMlo50UgJYK2Rp
 ttPWEqL0Vqt7olCgPrwHJje4NC++OpJXPLDcrSmPfI+eHsDUMt5vek/a0fxsg242bqdT
 C5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725905237; x=1726510037;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ms6V/0srD/nMNjMgzm5FTu/ZmmO4rz8+JUXESCUp5U0=;
 b=orqphFTLbFPId1oG8tCqYTuPnTDXRYXXZe+guWFtpllaLQh3VYSOpnQFwPu5oe8tRA
 FkxsukEz7kdK400Omy74oIYnlhZZF059hHRSYS7oM3J5Y+gda//rlS2zKq7Vzfbdcfp6
 3l/kZjxpYyq+XaZW1MwNtbR4LNNmfddiZmyTmwWtZxcqmSN26J5TaBWdUZcbgdedERLW
 8u98UCHVn3cYK4w4/kG56NMMDvOt4mTRKHA1/hfuevRvgwDKuRw1w+XyuxZDRNKA78K3
 mWP9wm1msBJXZCQTPaaUPFgximnCpt/eOK76UL1wCb8jtnQ8XSBFUh7aHn7cr0cF7/Xv
 ySYg==
X-Gm-Message-State: AOJu0YwRA7ac9FVBagRudAwsJwN1pol9euvlxHzuSy0NgEw3nnA8/9Dy
 2k8f9N1bWre2EHFk9nTvepxACvFfnt4WRde1Zl0nHRAzfU6eRLfWqp9TVNvKzVWiskawdcUZEcW
 i
X-Google-Smtp-Source: AGHT+IEaj6OGrZFMuKkDuRLaQkEn5HNHKgNINiktDbKu7QM6w+nZ3MD/OViKnXdVt7hTjaYjjsG7GQ==
X-Received: by 2002:a05:6a21:7702:b0:1ca:cd6d:3a26 with SMTP id
 adf61e73a8af0-1cf2a047b7fmr7461115637.27.1725905237501; 
 Mon, 09 Sep 2024 11:07:17 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc84efsm25431b3a.8.2024.09.09.11.07.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 11:07:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk,
	chauser@pullman.com
Subject: [PATCH v4 4/5] target/sparc: Implement STDFQ
Date: Mon,  9 Sep 2024 11:07:11 -0700
Message-ID: <20240909180712.651651-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909180712.651651-1-richard.henderson@linaro.org>
References: <20240909180712.651651-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
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


