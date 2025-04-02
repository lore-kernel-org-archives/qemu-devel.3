Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C2EC36018
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05mi-0005tC-1X; Wed, 02 Apr 2025 17:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05mh-0005t1-3Y
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:38:07 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05mf-0007ba-Cm
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:38:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso1280805e9.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743629882; x=1744234682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BJQTSCHQrb2RlU2HrCmbH5Umg4qlaYSReFutvUFFf74=;
 b=vYxgEINLXGYAa1Q+KFfN/1xkVuHCIbRfaI1TlFJwK5dmgkQj6GQ5H5vcajfv+Ne3ry
 Xn/e7mhXbXUHo/+x0NknN2t/W/bGEuFrh+HMX9+FtieDUJBMB9IH/H7WoOAgO7RxFN9c
 2WWLyrDDeXZceBBl6XLJY2wEaj0TAF+ywqLXkv7r5C3B2e39eZmSKQ2JDXrs2kAdz4Pa
 5WRMLlteyHBjicTBopKc/jnVP07RO9MUHFyut0VzW5yjmcoDfBBLHx/9htq+8zRhAWCO
 /ITj23WQfts5aoz/wB0KLIqbhg8PPK2ib8WzBOk39xE0Gg+pOTkct8LX84sb8sf+FB2A
 Qxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743629882; x=1744234682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BJQTSCHQrb2RlU2HrCmbH5Umg4qlaYSReFutvUFFf74=;
 b=ogZCOniFy+CNDOWP5k2IgwjNWSh+N2SKzxkGlBb9YnJ3Hf1jjl1dVU9k5fAVMBu4l3
 HOHzc1yDdWuo4QVHrZKw9/u3JnroXLJbRQROxgntQV5Xs1anmk5aqgx4z0y2SxoXGDNI
 K0X+yzt7JPqEG7eXG8zOnKfsLme2B9ug3QN6l1Ls53cg/G2WIdUVyh9bJe94SIP9nEsM
 PrOcbfPCGNbwfrAnNUdU6xJrTDkM5q8wUXMeSDdi5UXYRn4AhgJGFCaNMC2gjF5VCBx2
 lhepi8bDDMjHIumNDnJR3MMjUlDLDcIk4nBVHnxYL79gsFYpMbI+I3xgM0QoXGynCk05
 og7A==
X-Gm-Message-State: AOJu0YwLoPhcInbcoRMjBvQrKGNG1ZRiVvOcaNfIT8DUoWd1LR/r3D+T
 /ZgvkIO2g8RYP0SlAz7ZGgdMA3wLsVjVL2XM628KtjzEVNQIUu3oSVclVDgr6erv3SvQHUtZokT
 S
X-Gm-Gg: ASbGncuh+Jwk1JHiYlRhmatSqt09GJXwcUZfcIJPlPHXZ0ykvTe+herR96xvlVAkRVG
 UzXbDVVyXAxlAEYzlvQqH9bhar5E2T3IQ8yo08eFze/UD/yH9woKweuv1SCbSvMohVQnvkY5xRR
 /L9RLExbpabLlExLXUvOVteXH21HB5Kk71KZLDouHXmee4VEcqZb5/c6J65C9et3AHvcaDQYBZH
 p7lBCdIuGcY48XBRPq8TVnydI+sQfkjeylIBqXwmFSoslme5ozv6hJEW4BmNeYr02RYx81GwzBE
 6POs1rpiQSSPPMSAUhxI46ZaigDtRrhUF+ydcmQV0u7u24QZIoF0FpmrSGUyZy1rPEmLai+IGJR
 4+vEVeU2DVyZJbHyBZ/zt6xgdSN2Sig==
X-Google-Smtp-Source: AGHT+IFQbCO/fW3x0zcv1BZ2L1klr1PJ9+VJ8EPpYk/sFOl1O7q2/L2ZpfbHMYZu1afyOGP4BWBHaA==
X-Received: by 2002:a05:600c:138d:b0:43c:f44c:72b7 with SMTP id
 5b1f17b1804b1-43db61ff68bmr182922145e9.14.1743629882341; 
 Wed, 02 Apr 2025 14:38:02 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a4346sm18302360f8f.95.2025.04.02.14.38.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:38:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1] hw/intc: Build TYPE_M68K_IRQC with common system
 objects
Date: Wed,  2 Apr 2025 23:38:00 +0200
Message-ID: <20250402213800.61803-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

m68k_set_irq_level() prototype doesn't use target-specific
types, move its declaration from target-specific "cpu.h"
to target-agnostic "cpu-qom.h". Doing so we can remove the
"cpu.h" header in m68k_irqc.c, making it target-agnostic,
which can be build as part of the system_ss[] source set.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/m68k/cpu-qom.h | 2 ++
 target/m68k/cpu.h     | 1 -
 hw/intc/m68k_irqc.c   | 2 +-
 hw/intc/meson.build   | 2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/target/m68k/cpu-qom.h b/target/m68k/cpu-qom.h
index 273e8eae417..fa048c05a69 100644
--- a/target/m68k/cpu-qom.h
+++ b/target/m68k/cpu-qom.h
@@ -29,4 +29,6 @@ OBJECT_DECLARE_CPU_TYPE(M68kCPU, M68kCPUClass, M68K_CPU)
 #define M68K_CPU_TYPE_SUFFIX "-" TYPE_M68K_CPU
 #define M68K_CPU_TYPE_NAME(model) model M68K_CPU_TYPE_SUFFIX
 
+void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector);
+
 #endif
diff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
index 39d0b9d6d73..f35db0afd05 100644
--- a/target/m68k/cpu.h
+++ b/target/m68k/cpu.h
@@ -472,7 +472,6 @@ typedef enum {
 #define MACSR_V     0x002
 #define MACSR_EV    0x001
 
-void m68k_set_irq_level(M68kCPU *cpu, int level, uint8_t vector);
 void m68k_switch_sp(CPUM68KState *env);
 
 void do_m68k_semihosting(CPUM68KState *env, int nr);
diff --git a/hw/intc/m68k_irqc.c b/hw/intc/m68k_irqc.c
index a82b80f5c6f..ab85bf7412b 100644
--- a/hw/intc/m68k_irqc.c
+++ b/hw/intc/m68k_irqc.c
@@ -8,12 +8,12 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "migration/vmstate.h"
 #include "hw/qdev-properties.h"
 #include "hw/nmi.h"
 #include "hw/intc/intc.h"
 #include "hw/intc/m68k_irqc.h"
+#include "target/m68k/cpu-qom.h"
 
 
 static bool m68k_irqc_get_statistics(InterruptStatsProvider *obj,
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 602da304b02..92c4565c598 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -67,7 +67,7 @@ specific_ss.add(when: 'CONFIG_PSERIES', if_true: files('xics_spapr.c', 'spapr_xi
 specific_ss.add(when: 'CONFIG_XIVE', if_true: files('xive.c'))
 specific_ss.add(when: ['CONFIG_KVM', 'CONFIG_XIVE'],
 		if_true: files('spapr_xive_kvm.c'))
-specific_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
+system_ss.add(when: 'CONFIG_M68K_IRQC', if_true: files('m68k_irqc.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI_COMMON', if_true: files('loongson_ipi_common.c'))
 specific_ss.add(when: 'CONFIG_LOONGSON_IPI', if_true: files('loongson_ipi.c'))
 specific_ss.add(when: 'CONFIG_LOONGARCH_IPI', if_true: files('loongarch_ipi.c'))
-- 
2.47.1


