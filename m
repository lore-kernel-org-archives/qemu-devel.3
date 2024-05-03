Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9ECC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 15:38:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2uyT-0004M9-6c; Fri, 03 May 2024 11:37:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyK-0003ZH-BQ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:18 -0400
Received: from mail-lf1-x12e.google.com ([2a00:1450:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2uyH-0002lL-Rn
 for qemu-devel@nongnu.org; Fri, 03 May 2024 11:37:16 -0400
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51f17ac14daso2698298e87.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714750631; x=1715355431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TYufu7DpgZYDotR1hfS1ObeVUHdd9gyKuKm2GZNB3KM=;
 b=DV38KcXL/X+UoUlb5HiTv8w/1ifHxahE4ykG+4w2ilY95PoKQJ3IwcRaMMz1g1VgVa
 tUgDTLYpHl+L7SpACTRBhL/RmLbFc4Pfl33OYLlxPGuDP9XWPViIBnTnZhCrJIy/+mEr
 jUlrfvYxryflSooS4YWR5DIsLTR06AwpWRzHtlGSm6B1let4m6N49ZcW0e6Dqt9Y2tpw
 Cx4HpZjNUd9NUpefbrPmnUdppbkfBILP3QOCJkjqCYJAbWQxarpHPZAuqWc49oKKVA8m
 uYx+lhYFMSlUWh0/fALJEVypouvh7FondHhXDybK2g7h2sEIvl6Nrs2VSWwiresjB7H0
 JXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714750631; x=1715355431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TYufu7DpgZYDotR1hfS1ObeVUHdd9gyKuKm2GZNB3KM=;
 b=ibifW9W6txN7Su+EX53HSv8goFtgNyXlA23MixjwWH+l107O56szTKTZIxvzG74Lyf
 Y6VGrk4w79smNHs2Co+5sjjoV/eAyhZbRFUVDWw+Ic5bFQDRI72zYcdqi3uDXUPenWqi
 zMY4+nQEnejGKCfpQStJbq7gZWB2Ne/yeVb+5zFamS6y9HXo0x4THKb26vFtN8fN1AYp
 QTI+tldHU4YAgsHkqnPFmpj6FAQtqbexrQoPeal8KsHQbvC3cXSCmMwC5+NlFSKEoFsh
 QF+dYY68bTgp+BfBxhLMn65jhhXHk0hjljif+1SP3XZ0nZf+Bh90KVwcqiEu8KHwL9ui
 P9Dg==
X-Gm-Message-State: AOJu0YwGO4q66vz2fYq5Xwlldi4KBuhqf8xCHmsdWC5BrgZEuPvakjAM
 HznQB3mX03NjTP+f+3+LBbN/KdBFF6AOn9X0axOEkl+xYNF5Efv9UH0nvvBzCNLNEoMmHgvIHit
 N
X-Google-Smtp-Source: AGHT+IHCWClKP9jgJfQd/v1RHoSkIyY4j+j65Ej5E6qWegcYSihkBWGCxzZFpGjYgUeNzf8hvC0BSw==
X-Received: by 2002:ac2:5483:0:b0:51c:85b:bb72 with SMTP id
 t3-20020ac25483000000b0051c085bbb72mr1974905lfk.26.1714750630996; 
 Fri, 03 May 2024 08:37:10 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 s20-20020a170906061400b00a52274ee0a7sm1843364ejb.171.2024.05.03.08.37.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 May 2024 08:37:10 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org, Paul Cercueil <paul@crapouillou.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: [PULL 10/14] target/sh4: Fix ADDV opcode
Date: Fri,  3 May 2024 17:36:09 +0200
Message-ID: <20240503153613.38709-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240503153613.38709-1-philmd@linaro.org>
References: <20240503153613.38709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12e;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12e.google.com
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

  ADDV Rm, Rn        Rn + Rm -> Rn, overflow -> T

But QEMU implementation was:

  ADDV Rm, Rn        Rn + Rm -> Rm, overflow -> T

Fix by filling the correct Rm register.

Add tests provided by Paul Cercueil.

Cc: qemu-stable@nongnu.org
Fixes: ad8d25a11f ("target-sh4: implement addv and subv using TCG")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2317
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
Message-Id: <20240430163125.77430-2-philmd@linaro.org>
---
 target/sh4/translate.c        |  2 +-
 tests/tcg/sh4/test-addv.c     | 27 +++++++++++++++++++++++++++
 tests/tcg/sh4/Makefile.target |  3 +++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 tests/tcg/sh4/test-addv.c

diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index ebb6c901bf..4a1dd0d1f4 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -714,7 +714,7 @@ static void _decode_opc(DisasContext * ctx)
             tcg_gen_xor_i32(t2, REG(B7_4), REG(B11_8));
             tcg_gen_andc_i32(cpu_sr_t, t1, t2);
             tcg_gen_shri_i32(cpu_sr_t, cpu_sr_t, 31);
-            tcg_gen_mov_i32(REG(B7_4), t0);
+            tcg_gen_mov_i32(REG(B11_8), t0);
         }
         return;
     case 0x2009: /* and Rm,Rn */
diff --git a/tests/tcg/sh4/test-addv.c b/tests/tcg/sh4/test-addv.c
new file mode 100644
index 0000000000..ca87fe746a
--- /dev/null
+++ b/tests/tcg/sh4/test-addv.c
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+static void addv(const int a, const int b, const int res, const int carry)
+{
+    int o = a, c;
+
+    asm volatile("addv %2,%0\n"
+                 "movt %1\n"
+                 : "+r"(o), "=r"(c) : "r"(b) : );
+
+    if (c != carry || o != res) {
+        printf("ADDV %d, %d = %d/%d [T = %d/%d]\n", a, b, o, res, c, carry);
+        abort();
+    }
+}
+
+int main(void)
+{
+    addv(INT_MAX, 1, INT_MIN, 1);
+    addv(INT_MAX - 1, 1, INT_MAX, 0);
+
+    return 0;
+}
diff --git a/tests/tcg/sh4/Makefile.target b/tests/tcg/sh4/Makefile.target
index 4d09291c0c..521b8b0a76 100644
--- a/tests/tcg/sh4/Makefile.target
+++ b/tests/tcg/sh4/Makefile.target
@@ -17,3 +17,6 @@ TESTS += test-macl
 
 test-macw: CFLAGS += -O -g
 TESTS += test-macw
+
+test-addv: CFLAGS += -O -g
+TESTS += test-addv
-- 
2.41.0


