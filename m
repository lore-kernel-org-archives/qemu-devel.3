Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C070C98338
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAkny-0004hd-3M; Sun, 27 Sep 2026 05:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkns-0004Zb-PU
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:13 -0400
Received: from mail-pz2-x2a.google.com ([2607:f8b0:4864:3b::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAknr-0007de-2B
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:04:12 -0400
Received: by mail-pz2-x2a.google.com with SMTP id
 41be03b00d2f7-cc7a15ba46fso162107a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790499849; x=1791104649; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RhmEsVOe8JaSK7d0M3zsFdTZV9PjCmJ4QZiZ2z0LZLs=;
 b=IBLu28aGBDykd6s026CMDGcVYQnXKW3QYYVBCO+xYCPhktZ91pJ2eNuKMsCsUkQtkh
 jX8rKUroCzd73hSjmz7gqLAGPiuUmPigoAJXOq9jq0Ymqn+PhBjy4Vpo2PkT66Q6p8oM
 mjYaWU4XKAD3CUOfA9Aw9llEyutuh7liSpbBcTHqPLsINmaNHnXcwZ9kwEychUKfKXG9
 WjCczzwa5iTBIO1u6PgIEntdA1XDWjYI/ec9OMe0ZZmpOkmLo6tEXOfbPhDRjTasMZzS
 L2dh9Dkdzhgrw5LG8ZwF3z1KSg0YBKfmkwIitApcEX6il8TaRXLedaJJQpGdcDOY070g
 +UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790499849; x=1791104649;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RhmEsVOe8JaSK7d0M3zsFdTZV9PjCmJ4QZiZ2z0LZLs=;
 b=U9j8CfMAkv9IfFwQdTSMZrwSGVidhcqRTvYcKpBo7Me1IIHGBv8GAuAknze+xrmhVb
 UsXjD9zmUJs/jZfi1MhWKu+nUpOqTmXiASaTIsfrAVl12fPeH7OvH2ejZiV9Q+fSavDK
 xUmAT/zcRqrrBZRGc5V6PyGiR0cioZxsk2cx6/XadSnOXjs3Mdw3Oh87STig14IYJtsx
 bdJpoVge5epQXJ8aNFcUSb98rCBD9HsOZo+pjqMBeziQENQQb8QOdnEg1oAuNjprwI/j
 Wi+5UbhmE3O8olJ187YtHCpb0dj8kzonVezy2HtmYo0DIZVO9LUar7JNfbISqg2fMNXV
 JpjA==
X-Gm-Message-State: AFq9FYI9jJ/BCnL4OHx7emLkT8QlHdgORhZV7c2UtR7PGvfZlkjVP8pn
 BqP1+jIXUm8mx7hsmE5dNtXfU5fkKRWnvkV468Au/YQvY/qsfTE8CsdG+kuQP0/nP3V8npVVHz8
 bYOpq
X-Gm-Gg: AYBFou1kTD4+wonWO6gQxFy1OVnleiVOu2HlgHmau7EH0aU30zkyyJNSPkHeh+rXmDX
 o+v/cOXFJbdYrZAo1jc4eDsNpw3xNepWRoREAVDF1bTu9HyxKPdIlgkr0dWGI680g9QNxyxu3VP
 WzdMlR7HhsAMsJroFCz/pvkZOCwpNkJxG3R0f13eQl6BrIJcE9kZo5J51LqQuU7vztyuDK5hCaw
 j709NkuCzjUG39t7OiHMWsVq5ZRGdwVbwnFfbwvtya06YFG715fwcIt1rESd8edbuC4tkA/WE+z
 9IHh3hjPbCiizMg/fSquIvyvwXoxUOF9Yg3ORp6NpR/Yvigut/DyAcNCdeGYeELXaGWacplxgfV
 ZRsg4MxrmB2F9TYsJOba3L2N4Pm4DSHP9z9ivnvgNKhYqAJN0qQ0fMrM+t5X0iVjcGisznodwAK
 rrHn7ivP5Cg7JzJDtUHlOWwCcxisM/FM/SWhFVZZYDCQTTVEx596l8YeFGsDc4Tgcis+2PLlcLq
 sHenJdCbaw/JFFmZOFl3x9PiNV42w==
X-Received: by 2002:a17:90b:3bcf:b0:3a0:afc9:a51a with SMTP id
 98e67ed59e1d1-3a0afc9a61dmr6560458a91.12.1790499849165; 
 Sun, 27 Sep 2026 02:04:09 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e0ec367csm2916932a91.4.2026.09.27.02.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:04:08 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 053/101] tcg: Generic expansion of tcg_gen_clzi_*
Date: Sun, 27 Sep 2026 01:59:23 -0700
Message-ID: <20260927090011.10724-54-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x2a.google.com
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
index 40a7f94040c..acdd31dbeaf 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -130,7 +130,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 /* 32 bit ops */
 
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_ctzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2);
 void tcg_gen_clrsb_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_ctpop_i32(TCGv_i32 a1, TCGv_i32 a2);
@@ -190,7 +189,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_ctzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2);
 void tcg_gen_clrsb_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ctpop_i64(TCGv_i64 a1, TCGv_i64 a2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 74c68f46b76..cf832a6dc07 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -9,6 +9,7 @@ DEF3(andc, TCGV, TCGV, TCGV)
 DEF4(brcond, TCGCond, TCGV, TCGV, TCGLabelPtr)
 DEF4(brcondi, TCGCond, TCGV, TINT, TCGLabelPtr)
 DEF3(clz, TCGV, TCGV, TCGV)
+DEF3(clzi, TCGV, TCGV, TINT)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 1231cb4ca0e..f168386f46b 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -445,6 +445,11 @@ void tcg_gen_clz(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+void tcg_gen_clzi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
+{
+    tcg_gen_clz(type, dst, src1, tcg_constant_internal(type, src2));
+}
+
 void tcg_gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -753,11 +758,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_clzi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
-{
-    tcg_gen_clz_i32(ret, arg1, tcg_constant_i32(arg2));
-}
-
 void tcg_gen_ctz_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i32 z, t;
@@ -1674,11 +1674,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_clzi_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
-{
-    tcg_gen_clz_i64(ret, arg1, tcg_constant_i64(arg2));
-}
-
 void tcg_gen_ctz_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 z, t;
-- 
2.53.0


