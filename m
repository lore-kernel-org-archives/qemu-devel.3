Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60C79CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qk-0005qs-VL; Tue, 07 Oct 2025 10:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QK-0005mE-Hn
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:17 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Q6-0002CT-9e
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-46e4ad36541so68183165e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846311; x=1760451111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MvgTlUzfuW2bItObmTgfE47aXUveAlTerazWNbrwPac=;
 b=V3ggzLjG1wDt/YD6R82mXEwt0Fp+lV6gV5Na/hZIPW660DoL5my076W5M5Rs1gmvy8
 eqfYndMeHle5EUDzD0h6zRgRi402FiFvyHjBtDWWcUhbILo+thMF3loDFKQg/FQTzvJl
 69eZDjlR1cwzK0cSamRoRJydzN4IgLiByfroDD8erutZJI6U9oZpnWi+0G6/SgKRHjpc
 2X4mJfP5L4QPlDtjRykCllKVvPg6Ijhc3Dbgcxe12sTkcHO864p4a7KGbQ1exUNdwMKg
 iLvT6Rbesoi0U7/owM4gKmwsWKiEWLUvmnOHggdRPvl7iyPoH+JeuvR0aHPeYV03mwcZ
 HXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846311; x=1760451111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MvgTlUzfuW2bItObmTgfE47aXUveAlTerazWNbrwPac=;
 b=b0i2pN1XlX+/Eiwn8Jlavm5NfbzJtJMgy5jyoyH6VxH438YbLMnCK25JVqfvC7TT2h
 xvdssRCiE4Lhv0H2664nZiPEuzA1hWGOi/+ela41zdSM7Q+YjGtwx70Fi6gZTs6YfcnN
 YCc8Jv/+JJc/TIq8JexTp0Bd4INfM71PeS1va9MIAOWrXu3vamgUjH7RXg47I7trttr1
 rr3jYin/Up2gaGULlC7na+b1PEjYQ0TeSK12kWtDWbvApq6QgGapadcoi6U0jG10CuG8
 dDY/GRHeciUzNPrhTM6/lS3wSGgxvzIrjO7C/sL8nB1fAeUFEwR7XayrKhzKwoGf9m4D
 KYSQ==
X-Gm-Message-State: AOJu0YxbUu7YsD+gvXJ2S3B09FIWW+NYOhDnYeBbmlyHytpCEwhPdqvt
 ebNeARzwADujrqnXHolwqCB7E1KB/BkHwgeW8/c0TpLQO4Ptgeehig5Hma2u8r4vkuoOYr9Nwck
 Qcd4Y
X-Gm-Gg: ASbGncvnOvvh0z6g5Ew8B07Xc0e3decA3bXsyXmM9h6QzVL24i/cFCGn2vZi5YjeFyg
 Lc90AEtbBiCdiVAh325Jg2XblcyDHuuowZTp0Xb+gYnesueaOs2oicsDN8De1OqXnsBTImsxBXu
 UEgrr1/MHrAcMv814xACYQC4LruWzVudvJPTHOswjPdsuskFBwC9KtPtOO//pim+ASVAQgIQloj
 SWbu47Oopbs6s45PxRbiCjqHPu/HSN8T9gCHqIxJs3v4DFWkr3mLOk2FlI8UCs1ZJPNTu+bVtOg
 8NfOa3vgqj53eHJ837+V378KzJePqYAUxYeWAfkX/l4517zzNHCa8qoDdAhId9NRwskPHQ4oPg2
 GyRMR7oB92U27N0URG+klHE2E9IOAujzib9lpmMl6M5RCylU/0QVzhiYz
X-Google-Smtp-Source: AGHT+IE6dTeMuY5cMj9+FvUssOgh2Z2UMJTy/ySUY6JWNdlr40d03iM3OnzueLK0n+wyhXgLVI+EnQ==
X-Received: by 2002:a05:600c:1d11:b0:46e:330a:1762 with SMTP id
 5b1f17b1804b1-46e71145811mr99375205e9.22.1759846310975; 
 Tue, 07 Oct 2025 07:11:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/62] hw/intc/arm_gicv3: Introduce a 'first-cpu-index' property
Date: Tue,  7 Oct 2025 15:10:44 +0100
Message-ID: <20251007141123.3239867-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Francisco Iglesias <francisco.iglesias@xilinx.com>

Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
connected to the GICv3. This makes it possible to have multiple instances
of the GICv3 connected to different CPU clusters.

For KVM, mark this property has unsupported. It probably does not make
much sense as it is intented to be used to model non-SMP systems.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-24-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/intc/arm_gicv3_common.h | 1 +
 hw/intc/arm_gicv3_common.c         | 3 ++-
 hw/intc/arm_gicv3_cpuif.c          | 2 +-
 hw/intc/arm_gicv3_kvm.c            | 6 ++++++
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index 572d971d22c..38aa1961c50 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -229,6 +229,7 @@ struct GICv3State {
     uint32_t *redist_region_count; /* redistributor count within each region */
     uint32_t nb_redist_regions; /* number of redist regions */
 
+    uint32_t first_cpu_idx;
     uint32_t num_cpu;
     uint32_t num_irq;
     uint32_t revision;
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e438d8c042d..2d0df6da86c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -436,7 +436,7 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
     s->cpu = g_new0(GICv3CPUState, s->num_cpu);
 
     for (i = 0; i < s->num_cpu; i++) {
-        CPUState *cpu = qemu_get_cpu(i);
+        CPUState *cpu = qemu_get_cpu(s->first_cpu_idx + i);
         uint64_t cpu_affid;
 
         s->cpu[i].cpu = cpu;
@@ -622,6 +622,7 @@ static const Property arm_gicv3_common_properties[] = {
                       redist_region_count, qdev_prop_uint32, uint32_t),
     DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
                      MemoryRegion *),
+    DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
 };
 
 static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index 72e91f971a4..2e6c1f778a9 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -3024,7 +3024,7 @@ void gicv3_init_cpuif(GICv3State *s)
     int i;
 
     for (i = 0; i < s->num_cpu; i++) {
-        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
+        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
         GICv3CPUState *cs = &s->cpu[i];
 
         /*
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 0cd14d78a75..9829e2146da 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -821,6 +821,12 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->first_cpu_idx != 0) {
+        error_setg(errp, "Non-zero first-cpu-idx is unsupported with the "
+                   "in-kernel GIC");
+        return;
+    }
+
     gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
 
     for (i = 0; i < s->num_cpu; i++) {
-- 
2.43.0


