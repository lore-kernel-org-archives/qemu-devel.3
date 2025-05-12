Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E6FC3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXf2-0007aS-HO; Mon, 12 May 2025 14:13:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaI-0001lR-W3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:03 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaG-0000UI-76
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:02 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-73712952e1cso4758670b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073338; x=1747678138; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=O+E2HkRm5Ej84qg/3J7XCziWXr246WDiVxPhngD6k5VTwKIBv2xJlRZaDdB28f2UoQ
 GwP7hoGqhlXO5vDDMeRxR54MgkjOzvagSI2EtOsJfkgUDsc0sP0nV/YmlKtlCgsjVcYR
 WxNAN5PUVPGnqnvRNwbAIVfgH4EJhFrhJCqJHXi/HN4Bm6QcuK8Si206rUXRZzOpX7yd
 UXoORCVVoV5vueXsEoZBDuprEa9zc8Yqw+EULxk1ukpKHd8LSGUU1PJjUWYI594VFaNL
 NzI+XWhESbI+UPLxc5irZCz3Onc+RDpEOxe+yerzrBXRUqqo7kydfWT3FPhzrJlzUHyx
 aC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073338; x=1747678138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D50FgSNi0pKqcQ8O05hlTOFeOSvMmvlw2mBrg4KVMZU=;
 b=NBCXM7zm30yP1ygLeKKNqFB7a6obBOLfFsSCNSu8TvkpHZ8sZybFBpS13HH539jp88
 0ghHJkz0XXb4ssYXg8ARQhhxirEA+Vxnsd8qFTCO/pJOCGgBSjfYIIIs7oxe2DN9Upak
 ije5kcRVIzTmvrUlldSd1vaaA+MI+xN9jT0/cUKAwrJIfdiACPRCkLE06NjGY6LyyhSH
 UhCcoKIkZxjTKEoJgyMAuKSWj2TVdyvl0t44fMRM3c3UPzGwB+SaB1zhqbW6fPWYkv0E
 C7JfAisfifPr0ivN6iTulF60Fx7wWyed6u5LREm0NHrv67vMziXc3qNnaoCAWKAOqMEj
 i/KQ==
X-Gm-Message-State: AOJu0YyCNPBjOM8T8YWsDRFSHsEJcVQN3W3iY6RWoAPs9CCe6sA+OELW
 62avh1PyihJdRiLaDI6BNz+Lk5Dul5B+tJy+KrbQLShY79dqzPL7J7gmF3iL5vMVdLAdCxjcNl4
 J
X-Gm-Gg: ASbGncuuB+AZygifFImY4mWnwLiXTNdIxToEOCxEZsKCdM/Vv7fVq9T/DvMFsEx0rX7
 LmvA80JkNK8lEcuwDXnAINw3JefASkaSZ2CcuPRM9t7/ODfn6p7lAR2Llw90njcbigh/2xoai8K
 9DIe+tbJBPgiKlOqMpt+36+SDuuywlFssuqvZbXMmRZxK6WHLAkt7NXsXrfcx/1WjG1phl+2Su6
 +qW8UysXaxFhCF6+Gis2/TmmWBRSskuduQgXNlBtCm5+qV3D9FU0yWbxeO1oyClGbJmygs2F+/d
 j+nS2EcD1Ben5irXMJKrFkJVtoo7TsfhFW851frqDhWuQxYleyQ=
X-Google-Smtp-Source: AGHT+IHa8ReBvuhLYNJVfoOgw0HWEvZH8paPUe8+ITjOAG70MzmSvDV21eTP7FYFx9n7u6IDXuMTaw==
X-Received: by 2002:aa7:88d5:0:b0:740:9d6b:db1a with SMTP id
 d2e1a72fcca58-7423c05b18bmr18505517b3a.15.1747073338398; 
 Mon, 12 May 2025 11:08:58 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 47/48] target/arm/tcg/arith_helper: compile file once
Date: Mon, 12 May 2025 11:05:01 -0700
Message-ID: <20250512180502.2395029-48-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/arith_helper.c | 5 +++--
 target/arm/tcg/meson.build    | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/arith_helper.c b/target/arm/tcg/arith_helper.c
index 9a555c7966c..670139819df 100644
--- a/target/arm/tcg/arith_helper.c
+++ b/target/arm/tcg/arith_helper.c
@@ -6,11 +6,12 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/helper-proto.h"
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 /*
  * Note that signed overflow is undefined in C.  The following routines are
  * careful to use unsigned types where modulo arithmetic is required.
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 5d326585401..7502c5cded6 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -34,7 +34,6 @@ arm_ss.add(files(
   'mve_helper.c',
   'op_helper.c',
   'vec_helper.c',
-  'arith_helper.c',
   'vfp_helper.c',
 ))
 
@@ -59,6 +58,7 @@ arm_system_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('cpu-v7m.c'))
 arm_user_ss.add(when: 'TARGET_AARCH64', if_false: files('cpu-v7m.c'))
 
 arm_common_ss.add(files(
+  'arith_helper.c',
   'crypto_helper.c',
 ))
 
-- 
2.47.2


