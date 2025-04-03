Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B78C3601A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 23:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UKn-00027S-0P; Thu, 03 Apr 2025 19:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKP-0001kq-6N
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:39 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UKM-0000j7-UO
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 19:50:32 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso15455455e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 16:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724226; x=1744329026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ViYtgj7vvi4iKxNJjOBDXGos3WgZtYMTvrMpDjjoLI=;
 b=xb2Z9jb1yfmTfXQjif2q6Sk/hODa0CN6YFAKG8iVT7k90sFlu0gBOm36gS4X8AYCz8
 ObAwakA4T/npMF0mr2UReLBWg098OAjKtNChS+AL6u7dlfME0S9sbJ6+4Zvd10pQEvl+
 o/G6HBDzyZCYEGJeB5pzwOJKswUpiPy2lz6O8L499BSYPEFAG6O/VTtmnrujBNJYhnz0
 oDT0wnuKbIGyTvFBLSXqbk+yb9ervs3PhRT8ybH81VQaf+QeHUQcabRESSTAWG6uHPzt
 4Fq8uMAwhKY6Rh5ZahSt78MyJjGEy3FsfuYSGt7ekCDmTBOY1KPvIn4Gohir3kkOD+Ql
 LQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724226; x=1744329026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0ViYtgj7vvi4iKxNJjOBDXGos3WgZtYMTvrMpDjjoLI=;
 b=GjBUZdQ21SLoxJz6FpKeR0ncM4+D9geTsCSv58N8QAu7+LYOgQtO5rHShldNcSQqvY
 84k8ZWHomVuAxua2lngmjdlI9e0fxoHECKbsI1Fqrh3w6fifqydj7Jqw3dVdE56LVUEy
 t1b8nO00DQonMM9Bzno89QWGGuFyTQfvU21ll5yVtEvQyzRJj3xDrdC3/736t7oBQt1D
 RU/r6+LYQ56fa0sM3hkHciEraDBlSlLJwGXQnwdn5Lsj1r5yvFnie0QRKKaEP0KaV9L7
 BQ3ofUNENXsYyLbl9q+otB9hwuyH0ORmvYmbGYuZ+xrMnmXTvUpIj+hMWMF6c35vIysC
 6jLQ==
X-Gm-Message-State: AOJu0Ywb5F+1X7Obix9whc5C76PgoUToJ3+t6aMSKYqcAhz3fcDSKwAz
 O2LF6jdnFasncm0EOZJP0s9bOGa2vUclFJo6wdSlhz31u+Xg60WIZbCI3mXOZfSWJAXFORP48bs
 e
X-Gm-Gg: ASbGnct6vicImPsWhkzGTvJgavLWeLp5nbzz9E5xGuG404dKXg5KtHllFIaL1aRqZ/K
 Y2S6Uz78+ttPUGEl5TCBpPmXSabrdL+r1feVEjOsAVd7XTxttCwavoM3vckEqx2CNZ9jrPAHD4E
 UBwIp+06RDfKtJb/bkEb9CW1rf/Wt+S5wuTFt29/yu7EVADgLMTr+sQZGnVyeyQadc4gfc2I0RG
 WCyFB44r6P9b0zs6fPfxycDwNzPWw6HIoNBQc7cMG0aEgntrvaV3peDPKURDePfAqmnCNDkS0Sm
 9DCRNNO42kzkAspVcMDKxr/bQ53OIp5PVvcBh6aK1UTfEKrDnV7loH+ho58dIQ3yjoooElOxQM9
 qwRrWj0iBKc+2dG+eSOs=
X-Google-Smtp-Source: AGHT+IGAcWpIGxzcpj43YaWnwcMM51cGpcNCuzPhdAUhLKBItT74fPKJ1RjkHsY1gKRjKBFTafhxZA==
X-Received: by 2002:a05:600c:3494:b0:43d:4686:5cfb with SMTP id
 5b1f17b1804b1-43ecfa0672cmr7561775e9.27.1743724226482; 
 Thu, 03 Apr 2025 16:50:26 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c2fe9875dsm2952781f8f.0.2025.04.03.16.50.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 16:50:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH-for-10.1 11/19] accel/tcg: Replace CPU_RESOLVING_TYPE ->
 target_cpu_type()
Date: Fri,  4 Apr 2025 01:49:06 +0200
Message-ID: <20250403234914.9154-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403234914.9154-1-philmd@linaro.org>
References: <20250403234914.9154-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-all.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index bf27c5c0fb3..a13cb39644f 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-builtin-visit.h"
 #include "qemu/units.h"
+#include "qemu/target_info.h"
 #if defined(CONFIG_USER_ONLY)
 #include "hw/qdev-core.h"
 #else
@@ -44,7 +45,6 @@
 #include "accel/tcg/cpu-ops.h"
 #include "internal-common.h"
 #include "cpu-param.h"
-#include "cpu.h"
 
 
 struct TCGState {
@@ -73,7 +73,7 @@ bool qemu_tcg_mttcg_enabled(void)
 
 static void mttcg_init(TCGState *s)
 {
-    CPUClass *cc = CPU_CLASS(object_class_by_name(CPU_RESOLVING_TYPE));
+    CPUClass *cc = CPU_CLASS(object_class_by_name(target_cpu_type()));
     bool mttcg_supported = cc->tcg_ops->mttcg_supported;
 
     if (s->mttcg_enabled == ON_OFF_AUTO_AUTO) {
-- 
2.47.1


