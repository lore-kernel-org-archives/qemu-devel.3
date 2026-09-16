Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2811C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pK4-0001nm-ST; Wed, 16 Sep 2026 09:05:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJw-0001Rm-7b
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:04 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pJu-0000Tz-7i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:05:03 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-39b9184fa80so807302a91.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789563901; x=1790168701; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Jx9DLc4i3XAB9yWHymCGsCEcpc13lR01X3/dMGZDCr4=;
 b=ckVgiGr8VzECExHTOxrCVVSMqiHcx6REawWS7mufIgMnvpJaTaA7btVifoOpEXbRn8
 +ZAbCp8SsNxcRGwgQGvATjXQGTa7yGy0mUPmeDvY2Cx133xv2om5E+v0l9EcJsscnPBf
 /exYVkHalR846e/RYFJ0GuW53tZWXlVzOZ+hNx+dNcRSVkLrOLE7XYMxT4RG1VPnU0tW
 PJUh3eT66EBu9vPuEiVWNfTCKwEP3fU+yXKW+zovqyhUB4zdZkrEA1T7Bn2u/ciRvHs4
 lRSDGCjKpOnAXBaU12cyf8monOn4R6/I4YkQecn6YjfB30OMyVPAAD1NJf6BOPhwmMGr
 tMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563901; x=1790168701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Jx9DLc4i3XAB9yWHymCGsCEcpc13lR01X3/dMGZDCr4=;
 b=zxSOroqYl7r1eKpsiGU/FDl/ZD1pP2ngTAe0WRvkjaf4EkWNjcWNEv39QD5MU+sKRF
 8+R+XcamZ04KZz/GvsXJ4mAwMhpcqmBWaDUzyAWFManNoG8yeG8YqVK7PuZGGFPMN1NS
 Swq713WNPQ6E2AzTpl388aTNNn+R5Qe0jCOchAqrniWS57mgP5dLOfo8s6JyeIHAuauO
 1Bh9Fsp94NvutOelrEp+1Juk3V4rW7EQGyPMqtp45vNFbRh/6cDagWhOAbWYYxuZb23L
 7Rv/TMz8qwrvlN1CWvnbkhXHIts8+G/F6akHykKc9sZeALU1xt2nJvmUQeJ9RLys1R0M
 DS7A==
X-Gm-Message-State: AFuF++lCO4M/7yZPmUMk12ZDDLVoDN2qxhdjN3dpvGZ9uUCOa4cRfDMV
 j73b22Lw2VBMvafZSpHEe1VcRJL9zwG8TttbO9F4rxQoKuygm5zkzGhQo5//CVKmPGyoSBdQjSq
 BvvavSfo=
X-Gm-Gg: AYBFou3iI0B5V0gJ9KdDneMDBG6og9trbv+NH3BgVdE/66O8ipRWYupaitNI5h1OOyf
 FuDV4riFfKS0XXk62HF46zKMYAMdOwwn2Cm45wjADu+du6cQySL2xd5l+cFc4CNZ5V3srYIhpC/
 uuoA0t468Vd5U9NQi7OqSdXUX78dqsUw+MnwM7RV7WqPXLVwNcpHDnnKzLCDSRWFGUzxdbpbv8t
 bWAMHIWsSEgE7VpGxvQD0dp6MYyTp3s0LZIlQmQBj2vXZcj89l0fpiZACg2A6l5ZzTPPHXuCnsD
 thIeRN+RgHkwyHLBV5FBeeIjKkh46xl3GGUcgzyKezdwj4b3uJRTxbzJ/yEbBt/52JkONMcx3dp
 3aZYVesd1t+v4Sz3zaUsY+hZaXvJnQSulcPKvTY1MCuzpUgflnYW/QAWuvA3Nj9QK4ojMnhymLj
 oWtRCTez6+Agk4b2eAX+BVQYAcx1gBMz9OPVsuyB4hpYfym9zzml8Vsq1A0xR0PkB0veQFob20D
 eeea1U=
X-Received: by 2002:a17:90b:4c49:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-39e1df6e4edmr5822388a91.0.1789563900527; 
 Wed, 16 Sep 2026 06:05:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395caccf1sm6337196c88.2.2026.09.16.06.04.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:05:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/92] tcg: Drop division helpers
Date: Wed, 16 Sep 2026 03:03:05 -1000
Message-ID: <20260916130409.3382710-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
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

All current tcg hosts support division, so the helpers
are no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-runtime.h | 10 ----------
 accel/tcg/tcg-runtime.c | 44 -----------------------------------------
 tcg/tcg-op.c            | 16 +++++++--------
 3 files changed, 8 insertions(+), 62 deletions(-)

diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
index 0b832176b33..003c963bc7d 100644
--- a/accel/tcg/tcg-runtime.h
+++ b/accel/tcg/tcg-runtime.h
@@ -1,13 +1,3 @@
-DEF_HELPER_FLAGS_2(div_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(rem_i32, TCG_CALL_NO_RWG_SE, s32, s32, s32)
-DEF_HELPER_FLAGS_2(divu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-DEF_HELPER_FLAGS_2(remu_i32, TCG_CALL_NO_RWG_SE, i32, i32, i32)
-
-DEF_HELPER_FLAGS_2(div_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(rem_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
-DEF_HELPER_FLAGS_2(divu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-DEF_HELPER_FLAGS_2(remu_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
-
 DEF_HELPER_FLAGS_2(mulsh_i64, TCG_CALL_NO_RWG_SE, s64, s64, s64)
 DEF_HELPER_FLAGS_2(muluh_i64, TCG_CALL_NO_RWG_SE, i64, i64, i64)
 
diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 7c0aab98a80..77c4024148f 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -32,50 +32,6 @@
 #include "exec/helper-info.c.inc"
 #undef  HELPER_H
 
-/* 32-bit helpers */
-
-int32_t HELPER(div_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int32_t HELPER(rem_i32)(int32_t arg1, int32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint32_t HELPER(divu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint32_t HELPER(remu_i32)(uint32_t arg1, uint32_t arg2)
-{
-    return arg1 % arg2;
-}
-
-/* 64-bit helpers */
-
-int64_t HELPER(div_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-int64_t HELPER(rem_i64)(int64_t arg1, int64_t arg2)
-{
-    return arg1 % arg2;
-}
-
-uint64_t HELPER(divu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 / arg2;
-}
-
-uint64_t HELPER(remu_i64)(uint64_t arg1, uint64_t arg2)
-{
-    return arg1 % arg2;
-}
-
 uint64_t HELPER(muluh_i64)(uint64_t arg1, uint64_t arg2)
 {
     uint64_t l, h;
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9a2626e9669..5577f14ef62 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -659,7 +659,7 @@ void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_div_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -679,7 +679,7 @@ void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_rem_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -693,7 +693,7 @@ void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_divu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -713,7 +713,7 @@ void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
         tcg_gen_op5_i32(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i32(t0);
     } else {
-        gen_helper_remu_i32(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1587,7 +1587,7 @@ void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, ret, t0, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_div_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1607,7 +1607,7 @@ void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divs2, t0, ret, arg1, t0, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_rem_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1621,7 +1621,7 @@ void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_divu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
@@ -1641,7 +1641,7 @@ void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
         tcg_gen_op5_i64(INDEX_op_divu2, t0, ret, arg1, zero, arg2);
         tcg_temp_free_i64(t0);
     } else {
-        gen_helper_remu_i64(ret, arg1, arg2);
+        g_assert_not_reached();
     }
 }
 
-- 
2.53.0


