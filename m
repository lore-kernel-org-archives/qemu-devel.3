Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBEC6C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 17:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEtka-0003YX-TA; Tue, 13 May 2025 13:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcp-0000uA-9x
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:12 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEtcl-0003S6-T2
 for qemu-devel@nongnu.org; Tue, 13 May 2025 13:41:05 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso60988285e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 10:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747158061; x=1747762861; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AdJyj/3YunQPgnoavXNfU5+nphnaMTFTvEkxD36KHXw=;
 b=WosqhyHuTW9SZYrhIMsj2t/V8Ky42HEyYP5a0EAvkvBeiibBd4434yZvC+O9mJtCgu
 8Uj+kui23PYh2By/90bOgN90II4s5nJU1GKQ0guJ7Z2WnG8NRmVZ1MPDKcYd4m0dv+2C
 WOPo/FDLi6i5Y3dgkyokVFbGEhJ+Kfw11s7luwCwA+VREuJGZLlcGcbaKUY/FKayZ18q
 9V9b2OruUozHSOJXN1GBbQwwRjUvijOU8jBYJZOnaQw3g0bhioiaRp9/WMJq0gAP+wdO
 cd3PqLdajaSJaWhr7dOjqfOoLiRicexGcKHfHrqev2l9r2gRjaZy+EzgyQJrOKNgK8ip
 dK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747158061; x=1747762861;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AdJyj/3YunQPgnoavXNfU5+nphnaMTFTvEkxD36KHXw=;
 b=UwY5CViVhjOVpsnqZEkoE13o77noCRxfjVGR8pK96a3x92s35Eihlp0voKu6VQ+N8t
 LoY4pWaLkgcRKz/1n9nSoDlH/oJ6QzVrZpLIS3d8BUNalQWcGuYnqDtnyIxN6H+8evMe
 4hIYHivlakB3xdPInhnrMchO3J8fbD/v7AKdNr20AGzDsg+Yk5eTXUhQoBIP3RsQJaXL
 PypPgN/KSO4pTY1S8781LuckEf8LATcStUG5QSXA4xXU4mi3SVTil6mtbc0NDPxGFGah
 P/Wpt1Ch/uncWraYzYKpirmCoSCdiXMksV5RAHaJTabnOlQv5Rytwf4lKqjzj5BWJsH2
 /4kQ==
X-Gm-Message-State: AOJu0Yz6ft79ar7GP7MufIa5q0iQ8Nc9cOsXupjJVXI2ruEr/812WFa9
 sKSUfW5sFwRINLCIps+mN9p8ETMAhP9ms5XL2tRdIBvn+yygBfSQYsQWqXKlofyHhwGK3qjOjJK
 q/OE=
X-Gm-Gg: ASbGncuPEu3UDDydtEKUTAaqBl9xOd8j6AVFHa0aOPAYQ5rAaKt89xsiXrQ6s8OdsAf
 3u+B0tBVHE6/rDNRwJ3pwH8Nt652YSkGu8cY11ia+XA9MkpcA8DgChKkU1UGsfoun3iNzIXVZEq
 5ExtbcPtoMJn+Z0PClxesNm2Fs1c1E5pP/Cy4NoPdvlO8TcRlY4qfDX0tfse/FflJbeNXWAN/hZ
 S3ozpvSMe6WBialZTdyENhxj/YxYM4UA/ykkuoKjXTATg47XYyB3L24FQRC98XT7fqf7mOm17Tp
 ssWutFvI6NAD3DU+hSRp/+yrjLi5Uysfh0XIPNsAjIdj87Lu5DDyugCA+6JtQr4K37Dc6pBZDVC
 iyqLw6PtuW2OF2ixTUemFbIfUm4xD
X-Google-Smtp-Source: AGHT+IGEzemtm9ZAf3kgDUxZQyorMNRiLrCOhn6uwaOpHEYSRqzAYgiot/jxOdmcJblrNksBE/Z87g==
X-Received: by 2002:a05:600c:524c:b0:43c:f597:d582 with SMTP id
 5b1f17b1804b1-442f20ba9f0mr1823085e9.1.1747158060572; 
 Tue, 13 May 2025 10:41:00 -0700 (PDT)
Received: from localhost.localdomain (110.8.30.213.rev.vodafone.pt.
 [213.30.8.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd32f194sm221374605e9.10.2025.05.13.10.40.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 May 2025 10:41:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 18/19] hw/arm/virt-acpi: Replace arm_feature() ->
 arm_cpu_has_feature()
Date: Tue, 13 May 2025 18:39:27 +0100
Message-ID: <20250513173928.77376-19-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250513173928.77376-1-philmd@linaro.org>
References: <20250513173928.77376-1-philmd@linaro.org>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/virt-acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 20dc93fbc54..cc4ec7ad465 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -58,6 +58,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/cpu_has_feature.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/psci.h"
 
@@ -693,7 +694,7 @@ build_madt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         ARMCPU *armcpu = ARM_CPU(qemu_get_cpu(i));
         uint64_t physical_base_address = 0, gich = 0, gicv = 0;
         uint32_t vgic_interrupt = vms->virt ? ARCH_GIC_MAINT_IRQ : 0;
-        uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
+        uint32_t pmu_interrupt = arm_cpu_has_feature(armcpu, ARM_FEATURE_PMU) ?
                                              VIRTUAL_PMU_IRQ : 0;
 
         if (vms->gic_version == VIRT_GIC_VERSION_2) {
-- 
2.47.1


