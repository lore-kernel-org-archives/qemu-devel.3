Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2128E8FDD4
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQ0-0002T9-Qb; Sat, 27 Dec 2025 04:17:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPz-0002Rj-El
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPw-0002Lb-K3
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IRRc12ujGhS7SLR8p9U60qM+708r0Z/dh85biQeypj4=;
 b=f4/Hyhgmt+dpJXzD8Ypzv1vtUiuJIbaDbxXVqSva1TeFmhWn3JUyEj+Bfaz2XafuWzPBoh
 79mkeXxrBTZCwvmpcryVMkPLqz1mpQ7Q9ZYUoM4U1Ihy10jCddi61i42ZQIj43bpBHy8Ca
 7QtL7fYN8ZxN/PBWiRdVpc2c7Qx3R5U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-v42QMHwuMNyS5-EaexzVig-1; Sat, 27 Dec 2025 04:16:54 -0500
X-MC-Unique: v42QMHwuMNyS5-EaexzVig-1
X-Mimecast-MFC-AGG-ID: v42QMHwuMNyS5-EaexzVig_1766827013
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-47a83800743so43348535e9.0
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827012; x=1767431812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IRRc12ujGhS7SLR8p9U60qM+708r0Z/dh85biQeypj4=;
 b=oVTuHUhwUNWcPvJMm4NTtYYrxX/Das93pXThhgG8a+QUEjG2xVaFZvrbRQQkh0wL14
 cR9TVf4JipmnpGt2dbjAIL/ZCAN+VSwn+UmfX/toQKkSQTrJ0xkTgSEYmfn9qC2AfVZm
 tNmhSjYI+JykdMV/6odBvI7gw9+hjqBQW+1F/zPouIHOEXyhpA1p4YZswfKGXLeAMLRy
 fb+hhioloN98m7Tk8U0KHtbpHIxKAX7H0kbSxa63iGkCITmh5CGb+uQncnfDvtDopJ/m
 Tq66DXWeG0Y3xNpsZ2nRKD8iUdEfZHkUwuRDcbKj3JXGhLXdnaLzFmM9oDqZcNiEmEbS
 +jtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827012; x=1767431812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IRRc12ujGhS7SLR8p9U60qM+708r0Z/dh85biQeypj4=;
 b=vul9h7gbraT0WFJoqDQ+2+r8V3iGQMWsZCV8ThHnoachsP/YhuePDFTPA5oFXiyxm7
 A4afImUwqq/W7kokxBEjNqsJGHbdSH9MWULpo4TuKEU+ytyA1NA1c5nUnZb2XGKwXFxv
 Iuv72nGuGAfjbYwtEqMFa9j/KdJHSQZnXwiuSofsRlmiAGWKDjytzkk0p5s1QgK2HoLa
 N4Uih5eART4cU3uvQuGEsNjzJlWTb8BJfirVIDjfHTW/19GYbMDyJpbsziUYUXgR0juh
 UiUPdgyZIcSkzSH3JKTY5UUStMwBLNh3S8w94gFWbBG2Fx9dsELn/QiuEDlQT5utI7pY
 GEfg==
X-Gm-Message-State: AOJu0YybupTAMlB3j3GyKmu/51g4AVd66OBnl8I0Hg3T3eoysM2zudGs
 5rrTDkY02YFzL+TnslGHghhVhNNnBpo5bZibmvTaYSBbJyroto4X9ys5k0cWT7y0igEvdAv37YF
 x3VdFGbNBBKtTE4mRFrF6TjovVUrbwJZK4PIYFV9kP4VVMU2xyDw1JkZBlnO/lwat0HdVK/llnP
 xgE9ACLZcUwCCpzBXh+iVQrJzRLp9DD0R1CwMFn91m
X-Gm-Gg: AY/fxX7Lir0L8CRuTbAcQTieRG1FxiZJAcGUI68g9dUg2EgRy6LdNXgi20zPXkuULdi
 uoH0aFzA2BvImV3ZkDwlvHBEeYGjlwveA8FHMl45Cv5MfP9WELwk2lE1G+zT6OsjadFkIuDdVye
 EX6QezEvkksSnC6GwoCOqZF2AdmfwUXQ4vhtr6QHw/DruGk1INB2zbgrPy7Z52B34F+dqg5HkZv
 RzZtPe6SLkJO+UqsTYz7tgchj5ivtq7pFrvpgkvekB5sFQo2L6+0C1AyH3RYM1NBFaAAlDFKsRv
 E8Jk6U7LHYVhBCM0GNOyha5v94BAP/YHHKe/De11Yuj56ZTFeTfVfqx9SVQdQ5mUnxOkZ0yUzfw
 BPrV5o+orqWtm5AR96WDd3vqFCFUJ0WHc28m+aCUw8FEODu6+A2QuFSrLB9zWOkKeQKMQW75TVr
 hiYbM+6u8V2iZuDA4=
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273739435e9.1.1766827011919; 
 Sat, 27 Dec 2025 01:16:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdZs1cRiybMYAtfEi1ECw1M8v9XOWcvO0CsW0ke+JT4Ni5VdddC1R50GImcMG3AyWJfKXa7w==
X-Received: by 2002:a05:600c:4f08:b0:475:d9de:952e with SMTP id
 5b1f17b1804b1-47d18b83218mr273739255e9.1.1766827011378; 
 Sat, 27 Dec 2025 01:16:51 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa0908sm49530377f8f.31.2025.12.27.01.16.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 015/153] include: move hw/platform-bus.h to hw/core/
Date: Sat, 27 Dec 2025 10:14:02 +0100
Message-ID: <20251227091622.20725-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/e500.h                        | 2 +-
 include/hw/{ => core}/platform-bus.h | 0
 hw/arm/virt-acpi-build.c             | 2 +-
 hw/arm/virt.c                        | 2 +-
 hw/core/platform-bus.c               | 2 +-
 hw/core/sysbus-fdt.c                 | 2 +-
 hw/loongarch/virt-acpi-build.c       | 2 +-
 hw/loongarch/virt.c                  | 2 +-
 hw/ppc/e500.c                        | 2 +-
 hw/riscv/virt.c                      | 2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename include/hw/{ => core}/platform-bus.h (100%)

diff --git a/hw/ppc/e500.h b/hw/ppc/e500.h
index cda539bda18..11f8ae53177 100644
--- a/hw/ppc/e500.h
+++ b/hw/ppc/e500.h
@@ -2,7 +2,7 @@
 #define PPCE500_H
 
 #include "hw/core/boards.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "qom/object.h"
 
 #define PLATFORM_CLK_FREQ_HZ (400 * 1000 * 1000)
diff --git a/include/hw/platform-bus.h b/include/hw/core/platform-bus.h
similarity index 100%
rename from include/hw/platform-bus.h
rename to include/hw/core/platform-bus.h
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 200e2a1da70..03b43425746 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -54,7 +54,7 @@
 #include "hw/arm/virt.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "system/numa.h"
 #include "system/reset.h"
 #include "system/tpm.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c005eb914cb..0d2652e6dbc 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -62,7 +62,7 @@
 #include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/virtio/virtio-pci.h"
 #include "hw/core/sysbus-fdt.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/qdev-properties.h"
 #include "hw/arm/fdt.h"
 #include "hw/intc/arm_gic.h"
diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index 6950063de4f..4b6cc5f6498 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -20,7 +20,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/core/sysbus-fdt.c b/hw/core/sysbus-fdt.c
index 59f1d17de11..89d0c464454 100644
--- a/hw/core/sysbus-fdt.c
+++ b/hw/core/sysbus-fdt.c
@@ -32,7 +32,7 @@
 #include "system/device_tree.h"
 #include "system/tpm.h"
 #include "hw/arm/smmuv3.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/arm/fdt.h"
diff --git a/hw/loongarch/virt-acpi-build.c b/hw/loongarch/virt-acpi-build.c
index 3694c9827f0..8ff9ebdcd9e 100644
--- a/hw/loongarch/virt-acpi-build.c
+++ b/hw/loongarch/virt-acpi-build.c
@@ -32,7 +32,7 @@
 #include "hw/pci-host/gpex.h"
 #include "system/system.h"
 #include "system/tpm.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/hmat.h"
 
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index ea53941aeb9..6efa15da473 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -37,7 +37,7 @@
 #include "qapi/qapi-visit-common.h"
 #include "hw/acpi/generic_event_device.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/display/ramfb.h"
 #include "hw/uefi/var-service-api.h"
 #include "hw/mem/pc-dimm.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 769f18023d5..7c65757e215 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -46,7 +46,7 @@
 #include "qemu/option.h"
 #include "hw/pci-host/ppce500.h"
 #include "qemu/error-report.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
 #include "hw/i2c/i2c.h"
 #include "hw/core/irq.h"
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 0505bffa44a..9cb4f16432e 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -43,7 +43,7 @@
 #include "hw/intc/riscv_aplic.h"
 #include "hw/intc/sifive_plic.h"
 #include "hw/misc/sifive_test.h"
-#include "hw/platform-bus.h"
+#include "hw/core/platform-bus.h"
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
-- 
2.52.0


