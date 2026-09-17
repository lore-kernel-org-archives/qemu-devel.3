Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE92C982C1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73rj-00067g-UA; Thu, 17 Sep 2026 00:36:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r2-00041W-40
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:12 -0400
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73r0-0007y4-Cf
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:36:11 -0400
Received: by mail-pz2-x0e.google.com with SMTP id
 41be03b00d2f7-cc1cea4c7a0so195826a12.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619768; x=1790224568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=V6/XatSt+9Z5qJp9S2fZs29JeeUqwriGzVhNU7qPSbo=;
 b=eNktkJTakGPK1mAUDVobtsFDO7A4e7jGPfTq/305MGdtGxR7D4ZZoMbIGgq7bWhrZs
 qtYHZSF8rgpc4Rz0oI6sMj8KvhjNYgoCejEe5EV3MyLTDf8umbrXjyJOBn39Zv0bGuQg
 k6NIIg5CEkJ0N3ov6iFbb6xpPFDPnaNB4M68JZ0463ZCUC7/fPmJE5PtG9PReWiqk8q4
 fjw0VZH+seQAtEvCcjtW3/hnISirQrynEfkZtxh9FQ9Xc5ZAo09Ho3FURwSDQls0A/fX
 obmjf1i8inNGKRan5KlxWsAB0TFW/d3ZqozAd9faZ9Ah7jbEVCcSV0c2Bf9+hKaMxMG4
 ZcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619768; x=1790224568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=V6/XatSt+9Z5qJp9S2fZs29JeeUqwriGzVhNU7qPSbo=;
 b=NE6dFfYmRNeCuoaSZfxIzFueV7+ZFaWPpoLUWmpQ69M1FXyueS4vaPQnn5/NnOBKsU
 8PCAKwxHuw38Uq9HtuxwJer7d4d2v2LQhflSU/+UeZfcvKUTCHdaBmwJXkfHBPjVm7Vc
 uSW7E51MrZCDB8dzPRO6b6nnPdI/oBrXuZmfatU5NxiWlQWdAtTg8WCMNeANsq6DlkTF
 pTBLN+LbDKRiE6qrSRExHmE74uVl/CeH3oaprTCR5NAg4AoGLyc0/40KOyKgLw++RpVe
 LsBc0m8RzJT0ih/48reAYBryYcq9+qCIwZbQPROaNoh6a8tzkt+qB9pwEkUwPXAf7fpa
 6ttA==
X-Gm-Message-State: AFuF++lxp9VNqG1ifvXjpGYiFD2Tk7FhbleiHbMbP5/4fdw/MX1iafb0
 hImTVGHzTP/xJ6cWs9ctnTyy61tnytyKXKP7V5NnfshAKpGOigX5FlHQBjmMClJIMkXyps29l+7
 08paA
X-Gm-Gg: AYBFou2DbBZnf52dRparZ/4mdtyG96jQVYsut9tEkoBAuVKvAUTqeXZ01PdXkEn5LP/
 +J7JlJZraUSgYM9l0He8nTrFMAQN6w0bnPnTUpiKDLDV8SZ7nhpHd0QYu00zs9OTgehp9aHBIsU
 X39ur9VJcbdzDZOkUWY3gqK5gHS46aI3ms8+0eALBeepOFxfeBdyOFLjfIGjpyc0nem6zEoo0vs
 Jdf9RX5pscQej1/29FBZVWfrT2n9/kUXDDiQ7KwMHVRxtuKTTY+5q7RAjO3yCwdOC5BdnjO47/E
 /OH1os1ybHKo2Ojj0Ts4yge3MWrf1PpKUxJmEXiKxcPYStxewdL0rMZTfIv+tbmH5iNshw2FOQP
 Uypiw0+oFc7M1/f1XGgeAYemg3Icrltxj4RE22TE4mFsVfQopdWdbpgq6Zqst7x0juq6Ozjv0Pb
 38j4zwjx3TgWRKuBSdWGffwYLMmxnTwkohC8DOBhgTJbC9kE6+dfHKk62fAuGpfnku+hWTbjeJ8
 NWJ/kM=
X-Received: by 2002:a17:90b:1845:b0:39d:f259:3363 with SMTP id
 98e67ed59e1d1-39e1e491d27mr13164071a91.12.1789619768087; 
 Wed, 16 Sep 2026 21:36:08 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.36.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:36:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 096/101] tcg: Generic expansion of tcg_gen_st_*
Date: Wed, 16 Sep 2026 18:28:18 -1000
Message-ID: <20260917042823.542588-97-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0e.google.com
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
 tcg/tcg-op.c                 | 17 ++++++-----------
 3 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index a6b479ab2d8..942d8168325 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -142,7 +142,6 @@ void tcg_gen_dup_i32(unsigned vece, TCGv_i32 out, TCGv_i32 in);
 
 void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
@@ -166,7 +165,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* Size changing operations.  */
 
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 4f630f7e32a..a002163b04c 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -69,6 +69,7 @@ DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
 DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
+DEF3(st, TCGV, TCGv_ptr, tcg_target_long)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF6(sub2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 539911ff94e..9216e8cb95d 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1374,6 +1374,12 @@ static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_st(TCGType type, TCGTemp *dst,
+                   TCGTemp *base, tcg_target_long ofs)
+{
+    gen_op_tti(INDEX_op_st, type, dst, base, ofs);
+}
+
 static void gen_sub(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     gen_op_ttt(INDEX_op_sub, type, dst, src1, src2);
@@ -1535,12 +1541,6 @@ void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i32(INDEX_op_st16, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i32(INDEX_op_st, arg1, arg2, offset);
-}
-
-
 /* 64-bit ops */
 
 void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset)
@@ -1568,11 +1568,6 @@ void tcg_gen_st32_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st32, arg1, arg2, offset);
 }
 
-void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
-{
-    tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
-}
-
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 32);
-- 
2.53.0


