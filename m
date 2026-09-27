Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1237BC98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklI-0003C6-UR; Sun, 27 Sep 2026 05:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkU-0002V8-2f
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:47 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkS-0007Sk-BB
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:41 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1777255a91.3
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499639; x=1791104439; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=enyU/XUU3wtv+Xl6ie8oo8nkPzqD6sixQ7DId8tTSoI=;
 b=LCMwG5iV2wOU9cAb2Dr6hhzHSXhFAaRVwdmPAFOHHf2zm0AlPZ31EULLitakFu5c92
 CYtw9drD+BEqeVpQJ5ePux3IoNn+RyDA1/rckjDZDXN92BQX04HvQBHK86w6V45CoLqM
 XBXtsUcvFS8R0MtAQ1JZXv9IyYpvuclkmUq4NkoIxXRKrXGyi46gQAirzwGEkY64r3Ta
 x8nVIkVIEVkEEl8bB+HE1UYqMyt1OuRSCbv5j0F/TcWcvbJbfMnA0wCWMr03w+8y3j+z
 7WAtJQSmK/aVPeUxJseojzP9PfeBtpAmZpn3hi3g+xYKy8vvUQBgqG9P5b4Fp7Ip/s7G
 fVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499639; x=1791104439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=enyU/XUU3wtv+Xl6ie8oo8nkPzqD6sixQ7DId8tTSoI=;
 b=ucFbdXNETxZj83wYZMSfHfQr4KDoSIvjA6xVrC4deciG/ENZQLkOmPLiX/5U3s7wNV
 XkFkz2A/rUUaEcCVCUFIec9M52apQNzYzPYY8AmvfKgMfb2MekJDMVO791hEYBzElOt2
 bTsT5AT8IMT5x8Smp2B4yClcltFPjcfkDxeB37BfOpqktSru5S++V/yYGfYQKL1Mw5/b
 I17JESpJ4pnlzYoTZtqfIjgiqmXZvefBXpCaU7SZacgelT/WQAskUyzvTMajRwssYEIG
 jSwI0QnhMH8vLjk/qNO4uIW57xWeWXCVYDW1U6VgIumzs5lHfAFvmb7M63SKX5xM4cwJ
 WqwQ==
X-Gm-Message-State: AFq9FYLb5grLTuwyhYyZiwYAx4fOZHToseEpEWzMMZZdf3km9AFVpYGR
 wL5afqqJXr5N484SKSRpHIlmbWD4uvY+bsbHphi2ue2RvqsdfTRz+LRRHGm5BYAm2ttHh778LJt
 3d0a3
X-Gm-Gg: AYBFou3QPLCCqOX2CgFzQvfyQF9/LGI7wa9kDbA5/uXVEuPlS5usro8DO2yMJ7E8SjY
 8EdV6bxTYNxnStpRCh1LOYJMyOvSsjv2R1dVZcq8xATgpSxLTtVJ4z4fV5nzlyoOJePFtHJxuhH
 h4F83KpPpvsi5vOb95Vin1YvCrGYGPiQw4sSkW1nmG1oKCoTxa0ZhJX+2HOUN9UJ6B/xKX/6Af4
 SQa5+KAD1jXR12V/Vxhhqnao+KUPejE/qnOEAGnv9GjbdJFXM02s6CMcrGhEDT5cedeRx5G1H9c
 MkEInaQN52dDMqcrmZPxpl4xi2DTHZBcRQF43gN9npX+Qk3xHL1xBUB2yMiw8banIpoUvGp+22R
 vtprK1YnsmzFz950qp+612oKXp2rVWjqDUIVRUy7KNY7i26RzGhCHEUEV7nTxnoXyBDshQkW/kN
 7sAyhDM0NVEYt2dz1p3NSVXvcBAlQVqMYT9hlicorQD0v48CsW7e8VKzGejsCQxcUArNPr0eC/C
 +/J1s9Fcq6wvmy3RuX0h4lLmcmeQQ==
X-Received: by 2002:a17:90b:4acb:b0:398:b1eb:136c with SMTP id
 98e67ed59e1d1-3a098d43e23mr8696719a91.9.1790499638886; 
 Sun, 27 Sep 2026 02:00:38 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 026/101] tcg: Generic expansion of tcg_gen_shri_*
Date: Sun, 27 Sep 2026 01:58:56 -0700
Message-ID: <20260927090011.10724-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index d469f2b42a2..af6b85b6a3f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -216,7 +215,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index c47de1a3a42..ea641158ae0 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -14,6 +14,7 @@ DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
+DEF3(shri, TCGV, TCGV, TINT)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 716417bbfc4..a72fb4c0aee 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -439,6 +439,16 @@ void tcg_gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
 }
 
+void tcg_gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_shr(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -530,16 +540,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shr_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shr_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


