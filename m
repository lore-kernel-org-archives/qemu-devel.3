Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E26C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73k4-0003Ba-RF; Thu, 17 Sep 2026 00:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jd-00039Q-Q8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:34 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73jc-0006lj-9S
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:28:33 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso327682a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619311; x=1790224111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=PrVo0l2+iMmvfYWOqCJpJCBfIHc8ygXcOuXsnDzZVizEQgU6YkhJZgPNhCrzP/zvG4
 2wJGhKVqh3RT21C3++47Du8sxXB4/TZRBz/ylNJoe6bRiQdnZniQNRQ3uuVh0p8rIZIu
 chn/9x6mdw6go3pCyxkXMQfZXh9p12L72jlJ0UP1M0j5VwoNvxOLguU1lHB/7eZCtLsF
 pZ8uC932oPvndnyX11reR5h09UZB2dD4a5BfG70aWUrJYWOq1P2FH3HMNOyGuL6CL9Fo
 UE3DCHx0/FPA7lNB/C/3oitVjRqQNW1KoiM58ibomlg/Sa1Tfi8WdEQdh16SFU8+2agi
 F5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619311; x=1790224111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mvlxbvvBT6L4tozjt59kyDDd3bACtbqGjYtcp/gb1fc=;
 b=u9K5q2MtwN9rWRLOWvJMdDXazRgYn/t8tmmpR+/myBVpL2uWDugqiiJ36cSXH/wCzH
 MebTKDZLRm8BYp2P+O/8kNn+Te1ro39Twrdp1LtABrq7wOmQ8moZDSw7UTpjsXZRobIQ
 DzSGggYHocQT7q0sI/c3HKwUmU2cXR/a6wPrK33fZVBP82TCgAi0llNObPIja0BhatoC
 hyHX4pGTVyCBlJ4lM9vCzhSoX+pc6udWgwT5mQqcsSmuSQZBb5+lHHLPN/aRY69ngab1
 MNBmg6gE9T/139f4IZzPYH8HERYWhg9tsGV4VQjkEEYw3qzfi9pXPTcupLs0OlWofZng
 yycA==
X-Gm-Message-State: AFuF++lQlckK6l1zdkwBL1ZSet07qrb3zklgl9l9+2/FlBYQ6JXdw5VX
 ltvn3pUNb/+rmA8Q1VqYrztExBGIF9mVK59fSNnQEd+VZWbLfunADI+ZjSmXuqZT8+tPuV/1ETw
 OdYiNmKs=
X-Gm-Gg: AYBFou3k1v5xUqNRFcdwK0gLmpsZUm5PmQ1SfO/6YHhC1RTzCXhTen6CI7rQg98XfEL
 1659kDMATx0EbfnEoHwtFEGemT1Hox+J8BK7OpqpItOgu+Q3MaFl62gWJxY9nsKpXRGV9YSakcd
 3U3GKiaWwAODbD03OvOv9uhyawQ4cSRzw3xgcucINo+DNYtJXQ4iZ40ASuYIM9jaVUV3zo1aYYI
 YpbYetJpJy2gH4IEz5DHnvPmKkCICpTDki6fNaftPAIG/+bsBEL4zJzmoUyGu9tYv+IfOn87jmL
 vUYtpm+nlZa/V4yigR1jB+QzhX45q82oJsuPnYjuq55PQMBJyAn+cxDpQpHL1bKNbMAjgYzPvUG
 T2qDeF1AxjxKJxCHnw8gHedVtcQhFcmYD/03HDKsQZhrXGHQLpuY7CbqzuOBeo9U7OmRBLzdm7h
 wdvFAyBRvolDlE9ggymym7rPPQXTtAnPVng6GotYj0p05CaVgZ0vj9mrMkPeoeH6+L72oUpiQtg
 jpbgLQ=
X-Received: by 2002:a17:90b:3842:b0:39e:3ce1:d22f with SMTP id
 98e67ed59e1d1-39e3ce1d970mr2109727a91.16.1789619310845; 
 Wed, 16 Sep 2026 21:28:30 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.28.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:28:30 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 004/101] tcg: Annontate functions in tcg-op-mem.h with
 QEMU_*_NONNULL
Date: Wed, 16 Sep 2026 18:26:46 -1000
Message-ID: <20260917042823.542588-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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


