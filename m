Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FB2CD128C
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rps6H-0001n7-NI; Thu, 28 Mar 2024 11:55:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps68-0001Xv-GX
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:26 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rps66-00024h-Fd
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:55:24 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-56c2c41cbdaso648823a12.2
 for <qemu-devel@nongnu.org>; Thu, 28 Mar 2024 08:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711641320; x=1712246120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qqj3zRF0zkE64TiaxdKa2OyadNVq3wsX7i8167PhhDk=;
 b=fpFpEreOmtqPkGN8wZCLxiaQDUL02smlviXnSG1rTHWvb/HCrx5b4grPSWcsNQXRpn
 tZdjG4EDK2g9P7UVasve5CEBL+ydTAaYLbQJgswM0+v+704FhNUSsxUeTXzY1V9n8RO4
 OdBb47UI2Z9f2gQ/8ZszJRdebX1G5UkLYocS2FZ405krHs45dpjkrPoiEkcLd7sjoWz+
 +cYNrApJhKkeoZGPZqWL93aMVqdkcX7YCEvMN9ber2fpA5HjCuiE7Uh8xJjpdinF3hZp
 1iZ8jIWQvwNkDOVULNMungitVCfgJypewuFUKiYNAoQrnpB3nd8kra7Z9s8nDAx9kIeU
 Xhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711641320; x=1712246120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qqj3zRF0zkE64TiaxdKa2OyadNVq3wsX7i8167PhhDk=;
 b=X5YK9aM/Fbb9wWMjwPA/gsTssU4ihRunn1alTYeUT3hwzAvddQT2FoHEz4njWCJ4PR
 k1tS22M47G0Mq43OjQZbPbJTQgmHE0DjN4tBsorZ9lqzPjGdC0OlJROSJRh7eei5r8Qc
 PBgl83bS4q+D59HYYcvZiEez2Dqvpd3PCAQbQC+vPs1DkL0qbH6DU/E4txkDEZj0Sapt
 WUdXdzHD+gk5mNpli2Z3Fd9MGBoDxfbtonhAAWfG+CbLRR5wsu1yf6i1c1QhVTcmQweg
 711TlzTujrjNgz4p0bPOpiw+GW4hRsZPFGHVdJv5UXkDeczwjnxlapqgeoNJmrziRPR2
 jtGw==
X-Gm-Message-State: AOJu0YxsvvRYtLCTu78+vui0a1fHaAudJejz9vVyXQoZ5bdw99Gb1Jth
 nl5/xyUAAhwpGCz7iuxVWQRmEcW2akuxXD1E+mHzsezXzlb3FDmMfQ6f+wuWXmuuNnTzMpkopfR
 +
X-Google-Smtp-Source: AGHT+IHK7QxU7AgeWAocSeLH4R3SrP+9YZVhIuiOSStSg8CKPyXF7V4Tf4M9BXjp5dsE6yThozBjEA==
X-Received: by 2002:a50:8d08:0:b0:566:ecce:9d3c with SMTP id
 s8-20020a508d08000000b00566ecce9d3cmr2991678eds.26.1711641320462; 
 Thu, 28 Mar 2024 08:55:20 -0700 (PDT)
Received: from m1x-phil.lan (pas38-h02-176-184-5-52.dsl.sta.abo.bbox.fr.
 [176.184.5.52]) by smtp.gmail.com with ESMTPSA id
 ef15-20020a05640228cf00b0056c1380a972sm963818edb.74.2024.03.28.08.55.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 28 Mar 2024 08:55:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Stabellini <sstabellini@kernel.org>,
 xen-devel@lists.xenproject.org, Bernhard Beschow <shentey@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH-for-9.1 06/29] hw/i386/pc: Move pci_root_uid field to
 PcPciMachineClass
Date: Thu, 28 Mar 2024 16:54:14 +0100
Message-ID: <20240328155439.58719-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240328155439.58719-1-philmd@linaro.org>
References: <20240328155439.58719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x530.google.com
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

The 'pci_root_uid' field is irrelevant for non-PCI
machines, restrict it to the PcPciMachineClass.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/i386/pc.h | 4 +++-
 hw/i386/acpi-build.c | 9 +++++++--
 hw/i386/pc_piix.c    | 7 +++++--
 hw/i386/pc_q35.c     | 7 +++++--
 4 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 0b23e5ec7b..24c8e17e62 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -96,7 +96,6 @@ typedef struct PCMachineClass {
 
     /* ACPI compat: */
     bool has_acpi_build;
-    int pci_root_uid;
 
     /* SMBIOS compat: */
     bool smbios_defaults;
@@ -127,6 +126,9 @@ typedef struct PCMachineClass {
 
 typedef struct PcPciMachineClass {
     PCMachineClass parent_class;
+
+    /* ACPI compat: */
+    int pci_root_uid;
 } PcPciMachineClass;
 
 #define TYPE_PC_MACHINE "common-pc-machine"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 6f9925d176..b9890886f6 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1426,6 +1426,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     CrsRangeSet crs_range_set;
     PCMachineState *pcms = PC_MACHINE(machine);
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
+    PcPciMachineClass *ppmc;
     X86MachineState *x86ms = X86_MACHINE(machine);
     AcpiMcfgInfo mcfg;
     bool mcfg_valid = !!acpi_get_mcfg(&mcfg);
@@ -1448,10 +1449,12 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
     build_dbg_aml(dsdt);
     if (i440fx) {
+        ppmc = PC_PCI_MACHINE_GET_CLASS(machine);
+
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(ppmc->pci_root_uid)));
         aml_append(dev, aml_pci_edsm());
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
@@ -1461,11 +1464,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
         build_piix4_pci0_int(dsdt);
     } else if (q35) {
+        ppmc = PC_PCI_MACHINE_GET_CLASS(machine);
+
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
         aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
         aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(ppmc->pci_root_uid)));
         aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
         aml_append(dev, aml_pci_edsm());
         aml_append(sb_scope, dev);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 776d02db73..c42dd46e59 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -468,9 +468,11 @@ static void pc_xen_hvm_init(MachineState *machine)
 static void pc_i440fx_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    PcPciMachineClass *ppmc = PC_PCI_MACHINE_CLASS(m);
     ObjectClass *oc = OBJECT_CLASS(m);
+
     pcmc->default_south_bridge = TYPE_PIIX3_DEVICE;
-    pcmc->pci_root_uid = 0;
+    ppmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
     m->family = "pc_piix";
@@ -622,12 +624,13 @@ DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2", NULL,
 static void pc_i440fx_5_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    PcPciMachineClass *ppmc = PC_PCI_MACHINE_CLASS(m);
 
     pc_i440fx_5_2_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
     compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
     pcmc->kvmclock_create_always = false;
-    pcmc->pci_root_uid = 1;
+    ppmc->pci_root_uid = 1;
 }
 
 DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index c3b0467ef3..dc0bf85464 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -345,7 +345,9 @@ static void pc_q35_init(MachineState *machine)
 static void pc_q35_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pcmc->pci_root_uid = 0;
+    PcPciMachineClass *ppmc = PC_PCI_MACHINE_CLASS(m);
+
+    ppmc->pci_root_uid = 0;
     pcmc->default_cpu_version = 1;
 
     m->family = "pc_q35";
@@ -495,12 +497,13 @@ DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
 static void pc_q35_5_1_machine_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
+    PcPciMachineClass *ppmc = PC_PCI_MACHINE_CLASS(m);
 
     pc_q35_5_2_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
     compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
     pcmc->kvmclock_create_always = false;
-    pcmc->pci_root_uid = 1;
+    ppmc->pci_root_uid = 1;
 }
 
 DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
-- 
2.41.0


