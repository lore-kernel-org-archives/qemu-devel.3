Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB4BC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSj-0005mN-Rp; Tue, 01 Jul 2025 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSh-0005kH-6k
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:03 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSf-0003iY-5L
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:02 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so5264928f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389679; x=1751994479; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6rHpAA90Bjb+Ii0ByCKVJS29gi/VuqiHc6GuPotvdhc=;
 b=UveNdawnhhnSKBo1rZxSMaV6HdJyYrbNWjWYsobfXFGHTlBL/m3KbHoDcKghZpE5Q4
 5HUq4jQ8iF8hixrc8HJoJLtYsqinBG0B67F3rCDvLQtaz7vZzdoe/qRtAuxujXnahPib
 mXbAzvwVkEEPdhzadRbi+Uhwd1lnFd2jx37fDG4Z1uFMSeEBCQKN0YMVLv4YmO7apdm7
 no6mCRpni7NhjQd5IySRgIxeBGPZ6f9UdCM90RJ4ivPIHRvIKp7r+QD0Iqwb1ECjcHcT
 VEwykzjb34x/fmtPyPmhn1LfamqGMpwmAkc4nKz66zO7jI5GNMXX9XsPlTOqmQliRQDK
 pxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389679; x=1751994479;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6rHpAA90Bjb+Ii0ByCKVJS29gi/VuqiHc6GuPotvdhc=;
 b=kPoEHbZZq221/MUQQrmJLxxaVWyiGZVDcp0j6Vg/HWkOGGTw7YZrYRMh0KmfSx7otk
 q6g0dybMmlRIy33X83aORHAw+XPppuRB560UhkPnBANmNRPa58/B1QSrXuNRj+fwWrx/
 a1Jn+LM0tkIyOWY3qhLixQ8wBlHi8CCq+ROWC3xvBAQc9q8Y52MNN4xvtwNy8Z5MiOd0
 nC6zYO/S0/Dqz+QNboacvVXcKCJIGeLOm4utef11ijqs43dLhl8k12x2wwiI3qu4FvNh
 bDPo7WNbYBqgGISfNLgdDslX7iDptu4Mro7qIPFmFqmpD6WEGbhxSsQC+rqkooJhDx8l
 Gq7w==
X-Gm-Message-State: AOJu0YxuHISog5HHmcBC02Tn1MhRgvMZfL1B4egtnAC9w58R66T/jbhk
 rMvQl3t2Szpo7sgIZpdhPuVIRmJ+HV9GWgHV9dig5jwt/da50cajfcD0PF3XSThm+OuLfeaZS7T
 VCvlM
X-Gm-Gg: ASbGncvAi6Jy3lVNp895oBKxdLA0JALjHUL0zJ1aOiNJRUzdT4FfRR+jMHcSyO+6sOg
 ku57PGTvLDYvG+fLR46j5VXDBLHqRYe3MOUTOFtJGmWKGPPOTxvn6D37G9LMhrThgwpmWvHAZ+I
 ZB5opr7nGhyR1GNixC5gE1gnPHFyFan+Xp7DqYKWsaYXChNFHaWOsfBid37bC3eUOcGEn+wF9av
 80kkY+DaGD24qRGHAoTKcuoLjZ/K6078SNjHZs10jsZlOB7NiFlMaZGNCWgNVDRf3f8mY7YYnpD
 I02XN1H3Z1I3OAfVuxkJXinhJ4978+kbcaIGKh6Qxfn4l2tUwFyBhoCugyMCau8oFYHC
X-Google-Smtp-Source: AGHT+IEVi4r9bo9u4dEJdsJ2l1/K7SfRZ0sihlNpohm8SLtq4zvKzGbClB08cWrwVN28NTouI9ytBw==
X-Received: by 2002:a05:6000:104e:b0:3a4:f513:7f03 with SMTP id
 ffacd0b85a97d-3a917bc827cmr13193667f8f.44.1751389678879; 
 Tue, 01 Jul 2025 10:07:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/43] hw/arm/sbsa-ref: Tidy up use of RAMLIMIT_GB definition
Date: Tue,  1 Jul 2025 18:07:13 +0100
Message-ID: <20250701170720.4072660-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Define RAMLIMIT_BYTES using the TiB definition and display
the error parsed with size_to_str():

  $ qemu-system-aarch64-unsigned -M sbsa-ref -m 9T
  qemu-system-aarch64-unsigned: sbsa-ref: cannot model more than 8 TiB of RAM

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-22-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/sbsa-ref.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index deae5cf9861..15c1ff4b140 100644
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
+        char *size_str = size_to_str(RAMLIMIT_BYTES);
+
+        error_report("sbsa-ref: cannot model more than %s of RAM", size_str);
         exit(1);
     }
 
-- 
2.43.0


