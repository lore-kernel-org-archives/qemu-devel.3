Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3707C2BA1A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 16:59:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKL7h-0006I1-AN; Thu, 20 Jun 2024 12:58:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7f-0006H0-Rc
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sKL7d-000114-Eg
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 12:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718902732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RdajJxPxsGIaHqW/QhgcGhN3ZoJdHh/ppbDzKcn5hKU=;
 b=V5KFUxw89q61hThf3NvbhSm3vb3mEPnocVYDWa57LvEvdZkla7+9yBk5IkCV/EPkx9rlLW
 gPX3M+thxCJNRpNh/0zr8dMEa4PNMENRTDN5orC4DyTNl9+GMhNi+PyN9OFwAPlMdoty3k
 RmsYypB7J0E0BhE1EzfhGJAWnYDMCWU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-ujMvmrkwOBGPcn6XEXc6FA-1; Thu,
 20 Jun 2024 12:58:49 -0400
X-MC-Unique: ujMvmrkwOBGPcn6XEXc6FA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5EAA41956094; Thu, 20 Jun 2024 16:58:46 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.69])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9595F19560AF; Thu, 20 Jun 2024 16:58:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 06/14] hw/i386: convert 'i440fx' machine definitions to use
 new macros
Date: Thu, 20 Jun 2024 17:57:34 +0100
Message-ID: <20240620165742.1711389-7-berrange@redhat.com>
In-Reply-To: <20240620165742.1711389-1-berrange@redhat.com>
References: <20240620165742.1711389-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This changes the DEFINE_I440FX_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number thrice in three different formats in the calls
to DEFINE_I440FX_MACHINE.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_piix.c    | 219 +++++++++++++++++++------------------------
 include/hw/i386/pc.h |  26 +++++
 2 files changed, 122 insertions(+), 123 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e4930b7f48..5705d6e155 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -445,12 +445,13 @@ static void pc_xen_hvm_init(MachineState *machine)
 }
 #endif
 
-#define DEFINE_I440FX_MACHINE(suffix, name, optionfn) \
-    static void pc_init_##suffix(MachineState *machine) \
-    { \
-        pc_init1(machine, TYPE_I440FX_PCI_DEVICE); \
-    } \
-    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
+static void pc_i440fx_init(MachineState *machine)
+{
+    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
+}
+
+#define DEFINE_I440FX_MACHINE(major, minor) \
+    DEFINE_PC_VER_MACHINE(pc_i440fx, "pc-i440fx", pc_i440fx_init, major, minor);
 
 static void pc_i440fx_machine_options(MachineClass *m)
 {
@@ -478,21 +479,20 @@ static void pc_i440fx_machine_options(MachineClass *m)
                                      "Use a different south bridge than PIIX3");
 }
 
-static void pc_i440fx_9_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_9_1_options(MachineClass *m)
 {
     pc_i440fx_machine_options(m);
     m->alias = "pc";
     m->is_default = true;
 }
 
-DEFINE_I440FX_MACHINE(v9_1, "pc-i440fx-9.1",
-                      pc_i440fx_9_1_machine_options);
+DEFINE_I440FX_MACHINE(9, 1);
 
-static void pc_i440fx_9_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_9_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_9_1_machine_options(m);
+    pc_i440fx_machine_9_1_options(m);
     m->alias = NULL;
     m->is_default = false;
 
@@ -501,14 +501,13 @@ static void pc_i440fx_9_0_machine_options(MachineClass *m)
     pcmc->isa_bios_alias = false;
 }
 
-DEFINE_I440FX_MACHINE(v9_0, "pc-i440fx-9.0",
-                      pc_i440fx_9_0_machine_options);
+DEFINE_I440FX_MACHINE(9, 0);
 
-static void pc_i440fx_8_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_2_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_9_0_machine_options(m);
+    pc_i440fx_machine_9_0_options(m);
 
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
@@ -516,28 +515,26 @@ static void pc_i440fx_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_I440FX_MACHINE(v8_2, "pc-i440fx-8.2",
-                      pc_i440fx_8_2_machine_options);
+DEFINE_I440FX_MACHINE(8, 2);
 
-static void pc_i440fx_8_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_8_2_machine_options(m);
+    pc_i440fx_machine_8_2_options(m);
     pcmc->broken_32bit_mem_addr_check = true;
 
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v8_1, "pc-i440fx-8.1",
-                      pc_i440fx_8_1_machine_options);
+DEFINE_I440FX_MACHINE(8, 1);
 
-static void pc_i440fx_8_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_8_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_8_1_machine_options(m);
+    pc_i440fx_machine_8_1_options(m);
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
 
@@ -545,268 +542,244 @@ static void pc_i440fx_8_0_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
 }
 
-DEFINE_I440FX_MACHINE(v8_0, "pc-i440fx-8.0",
-                      pc_i440fx_8_0_machine_options);
+DEFINE_I440FX_MACHINE(8, 0);
 
-static void pc_i440fx_7_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_2_options(MachineClass *m)
 {
-    pc_i440fx_8_0_machine_options(m);
+    pc_i440fx_machine_8_0_options(m);
     compat_props_add(m->compat_props, hw_compat_7_2, hw_compat_7_2_len);
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_2, "pc-i440fx-7.2",
-                      pc_i440fx_7_2_machine_options);
+DEFINE_I440FX_MACHINE(7, 2)
 
-static void pc_i440fx_7_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_1_options(MachineClass *m)
 {
-    pc_i440fx_7_2_machine_options(m);
+    pc_i440fx_machine_7_2_options(m);
     compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_1, "pc-i440fx-7.1",
-                      pc_i440fx_7_1_machine_options);
+DEFINE_I440FX_MACHINE(7, 1);
 
-static void pc_i440fx_7_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_7_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_i440fx_7_1_machine_options(m);
+    pc_i440fx_machine_7_1_options(m);
     pcmc->enforce_amd_1tb_hole = false;
     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v7_0, "pc-i440fx-7.0",
-                      pc_i440fx_7_0_machine_options);
+DEFINE_I440FX_MACHINE(7, 0);
 
-static void pc_i440fx_6_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_2_options(MachineClass *m)
 {
-    pc_i440fx_7_0_machine_options(m);
+    pc_i440fx_machine_7_0_options(m);
     compat_props_add(m->compat_props, hw_compat_6_2, hw_compat_6_2_len);
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_2, "pc-i440fx-6.2",
-                      pc_i440fx_6_2_machine_options);
+DEFINE_I440FX_MACHINE(6, 2);
 
-static void pc_i440fx_6_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_1_options(MachineClass *m)
 {
-    pc_i440fx_6_2_machine_options(m);
+    pc_i440fx_machine_6_2_options(m);
     compat_props_add(m->compat_props, hw_compat_6_1, hw_compat_6_1_len);
     compat_props_add(m->compat_props, pc_compat_6_1, pc_compat_6_1_len);
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_I440FX_MACHINE(v6_1, "pc-i440fx-6.1",
-                      pc_i440fx_6_1_machine_options);
+DEFINE_I440FX_MACHINE(6, 1);
 
-static void pc_i440fx_6_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_6_0_options(MachineClass *m)
 {
-    pc_i440fx_6_1_machine_options(m);
+    pc_i440fx_machine_6_1_options(m);
     compat_props_add(m->compat_props, hw_compat_6_0, hw_compat_6_0_len);
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v6_0, "pc-i440fx-6.0",
-                      pc_i440fx_6_0_machine_options);
+DEFINE_I440FX_MACHINE(6, 0);
 
-static void pc_i440fx_5_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_2_options(MachineClass *m)
 {
-    pc_i440fx_6_0_machine_options(m);
+    pc_i440fx_machine_6_0_options(m);
     compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v5_2, "pc-i440fx-5.2",
-                      pc_i440fx_5_2_machine_options);
+DEFINE_I440FX_MACHINE(5, 2);
 
-static void pc_i440fx_5_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_5_2_machine_options(m);
+    pc_i440fx_machine_5_2_options(m);
     compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
     compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
     pcmc->kvmclock_create_always = false;
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_I440FX_MACHINE(v5_1, "pc-i440fx-5.1",
-                      pc_i440fx_5_1_machine_options);
+DEFINE_I440FX_MACHINE(5, 1);
 
-static void pc_i440fx_5_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_5_0_options(MachineClass *m)
 {
-    pc_i440fx_5_1_machine_options(m);
+    pc_i440fx_machine_5_1_options(m);
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_I440FX_MACHINE(v5_0, "pc-i440fx-5.0",
-                      pc_i440fx_5_0_machine_options);
+DEFINE_I440FX_MACHINE(5, 0);
 
-static void pc_i440fx_4_2_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_2_options(MachineClass *m)
 {
-    pc_i440fx_5_0_machine_options(m);
+    pc_i440fx_machine_5_0_options(m);
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_2, "pc-i440fx-4.2",
-                      pc_i440fx_4_2_machine_options);
+DEFINE_I440FX_MACHINE(4, 2);
 
-static void pc_i440fx_4_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_1_options(MachineClass *m)
 {
-    pc_i440fx_4_2_machine_options(m);
+    pc_i440fx_machine_4_2_options(m);
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_1, "pc-i440fx-4.1",
-                      pc_i440fx_4_1_machine_options);
+DEFINE_I440FX_MACHINE(4, 1);
 
-static void pc_i440fx_4_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_4_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_i440fx_4_1_machine_options(m);
+    pc_i440fx_machine_4_1_options(m);
     pcmc->default_cpu_version = CPU_VERSION_LEGACY;
     compat_props_add(m->compat_props, hw_compat_4_0, hw_compat_4_0_len);
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v4_0, "pc-i440fx-4.0",
-                      pc_i440fx_4_0_machine_options);
+DEFINE_I440FX_MACHINE(4, 0);
 
-static void pc_i440fx_3_1_machine_options(MachineClass *m)
+static void pc_i440fx_machine_3_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_4_0_machine_options(m);
+    pc_i440fx_machine_4_0_options(m);
     m->smbus_no_migration_support = true;
     pcmc->pvh_enabled = false;
     compat_props_add(m->compat_props, hw_compat_3_1, hw_compat_3_1_len);
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1",
-                      pc_i440fx_3_1_machine_options);
+DEFINE_I440FX_MACHINE(3, 1);
 
-static void pc_i440fx_3_0_machine_options(MachineClass *m)
+static void pc_i440fx_machine_3_0_options(MachineClass *m)
 {
-    pc_i440fx_3_1_machine_options(m);
+    pc_i440fx_machine_3_1_options(m);
     compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0",
-                      pc_i440fx_3_0_machine_options);
+DEFINE_I440FX_MACHINE(3, 0);
 
-static void pc_i440fx_2_12_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_12_options(MachineClass *m)
 {
-    pc_i440fx_3_0_machine_options(m);
+    pc_i440fx_machine_3_0_options(m);
     m->deprecation_reason = "old and unattended - use a newer version instead";
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_12, "pc-i440fx-2.12",
-                      pc_i440fx_2_12_machine_options);
+DEFINE_I440FX_MACHINE(2, 12);
 
-static void pc_i440fx_2_11_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_11_options(MachineClass *m)
 {
-    pc_i440fx_2_12_machine_options(m);
+    pc_i440fx_machine_2_12_options(m);
     compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_11, "pc-i440fx-2.11",
-                      pc_i440fx_2_11_machine_options);
+DEFINE_I440FX_MACHINE(2, 11);
 
-static void pc_i440fx_2_10_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_10_options(MachineClass *m)
 {
-    pc_i440fx_2_11_machine_options(m);
+    pc_i440fx_machine_2_11_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_I440FX_MACHINE(v2_10, "pc-i440fx-2.10",
-                      pc_i440fx_2_10_machine_options);
+DEFINE_I440FX_MACHINE(2, 10);
 
-static void pc_i440fx_2_9_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_9_options(MachineClass *m)
 {
-    pc_i440fx_2_10_machine_options(m);
+    pc_i440fx_machine_2_10_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9",
-                      pc_i440fx_2_9_machine_options);
+DEFINE_I440FX_MACHINE(2, 9);
 
-static void pc_i440fx_2_8_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_8_options(MachineClass *m)
 {
-    pc_i440fx_2_9_machine_options(m);
+    pc_i440fx_machine_2_9_options(m);
     compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_8, "pc-i440fx-2.8",
-                      pc_i440fx_2_8_machine_options);
+DEFINE_I440FX_MACHINE(2, 8);
 
-static void pc_i440fx_2_7_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_7_options(MachineClass *m)
 {
-    pc_i440fx_2_8_machine_options(m);
+    pc_i440fx_machine_2_8_options(m);
     compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_7, "pc-i440fx-2.7",
-                      pc_i440fx_2_7_machine_options);
+DEFINE_I440FX_MACHINE(2, 7);
 
-static void pc_i440fx_2_6_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_6_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_2_7_machine_options(m);
+    pc_i440fx_machine_2_7_options(m);
     pcmc->legacy_cpu_hotplug = true;
     x86mc->fwcfg_dma_enabled = false;
     compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6",
-                      pc_i440fx_2_6_machine_options);
+DEFINE_I440FX_MACHINE(2, 6);
 
-static void pc_i440fx_2_5_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_5_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
-    pc_i440fx_2_6_machine_options(m);
+    pc_i440fx_machine_2_6_options(m);
     x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_5, "pc-i440fx-2.5",
-                      pc_i440fx_2_5_machine_options);
+DEFINE_I440FX_MACHINE(2, 5);
 
-static void pc_i440fx_2_4_machine_options(MachineClass *m)
+static void pc_i440fx_machine_2_4_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_i440fx_2_5_machine_options(m);
+    pc_i440fx_machine_2_5_options(m);
     m->hw_version = "2.4.0";
     pcmc->broken_reserved_end = true;
     compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_I440FX_MACHINE(v2_4, "pc-i440fx-2.4",
-                      pc_i440fx_2_4_machine_options)
+DEFINE_I440FX_MACHINE(2, 4);
 
 #ifdef CONFIG_ISAPC
 static void isapc_machine_options(MachineClass *m)
@@ -833,20 +806,20 @@ DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,
 #endif
 
 #ifdef CONFIG_XEN
-static void xenfv_4_2_machine_options(MachineClass *m)
+static void xenfv_machine_4_2_options(MachineClass *m)
 {
-    pc_i440fx_4_2_machine_options(m);
+    pc_i440fx_machine_4_2_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->max_cpus = HVM_MAX_VCPUS;
     m->default_machine_opts = "accel=xen,suppress-vmdesc=on";
 }
 
 DEFINE_PC_MACHINE(xenfv_4_2, "xenfv-4.2", pc_xen_hvm_init,
-                  xenfv_4_2_machine_options);
+                  xenfv_machine_4_2_options);
 
-static void xenfv_3_1_machine_options(MachineClass *m)
+static void xenfv_machine_3_1_options(MachineClass *m)
 {
-    pc_i440fx_3_1_machine_options(m);
+    pc_i440fx_machine_3_1_options(m);
     m->desc = "Xen Fully-virtualized PC";
     m->alias = "xenfv";
     m->max_cpus = HVM_MAX_VCPUS;
@@ -854,5 +827,5 @@ static void xenfv_3_1_machine_options(MachineClass *m)
 }
 
 DEFINE_PC_MACHINE(xenfv, "xenfv-3.1", pc_xen_hvm_init,
-                  xenfv_3_1_machine_options);
+                  xenfv_machine_3_1_options);
 #endif
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 46bc411063..027c6f29f7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -317,4 +317,30 @@ extern const size_t pc_compat_2_3_len;
     } \
     type_init(pc_machine_init_##suffix)
 
+#define DEFINE_PC_VER_MACHINE(namesym, namestr, initfn, ...) \
+    static void MACHINE_VER_SYM(init, namesym, __VA_ARGS__)( \
+        MachineState *machine) \
+    { \
+        initfn(machine); \
+    } \
+    static void MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__)( \
+        ObjectClass *oc, \
+        void *data) \
+    { \
+        MachineClass *mc = MACHINE_CLASS(oc); \
+        MACHINE_VER_SYM(options, namesym, __VA_ARGS__)(mc); \
+        mc->init = MACHINE_VER_SYM(init, namesym, __VA_ARGS__); \
+    } \
+    static const TypeInfo MACHINE_VER_SYM(info, namesym, __VA_ARGS__) = \
+    { \
+        .name       = MACHINE_VER_TYPE_NAME(namestr, __VA_ARGS__), \
+        .parent     = TYPE_PC_MACHINE, \
+        .class_init = MACHINE_VER_SYM(class_init, namesym, __VA_ARGS__), \
+    }; \
+    static void MACHINE_VER_SYM(register, namesym, __VA_ARGS__)(void) \
+    { \
+        type_register(&MACHINE_VER_SYM(info, namesym, __VA_ARGS__)); \
+    } \
+    type_init(MACHINE_VER_SYM(register, namesym, __VA_ARGS__));
+
 #endif
-- 
2.43.0


