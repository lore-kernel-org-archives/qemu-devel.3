Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73668C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 14:46:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razSt-0005Re-MW; Fri, 16 Feb 2024 09:45:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSr-0005RF-Ra
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:21 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1razSq-0005Rn-2S
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:45:21 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-56394d0ee54so1071079a12.3
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 06:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708094718; x=1708699518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oXng8oGwwqDt/PMjq6VF0UcwHwIEk/qMcV0UYux3zN8=;
 b=KyfOAkKe0+C1WWTjZc9DOOW5ianms3KID6wtOQe/YL91LiFh8MHMwZyj5pI1V9XJQ6
 OvP0yOQxXrDa4ZO6EFssqixsBlpoPC1LvKySshuujyrIT29D6GU9LFHaOltjFPDCdcrM
 PgBwgvmmtRrhsBzM2qYs7F8lbdcecVtBi5/PYz+LbCSTiq+MGUPj9ARC7QPtXMaWALXi
 7y9vvhTuq5tAsgW+2TMA7sYmZowBl4qYn1d2hi0u+W7ymoRuSFoWtJdtUw3O8rMtQhWV
 reVGGF7DYVmguO+tN7ajzMflw3wr2K69Lb8cRCVEMldhcBkBTwpkgAkX5XCHYL+Zg52L
 ziNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708094718; x=1708699518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oXng8oGwwqDt/PMjq6VF0UcwHwIEk/qMcV0UYux3zN8=;
 b=Swx/2+v9BSfrjIM02VmQLrz1DoAA1NFg4DIk3qvfweFl70RNdyCNHwpx0qcqE+T+dz
 Eg0oU06GrBrws75b6qs8vh22MBVMcz9STUZzalvCE+a+Dwdka9URl7eCQKJKgYtceg6i
 J56BnxsCHPIVFp/t5x+TK8Cmma+hwTlTihg37T/94fxQeaOqe8vOYj+EuZUqgpu18N7u
 ctytZxvXmOeaW+ymcy/0Jxvl12SSJnK+lBlL22jGclC61cDcDC/zV86qYoFPMQutk+RQ
 w1rLRxWjF/2E/KOLnjEXc2qIzPoPoGp8SxDiy3hfce2sG2481XTQuzkyVWgyhkiNZwyg
 lCyA==
X-Gm-Message-State: AOJu0YzBmmk3ach84bUoRrmF13It7XD0Owwv7ay1OGHZW9kH5dy2qG98
 weOIR0ogN5v44rwKY4a9jVEUvx9i3vVeKonCLxfqewqL5cAY2jrgkqbBSlWMzc1R5kHWapZq6zr
 x
X-Google-Smtp-Source: AGHT+IGK5WYs6Evb0lMuBrJCBdo55QSC3BU2SAY6VBsZUT1RxpdpqKP5TMf2j23bsg++TMfnX3YhIA==
X-Received: by 2002:a17:906:a1d4:b0:a3b:eaa3:ecc4 with SMTP id
 bx20-20020a170906a1d400b00a3beaa3ecc4mr3985642ejb.60.1708094718406; 
 Fri, 16 Feb 2024 06:45:18 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.246])
 by smtp.gmail.com with ESMTPSA id
 th8-20020a1709078e0800b00a3d120e311asm1601054ejc.117.2024.02.16.06.45.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 16 Feb 2024 06:45:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Gustavo Romero <gustavo.romero@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Anton Kochkov <anton.kochkov@proton.me>, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/6] hw/arm: Allow some machines to use the ivshmem-flat
 device
Date: Fri, 16 Feb 2024 15:44:53 +0100
Message-ID: <20240216144456.34992-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240216144456.34992-1-philmd@linaro.org>
References: <20240216144456.34992-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-ID: <20231127052024.435743-2-gustavo.romero@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/mps2.c      | 3 +++
 hw/arm/stellaris.c | 3 +++
 hw/arm/virt.c      | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 50919ee46d..fe158dfbc0 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -42,6 +42,7 @@
 #include "hw/timer/cmsdk-apb-dualtimer.h"
 #include "hw/misc/mps2-scc.h"
 #include "hw/misc/mps2-fpgaio.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/ssi/pl022.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/net/lan9118.h"
@@ -472,6 +473,8 @@ static void mps2_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = 1;
     mc->default_ram_size = 16 * MiB;
     mc->default_ram_id = "mps.ram";
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 }
 
 static void mps2_an385_class_init(ObjectClass *oc, void *data)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index a2f998bf9e..e25858f232 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -28,6 +28,7 @@
 #include "hw/watchdog/cmsdk-apb-watchdog.h"
 #include "migration/vmstate.h"
 #include "hw/misc/unimp.h"
+#include "hw/misc/ivshmem-flat.h"
 #include "hw/timer/stellaris-gptm.h"
 #include "hw/qdev-clock.h"
 #include "qom/object.h"
@@ -1404,6 +1405,8 @@ static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
     mc->init = lm3s6965evb_init;
     mc->ignore_memory_transaction_failures = true;
     mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m3");
+
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 }
 
 static const TypeInfo lm3s6965evb_type = {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0af1943697..6c0917f3b2 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -84,6 +84,7 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "hw/char/pl011.h"
 #include "qemu/guest-random.h"
+#include "hw/misc/ivshmem-flat.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -2973,6 +2974,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_AMD_XGBE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_VFIO_PLATFORM);
+    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_IVSHMEM_FLAT);
 #ifdef CONFIG_TPM
     machine_class_allow_dynamic_sysbus_dev(mc, TYPE_TPM_TIS_SYSBUS);
 #endif
-- 
2.41.0


