Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02227C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV41-0002GR-A4; Tue, 05 Mar 2024 08:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV3z-0002GG-LN
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:35 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV3x-0003wf-Nx
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:42:35 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-563cb3ba9daso7116142a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646152; x=1710250952; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMNfTRI2EEqDMvR5k42GTJ+bmKNe3TP93rxFG8a8RHU=;
 b=HcvLfv4h61iil8IVPcuoBVWXXI4zftOw87dr5pactiElGnVGPoeZAYiyvsx8o9tKvH
 zBXUOz7cAF6qUP+VdUHtKpYJXgqmaOwtXFjDYQwTSfwiYqbP6ueRGZj+J6a4jqPPtG/Z
 q6icE8MTjjKEzI4QB/BVUP/JzMFmj8h90wIWQrPIm6l7s9IhJ6QN8zA9Y23ZRjKuGHM/
 clhHeSCpG0mSMLHpOKvwXYEipSEbWslrMF6E21TcMEjYJB9B6VfTXL8eKMDPuezHeOdR
 TRYUsggg/SIIt/vCEuCU12E70sVGSqh3++dPd+XKL+MDHGgmwqhohU1D606eqIYEDSPG
 3ndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646152; x=1710250952;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OMNfTRI2EEqDMvR5k42GTJ+bmKNe3TP93rxFG8a8RHU=;
 b=YbCQRouUtRUDyh9H6DlsNRVTM5zCJJN5fjcmtOyHRKy5R1j2KpEc0an1sR9ONqjB+C
 1MuUr1sNwjQxARjHOuz9ka1QqX+O4E6lhRJ60QV0hgthh/qD4Wk/3xqyJk6rab7nlNB8
 ZHAvMPbreNKMwisgIS7jMfDxYC0VUPb7ZMnDwMywrUc3fEgOoUwXOBdxBGdvk6OAam8n
 xhkDQLUUzJ+XtaxqoG9e1jjz0EwE4vf8IUV/9FjlI+9p2VeOJmc7rs2uXFVwgT4/E9GT
 HTxm9hYECbILPb2QVxhE20WSo28OGpGKM7q5yZN9VtDR4qhRCT9MmAixcLyj/DyuCaNe
 xDjQ==
X-Gm-Message-State: AOJu0Yw6qAJDss8gCO8e2UqtiSulUxZq3Skw/zY3ng3ivyZ/lsj7Heod
 ulfOEhwXF2hf5c7K4h2P3/juz8k44StuMIdP7htzDt9YyMyhvunB35yzTQcmOpGU4DZDpMv+ixE
 h
X-Google-Smtp-Source: AGHT+IG1q9HaAJ/qhvQerM8geumyfDRonf6wnB9tKhRLsDqaklXBgRR2dzeyq17BLhnoyQtqTJ+6sw==
X-Received: by 2002:a05:6402:5189:b0:567:26dd:d403 with SMTP id
 q9-20020a056402518900b0056726ddd403mr6223181edd.17.1709646152145; 
 Tue, 05 Mar 2024 05:42:32 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 i1-20020a0564020f0100b00567afe29709sm215237eda.78.2024.03.05.05.42.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:42:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Thomas Huth <thuth@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, devel@lists.libvirt.org,
 David Hildenbrand <david@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH-for-9.1 01/18] hw/i386/pc: Remove deprecated pc-i440fx-2.0
 machine
Date: Tue,  5 Mar 2024 14:42:03 +0100
Message-ID: <20240305134221.30924-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

The pc-i440fx-2.0 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    | 15 -------------
 hw/i386/pc_piix.c               | 37 ---------------------------------
 5 files changed, 2 insertions(+), 57 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 8565644da6..6d4738ca20 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -221,7 +221,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.0`` up to ``pc-i440fx-2.3`` (since 8.2)
+``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 417a0e4fa1..156737989e 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -801,7 +801,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-1.7`` (removed in 4.0 up to 8.2)
+``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b958023187..3360ca2307 100644
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
index f5ff970acf..bb7ef31af2 100644
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
index fa5f93f99f..594b131625 100644
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
@@ -868,38 +863,6 @@ static void pc_i440fx_2_1_machine_options(MachineClass *m)
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


