Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21B4C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83A-0005H9-AL; Sat, 21 Jun 2025 19:55:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82X-0002lT-Ju
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:29 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82V-0005D8-Jp
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:29 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2345418b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550066; x=1751154866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iV8qD1Z9hoTfgIr5MyQeZ7xaeg1BLRsmHYQz1Flk+L0=;
 b=qKTlZkUKU1l5kt3jyGsUQUXt767B/ialu2tqe0cCLTngddptvs3qWXeJ+s/hlQhwj2
 WGAKDjIvfquxmWai3GpSggU8MqVOkj257RQOjbhquwSon0+HUY+/FHmzZDShTI4Kev4b
 OwagZ+kEeVX35W3l3mYf7C9AfL9vOajQyXhHZvTdVszJjRS+7+cV4ZlOOtscHa6Codab
 ZxkTXm6koN/oxiE6lWKWmXfFtQp8ToBvJg+MNaKQWUgyGxK8W8AX1uTQBxZjZZl3qehj
 7AhWxAyzpkTXPT1V25FFUimFmg3/O8fToPicMcJQRP/eVY1XY2GM72J8qOQxJz3KydKp
 oqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550066; x=1751154866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iV8qD1Z9hoTfgIr5MyQeZ7xaeg1BLRsmHYQz1Flk+L0=;
 b=eS/k0TIp4pFUSUVJn6w0RtN0lC7VW0VX8jiMlfBZm7PbKJL8Qgm0RjCJBIJ5o+6IjD
 HE2BjzR2jDnJziWJOPIEaL5H6oSn9y2wnUithf/c3sl6NFo7UhFSmkuCLMqTecMkm3Jy
 eb3j9jEAeHpjXpL5NQ7muHFhvwU2oABIJ4m64hxyhV76avcEz0gEJbcg9IB5HXH1icLC
 hWKuXRT0S2xbh3w1pQUcLCGY6QvZqKe4wbLQpRf5ZLDh1SfXGZf8NK+YsV8QZbYc7eq8
 llZahQ5QkfWuHvuVhQfHTT6uk1fXoKnrDfELXnDqaS+8IV/z+52fsuSnosqB1gCbHqS1
 ab9w==
X-Gm-Message-State: AOJu0Yxex4g7tPi/WmG65rQCBXS3u5njVZa6dJFXCJug4tvGwNfUAWXG
 oEPPnJfr2THy/xQQCANimOnf5UU/CRT92fNQMelXqy/emndc6yCG3HiTIK8ESuBDweg/OuiBzjf
 2VJ6k27Q=
X-Gm-Gg: ASbGnctWmNga6FcaTLYSh6P4WrRuyFm9NdeLa1oo4r0bJdEc5j7K6edR12N5As0r72M
 2ZnLeycDQeayKI7GTBCCTyGyZP/Ni3Mdg+8aVOJiyjkswPrSlMEGozmcxxdgZNI9MBwECfc2wJV
 WppRENyg2Ok5Zre8R9I70FD0X3kxbNFEHmGrO/62/qPAM1a6I/mWbDiEej96HiS/DzsiINLAuAv
 r0w2B4LanNXzLv10zqwSITnDDTATiou+7KJD9vI/iothDGuSPx7C9BjbUEh38x+v3RNBjFT1LVl
 mJPMzm1DzD+ZUGLP5EReBpRezlmzHDIv+GKSmaRv0R2g8u9FVkEa/5Rx3HZWD5AtNWpss/o89iB
 HeyfqrQzgVOxkud5RxeGl
X-Google-Smtp-Source: AGHT+IE77bcv1BxvfvL1weXef8nWn7L4d7Dh4p2+tb8VUAlEPmxUFXOEj9xMD0cn67l7+HO+x7jxsQ==
X-Received: by 2002:a05:6a00:8590:b0:742:ccf9:317a with SMTP id
 d2e1a72fcca58-7490f5c8896mr10229473b3a.12.1750550066114; 
 Sat, 21 Jun 2025 16:54:26 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 074/101] target/arm: Move scale by esz into
 helper_sve_while*
Date: Sat, 21 Jun 2025 16:50:10 -0700
Message-ID: <20250621235037.74091-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Change the API to pass element count rather than bit count.
This will be helpful later for predicate as counter.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c    |  2 ++
 target/arm/tcg/translate-sve.c | 13 +++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index c32354142a..dbb88e9a39 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4150,6 +4150,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     uint32_t oprbits = oprsz * 8;
     uint64_t esz_mask = pred_esz_masks[esz];
 
+    count <<= esz;
     do_zero(vd, oprsz);
     do_whilel(vd, esz_mask, count, oprbits);
 
@@ -4182,6 +4183,7 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     uint32_t oprbits = oprsz * 8;
     uint64_t esz_mask = pred_esz_masks[esz];
 
+    count <<= esz;
     do_zero(vd, oprsz);
     do_whileg(vd, esz_mask, count, oprbits);
 
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 235022110f..5e747b1424 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3181,9 +3181,6 @@ static bool trans_WHILE(DisasContext *s, arg_WHILE *a)
     t2 = tcg_temp_new_i32();
     tcg_gen_extrl_i64_i32(t2, t0);
 
-    /* Scale elements to bits.  */
-    tcg_gen_shli_i32(t2, t2, a->esz);
-
     desc = FIELD_DP32(desc, PREDDESC, OPRSZ, vsz / 8);
     desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
 
@@ -3217,7 +3214,7 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
     op0 = read_cpu_reg(s, a->rn, 1);
     op1 = read_cpu_reg(s, a->rm, 1);
 
-    tmax = tcg_constant_i64(vsz);
+    tmax = tcg_constant_i64(vsz >> a->esz);
     diff = tcg_temp_new_i64();
 
     if (a->rw) {
@@ -3227,15 +3224,15 @@ static bool trans_WHILE_ptr(DisasContext *s, arg_WHILE_ptr *a)
         tcg_gen_sub_i64(diff, op0, op1);
         tcg_gen_sub_i64(t1, op1, op0);
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, diff, t1);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op1 == op0, diff == 0, and the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_EQ, diff, op0, op1, tmax, diff);
     } else {
         /* WHILEWR */
         tcg_gen_sub_i64(diff, op1, op0);
-        /* Round down to a multiple of ESIZE.  */
-        tcg_gen_andi_i64(diff, diff, -1 << a->esz);
+        /* Divide, rounding down, by ESIZE.  */
+        tcg_gen_shri_i64(diff, diff, a->esz);
         /* If op0 >= op1, diff <= 0, the condition is always true. */
         tcg_gen_movcond_i64(TCG_COND_GEU, diff, op0, op1, tmax, diff);
     }
-- 
2.43.0


