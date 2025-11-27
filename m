Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C63D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:20:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObt8-0005wQ-IM; Thu, 27 Nov 2025 08:18:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqj-0002ed-Jb
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObqh-0001Gj-CJ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:15:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rPn3s6GJ8euZXEVXy/H77NzWhVh7YdtKya5PhJ0IVoA=;
 b=UH2DCTc56xZFFEhONtCPJ91Npx4iKP5rR/ScVq17KSDjqPdkTO+gH3sdr6+Ng7A+HSjTjQ
 3+EYuFHGnVBRkAKe+QcUleVeCeslglky5pUbaWHhgXYOnzzVA/2maFd50Xdjul55SVX5kS
 NjZr5IMxwKn205Yp8K/RpLK/Oc0SEHw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-bYsKR0DbO36SC5Cs44izPA-1; Thu, 27 Nov 2025 08:15:49 -0500
X-MC-Unique: bYsKR0DbO36SC5Cs44izPA-1
X-Mimecast-MFC-AGG-ID: bYsKR0DbO36SC5Cs44izPA_1764249343
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b767784598dso63259066b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249342; x=1764854142; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rPn3s6GJ8euZXEVXy/H77NzWhVh7YdtKya5PhJ0IVoA=;
 b=W4HhvSJfZ86NXcnjNc5NI6EsiY9W5xPBKmoMa4X19ENzq0Fx8FXj+q6zpRdLlk1txJ
 E0FzsY7scjFp1S1iRdttYhzOb97J0Fhu02V0aV87Lely9fQdRjQGdiQ8wuHrv6ubO5qz
 Up9MqKgh5SW7gtf+WrPTI/TMDg2J/R8Jm/51P4+RLqL6KHzyq7dWGJ87V2ONi7hcLhaC
 lEozBKkqxTd/lqOibncF2spDuZrV2xcvHZ5TyuS2H22PbbdMktXeT4YtkpffwWjfEapF
 0L4+8SVCmrMlawb8Y44UQAsftBLpFJmkRMn5nyuUDSwW+jf4G8JVR+EQYkzGQut6q7wF
 kNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249342; x=1764854142;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rPn3s6GJ8euZXEVXy/H77NzWhVh7YdtKya5PhJ0IVoA=;
 b=AlETIlOadCEybgTTjBJhEN7reNbeyLGpTFx/Lo58qVYd+3kI6qLM+kBd+fawtQMym6
 /Bp9+bnz4aELmeLR/s+DNnPmGLyd8bnRBb4rDdFd4AZ3Prw12LcPV/0Q1k6upGLYuu9N
 ApP4oOaRzDZ5gujVh6+UBBXo6ImAdFqUgHxvcQGq/8lyNiMGGQOczsaxoq4zbjjhfbOz
 utIVyyRyhAYvTRYNHoRyWXP8jlg8wpxtbiKwkiwm9PqkBZNLANTfztEMSrB4yjkhRB2h
 RXPmTaAc8mHgYBf8vzHZFs6CvmLL89iAkk/qXpl5r/PP3BS7mx63xOfu7W+U6YK2mGXe
 Khsg==
X-Gm-Message-State: AOJu0YzOSSgByGSg3DN1ysLSwSaU0kWCk2lqAawvM7u5Q29egzy51NUW
 MkASOJBVwlsHVf2WkpO8eJp7WdXlO0LcvZbdYbk7t+fwp5Qmh8Ng7tHEEeMrtWwWYL4kUICHcM2
 /rjSJyUMPhNqFI4Kl/uwkRgd9G1x5//ziTyORGgkroqEESTKuujesDzkmst+wFcyc/kdESNGXzh
 20OKRO/ilpCPTAdP/PL8UgiAHMkC+adlyLFVcXfhlA
X-Gm-Gg: ASbGncvaDcqnd+57miKcyF05j/8vyx3l8GLaPy/C2JBorKACbnD/kCMfSyqbOVH2J2b
 EanjUTrJm59IQukcS0a1/N1u3QFT57PW1KjUd/jYBFz08C9i1Iu0A+21Si8+L3Hkx3mZPsCwGpR
 OFpT7xbJ+FWhpn4AkH7oASX/PSAhYOIcbE/KwdVTZK3Pxeve9zBqMcaGt0TOC85YmDaP/7SlfKW
 4KxE6kVKUCYa3WCf+aIXJZdnbQILY4GVhPvk8FNu/azmEUSn5h0Owfz1SzOBnTLc6rmWYLunzd8
 8qbGnuHOLNp3tW+QcxJsx8BpHU7mOnA51nbEl9JIJns2BAltornbDGfbLpXr7lyJtMc8Y4MGwtm
 K3INLlMGd0AEZkyidKrJHF93g12u6PsmZyBt/u+eq666Mv1qrJFTmgPu5gOqZb9D82eNAzOJOQT
 2XJ+/Ko338/PP4i8I=
X-Received: by 2002:a17:907:97d6:b0:b76:2d96:6c28 with SMTP id
 a640c23a62f3a-b76715acbd4mr2409933866b.24.1764249341688; 
 Thu, 27 Nov 2025 05:15:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhiZxlursCvNaT6bq97EqynLxYV8JjekLOP/S09qU2IH1vHJyl0x583KHfB8adwD1gorEevw==
X-Received: by 2002:a17:907:97d6:b0:b76:2d96:6c28 with SMTP id
 a640c23a62f3a-b76715acbd4mr2409930866b.24.1764249341160; 
 Thu, 27 Nov 2025 05:15:41 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f59eb3f6sm154811066b.55.2025.11.27.05.15.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:15:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/28] include: move hw/platform-bus.h to hw/core/
Date: Thu, 27 Nov 2025 14:15:01 +0100
Message-ID: <20251127131516.80807-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
2.51.1


