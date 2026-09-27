Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7662EC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkw-0002a1-MR; Sun, 27 Sep 2026 05:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkB-0002Pt-1y
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:28 -0400
Received: from mail-pz2-x2b.google.com ([2607:f8b0:4864:3b::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk7-0007OV-Lj
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:21 -0400
Received: by mail-pz2-x2b.google.com with SMTP id
 41be03b00d2f7-cc79223bcfbso1025500a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499618; x=1791104418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=da3w2mHE7nqzicqisr8lyqoDZHuEAojBvZfE6rc1f+Il2wl+4i+FEp3oX29W2MAc2o
 /1CMy8hAkr0f2cq7JDtbvuWlDxqHt6KqN7Si6yEsEDPv8lEqVIdIahZ+DC98lU1/ilBt
 LlrYyFGaAjuGx7l57g5frHcuHmPC1KBFIdXuHcVqeUjTmkyz0YoV0aX+Xs8c0eSnXgOT
 WoNtjCambAt1zspl5pzwJO33jHfnShVqz32lSTotTzffBGu2W1tgJjqByz/nlb6GXYTl
 RQMOkFSM+etBx8nThhdZM+d9DMHNHli2pcpDRvFNZJhX20iRHz34X6zd2sgbZgjgqvRx
 yiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499618; x=1791104418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zppA5F7u5jRNskJwrLWeML9tlG0yJ4S2s1Br5DXJWCE=;
 b=XD+ZFC4vL8YwC5PvIFHCtu/4N0fgd3hdlnOKcQx+vyxWZdyIcldN0wHup8DJX+aG2A
 CsR1bMzAVUpZcoE0YpkRUrgqgfiABPcD0lSM4lmHMjY6vlLafevnjjfu/wOpsHHI0hep
 q0pf79U12o2yJD6FxncvcgqlmIy1u/SMLwTGAQ6UM5Yc03/vyvVMpoLRIJxJ/f2cssjE
 0BNtCY7n8vx6hS3cnN7zyJNd+LezccOeK7yJevo6CL9vDJTESqM3aByRJXZCDj4k0hPY
 linoX9HRUAZH/L5Hr8SPxUSpDzlh0QXbjLIOEXKSSrcca43aiieI3N4Qj66V0a0YJ3WJ
 TiIA==
X-Gm-Message-State: AFq9FYIx3IbrPYgtBf5Kr/tmlkqEaGVKh0UQk5KhtMP2TvnrQc0apFOC
 b3qNgYfQCagNxvmo+T2ArEYjR7kRjNP8xkOovEypS79pdrvwFo698BM51ZQiPr5QV5S3nLLtKLo
 pjtS6
X-Gm-Gg: AYBFou0LFaxSG3kGL75U21JQR8x1szfToZ4fW+RK2VHwC38ESw7eMLHS6fB9L77Qjkx
 M0cIhSr8HmJTWW10JkpLMxT+ezZT5mHoJsZsrIN2JcehfVE40H1Z+O29e5ocJu1VZRTUm/yNSx5
 f4R2yDezakr5y4JIUe8tc0qX4w2NMcF1Iu3Trp4CMGYl6b6zatG4HYgrhkfEBVcytiFTBPfBj3J
 3d8SKLhes+4xcNSz7Onw9Xo8euR0A1vuAP+BRnjN8LZxHTiThy2pTN1uuhZoWpko7MDpHDWQSnz
 3Gv9/kkjFxYkAxaNIYArv7A29FOA6/finDK6kUlBtVEyMKzc55REPt82cjPDyf+F3U53P8IyELC
 n+ufMhahtiJgSgN2uwsfAo2UWPdGFITud/XG/q1wPnUPMMxnROEvyzrBqpL+5e2NVnmrjxm05+5
 GMCSl63X59cpgcnnRgQTwsWup7y+8nhlyyUQOLv4v314nHKJkgY6r/EX1bSGnWMcRT0hctMB/w1
 /PzJrbC3QIcDkFqr6GZnWXIt+N4DQ==
X-Received: by 2002:a17:90b:5848:b0:39e:4c7e:f03e with SMTP id
 98e67ed59e1d1-3a098b4cae7mr8629944a91.27.1790499618069; 
 Sun, 27 Sep 2026 02:00:18 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 005/101] tcg: Annontate functions in tcg-internal.h with
 QEMU_*_NONNULL
Date: Sun, 27 Sep 2026 01:58:35 -0700
Message-ID: <20260927090011.10724-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2b.google.com
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


