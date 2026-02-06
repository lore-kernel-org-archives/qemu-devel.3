Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6415EE9129D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 04:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voDMC-0004O9-Km; Thu, 05 Feb 2026 23:22:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM9-0004LG-JG
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:09 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voDM5-0003Rr-QB
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 23:22:09 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81f39438187so1227851b3a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 20:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770351724; x=1770956524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNi8czf1/CFVr3JdN24WUseqYsA6Bdj1+/T6IG97cXc=;
 b=QlZUyOcDmcOP0kIGqSmm6GCfnbo1o20QMnSI6ztuNm3fJbtFBhTTjVXPx0OB9jbIML
 YFgghe2kXiwxsPUDYA5aO9zoOE50v9VXVxNH1uHS8XIg9VFsclTUL3KtNbM9KNa+Lzed
 Ttd3vgyc4CT/0QbCxHP+DviAiZLFoxW0UAMVckbA28ZhJwGZs1X6QdLzkBL12462q2ew
 9HkiBw1D7BKqVIflFn9duREyI3enLVskLxFh1UCgioIit/6ndFx8DsmSG+9NPgwpXPyE
 ncRmeK2IdDrMufwZhbU9KdLnNrx8JSNxZ2JHu5eH6qxglMnfKeiJ3l3I8r6QbKfWPndo
 o5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770351724; x=1770956524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NNi8czf1/CFVr3JdN24WUseqYsA6Bdj1+/T6IG97cXc=;
 b=QofEWtXmiHDx1TfH5kl/VNsnG7SYafZjrmYvvLGpt1YKD6PfO3c0nyA+R6tOMvoT31
 hsFILqbVW/ktbZt3gcZvQbGeHMFJ1ACbec7sD1Kg49ge1w6uRHQycQG+YH6/eOJywhwq
 wCxXf6Yxu8ox8tBDML6it0ZV3ycyE2J53gFdDq+yx3EhrmbynPvg85+8PPNSA0PVFvgt
 noQNAbrdkPxBvBFlus04QSblTFi/RZgDKPAQzmS2dywSWqkZM7OvrAlqg3tz2kNe1jIv
 IrYNhmdSHAW5287SSCp7NDHYHFVrC1t9zl6XvPoCFCQ4xyntfVJjjKpjBZsMx9mUQkSU
 l0oA==
X-Gm-Message-State: AOJu0YzAPqcEYJLn6HuFfjwyd2NDNA/PMigNpGsH9S+5R5paBFFHR6Vi
 vCXNhjrrEDDlq9ddvGlxUYpMzHWCvzmHTO4Blu/oaUSieXPVShzgL8QV5n+1l0qTntHTBlj9eTK
 L3tZn
X-Gm-Gg: AZuq6aKHnBR1HfZ1HCpHEQIOn0B9cZphjV4VL+B937qVR15sB6ER2HZF3eH1i4I4e1v
 126psowCHNcELPz+lDajirHdk7h9uU+ouXvFiffGn6grCcCoCvEfo5uNOzKTtC0fr6itnA674aH
 rrB9uVionNhaIUWhFBvB4nUa7fQqE8cFVdtlySAH7DYZ7Z6ADWqbo+7aCJRZy/killmBSS2KD1Y
 dFFisjxXQG9CBhRc6G00XQmN8xxbQsK4bdVuDTAqX39q2EYpo+OfAS7tTaRDmTGg+oX/3Zy6y6F
 tuwhaFRlwZnqy1NsFDRYs/GpOusuqlbxEMmNI9/4V195kblS4vnDumul2yEu27g45HdmvyvOXy/
 OS6g9ftIHQt7ZPwFPG0YVY5FN/zDRIFTihsTfTt8CZ/V6u5Ch8pPFEU3Coj/Y6xjEEgDlV/Lana
 YhjfVdcI8Argvi0Uksw13Guf94pIYa59XKe0OA0Zefzf1ZQZ//TjdDwXy0h/8Q4zbkmcaVwrNKw
 ds=
X-Received: by 2002:a05:6a00:1790:b0:81f:49cc:ea11 with SMTP id
 d2e1a72fcca58-824417b8d66mr1225060b3a.65.1770351724414; 
 Thu, 05 Feb 2026 20:22:04 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8244168fdf5sm926914b3a.17.2026.02.05.20.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 20:22:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 05/12] target/arm: extract helper-sme.h from helper.h
Date: Thu,  5 Feb 2026 20:21:43 -0800
Message-ID: <20260206042150.912578-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
References: <20260206042150.912578-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper-sme.h                            | 14 ++++++++++++++
 target/arm/helper.h                                |  4 ----
 target/arm/tcg/{helper-sme.h => helper-sme-defs.h} |  0
 target/arm/tcg/sme_helper.c                        |  3 +++
 target/arm/tcg/translate-a64.c                     |  1 +
 target/arm/tcg/translate-sme.c                     |  1 +
 target/arm/tcg/translate-sve.c                     |  1 +
 target/arm/tcg/vec_helper.c                        |  1 +
 8 files changed, 21 insertions(+), 4 deletions(-)
 create mode 100644 target/arm/helper-sme.h
 rename target/arm/tcg/{helper-sme.h => helper-sme-defs.h} (100%)

diff --git a/target/arm/helper-sme.h b/target/arm/helper-sme.h
new file mode 100644
index 00000000000..27c85fdeef1
--- /dev/null
+++ b/target/arm/helper-sme.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef HELPER_SME_H
+#define HELPER_SME_H
+
+#include "exec/helper-proto-common.h"
+#include "exec/helper-gen-common.h"
+
+#define HELPER_H "tcg/helper-sme-defs.h"
+#include "exec/helper-proto.h.inc"
+#include "exec/helper-gen.h.inc"
+#undef HELPER_H
+
+#endif /* HELPER_SME_H */
diff --git a/target/arm/helper.h b/target/arm/helper.h
index 2f724643d39..b1e83196b3b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -1,7 +1,3 @@
 /* SPDX-License-Identifier: GPL-2.0-or-later */
 
 #include "tcg/helper.h"
-
-#ifdef TARGET_AARCH64
-#include "tcg/helper-sme.h"
-#endif
diff --git a/target/arm/tcg/helper-sme.h b/target/arm/tcg/helper-sme-defs.h
similarity index 100%
rename from target/arm/tcg/helper-sme.h
rename to target/arm/tcg/helper-sme-defs.h
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 075360d8b8a..7729732369f 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -22,6 +22,7 @@
 #include "internals.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "exec/helper-proto.h"
+#include "helper-sme.h"
 #include "accel/tcg/cpu-ldst.h"
 #include "accel/tcg/helper-retaddr.h"
 #include "qemu/int128.h"
@@ -29,6 +30,8 @@
 #include "vec_internal.h"
 #include "sve_ldst_internal.h"
 
+#define HELPER_H "tcg/helper-sme-defs.h"
+#include "exec/helper-info.c.inc"
 
 static bool vectors_overlap(ARMVectorReg *x, unsigned nx,
                             ARMVectorReg *y, unsigned ny)
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 31fb2ea9cc3..5d261a5e32b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -19,6 +19,7 @@
 #include "qemu/osdep.h"
 #include "exec/target_page.h"
 #include "helper-a64.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 463ece97ab8..7d25ac5a51f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c68a44aff8c..db25636fa3b 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index bc64c8ff374..a070ac90579 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "helper-a64.h"
+#include "helper-sme.h"
 #include "helper-sve.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
-- 
2.47.3


