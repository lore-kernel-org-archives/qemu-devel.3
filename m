Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F376C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rZ-0004zE-9e; Thu, 17 Sep 2026 00:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r3-00048q-Ha
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:14 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r1-0007yN-Fi
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:13 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso372250a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619770; x=1790224570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fWPVvphMxFaV7wkyvg2KgJ5icmQKQuyffqXeud25IRo=;
 b=ZiHkRZ+RgqYBA4IRg5d1Rfb0/h3BRTZui5XrJiMl8pB/2lO/eh4Ds5yGyk4fxk8wwn
 dl6D0zASp5US+BjZsQCIWREDtPbfNNS6ahKMP3VZvHL1yAHn8MglLo0HGCKKIeu3slXA
 yDqD+PCD6KRuDMPdpjT9brJM1qGuLhX8L2mGgYRSctWr7Yqf1HmEXYuBuccvWfNpEUeo
 8eOHXGDfaObBSi9uxZDehJ//K2vZ2wB7N7CK8F3bGmM772dentgRVUf9henSvu41a8dp
 Oh84VHK3jJGkVjJR4xCoO4Swb57F4PJZ23PW2Xfcc4GOCqsYrCEPXv4/7v8Px4L38BV4
 KFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619770; x=1790224570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fWPVvphMxFaV7wkyvg2KgJ5icmQKQuyffqXeud25IRo=;
 b=T1cRGgnyA5LKRH5fik0TDvcqMq3Fpbg8INVycx7MkQ/7hcBAwqZ+PQWmxGNHnVd/ap
 WquF4bW8Drtv9SC+lVIFlOaQtsxL05b8Kqbc0X2S31dHMCpEc/Cw2abGx6jow+zUsKBj
 fBQZseQWUMifghcG+GCbx5JfV8o0mU/wySC2QGymGVE+3UmAN0xZ1loTF0Y5y/Rv+SK0
 fUIiBgu36OpRWdTBGw3pTqn6piPg8P05fyiSunrd2ymZPw1PeX5Gt3w1Dyfo3dVZIUjc
 h4Q4A/UOrsUzieb6kQJXMRYmRGwAIFUQCPi6935s1F53JdVNvzjm71CQmZn3k88DPgeJ
 Ri3w==
X-Gm-Message-State: AFuF++lhcvF3eYSYGW0Dr9v0HGTwCJcb2X7VFb/lZQE2bmUiOQ6k6/RO
 T9+brjImVnRK/HeZNtpTQlQ9amfhMsCUNpXgE2/8QhCLDbPiZbthwWfFP5CnN+WCWFFQVzt1QhT
 XqHxbjG0=
X-Gm-Gg: AYBFou0tAENTBNpHzLpHAYmLhUu8EWTui6OD00RBw3Xy4BrKl2dygb7MIzK4fi07j2Q
 KyhoBv0FbNjqd/0FV6BlfYkCWTrmIO9Lf0OkATJDbpGv1IzZCk7zQ6BElFx2Fb6Z9csRSaVhN6Z
 eKS8IO5LSdiPYARjmf32FZ3yY81pp4gmVdvaOb/kesW0HywH6+EcELz/RmmJWTMfMIHJjIYKeqE
 u2HGBKYQDLIRvDfjo351FndD2iFYS78du//L5U318Xathxbx8X91iQ+QNIiLTI68WoS3mIqhEoj
 NE14PihnTHvxo4lCBO2tIJ6s1A/K0Z172bRONl+XYgXXpzhYTlfL14lveOWO57o2LdC2WHg7wRT
 YgfbtYEH7ZZV4VFCZ5uGx4IZbcQWggoeeKfcDv0b6HznxGmrM6aYYurwLY+ElLOHgkjCtRyB1Z/
 c02z4h40yNdRZpWdVDnVjLqEtOC0KKrIQlS3WF41PctYRnXe1RZSaMQSJO1c/vvtBAirJhfVtvq
 5nia1Pw0+gHxUVtxg==
X-Received: by 2002:a17:90a:f09:b0:39e:218c:d47c with SMTP id
 98e67ed59e1d1-39e218cd674mr9282258a91.9.1789619769924; 
 Wed, 16 Sep 2026 21:36:09 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 098/101] tcg: Generic expansion of tcg_gen_st16_*
Date: Wed, 16 Sep 2026 18:28:20 -1000
Message-ID: <20260917042823.542588-99-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h  |  3 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 23 ++++++-----------------
 3 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 0640774f8b1..604ead6b5ed 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -140,8 +140,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
@@ -158,7 +156,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
 /* Replicate a value of size @vece from @in to all the lanes in @out */
 void tcg_gen_dup_i64(unsigned vece, TCGv_i64 out, TCGv_i64 in);
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 0bb9f894564..5657636fa2a 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -71,6 +71,7 @@ DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(st8, TCGV, TCGv_ptr, tcg_target_long)
+DEF3(st16, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 080c7ce1982..9317c9ca792 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -203,13 +203,6 @@ static void DNI tcg_gen_op3i_i64(TCGOpcode opc, TCGv_i64 a1,
     tcg_gen_op3(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3);
 }
 
-static void DNI tcg_gen_ldst_op_i32(TCGOpcode opc, TCGv_i32 val,
-                                    TCGv_ptr base, TCGArg offset)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(val),
-                tcgv_ptr_arg(base), offset);
-}
-
 static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                                     TCGv_ptr base, TCGArg offset)
 {
@@ -1386,6 +1379,12 @@ static void gen_st8(TCGType type, TCGTemp *dst,
     gen_op_tti(INDEX_op_st8, type, dst, base, ofs);
 }
 
+static void gen_st16(TCGType type, TCGTemp *dst,
+                     TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_st16, type, dst, base, ofs);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1537,11 +1536,6 @@ void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg)
     }
 }
 
-void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
-}
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1554,11 +1548,6 @@ void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_ld32s, ret, arg2, offset);
 }
 
-void tcg_gen_st16_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st16, arg1, arg2, offset);
-}
-
 void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
-- 
2.53.0


