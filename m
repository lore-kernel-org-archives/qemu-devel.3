Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C5AC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 04:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzRzG-0007UX-LV; Thu, 27 Aug 2026 00:45:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzD-0007Px-Ab
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:11 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wzRzA-0005tG-8W
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 00:45:11 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-853c401326eso148827b3a.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 21:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787805907; x=1788410707; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gruEqfQPYN4ttNmxp59K39o2c8f3yt5K41EbUmDkakA=;
 b=Tb0PZzIpuxR7GXQAoj46EHpCtzqX61z0/eiDhfLVJPhLbTHvYlxIvcT9PQPHg1I69d
 bb7HNuVO6F49jQiPq8hFZiOO7I4VbGic4m0c8saHzeDsjsbFMj/NhAnM2HcqgEcGHxgm
 zD8kKzwPau/Y4n4cQvt3nV7qWTv/yvMOyGlS4+ux54QyXx1z5XJTfYbH/PmZvVFZoUVZ
 /JX095ugGNNqiP89/aLN+knobD5vPynP2+m8CaP3OQQ/DaJ90UQ4H2dpIAVmKnSFPUzR
 kzhIjJl0c0V8Hi0+jQQg2RI9Z6iMIf/uD+p3W/T1nmHGcEO/8lIy+XedhfVONGk8CEHo
 b+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787805907; x=1788410707;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gruEqfQPYN4ttNmxp59K39o2c8f3yt5K41EbUmDkakA=;
 b=azKs9to4MItp7uAQqOWQriHDsQAEaCgq0zCUoix8kTqSvMfa4PP5PnZBHuG0SD9GY3
 CPdGRo6mTlUojv3tmwWzNzc5YQzcWCCLeMoV/MXnE24YdeMI6GJLtUvPu1WiYR5D9FA2
 ZiaVlVLeg42WzhLJbQIQweKijxS6/1gOre3rxqtnFaHgf6Fz3NsokUVJbkLFfeQ5dyhq
 ljwa7/2jQmC99Ajrrdu+kcHpI7yw2BbgGBcdgZtMyVP1bOHO5Bvu082DWbJYtG7oI0Eh
 v5p8h+SYnjPqDEInlHnYE1VaGZmIFD/sgf12Wgs4MU3OdGjxCGGnngaFbUA3Dlrj6Jcz
 jbbQ==
X-Gm-Message-State: AFuF++nLMIVNwSSkEMUVD/QR/JUAhtQmdk7+T1gK/QAgNEZMbnccEqA0
 Jpy+4CjVVmIdHXaB1xfcKjohj9mYTi2aoK8royydg6tT69FMEANJJ+73k0tYzaN7rDSIaVevGWg
 ypPpUAA4=
X-Gm-Gg: AR+sD103C1LZFU8HCageZUOxm9I6Kahuhg+9Z+VT1GHDDYoRRwm72SKOd6xr1U1rcdZ
 Qrbj3QbEBuzw4WA6Cs6wtfuiLUs2FZBsy1wwiF5jH9xhfrTW8uqofCJKSJoqQy3I05gjROKqao4
 i2g79ktwaDoLeUTaeTn7Mo3miAwL9i38cjbH7TrnL3T1+L/fWbxFBIroZnL+yVjLjmmbs//rVAh
 RJQyFZGigDklYG4rzHiNGqr9JECnt+pJl84M1cTuJtqkrWXzz1YLAlZjs3w5hM4N5X/4VfeGB66
 kJr1zVOKA2U4/dAich0kLn4mjLDT3M92woQTLbJQCgBdqB9MJKHS+9pCna3+pusr2XVbXwxSAMm
 PK5juBtaBoO69wt58RQPVOmcurK/A+0BGruj5caX5O3Cp0Giq4k09ydb3el102eEtX+V8tIMvKs
 YIiQINRQGQZG5LWe+KMlZWTELoonpTg7Dw4uns072bdAOSSsOQ7TZFW56Hopwf1Wj/hjY2FDiho
 f11sK17jp41Xvnj0A==
X-Received: by 2002:a05:6a00:3c85:b0:847:7f3c:b5f5 with SMTP id
 d2e1a72fcca58-85374ec9fe4mr21045282b3a.11.1787805906680; 
 Wed, 26 Aug 2026 21:45:06 -0700 (PDT)
Received: from stoup (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535ced0f99sm1606003b3a.44.2026.08.26.21.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 21:45:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Tao Tang <tangtao1634@phytium.com.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 4/4] util/cpuinfo-aarch64: Fix build with older glibc headers
Date: Wed, 26 Aug 2026 21:45:02 -0700
Message-ID: <20260827044502.778915-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827044502.778915-1-richard.henderson@linaro.org>
References: <20260827044502.778915-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

From: Tao Tang <tangtao1634@phytium.com.cn>

Commit 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
started using HWCAP2_CSSC unconditionally. This macro was added to
glibc's AArch64 bits/hwcap.h during the glibc 2.38 development cycle,
so AArch64 hosts with older headers fail to build.

Follow the existing HWCAP2_BTI handling and define HWCAP2_CSSC to
zero when it is not provided by system headers. Such environments
simply do not use FEAT_CSSC host optimizations.

This has been tested on an Ubuntu 22.04 aarch64 host with glibc 2.35.

Fixes: 761bfe07b2c9 ("util/cpuinfo-aarch64: Detect FEAT_CSSC")
Signed-off-by: Tao Tang <tangtao1634@phytium.com.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260826163753.459661-1-tangtao1634@phytium.com.cn>
---
 util/cpuinfo-aarch64.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/util/cpuinfo-aarch64.c b/util/cpuinfo-aarch64.c
index 4ce6deb7c82..e3446762149 100644
--- a/util/cpuinfo-aarch64.c
+++ b/util/cpuinfo-aarch64.c
@@ -16,6 +16,9 @@
 # ifndef HWCAP2_BTI
 #  define HWCAP2_BTI 0  /* added in glibc 2.32 */
 # endif
+# ifndef HWCAP2_CSSC
+#  define HWCAP2_CSSC 0  /* added in glibc 2.38 */
+# endif
 #endif
 #ifdef CONFIG_ELF_AUX_INFO
 #include <sys/auxv.h>
-- 
2.53.0


