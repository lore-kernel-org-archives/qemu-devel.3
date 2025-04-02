Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B33C36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 22:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u06W6-0005H1-Rn; Wed, 02 Apr 2025 18:25:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Vl-0004wP-RY
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:45 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u06Vk-0002aA-6D
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 18:24:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso2286155e9.3
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 15:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743632677; x=1744237477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bvg0sskfp1zs/zAw+tx6oTWh/pDWcI3/X7VI/A1vFkg=;
 b=AfD3Ebn1nx6JzteM0/cuPaMYJJUdKUbNsG5BR4EuDyR91TNSuto2/AU4eOVuonb+j1
 TkMDGEsfKV7IKCtymzgN9mqMiqBu2IkqzgVDRsr7dc6q+f1/UlsGRYpvucbH/MUwsP4Y
 gcUWB3eDSONKgraXGxE/ZYuAzSJP4YslWDIo1lTP3qtmaBRDJRCFY7ZrxbkESyOUmGvj
 zoWleV0Wg8MgQVUYJRtkP6dY7Od5sw3in2siQC8HVb7kVel1fwHSFhUW0RstYp7C0wNg
 e+iJAIt1WrZe1CYOa0c0eqJbYX28Z8RI9gCepfvichWCBrs0uMM2Ky2JX/SkpbM39l8M
 +z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743632677; x=1744237477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Bvg0sskfp1zs/zAw+tx6oTWh/pDWcI3/X7VI/A1vFkg=;
 b=iXULUZFQ3rD3ENpvTGetQ5j+1WFqbwX9/fcbMrHCrNmO2+LvrY/bSXy40W2mX974uR
 WJcsuNpMUmy/ONaQXseGLvhvBH5HTm7kmYnwN5ABOz5fcM6ocO9xAmrcPHbwXs/2RD5Y
 vSSL4Weht9jC4DgbT0kwALna8uL21FGXd3WstuVHNA/xcTIG0GUJCMoOm62z5mq2kwrY
 KShbomY4nUnW+oxxGJjwFSdXxjDGYqYpa+5Ern+vO2a8EzwhOtUIIAGOfnFPqDu39MPs
 EeuyotAnhiwnz4nnPbbLYhRSeutGu/61Hcwsk0tLxw8w6IlKvdAFWJKOaqGgFr4KyI0U
 bHtQ==
X-Gm-Message-State: AOJu0Yyoieir4TLItWl0WqWfWkE9gO8KPZgih80HUTmabbYpQWsdLBgB
 lU6fFqDRkYTnc6X0gQQ/x25eMG0dAHuuid9ajPGGAfXiGU9U69Beam5s3DIM16HO9bo4m5/5lLr
 t
X-Gm-Gg: ASbGncsFovM6OielDkhGXuG8hEHz73CIlihAfhXtxXYBdqFV8DYj3LPdNt2mYeZO4Lt
 fMUyJrW+AD+TfRSMs0wjOZbOyN8hBy2X/1hq/uoYdKLB8nL1SVJIVN30ShufmSxGr/aPyGKLCNn
 U99XE2coKhfvjkzjVk3eWXbWPugb70dS3qb9TkQaRy+2nr1xvPmAPk6YvMhm0b5wB35nZpJRNCh
 6YHyPBCYCQMtyrc7MZTesTMMD7pGrSSlC1TCz3ZjF2IbhZZi4dTspzyv5ot7GE2t4rYEGL4PkLK
 Ej8ea4o4ksnxUo3DBnfFMKDzNQ9p3QP7SuV4ekrtW2V13DvoLpX/9QUeN/30IpNCU0slz/JM9hF
 4trmN3i09f3o6zO3LZmk=
X-Google-Smtp-Source: AGHT+IFyToebJMSxLhkZnTqW+hDRMhteNFLTcRMIjhmj70tl3YkRAtShMwGAS5lZ8GmUpnr1rPCJLg==
X-Received: by 2002:a05:6000:220f:b0:391:1388:64b7 with SMTP id
 ffacd0b85a97d-39c297e4637mr3850193f8f.46.1743632677629; 
 Wed, 02 Apr 2025 15:24:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020da22sm43807f8f.68.2025.04.02.15.24.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 15:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 13/13] hw/arm/virt-acpi: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Thu,  3 Apr 2025 00:23:33 +0200
Message-ID: <20250402222334.66511-14-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402222334.66511-1-philmd@linaro.org>
References: <20250402222334.66511-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Using arm_cpu_has_feature() instead of arm_feature() remove
a dependency on (the indirectly included) "cpu.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index da61af1d359..ae28d958895 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -58,6 +58,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/cpu_has_feature.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/psci.h"
 
@@ -697,7 +698,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
         uint64_t physical_base_address = 0, gich = 0, gicv = 0;
         uint32_t vgic_interrupt = vms->virt ? ARCH_GIC_MAINT_IRQ : 0;
-        uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
+        uint32_t pmu_interrupt = arm_cpu_has_feature(armcpu, ARM_FEATURE_PMU) ?
                                              VIRTUAL_PMU_IRQ : 0;
 
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
-- 
2.47.1


