Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DF79F46C47
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 15:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9lVV-0002uI-QJ; Mon, 06 Apr 2026 11:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVR-0002sE-8T
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:49 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9lVO-0003qR-OI
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 11:04:48 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so26000345ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775487885; x=1776092685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=VmHQQXMnmFc3cpHK+lQmJPF4Pb1ZYQB3g4/6ybwrJ8qSp7oQXOCsntad+yk+tXEvko
 cU0SnHUv1uooC/tq45pdxqBN7Ior4TmHGpeUIhSh0P/M+sNGgGBq4fKBT1ayZBXJb4cE
 3v13xox6PThmLMcdU5O35AkNz+skaEoE1R7NV7OMg6ilEPNblgfljLSNOlvAUBhwjnZZ
 bS+Dpyr8e3RLXUSmnqOWlWaoUmbiYdhZlIqsLDW1KPFRIsZqr/w1j6xDHC6MrSM50m/g
 Kuu5V8LjrPp7kdPvPSmz7LuhaB7cJ8xcPPiEwZc2KlTUrcMvPSMo31zDaBoB+mrF1WUU
 usKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775487885; x=1776092685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bt74HgDQm6QWm4ci9bJjS4WKY7nrk6DWez5uAlhy+BI=;
 b=d4cFNVSNCo4KqyW0pewHXRhIpmBITzZl2Zdp/b2/oX9n5zWiHAwl/k5L3VsZsfW1uA
 59V2ez4jh663HErOWpohtz7R6RE5SIxSOo/4BnVnGZ6TxWT0NzShLV2E2KN8kfRGH4De
 dR8pNNLepA622F2nzKzodS/jSXlk7CY83KdvRwhvfUcXO+0oNiU5nMOD2wTP1Ouq9MGt
 5lTn2d6rHikHQ59mFF5ex3z0OchspEeHiwCYSegCMarKjzoC6b8YUlX5lBPdgIAOpoyX
 TkWqUd49uonZqUZckVzviuWRREf/eHOo3xlzlsrKB+3/RSukeGY8YZagIwj37sXJT4m1
 h0dg==
X-Gm-Message-State: AOJu0YxBlIg4ckKaDZxFkm1LN039mT/5GHC+I+TcvRnkeSO8EJ5U6ce/
 ZL0c5bJHYOqAfon4B9VmsrODkp+RTN5I6r82/dMk9iJUOHrUeuHyIP73kuN3zxfiJ7JYajaUKPw
 /qrEurLBZhA==
X-Gm-Gg: AeBDieuzg7NeIqODc0ue/cmlHDl+c7IJq9uwPqOa9HxBIu9/pACmvhLcMSacK83Ds4J
 jTul5U+KnaDPfAS/pGS/UlGuCGaYtOT/ndPHVxjoE+rQ1fpS2oOp9ijHTiCHarG0j1pHqiURsO2
 flCGzSCY/m0V0wVotJAnstbRSG3o49f9WYv2iDaqrQrokWqKVnQGQ2H2826vhwM+ZUkJmbNxyBi
 QKwhRVcBdzX9UAoD6kLg3M/J3Q6F6Y6GJnOodASFirapHb98WNCiAHyBZNIH9glfkn0zevPwl/L
 HlcizgCam/kuQysDYq8LmYznjzGbFG76vfUxGXNVbggXLXyUYmfba7+8TLlgE+Y/5nmen1YBf2Z
 Svww+UBEuWVLe+jdCmVomg8O2jtPj20zt99wZIZqqxaMlyxpbcQQXV0h5z+I5jdKyaINR24ztKO
 5yarhai3aKXSybmAahiNZoksWM5LMGRGXBL9wiRsuHQkw6BxuuRcBoBKAQsIxnV/pDmoUQ7hRdQ
 Byr
X-Received: by 2002:a17:903:a86:b0:2b2:4d78:eeb4 with SMTP id
 d9443c01a7336-2b281779e2bmr132654585ad.22.1775487885065; 
 Mon, 06 Apr 2026 08:04:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d72sm137770075ad.51.2026.04.06.08.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 08:04:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, philmd@linaro.org,
 jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 02/14] target/arm/translate.h: remove tcg-op.h include
Date: Mon,  6 Apr 2026 08:04:22 -0700
Message-ID: <20260406150434.407201-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
References: <20260406150434.407201-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

Include tcg-op-common.h instead, and include target specific tcg-op.h in
files needing it. This intermediate step allows to clean up every file
(TCGv, tcg_gen.*_tl.*) in separate commits.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.h     | 2 +-
 target/arm/tcg/translate-a64.c | 1 +
 target/arm/tcg/translate-sme.c | 1 +
 target/arm/tcg/translate-sve.c | 1 +
 target/arm/tcg/translate.c     | 1 +
 5 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index 3e3094a463e..6d52606f9b7 100644
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
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 5d261a5e32b..35ad7530c4b 100644
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
index 7d25ac5a51f..08254b088ed 100644
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
index 5bace3fda1a..aa7d72a35ef 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -23,6 +23,7 @@
 #include "helper-sve.h"
 #include "translate.h"
 #include "translate-a64.h"
+#include "tcg/tcg-op.h"
 #include "fpu/softfloat.h"
 
 
diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index f9d1b8897d2..56ef1e0eb59 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,6 +22,7 @@
 
 #include "translate.h"
 #include "translate-a32.h"
+#include "tcg/tcg-op.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
-- 
2.47.3


