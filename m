Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90693C25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyc-0004ZC-Sa; Fri, 03 May 2024 11:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyT-0004NC-3y
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:25 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyM-0002ly-Av
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:23 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a58fc650f8fso900971266b.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750636; x=1715355436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZ76gv7i8YSHM81Ab5Mv7SVtJJSc8rRsU348TrrHgtg=;
 b=VVfx94PRR1vbSJEA+5dz/eXx6X80jtwIHJs1D0vjnbBK0WDMRe5K8IlcE4inSCfYH7
 b3iyHipIIKctAJGld9x5uCAdkudiH/2sa8H6Kjbh5VHOQnxv8vo7EISGU2TfOEZw5mvB
 FeTKcVWwYzG1BHaZUPq4ZuNysekK+1T2UPt9pvefgy7FXPE/kSAL7TQ1Fz88XLPuh7FG
 C31dEhlqj8qr+uisAI9vzxBpBIbniK4YR3L3bCgVbadFAp7ROmbyGFwefyi2Y3fh/Ka3
 s32+RxrajruShiU9V/vUEjEv/0Z9IgZYADA4SJXTpLhNAnsHJGV4sHDbt2ConlJ7/+Sc
 81Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750636; x=1715355436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JZ76gv7i8YSHM81Ab5Mv7SVtJJSc8rRsU348TrrHgtg=;
 b=i03LWoFdLnQCu0kQbu56AdwjoaPKWet7Y0vkt4fQfP7ckME9fT9HwM7foPr0jkrfE3
 gcVImsE4RwC+29MRMUSDgBUQfYDvnhFBzvhXtYOw7j1Qk/nqjnavsfIrXN/vcswEZjnm
 c4gSbIRytHEfNZViNsAkEswLbF0sdu7xYo7c0VnFuGiMCmVH10nEVCtN0cx7gmMYCuhv
 yv+J2FWo2fh5oYIs9sH5rCq+J4sO6szn/rn9WDmbhwf4Er+/dLHh5pY5qaNyUyDx7+Rq
 u5iWQKXs0kJFgefmvsaA7lm9FjFqj0BiCOo3KYBa0EiyySW0Gmn5D1uEfHE/XcdhyE5K
 Xf2Q==
X-Gm-Message-State: AOJu0YwSv2tSnTWliyNu2Wjnd29ujZkdZ6lDz5Ynt/rgW0ijH/A4JaBx
 c5cpCfxPsml8q9S3WpbjJFfCavRB2bjYjuvoXKgIfYvs0OiunW8c8QsmHC31OfIPYzjrxqF+3yh
 Y
X-Google-Smtp-Source: AGHT+IEipyBuDNCsQgq6UraYdsiP+SS8tf2n3WTcrLLinFrrTRbokPQAFeky+xlQ3L6G16mOH9DD7Q==
X-Received: by 2002:a17:907:174d:b0:a58:dd06:b8bb with SMTP id
 lf13-20020a170907174d00b00a58dd06b8bbmr1867268ejc.70.1714750636493; 
 Fri, 03 May 2024 08:37:16 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 lb24-20020a170906add800b00a58de09fd92sm1816023ejb.27.2024.05.03.08.37.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paul Cercueil <paul@crapouillou.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 11/14] target/sh4: Fix SUBV opcode
Date: Fri,  3 May 2024 17:36:10 +0200
Message-ID: <20240503153613.38709-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
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

The documentation says:

  SUBV Rm, Rn        Rn - Rm -> Rn, underflow -> T

The overflow / underflow can be calculated as:

  T = ((Rn ^ Rm) & (Result ^ Rn)) >> 31

However we were using the incorrect:

  T = ((Rn ^ Rm) & (Result ^ Rm)) >> 31

Fix by using the Rn register instead of Rm.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Suggested-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2318
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240430163125.77430-3-philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-subv.c     | 30 ++++++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 34 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/sh4/test-subv.c

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4a1dd0d1f4..3e013b7c7c 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -933,7 +933,7 @@ static void _decode_opc(DisasContext * ctx)
             t0 = tcg_temp_new();
             tcg_gen_sub_i32(t0, REG(B11_8), REG(B7_4));
             t1 = tcg_temp_new();
-            tcg_gen_xor_i32(t1, t0, REG(B7_4));
+            tcg_gen_xor_i32(t1, t0, REG(B11_8));
             t2 = tcg_temp_new();
             tcg_gen_xor_i32(t2, REG(B11_8), REG(B7_4));
             tcg_gen_and_i32(t1, t1, t2);
diff --git a/tests/tcg/sh4/test-subv.c b/tests/tcg/sh4/test-subv.c
new file mode 100644
index 0000000000..a3c2db96e4
--- /dev/null
+++ b/tests/tcg/sh4/test-subv.c
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void subv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("subv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) : );
+
+    if (c != carry || o != res) {
+        printf("SUBV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    subv(INT_MIN, 1, INT_MAX, 1);
+    subv(INT_MAX, -1, INT_MIN, 1);
+    subv(INT_MAX, 1, INT_MAX - 1, 0);
+    subv(0, 1, -1, 0);
+    subv(-1, -1, 0, 0);
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 521b8b0a76..7852fa62d8 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -20,3 +20,6 @@ TESTS += test-macw
 
 test-addv: CFLAGS += -O -g
 TESTS += test-addv
+
+test-subv: CFLAGS += -O -g
+TESTS += test-subv
-- 
2.41.0


