Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E58DC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L5m-0004bm-6k; Sat, 12 Sep 2026 06:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5B-0001EY-Do
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:41 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L59-0008TV-8v
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2d942c7cc2fso17185725ad.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209338; x=1789814138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=newdrgVvvOB46f7SbNgTuNYOzaQB6WVqzQqV5Nz87so=;
 b=VxSoLgiH0Ees7uSBMI5Ff+RoyVZdvGWQcEmUX6557nnNJiHwJGFn3j7cDNYbQjNtww
 Bwv8l/h7iID61+LVgCwUvtD1nW58q8bPRDp9M1ZI+8XGG6P3TZTjQGWldE4z3crR3rvG
 uqFzQtr5AEqAHtvh36g+VzlxPgBGgMzTmLVcKfDhY/KuhuFxXCeAb2aOXc2op3fXbdd2
 FYmYvcb0z76ScZsUm5ihdzdSPi4Ngy3aLRNllFeOmsD4B7NmFoan6LWQW7d305ZKC7j4
 /nXqmwULSiPIBGfy69x/lWzmB8uvQIxxrdx3qk/djvinxVmr/HEojCiD6Fn/ncqekb7E
 HDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209338; x=1789814138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=newdrgVvvOB46f7SbNgTuNYOzaQB6WVqzQqV5Nz87so=;
 b=qzhKLOzihS6gwM1mchJmKNjurVmcOzJw3Ej+zQaz0jw9vwteyuGSPYfRCNraKlgsrN
 bzDlplJO+tUJ3qg/w/BJ8cRj/E6TWwL9YbgQOtnfhBOovpwNeJqOWf+fhiA87TvewLKs
 sAyFtgN0j3jIT+g0j+YvVEiAk5GofeIlcs+/zRleAANF2p0t7PMp/RwTr6NGrdGl+XX1
 r8Tlg05nBhqzcpZwsVHbrqYNQUXY0O4TINNnLnkKihn//AbQHvEhXRhXvZ/OstJOpfCj
 /BtAT1QXw7dMvA8lvFv5mXDazN+22sNSozZi4Wws+OJ9Pexj5PYUJo87POJ+rvi5DyXW
 q/nw==
X-Gm-Message-State: AFuF++lopEALFpdn1doloG/H5WGzgYEemyoc6viOk1wDIw7J7qUkGXZc
 p0IgBt9PNncGdoBzvrBYZF3os/iiTGTpGZj404dsT+W7KGMw9+B/xuMuQYWMamnE4+3QKDzk1LJ
 jW0Msda8=
X-Gm-Gg: AYBFou0GGbxSXB5dhUkFHGYeQoKvBc0Efq//FExF7HPr3Lh4Ah9s88xIEWxThS8yFny
 DKDcYe5TLuuFA/HKhcpmIGXA/NldX+vEHeaPk4/NwUFNYAMzLnlhjK8MVr9ocU3QK4/7AZyx2M8
 +EXdOtLIusTGamfCbT2MrH+S50ez45D8kXZDGJwusDRpL3XX4Cz5AnWMARVft5V4nc1zFdx0xZF
 APeuSth0OsvhQ48olZghON60jar+elss1d20ZEzAeWql0pfcGb5rONY+ie4m4/BOsYYKHj86dHi
 et2Ygu4OzzUOJcPSPCHRo0vuij0LPI4RWI5uYFPTSkxXBoZaWsZ4YrIsyBf2MXl52VajqX7s+tc
 jijZl2jkMEOMKTP4lcQFR2TXOvlYpxzDv7iYpNcHHizpXrQpX3L8g00V61p+O3HbpZACTI/eA5k
 XPdyZYZFPrHtUW557jXddiCuGYRCdUFRDjLC/MJG6/AB5C6gsPHsMEfRMCu7J97/i23ZOEhu4PR
 DOplQ0=
X-Received: by 2002:a17:90b:3842:b0:39d:93a3:7adc with SMTP id
 98e67ed59e1d1-39d9c3ab85fmr13478271a91.25.1789209337683; 
 Sat, 12 Sep 2026 03:35:37 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 71/82] tcg: Generic expansion of tcg_gen_umax_*
Date: Sat, 12 Sep 2026 00:31:15 -1000
Message-ID: <20260912103126.598030-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index de0e535cc10..1b7f9cf473f 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -166,7 +166,6 @@ void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -207,7 +206,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index fb76cb39ec3..4dfe7513e37 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -55,6 +55,7 @@ DEF_RRR(shr)
 DEF_RRR(smax)
 DEF_RRR(smin)
 DEF_RRR(sub)
+DEF_RRR(umax)
 DEF_RRR(umin)
 DEF_RRR(xor)
 DEF_RRRUU(deposit)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5afc0cca18d..b2b201c33f4 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1110,6 +1110,15 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_umax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_umax, type, 0)) {
+        gen_op_ttt(INDEX_op_umax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GTU, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_umin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_umin, type, 0)) {
@@ -1514,15 +1523,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     TCGv_i32 t = tcg_temp_ebb_new_i32();
@@ -2027,15 +2027,6 @@ void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
     tcg_temp_free_i64(t2);
 }
 
-void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_umax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LTU, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     TCGv_i64 t = tcg_temp_ebb_new_i64();
-- 
2.53.0


