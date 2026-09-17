Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C665EC982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73ns-0002hz-CC; Thu, 17 Sep 2026 00:32:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nI-0001U1-VK
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:22 -0400
Received: from mail-oo2-x2b.google.com ([2607:f8b0:4864:31::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73nD-0007D4-Ui
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:32:17 -0400
Received: by mail-oo2-x2b.google.com with SMTP id
 006d021491bc7-6b1ae7166edso241972eaf.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619534; x=1790224334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vmR9bh6nFD/o+Kl8UuKD14VRvSu0WPDxviozaeiSIEI=;
 b=XGewsBCl1DyR7/7+wDmW1v/fS2L3/qv2zPpYindIJqRunV9u0ZUVuyIaPBuiRJSq6A
 z9blIMJV84wIf6oyTph+nfnRjDvW4ycNPpjTgpCeBB7PvtLUZtieJmgoLmRL5odXARl+
 dskXzG7BH/+7iE4mNUb9/uVDWrmlz2kyuuPQ0SxHOqxSMBQwOEpuWHIQjlXTk+Ji0s/j
 5K1kOQxR+xEVuDJXk6QJGuR16O5GCt8yzLwzc6rCKAVKkjeW9h5c/AwU8RGHhc7xTeqn
 kJc5CEFi1RVk8CFaeAx66usCsZEgmf6G6zqxxDKy8EJHIq/P25/W346uAIt8Esjbo4IS
 UDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619534; x=1790224334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vmR9bh6nFD/o+Kl8UuKD14VRvSu0WPDxviozaeiSIEI=;
 b=fSLUZpvRPBb9YXMtqnn9+JHh26FPBcw24+pcQGoGWgvSl3OXEL7Vs7cA9CYawf/+kh
 TwBjgMj7HYzJaHq0y1uCJCgP3sZOW44CpjISPRVZ5oNLbarBlmamy/egxlopQfKHMQtu
 QCGIDpki3GA6rv2L9EWRzP7u/Bw9F0wC4FGx9UiZesFMdgIVCITGUuXbssiPRwMyJUmt
 7+DtoS5gzXAn0T4Wrd2ta0eWaouWAXvRSFpDktuNWoL2e3R1Z8h2PNc/milYb5AxC3xp
 YIa097nBV1s1FBqVUjgepKllDtTi+4WvEOdlppsSBrixSGaYcnAybNNjolwmlUKC8d4M
 PEVw==
X-Gm-Message-State: AFuF++nUPXDxsqA3s/G4+L9N7Bgp97ST7OT/o3aklvHCCaK5Dcs/y7u5
 BK59M84UX3ht+b48ucEfNrftAJVYOnzvGnTSalaZ9zOo5Uz3qTTuGCzcWb6o0parbh5Zw63U5TP
 SCv8svmA=
X-Gm-Gg: AYBFou3Okdc7s8qPxXSCwYe03FDgUJGV9CF1UZEXKoDV6vbpupiTboR0SWfE/8NqZgn
 x/K5E6i8Z8zetPTkRazuHoAJ/WYRMF5ReOviCZTV6rm+F25ezDhcPq9TFz41FAXIjk8HzoopfQr
 h69MJYDub3RQXmwZmP+f7Aj1cgygVvuk56VAMLixQtoCv1Wm/CbFCftXBnfoIEYCrmKDaE9/8hu
 XGZ6gNLFnoGTczjbuldbTeQrIkk6YqMz10H0p9ogFAYK5nIsYwhyrEYd+AHIagxc3priEnfsRdt
 xAEmU14lQmUtIhNZJS0tTYyQB5GnQ6oB9RkB8k+ks6/JrTrFgXnbwst37swOvEN6E0T/9fpFocM
 Ij+3tkLu/wGxjM9SBCKElOBhsoa5ZInhc0KToAnRCteJ7yRjjrxHnLeBJq2mf2exbLxLS90oY40
 KkArngDuzYR6vSuiG+lSX1pAn1GWF3NrjaQFT21MXbUcXdmDUhPOYWtcqyIHaHX72bILH8+T0Tw
 VH4Sr5L7neq6wg6YQ==
X-Received: by 2002:a05:6820:200f:b0:6b6:93d6:afcd with SMTP id
 006d021491bc7-6c7d1bca6a7mr5342215eaf.26.1789619534491; 
 Wed, 16 Sep 2026 21:32:14 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13cb7sm10501878c88.7.2026.09.16.21.32.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:32:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 045/101] tcg: Generic expansion of tcg_gen_setcond_*
Date: Wed, 16 Sep 2026 18:27:27 -1000
Message-ID: <20260917042823.542588-46-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x2b.google.com
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
 include/tcg/tcg-op-common.h  |  4 ----
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 42 ++++++++++++++++--------------------
 3 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 006f668aa5f..2df3fe5f6a8 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,8 +146,6 @@ void tcg_gen_sextract_i32(TCGv_i32 ret, TCGv_i32 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i32(TCGv_i32 ret, TCGv_i32 al, TCGv_i32 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_negsetcond_i32(TCGCond cond, TCGv_i32 ret,
@@ -217,8 +215,6 @@ void tcg_gen_sextract_i64(TCGv_i64 ret, TCGv_i64 arg,
                           unsigned int ofs, unsigned int len);
 void tcg_gen_extract2_i64(TCGv_i64 ret, TCGv_i64 al, TCGv_i64 ah,
                           unsigned int ofs);
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 63e87c8313b..6ce86d2005a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -26,6 +26,7 @@ DEF3(rem, TCGV, TCGV, TCGV)
 DEF3(remu, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
 DEF3(sari, TCGV, TCGV, TINT)
+DEF4(setcond, TCGCond, TCGV, TCGV, TCGV)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index abb37a6d623..762888aef40 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -121,6 +121,12 @@ static TCGOp *gen_op_ttii(TCGOpcode opc, TCGType type,
     return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), a2, a3);
 }
 
+static TCGOp *gen_op_ttti(TCGOpcode opc, TCGType type,
+                          TCGTemp *t0, TCGTemp *t1, TCGTemp *t2, TCGArg a3)
+{
+    return tcg_gen_op4(opc, type, temp_arg(t0), temp_arg(t1), temp_arg(t2), a3);
+}
+
 static TCGOp *gen_op_ttttt(TCGOpcode opc, TCGType type,
                            TCGTemp *t0, TCGTemp *t1, TCGTemp *t2,
                            TCGTemp *t3, TCGTemp *t4)
@@ -673,6 +679,18 @@ static void gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_setcond(TCGType type, TCGCond cond, TCGTemp *dst,
+                        TCGTemp *src1, TCGTemp *src2)
+{
+    if (cond == TCG_COND_ALWAYS) {
+        gen_movi(type, dst, 1);
+    } else if (cond == TCG_COND_NEVER) {
+        gen_movi(type, dst, 0);
+    } else {
+        gen_op_ttti(INDEX_op_setcond, type, dst, src1, src2, cond);
+    }
+}
+
 static void gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -741,18 +759,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_setcond_i32(TCGCond cond, TCGv_i32 ret,
-                         TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i32(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i32(ret, 0);
-    } else {
-        tcg_gen_op4i_i32(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i32(TCGCond cond, TCGv_i32 ret,
                           TCGv_i32 arg1, int32_t arg2)
 {
@@ -1531,18 +1537,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_setcond_i64(TCGCond cond, TCGv_i64 ret,
-                         TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (cond == TCG_COND_ALWAYS) {
-        tcg_gen_movi_i64(ret, 1);
-    } else if (cond == TCG_COND_NEVER) {
-        tcg_gen_movi_i64(ret, 0);
-    } else {
-        tcg_gen_op4i_i64(INDEX_op_setcond, ret, arg1, arg2, cond);
-    }
-}
-
 void tcg_gen_setcondi_i64(TCGCond cond, TCGv_i64 ret,
                           TCGv_i64 arg1, int64_t arg2)
 {
-- 
2.53.0


