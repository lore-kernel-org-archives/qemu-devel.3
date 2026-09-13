Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17EE6C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:43:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5aBG-0003Z2-DG; Sat, 12 Sep 2026 22:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBD-0003TS-Es
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:55 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5aBB-0001yA-L5
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:42:55 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so755853a12.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267372; x=1789872172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/J09EiTCxDahcnTgt+2ldQAGQXVnu/hVLGdngyd15tA=;
 b=dEDw5Ym705Fd/3COUCbrOVeiXkcN3+/c8qVWR/aQH+Fx7eA4NQEad6wrBx9SvTqLbB
 Qug8nLPQUPqpNVd0jq3bo+E1Ihwd34gd7fhhRK2xCk3TE1PQfqBzhxAjKmgbGCL4JkkI
 H7ekkH+vlrqcv365kOoxeUknSAfozkC149UzbGraa6RrY95uETLfNCz+c3H6Y6ALoBRm
 1s6QCsBzPtr6m43PV/IOePR0d7dP9XPkTGWxal9+EAO9ht735L2NC5Bk8DQACY+phikw
 M2sCZU7hCvyb+jSzCAv/3ggqooWOXlbnP8Nmq9KBDxt7+vbcxTaBdGuiXId9FHdTbws6
 aToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267372; x=1789872172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=/J09EiTCxDahcnTgt+2ldQAGQXVnu/hVLGdngyd15tA=;
 b=WqijvpHvsP7m2wlBJIbRdkaioX0tkdjKZx4Rv+nf1qvCE39Hxw8XaSTbXoEh2IFPcV
 7xrXoK5GqwLDgFWHNWeR/3uMM8rxLjW55JTJQT1963VlGQJE25/CBGKM0+4FuR+PMfOa
 dPSVgdB37SVIceaKJelpbx4CElSW9R9jdyxZtDqm/ViIbHcOBz9w9cJnJe5B+2UpC4os
 /e7d+tLYQm7q0BmrMnDoZmcJSiP8hXq9VwY9mDtJDq6xk67qQJEglDcT53nGDeauDw8G
 ozkgUX7AvpyVK+kVrFL0FUogjBc7ANgRkBPObjLp8tAMZdI5agd3U+CxeU70YGsLzfyi
 kmuA==
X-Gm-Message-State: AFuF++myPUddjwf/ExJLuvT5ttqW3uEUeV1Lv6Zg9qFgdbYuAGtMj6o6
 pISVsNIhEJmAdDQDDaIV9Par+VW2AteKLuvOkHuFyZlJX1iZGK0dS7Qvxch+vG8vT7+1PZdLnLu
 l6BFjeAo=
X-Gm-Gg: AYBFou2ZhfvNx/djIHqjMmuUwS21hhDz7FFvtyAPZAVydKRVK2T2Bb8Bcj0Wfjqjf26
 6F0re9tPQ0sbtx4XnA8PvBiWU7T+X6CrKaa00COrcum9NXXLaqGIwBnpKSjTZ9V8cHFRTwO2I+r
 jFLGSohLk5iLx+o4pko25akQ1HHcvjf8A8FAFU8st/x5DGJAvCMoEl/uu2jOvt+O9KeZDQShK+I
 ++foHbm744+flj+DgP/MyoYiYsG6IC3gKoHjH5eGCjo7pPc2pRbKUgvjySZ0IVXEDU+Zo6KkIXp
 nxs85SvacEe0Go4BS+ToiN0yOnlnCGT2ZYFMWu1+zkOTNiDP+SkV8EdJqhJ6ZotvLiqVpQGjHaN
 LjsKeEujBfbf7/5PTy6KB0cVxQpkE8ENDT3a6x+ugka/phlmU3fon62v3zusVctpYNB3PBja7cy
 Oo0VK1Yf9Z4hxP44nwYup8osnCJPoe+Nif0eJwkRv7vG9oEV+L+wJXXMUPooPa9HZutvTtZaC70
 q4XpTE=
X-Received: by 2002:a05:6a21:3382:b0:3c4:2b8b:e88f with SMTP id
 adf61e73a8af0-3daed217b1fmr21183018637.5.1789267372255; 
 Sat, 12 Sep 2026 19:42:52 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4fb3ddasm14946556eec.30.2026.09.12.19.42.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:42:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 66/86] tcg: Generic expansion of tcg_gen_ext16u_*
Date: Sat, 12 Sep 2026 16:38:17 -1000
Message-ID: <20260913023837.741866-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 27952e3d36b..ce9b5243911 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -185,7 +184,6 @@ void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext_i64(TCGv_i64 ret, TCGv_i64 val, MemOp opc);
 void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cb8436e3b39..dfad7288bb4 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -21,6 +21,7 @@ DEF3(divu, TCGV, TCGV, TCGV)
 DEF2(ext8s, TCGV, TCGV)
 DEF2(ext8u, TCGV, TCGV)
 DEF2(ext16s, TCGV, TCGV)
+DEF2(ext16u, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b07f3a67eed..5c103bb8e4a 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -709,6 +709,11 @@ static void gen_ext16s(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_sextract(type, dst, src, 0, 16);
 }
 
+static void gen_ext16u(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    gen_extract(type, dst, src, 0, 16);
+}
+
 static void gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                         unsigned int ofs, unsigned int len)
 {
@@ -1299,11 +1304,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_extract_i32(ret, arg, 0, 16);
-}
-
 /*
  * Internal helper for bit and byte reversal.
  * Given a repeating matched block of 1's and 0's, swap the bits within
@@ -1595,11 +1595,6 @@ void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_sextract_i64(ret, arg, 0, 32);
 }
 
-void tcg_gen_ext16u_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_extract_i64(ret, arg, 0, 16);
-}
-
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_extract_i64(ret, arg, 0, 32);
-- 
2.53.0


