Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD74C7115A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Jun 2025 13:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSF6r-00065N-MQ; Thu, 19 Jun 2025 09:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6h-00056c-AB
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:07 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSF6e-0004E1-QF
 for qemu-devel@nongnu.org; Thu, 19 Jun 2025 09:15:06 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so6683755e9.0
 for <qemu-devel@nongnu.org>; Thu, 19 Jun 2025 06:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750338903; x=1750943703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOrY1FO5kcbv6yzuU6OsNlHS46/lwsOolLM8hoDx0Ks=;
 b=iN17VTZZoDmSEWfiUkxKk6tWVMWphdhNTttC7Ru1M2Bmb+ln+RnEytJI0+baLtC2PW
 d0BZtxwBb/xpbr1MwnoK295dtgQV4mwEIZksFxGYdO511NtOfKM/1y6/j6TW8boGEyB9
 xOmvLSSoloL9NtJdjK5ECL9XzFjJhCtGeK8zpI5OIpN2RU4gPhu/fv1XWKfmLZg/tabj
 Jtja/Hq4UyWc3UxaR2qzNWUpTjH03/miLPKmG/Km0Spcn/uYuB2BbEPF+1F4y3hY2qmN
 YmI6BJG65EHpOmuhO9qyanbdnpsxAU3Twx54jyMNx0uwwnkVe56a8EWhKFe92+CHBph0
 5zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750338903; x=1750943703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOrY1FO5kcbv6yzuU6OsNlHS46/lwsOolLM8hoDx0Ks=;
 b=aEvSwpJMd4n4u7K01dLuavq37VZ1zsLOvPCq2aPW/QnhV37xuoFKzcqzEe5zncISqe
 Jn9cmx2AYX93W8q1VH4GAsCZ6BrJx6GZQwKUoWK6mx66kWbdZAmA33Io+gVDZvpN2E2O
 wZqgZdDKXLI8PIfqmW6YS9Cw65v7ck1U3ObNtwU6ceJZ4wR/Eaesxjc2A+LoXJyd4tPq
 Ep2fqmpwZ+OWO93RvsFCIjMA89fLFpxy8453fmv1ZO1hPdshWuU43i/U77quqcvJpyKl
 m4dVNNU6MJEYcJDBNP8ABxD+fbxpplQjk96rK6bajV49U+zEtSSUe3t62Xlg8SxGBdhy
 2m5w==
X-Gm-Message-State: AOJu0YymEoaCjpcRF24/T+TYWrYd5nX+WiHTkjPMRJAF2DbYcaIdstNA
 dkFyaGYnYcv/CvuohWMrWIdSUxfUMX2hrc0CW+ZEn9klB76/o/95UC3xpUsKhSw+h7R6ghFoBmO
 rZFqeAts=
X-Gm-Gg: ASbGncsiu8P935Ijkl8toESiT4uPp5JQl10UuCsZ09Vsmt21y9tsBi2md3pKHYttgCk
 xhxMVQWfwUOgXXIM5XwbHFYFcvemGSz1tp4HHF1juz2dBSQAhPNtddZn0b0TSUYVPqSL7eB1VEj
 4M2KfNfyLhGIZGN07XND2xH/dE3ZJMT3t5s4s3zPucri6rQoaEeJ9wnEFGUbeaztskbtXUM8+KT
 EPMOtCMkzaTJ6Jyyla5h7uOfSwwRAgOgzX4dTd8P1+Vj1F5MN2bq0z3tL8jgdPLTbZP+ZigqdgE
 T/iX9zYOWTTsM30M+szeun8i/w2ngs2wC82SULNWbdYW2GT8kuZwmnIWvNnDkvx+5w8M+9o7Ntm
 eMRCmksiu7wbsdc9fuU4d4se/s8UDS8YFSKtd
X-Google-Smtp-Source: AGHT+IFFj/4N5XELq/kLhF7E4qci2bJJhqg8HElhpm3KcUTcYoBlJ+rjYJOiQKm4H1fVjPvPjGO1Uw==
X-Received: by 2002:a05:600c:a01:b0:453:6150:de41 with SMTP id
 5b1f17b1804b1-4536150e073mr16395235e9.17.1750338902687; 
 Thu, 19 Jun 2025 06:15:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4535eac8bb6sm28841155e9.25.2025.06.19.06.15.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 19 Jun 2025 06:15:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>
Subject: [PATCH 19/20] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
Date: Thu, 19 Jun 2025 15:13:18 +0200
Message-ID: <20250619131319.47301-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250619131319.47301-1-philmd@linaro.org>
References: <20250619131319.47301-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Define RAMLIMIT_BYTES using the TiB definition and display
the error parsed with size_to_str():

  $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
  qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of RAM

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/sbsa-ref.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index deae5cf9861..3b7d4e7bf1d 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -53,8 +54,7 @@
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
 
-#define RAMLIMIT_GB 8192
-#define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
+#define RAMLIMIT_BYTES (8 * TiB)
 
 #define NUM_IRQS        256
 #define NUM_SMMU_IRQS   4
@@ -756,7 +756,9 @@ static void sbsa_ref_init(MachineState *machine)
     sms->smp_cpus = smp_cpus;
 
     if (machine->ram_size > sbsa_ref_memmap[SBSA_MEM].size) {
-        error_report("sbsa-ref: cannot model more than %dGB RAM", RAMLIMIT_GB);
+        g_autofree char *size_str = size_to_str(RAMLIMIT_BYTES);
+
+        error_report("sbsa-ref: cannot model more than %s of RAM", size_str);
         exit(1);
     }
 
-- 
2.49.0


