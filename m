Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C7A9C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:12:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks6-0005tc-5h; Sun, 27 Sep 2026 05:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrL-00027u-V1
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:49 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrK-0008GD-98
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:47 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 d9443c01a7336-2df90e859e8so6137025ad.0
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500065; x=1791104865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OflXdFdak4kGZye2JWnaDHf/FnStixzyIa2tWTcncE4=;
 b=yUP+zwzefArgXFomhewBLsBuCJJJzXYzLIMFS193509Wy85jQ5CmMIVl+1c8JsJtDd
 eWGb2CcjetIROU0sdCeRJgeCfANjK2d84S+JOIgtGE5kr7xeAzesJLV2x1g3n9IesTND
 /1pxDEuzesZWVSgipfiSTSRM45+DhHPNKZBEaZ7McYSdJFIxegMy8HIFjUpG/eFfogyi
 PGuO42zzZ1l6wmT+fyBTMeNZnvS0CfT3I6VW18p5lf7dczYtpLn+uNNqz4zL/TvpdtxF
 tBYQoqROS1B5joORDmWXpTHjZEvWMKmceZnyPZ2oy4XBHmoKXR1rApaLVvI74D415VJr
 gshQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500065; x=1791104865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OflXdFdak4kGZye2JWnaDHf/FnStixzyIa2tWTcncE4=;
 b=qaJZIuZiXriQJig8M725U/G7JRsL/GlLD20puIxR0COVyVXUAlWfS4gRJnMaVCLD+z
 gZK5cWslIYsOmqhZolXM+vl3lacCr1NxasgQ5c8HZsMOkLdkfZW4HxJJ1ZDn9UUd7Op6
 wu/513TBMOiAbXieFIB+DW7urEtkiuEOwt8m+Y9lePMs9g0Bc1a8geWa8WQAw2IZjBzq
 zgxojsMjODmAOcayctYcGXnStwaRObG1XsjeX330yzeMTvg9oB/t3ukAjL3vAg463KkZ
 dQiaS3NuV3YlTwRqLTfJHok2flFRy0hXHReiUpK+Ydsjk19f9/rJk2qVvq8kt1T26lpT
 dZoQ==
X-Gm-Message-State: AFq9FYIOK8B3e5wHLbw6Ur5ZkGPjQ3a9q2OPBfqlkYM6bWjEwdMj5pKN
 gnOufQyP2Kpf/R7g9RenBb3/zyYeHmZzF60sD+MijVnzdhyugPPbOHJBF6mEYF2hjyLTavo+2EF
 S5iZq
X-Gm-Gg: AYBFou3Y7Mf8jHtjuCN+H3EHTKjNuEO6FNwJGiqf1ldW6c4HwVe/z6bQVqCyx0CBG/M
 BLwAQklzWiOu1oNDEaLy5KzRLYR/vrgr8O+inUR3GljatGYXgbYG06DQoadZHcco3bFb6ukQxw0
 nptRk6rNoXo+ExU37DmZOnieinjlk5Y5l/KIxAMGsVP185uzcsWsLPBIkkjE3hkjuINAgJYUtU6
 pINpciuEH7w6B4yLVvHP9t9SS+B5xQ1rdCMFqW9Y9PnkY4s+RAOZJJ+tnqsvZHAHYqHm3svOFua
 tXY0N8ZIZCaJuT5EisHPDNNbBw1eVdSxo0cvvkzRwxJQPBZGUUEH6mMpLfh07Rjheor3Ei/FUNh
 E8Xrxs1KGiIy3HVpG2G826oBKby7dT8N2hnRtTP1RXQcG7+4envqaQcQMazrVNgXlyNxwVFhbZT
 chriM+Z/bOwutQ0lm8QPJkTqeUtPZBiY608A1YCm0LshDbQmRYI8ApUJI3l9BiUMvFpq5X9mVwu
 xp9iv9wDMtxHJBAX6qG/OwXG7GZqw==
X-Received: by 2002:a17:90b:5110:b0:39e:6a7f:6187 with SMTP id
 98e67ed59e1d1-3a098ac9ea1mr6016931a91.24.1790500064741; 
 Sun, 27 Sep 2026 02:07:44 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 084/101] tcg: Use unsigned for flags for bswap and revbit
 operations
Date: Sun, 27 Sep 2026 01:59:54 -0700
Message-ID: <20260927090011.10724-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
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
 include/tcg/tcg-op-common.h | 8 ++++----
 tcg/tcg-op.c                | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 5f73601ddf7..7971619ba92 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -133,7 +133,7 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -158,13 +158,13 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 
 /* Replicate a value of size @vece from @in to all the lanes in @out */
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 61d50294a68..e593a4d8758 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1305,7 +1305,7 @@ static void gen_bitswap_i64(TCGv_i64 ret, TCGv_i64 arg, uint64_t mask)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags)
+void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1506,7 +1506,7 @@ void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1549,7 +1549,7 @@ void tcg_gen_bswap16_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
  * With TCG_BSWAP_IZ, x == zero, else undefined.
  * With TCG_BSWAP_OZ, y == zero, with TCG_BSWAP_OS y == sign, else undefined.
  */
-void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
@@ -1616,7 +1616,7 @@ void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg)
     tcg_gen_rotli_i64(ret, arg, 32);
 }
 
-void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags)
+void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, unsigned flags)
 {
     /* Only one extension flag may be present. */
     tcg_debug_assert(!(flags & TCG_BSWAP_OS) || !(flags & TCG_BSWAP_OZ));
-- 
2.53.0


