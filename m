Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A3FDD6AAF5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2026 17:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8LTT-0000DV-Av; Thu, 02 Apr 2026 13:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTM-0000B4-9i
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8LTK-0000fu-8I
 for qemu-devel@nongnu.org; Thu, 02 Apr 2026 13:04:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-486fc4725f0so11702965e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2026 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775149484; x=1775754284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KGFFrfbr36AmEzkh74oOA4hg7tq9vtm73qaYZR3gMNw=;
 b=ORnlcCE16QDMGw8KGUTbRCQktipHKF7L0IoRHZyRXabeTmJ6O96CdDMrGkdb06ihQU
 clfGspQU1s2HnxgOZy+PRrZXbSTJOCb2k7KRgLb00Cs19vGqjNZjywb/kabQ34L1RgI3
 Bu7AU7UqrawZPNDXBSIZfBCfEEfBqMMLKhnCAADHki2b63EnNKhOBuv/qyEkgzlaCqlL
 LH3xW9uJZo+CCGeqFUksLMjlB9eWL2eVJWeiiCgqRV2yxtX935wT5jW7lABbZCOvyiec
 lHj3mjdEdYFZsfBKObs0L88GNJHJ8jU4cA5bTmzoDhIUO/8NBWlqxLJG9R7u3umUs1D5
 UpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775149484; x=1775754284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KGFFrfbr36AmEzkh74oOA4hg7tq9vtm73qaYZR3gMNw=;
 b=mLwOwEAKJhNqYkxPsRxUCHc5hoL0R0vxfsf/lzpk23GvFwAs4uhccVNDgm2XO8e8p/
 UYzyatDrOpKetqwTpsNEeQw/oL7ZbAR65Nu+WyToJSo9Tyiti70gBOtjEOeRnhPy17P9
 0hpqj7bHjzQukk5dtla+/IaxeyccCXt1AoJb1EiZdpcRqW//0WSwjlTAsfw4J2BQ0kF1
 22u2RWpb4OGGCK6aBaJyZ837h0/5tmyTB2gELD4ryPY2l+bGqglOvMSwxysoklGMa8ZJ
 ICV4DkqqF6RRf9IkNnEFLhSXovlEPSRt79Ntq74j8ZbQQWJ2+EsBQiMOLYcKcbAe2sn1
 50Lw==
X-Gm-Message-State: AOJu0YzUbWbOs+SHQY8g+hWRGLOwIQr6hYCG/Oqg2q3afV1F8iS3zfij
 KKuOpNaNcRpx/cuc693cLobYBHbU4EjMYzj6ZTnChAjDRubTdYbH1rHqdOpKUmT3JI0rJJ/cYoo
 2vsi0+A4=
X-Gm-Gg: ATEYQzyqRR2e+3uWdmvRtXPlPkQmigSViKcOlAhtganASZkffMXexXk5TfRo6ViFcyh
 i2xESfoUMN1cEM/ZgK2Cy19ns9+HGqGRs4aK8W+DR3kREqTu3711d4nXIV5KPhZROs2tqtCMfs9
 Pef8JUlKdUjk/HsI7vggey3VGGLy7jJ6roxv5WsqWJ/iTuo28x3HrOJED8hoqzMj9PrGDGBQsvd
 Mn/oQgzN+T+mzrD9ETrVbe1j0GnYVb41U5C76+z/P67xs06NC1kDgXxmnx9rvU6UQdtnmlu7VhN
 CWNdYwvfEvZPkkH/hFM019zlDqB0DjaMajs6+feVFiR1izSzobWPPGz07tTayNiDT0uHS0mFMcO
 0rxawgG+wtRu1oQyOI/yvpJJCpEbY02cznAssVjI6btTjLCjRrOorwmuKBHAbt7C0wl5g/0EBTf
 EBarl27J9EAzx5T2hEPZVF0SD1vMCkf8lo7I1I0Vcq+BqGrKcoUrVSr5KaGha+zvhLfwdm6S+7s
 T1cnnuAw8E=
X-Received: by 2002:a05:600c:3b0a:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-4888e09ba82mr46452805e9.10.1775149484030; 
 Thu, 02 Apr 2026 10:04:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4888a7165aasm104469075e9.14.2026.04.02.10.04.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Apr 2026 10:04:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-riscv@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-11.1 v2 1/9] accel/kvm: Include missing
 'exec/cpu-common.h' header
Date: Thu,  2 Apr 2026 19:04:26 +0200
Message-ID: <20260402170434.94783-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402170434.94783-1-philmd@linaro.org>
References: <20260402170434.94783-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

kvm-all.c uses EXCP_INTERRUPT and EXCP_HLT, defined in the
"exec/cpu-common.h" header:

 17 #define EXCP_INTERRUPT  0x10000 /* async interruption */
 18 #define EXCP_HLT        0x10001 /* hlt instruction reached */

This header is indirectly included via "system/kvm.h" -> "cpu.h".
Since we want to remove the latter inclusion, include it here in
order to avoid otherwise:

  accel/kvm/kvm-all.c: In function 'kvm_handle_internal_error':
  accel/kvm/kvm-all.c:3147:20: error: 'EXCP_INTERRUPT' undeclared (first use in this function); did you mean 'SA_INTERRUPT'?
   3147 |             return EXCP_INTERRUPT;
        |                    ^~~~~~~~~~~~~~
  accel/kvm/kvm-all.c: In function 'kvm_cpu_exec':
  accel/kvm/kvm-all.c:3436:16: error: 'EXCP_HLT' undeclared (first use in this function)
   3436 |         return EXCP_HLT;
        |                ^~~~~~~~
  accel/kvm/kvm-all.c:3490:23: error: 'EXCP_INTERRUPT' undeclared (first use in this function); did you mean 'SA_INTERRUPT'?
   3490 |                 ret = EXCP_INTERRUPT;
        |                       ^~~~~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/kvm/kvm-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 774499d34f8..5df3fb90d88 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -36,6 +36,7 @@
 #include "system/ramblock.h"
 #include "accel/accel-ops.h"
 #include "qemu/bswap.h"
+#include "exec/cpu-common.h"
 #include "exec/tswap.h"
 #include "exec/target_page.h"
 #include "system/memory.h"
-- 
2.53.0


