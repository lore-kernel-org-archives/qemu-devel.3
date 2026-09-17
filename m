Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73D32C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73jr-0003AK-0s; Thu, 17 Sep 2026 00:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jf-00039X-2O
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:35 -0400
Received: from mail-pj2-x0e.google.com ([2607:f8b0:4864:39::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jd-0006lw-DB
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:34 -0400
Received: by mail-pj2-x0e.google.com with SMTP id
 98e67ed59e1d1-39b5b07ec78so281193a91.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619312; x=1790224112; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=CdbYPcj6+6HswkuieSAYfDVrm/5B9AOulwdKTjEt3SmN1Yq+mTD3dgksYfikE/5I2A
 O513UqpKgcaKEqUUKkQz8snpAnhnyC9qJFAwfkTfOHutTXVQ9PwzguuP2rBEgWkKgIhP
 OoIfqXbn/QRY14g9XVWHKFTy+5q/miZdcRZplyT6qFK8ns0gHDWF63LcT0DZESVl2aDN
 eoQRJUlg9V/7BB95BoMb/4yLxYS1CFuXECrE+R75hnviPnMSpZJ1rBIVMow3J7KsTDx8
 feGJNqqAXLyMtDCSh+KrkOIrvhgWU29xeTBMDlXr2SlEe0f1ca+lWL0DVOj0SB5IzJEg
 i6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619312; x=1790224112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=RWIje20BfbIiySSMoBsscK5Jzl7Q6/PQ19OZwq0/pxSSm6Z7QxJ2vHYrst6tlMNtSc
 TqexOd84BE2wrwOp3LutPdsOiBE3DfLlHYJyr7X7KRLSk3KyFgKQcAGpwlcrwhhqrxnU
 V/aKYqCAR2qm4hZDToay90EiyEHP4vHugbD1QR29gUTIEBIvnkE+tNrjT4xKzeL8JXzF
 Z2e9XRMAU3rC209LNHSjC8HaOiPktGQ/J0ZAK5v6+Ffqnq8hCYh+JPDeUL0pZkT1f1rG
 JnayjjJ+Ww2SXG+35rg6jqS92yNDK0ZrCbZXuG6Aor0fSTgylr9/PY4bYnu1UWRwP5Zt
 ku9g==
X-Gm-Message-State: AFuF++lFEgu+VeKCRcHp3UM436rjQmVL2kOLiRw1rw+GWTc0ubTx+XvI
 UZBZchp4X1a8ikrm5Q3MgM8J5NUDdc63wEPEOx9qoKzDILwPbmeewnT44od1oPHSA/SdJ9cKEu2
 bfhgWMbw=
X-Gm-Gg: AYBFou23whOqTaiqUAw1h0DUWbmyTsbZArXve0gywJLfLf42uHBLVNfduzcg9JNtXpe
 h230IE9GcTQgbmh2XvBxpEBDXyP96/uwzem9rRu06+fntdnVVP8cRjEe2KFqNZKhpHeGz3VJr6c
 nLsy7UtONtxEK7M6TednuC500zOiqyW3rEnJcVN7aLOXQTYSNQZDqrku0R50NG1xyGg20NfWeyz
 aoNythHePta9GPcywije4wCNbOwbFRt4uko8M8IkzzwsTgGvpiflpyd3sEvxoucf9umWz7Y/R42
 Al50fUEq3Xr0Dke0isfGFoE0QAGNEMaiVsYuTmzlzZzKVmRqbOv83aFKD6BdFYC/QMXumNcouzh
 fu2kB09c2pkto0w5Q1OzFupWR0fk3eCM012lv+/nlrXmvfrE7t6EaWZH5r4uBkGaAKXVYflkjyV
 D2iJ1A14YxksdWpTn4B62U/Y/aYb5gZAInUDoguRnakWDOQXBo6vLHW/bJJU2FEUDHEQTQlRrfD
 8j/i4I=
X-Received: by 2002:a17:90b:3c06:b0:39d:fcee:8d10 with SMTP id
 98e67ed59e1d1-39e1e48f686mr12684291a91.16.1789619311929; 
 Wed, 16 Sep 2026 21:28:31 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 005/101] tcg: Annontate functions in tcg-internal.h with
 QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 18:26:47 -1000
Message-ID: <20260917042823.542588-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-internal.h | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-internal.h b/tcg/tcg-internal.h
index e35440dc8c0..2620c23b448 100644
--- a/tcg/tcg-internal.h
+++ b/tcg/tcg-internal.h
@@ -41,53 +41,55 @@ extern unsigned int tcg_max_ctxs;
 #endif
 
 void tcg_region_init(size_t tb_size, int splitwx, unsigned max_threads);
-bool tcg_region_alloc(TCGContext *s);
-void tcg_region_thread_initial_alloc(TCGContext *s);
-void tcg_region_prologue_set(TCGContext *s);
+QEMU_ARG_NONNULL bool tcg_region_alloc(TCGContext *s);
+QEMU_ARG_NONNULL void tcg_region_thread_initial_alloc(TCGContext *s);
+QEMU_ARG_NONNULL void tcg_region_prologue_set(TCGContext *s);
 
-static inline void *tcg_call_func(TCGOp *op)
+QEMU_RET_ARG_NONNULL static inline void *tcg_call_func(TCGOp *op)
 {
     return (void *)(uintptr_t)op->args[TCGOP_CALLO(op) + TCGOP_CALLI(op)];
 }
 
-static inline const TCGHelperInfo *tcg_call_info(TCGOp *op)
+QEMU_RET_ARG_NONNULL static inline const TCGHelperInfo *tcg_call_info(TCGOp *op)
 {
     return (void *)(uintptr_t)op->args[TCGOP_CALLO(op) + TCGOP_CALLI(op) + 1];
 }
 
-static inline unsigned tcg_call_flags(TCGOp *op)
+QEMU_ARG_NONNULL static inline unsigned tcg_call_flags(TCGOp *op)
 {
     return tcg_call_info(op)->flags;
 }
 
-static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
+QEMU_RET_ARG_NONNULL static inline TCGv_i64 TCGV128_LOW(TCGv_i128 t)
 {
     return temp_tcgv_i64(tcgv_i128_temp(t) + HOST_BIG_ENDIAN);
 }
 
-static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
+QEMU_RET_ARG_NONNULL static inline TCGv_i64 TCGV128_HIGH(TCGv_i128 t)
 {
     return temp_tcgv_i64(tcgv_i128_temp(t) + !HOST_BIG_ENDIAN);
 }
 
 bool tcg_target_has_memory_bswap(MemOp memop);
 
-TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
+QEMU_RET_NONNULL TCGTemp *tcg_temp_new_internal(TCGType type, TCGTempKind kind);
 
 /*
  * Locate or create a read-only temporary that is a constant.
  * This kind of temporary need not be freed, but for convenience
  * will be silently ignored by tcg_temp_free_*.
  */
-TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
+QEMU_RET_NONNULL TCGTemp *tcg_constant_internal(TCGType type, int64_t val);
 
-TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
-TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
-TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg, TCGArg, TCGArg);
-TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
-                   TCGArg, TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op1(TCGOpcode, TCGType, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op2(TCGOpcode, TCGType, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op3(TCGOpcode, TCGType, TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op4(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op5(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg, TCGArg);
+QEMU_RET_NONNULL TCGOp *tcg_gen_op6(TCGOpcode, TCGType, TCGArg, TCGArg,
+                                    TCGArg, TCGArg, TCGArg, TCGArg);
 
 void vec_gen_2(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg);
 void vec_gen_3(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg);
@@ -95,8 +97,10 @@ void vec_gen_4(TCGOpcode, TCGType, unsigned, TCGArg, TCGArg, TCGArg, TCGArg);
 void vec_gen_6(TCGOpcode opc, TCGType type, unsigned vece, TCGArg r,
                TCGArg a, TCGArg b, TCGArg c, TCGArg d, TCGArg e);
 
+QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_before(TCGContext *s, TCGOp *op,
                             TCGOpcode, TCGType, unsigned nargs);
+QEMU_RET_ARG_NONNULL
 TCGOp *tcg_op_insert_after(TCGContext *s, TCGOp *op,
                            TCGOpcode, TCGType, unsigned nargs);
 
-- 
2.53.0


