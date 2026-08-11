Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A947EC5AD55
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 04:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wteXA-0005N6-ER; Tue, 11 Aug 2026 00:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX8-0005Kc-MU
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:14 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wteX7-0002lx-0q
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 00:56:14 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2cf452def93so4934695ad.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 21:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786424171; x=1787028971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mX1Ch6DIv6V+2IbNfj0xC7mrUQ+BRvJBIthY/GhxMik=;
 b=mwMnAEZXLk7JO1Q7cQamSWQw+hI4uYRIeZLMi8T9XMgtUfnwThYxkWXNJBEGrkadIk
 5zUdWEZBkUtJzCm+5drcmLesa87v+kkXooAny3Z1NFa49YgG0mV2j67qJGfnr0yqLAa/
 y7bixMMN5Oe6sLwGV3kgg7DFwXKSDrS/q9SnDjDTMT76kzmarE13S5ehh+Unw9eZhI58
 GnlqcIdt4nD6yQs7dnhqjiiyqTQ6y/djkpl2fnJBI5ox4Pn6FUCHwmzTEFXDkda45gQV
 A8hza91H/n788lxeO4gIvBONhuADX1ijWj+Xi15k7LWglL7hIC98jOD9ciTzR0ccqWkw
 hcrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786424171; x=1787028971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mX1Ch6DIv6V+2IbNfj0xC7mrUQ+BRvJBIthY/GhxMik=;
 b=j7URYfzfDndmwGQ5PCpWVs45AkdalV1lXacUWGxXQU96uXC3MUkOM2TksweMkwPaLW
 zh75e80dArHgpQljlXY4iOLTDmnS9ZnYb3XlV8wmHobzNRUi7k7cPE86YE7mwfhBhU2t
 Q/Hwvn0ULNnjhdjIugFO2BRG9XqAuX0YmYATA+ne/dTwbt0QqQh1whoJE3Nh49rdfQjO
 H3Xj0ds2rIAiuMhwFrcjqjQDI/KnI8c704A+yE48DjMTu+XibvDhs8uZAgkSXItgS7UQ
 fEtL2WTXTd1amn9jKLbioLPyk4OO9Gjzfqdhkqd+i3Ds4ENYL4ouMFjuPQEATqS+VX/M
 lZsQ==
X-Gm-Message-State: AOJu0Yx9zYFDMMm+ns8WiTUkik4nVtxLZBBvrkYoYsBO6HC4X1wyZUDy
 7fw8Ara/o5SqmMAmxuNQQMmAvB5BFBorcnQPuCfMr2c/XPoufIbyyGUqweOoD9p+Bv/L8vaQOk5
 XJcXW
X-Gm-Gg: AR+sD107OnHODK2kHHqRuDX4ONaKJEpRZdHJRLUvo/kQTdi6X84adMmmf6rrSyigmc5
 gwKMt/GjhcA2Hr+hwZXkxyhINPn5Q0PCaqTkwpyiJOHF8t9Hi2xKOfHzsFmm7TLXo9hefGBNUCo
 YpWLuEBP/YXSIxJtoQiBHQlFJV2GT8eEiQSHhwy8ygs9QzYbyjLpdNe0mwvr8T7gc+ymFDQ9cO5
 a24RBC+rzbIB+4LJclCEykEZbiUeWqNcsccaqWhlz0yFL6OKCQBk7/8pEEz24UGsu64UJ7KDOWM
 DKFABjv70EnI3HEEdzefi1a45MM9SwTWdRqhYTiImvdblg7A7WmtONrBNPS+sBxKIbQoqirj8CV
 BGQU6xSlIOc9P7WLzhSHZSWN5AfOTFC/Xew83cVd3u/Wlhp0g63RbsmGJ6i4m8/hPQOcrQKDlg4
 IAvLF3ES2YExLjwojfHdvx91gBL+CBsgjeHYghQPvBo0lQ8/UlBdUKoZbNbkXf8SNoi65Z5HbEH
 i5C3+aTuF3Ph4wWHNsT
X-Received: by 2002:a17:90b:2dc5:b0:38f:de94:bf34 with SMTP id
 98e67ed59e1d1-392edb67346mr143316a91.10.1786424171350; 
 Mon, 10 Aug 2026 21:56:11 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-392ee3084d0sm156818a91.8.2026.08.10.21.56.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 21:56:10 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <17746591750@163.com>
Subject: [PATCH v2 05/16] target/loongarch: Use generic tcg_gen_revbit*
Date: Mon, 10 Aug 2026 21:55:54 -0700
Message-ID: <20260811045605.1246543-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260811045605.1246543-1-richard.henderson@linaro.org>
References: <20260811045605.1246543-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

Reviewed-by: Song Gao <17746591750@163.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/loongarch/tcg/helper.h                 |  4 ----
 target/loongarch/tcg/op_helper.c              | 21 -------------------
 .../loongarch/tcg/insn_trans/trans_bit.c.inc  | 13 ++++++++----
 3 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/target/loongarch/tcg/helper.h b/target/loongarch/tcg/helper.h
index 8a6c62f116..e76c73c775 100644
--- a/target/loongarch/tcg/helper.h
+++ b/target/loongarch/tcg/helper.h
@@ -5,10 +5,6 @@
 
 DEF_HELPER_2(raise_exception, noreturn, env, i32)
 
-DEF_HELPER_FLAGS_1(bitrev_w, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitrev_d, TCG_CALL_NO_RWG_SE, tl, tl)
-DEF_HELPER_FLAGS_1(bitswap, TCG_CALL_NO_RWG_SE, tl, tl)
-
 DEF_HELPER_FLAGS_3(asrtle_d, TCG_CALL_NO_WG, void, env, tl, tl)
 DEF_HELPER_FLAGS_3(asrtgt_d, TCG_CALL_NO_WG, void, env, tl, tl)
 
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index e63ac66daa..f41f0cb1e6 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -22,27 +22,6 @@ void helper_raise_exception(CPULoongArchState *env, uint32_t exception)
     do_raise_exception(env, exception, GETPC());
 }
 
-target_ulong helper_bitrev_w(target_ulong rj)
-{
-    return (int32_t)revbit32(rj);
-}
-
-target_ulong helper_bitrev_d(target_ulong rj)
-{
-    return revbit64(rj);
-}
-
-target_ulong helper_bitswap(target_ulong v)
-{
-    v = ((v >> 1) & (target_ulong)0x5555555555555555ULL) |
-        ((v & (target_ulong)0x5555555555555555ULL) << 1);
-    v = ((v >> 2) & (target_ulong)0x3333333333333333ULL) |
-        ((v & (target_ulong)0x3333333333333333ULL) << 2);
-    v = ((v >> 4) & (target_ulong)0x0F0F0F0F0F0F0F0FULL) |
-        ((v & (target_ulong)0x0F0F0F0F0F0F0F0FULL) << 4);
-    return v;
-}
-
 /* loongarch assert op */
 void helper_asrtle_d(CPULoongArchState *env, target_ulong rj, target_ulong rk)
 {
diff --git a/target/loongarch/tcg/insn_trans/trans_bit.c.inc b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
index ee5fa003ce..b91bb7eaa6 100644
--- a/target/loongarch/tcg/insn_trans/trans_bit.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_bit.c.inc
@@ -178,6 +178,11 @@ static void gen_masknez(TCGv dest, TCGv src1, TCGv src2)
     tcg_gen_movcond_tl(TCG_COND_NE, dest, src2, zero, zero, src1);
 }
 
+static void gen_bitrev_w(TCGv dest, TCGv src)
+{
+    tcg_gen_revbit32_tl(dest, src, TCG_BSWAP_OS);
+}
+
 TRANS(ext_w_h, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext16s_tl)
 TRANS(ext_w_b, ALL, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_ext8s_tl)
 TRANS(clo_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_clo_w)
@@ -194,10 +199,10 @@ TRANS(revb_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revb_2w)
 TRANS(revb_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_bswap64_i64)
 TRANS(revh_2w, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_2w)
 TRANS(revh_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_revh_d)
-TRANS(bitrev_4b, ALL, gen_rr, EXT_ZERO, EXT_SIGN, gen_helper_bitswap)
-TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitswap)
-TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_SIGN, gen_helper_bitrev_w)
-TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, gen_helper_bitrev_d)
+TRANS(bitrev_4b, ALL, gen_rr, EXT_NONE, EXT_SIGN, tcg_gen_revbit8_i64)
+TRANS(bitrev_8b, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit8_i64)
+TRANS(bitrev_w, ALL, gen_rr, EXT_NONE, EXT_NONE, gen_bitrev_w)
+TRANS(bitrev_d, 64, gen_rr, EXT_NONE, EXT_NONE, tcg_gen_revbit64_i64)
 TRANS(maskeqz, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_maskeqz)
 TRANS(masknez, ALL, gen_rrr, EXT_NONE, EXT_NONE, EXT_NONE, gen_masknez)
 TRANS(bytepick_w, ALL, gen_rrr_sa, EXT_NONE, EXT_NONE, gen_bytepick_w)
-- 
2.43.0


