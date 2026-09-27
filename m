Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D61C3C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkpe-00005E-Sv; Sun, 27 Sep 2026 05:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkoA-0005Bc-LC
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:31 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAko4-0007gC-Oq
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:26 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-398a147688bso1553220a91.1
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499863; x=1791104663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5L8yVK4ncB9UnbbLeWRaxEzRDbg26f8jPxDocOkjPv0=;
 b=FhR1XnH00/n3FhCIr7KTQXL4TuN5I0ukBkBZ8Rb0Ob0/XnQowieHWR9AwNuaFtI0Zs
 oQGBsiXKR7+5e3fRhejjZEaABZA1A/xQZYhBFYLDGcXfR2D4qaEVpbq5Gsh8AE4x4WaL
 Iev8OUeAbTnruOdHacwUmtW8NDPClERA26DDm9Z5g2184M9yOH5NH83bRuL3dFmTeiA4
 sHNu/5uH+X40ooFYkdl3KityvL90lmRNzbpveLkdySfer0mVhYJ+0oVT+jLSfxtnLEwp
 ZnmTkheTN+YzGOX59X6cj8RdaRc2BlEYO4ENdG4QrVMNrCTxTabhroH/pFJJ+bIfnszX
 WzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499863; x=1791104663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5L8yVK4ncB9UnbbLeWRaxEzRDbg26f8jPxDocOkjPv0=;
 b=YKW3jJkFDIX2g1bMO7M9eNQ1n9G76DCo3uenMTiGQUB17zZMyU0waBRGxRMtYzHrzM
 SS7PLobEBnQiJSC3DQS0EPEDS46IfbWOoSBtJPoC9FOhtxxvakS+DQI7jyMoASJfVX38
 7Myhv5GCcTBdfdGa0vDzFw35T1pwP906+ElVjm2eC9WVk8RmD4nBPWN8V80pPrtVFX4c
 EAqDQmmWOp6kYHF/CYv5FgO9eAF/Nk11yT2U9KPNvfV0MmAlUBe2CZA6zXgumtZY3Hcg
 z5GxfvVE1FRvKmYU25QZ52CJYVX+g6D3A1W23xpkAFhZEo3qY2scSRtR3WjGqoakm6Jr
 gUGQ==
X-Gm-Message-State: AFq9FYKXwxab0KM+viRwtYCfni9XoSwTjgxuUwV9ywZC/1MRN3eG6uTQ
 meKvgsIRmA2s2HS7BwHossmC8M23dg7qVAOIzryWxbRdUiebKzNhBVbMeEXsZBs+Dhy9pgrZFmE
 fO6Qr
X-Gm-Gg: AYBFou0x6xo5DsfUtmWsNDueCmIwetIpr0Fd6tBNX1cVSDx3qqgv5vItKRGuK/oPHn5
 Wjn6+anDf87KpffgieFVtJFd87qEBpopjVmzSkHisP1cP+f1N70QqEop5QgGI104ILRfiHYY750
 oailEyQkoqaPSBwvt7L4tUPXVyUmYH3A7gvVcWpnLYIQ2UrTjV2q6iLM9vrpYc6A1n6KHprIKZf
 FAaoMLawlCQZcEDuVAHnJhbrgmtiraM3vXSXAMoBi3jgvmAYe8MChBktVDJ93/t7aia0TxY+KJA
 YmBL3fb+moU1+zxcitCzSWhwq/jd1viTVbRL/c5+nQYQit2Oim2wb5KE6Jhk0YJl8Uy9ol0fH1I
 l7zVktDjIuMmmVNJMFQ3q0iQDYFVJeV00FMpI0F9ccyKW7IGsleUdW4ut3XXUia00LaRRhj0gJN
 x0rf4DQUBKKhP0gjB0lWncZtXONTY/LxX1m23JC8MnNAojXXEc6f7s/s3xN9g7AhMIaibMMmodv
 UbSyRtF4G+is1orrLh1ZE88L1W+nQ==
X-Received: by 2002:a17:90b:3c05:b0:3a0:e5ed:ef99 with SMTP id
 98e67ed59e1d1-3a0e5edf00bmr2473299a91.45.1790499863327; 
 Sun, 27 Sep 2026 02:04:23 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 066/101] tcg: Generic expansion of tcg_gen_ext8s_*
Date: Sun, 27 Sep 2026 01:59:36 -0700
Message-ID: <20260927090011.10724-67-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f80e9dc2e29..52752db2655 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -143,7 +143,6 @@ void tcg_gen_addcio_i32(TCGv_i32 r, TCGv_i32 co,
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext8u_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ext16u_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -187,7 +186,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
 void tcg_gen_mulu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext8u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 88e87ebc2f6..a5b2bdcb432 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -19,6 +19,7 @@ DEF4(deposit_z, TCGV, TCGV, unsigned, unsigned)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
+DEF2(ext8s, TCGV, TCGV)
 DEF4(extract, TCGV, TCGV, unsigned, unsigned)
 DEF3(eqv, TCGV, TCGV, TCGV)
 DEF2(mov, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2e5bc1e8200..6dbe396afc1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -600,6 +600,11 @@ void tcg_gen_eqv(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_ext8s(TCGType type, TCGTemp *dst, TCGTemp *src)
+{
+    tcg_gen_sextract(type, dst, src, 0, 8);
+}
+
 void tcg_gen_extract(TCGType type, TCGTemp *dst, TCGTemp *src,
                      unsigned int ofs, unsigned int len)
 {
@@ -1166,11 +1171,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
     tcg_temp_free_i64(t1);
 }
 
-void tcg_gen_ext8s_i32(TCGv_i32 ret, TCGv_i32 arg)
-{
-    tcg_gen_sextract_i32(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
     tcg_gen_sextract_i32(ret, arg, 0, 16);
@@ -1472,11 +1472,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_ext8s_i64(TCGv_i64 ret, TCGv_i64 arg)
-{
-    tcg_gen_sextract_i64(ret, arg, 0, 8);
-}
-
 void tcg_gen_ext16s_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
     tcg_gen_sextract_i64(ret, arg, 0, 16);
-- 
2.53.0


