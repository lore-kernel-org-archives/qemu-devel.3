Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F9FC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UUl-0006Am-O1; Thu, 03 Apr 2025 20:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUb-0005ag-JY
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UUZ-00035b-Pf
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:01:05 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso1633971f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724862; x=1744329662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ql/mC2IOtWZLIqcQeQJUXW7zdNSSuVI9j8UwEDiydo8=;
 b=SYK9tOQ2hGvL8WackKLb108UKotVCoUgcaNJqTuo1dhpbT7XPDWi/RoOoFL2Ao5hRZ
 PzsL+Q1uytbQbYnr2HrMIsXzDL+MXpOVVqvh3gT9p8MzojlOgX6VtL10wbFfn0STxr2K
 1n1Eiq1lwr61x2RoC27UyP9FYJ0wtmEhmcr8/0XgbKP7FyCBWpIiFDYMkowk10Em1PzR
 fKmukm8Fay1To3xnh5LACg3injnta+vRCcUO5wZ+Kew6D4KqXhmIWqFcdaM5eU7RZ7Jt
 BpKj0lNl7Z6utZVDLpOU6LNzCaEJBBaj2yNG/hidl+tgX4nT1aPc0f7M0yU5+mInwsiu
 qaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724862; x=1744329662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ql/mC2IOtWZLIqcQeQJUXW7zdNSSuVI9j8UwEDiydo8=;
 b=CwOAVvPJ/8afLRDmzzvFzCroDl9/YOM7+w2pq03xkVRwghV7+IGW/Y5wRQKiKjL+h0
 WYEwnfh7o6YFmGnVgFk/st+j8pgnL99QG2w/BQ5deIHILV1DURolu7jEig6E4wutUfr/
 HLSgRGFu2jWOcFIkzZHdti3kEcmfcFq92tsAnS1gZWcws4eUf0/2Hp3Xcq75/tsMDrOZ
 8A1Ku8m8R6y7hCPQx9pgAJroZUXguCn9A0J+eZtHV0h559/1hR8z8CmUMQUp4v0nNMau
 gqyQKGMUMJUM81JnIxepNan4ooGKVG+wMhSJzhMiBi66L660eTylvGOAsX2bnr7p7c9P
 vvVA==
X-Gm-Message-State: AOJu0YwSHXPRNipiHL3q7ibrMO3VHSR0CXZX5Sr1Qdj/Q2V7xVc9H/Hw
 Nr/BQfDs140P0RqLUy8dKsN6AQxi4nrEuqs2NFo0y812cnCFemIksPA+WL4b4K74rbyKHpiPGZ1
 c
X-Gm-Gg: ASbGnctVLqfSf9OJp84DSgoT/DiIp8E0h+6RZm3NBtEW5bTxFikBK+B7orvtyl0X02a
 UAyUvZQrFuH8hV09wJcm7wRQm/EfKtjVBQ3rPZaGPOM3a5gOWdtMHzQc3K14mE2rgQ1aGIJTEKC
 0Tf54V3v3aVkUpQgqKe/b4t5vQLxzoSqim2e2/PseSyGOBrDDy+E+Zs87pUZUP3R63aemqdQtUq
 HEZc9kVKoKwWPTkCeZYlTTeX5rfRd4KDv38feqEH+JTpPz6w46jqii+dRJ/WTJ1gtfKAY/TrGP0
 nJsq2+MstA81wnplz8d6och5UGiJUsgoSjRBraRZNL8JMVqDQm8SyJEmfOD1yjoL9mbwQwr92df
 ihHZ3gi4r3+Cw8f1ZUoM=
X-Google-Smtp-Source: AGHT+IGUx4U4/AV0aTekH+oHJljzubczg6SkTkW6qPPBQAgNTiyZyiYQnRf8fDIS1u6dp+n+Dl9qHQ==
X-Received: by 2002:a05:6000:4212:b0:39c:1efb:eec9 with SMTP id
 ffacd0b85a97d-39cb35b8aeamr736945f8f.13.1743724862023; 
 Thu, 03 Apr 2025 17:01:02 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c3020d63csm3041048f8f.69.2025.04.03.17.01.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:01:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 24/39] hw/arm/virt-acpi: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Fri,  4 Apr 2025 01:58:06 +0200
Message-ID: <20250403235821.9909-25-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

Using arm_cpu_has_feature() instead of arm_feature() remove
a dependency on (the indirectly included) "cpu.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


