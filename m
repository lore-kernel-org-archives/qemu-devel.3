Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C7C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8K-0001yC-L8; Sat, 12 Sep 2026 22:39:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-0008VZ-DW
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7n-00016P-8o
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:24 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-38a0c7e841fso3299490a91.2
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267161; x=1789871961; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=n0ThWuTmkmvVNKbGAYUArcwtR2A+zAz5iQWCAX9uiUY=;
 b=pQB9d3p91kgK3iRA00xeSTpH3b4WxXRGI01ENHMQ4YXIdcd7A1QYi2h46b9mNjjHAf
 6SW90McgSQ34HvVvpzrVD7bNOYO4gC6JGk61b8gU3cgLP4yrZc2g6+fh2z2GVgCfc2jP
 hLqihBibYSyKBuG2YDXi2M3gD/hWWY9ZW0DyhoThw6Er3DatUbZLekWbo8QnrXHZjLZq
 h2pvv+wiD8zzEri6Mqq4rnG1qxzkfCdhmJX39Veetut3FPinSPK91Zx/k/NWnycbnnhg
 D65Zwbgc7sdmLYY5qoS2RaLH98IGDlNpV/AKUUKh2FrXA4ut28zPYODaQVwuXQkwBBCZ
 +fWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267161; x=1789871961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=n0ThWuTmkmvVNKbGAYUArcwtR2A+zAz5iQWCAX9uiUY=;
 b=PFwGRh3Ve4yPwBVE4/U2X0OP3qnB51SATLpEmNnFRAyR74gIu6N4Gd1lCc0PTyeOcW
 JL/6bledEhoYNdZoIZk86+K94FY73KhAODKuzjr2PJkz9Mm1NaOvvF1YoH7hxBKbDph9
 GfhO6HCrxC3uHdVB84ah6Zcp03Gq4CBSdlQlDUu+OGDVp7S6JUmGR2SVTDm1x/V0SSNi
 biWfB3jIkmQQhqpC09mx77DorBDUrwmFxq62iRlW+0ONkOpSQ+mdEQfQba5zyRwQihcZ
 6EbyIEgJ91C5f1utr8b0xlh0L3odsUyPyEiN1YcXqLKQQ8jZtq+SEXMlPM0y/W07BeSJ
 6syQ==
X-Gm-Message-State: AFuF++mGmiGnAH8ueSNep2Rkwpm/c3eM3ZWz2PPkqclEnX+lNsmfVuxf
 h83Yngvhw1Zk/vaykxi/qe/scSsCiSvnen1J8oT3lUFXuqHMAjZJmyUVZ5ggZ1hRAcL4tsa0up/
 mBFEqppI=
X-Gm-Gg: AYBFou1NZ3Y8fgXn1ltTXYL2q8+Q1stKDN6a2qkcwTwsJK7Eg56FfQQFN8lEtsbQWq7
 Jp79hO15TwpZmth2Xg6hf8L4EMNj/C3rbSQrtxfphOlwvPRzQ2qoKE3QmegysLHdtgM4eJeBuHS
 1605axLZzogazfXjrR8WMb2Fpq5IgerQ0618ekXqivhBwH511L5cfqzHX59PDlep0emg2IEShX3
 5EWqkV2Zj1v54IofX7lnHQo9zzX8n9gt/K2+y02DVp1cWd9f/PfkiwqDAxuT+HKLeqUZ8k7nWun
 7eh0i9b2eMheI9NnG6n3NibZ2m65kQbWHWljlt4eytIYR7ZpRfjxbOB7Z1jXeUL6DW+crVlNcZn
 1IhzNcrsqTP03RXqf6pa4xU3d4MaXC6AK24NentTsjM3RhUWo3IPdH623uME7L1ZKp52dbRmHWD
 5fX4fjKcpxVK7CkS0QyCzumj329QYcO+JITyzXg5Bd3P+ju6cFS5FCNUpbCvctX0zzc3NpLOIV6
 XtQroE=
X-Received: by 2002:a17:90b:4b81:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-39d9bc6a1b8mr18658537a91.8.1789267161194; 
 Sat, 12 Sep 2026 19:39:21 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 36/86] tcg: Generic expansion of tcg_gen_orc_*
Date: Sat, 12 Sep 2026 16:37:47 -1000
Message-ID: <20260913023837.741866-37-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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
 tcg/tcg-op.c                 | 37 +++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 471fce20998..974681a29a1 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, uint32_t arg2);
@@ -197,7 +196,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, uint64_t arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 62dc85ff6a6..e17caafd890 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF3(nor, TCGV, TCGV, TCGV)
 DEF2(not, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(ori, TCGV, TCGV, TINT)
+DEF3(orc, TCGV, TCGV, TCGV)
 DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 928ae524d49..1bbe6992e34 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -578,6 +578,19 @@ static void gen_ori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_orc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_orc, type, 0)) {
+        gen_op_ttt(INDEX_op_orc, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_not(type, tmp, src2);
+        gen_or(type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_rem(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_rems, type, 0)) {
@@ -760,18 +773,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_orc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_or_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_clz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I32, 0)) {
@@ -1777,18 +1778,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_orc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_orc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_orc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_or_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_clz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_clz, TCG_TYPE_I64, 0)) {
-- 
2.53.0


