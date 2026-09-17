Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F3FC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rZ-0004yC-8N; Thu, 17 Sep 2026 00:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qv-0003l8-TL
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:06 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qu-0007x5-07
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:05 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-398a147688bso364108a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619763; x=1790224563; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JzX3XHmCsmRbtmaFAA6hZKePi8VPIq4fPpBQOzjWd/s=;
 b=hpO1GG+qLGdTemppoXdGhfyvK8mLEKvRx0C02JAFFRWay8fYN3sIJAajEszq/hjZS7
 QHZ2na0oc9L25rDw4q+hfdywWz6laOql5tje4znB8sKrTRxKcMqmZb9e8h64PqOUtRpi
 L4h/MrjWKfoad0q/4JBCG3+BOLcDcoOUYapA4MZ2GSNUv5+msCfFP8SZhZxtp7YHkUIF
 b/Cls7WrBBqh34imqE8OP9XjFrdeW7tgbAWHuO0aUGa8aU5Php8w5cLCYmi3UZsy0pWo
 RLSdxWpnv1fud1LRA4uJVIB4YnyGb1blls10Z0csOQ5Dig1VZzGBoxqaPhinEoIPBsqT
 L4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619763; x=1790224563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JzX3XHmCsmRbtmaFAA6hZKePi8VPIq4fPpBQOzjWd/s=;
 b=IdXwUWjh9JeOZvqLQNQWMn1X2icBXNB0GVcl93aB+V+Ur5vttK9BW54oMteVG9HdOp
 pmzbK11tyJ/9p41bPt9+chRLO42n4F8sw29rm/GKH4L/4T5lHwVnFxt0MvPZyWMwmIrA
 T64XvHWHDIi9QHeudQBtZCvvOBqEaCW/8p9KNpTR/TM9lybhpzWPBlETr1hgv6SA7v00
 zMPiPvp5bOq0/NOTTeD1h2DdZOvGG9nKRMb9Dcq73yrRKBttCSwNPQdK/LwaPO5l4M+2
 jjc3xu7rjyNQn8QxoqadGL9seEEE3Vt4hxGzdaqwc//AzwCiUttz5TiF+tHamX81zxp3
 kTcg==
X-Gm-Message-State: AFuF++lCNqv9q2tb1s1aOxkbDtf+B87VQh97Fc711qQMB2InEGpCGhOO
 NYkeYGHy/CfDlKEkPmNKH3W0z2/IMLHFgT/b+l/xAtCrvuCXQq5cqs7lOcw6VRQW/QSZU6WeTU2
 771MOLwc=
X-Gm-Gg: AYBFou2oiR77xjEQz3FnJFMAbtZCy7Swa5wmyQNoQyMGss+GjM/LQCWdPnfL0B33fpX
 SK0SuaXvQqbEjv/YGKchUOFZq1C+5y9QPQg9Jk2T9EmA76b2eiS4PJQnH1yD+e9ifSnAUHUOcsu
 xdK+8/3rnIVu6rzgo2i4F99cXl4Tr956j8N4SezMsI3jyMmZob+uX50kycbszwokbtbLyjJAWZ5
 Ee2klotsvdY4NGtr4maSB83NnG9/4HsEV5NB5tWjHwQaeRlEGcwAmIgPb/+cmA8pF2o4/Wnujm+
 p8rLuWXBijspCeMD55DTm8Hoeo/NQLOwuhXWq9mrIWoccXZdg0EgeqTnXCsL0Qs4zSIQuPNad0y
 EeBPgp1WDR1zyQ1kUvk9JLjefbI7gbbtYyHJJ3/crMNHkXzuWO9ITCiDYXt8gC5KZk3Crjnv3vE
 uafiJVmzVDdqqE4pMGhrbS8Raot53s1FHwJvMopPlYWvaGFcQCdSZfdfxoo4tWce9ahn/O+J8b4
 1bjfSzK
X-Received: by 2002:a17:90b:6d0:b0:39d:e213:9dd3 with SMTP id
 98e67ed59e1d1-39e1e27ad18mr12233362a91.1.1789619762591; 
 Wed, 16 Sep 2026 21:36:02 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 092/101] tcg: Generic expansion of tcg_gen_ld8s_*
Date: Wed, 16 Sep 2026 18:28:14 -1000
Message-ID: <20260917042823.542588-93-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 16 ++++++----------
 3 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 22077246109..0e75243f534 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -141,7 +141,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset);
 
@@ -170,7 +169,6 @@ void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld16s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index dcd5be7f20c..d246b47a38d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -31,6 +31,7 @@ DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF4(extract2, TCGV, TCGV, TCGV, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF3(ld, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(ld8s, TCGV, TCGv_ptr, tcg_target_long)
 DEF2(mov, TCGV, TCGV)
 DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b77e61c2b1d..c4419b702b1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -897,6 +897,12 @@ static void gen_ld(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_ld, type, dst, base, ofs);
 }
 
+static void gen_ld8s(TCGType type, TCGTemp *dst,
+                     TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_ld8s, type, dst, base, ofs);
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -1506,11 +1512,6 @@ void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld16u, ret, arg2, offset);
@@ -1544,11 +1545,6 @@ void tcg_gen_ld8u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld8u, ret, arg2, offset);
 }
 
-void tcg_gen_ld8s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_ld8s, ret, arg2, offset);
-}
-
 void tcg_gen_ld16u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_ld16u, ret, arg2, offset);
-- 
2.53.0


