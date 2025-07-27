Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50DCDC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwR7-0007r9-3w; Sun, 27 Jul 2025 04:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPP-0001tN-Mr
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:03 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPO-0004l5-01
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:07:03 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2352400344aso30525605ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603620; x=1754208420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q1E53pgb9AZCt1kwtrkxIgkEwDfx9OIXorUzM2iqJtM=;
 b=E/98XfKCaXFIsjKP8+pKO1L9CAD3bMFnrLS/lsC19x4/brGyUy8gf2s3NZ3GlElr9o
 i++KbsVrPpH0oz+q7eYx3vz7lZjKqzdjyPBy06rrINFnHIKQ9wpeB89qhwE2yZKhqEXy
 RKvzAywW0Zj9QivLj+9X4gbQzptrrgmPi0B+roc6GQC+rDwlVuEmXfaauTTmDBdFTP+I
 u7VM8CtZDndvWxAQ2TMJiZKz+v0qwPux0gqkbphudvyBfyBq9ZrgTqJF/lSJ+/CO8cuw
 5iv7XyXhphtd6xKgXKPijSLit2JAilfFrLBG+JHRJy1hkM8EhvNPGW/biqp7FyLiaYa/
 KI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603620; x=1754208420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q1E53pgb9AZCt1kwtrkxIgkEwDfx9OIXorUzM2iqJtM=;
 b=M9zg7aMkBkbghrfcM/BsOFFhCBtGLwpGxPUTYtnTHrkBp4fHafeGjGItiZOcJbamD4
 xxAJWOSd+Dtl4sZ6014CEfMLjZBFBmCywUpEqRGKbbo0JM8H87J8MXkujJDuun/27VKw
 oAIUp3IPKjiglj8g4SP7x+KBCxqH5cgJo9tYUq1gHlSV3D6ivlZEzGQtLduUhyqAMbEa
 l8GYZyGLC2FgOP40tDnZr58QSisLf6zhPFH3xKtRLL8q0y5+GSKipOphyMbSrNbvodte
 tcEHfHRq0UpbHP0MyMcuyABDfQpnoGQfEGUqiAt8srst9+nQcd9rXyKqGRHtz7mMoQDJ
 NHTA==
X-Gm-Message-State: AOJu0Yz3+qtLPOukl9/WKdSJwqm+4Y7WI77khLHh2JcmtBYdcVOswKMN
 qa7Jjh/kZjIjS3NWT/nzhVAJSLsxEBe5TAu/e/1JIb8JsRT3gGxrSklIBm9EwvL3PP/KitDA45f
 peSz4
X-Gm-Gg: ASbGncvBpCX8zkl4tEgKTcH4Q9EoQZESmtKfhIYTwrSwaAF7gAErxwSmpXfXkGQgyhL
 YzhYpNWBMDn8OcoE9TKiQrfNcEkYK8yKCd+szJj87cdETCmMfOtRYJd8RQ2JDaVZz4UAWSzhXdd
 19VruDzjjzVAO5sgcY9I+ic/inWBZR1cRWy2aHB3mKy2A+zMUgM41O3J3LRlQKVGMpVU2RWma1c
 Oy0ouT7DL+YF6Pu7sMKEwMOXVA9Zld7zVAk8DDSKsf9vYQKQybBmXEnIA4bbYvPO+8112ShQkek
 LIozQh6R/Wt3kkAYzcI5Xuet/77DWOVB2IBHFUyEm9HbiEGs+fG4gRrbyVVG/EgZvAODKKUXGK3
 C5t63/ECPQQ0KVBjQiQ5HWcN4LnANYYLNVAjQtiVLWaaKpufs6F2Iu/Q3fVAXlqWMZEGFeebiQE
 gyp5adxVJUnw==
X-Google-Smtp-Source: AGHT+IFzSx/oJgTSX6vJxIjvcD7JVwHH/1H5rkzdVhtJCT3r/tyrv7Z0BrQHle7g2OPRwrc/5IaI1w==
X-Received: by 2002:a17:903:22c3:b0:234:a033:b711 with SMTP id
 d9443c01a7336-23fb31af6b8mr120133285ad.50.1753603620562; 
 Sun, 27 Jul 2025 01:07:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:07:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 52/82] target/arm: Emit HSTR trap exception out of line
Date: Sat, 26 Jul 2025 22:02:24 -1000
Message-ID: <20250727080254.83840-53-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Use delay_exception_el to move the exception out of line.
Use TCG_COND_TSTNE instead of separate AND+NE.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index c4dd3a747c..f6fdfaa551 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -3033,21 +3033,11 @@ static void do_coproc_insn(DisasContext *s, int cpnum, int is64,
 
         if (maskbit != 4 && maskbit != 14) {
             /* T4 and T14 are RES0 so never cause traps */
-            TCGv_i32 t;
-            DisasLabel over = gen_disas_label(s);
+            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
+            TCGv_i32 t =
+                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
 
-            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
-            tcg_gen_andi_i32(t, t, 1u << maskbit);
-            tcg_gen_brcondi_i32(TCG_COND_EQ, t, 0, over.label);
-
-            gen_exception_insn_el(s, 0, EXCP_UDEF, syndrome, 2);
-            /*
-             * gen_exception_insn() will set is_jmp to DISAS_NORETURN,
-             * but since we're conditionally branching over it, we want
-             * to assume continue-to-next-instruction.
-             */
-            s->base.is_jmp = DISAS_NEXT;
-            set_disas_label(s, over);
+            tcg_gen_brcondi_i32(TCG_COND_TSTNE, t, 1u << maskbit, fail);
         }
     }
 
-- 
2.43.0


