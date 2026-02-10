Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF97EB2700
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 20:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpu9J-0007lo-Ef; Tue, 10 Feb 2026 15:15:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9G-0007Za-Ux
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:51 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vpu9E-000891-8N
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 15:15:50 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-bc274b8b15bso673021a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Feb 2026 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770754546; x=1771359346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2plFct/EpqGzjEx7nOv5ScJhI5BtmBrKmQ1/sromkc=;
 b=Zqqnp3f61y7sry2qU6lK3UMOJqG0/9QW55Tj90+7gQRiHHpCgTuhj/UwIQPlL8LJ9h
 VY6ecKt4SXSoQMF9M+Vw2zFmoSmiikddRt6HlCMjoR6pLfchTBqQcYmWIP5LPmzmbAEz
 Bq+PZ09X3QCQ/imIPOxUpx3fq+GO1U0YLnIv16VgqW7PO6yB7aaIHffFxKRp5hwIYlv8
 pFXeZKh6P7M6escGlENQAhKm3U+nz5xOa6SpCmoPHuQVB/Vwt24Bf4b2n/v+GHKxUQ0P
 S6QLlnORZlibY3wJhWD3nN3LbH7g+eiuPGUdlsIDWwpfYwYndO3zFyB5seUvVzMNQEB3
 nvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770754546; x=1771359346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h2plFct/EpqGzjEx7nOv5ScJhI5BtmBrKmQ1/sromkc=;
 b=F6X5/xDC4CkAI6ZiU1bsl0s0JxKPlq4h2oe8HeuzSm3ykrww2Fc4k3TNOjhEORlp8e
 Y7DiAHheF2+hn6zfrip2hhSvU44TGKPeBugVoJ1iIMCc2XLfEiBCS4Jyi+anUMYFwbHX
 kwZahJ2h74v9QZJnJgZotx9WaPGrzW6XMe8VxDZl99hUEzSqrnmaDN5IQqSNDnDai7/N
 Y1nWx92dBUHVvBI3jkpp5jn05gTHMiTTmfZjSWFlQQs2OpN0boBlKTeuSifhjSZoJdW4
 DAN0Mq/ZVBKsB8NZWZt0y7FxgLmtsugi0D2aSObqu97hiFEnJwcmWfm/aLdA3+6hQYHf
 Rbew==
X-Gm-Message-State: AOJu0YwsPQiBuOeYy8QZ9xQUq4hfgA75d/oS2Vr8laPOA9m0Nb3xsDfR
 rpeY4k6Cg7jJWRm/Z8R7b86X+0dFKqGhnAfjOTkxIzJjyPE6tEME0fqEfPfu39IxlqU82tfOIjq
 dk9b0
X-Gm-Gg: AZuq6aIER6ZWu5Ve7xUeah1X3xh02Dod7YGM4U+os2kx+KEYJh3jRdJuuH4COSCbG6D
 1BvT2KpQif5CgKxcQhpEDwjtKCNUWhiScV11JAYk+yTSDPwX6GAMhykatiVMeHxn4DYjr8UCyRn
 ta7gOAiiB+78J7BiWCXXU6Z/3FBBdDyAeKmzKHZFeVQ/B261sZ4d+AMilSoKfDPfKO3k4/Q5MNd
 q9mDM0ZCDRNEx7ZH5flFK++3NIQDLlmyEhC7Y3km94X4yTOeAlO+4B6L3grYSi/VPKcsD9d3mFQ
 XkxSSe87+5UMjgkkiE3X5jhljMLR8l2Apyn+KRHgglKCadLrjUob3p3KiXYCwwGUWXWZNt3++en
 2mgddI2/k9eRU4adQa34KP6kP2F9zMZqusZlWNdK8Bzk21o/mB5ZwyLS4WE18pA0UhHv67hyp89
 JXzr7Ffvkie+DJ+o2vQFfjhUmyILzXnjYttSKkgNTKqgInFaomidAes+TWJHvtC2JccLSCvK1Di
 Ii6
X-Received: by 2002:a17:902:db07:b0:2a5:8c1c:7451 with SMTP id
 d9443c01a7336-2a9519f5b02mr181073635ad.58.1770754546416; 
 Tue, 10 Feb 2026 12:15:46 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ab0b392cb5sm38523225ad.70.2026.02.10.12.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Feb 2026 12:15:46 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 01/12] target/arm: extract helper-mve.h from helper.h
Date: Tue, 10 Feb 2026 12:15:29 -0800
Message-ID: <20260210201540.1405424-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x532.google.com
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

A few points to mention:
- We mix helper prototypes and gen_helper definitions in a single header
for convenience and to avoid headers boilerplate.
- We rename existing tcg/helper-mve.h to helper-mve-defs.h to avoid
conflict when including helper-mve.h.
- We move mve helper_info definitions to tcg/mve_helper.c

We'll repeat the same for other helpers.
This allow to get rid of TARGET_AARCH64 in target/arm/helper.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper-mve.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  2 --
 target/arm/tcg/{helper-mve.h => helper-mve-defs.h} |  0
 target/arm/tcg/mve_helper.c                        |  4 ++++
 target/arm/tcg/translate-mve.c                     |  1 +
 target/arm/tcg/translate.c                         |  1 +
 6 files changed, 20 insertions(+), 2 deletions(-)
 create mode 100644 target/arm/helper-mve.h
 rename target/arm/tcg/{helper-mve.h => helper-mve-defs.h} (100%)

diff --git a/target/arm/helper-mve.h b/target/arm/helper-mve.h
new file mode 100644
index 00000000000..32ef3f64661
--- /dev/null
+++ b/target/arm/helper-mve.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_MVE_H
+#define HELPER_MVE_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-mve-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_MVE_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index f340a49a28a..44c7f3ed751 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -7,5 +7,3 @@
 #include "tcg/helper-sve.h"
 #include "tcg/helper-sme.h"
 #endif
-
-#include "tcg/helper-mve.h"
diff --git a/target/arm/tcg/helper-mve.h b/target/arm/tcg/helper-mve-defs.h
similarity index 100%
rename from target/arm/tcg/helper-mve.h
rename to target/arm/tcg/helper-mve-defs.h
diff --git a/target/arm/tcg/mve_helper.c b/target/arm/tcg/mve_helper.c
index 63ddcf3fecf..f33642df1f9 100644
--- a/target/arm/tcg/mve_helper.c
+++ b/target/arm/tcg/mve_helper.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-mve.h"
 #include "internals.h"
 #include "vec_internal.h"
 #include "exec/helper-proto.h"
@@ -27,6 +28,9 @@
 #include "fpu/softfloat.h"
 #include "crypto/clmul.h"
 
+#define HELPER_H "tcg/helper-mve-defs.h"
+#include "exec/helper-info.c.inc"
+
 static uint16_t mve_eci_mask(CPUARMState *env)
 {
     /*
diff --git a/target/arm/tcg/translate-mve.c b/target/arm/tcg/translate-mve.c
index b1a8d6a65c0..4ca88f4d3a3 100644
--- a/target/arm/tcg/translate-mve.c
+++ b/target/arm/tcg/translate-mve.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "helper-mve.h"
 #include "translate.h"
 #include "translate-a32.h"
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 63735d97898..febb7f1532a 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -28,6 +28,7 @@
 #include "cpregs.h"
 #include "exec/helper-proto.h"
 #include "exec/target_page.h"
+#include "helper-mve.h"
 
 #define HELPER_H "helper.h"
 #include "exec/helper-info.c.inc"
-- 
2.47.3


