Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE038C10F16
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 16:52:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1qfO-0002hf-Lz; Tue, 30 Apr 2024 12:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qf3-0002Od-9f
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:58 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s1qex-0005ch-5O
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 12:48:57 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41c011bb920so17360185e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714495729; x=1715100529; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1X3KDYbraVKCKoUyzCUTAqrQ2WBUY6nJhep+vymKNJo=;
 b=v8hcm6YMeTWKkpCVzRagK5XBUxb8gjKv7Y5EFHzsAkikIrJ7bx59i51I2Ia8aQVD4v
 VXjhXBeGPiPQgn7t05DF4dM7n6pYybD2kFomA38xnXbh4/qxypUArdujCTzXIGXRJT7G
 kO5Bw2Q2GYnbkNSiURJSJVf6RDpMiDBS98iVaaTYFOAaphua9KMg8NgJ6G8y42EBiibf
 ZdLCnR6wUaLmy7N/HnCiPbBhI4nuXMu04aAQKHl2XEm9t8FkPOihr4852JgG24djyvhC
 WkU09/F0o75OkVtNJ9F9A5PzZCJzTr3cCyVIYBVXLRWO004qdB9pDzX8eeFSDTWuc+Il
 ahXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714495729; x=1715100529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1X3KDYbraVKCKoUyzCUTAqrQ2WBUY6nJhep+vymKNJo=;
 b=tP6TTmUs8XxSHMnpjq5OHVeI0iKWsjHzM1/FXHQHoyA6D6D/RWS+tzQJ4xNkPDZqhL
 Q309MNc4iEHdb4JQzk7r7fjLfHUudjFq6iFgFvkChpV+xDQW7+b3O6eoUP3AFZXuj4VL
 7whnJXd4+ypCwg6I9kquX3/Obavs2nifpMp5FMBX3KqtNkX7TgvRjJj8OiPm1+yV4QES
 nGSM1IZCfVZgWaVq5XQ1t6l45aRmjp+wSJ7QfyTgW/ujMCMyEP3uL6DMyQs1dK0xjjXQ
 UavQ8b8Kez6nZYVccdf21mHwbuDaEog3I6hyVhJEahB0L0waCkyn7ApIm8tDyTJS13kG
 PUZw==
X-Gm-Message-State: AOJu0Yy1JkKjgvzVkAEpSFchPiJq6SH5JT7NBZf19DjL/zfTeuDBtpxt
 Tth6DPJT+LbLsDDS2uGKCnC17z5nQzQMVUwJw9BYZ1X4y9WFmtoMj3RC3FVQC+ffI+ReG/PCCP1
 I
X-Google-Smtp-Source: AGHT+IEcLKRkl5M+ClFbEoDiaVEjb3NNosw713ne5tkMSnELVSrfG4S5HrkZtOVeSv1BI9AHSFCB9Q==
X-Received: by 2002:a05:600c:35ca:b0:41b:9427:562e with SMTP id
 r10-20020a05600c35ca00b0041b9427562emr385077wmq.12.1714495729646; 
 Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 b6-20020a05600c4e0600b0041be3383a2fsm12920384wmq.19.2024.04.30.09.48.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 09:48:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/21] hw/arm/sbsa-ref: Force CPU generic timer to 62.5MHz
Date: Tue, 30 Apr 2024 17:48:32 +0100
Message-Id: <20240430164842.4074734-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430164842.4074734-1-peter.maydell@linaro.org>
References: <20240430164842.4074734-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

Currently QEMU CPUs always run with a generic timer counter frequency
of 62.5MHz, but ARMv8.6 CPUs will run at 1GHz.  For older versions of
the TF-A firmware that sbsa-ref runs, the frequency of the generic
timer is hardcoded into the firmware, and so if the CPU actually has
a different frequency then timers in the guest will be set
incorrectly.

The default frequency used by the 'max' CPU is about to change, so
make the sbsa-ref board force the CPU frequency to the value which
the firmware expects.

Newer versions of TF-A will read the frequency from the CPU's
CNTFRQ_EL0 register:
 https://github.com/ARM-software/arm-trusted-firmware/commit/4c77fac98dac0bebc63798aae9101ac865b87148
so in the longer term we could make this board use the 1GHz
frequency. We will need to make sure we update the binaries used
by our avocado test
 Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
before we can do that.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Message-id: 20240426122913.3427983-3-peter.maydell@linaro.org
---
 hw/arm/sbsa-ref.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f5709d6c141..36f6f717b4b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -60,6 +60,19 @@
 #define NUM_SMMU_IRQS   4
 #define NUM_SATA_PORTS  6
 
+/*
+ * Generic timer frequency in Hz (which drives both the CPU generic timers
+ * and the SBSA watchdog-timer). Older versions of the TF-A firmware
+ * typically used with sbsa-ref (including the binaries in our Avocado test
+ * Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max_pauth_impdef
+ * assume it is this value.
+ *
+ * TODO: this value is not architecturally correct for an Armv8.6 or
+ * better CPU, so we should move to 1GHz once the TF-A fix above has
+ * made it into a release and into our Avocado test.
+ */
+#define SBSA_GTIMER_HZ 62500000
+
 enum {
     SBSA_FLASH,
     SBSA_MEM,
@@ -767,6 +780,8 @@ static void sbsa_ref_init(MachineState *machine)
                                     &error_abort);
         }
 
+        object_property_set_int(cpuobj, "cntfrq", SBSA_GTIMER_HZ, &error_abort);
+
         object_property_set_link(cpuobj, "memory", OBJECT(sysmem),
                                  &error_abort);
 
-- 
2.34.1


