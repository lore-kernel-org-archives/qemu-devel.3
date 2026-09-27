Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14C9C98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkkI-0002Sa-7q; Sun, 27 Sep 2026 05:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk8-0002Pd-Br
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:20 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkk6-0007ON-U4
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:20 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1084736a91.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499617; x=1791104417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=i9+/1h+8WZK1oU3050KhKRJTyG/EiekJWDNaB45q5XGY97f4i1um1KtNyCzvPtQLxg
 LrX+8iMmMbT+IsHH+s/rBwNhoo3K9BW4OgdB5ab/sxwCyjbOBVSgNhBNoFt02ao+sYY/
 3BIlTX0WJ1rBbIRhcx6Lov/PrvQTHTm+ekyrfn40AW84vYXTv5sQO1Ev3iD7yDpuRe+p
 9x09SDt8UCSvBKRnQFDwF5GLD98OnCJT477MDPqRLzX5Qhi7i4s5K/Ba2UypsKOHkwO2
 pctJr34r+PkIUPEk7H/k4r6SmRSPg7iVbky2jbtHJonT+L6+4WZbbw00KnLUm4KFxeoO
 vqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499617; x=1791104417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=ovxyXY3NJLsSQSPyxbi2H1s7HFmYywSi6TKMCmkw2DcXpc0W/oD1rhqQdA0I1Gegde
 SVEzNUCE2LeVAcl/QdL7XqDTQDambLssAJLY3YYHeig8Z5RIBrfNqT0IkSOTVnc6ckOu
 QwMPSU6iUTOKqYC0wuVBqqQonITuPRM8WhZR0ChpNyLU2FuX6/KT5bARyo+/qdJv5y5d
 Tw9Ci3dX0Et2AMlO/m90FdItc/Onjr2liMPqEll7i0mlzRtmXq73cUF2TwIjjxU2vMBT
 3ykNAy/ORUmnJY3Y3k/ou18Dn6PaqIhWcV85x/nkKG+SuYB/qz/qknGMtAGe3Juo2mzK
 jBAw==
X-Gm-Message-State: AFq9FYJnRfWdQ1fYsdVonT9m7hYIm3RT87VguVxyARHLedED1JXg2sZ3
 cWfVY1vwIu4w6P9wC84zos/SHieKMPx1YeK3FFckMfxsYVzt7PNZfiRrk6qNLVcjR9RXp/N4wRl
 aO35I
X-Gm-Gg: AYBFou2qErcROnh/bVhlGZz27MLYt3LqvqLYvImZ+M0wIg3kl0XCmKNSmOeqHlkaHcV
 yIlZEUw/7q6i8cLsaDfe5mY/yHkKZIDM3kzWbRLUhlL1Cu2Iae4cqYE8foQ5XKIDIPP1ygqS80U
 vHlwYcO1Gr07TGksn++uKGZYGOd1ZC0nQEKnTS9VDxYT4hRWO8dmjdPydhRl4nVb5IIhOZRSdIW
 e5j1sbjHTQYu/QkcG3gLJ2MZIiZL9s/LtBHZEScnOCp4yHHar8l2pyT7yAOZ0WGm/1d4KN8OWjW
 Axr7f+2dL6GHMgjisJC5YVv2QbA16oJv8ACXft8g5lwbL+OeF8oC9sdJk2gfUBHzW99tyV6pGQd
 rwVUgzqW4QzNXqu4cOSrAW+LghiBmdkZolnN5g2UM7p+02LqqcfFMSykymioQTAjdjxAxbeD9E2
 17J6E47dvfx79iCK7Lt6/X2h00HGdQ5Nwo/JqwxDEEbZ6NGlyoXUsIOSjvjEWbUQzrwv/4O3E3J
 cNX+Oi0BOc9QnrtfL1d/OMY3e14nQ==
X-Received: by 2002:a17:90b:3a46:b0:3a2:b04e:8086 with SMTP id
 98e67ed59e1d1-3a2b04e8389mr467828a91.44.1790499617309; 
 Sun, 27 Sep 2026 02:00:17 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 004/101] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Date: Sun, 27 Sep 2026 01:58:34 -0700
Message-ID: <20260927090011.10724-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-mem.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/tcg/tcg-op-mem.h b/include/tcg/tcg-op-mem.h
index ea35a02fb40..29e7c02f256 100644
--- a/include/tcg/tcg-op-mem.h
+++ b/include/tcg/tcg-op-mem.h
@@ -28,50 +28,50 @@ typedef TCGv_i64 TCGv_va;
 #error
 #endif
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i32(TCGv_i32 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i32_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i64(TCGv_i64 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i64_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_ld_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_ld_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
-static inline void
+QEMU_ARG_NONNULL static inline void
 tcg_gen_qemu_st_i128(TCGv_i128 v, TCGv_va a, TCGArg i, MemOp m)
 {
     tcg_gen_qemu_st_i128_chk(v, tcgv_va_temp(a), i, m, TCG_TYPE_VA);
 }
 
 #define DEF_ATOMIC2(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v,       \
-                               TCGArg i, MemOp m)                       \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S v, TCGArg i, MemOp m)       \
     { N##_##S##_chk(r, tcgv_va_temp(a), v, i, m, TCG_TYPE_VA); }
 
 #define DEF_ATOMIC3(N, S)                                               \
-    static inline void N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o,       \
-                               TCGv_##S n, TCGArg i, MemOp m)           \
+    QEMU_ARG_NONNULL static inline void                                 \
+    N##_##S(TCGv_##S r, TCGv_va a, TCGv_##S o, TCGv_##S n, TCGArg i, MemOp m) \
     { N##_##S##_chk(r, tcgv_va_temp(a), o, n, i, m, TCG_TYPE_VA); }
 
 DEF_ATOMIC3(tcg_gen_atomic_cmpxchg, i32)
-- 
2.53.0


