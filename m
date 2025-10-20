Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C3FCCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 22:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyEq-0004se-2e; Mon, 20 Oct 2025 18:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEo-0004rg-B8
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAyEm-0007Sr-7a
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 18:20:21 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so29124095e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 15:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760998818; x=1761603618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D/MX9EUM3OlM0fVIXCU1R8/yICbcVLFwc2FcsNTruKA=;
 b=HXhRxyCrhb+AjRMaSIVhzQ8dvZcNFigtKkiR2Wwqt9TL0Hx58qpi3oh6fHNizeBaWU
 Kf3prR+AXKN2SounIpog77Z/fnDP7AAW0mnE4b1aJpkzctV0Bsko8kCo3AWa7XEK0afc
 y5aWP7pSLuEMMb1JsKPbPKRh6wKlzi4yNJsA/e5TWMQMvaQkvhDL1fp9L+Rw2kKFmI8c
 mMAJQhAFpxhaspS1WNALb0Ip1vhJ4wNdWsopMkgbsXD+B42Mn0Q5MJdGvEBXLlIX+Z0J
 Uqxc0cnJ2QAEYuKxsyAIJLz4rRae+z2DPj/AbT2Aw6v4WPx8TVlsi0GSJQiVB4++DUx0
 5hGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760998818; x=1761603618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D/MX9EUM3OlM0fVIXCU1R8/yICbcVLFwc2FcsNTruKA=;
 b=A98Tnsf8VlbYVHgmHxLc3NOd0vPNjutXrMPDJXSQg4KICUKa5lPayAsN7T0X/PeJYx
 ejIkWLvhxiiih8tpLjVd9irQ+hFGwYvFyXjHxRJismKal7PA1DSoiJAo/2NmZxIEBZQS
 fsfWkFoqWZpCzWJxWQv8NXIQKlTu2Ca+xQZMi/nOg+gKSpFWWs+GOGdzVcn5ZXlRGWbb
 kBlgdLWJw03uNMb/1vIw0hVEIAxNCaoGUpxGYZ55G0qwejxsrwikDW48gbO9sc2AV8Vg
 WIo/0lEf8zqX90kxUyDmSVT1iLJCsuF43Od6H4aS34qZ8mqMOSqW3+2KeYbE8iJHSpN3
 ZeFA==
X-Gm-Message-State: AOJu0Yx9pLdN3QQ7y4Gh68VpkDklTq15+8DERGyCACyv4jne/WkwFTGU
 uyWWSdMd9pBjDrfJ3aUgQ8UqgWZP/2vLntx/qB72fUwmEKsk3Nv0StudRAA3pg96/72InITSxDM
 gQMXjfZs=
X-Gm-Gg: ASbGnct70VVfFpnsZbuDvTY9GHASDSu0hGe3cwj+UO58LAmZEojDcm2Hks7JWUaplEK
 ib8rtHy2QCmDemVHJHV73yJPeL/fPDyvm4gSZ8kOsjUjhQJNDy/lLHe8KrOzJHMLNsI5I1t4237
 8NyewEm3KKPbZWLkKpK6OKIIuJoCKaPD2RTJLpvd0qaVwMV4V4fH8bjT02vQ01DGdKdo1t7fNzB
 lSOph4Ws3OkdlcOQ8iF+gYtPY3DxAexfF4sgtdbol1PG/cKxB2HKfBMwydxV2GYifh/I3Mj6B3G
 9TJ2hOz6xmUJ/MBjuwnFW7kfk6B0tal7IFNe4yKKUmLvlcID86JZQ0ohZbIfEzve+3V+eTiGxeU
 MKILGG9a0A/Sm3H5q35emrhLWU1FuE5iiFZtm2eiljzYR5pPsVLoyJk4I7nmle52LVSM8CGDQtf
 pec/0B/pHI6g5C5S9+Qyns9aYpbXK80VzHDNE8dwK5+SsQVtjLZA==
X-Google-Smtp-Source: AGHT+IHQd94WnxOqRShneHwKD1auZ5AJi9lX/D5JtmhSmJqVvl4rtAmLxPX6xUZIlTT0afo+HO6Fjg==
X-Received: by 2002:a05:600c:1d9b:b0:46e:38f7:625f with SMTP id
 5b1f17b1804b1-471178771b6mr98997475e9.10.1760998818083; 
 Mon, 20 Oct 2025 15:20:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-474975af467sm3992735e9.10.2025.10.20.15.20.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 15:20:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Luc Michel <luc.michel@amd.com>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v6 26/30] hw/arm/virt-acpi-build: Include missing 'cpu.h'
 header
Date: Tue, 21 Oct 2025 00:20:06 +0200
Message-ID: <20251020222010.68708-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020220941.65269-1-philmd@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

"cpu.h" is indirectly pulled in by another header. Include
it explicitly in order to avoid when changing default CPPFLAGS path:

  hw/arm/virt-acpi-build.c:903:34: error: call to undeclared function 'arm_feature';
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                  ^
  hw/arm/virt-acpi-build.c:903:53: error: incomplete definition of type 'ARMCPU' (aka 'struct ArchCPU')
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                               ~~~~~~^
  include/qemu/typedefs.h:30:16: note: forward declaration of 'struct ArchCPU'
     30 | typedef struct ArchCPU ArchCPU;
        |                ^
  hw/arm/virt-acpi-build.c:903:60: error: use of undeclared identifier 'ARM_FEATURE_PMU'
    903 |         uint32_t pmu_interrupt = arm_feature(&armcpu->env, ARM_FEATURE_PMU) ?
        |                                                            ^
  hw/arm/virt-acpi-build.c:993:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_DISABLED'
    993 |     case QEMU_PSCI_CONDUIT_DISABLED:
        |          ^
  hw/arm/virt-acpi-build.c:996:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_HVC'
    996 |     case QEMU_PSCI_CONDUIT_HVC:
        |          ^
  hw/arm/virt-acpi-build.c:1000:10: error: use of undeclared identifier 'QEMU_PSCI_CONDUIT_SMC'
   1000 |     case QEMU_PSCI_CONDUIT_SMC:
        |          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 8bb6b605154..200e2a1da70 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -62,6 +62,7 @@
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
 #define ARM_SPI_BASE 32
-- 
2.51.0


