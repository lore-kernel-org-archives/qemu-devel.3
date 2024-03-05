Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD3DC54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 13:43:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhV4k-00030f-3Z; Tue, 05 Mar 2024 08:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4Z-0002tS-E4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:13 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rhV4W-0003z4-H4
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:43:10 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5658082d2c4so7796380a12.1
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709646186; x=1710250986; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qNCIUOXAP5nkn1WP2t/PEPvMd4mRhcnbtnDDAPAoHAk=;
 b=vzdIlLVG4/Gb0VCRkVcAgnnMFrRnIbBtoiiPAR2hblHECG8jPVF5KDAX79vAJrWcd5
 HB9jvoFmcxFapPUetdHLB+05RqeZAYd3rSTkc0tZxrhjdq5gAGcyMMl+Vt984Is47x56
 curpDXnCSwW9GNMMYxTGj4OL9qc3vsU5Or0eVIedHSBl8wZcA7G7HO2nJbR0G1xJ6Z61
 FN/SDngg645+mi3+4+KZbTnrXlJeffGGwGtXjvqgqgGUbsGApSkHTLcH9badmsdiiG7j
 j4y1D2p6Y9Q5QtyWPUBkAwYCVqmjnNRKvIkeLWflcPqhoQ3KJTInIBkuJZy9DsEAj2g4
 comg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709646186; x=1710250986;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qNCIUOXAP5nkn1WP2t/PEPvMd4mRhcnbtnDDAPAoHAk=;
 b=T+JkrDd21Wjr3ULXDaYrD0Jn0r2wr9BRQKFYzs2rpc9WbR/LIDYTWl0j1hgYpjZgcm
 0Pha/YvrH8LVkCCSox19ACWQPUIKad8JibBjARCltGyLFQnL8sDrwYy00q+86FGFZpUS
 bjL2FqghNl6F21hlwEDENNyAOk/5RVIRF5zM8g0U9tBvdSXJ0FRQJvAWzSkhePloVeD/
 gnPWo4WhXoyg7AJbdUYrNk3JuXj9vC/5zto1WzJNiqrUAQ5t3VuyXUN9DogVbeQq2hZj
 LsGqMWn3vEEsJzJOJPQimvBk1DtK6bGbXfz7wRMxGCURcjXSF0Uf+0Ux2gaGj86KQw7Q
 pacQ==
X-Gm-Message-State: AOJu0Yyq2LV7AG+dE+Smbp59CBvEvQRoTmUSH9nPgmqhIgDcvq/w+560
 YVuwswtKHIXCnHDI8n+lADLk0rfdGNFiLNFbsfhMJFJcvsoBvDGFCc2I21RQU+/i4wEAo61bh64
 p
X-Google-Smtp-Source: AGHT+IFf8ZGZhDfjYAXFDPsxT7EZZWXpGFpXOeFd4BwtvveykEU8Vst9MseHS8RugHUgHLPbLYodgA==
X-Received: by 2002:a17:906:270d:b0:a45:ab75:7628 with SMTP id
 z13-20020a170906270d00b00a45ab757628mr1214935ejc.52.1709646186033; 
 Tue, 05 Mar 2024 05:43:06 -0800 (PST)
Received: from m1x-phil.lan ([176.176.177.70])
 by smtp.gmail.com with ESMTPSA id
 lh24-20020a170906f8d800b00a45b1ce5046sm946ejb.155.2024.03.05.05.43.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Mar 2024 05:43:05 -0800 (PST)
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
Subject: [PATCH-for-9.1 06/18] hw/i386/pc: Remove deprecated pc-i440fx-2.1
 machine
Date: Tue,  5 Mar 2024 14:42:08 +0100
Message-ID: <20240305134221.30924-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305134221.30924-1-philmd@linaro.org>
References: <20240305134221.30924-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x536.google.com
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

The pc-i440fx-2.1 machine was deprecated for the 8.2
release (see commit c7437f0ddb "docs/about: Mark the
old pc-i440fx-2.0 - 2.3 machine types as deprecated"),
time to remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/about/deprecated.rst       |  2 +-
 docs/about/removed-features.rst |  2 +-
 include/hw/i386/pc.h            |  3 ---
 hw/i386/pc.c                    |  7 -------
 hw/i386/pc_piix.c               | 23 -----------------------
 5 files changed, 2 insertions(+), 35 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 6d4738ca20..c68b17df23 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -221,7 +221,7 @@ deprecated; use the new name ``dtb-randomness`` instead. The new name
 better reflects the way this property affects all random data within
 the device tree blob, not just the ``kaslr-seed`` node.
 
-``pc-i440fx-2.1`` up to ``pc-i440fx-2.3`` (since 8.2)
+``pc-i440fx-2.2`` up to ``pc-i440fx-2.3`` (since 8.2)
 '''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These old machine types are quite neglected nowadays and thus might have
diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
index 156737989e..d01b0afbef 100644
--- a/docs/about/removed-features.rst
+++ b/docs/about/removed-features.rst
@@ -801,7 +801,7 @@ mips ``fulong2e`` machine alias (removed in 6.0)
 
 This machine has been renamed ``fuloong2e``.
 
-``pc-0.10`` up to ``pc-i440fx-2.0`` (removed in 4.0 up to 9.0)
+``pc-0.10`` up to ``pc-i440fx-2.1`` (removed in 4.0 up to 9.0)
 ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
 
 These machine types were very old and likely could not be used for live
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 758d670a36..f77639d94f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -281,9 +281,6 @@ extern const size_t pc_compat_2_3_len;
 extern GlobalProperty pc_compat_2_2[];
 extern const size_t pc_compat_2_2_len;
 
-extern GlobalProperty pc_compat_2_1[];
-extern const size_t pc_compat_2_1_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index bb7ef31af2..d417cf106c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -304,13 +304,6 @@ GlobalProperty pc_compat_2_2[] = {
 };
 const size_t pc_compat_2_2_len = G_N_ELEMENTS(pc_compat_2_2);
 
-GlobalProperty pc_compat_2_1[] = {
-    PC_CPU_MODEL_IDS("2.1.0")
-    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
-    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
-};
-const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
-
 GSIState *pc_gsi_create(qemu_irq **irqs, bool pci_enabled)
 {
     GSIState *s;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 594b131625..88457de0f8 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -65,7 +65,6 @@
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/i386/acpi-build.h"
-#include "kvm/kvm-cpu.h"
 #include "target/i386/cpu.h"
 
 #define XEN_IOAPIC_NUM_PIRQS 128ULL
@@ -435,12 +434,6 @@ static void pc_compat_2_2_fn(MachineState *machine)
     pc_compat_2_3_fn(machine);
 }
 
-static void pc_compat_2_1_fn(MachineState *machine)
-{
-    pc_compat_2_2_fn(machine);
-    x86_cpu_change_kvm_default("svm", NULL);
-}
-
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
@@ -847,22 +840,6 @@ static void pc_i440fx_2_2_machine_options(MachineClass *m)
 DEFINE_I440FX_MACHINE(v2_2, "pc-i440fx-2.2", pc_compat_2_2_fn,
                       pc_i440fx_2_2_machine_options);
 
-static void pc_i440fx_2_1_machine_options(MachineClass *m)
-{
-    PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-
-    pc_i440fx_2_2_machine_options(m);
-    m->hw_version = "2.1.0";
-    m->default_display = NULL;
-    compat_props_add(m->compat_props, hw_compat_2_1, hw_compat_2_1_len);
-    compat_props_add(m->compat_props, pc_compat_2_1, pc_compat_2_1_len);
-    pcmc->smbios_uuid_encoded = false;
-    pcmc->enforce_aligned_dimm = false;
-}
-
-DEFINE_I440FX_MACHINE(v2_1, "pc-i440fx-2.1", pc_compat_2_1_fn,
-                      pc_i440fx_2_1_machine_options);
-
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
 {
-- 
2.41.0


