Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19C0CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:17:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu54a-0006Gd-Tp; Thu, 04 Sep 2025 04:12:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54Y-0006Co-5T
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:58 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uu54J-00040u-5N
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:11:57 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-619487c8865so3298491a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Sep 2025 01:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756973500; x=1757578300; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYVyVNsFyTXeOSFCWu8uUvsiqoxRwuwTGPuSI8iWgeI=;
 b=rZ4ZeC78nxBSs7Hm28KPJA5UJ9/lmcd+qT6HI2dPYRgjbSbw8vupniVlEUHXvqpbsn
 6MeEkMYeEq/YchF968lN9sYtAbppFqVpYC/43sQmjCIMFtH9d3RCZy0CjSbJlH0COMkO
 p+fkLqifdJb4uTSQDeYHOcAWBNd15ftan2CM9gzXQNY4LC9D918wKhTnIoynp/txtjm8
 Zmzu4E1LcDGH1WKI8qe9NIZZhVPWdReTtf8tfSByB9PJuRE25pirUXXDydE/M97AnMaN
 eInmWkGSTDl936dtve9BqbQUbseczCRXpssU3GICm/dRQ/c6TRcMGz/ZdIfHPbM+58zL
 qIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756973500; x=1757578300;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZYVyVNsFyTXeOSFCWu8uUvsiqoxRwuwTGPuSI8iWgeI=;
 b=HVeT957DZvH+IeWoMsexbuae3UsJ5lcsFgwqZ65/AGP9STTd85RFR2zR8RJ+1fieN1
 +SF0X+vRXdjnkp63w4U5W67W9hCWqfKcICiICrQ9uq/4kykIldHgc0gzWt6ckQV3bdvC
 rpXYcZYpxLd0WEx7i6plD0xuyw6c6bV/EBwR4yE7fqLq8pWVw+ZbEW/HzE3Z0UDoB60b
 jUJn99PWH1EIcnCZz6LUlwW342CVKKfhMfjI2bzjVDUdwaVZ725kMh/2hI5GkTmcJlY0
 dvomh8XdRod5mg+igZauqg3Oal81MgPeEAMnRqt0gNOsMYNP18/cSZ0Men2qHP8toPJW
 dUPQ==
X-Gm-Message-State: AOJu0YzCONoUr7rhOW9DMXWxLISTMM1ZFmJLoKO5/Q/Zd4wNJDzZQLVK
 EusPsj9oLea5EmaJDmRNAFyM+9XAK+r8azhgpcY9+ylqCtcvjjgGY+k1LpkFM9XGpZyqDwrZvKd
 9bhvWCN2c7A==
X-Gm-Gg: ASbGncvaNq0VYr65rpmP+uJmn4ELOykJvW+2kqwSdCr9K/UXjLLFyMoiSMnIrPIutdu
 Xax3K/QD4jTH3vWnKd3IW9GfSaNoZ+UZ38ZSWnFjGXlOT9DYbcd/r3f30d5OgWEbgOmxdGstcgW
 liTTKFS+7F/eYUWhfD6cwpuzm+YAJAL/isedxYFHU63wL+qT1ExBFeLW4J+ic2xYJz8o9aaeah1
 OSqfPeRT3a38i0tIS0ZIQYaqkR9Etq+doG16eoMSSyQ2TFn6kW68SdAB1zzTIg/QEqV9wEI74+W
 kc11kbMUdW3gNqRFj5XyywSwBkSa4sI04TaZsQWuJrbuCdxQZm8dTDtplbAXj/PZ1YRs+gkaVQH
 Z9lR/lzWH8lPiW8J/DBuhEv2ks8U78RKlbA==
X-Google-Smtp-Source: AGHT+IFieb+gm+rWJ0Oa45cj1KjcPCC4rl/ynxe9G4bgf3W7srLgMSyNw8FhmhZu6eY5HA4lnrH5tA==
X-Received: by 2002:a17:907:9729:b0:af9:8739:10ca with SMTP id
 a640c23a62f3a-b01083235f9mr1709209966b.28.1756973499527; 
 Thu, 04 Sep 2025 01:11:39 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b047011daa1sm275133966b.79.2025.09.04.01.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 01:11:37 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2163E5F93E;
 Thu, 04 Sep 2025 09:11:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Reinoud Zandijk <reinoud@netbsd.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 Fam Zheng <fam@euphon.net>, Helge Deller <deller@gmx.de>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-rust@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 qemu-riscv@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Riku Voipio <riku.voipio@iki.fi>, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Laurent Vivier <lvivier@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org, Stafford Horne <shorne@gmail.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, devel@lists.libvirt.org,
 Mads Ynddal <mads@ynddal.dk>, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Peter Xu <peterx@redhat.com>, Jason Herne <jjherne@linux.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 David Hildenbrand <david@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, kvm@vger.kernel.org,
 Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, John Levon <john.levon@nutanix.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v2 008/281] hw: add compat machines for 10.2
Date: Thu,  4 Sep 2025 09:06:42 +0100
Message-ID: <20250904081128.1942269-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250904081128.1942269-1-alex.bennee@linaro.org>
References: <20250904081128.1942269-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Add 10.2 machine types for arm/i440fx/m68k/q35/s390x/spapr.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250805095616.1168905-1-cohuck@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/boards.h        |  3 +++
 include/hw/i386/pc.h       |  3 +++
 hw/arm/virt.c              |  9 ++++++++-
 hw/core/machine.c          |  3 +++
 hw/i386/pc.c               |  3 +++
 hw/i386/pc_piix.c          | 13 +++++++++++--
 hw/i386/pc_q35.c           | 13 +++++++++++--
 hw/m68k/virt.c             |  9 ++++++++-
 hw/ppc/spapr.c             | 15 +++++++++++++--
 hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
 10 files changed, 76 insertions(+), 9 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index f94713e6e29..665b6201214 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -779,6 +779,9 @@ struct MachineState {
     } \
     type_init(machine_initfn##_register_types)
 
+extern GlobalProperty hw_compat_10_1[];
+extern const size_t hw_compat_10_1_len;
+
 extern GlobalProperty hw_compat_10_0[];
 extern const size_t hw_compat_10_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 79b72c54dd3..e83157ab358 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -214,6 +214,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_10_1[];
+extern const size_t pc_compat_10_1_len;
+
 extern GlobalProperty pc_compat_10_0[];
 extern const size_t pc_compat_10_0_len;
 
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ef6be3660f5..9326cfc895f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3455,10 +3455,17 @@ static void machvirt_machine_init(void)
 }
 type_init(machvirt_machine_init);
 
+static void virt_machine_10_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    virt_machine_10_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+DEFINE_VIRT_MACHINE(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bd47527479a..38c949c4f2c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -37,6 +37,9 @@
 #include "hw/virtio/virtio-iommu.h"
 #include "audio/audio.h"
 
+GlobalProperty hw_compat_10_1[] = {};
+const size_t hw_compat_10_1_len = G_N_ELEMENTS(hw_compat_10_1);
+
 GlobalProperty hw_compat_10_0[] = {
     { "scsi-hd", "dpofua", "off" },
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2f58e73d334..bc048a6d137 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,9 @@
     { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
     { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
+GlobalProperty pc_compat_10_1[] = {};
+const size_t pc_compat_10_1_len = G_N_ELEMENTS(pc_compat_10_1);
+
 GlobalProperty pc_compat_10_0[] = {
     { TYPE_X86_CPU, "x-consistent-cache", "false" },
     { TYPE_X86_CPU, "x-vendor-cpuid-only-v2", "false" },
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index c03324281bd..d165ac72ed7 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -504,12 +504,21 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_10_1_options(MachineClass *m)
+static void pc_i440fx_machine_10_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(10, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(10, 2);
+
+static void pc_i440fx_machine_10_1_options(MachineClass *m)
+{
+    pc_i440fx_machine_10_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
+}
+
+DEFINE_I440FX_MACHINE(10, 1);
 
 static void pc_i440fx_machine_10_0_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index b309b2b378d..e89951285e5 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -374,12 +374,21 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_10_1_options(MachineClass *m)
+static void pc_q35_machine_10_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(10, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(10, 2);
+
+static void pc_q35_machine_10_1_options(MachineClass *m)
+{
+    pc_q35_machine_10_2_options(m);
+    compat_props_add(m->compat_props, hw_compat_10_1, hw_compat_10_1_len);
+    compat_props_add(m->compat_props, pc_compat_10_1, pc_compat_10_1_len);
+}
+
+DEFINE_Q35_MACHINE(10, 1);
 
 static void pc_q35_machine_10_0_options(MachineClass *m)
 {
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c
index 875fd00ef8d..98cfe43c73a 100644
--- a/hw/m68k/virt.c
+++ b/hw/m68k/virt.c
@@ -367,10 +367,17 @@ type_init(virt_machine_register_types)
 #define DEFINE_VIRT_MACHINE(major, minor) \
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)
 
+static void virt_machine_10_2_options(MachineClass *mc)
+{
+}
+DEFINE_VIRT_MACHINE_AS_LATEST(10, 2)
+
 static void virt_machine_10_1_options(MachineClass *mc)
 {
+    virt_machine_10_2_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_VIRT_MACHINE_AS_LATEST(10, 1)
+DEFINE_VIRT_MACHINE(10, 1)
 
 static void virt_machine_10_0_options(MachineClass *mc)
 {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 1855a3cd8d0..eb22333404d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4761,15 +4761,26 @@ static void spapr_machine_latest_class_options(MachineClass *mc)
 #define DEFINE_SPAPR_MACHINE(major, minor) \
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)
 
+/*
+ * pseries-10.2
+ */
+static void spapr_machine_10_2_class_options(MachineClass *mc)
+{
+    /* Defaults for the latest behaviour inherited from the base class */
+}
+
+DEFINE_SPAPR_MACHINE_AS_LATEST(10, 2);
+
 /*
  * pseries-10.1
  */
 static void spapr_machine_10_1_class_options(MachineClass *mc)
 {
-    /* Defaults for the latest behaviour inherited from the base class */
+    spapr_machine_10_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
 
-DEFINE_SPAPR_MACHINE_AS_LATEST(10, 1);
+DEFINE_SPAPR_MACHINE(10, 1);
 
 /*
  * pseries-10.0
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a79bd13275b..d0c6e80cb05 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -911,14 +911,26 @@ static const TypeInfo ccw_machine_info = {
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)
 
 
+static void ccw_machine_10_2_instance_options(MachineState *machine)
+{
+}
+
+static void ccw_machine_10_2_class_options(MachineClass *mc)
+{
+}
+DEFINE_CCW_MACHINE_AS_LATEST(10, 2);
+
 static void ccw_machine_10_1_instance_options(MachineState *machine)
 {
+    ccw_machine_10_2_instance_options(machine);
 }
 
 static void ccw_machine_10_1_class_options(MachineClass *mc)
 {
+    ccw_machine_10_2_class_options(mc);
+    compat_props_add(mc->compat_props, hw_compat_10_1, hw_compat_10_1_len);
 }
-DEFINE_CCW_MACHINE_AS_LATEST(10, 1);
+DEFINE_CCW_MACHINE(10, 1);
 
 static void ccw_machine_10_0_instance_options(MachineState *machine)
 {
-- 
2.47.2


