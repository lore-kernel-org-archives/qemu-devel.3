Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCAD0C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1o-0005Kx-L6; Sat, 12 Sep 2026 06:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1g-0005BJ-3R
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:04 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1e-0007Mi-4l
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:03 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea50db3so186197a12.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209121; x=1789813921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oZO0SOhP97A15mzeKwBR14Aw17yXX2X2KlpwBu8IcIs=;
 b=Ws0QFO9gGSmAAhtjJm5GJFjDheBxCPCPLESTNyuTL6xPv5q8VHrE85Nnpoe2AJGmRH
 VK5zTQndl5VAZPmckn86tBQnM0emzjhI0rG81bXbCmSitMjQQmYvFb99ep9zDq9+pKVA
 yDf2EpGxJxdjYSgSMo61YERupBaAlhPCQPUoBV070Dg72FQste4Os+C979r3KSMvnTtQ
 7Rh7I/jm7Fyvz5I+SanhwMn81v4AJYRAnsL1nSCmb2s01V+o+b98/oT/fDe7fsEW1rj/
 Zx0TC1TzJwSYDcQIyj62w4fWHi7h0f8wF1jEOAcsK8sGiqZMqbEuedWmeZ10WfbiowGc
 XHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209121; x=1789813921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oZO0SOhP97A15mzeKwBR14Aw17yXX2X2KlpwBu8IcIs=;
 b=ZPef430boRCgp05EUHJzRVMhJGZ90wJeGqctXChJypC4Y0vkMTeYVaxvGuPoBpY8wj
 eZj07TZk/8CwouCa/qnt/JYNPw9sUzTQKt94iL009JQNadSBVWCChGzudDMXLWYO9Q5a
 mWnAaGnvVLD85AoEzjFjQyfOUnYsNzmP8fZVetp7G1FpfWlO1vpalhP04j4Q3Y+/Yqw7
 CuwsbNs6u4b8gV+Vu7w3qi+ZSbmboRhLMRJ5Lkj2G87rYu1AfhAvC43FRjPullUa3tHa
 5z3fZie8EoNWBWU8e/oEDfRn9ahgJhD1BEA/zwBE7EfgQ37IvbU1DmFvBrz7wDRscIXQ
 5QKQ==
X-Gm-Message-State: AFuF++mQzfK0dOwVmLHQ/P/P810U+DA2Nf1oGEInKbjK9zdttpmnssey
 7wlejkjhCFfMMOiwkESvsgQHQWE41uAUTizE+WqkmwcVfQYUbxIHzQBH8aaBxxOMcdLAfCqoudp
 MizvK46A=
X-Gm-Gg: AYBFou0bRkNZ+xw/OjzK63Y8tUgLwWSPt+H2gZ+pBl+WeL38VkZwGVZUKTdatgpKrDu
 ZwTqhuWxg6AWXGY46MmqO7IKgSVjFKiScvQC05bQW4E49veRH0Lbh9lTWp2xJ14ZrYO73aZXFAb
 9JpsEi3Jo9462Fzf6jpTpTplod1loRZwous/1jN2cpuIAN4OT7+bzU3yoVasUN36gR2jOquwkDR
 Lmxu9Sb5+zZe1R0JBIP+gll+xgWC46wm2tXOjRcK7CFtBC9dPNSPJSgGcxZdicJbIApigzS7lXw
 L/kKUWEgRoY3aYJXSJ4KlbYXqZ6+1KJFgJtfvg8hmdwRAxew9f6duSnfSsJIlQCNwWLaEqmSmnp
 98bVPJ5M6tN4wL00JeYaR5FIyx5AJNxkMG069ZrizzqhlgSWpECMRzYgTInhDQlTnjiYfxJ9GiN
 kxisFbQYXVeZ8KdLe9lDNWoC8SXUjKNaXpaG6+NDOocmeYdcKPGAUWil0XIvhhdBK/4CCQt3Dnd
 Rs0Pr+lUknGb6BIng==
X-Received: by 2002:a05:6a20:a11e:b0:3bf:a543:e7f5 with SMTP id
 adf61e73a8af0-3db0e0b887bmr4082780637.3.1789209120734; 
 Sat, 12 Sep 2026 03:32:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.32.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:32:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 34/82] tcg: Generic expansion of tcg_gen_nand_*
Date: Sat, 12 Sep 2026 00:30:38 -1000
Message-ID: <20260912103126.598030-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
index 7d225eed9b4..6ee12cc2dbe 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 3b2807c48d9..276c0059ec2 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -22,6 +22,7 @@ DEF_RRR(div)
 DEF_RRR(divu)
 DEF_RRR(eqv)
 DEF_RRR(mul)
+DEF_RRR(nand)
 DEF_RRR(or)
 DEF_RRR(rem)
 DEF_RRR(remu)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 9811b26a84e..1caedda8931 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -483,6 +483,16 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_nand(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_nand, type, 0)) {
+        gen_op_ttt(INDEX_op_nand, type, dst, src1, src2);
+    } else {
+        gen_and(type, dst, src1, src2);
+        gen_not(type, dst, dst);
+    }
+}
+
 static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     gen_op_tt(INDEX_op_neg, type, dst, src);
@@ -733,16 +743,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i32(ret, arg1, arg2);
-        tcg_gen_not_i32(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I32, 0)) {
@@ -1770,16 +1770,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_nand, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_nand, ret, arg1, arg2);
-    } else {
-        tcg_gen_and_i64(ret, arg1, arg2);
-        tcg_gen_not_i64(ret, ret);
-    }
-}
-
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_nor, TCG_TYPE_I64, 0)) {
-- 
2.53.0


