Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC6FCD98E7
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUKG-00054U-Qj; Tue, 16 Jun 2026 09:59:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKE-000531-Qz
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:34 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xpahos@gmail.com>) id 1wZUKD-0007Ke-0J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 09:59:34 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5aa66893e9fso5982198e87.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 06:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781618371; x=1782223171; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dRL+/V54GamePco94OeayJHfwlemtYbdo+DlCdU3QsM=;
 b=efcVDW0jOasi/GJEmvQ/LErz7/yVeaInVPq9kj7HXXajXMwSeytGeBay8o43n8RT3+
 PZBHuvAXOz/SNN3S06OKi1XDSFiWUFL2okMXPDenblUZo5uGCimqMx5pACCeFLe5U0/j
 BkV+G9ecIg0Z2vgMMsaGxrmsfBWQvKyteXzx9ef1i2XCf/8Gvc8zBD5LfQy9gDUxIPhc
 wQSlqZZNJjLukDnFSNwnRar8r4IK/NNaRk5zoWt4A1YYhlCatjhI5be03BBgQbkCWDR2
 TXPeB1TXadfGPq7/j2RpKTdCP9EkklwWd0Lks2vXp+drpLoNm8OIJ0eCpMzKu4aWkio7
 pUxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781618371; x=1782223171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dRL+/V54GamePco94OeayJHfwlemtYbdo+DlCdU3QsM=;
 b=qvapKK3fzRl7a6fsKZPTnUYxsWQZRjbDcaclxPuFYGY91QAPkKehQI+POBEatdjURF
 MTswFjN3jNNKsC54i87SMPEXOXz8U7UW15UZoO7I9lPHRx02FWWd2a6zlaA9ZbfUMuE2
 Y7wASzmWCbpOwK3kS+ZXvwa4sy7GEeu8fV5biOegdCorfTHGvHrstXkuYady8tsFl4sd
 eLgHEMk3jvj+0t4pvIAOvD7lernqjgeAPSBrzYF/IhvTgELhR/f5BW/T+/pn5ou8H0cP
 OavHtI/WiF+ihE6rgIuiPD8NLQ5CKlx90/k1x0wbHBSXBRlkY8KnWgBRDRbRCbSfxWIS
 QdVA==
X-Gm-Message-State: AOJu0YziDHF/qyG7rBic2v0vUuSbcy+ueoapsK+cVAtm0sAubW33aWwt
 +52jiur87PTTrieERPzVpuZ/gOa06GjuER7ph49XhVvmQxqlaRqUy9etw84cgrcfX9I=
X-Gm-Gg: Acq92OHF6gRhMOvhLn+FU9BgVTAzteWyPMnYDoSXS4S2lYDUj/64K5072f9OkI5H/S1
 smUy+r8NDYPyj5H6seq/ZLoBty465W/FzmxuX2KqE2i3VdLm2+zeaytH67YjnXfdlKZa/It6mTT
 hjSyTKkOX2w5lXs2DHDyiTMWvJZoBa6VDK+s3eHi4eKyl5cZK2DwyHNdXqWd87k6CSPgaExkQB1
 zw74PZM9TPFUj9H+MK2lG+yDJ9q4zcSs5QErnThgro0dacSlv/DagzdW9guRkxXUhnTxfgFEiQZ
 JOSu5QPKW/p8hdvSS6HDE5fy5yHNSqGZylh732LbQ5zI5g6qeLm+hnNp3MWIxbkH0TN/Z2bGEhb
 2ZwVGRW+i57/Ah61B0PqtRO5wDQVRyQ50AGwt8eM7pSYTamhYvrpEzCduDWnQ5BEs5m/Jbn3vIW
 4NYuh0yRZqBjrIGiO4mAc9suf7/GEsMZiKZKXWXHSnrbLAvANpIxXZxxmltog=
X-Received: by 2002:ac2:57c3:0:b0:5aa:8823:aeba with SMTP id
 2adb3069b0e04-5ad4376a746mr996661e87.47.1781618370863; 
 Tue, 16 Jun 2026 06:59:30 -0700 (PDT)
Received: from xpahos-osx.yandex.net ([2a02:6bf:8011:f00:689d:b3a0:c7eb:5526])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ad2e161f1esm3634677e87.2.2026.06.16.06.59.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 06:59:30 -0700 (PDT)
From: Alexander Gryanko <xpahos@gmail.com>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, mst@redhat.com, philmd@linaro.org,
 anisinha@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 zhao1.liu@intel.com, Alexander Gryanko <xpahos@gmail.com>
Subject: [PATCH v2 1/3] hw/i386/pc: Introduce 11.2 machine type for SMBIOS
 type 8 base migration
Date: Tue, 16 Jun 2026 16:59:02 +0300
Message-Id: <20260616135904.44930-2-xpahos@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260616135904.44930-1-xpahos@gmail.com>
References: <20260616135904.44930-1-xpahos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=xpahos@gmail.com; helo=mail-lf1-x132.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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


