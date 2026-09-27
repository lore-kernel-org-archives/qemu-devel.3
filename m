Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D767AC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAklA-0002ov-Bj; Sun, 27 Sep 2026 05:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkV-0002VB-Eu
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:47 -0400
Received: from mail-pz2-x1d.google.com ([2607:f8b0:4864:3b::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkkT-0007Su-9z
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:00:42 -0400
Received: by mail-pz2-x1d.google.com with SMTP id
 41be03b00d2f7-cc1cebad4aeso577932a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499640; x=1791104440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WkbnIaNaKW5U/2h3ItRbQkzJq+mYAwK6zleV3W1NsWA=;
 b=Z3T/TczUQXTSsAe2sZ2SSbI0k+5q13uuvgo7+hnRjvFlmthi6RLuE1yOgavFqoDdmu
 ze+MrWRr6a4ySuyG1l5VeinTq+O04QXrRlhZwaycF7cIIYYRlMRhewD5UYJeua9EY/90
 g0AGa33HUJgfTWvU29aOLiia1JwAlUylqPdwgpD91UXoJnzXtxs859Wx7ORylmJ6nZ3e
 i+8Ye7wUtEE1q1FV5k+saLXsqYXSIpg5WjUBVGPAduuWSD+FpaHZ/nxkAFfeKhtJfNaT
 IinMjxvZkTDisfmL3VmW3afhKTB72qXXUf/DepX/xVzt8YChzHaH42FuDnuNXcNDi1Xn
 op2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499640; x=1791104440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WkbnIaNaKW5U/2h3ItRbQkzJq+mYAwK6zleV3W1NsWA=;
 b=Y9Ra8x3QeFyijI7G7Z0xLGhM0pQ800TuETJlFxKNLvEy30NhKndEeR5QD0Qbmmguz/
 TtmuCPeoJza8tui0D+Sqf3RGSIl3W+USpf7qKJjBrFUwpRY82tKi9poh/XXGbYzNulSU
 ObTvYXlOPMr10kqSa3U0w/wKpLpQFubyQ5JyB1rJ6Nw8KqO2lHwHw9Ot13RXixqgGBH6
 yJZc0HhDZGPTlFCQnmU+7sJgGn0ilGPCNA0dMG8aTiv814vNpan+hcis4W8c/4eW1vUz
 pKivcC60MoU3OEVUdjl+/zSeUNjHlSQK/6gUyvEZlmIkWzKfLUyrfddK27Yr4/h4qTFR
 gK8A==
X-Gm-Message-State: AFq9FYLw7Wj0sSYaSYVuIoOugEDeNKI7pW5oIJXZ+1+rkamuXpbzviNc
 VBu5TCZlZcY3sP+gU3JUyObOx9TIXgCiR8w6rrRvbGrbB8ffrBl/hJR9ibPamc5l0kKSVvDTP/Z
 J43c9
X-Gm-Gg: AYBFou17SB6SDn/Bpi/I4CfcWhEsZEWrbbSv/MZ0yxK3lEevvfPaWaOGm5ny9o1kVlm
 tCWiu6+WvxIuK9tK2ag8wLuxVY0Xl4CWMvJZl5wK3IqjrvUS2YydG+KppToLyNyFJw42OWC8RFb
 54x/iAjoeLGsIJ4ubUuS8VCq5b0Siopi1jt6HpUKePIW6zLs5/6RApVXWzs7a7BdNxlPUsCOR4k
 2GqLny7qhSLQcG/F4uaYbhESU8qRLf9mNHF3hKEHNfxatYw1GKjvsdEdPckJ2H2BUmbM8iAQ/ri
 cwh00CbkMbxBmQkeLgi++/qTlFCsZOVW42kwrr1v/BVx4HVaQvfNyTy0swnWVg/WkokbyWdYaST
 Nb/KPVqJHSXg0o/KhSz4dYBI4FThEGlOXOv4a/4ZZjYF/VHOBGMjJk75DwSPKg3VeU/yREVVr6F
 D5oqHDKXUXewhuX5RjlrkwP1b+gdct+7fm+uQISDugzqi4Ri6bkpwyFcoZbEpiuPDz7Xu4udo5I
 gGFVeNNOh2aoPpnBmnMfmN/uQaxWg==
X-Received: by 2002:a17:90b:917:b0:39e:6c69:7777 with SMTP id
 98e67ed59e1d1-3a0989866e6mr5934833a91.32.1790499639768; 
 Sun, 27 Sep 2026 02:00:39 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0b8efaeb3sm14014181a91.2.2026.09.27.02.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:00:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 027/101] tcg: Generic expansion of tcg_gen_sari_*
Date: Sun, 27 Sep 2026 01:58:57 -0700
Message-ID: <20260927090011.10724-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::1d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x1d.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 30 ++++++++++--------------------
 3 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index af6b85b6a3f..6b66f050cab 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -126,7 +126,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_muli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_div_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_rem_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -215,7 +214,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_andi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_muli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_div_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_rem_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index ea641158ae0..2108082ce63 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,6 +11,7 @@ DEF3(mul, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
 DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sar, TCGV, TCGV, TCGV)
+DEF3(sari, TCGV, TCGV, TINT)
 DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a72fb4c0aee..7832e99dccd 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -419,6 +419,16 @@ void tcg_gen_sar(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     tcg_gen_op_ttt(INDEX_op_sar, type, dst, src1, src2);
 }
 
+void tcg_gen_sari(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_debug_assert(src2 >= 0 && src2 < tcg_type_size(type) * 8);
+    if (src2 == 0) {
+        tcg_gen_mov(type, dst, src1);
+    } else {
+        tcg_gen_sar(type, dst, src1, tcg_constant_internal(type, src2));
+    }
+}
+
 void tcg_gen_shl(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     tcg_gen_op_ttt(INDEX_op_shl, type, dst, src1, src2);
@@ -540,16 +550,6 @@ void tcg_gen_not_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_sari_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 32);
-    if (arg2 == 0) {
-        tcg_gen_mov_i32(ret, arg1);
-    } else {
-        tcg_gen_sar_i32(ret, arg1, tcg_constant_i32(arg2));
-    }
-}
-
 void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
@@ -1549,16 +1549,6 @@ void tcg_gen_xori_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     }
 }
 
-void tcg_gen_sari_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_debug_assert(arg2 >= 0 && arg2 < 64);
-    if (arg2 == 0) {
-        tcg_gen_mov_i64(ret, arg1);
-    } else {
-        tcg_gen_sar_i64(ret, arg1, tcg_constant_i64(arg2));
-    }
-}
-
 void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
 {
     if (cond == TCG_COND_ALWAYS) {
-- 
2.53.0


