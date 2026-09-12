Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E99C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1b-000515-Lh; Sat, 12 Sep 2026 06:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1M-0004nu-HP
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:44 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1K-0007HC-My
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:31:44 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso1804600a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209101; x=1789813901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FEuaQSDdbqE/uYjVAh6LP8f0r8b/FZVYcE/+IlgaBM8=;
 b=SVrCt3dPoSulYAs2kUoAsqivfdm2QXZKN9Nv9cpgiXf6zTQyDBM97naoJgmdM2JedA
 SPU9tz+Cn477wtObSJj1MJKnsy98/ujRP6GnLbbOwh90NJh7c/R+e7DLmUiRQeFNTGCH
 fFRMySywvbupcwjjXO8bKxrEbozy55pZ6rpLrz2TBZlTsHAjoYIroOXDxM7mNkjSqlwv
 dCg06aXzj++laCRsFRnQ0EsDC5uSb9T0lkn8rtIHB13BblxYtC1oDo03XHycZkJbmJRS
 vU0gQdocI6uVDYvTHH+MVjShCBOWrbQRHlU8WJ26zAcQkcKv14IH6cJ0h95Q0w4u5Bsd
 nmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209101; x=1789813901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FEuaQSDdbqE/uYjVAh6LP8f0r8b/FZVYcE/+IlgaBM8=;
 b=Kvy5KwvFnYV8GI5VQnzgQmBM3t4MYgvdqy6PsVOBaPxYhDfEpDL+l3WxWswX1Dyt9o
 8Uslv9tFcmnrKryN7aB24IORnh6aQT699H8SwgRynGeX43QwYbjs2zuECvy8/RYJmQFV
 LfF9qUXK5ULJvVfaTiyT6BPvbOXKdjJnXEDHvLREZJV7nkWFlmr9W4wEhhnY90sf2lmV
 ZEOz3GFc8sIcSuy1VyOdy1QknYpBGzO/H2yxhk+cnLqa6SNAdMUPvLLfmwr4120v+odL
 XGo7jg91ehRLvju4fmR5OXxLFnEQhaJtzUwPMA2163qFsMQRqF/rCU1/8kWS4P5+Pxyn
 uGLQ==
X-Gm-Message-State: AFuF++lGcgTwJG3PbzbYsqhf7fEDa0167x+1sK4vfs5U78ly64+lh+lt
 upXSDCLc4n2YWXj9ajfB9HCP45+6BHm8KKx2u8awZVkccvlRQFslGLfkcJaFeuZLxVcTviAme0L
 GUjdvxEo=
X-Gm-Gg: AYBFou2p64XEs20ZUbOEGz5wrK5OdEXzqIpRJleo+2fpzuAnA++yOT1+Tsb7phR/jss
 w0DPfT9OuWJAt9zzvBMDXU/EEWfk38rQ5i5Pa4OboUugbiiaAXNU07hRFyAuZSXHxmWvqu89WXX
 kDzRFyfaMzDeg2ZVaJhiBIjZxg1nGOnLQnbT36KDtmSjwPFIKTH5K2XmSFau8ELLNGvjopv2EMr
 3uNx4FHZTyQH9AenoDayJzI78h7DXOpN7fBTiZqnA+B69lR1Zj3PNiVfaMA8I5mCnGjQjvnQGGB
 ALDlRRd9zefI0VKhLnMMUslUDvENF38wxCuXBu32mOm1uo8VkFBJW8eWtGZpKJWifk8ml50lWlR
 jHBOStJ80v0ZLqHL/dxeQ12sXlyMLQSUTXiO3tQ1O1U615/219FJluRTagdZfqHeUdBrOH/Ho7l
 iZEf4uhLx3kLsvGmLGVLx9gxkwqXiAETHSSLV8RTTQ1v5DerzuSGqQvRoAwldfLuVd31u9ESoI+
 6JziTc=
X-Received: by 2002:a17:90b:2689:b0:398:9bd1:3211 with SMTP id
 98e67ed59e1d1-39d9c21eb06mr13477991a91.18.1789209101216; 
 Sat, 12 Sep 2026 03:31:41 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/82] tcg: Generic expansion of tcg_gen_or_*
Date: Sat, 12 Sep 2026 00:30:17 -1000
Message-ID: <20260912103126.598030-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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
 tcg/tcg-op.c                  | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index c957cc95b1e..9d309fed4ed 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -208,7 +208,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -314,7 +313,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index ce21bf5b965..e42f57a7a8f 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -9,4 +9,5 @@ DEF_RRI(addi)
 DEF_RRI(subi)
 DEF_RRR(add)
 DEF_RRR(and)
+DEF_RRR(or)
 DEF_RRR(sub)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 5d0ffe4d70d..6e00dda3ad0 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -394,6 +394,11 @@ static void gen_neg(TCGType type, TCGTemp *dst, TCGTemp *src)
     gen_op_tt(INDEX_op_neg, type, dst, src);
 }
 
+static void gen_or(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_or, type, dst, src1, src2);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -482,11 +487,6 @@ void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     tcg_gen_and_i32(ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_or_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1520,11 +1520,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_or_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_or, ret, arg1, arg2);
-}
-
 void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-- 
2.53.0


