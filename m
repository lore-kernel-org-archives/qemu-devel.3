Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A84C0C88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1l-0005Fz-QU; Sat, 12 Sep 2026 06:32:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1S-0004pX-Kx
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:57 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1Q-0007It-PG
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:50 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-39647aa9d52so1891127a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209107; x=1789813907; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HCfglA/tPJhB1o/CRCIIhHWWkrHTyJ7PJZcyUVdFWy4=;
 b=NRnGe65peyGM+lGkK+iBeMy6bPaKfmf6tIVqq5FeR3mc16ft+2yGIxCwR7euvC0nrs
 6Mquj2lPZ85qY6JbWu6n4OnIzELUT1Kpe3qq22JKVTVPUwq39rY2hrL2mma8wAJZowjh
 Io0SvP2y7lvFdyiR0FXa5NiFZLVwhwYapmsPq30YnrBg2HPpB9Vvd7LfKST/MKzstWGo
 wdG84UNyS9NawdnOZ5CwkvoXLH3KclME+vtHoK7aQo2fgMdZJeAhJf/ZOsCoL6x6M8tW
 bc10vMsr7wmIUxYvXpnq4WmQrZH/FVhrHwuubcMLPcfS+ltYPJAZ1bC3nuJtbumZr/bB
 ua/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209107; x=1789813907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HCfglA/tPJhB1o/CRCIIhHWWkrHTyJ7PJZcyUVdFWy4=;
 b=TC3F7IlE8298PypE8Yv4L9c+ayecib8V8zkMGeCZ2b8gdSVAp1Pn+RFI7+rQECWYrl
 W/uGMITwoL2sO1Rc5qaH1zv3j3UrONRaV4o4rieOUP89Cpw7c10fRoaxSGsy0BUNfL7L
 GxwsmFRyTo3P4fNGECpbcSZ8YJ6DEPzdegDD9p1CtyS69THzpi2c3q4mvftLCnH3KvJc
 7+N/G1iWsa7xBjICtxqwcdXDaWRLCj4h43iXMy8gG2TkcixJTORn1xWBSerEgU4rTev3
 BKtwAMAhcchWEtn1lJicurx4Wb88ZfB+GLNyfeqPCKkRssF2dDPjNYKi7+BxwFJUD1uk
 Qsew==
X-Gm-Message-State: AFuF++m/gKpLnFmntvy26REZPb24DI0hFoAhlwruxFsZ9pCxvbIltHqS
 FsHpLoU3wET/LybQ359zC/7u1ddE/0Ncal5frPSH/SmFsG1k0hw4Tq+GrM/5mn0itSDMYkCz+b2
 GAZ/Gnj8=
X-Gm-Gg: AYBFou1jKNXZZc3I+IjiG5906f9lim3cmAUK2pmcNJClE8KSrSuapoGpQU3ulV3HMJb
 81cwsbxCgSixVulA0FruBb1wgz28cHO5lYCuNFfYsRl+9aeaiL/8PKwbfYFYJTtE28BLx55qpHE
 McRMyTWP8w7LN2gGcurCYTuHy45uee0f7C54fYEgWvlH60b8k41gP/kcgW9RwZdsIFbH/OAvPys
 VbtJJQBScMfBGcdHQ2Y9Y2+36OfHB3ap4AICRxd+hVw8I3YqIXoDKMcnSkFGaJ9WaQMuNtdTpna
 1ifO914U4DhveFXhDRPJby8UDcfR2d01/ZgwZC9CxIwGI2+4CX7bxEX4wVmyukeRGN2B2mgTHv9
 xUCriRJX/DUdeuJAL5MkaEQpQMXdnDd8Y2YcH+mo1ITqKFkd3RYSnqHlM6+zI9oCNJmzsB6S0KP
 LfUJkCIvVDpfowom0eq5FktWOmgdKLNZh+pO1MPeFACQjHKVT6pwRIw6ULnvaw60YdfjACnqELW
 0o0Mo4=
X-Received: by 2002:a17:90a:d40b:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39d773ade15mr18234670a91.0.1789209106667; 
 Sat, 12 Sep 2026 03:31:46 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/82] tcg: Generic expansion of tcg_gen_shli_*
Date: Sat, 12 Sep 2026 00:30:23 -1000
Message-ID: <20260912103126.598030-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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
 tcg/tcg-op.c                  | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index af15e4a9dea..fd272b4305c 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -124,7 +124,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 67aee68c1a4..b0ba4bafc36 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -6,6 +6,7 @@ DEF_RIR(subfi)
 DEF_RR(mov)
 DEF_RR(neg)
 DEF_RRI(addi)
+DEF_RRI(shli)
 DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index ff06a80dc02..c12d0f29a72 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -414,6 +414,16 @@ static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
 }
 
+static void gen_shli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        gen_mov(type, dst, src1);
+    } else {
+        gen_shl(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 static void gen_shr(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shr, type, dst, src1, src2);
@@ -547,16 +557,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_shli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_shl_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_shri_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 32);
@@ -1576,16 +1576,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_shli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_shl_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_shri_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 {
     tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-- 
2.53.0


