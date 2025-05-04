Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E0AC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:46:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvA-0002EJ-88; Sun, 04 May 2025 01:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv5-00029V-Fy
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:43 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRv2-0004NA-9Z
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:43 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-736b350a22cso2834299b3a.1
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336579; x=1746941379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86LVIOw/2dppRQJ4fgmxpMIcvI46MI2lVjbVrJNlYmw=;
 b=KbYJGgWYWZDzms0j6oZzI2QC/tf9fzF99BjWRDxVcW6H9Dp4ilQ7Ar5pgDAara3g5f
 kB2K3FFt3Ao9/+P5Kv5VVMCq+dPeXAvG+WYrFrDc8TUE4vkombWbcSaWgacnu4GjMTuo
 TZLTsA17RjLEmiAbg+TUGIIFiyyOAD++5B3IW0pRJxQP8dX8EkdUgwQ5ZAhoedHFxx1+
 +sZUGeRzpeG7hC71pRomszN1opjIgAuB43B3DGu33u3MFQiDE6jC57ItQ9ilxOlRiUHj
 qMehTGnP+3mxFs782lCicNmrRi8rLwsZZXiP8flfOZyg3OsbyXNj8zJQ2y7oGrWLYF4t
 fi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336579; x=1746941379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=86LVIOw/2dppRQJ4fgmxpMIcvI46MI2lVjbVrJNlYmw=;
 b=OMvatcv/Cjd+WZC9SL6TCsHxzADpKA5aedCK8EsdTL1E3ZsrejNOde/QlzeMhzc1eh
 cfxb07cP39O6zgD5NvwnrYWk0AjzwJBYy8PlESBrGOtrlIjprOSAkeTS86RiTCbECqmx
 /2KnhDG3UqmBqjM/HoGIdFajbFLmMUDBj3LdtWPR9D/Z9YZqtT9auVuwAOBP/S74UT5+
 TIJToKE/hIxFGhEoQJp95t85HCszROznJv2STN5RbRTl2wyygCbigx+2dalhXMHjxDR+
 blb/gK+29Tx13+ufXaO/Tni7ON7SnDnkFFPsbAbiDpTuTvZZ5ynhhgaz1a48UYm2K126
 jy4Q==
X-Gm-Message-State: AOJu0Yw9dgeRlpUL4tZQEBEEmg/F65wXa18I/uhMX8NAGStWRpDGRCxU
 MV36uWzOG1Bq0BozcQ9mEIj4gRfkGjE9KC21E2cfs74+ynwd0zN8t5jHxtUQrmgh5qGtXvDROvc
 8h68=
X-Gm-Gg: ASbGnctHvIWugZMJNSYgXyzcx+gCw6EPwqzFJL5g8VUc3DApIe3/M4RLpZhRgvkolkZ
 gcPRPjFcl0ccRgBzR/v61NeOKcxbO1WwoEWOr9VQUElwVT7V6xABo1vP0rtdLtmwS29nwT8dHdV
 Q/dBfotHITI6C5PTePMKHFEcj1I4oWI00erAtjKaCEezRks2+qwpsMwAIn/qgbIxpFKUEg6M7lM
 bVx16iBY3t58QK2f7LGJbNZU7pssl3jkABAvnpaFnRIIJRmbUFrimMSPSDelK/Ymlowa2A52kmN
 baTZrVYGNXQo9X6cVQhsrvvKYJkyRnZLY2EfSqvG
X-Google-Smtp-Source: AGHT+IG4ULaEA/GoSGjxEhxOoVD4iO7XzTMOWyT0+0o23OyJwF3hTP78uWvNt/UX6GWnXj4rDAzS1w==
X-Received: by 2002:a05:6a20:c901:b0:209:ca8b:91f2 with SMTP id
 adf61e73a8af0-20cded4359dmr12181184637.19.1746336578692; 
 Sat, 03 May 2025 22:29:38 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 21/40] target/arm/helper: restrict include to common helpers
Date: Sat,  3 May 2025 22:28:55 -0700
Message-ID: <20250504052914.3525365-22-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
 target/arm/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 257b1ba5270..085c1656027 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -12,7 +12,6 @@
 #include "cpu.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "exec/helper-proto.h"
 #include "exec/page-protection.h"
 #include "exec/mmap-lock.h"
 #include "qemu/main-loop.h"
@@ -36,6 +35,9 @@
 #include "target/arm/gtimer.h"
 #include "qemu/plugin.h"
 
+#define HELPER_H "tcg/helper.h"
+#include "exec/helper-proto.h.inc"
+
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 static void switch_mode(CPUARMState *env, int mode);
-- 
2.47.2


