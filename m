Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A52F99366
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtV-0006LS-Gc; Thu, 23 Apr 2026 06:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtS-0006KU-Bv
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtQ-000210-Hp
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:46 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43eb012ac4fso3929432f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938563; x=1777543363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3qwqN+DauHC4IRA0wcrAnRFZ+O5YVSUCRaHS35gZNno=;
 b=bb5TyHnkn2OVivrBwatXFNxNDR7PHLXZzu6IMT5lhWqGIZN2zvQgaGZhoiderGGiCb
 KEAECNiRHTfFMGbIW9kXWBLHHeTqq0uLrbL422ZBcBktnCM4MjasZjhLzxlTLgeodCBJ
 DE2a7eVPBUemsXp2mzAfQwN/NC3UKl/2QaNaQYaIwxMJeB9CTBTi2/457yXbretYmt0+
 iJ/TkZGVmC0Bfpv2FICkzV2ZcPEaa/XD7sMmyrzXKr20npQDIw8jKpRvWicjYV2xvt5O
 m2SXDidun5tqzygPsqYRZ34aFVZzLCppHnlDdj+bU3im4klMVgssmfeNlb7FWEm8xHir
 W+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938563; x=1777543363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3qwqN+DauHC4IRA0wcrAnRFZ+O5YVSUCRaHS35gZNno=;
 b=pNHmrRjKjmzD8hMe2fKHnTmtBABHckFgijj5752nE6SG7nFsNLaFjF8kyURAn311UU
 iPisjFQclO9gK2KIWMn5fPiG9bZsuMda1mJqcc2cJF3h9iwzGjHCa7nNcmMiI6p6/SUN
 hqyJZTR5r8yLSddp7rnTj/sl7D8/gIcfWUFuoca0jOvGoAuRGcqIvHaxCgjIzRIhoe1D
 mYNARyuvheaC3nY8GP+Jz1ieBHS/WNwEaE7N6iWoM7oDbbz5Od8ABDrxksp1hA8KRDLf
 hbKApyzdsFl9hNOT572gYh7sfWQi2baUDWyCrAPvwRIj89XhdwEDZ2IjcpxqOTr+ywPW
 zoMA==
X-Gm-Message-State: AOJu0YxAw6F5CwNoaK6HSTyg9SG9nxYBW9PE3x1qWqTLwRhRJ5d+NOqi
 Co0oB7Apyb2rDlmvByQot/UPtbtyFZQ+w1kg1nN6+op5tv7nT77NxVXowD7A/gtsNaBkjr4VqEi
 MQIys
X-Gm-Gg: AeBDieuFVj/LIz/hs+RskXFD0GV5aPUJ9tPFcmVZtvtAdDh0DOhyRnisUvBh9IyWcd/
 1peY46Ste53jGFq26qHT4m9Qt8hZehP5W5EqqsVb6Z1+DTP6d3gQe3CScipqTceI/sMNgLWW9RO
 4SHVTEa0A0obYfKzUOnlzqwjopBSKPJY2VXQXCsANZbjAFu4bZtGUt+s5gDeU27Clru3lmZkeUw
 8TQ9p4V3oM0W3suhdh36/5MtfBVxsBoRmrQ8iIlUgoldfd8y7XckL7vLEglitdHMVFScoyD6hhk
 7RcMh1ybwdWesZiZTillhJs+Qr2wvA38KplznEUOT4k0DThGms1uYC6n0ewNLikFI/vZNlqEqJD
 rt1cZHE85cyRpAFYQLuJuJ+JWgZXIKzPMpVhG/zBCMPIWAx+R9QpqTFxB3A33e+cLwf6z0hjSnM
 RLi8mnsrgcD936WlXzf1h0cOhuRU3FTyjC4YmjgrZn9HLzktzCYnpMmZBayKC8QG7d4CmJML7WS
 1RlSoOXCX0W3MMokO5FXp9OztO5B0B+7D6mar0x2P9pkSQp5dXu
X-Received: by 2002:a5d:5d11:0:b0:43b:8858:1146 with SMTP id
 ffacd0b85a97d-43fe3e0fe61mr42226894f8f.41.1776938562975; 
 Thu, 23 Apr 2026 03:02:42 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/59] target/arm/translate.h: remove tcg-op.h include
Date: Thu, 23 Apr 2026 11:01:41 +0100
Message-ID: <20260423100229.2941820-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-3-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 target/arm/tcg/translate.h     | 2 +-
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32..35ad7530c4 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51..08254b088e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 
 /*
  * Include the generated decoder.
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 5bace3fda1..aa7d72a35e 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d..56ef1e0eb5 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463..6d52606f9b 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -2,7 +2,7 @@
 #define TARGET_ARM_TRANSLATE_H
 
 #include "cpu.h"
-#include "tcg/tcg-op.h"
+#include "tcg/tcg-op-common.h"
 #include "tcg/tcg-op-gvec.h"
 #include "exec/translator.h"
 #include "exec/translation-block.h"
-- 
2.43.0


