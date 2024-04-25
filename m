Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F562C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 10:48:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwWZ-00023x-5c; Thu, 25 Apr 2024 06:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWP-0001za-Rx
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:10 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rzwWO-0007Ao-7v
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 06:40:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-34c09040154so412764f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 03:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714041606; x=1714646406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=b6yIAJM8jr7uSpt6r8if5DSOdOSQk5RvqykVEUvE64g=;
 b=YPRs4cYsaYHY97jxa0Ozwm+RG3Zws7TRiTWbD+I4LiVUZyOkoY12FkFNDE+eTtllRx
 7RvNNieuGmNJ5KbUTe2WU/M/6jQInFjNEtZkS74x2T1AzQXdqZZtcvdKGqXkNIz/7PJd
 OKGPu7UoRuVRUJnunL1xVuFDHlZo67hZvAOQbFdDf8tZrgdaPhHYYx933ckb6sOYFxQg
 E/Mv63d6af0HuqhYB5ONF2ghlhFs463OMdQZQm5a5rNZte5BIdehtASwsnfHWYMMn96m
 jx5h8UaHfwOeqMbJ0bykO1NjwQoNfKr5Q6druXmGAsF7BPFfGN8H4/Uno2nLVikmrMog
 O8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714041606; x=1714646406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b6yIAJM8jr7uSpt6r8if5DSOdOSQk5RvqykVEUvE64g=;
 b=fIfL3KrEtliRcRaTX1n14NHMcN3yY17L99sIa+GKg+FH912n4VrJUyrOvQ6+DolGTf
 vUeFwXIz16Db6i5mAy0+T6EFkwSkR5/jfM7mi2UCutsZcKbgzimwohpQA45mEwlfj3lO
 A2jKO8C5XOPWo4T45wg2MtzxzLr7bkhP1QmZMIO0FR2veAyZVANDMWmsQ3NFmFAJ6C0t
 TG4pF67MYecFKIX8VVS46vc02yGAoBOoVVQhzZ8toxYZDah2cfuPqLljpyu4XPR0lsxi
 mtgo42HiAIfB4N+FyVc1hmODYCSGzpVUg6Tk7R+nDSHale7vKwdAI/dZxftvilnOgZro
 /0Sw==
X-Gm-Message-State: AOJu0YxPCdymPLIZEzV87dFeBYrvMaqOTJ6d92sfmHqC8x2RhwwExf0p
 ZhHUR3RkuFdfV+fwyXhk2eX3RIiKpqyEoF2EUX5xJxgTNCMweKDmnWM169K+pHFWJVqAIr7PoRS
 q
X-Google-Smtp-Source: AGHT+IEunhto1DYegTMoTqYfpazsOcWviVv5WM0Xs1q5WXDh7tAE0qPpdVz04ZUYT5J+bmAd3XxsQQ==
X-Received: by 2002:a5d:46cd:0:b0:343:edfd:113d with SMTP id
 g13-20020a5d46cd000000b00343edfd113dmr2818121wrs.71.1714041606455; 
 Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 h15-20020a056000000f00b003434c764f01sm19485768wrx.107.2024.04.25.03.40.06
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Apr 2024 03:40:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/37] hw/arm/virt: Wire NMI and VINMI irq lines from GIC to CPU
Date: Thu, 25 Apr 2024 11:39:32 +0100
Message-Id: <20240425103958.3237225-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240425103958.3237225-1-peter.maydell@linaro.org>
References: <20240425103958.3237225-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Jinjie Ruan <ruanjinjie@huawei.com>

Wire the new NMI and VINMI interrupt line from the GIC to each CPU if it
is not GICv2.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240407081733.3231820-12-ruanjinjie@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c9119ef3847..c4b03b09c27 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -821,7 +821,8 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
 
     /* Wire the outputs from each CPU's generic timer and the GICv3
      * maintenance interrupt signal to the appropriate GIC PPI inputs,
-     * and the GIC's IRQ/FIQ/VIRQ/VFIQ interrupt outputs to the CPU's inputs.
+     * and the GIC's IRQ/FIQ/VIRQ/VFIQ/NMI/VINMI interrupt outputs to the
+     * CPU's inputs.
      */
     for (i = 0; i < smp_cpus; i++) {
         DeviceState *cpudev = DEVICE(qemu_get_cpu(i));
@@ -865,6 +866,13 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                            qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
         sysbus_connect_irq(gicbusdev, i + 3 * smp_cpus,
                            qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+
+        if (vms->gic_version != VIRT_GIC_VERSION_2) {
+            sysbus_connect_irq(gicbusdev, i + 4 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_NMI));
+            sysbus_connect_irq(gicbusdev, i + 5 * smp_cpus,
+                               qdev_get_gpio_in(cpudev, ARM_CPU_VINMI));
+        }
     }
 
     fdt_add_gic_node(vms);
-- 
2.34.1


