Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FB6CD5BBF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 May 2026 12:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQlnN-0007hD-UD; Sat, 23 May 2026 08:49:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdG4-0000Oy-Bb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:42:41 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wQdG2-0001X1-Gb
 for qemu-devel@nongnu.org; Fri, 22 May 2026 23:42:40 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a40cfab24dso3312852e87.2
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 20:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779507757; x=1780112557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRL+/V54GamePco94OeayJHfwlemtYbdo+DlCdU3QsM=;
 b=SYorEpKCjAGwsKHpQ3viFMePmr8T1ipwbAtnioPyeoENs3VKY5FMIRt5fm6uKt73/y
 niYUEUQZYMEfwf9wpdsstJsrEjxXJ0KkQN+2UFt6MVXFWY8kfh5p29qcHBwsxD/yOJqs
 5SZzfl8qon52DZx7RZzdMr6UWfgvxx0QDeZaBjNM+2KySuXzLjBgVFI0sBYM/PUTMaug
 YePcp2TLmWfNxZx1vPtMXYS7JRV5AT1GKUp/OhYRlJ5zuknEStYsRlSyWPvPk/erf4qD
 mPocjDuW6rmHkomC2hz80/QW2SAEntzW6ez/vnHkbsVKw+VVHNonB2LXv+74u/BfSG1Y
 VVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779507757; x=1780112557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dRL+/V54GamePco94OeayJHfwlemtYbdo+DlCdU3QsM=;
 b=csjENfHPN3A2i2FHvYBq2HwhjVIPt1sDhVQ1auHOIqJLtRr8QlMxe0K0CskiQFdpvO
 oUJb5xM2Q8KQO90GeJiDen3MGKoLrs8eIVfwo7fmDf7Vywc8tBpy0ViFL/+h+i3rQKjk
 T2iet//Xc7foc5PoACx9+W+5siE5feZ6ejSo027Fng9rs9lwPMg7q1JbiGmfmUqPyAZT
 L6DWqve9jyjumBlxCNR/5FItKb2iTei28cJNwQZT6rVOfi5yqowNYsMUlLg71A2kW4lU
 n5iUXapnwsVr0v9PQzOoFNummXVf9OXu7bbmXHSAhSYK5zZJFcHVC7enlczR4wekQmlu
 IWAw==
X-Gm-Message-State: AOJu0YzXMIi6/F6qe+xwf73Ax5Px2Z0N8A1u07mLEu09cv3BSmXSnADY
 zBsJ3bZ/b67Bp49haH2WmIIYfRoauv+vuBGYxnEImUBGFtBF0k+TLBLRrnV4WSPa3jg=
X-Gm-Gg: Acq92OEvggwUOy58mgUBueQ2JW/xtNWyGSey9i75Jj2Nl/hJsMKSGaQPtyj+G77XdBp
 IiFQ5SMQlSUyZylp5ligQXlmFtajqzTxflHDw+RoRl0P+Zs/LyetdtMzsYvzecL83b9WGGvaEMA
 25ESHd5QFyyPzeJ/SgcJFW3mIFj6b/p/LwxWp8vGm/bOaAVpkLzcruZcOen4rA6xplE7n1tQICa
 QxJHIf8XDI4DPjoyv+l9TsaLu2mhMnMUn6N2k61iGsQXRvm6PsGF7o1s+ZLxhvI2C1wFzRf5h1W
 mLOflYS5y4uNUEDPiTh+k2rXsKurlLBqjA9TsotZuvDRhsPbAzng+6UvK/pmCqL4plW49eW0ith
 r6Sd0F/sFUPG7wDq/JWRy0Brs0U7V/o5cV5qRPaEz3mv7AdWBvquU+SlNtvWYne+MzJR2DziknI
 Yh0NpaORZv0jxDzj41n6dBCNb4ZyWp4w==
X-Received: by 2002:a05:6512:3d11:b0:5a8:638f:cc9c with SMTP id
 2adb3069b0e04-5aa3237e691mr1786968e87.17.1779507756458; 
 Fri, 22 May 2026 20:42:36 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8080:c2d::1:2b])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa32cb36f6sm848685e87.4.2026.05.22.20.42.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 22 May 2026 20:42:36 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH 1/3] hw/i386/pc: Introduce 11.2 machine type for SMBIOS type 8
 base migration
Date: Sat, 23 May 2026 06:41:56 +0300
Message-Id: <20260523034158.57487-2-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260523034158.57487-1-xpahos@gmail.com>
References: <20260523034158.57487-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 23 May 2026 08:49:35 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

SMBIOS Type 8 (Port Connector) tables have been using T0_BASE (0x0) for
handle allocation, which can collide with handles assigned to other
SMBIOS types. Types 2, 3, 4, 9, and 11 already use dedicated ranges
(T2_BASE=0x200, T3_BASE=0x300, etc.).
Introduce pc-q35-11.2 and pc-i440fx-11.2 with smbios_type8_handle_t8_base
enabled, so Type 8 handles start at 0x800. The 11.1 machine types retain
T0_BASE for migration compatibility.
Other platforms (ARM, LoongArch, RISC-V) are not changed by this patch.

Signed-off-by: Alexander Gryanko <xpahos@gmail.com>
---
 hw/core/machine.c        |  3 +++
 hw/i386/pc.c             |  3 +++
 hw/i386/pc_piix.c        | 16 ++++++++++++++--
 hw/i386/pc_q35.c         | 16 ++++++++++++++--
 include/hw/core/boards.h |  3 +++
 include/hw/i386/pc.h     |  4 ++++
 6 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 63baff859f..96de2d20f0 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -39,6 +39,9 @@
 #include "hw/acpi/generic_event_device.h"
 #include "qemu/audio.h"
 
+GlobalProperty hw_compat_11_1[] = {};
+const size_t hw_compat_11_1_len = G_N_ELEMENTS(hw_compat_11_1);
+
 GlobalProperty hw_compat_11_0[] = {
     { "chardev-vc", "encoding", "cp437" },
 };
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503..17ad8b6489 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -73,6 +73,9 @@
 #include "hw/xen/xen-bus.h"
 #endif
 
+GlobalProperty pc_compat_11_1[] = {};
+const size_t pc_compat_11_1_len = G_N_ELEMENTS(pc_compat_11_1);
+
 GlobalProperty pc_compat_11_0[] = {};
 const size_t pc_compat_11_0_len = G_N_ELEMENTS(pc_compat_11_0);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 82457bdb16..27e1d552f6 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -406,6 +406,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->smbios_type8_handle_t8_base = true;
 
     m->family = "pc_piix";
     m->desc = "Standard PC (i440FX + PIIX, 1996)";
@@ -428,12 +429,23 @@ static void pc_i440fx_machine_options(MachineClass *m)
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len);
 }
 
-static void pc_i440fx_machine_11_1_options(MachineClass *m)
+static void pc_i440fx_machine_11_2_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
 }
 
-DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 2);
+
+static void pc_i440fx_machine_11_1_options(MachineClass *m)
+{
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    pc_i440fx_machine_11_2_options(m);
+    pcmc->smbios_type8_handle_t8_base = false;
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_I440FX_MACHINE(11, 1);
 
 static void pc_i440fx_machine_11_0_options(MachineClass *m)
 {
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index d8fed698c7..cf1ae9b78b 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -345,6 +345,7 @@ static void pc_q35_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pcmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
+    pcmc->smbios_type8_handle_t8_base = true;
 
     m->family = "pc_q35";
     m->desc = "Standard PC (Q35 + ICH9, 2009)";
@@ -365,12 +366,23 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_machine_11_1_options(MachineClass *m)
+static void pc_q35_machine_11_2_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
 }
 
-DEFINE_Q35_MACHINE_AS_LATEST(11, 1);
+DEFINE_Q35_MACHINE_AS_LATEST(11, 2);
+
+static void pc_q35_machine_11_1_options(MachineClass *m)
+{
+    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    pc_q35_machine_11_2_options(m);
+    pcmc->smbios_type8_handle_t8_base = false;
+    compat_props_add(m->compat_props, hw_compat_11_1, hw_compat_11_1_len);
+    compat_props_add(m->compat_props, pc_compat_11_1, pc_compat_11_1_len);
+}
+
+DEFINE_Q35_MACHINE(11, 1);
 
 static void pc_q35_machine_11_0_options(MachineClass *m)
 {
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 29c68931d8..a436d48c8e 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -815,6 +815,9 @@ compat_props_add(GPtrArray *arr,
     }
 }
 
+extern GlobalProperty hw_compat_11_1[];
+extern const size_t hw_compat_11_1_len;
+
 extern GlobalProperty hw_compat_11_0[];
 extern const size_t hw_compat_11_0_len;
 
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 85a74363b5..b7d21fb96e 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -102,6 +102,7 @@ struct PCMachineClass {
     /* SMBIOS compat: */
     bool smbios_defaults;
     bool smbios_legacy_mode;
+    bool smbios_type8_handle_t8_base;
     SmbiosEntryPointType default_smbios_ep_type;
 
     /* RAM / address space compat: */
@@ -208,6 +209,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, size_t flash_size);
 /* sgx.c */
 void pc_machine_init_sgx_epc(PCMachineState *pcms);
 
+extern GlobalProperty pc_compat_11_1[];
+extern const size_t pc_compat_11_1_len;
+
 extern GlobalProperty pc_compat_11_0[];
 extern const size_t pc_compat_11_0_len;
 
-- 
2.39.5 (Apple Git-154)


