Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70356C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JSU-0004UB-06; Tue, 22 Apr 2025 15:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JSD-00042t-1h
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:49 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JS6-0007Jc-V4
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:38:48 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-227b828de00so60307375ad.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350721; x=1745955521; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IzxhDXQ8yhw3qgxUo2QDT1zA0vlXRiIUxtrypSczyWI=;
 b=FUYF+AXhJORIGnVcv7zRf6y1qlZZrf2eMN04pIsY/TmqbkwQhm6q0MLgaYd3HYCLUe
 GVhSOrc28TlWBFDqTjq10X4Tvb7r9Oei8wZW0R8k0lR21Hy9SiOpRnvk7iTdTzjZB2fa
 BRRP1pXBA1y53EmZmjiyibKp57GCPbta5T2hV1FrM9uOfRsqHLdeoGfuF01DudUXia1K
 F3dQlxxRsmgYXyEOVsV3Fc8gChwsK1RYDrYZWdxmZTqffAIX/8VEPUfxoE7V+xmj4r0L
 4a4laMAqu09cqnaYM/OWK4sFSZo4M1qMjTegm6V5N0YLU6AHIb/eSdKixnq63jvWpBDz
 ev8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350721; x=1745955521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IzxhDXQ8yhw3qgxUo2QDT1zA0vlXRiIUxtrypSczyWI=;
 b=rzqiUPg41vR5D+7AqF9LkNJQ1llaGoVgsYkHoNm7JZIafJoF36O9klpDEGrbmdFiIG
 GARaScyQ9gxHlCpxW2xCn/VtmrXN5kmTgPHmbi/QtMMALHHZI+n+S7QYfVTA0xxcE3CC
 pqGn+UEzF334zxpograv8AgTsabxLa+0pakyxFYX16onqBg8azlpfCHf9qZe61GsXrHY
 dUksszGITRIvlJBo4GWOHKe+l6edcViQpdN6u2M9LOvSKcTSPpGxN0NWBn+KFFXfJLE6
 97fsSYugLj+KqYIfmlwm5ySlkd1nwmndmqehrw8KX3ZTrmQqkmz8ZBeIDNYB18EiL1Yz
 D/pw==
X-Gm-Message-State: AOJu0YxVpx4jQTnKRKex24YvOpYASEPigJrD60OzazsMbyhSoxO8y9tp
 M22qEwouPG1/re7D+xlbrmhh/JMcllsyymR/rPSy9yF7fzrLr4W5sMtwrz4w8gk7BNu8mlFJGt9
 C
X-Gm-Gg: ASbGnctUsapdpxgmK97X659d5hwbsCt6P7+ftW3KuBSMpgB6bMbJJZUBNaZQY6fXMFw
 VFn9BTajAXnSqX6YQSpKhQZiCzE4MNxFlP90zIIP0WmMFE3AEyJaIuTtW23EVJuAz80/NylLLkM
 nZwCRqmh6qwXag5eW5lWXPP81RwH4lSQC1HNQFv8GDUKbvyGiHzkjtS434Du6/zHrO6YMjiz+UK
 48oNbOmFOsj7XeHPN/XteG0XhS8vaAFcuzM63fXVCkK98ugxaaxsH9yGOOc4FRgoH329Dktlcs5
 gnusep9iwlO54nzTXAYE5sqXfnGW+ydBSeDnyUkGjI6nwcsObRKUQEVDUBvohzlafcwXzTqmMiQ
 =
X-Google-Smtp-Source: AGHT+IGbtiicSLiPj/cD3gtYnscBp0+vVys6yrQTwSEKVHdD87NXX0KuKpIJ7tRabBFiM81u4PsCDQ==
X-Received: by 2002:a17:902:cec7:b0:224:584:6f07 with SMTP id
 d9443c01a7336-22c5360772dmr221935605ad.37.1745350721373; 
 Tue, 22 Apr 2025 12:38:41 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50eb484dsm88951765ad.148.2025.04.22.12.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:38:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 123/147] hw/arm/xlnx-versal: prepare compilation unit to be
 common
Date: Tue, 22 Apr 2025 12:27:52 -0700
Message-ID: <20250422192819.302784-124-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Remove kvm unused headers.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250325045915.994760-29-pierrick.bouvier@linaro.org>
---
 hw/arm/xlnx-versal.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 278545a3f7..f0b383b29e 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -17,9 +17,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "system/system.h"
-#include "system/kvm.h"
 #include "hw/arm/boot.h"
-#include "kvm_arm.h"
 #include "hw/misc/unimp.h"
 #include "hw/arm/xlnx-versal.h"
 #include "qemu/log.h"
-- 
2.43.0


