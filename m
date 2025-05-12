Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C116CC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:15:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXcx-0004Lr-1V; Mon, 12 May 2025 14:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaG-0001Z6-8U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:09:00 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXaC-0000T3-OQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:08:59 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-741b3e37a1eso3849878b3a.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073335; x=1747678135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=vVRBNoLPOIDRuk4zq/0u8h6ngkBf1olsuyU3Bjs++44nthKyfk7E+WUaxZhcmgmlfr
 5SrmRrmwm30ju2LunobUWcbfUOD+1mcjJoS8TB30k/LHddF1xNlhplV4M8lIDjtWj2ht
 cVpRUo+SiZZVpjICDEbwH/J106x7l5nyndUKXZK0NMfvVbIcoKkOoa+mZgq9hGES+BDX
 7uGhjEpYFpVjmTbW70YcPNej/NwBAl35+uBaG9fYz5hkm7BS9u+SwYnLXiVPv2+DX7uH
 /BTdobE5Wm7BVYIb0KeU3VoBpvACvIQ+ATKCYNmaIvQ7qEf/v3ONJKxEkuZQrAJH11/t
 Y2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073335; x=1747678135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=11Q55+gMF5u6Eo9NyNW4V+s1ceVG/+YyEcTpuHMGI4c=;
 b=OqFKM97oHkM5W+Gb2TxmGIm+OBeRpNWmMg1NswkFdwK7eWNGd3RLYcEGr7jrlKpLCb
 SqPcfTInueJ8vvVuABoP8AlOlAbPcyAFxschmIEWgjOdJzFI1JHx/kdS2zWI0arHqAOI
 eqxdTBe9QA1NoxPMczj9V3tgdsa8umkVagbPK+LzzYpuFDKUkYp1SCQ8XDQpUjnGGPJK
 9OYIqOP1TjZF0Fpv9VZF2cJD6jVdI8Ce+3F2CM1OOzpHJm8mn9JNq0I34Ybg49c5HR7N
 HLSlaZp/fFTYVFyiuXbabu1AmVmpx+XxVlPmajeSLGi7Sel4PYk01VI3F2RuLKAYCIXY
 jZmA==
X-Gm-Message-State: AOJu0YzQ3kxQeqPh/4tM3jLzeofP5NjxToxtA6tihBiD31g8VA4WSKf5
 KpsxrUMx21701d3FZd4x+yZdudBxu6S7WTsxDdLFRTm8iIuVBQSXOS1jBqylnBKEIunGPI5Qh0X
 E
X-Gm-Gg: ASbGncsrea712qhCNRvcM43KtmFcaW3alkOWkj98gKmv14UX+rDnRN/gGd2wPGJoPhZ
 zNZb/ovEVll+6YTUXyMCoDxhdOtN2tfKtvAVTvP6KRpJVPBDjk8ErfFLkc9+Fm3p6pNl9hBXMNA
 Cn8A8Y4h0IwnnZyw+/l7hUzS6Pd5KKcc0scDAknCeNR3FrEAsu1LH+q8TYKXhWkuhTf7Jlg214X
 L5wp+bgub4PG3SWdHRimspgHW3y7zB3cFYlrq2U0V2HgadCVGYaPoePlox2Y0ZjTxnLOL+bq/5n
 gy+oHGlyhTcPy5697JVQNq9zZXzsdB7PCv6dsK7Ef3vYPsNF0+I=
X-Google-Smtp-Source: AGHT+IHHZxH27Fblpk+T6nzSm6gwzWmiuunS0CeLF3GYhXIAV+SAz8d1QBV/IJKqUKfOEduj/U+Kxw==
X-Received: by 2002:a05:6a00:a10:b0:740:9d7c:aeb9 with SMTP id
 d2e1a72fcca58-7423c0737cdmr18544639b3a.21.1747073334907; 
 Mon, 12 May 2025 11:08:54 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237705499sm6438580b3a.33.2025.05.12.11.08.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:08:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 43/48] target/arm/tcg/neon_helper: compile file twice
 (system, user)
Date: Mon, 12 May 2025 11:04:57 -0700
Message-ID: <20250512180502.2395029-44-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/neon_helper.c | 4 +++-
 target/arm/tcg/meson.build   | 3 ++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/neon_helper.c b/target/arm/tcg/neon_helper.c
index e2cc7cf4ee6..2cc8241f1e4 100644
--- a/target/arm/tcg/neon_helper.c
+++ b/target/arm/tcg/neon_helper.c
@@ -9,11 +9,13 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "exec/helper-proto.h"
 #include "tcg/tcg-gvec-desc.h"
 #include "fpu/softfloat.h"
 #include "vec_internal.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define SIGNBIT (uint32_t)0x80000000
 #define SIGNBIT64 ((uint64_t)1 << 63)
 
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 02dfe768c5d..af786196d2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -32,7 +32,6 @@ arm_ss.add(files(
   'translate-vfp.c',
   'm_helper.c',
   'mve_helper.c',
-  'neon_helper.c',
   'op_helper.c',
   'tlb_helper.c',
   'vec_helper.c',
@@ -68,8 +67,10 @@ arm_common_ss.add(files(
 arm_common_system_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
 arm_user_ss.add(files(
   'hflags.c',
   'iwmmxt_helper.c',
+  'neon_helper.c',
 ))
-- 
2.47.2


