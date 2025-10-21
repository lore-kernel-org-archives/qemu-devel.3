Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E91BCCD1AF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 21:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJVk-0006I9-Qb; Tue, 21 Oct 2025 17:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVi-0006F6-5P
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:14 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJVg-00031P-8R
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 17:03:13 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475c1f433d8so6027485e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 14:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761080590; x=1761685390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wW2n/n59TQ98XwdluAObjuP3SDohe7zmu6LDZfQMwOI=;
 b=H0UEMW514Tjgpd47GHn/OLs0Gv+P+JJwMv3/Fsie2L/1uDqr75zCkj85RSdfYUlH4t
 mbz0utSJ2BdVbjCgKd8Ps4p/m3Y8gLu/hGI13ayY1glM04JEJZlp5FfbKvNUbze+Q/rI
 IsMgDUEpkwSQw97PD6ZXqhuSKwLbOjKEl7bsPWzt/CIl72x1HgsvTA3pq1BTjOZCRE54
 bYw4x82xoUgRRIRgkns6rYxqyXiA35v+RH1kIByur6X9jLZdh4eQdIHbUoN5QMkJHr9t
 Ngw2a++Pbm7CgV+0iE45/m7rHQW3reBNxbFozcJsnfmpj5wYB2pEU+VgUMcweifjJTge
 5QDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761080590; x=1761685390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wW2n/n59TQ98XwdluAObjuP3SDohe7zmu6LDZfQMwOI=;
 b=GCK9YKMjDJW5imjTO70YF8oC2W+JFfi9wejwzBfjmKdFqaadHmzoJAItjswx+28C7A
 dfEz2JlteOEN0mxWHSeCXWFF+4LB6MEHifWIZS2JYFbCSZqjEhWG/xqclAqMPRwupVzS
 yZWJwaaTqAi9v6GVJsm90adUCxAPwl3jQxd/3LfBjDvW18uOM2AYBcGD6T15vfHK8Ft8
 IU1fp84vpi1MphTz+TsFUSOBmCUp7hkjfbwvTiV6eeEsGex4skBXuvDwi6IPJgoYoeHV
 PW9DVtElaQ4HEzlLo88NkV8GauAjaBR0ICF8ryIfRi4uGl0Iw6ffvtYfzu6NuUpi0QSr
 kMNA==
X-Gm-Message-State: AOJu0Yxa4biquhRURKEoy8LcPhyELI+UTAgbj9WKcE7t1TOVAdPfSuUb
 sL8hcXQReMrPmbNUJOsiEPgc7Dmh/KAdJZmamtXg7XYm2XfgbpeagEOg9HJY6NoKxK++ckcyGnC
 kBWbpGqY=
X-Gm-Gg: ASbGncsi7Oqoah2VojvSQCqp/gznRcBRiW+xt07/8kproClFQhcSc8oCS/9KOg4venK
 Zf34GzB1A54O1+pHdZf+TqgDlrQ7pGJ8kAp2ezaCSmeDIQtEsxcYUzV4lJUAXZVjConYnG3r7xe
 I2mn+OjLG0ToCxbKI1kEpofkwnGXYXmxg9tH1iqsIoarhKUEffYkbtnz1kSVKymr1PVu7cPlwp7
 0jcH1LJDfQ0IXu+yOwkBoVRn3lPwZUf162Y4IT1x7Zi6iAG+TXamLj06v/E0rdi/As2Viz2FdBR
 GHt7pYNAvryShsOCva12GBiAYVaYmwl+jrK1SCsbd69/9tT8pqkacEmx11zWDc7yKXHSWplnEXQ
 ZBeEzsqEMxq54YicIEL+Ao7bDUCKnRY+kYaN3pUgVpMx+4NUF3r5xImR22xArvAbYs7sKsJDFU1
 Olq5mALRQAvlX7nEfLhyGCP517/+1Fh41R44gFSJS2BN8WOD1i7ECoJgwOTZT+
X-Google-Smtp-Source: AGHT+IFMtEd9j8AaEz8NlzRIUOAP/tDz6D2xQoMGrSoaUyb0gUF8Q3f2YMrgJMJ5QSRY5TI+FF8b4g==
X-Received: by 2002:a05:600c:548a:b0:46e:3f75:da49 with SMTP id
 5b1f17b1804b1-47117925d24mr134950305e9.37.1761080589970; 
 Tue, 21 Oct 2025 14:03:09 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b567dsm10554615e9.16.2025.10.21.14.03.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 14:03:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v7 16/19] hw/arm/virt-acpi-build: Include missing 'cpu.h'
 header
Date: Tue, 21 Oct 2025 23:01:40 +0200
Message-ID: <20251021210144.58108-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021205741.57109-1-philmd@linaro.org>
References: <20251021205741.57109-1-philmd@linaro.org>
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
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


