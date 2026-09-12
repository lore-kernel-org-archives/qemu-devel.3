Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B79C88E59
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:37:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L60-0005Rd-ED; Sat, 12 Sep 2026 06:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5C-0001HG-5N
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:42 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L5A-0008Tv-6N
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:35:41 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so17890075ad.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209339; x=1789814139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EGdS1EzhRdJFK/8NNyAnn71d7UhOhRUoQWES/PAECmg=;
 b=ZMIzrN91SH3FWta11bpsk4NFouuaHBR11vcvrzuTcHY01yRKEBsQkD2UWVUJu60mPc
 R4YpH/NhUucINDmYcSO8WL73IHyle56nNr+nM2wpFM+w84XA5ScV50sogD+VWc/jfSIZ
 6bydveZZC7VUeeZNvsJOJ3rWcJk9m6XwBXA4OlvEs4GwFhYHWRiMpGYn+zvekpanrDES
 I6Jj4PI1w9r4Tb7s7ss3sT2BKFNJp+pwJH4Efhc6lfeCfk11MFY4ih/xr6jtB01yOhLA
 RQU28dErLRax4nH1iwMD/LptKkx+b91XJRrtJqvdLj51dc5R3HjDECmLmNfOgczIXtYp
 m7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209339; x=1789814139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EGdS1EzhRdJFK/8NNyAnn71d7UhOhRUoQWES/PAECmg=;
 b=VRQTgiGvn3OdbF4c11xvaFBwO9OWnJsQG3raudv/dD8V8W4q9Z7+iHCn8TE2kJaq2h
 v/mzY/hFB7TDY0qZam/ko7s/DXQm3e5gRDaMJtJE2l8HoMgtgwCaJZYUSwKeKSQZ/ba+
 mjGUGamYDI6bOI1LK4heYRsHdbx7UjuZ0wz6GjaBHyUv2UicH8+LSfmA1akM9q6n6UHf
 TiNXlcXAb0WE2wst9sQtKr+tm4MrJQLM0EAoWJIgR9ArLl0HZt0TFEYW8gvUIds9Onp1
 0vznY2T/q0wj4T+lhg41IRoA/nUX0EmSMzSvn5CLrbHXHzbriuV9k17A2rOJjZYyFQYY
 edaA==
X-Gm-Message-State: AFuF++nL52ROuUakO8oC8kaKM/aWZKFgZTOn7ibGka5jFYjm2Rwz2v69
 7zzgsRxIpA49ja6Hml5BAtI+Sy9nvrYelLxvZJV9vGkgxHnHNOpxKDQ2c8As49Ci3HX8/BjuBFd
 qHOFZ74k=
X-Gm-Gg: AYBFou2OzQjkKaI4tELoTK+0tQeT5Yfe9HulGQLWqvQNFZ0/bgOEztnXE3jyUPSsEhG
 hNN79zP3Tb61N7L4arBfRMJZCeY0T7+LKBJBF1F06JfdVYKK233RcZIsxI5Mrlcgrrj9d9o4WDm
 dOZKXtBq3aIE1j3hKMOj6YJ8URmUg2U0dz2c9NEwMzcJL2yJlbSL/U69Cn6Q0q+1MWauIrUkTWJ
 EdBJSOTuYfyXt2SpDWOdAAev5w1mNNFzM0qErp6gmf4u1+F+6VpSHGKtKfjBBE2rTZIsI7tK24z
 Iur4gsQHezZDtPlUzeLisvckNz7h9Hx9XVtznKPKxcVHPlixHfDsm+7lhOmyK3Uj71JTgOWYN6D
 UQgiyLn35Q5yLOuKytxmz33HE7ac2NsozPH8FZsSp060V/2Do8mUuZMs8TLGIMMe4InpguHu5j4
 JZ6Ox6+53LMTwlMRCOaDEGLd9cug9j5W3m+2Mtf0c9eQTb2z1+P0Tg8zautbj1n8VccSyN/N55l
 ahgC6g=
X-Received: by 2002:a17:902:db0f:b0:2c8:2808:3ec9 with SMTP id
 d9443c01a7336-2dd2a3474bcmr131977115ad.12.1789209338567; 
 Sat, 12 Sep 2026 03:35:38 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f55735sm13673674eec.24.2026.09.12.03.35.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:35:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 72/82] tcg: Generic expansion of tcg_gen_abs_*
Date: Sat, 12 Sep 2026 00:31:16 -1000
Message-ID: <20260912103126.598030-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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
 tcg/tcg-op.c                  | 31 +++++++++++--------------------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1b7f9cf473f..944e26c7d28 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -167,7 +167,6 @@ void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_abs_i32(TCGv_i32, TCGv_i32);
 void tcg_gen_revbit8_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_revbit32_i32(TCGv_i32 ret, TCGv_i32 arg);
 
@@ -207,7 +206,6 @@ void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_abs_i64(TCGv_i64, TCGv_i64);
 void tcg_gen_revbit8_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_revbit32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 4dfe7513e37..745708c1bbb 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -10,6 +10,7 @@ DEF_CRRRRR(movcond)
 DEF_R(discard)
 DEF_RI(movi)
 DEF_RIR(subfi)
+DEF_RR(abs)
 DEF_RR(clrsb)
 DEF_RR(ctpop)
 DEF_RR(ext8s)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index b2b201c33f4..ea99a8842d6 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -367,6 +367,17 @@ static void gen_extu_i32_i64(TCGTemp *dst, TCGTemp *src);
  * are of the proper type.
  */
 
+static void gen_abs(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+    int width = tcg_type_size(type) * 8;
+
+    gen_sari(type, tmp, src, width - 1);
+    gen_xor(type, dst, src, tmp);
+    gen_sub(type, dst, dst, tmp);
+    tcg_temp_free_internal(tmp);
+}
+
 static void gen_add(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_add, type, dst, src1, src2);
@@ -1533,16 +1544,6 @@ void tcg_gen_ussub_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     tcg_temp_free_i32(t);
 }
 
-void tcg_gen_abs_i32(TCGv_i32 ret, TCGv_i32 a)
-{
-    TCGv_i32 t = tcg_temp_ebb_new_i32();
-
-    tcg_gen_sari_i32(t, a, 31);
-    tcg_gen_xor_i32(ret, a, t);
-    tcg_gen_sub_i32(ret, ret, t);
-    tcg_temp_free_i32(t);
-}
-
 void tcg_gen_ld8u_i32(TCGv_i32 ret, TCGv_ptr arg2, tcg_target_long offset)
 {
     tcg_gen_ldst_op_i32(INDEX_op_ld8u, ret, arg2, offset);
@@ -2037,16 +2038,6 @@ void tcg_gen_ussub_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     tcg_temp_free_i64(t);
 }
 
-void tcg_gen_abs_i64(TCGv_i64 ret, TCGv_i64 a)
-{
-    TCGv_i64 t = tcg_temp_ebb_new_i64();
-
-    tcg_gen_sari_i64(t, a, 63);
-    tcg_gen_xor_i64(ret, a, t);
-    tcg_gen_sub_i64(ret, ret, t);
-    tcg_temp_free_i64(t);
-}
-
 /* Size changing operations.  */
 
 void tcg_gen_extrl_i64_i32(TCGv_i32 ret, TCGv_i64 arg)
-- 
2.53.0


