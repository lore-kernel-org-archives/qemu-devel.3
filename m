Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D97C05023
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 19:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwo2z-00014U-Dd; Tue, 16 Apr 2024 15:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2D-0000pS-N8
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:01 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rwo2A-0005Lv-Fn
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 15:00:01 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a46ea03c2a5so12079566b.1
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713293997; x=1713898797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1V0kAA/eWhoS7zcrOVou3w7pilpSrG0y1cYXN1Lr2Pg=;
 b=s2fFESgvWxTMisur7RCsHW6Z8c0evl7N7e/ygquF8ikAU53I0YV+byEf/UVrLwzfX/
 Ht94Fah2cJuxgZVoiSRVQfVePY/z4NyKAQy1CzuujNPh+Eh0bwSJ2rGDUe1xKzZjwAr7
 tpXg/IfG+gE6oHsuLy96KnB/5VgScshKTzopnHWO4DWmE9kxcsivHdiscGZpIjznpfA0
 qYOTDS4dJ4swZonJLOQzSQb4w6eFMQDH/v5RiKWip6HPviEvcEPXP52O0XVPcdg6D96e
 lQyI1rcI2MV7slN5hPU+s79/r2YahUY6Cym+iRRkON1SCxsC6FEsV6BqOgMdmFKVNSdr
 3+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713293997; x=1713898797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1V0kAA/eWhoS7zcrOVou3w7pilpSrG0y1cYXN1Lr2Pg=;
 b=QmhBFxM51r5678/Ah8kDaq2ks7hMfAjFYDgevcNYpzX7T3QBIaip+Clyp03MhSUS6W
 Hj5j2qWo4v7jOIB7ZjCkfSjipsQVFIBkFqNWfg6QSffqcUYlsKt5s4iGL81Rb9LH2LLG
 ZapL6B1QvLRJkuJmQU5R4av+DLEkDIz0laUM4FYviSygamK3ELx/On+ii6xU570CtHlq
 2dtePIzGDiqVtVjNdN491fmJoYVxro/R0Y7WUkrNXAHs/h/uSkzv0e3nmEkEOnWaFRvy
 e1Gj55WQd2jrzsrZRjpbvMPz8ndICWUikvBdbazuZnw1Mc26FNYZtwVzsJRHSsGAcebs
 gEdQ==
X-Gm-Message-State: AOJu0YwEU3Io8+8U0miunk+Xjj2bcHqL8Fns2klccOjhD4lTW03LWmTy
 DkvJj2WyPI2XWPchU/TYnSulN9w2lxIudKBk8pYCz2AZHVxh5Qo4x6xRdjwxabXrinK/O2h4e/e
 F
X-Google-Smtp-Source: AGHT+IHlrz7w1jeNA/Qttm4+X6hFJQqGDdbM0y2U1/FZjg7zMV3JYiO/NIWax6hq1GaxHfHR3Y3EwA==
X-Received: by 2002:a17:907:6d1a:b0:a51:f823:f4b4 with SMTP id
 sa26-20020a1709076d1a00b00a51f823f4b4mr3051283ejc.17.1713293996667; 
 Tue, 16 Apr 2024 11:59:56 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.61])
 by smtp.gmail.com with ESMTPSA id
 qb11-20020a1709077e8b00b00a51ab065bf0sm7129332ejc.202.2024.04.16.11.59.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Apr 2024 11:59:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v4 02/22] hw/i386/pc: Remove deprecated pc-i440fx-2.0 machine
Date: Tue, 16 Apr 2024 20:59:18 +0200
Message-ID: <20240416185939.37984-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240416185939.37984-1-philmd@linaro.org>
References: <20240416185939.37984-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
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

The pc-i440fx-2.0 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    | 15 -------------
 hw/i386/pc_piix.c               | 37 ---------------------------------
 5 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 47234da329..b09ae3d55d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -219,7 +219,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
+``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2) and ``pc-i440fx-2.4`` up to ``pc-i440fx-2.12`` (since 9.1)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index f9cf874f7b..51119e623f 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -816,7 +816,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
+``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 27a68071d7..67856f54c3 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -285,9 +285,6 @@ extern const size_t pc_compat_2_2_len;
 extern GlobalProperty pc_compat_2_1[];
 extern const size_t pc_compat_2_1_len;
 
-extern GlobalProperty pc_compat_2_0[];
-extern const size_t pc_compat_2_0_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5c21b0c4db..172814f604 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -311,21 +311,6 @@ GlobalProperty pc_compat_2_1[] = {
 };
 const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
 
-GlobalProperty pc_compat_2_0[] = {
-    PC_CPU_MODEL_IDS("2.0.0")
-    { "virtio-scsi-pci", "any_layout", "off" },
-    { "PIIX4_PM", "memory-hotplug-support", "off" },
-    { "apic", "version", "0x11" },
-    { "nec-usb-xhci", "superspeed-ports-first", "off" },
-    { "nec-usb-xhci", "force-pcie-endcap", "on" },
-    { "pci-serial", "prog_if", "0" },
-    { "pci-serial-2x", "prog_if", "0" },
-    { "pci-serial-4x", "prog_if", "0" },
-    { "virtio-net-pci", "guest_announce", "off" },
-    { "ICH9-LPC", "memory-hotplug-support", "off" },
-};
-const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 817d99c0ce..9e1bca7b17 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -441,11 +441,6 @@ static void pc_compat_2_1_fn(MachineState *machine)
     x86_cpu_change_kvm_default("svm", NULL);
 }
 
-static void pc_compat_2_0_fn(MachineState *machine)
-{
-    pc_compat_2_1_fn(machine);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -872,38 +867,6 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
                       pc_i440fx_2_1_machine_options);
 
-static void pc_i440fx_2_0_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_1_machine_options(m);
-    m->hw_version = "2.0.0";
-    compat_props_add(m->compat_props, pc_compat_2_0, pc_compat_2_0_len);
-    pcmc->smbios_legacy_mode = true;
-    pcmc->has_reserved_memory = false;
-    /* This value depends on the actual DSDT and SSDT compiled into
-     * the source QEMU; unfortunately it depends on the binary and
-     * not on the machine type, so we cannot make pc-i440fx-1.7 work on
-     * both QEMU 1.7 and QEMU 2.0.
-     *
-     * Large variations cause migration to fail for more than one
-     * consecutive value of the "-smp" maxcpus option.
-     *
-     * For small variations of the kind caused by different iasl versions,
-     * the 4k rounding usually leaves slack.  However, there could be still
-     * one or two values that break.  For QEMU 1.7 and QEMU 2.0 the
-     * slack is only ~10 bytes before one "-smp maxcpus" value breaks!
-     *
-     * 6652 is valid for QEMU 2.0, the right value for pc-i440fx-1.7 on
-     * QEMU 1.7 it is 6414.  For RHEL/CentOS 7.0 it is 6418.
-     */
-    pcmc->legacy_acpi_table_size = 6652;
-    pcmc->acpi_data_size = 0x10000;
-}
-
-DEFINE_I440FX_MACHINE(v2_0, "pc-i440fx-2.0", pc_compat_2_0_fn,
-                      pc_i440fx_2_0_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


