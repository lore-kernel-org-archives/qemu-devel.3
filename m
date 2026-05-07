Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28460CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 22:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL725-0000nn-Jz; Thu, 07 May 2026 18:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL723-0000n4-EL
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:23 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wL721-00039I-Q5
 for qemu-devel@nongnu.org; Thu, 07 May 2026 18:17:23 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-4350cd5b97fso752206fac.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778192240; x=1778797040; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0l0OBvb0V3tTyoz3zrbfooAbsVRfx1OHt7vq70bkBfA=;
 b=IQTzg5RjEPQ6hRIrLbd6l3f/kJOdKZU+YrjbdSrF4i8xnURw7KUm4v6zobBgCeWXRA
 o4YJffydvRVsNNuqc9tt2kDeaOBNi54dN6o18HPuoC8FA1CNHscbK+DWNTvlZ4qnwVp1
 WhQiVuYcxdLm1iPkz5BCud+vdFc4+zhDi/mFXfl0qBBLMca87uP1mgZYeBtlhl16e+Ji
 sF+mjHTCzWPmsOFpIUJi70Md5wnQi8IsfWqFUugSFeadOPpjqt3b1MmiYhNVnxqygO2I
 u1mGClhPkL6ZtUn6u62aypJZZUfjypouNvE1I46HP6CqgcQFmyLNdQG+sVfU4AlALHKp
 FPOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778192240; x=1778797040;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=0l0OBvb0V3tTyoz3zrbfooAbsVRfx1OHt7vq70bkBfA=;
 b=i34MkfgF5MOTx13i28BzENKL2c7UJk7rrpYYWZ45RJdAonqea+nPq4QuZnwRQZDz4X
 wiVeGd3VivIXleOeOf9XCkhxWHhenTM0AU3LmNLDq3WQo/wzLvq30T8mCzWym5I2fd22
 CGIp3g/MXUL2pQxqk4fAa+rhlgk/poQVONIUUUYGpp8Lpq1HMDzt7djMzRD8FyM+b8Bb
 r0xHGmcuT5/2eLvRnxP547d8Og/F6khxsqhW1TcHJEyx/uNNph8nvfL2UmyuwA8U77gX
 1ud0CzSeGr3eG1wj0eMYxCrUvHleSOJBcB1E9BOM6Jd+L/9+F2IRlujZDWCD+FdqaTD+
 Au7A==
X-Gm-Message-State: AOJu0Ywx11QWkXHdr+HCyg6O2oflf9/AFfagfxigqoIx8t5hEDB+mrJq
 IftAoS3re1SxNxeH1JkZWNu522LajJQUQmJ5iZDJSapJci0mg9lFJ7HD/nMnqF/J44wfv2kV10V
 cWXnJ
X-Gm-Gg: AeBDieu3l69cBkCg58zOiBA2C3b5qp3pZwvyCkmsB/err4E5n1rKS3vwqw9TkpNQ+du
 BQ6fVj7QxGmXl8fOaiWlaFMx93WNDmsmaxUwxhc2BTLqRButJLPUbRPwByjDXgM8EnmtV6axHlZ
 ry7UnHB+BO5KicwN1x5lj3GGZbZZnzprXrbCbBE2rZvvS+h+jHw2nLmYKWI+6PH9r9c1PjOJPKU
 TyhjxU7B02aFvsTk/erlyBKstgJKwBTUanY2kBab6BpqcffLODTQrA/fxrpGZ+oLnWC/Xf46vnB
 S5LejNHYCE0DvuxK4wq5WjDJe4f2kn7ojWQwtcpxqScy18XIGLy/yjNYTI8rfM+0rXr5egfiGfj
 5wP5VGQllRssj8R8VE1RRBjEFNBalew7kDQN/z4lDzt3VDGr0U3A7NbN+XdczVMrG3wgLjr2BQ4
 8ouDjgmMRdHWatp4qZyd5ZhGb1Vj6nG7PnehTlfvZUY8Zh/g==
X-Received: by 2002:a05:6870:d109:b0:41c:25b1:930f with SMTP id
 586e51a60fabf-434f65f3d0amr6883048fac.19.1778192240317; 
 Thu, 07 May 2026 15:17:20 -0700 (PDT)
Received: from stoup.attlocal.net ([2600:381:c938:6375:9641:bbb2:a93a:bb4c])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435573e7254sm45037fac.14.2026.05.07.15.17.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 15:17:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/18] target/alpha: Remove CONFIG_SOFTFLOAT_INLINE
Date: Thu,  7 May 2026 17:17:00 -0500
Message-ID: <20260507221717.486023-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507221717.486023-1-richard.henderson@linaro.org>
References: <20260507221717.486023-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Don't peek into float_status internals.
Fix the helper calls that were missing an argument.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/alpha/translate.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index d2d1467a81..c66e3f9c14 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -34,7 +34,6 @@
 #undef  HELPER_H
 
 #undef ALPHA_DEBUG_DISAS
-#define CONFIG_SOFTFLOAT_INLINE
 
 #ifdef ALPHA_DEBUG_DISAS
 #  define LOG_DISAS(...) qemu_log_mask(CPU_LOG_TB_IN_ASM, ## __VA_ARGS__)
@@ -578,15 +577,7 @@ static void gen_qual_roundmode(DisasContext *ctx, int fn11)
         break;
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    /* ??? The "fpu/softfloat.h" interface is to call set_float_rounding_mode.
-       With CONFIG_SOFTFLOAT that expands to an out-of-line call that just
-       sets the one field.  */
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.float_rounding_mode));
-#else
-    gen_helper_setroundmode(tmp);
-#endif
+    gen_helper_setroundmode(tcg_env, tmp);
 }
 
 static void gen_qual_flushzero(DisasContext *ctx, int fn11)
@@ -609,12 +600,7 @@ static void gen_qual_flushzero(DisasContext *ctx, int fn11)
         tcg_gen_movi_i32(tmp, 1);
     }
 
-#if defined(CONFIG_SOFTFLOAT_INLINE)
-    tcg_gen_st8_i32(tmp, tcg_env,
-                    offsetof(CPUAlphaState, fp_status.flush_to_zero));
-#else
-    gen_helper_setflushzero(tmp);
-#endif
+    gen_helper_setflushzero(tcg_env, tmp);
 }
 
 static TCGv_i64 gen_ieee_input(DisasContext *ctx, int reg, int fn11, int is_cmp)
-- 
2.43.0


