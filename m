Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A00C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2024 18:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ei4-0007Ej-UD; Wed, 01 May 2024 14:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Ehr-0006o8-UE
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2Eho-0003Nv-O1
 for qemu-devel@nongnu.org; Wed, 01 May 2024 14:29:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714588164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7m1vPAvm73mGIWlBZGHUCuljSVrrPQdCUpeHH9Aedf4=;
 b=PrtnUBMI6HpfrhwqO6/xAJSUi6ZQ6Yv3DMATqA3o4Z58y6FxjlHU1ySi0NeCB0CncGXbaB
 ReBW48A7dpIHTKx+oy1P1mdEuKFHs5s/lUu6lU0/mMuZaorwQfzCnMD22Q3wHNevO2W3kY
 PEbp3y3fZj+UCziJ9bTQqUNhHrle8KM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-3sMqNfenP-CgNElAI9sj9A-1; Wed, 01 May 2024 14:29:20 -0400
X-MC-Unique: 3sMqNfenP-CgNElAI9sj9A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D8218948A1;
 Wed,  1 May 2024 18:29:18 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.121])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 909308C4;
 Wed,  1 May 2024 18:29:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clegoate@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-arm@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 07/14] hw/i386: convert 'q35' machine definitions to use new
 macros
Date: Wed,  1 May 2024 19:27:52 +0100
Message-ID: <20240501182759.2934195-8-berrange@redhat.com>
In-Reply-To: <20240501182759.2934195-1-berrange@redhat.com>
References: <20240501182759.2934195-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.897,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This changes the DEFINE_Q35_MACHINE macro to use the common
helpers for constructing versioned symbol names and strings,
bringing greater consistency across targets.

The added benefit is that it avoids the need to repeat the
version number thrice in three different formats in the calls
to DEFINE_Q35_MACHINE.

Due to the odd-ball '4.0.1' machine type version, this
commit introduces a DEFINE_Q35_BUGFIX helper, to allow
defining of "bugfix" machine types which have a three
digit version.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/pc_q35.c | 215 ++++++++++++++++++++---------------------------
 1 file changed, 90 insertions(+), 125 deletions(-)

diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index bb53a51ac1..b76cdca151 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -331,17 +331,11 @@ static void pc_q35_init(MachineState *machine)
     }
 }
 
-#define DEFINE_Q35_MACHINE(suffix, name, compatfn, optionfn) \
-    static void pc_init_##suffix(MachineState *machine) \
-    { \
-        void (*compat)(MachineState *m) = (compatfn); \
-        if (compat) { \
-            compat(machine); \
-        } \
-        pc_q35_init(machine); \
-    } \
-    DEFINE_PC_MACHINE(suffix, name, pc_init_##suffix, optionfn)
+#define DEFINE_Q35_MACHINE(major, minor) \
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, NULL, major, minor);
 
+#define DEFINE_Q35_MACHINE_BUGFIX(major, minor, micro) \
+    DEFINE_PC_VER_MACHINE(pc_q35, "pc-q35", pc_q35_init, NULL, major, minor, micro);
 
 static void pc_q35_machine_options(MachineClass *m)
 {
@@ -367,30 +361,28 @@ static void pc_q35_machine_options(MachineClass *m)
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);
 }
 
-static void pc_q35_9_1_machine_options(MachineClass *m)
+static void pc_q35_machine_9_1_options(MachineClass *m)
 {
     pc_q35_machine_options(m);
     m->alias = "q35";
 }
 
-DEFINE_Q35_MACHINE(v9_1, "pc-q35-9.1", NULL,
-                   pc_q35_9_1_machine_options);
+DEFINE_Q35_MACHINE(9, 1);
 
-static void pc_q35_9_0_machine_options(MachineClass *m)
+static void pc_q35_machine_9_0_options(MachineClass *m)
 {
-    pc_q35_9_1_machine_options(m);
+    pc_q35_machine_9_1_options(m);
     m->alias = NULL;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
 }
 
-DEFINE_Q35_MACHINE(v9_0, "pc-q35-9.0", NULL,
-                   pc_q35_9_0_machine_options);
+DEFINE_Q35_MACHINE(9, 0);
 
-static void pc_q35_8_2_machine_options(MachineClass *m)
+static void pc_q35_machine_8_2_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_q35_9_0_machine_options(m);
+    pc_q35_machine_9_0_options(m);
     m->max_cpus = 1024;
     compat_props_add(m->compat_props, hw_compat_8_2, hw_compat_8_2_len);
     compat_props_add(m->compat_props, pc_compat_8_2, pc_compat_8_2_len);
@@ -398,26 +390,24 @@ static void pc_q35_8_2_machine_options(MachineClass *m)
     pcmc->default_smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_64;
 }
 
-DEFINE_Q35_MACHINE(v8_2, "pc-q35-8.2", NULL,
-                   pc_q35_8_2_machine_options);
+DEFINE_Q35_MACHINE(8, 2);
 
-static void pc_q35_8_1_machine_options(MachineClass *m)
+static void pc_q35_machine_8_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_q35_8_2_machine_options(m);
+    pc_q35_machine_8_2_options(m);
     pcmc->broken_32bit_mem_addr_check = true;
     compat_props_add(m->compat_props, hw_compat_8_1, hw_compat_8_1_len);
     compat_props_add(m->compat_props, pc_compat_8_1, pc_compat_8_1_len);
 }
 
-DEFINE_Q35_MACHINE(v8_1, "pc-q35-8.1", NULL,
-                   pc_q35_8_1_machine_options);
+DEFINE_Q35_MACHINE(8, 1);
 
-static void pc_q35_8_0_machine_options(MachineClass *m)
+static void pc_q35_machine_8_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_q35_8_1_machine_options(m);
+    pc_q35_machine_8_1_options(m);
     compat_props_add(m->compat_props, hw_compat_8_0, hw_compat_8_0_len);
     compat_props_add(m->compat_props, pc_compat_8_0, pc_compat_8_0_len);
 
@@ -426,132 +416,120 @@ static void pc_q35_8_0_machine_options(MachineClass *m)
     m->max_cpus = 288;
 }
 
-DEFINE_Q35_MACHINE(v8_0, "pc-q35-8.0", NULL,
-                   pc_q35_8_0_machine_options);
+DEFINE_Q35_MACHINE(8, 0);
 
-static void pc_q35_7_2_machine_options(MachineClass *m)
+static void pc_q35_machine_7_2_options(MachineClass *m)
 {
-    pc_q35_8_0_machine_options(m);
+    pc_q35_machine_8_0_options(m);
     compat_props_add(m->compat_props, hw_compat_7_2, hw_compat_7_2_len);
     compat_props_add(m->compat_props, pc_compat_7_2, pc_compat_7_2_len);
 }
 
-DEFINE_Q35_MACHINE(v7_2, "pc-q35-7.2", NULL,
-                   pc_q35_7_2_machine_options);
+DEFINE_Q35_MACHINE(7, 2);
 
-static void pc_q35_7_1_machine_options(MachineClass *m)
+static void pc_q35_machine_7_1_options(MachineClass *m)
 {
-    pc_q35_7_2_machine_options(m);
+    pc_q35_machine_7_2_options(m);
     compat_props_add(m->compat_props, hw_compat_7_1, hw_compat_7_1_len);
     compat_props_add(m->compat_props, pc_compat_7_1, pc_compat_7_1_len);
 }
 
-DEFINE_Q35_MACHINE(v7_1, "pc-q35-7.1", NULL,
-                   pc_q35_7_1_machine_options);
+DEFINE_Q35_MACHINE(7, 1);
 
-static void pc_q35_7_0_machine_options(MachineClass *m)
+static void pc_q35_machine_7_0_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_q35_7_1_machine_options(m);
+    pc_q35_machine_7_1_options(m);
     pcmc->enforce_amd_1tb_hole = false;
     compat_props_add(m->compat_props, hw_compat_7_0, hw_compat_7_0_len);
     compat_props_add(m->compat_props, pc_compat_7_0, pc_compat_7_0_len);
 }
 
-DEFINE_Q35_MACHINE(v7_0, "pc-q35-7.0", NULL,
-                   pc_q35_7_0_machine_options);
+DEFINE_Q35_MACHINE(7, 0);
 
-static void pc_q35_6_2_machine_options(MachineClass *m)
+static void pc_q35_machine_6_2_options(MachineClass *m)
 {
-    pc_q35_7_0_machine_options(m);
+    pc_q35_machine_7_0_options(m);
     compat_props_add(m->compat_props, hw_compat_6_2, hw_compat_6_2_len);
     compat_props_add(m->compat_props, pc_compat_6_2, pc_compat_6_2_len);
 }
 
-DEFINE_Q35_MACHINE(v6_2, "pc-q35-6.2", NULL,
-                   pc_q35_6_2_machine_options);
+DEFINE_Q35_MACHINE(6, 2);
 
-static void pc_q35_6_1_machine_options(MachineClass *m)
+static void pc_q35_machine_6_1_options(MachineClass *m)
 {
-    pc_q35_6_2_machine_options(m);
+    pc_q35_machine_6_2_options(m);
     compat_props_add(m->compat_props, hw_compat_6_1, hw_compat_6_1_len);
     compat_props_add(m->compat_props, pc_compat_6_1, pc_compat_6_1_len);
     m->smp_props.prefer_sockets = true;
 }
 
-DEFINE_Q35_MACHINE(v6_1, "pc-q35-6.1", NULL,
-                   pc_q35_6_1_machine_options);
+DEFINE_Q35_MACHINE(6, 1);
 
-static void pc_q35_6_0_machine_options(MachineClass *m)
+static void pc_q35_machine_6_0_options(MachineClass *m)
 {
-    pc_q35_6_1_machine_options(m);
+    pc_q35_machine_6_1_options(m);
     compat_props_add(m->compat_props, hw_compat_6_0, hw_compat_6_0_len);
     compat_props_add(m->compat_props, pc_compat_6_0, pc_compat_6_0_len);
 }
 
-DEFINE_Q35_MACHINE(v6_0, "pc-q35-6.0", NULL,
-                   pc_q35_6_0_machine_options);
+DEFINE_Q35_MACHINE(6, 0);
 
-static void pc_q35_5_2_machine_options(MachineClass *m)
+static void pc_q35_machine_5_2_options(MachineClass *m)
 {
-    pc_q35_6_0_machine_options(m);
+    pc_q35_machine_6_0_options(m);
     compat_props_add(m->compat_props, hw_compat_5_2, hw_compat_5_2_len);
     compat_props_add(m->compat_props, pc_compat_5_2, pc_compat_5_2_len);
 }
 
-DEFINE_Q35_MACHINE(v5_2, "pc-q35-5.2", NULL,
-                   pc_q35_5_2_machine_options);
+DEFINE_Q35_MACHINE(5, 2);
 
-static void pc_q35_5_1_machine_options(MachineClass *m)
+static void pc_q35_machine_5_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_q35_5_2_machine_options(m);
+    pc_q35_machine_5_2_options(m);
     compat_props_add(m->compat_props, hw_compat_5_1, hw_compat_5_1_len);
     compat_props_add(m->compat_props, pc_compat_5_1, pc_compat_5_1_len);
     pcmc->kvmclock_create_always = false;
     pcmc->pci_root_uid = 1;
 }
 
-DEFINE_Q35_MACHINE(v5_1, "pc-q35-5.1", NULL,
-                   pc_q35_5_1_machine_options);
+DEFINE_Q35_MACHINE(5, 1);
 
-static void pc_q35_5_0_machine_options(MachineClass *m)
+static void pc_q35_machine_5_0_options(MachineClass *m)
 {
-    pc_q35_5_1_machine_options(m);
+    pc_q35_machine_5_1_options(m);
     m->numa_mem_supported = true;
     compat_props_add(m->compat_props, hw_compat_5_0, hw_compat_5_0_len);
     compat_props_add(m->compat_props, pc_compat_5_0, pc_compat_5_0_len);
     m->auto_enable_numa_with_memdev = false;
 }
 
-DEFINE_Q35_MACHINE(v5_0, "pc-q35-5.0", NULL,
-                   pc_q35_5_0_machine_options);
+DEFINE_Q35_MACHINE(5, 0);
 
-static void pc_q35_4_2_machine_options(MachineClass *m)
+static void pc_q35_machine_4_2_options(MachineClass *m)
 {
-    pc_q35_5_0_machine_options(m);
+    pc_q35_machine_5_0_options(m);
     compat_props_add(m->compat_props, hw_compat_4_2, hw_compat_4_2_len);
     compat_props_add(m->compat_props, pc_compat_4_2, pc_compat_4_2_len);
 }
 
-DEFINE_Q35_MACHINE(v4_2, "pc-q35-4.2", NULL,
-                   pc_q35_4_2_machine_options);
+DEFINE_Q35_MACHINE(4, 2);
 
-static void pc_q35_4_1_machine_options(MachineClass *m)
+static void pc_q35_machine_4_1_options(MachineClass *m)
 {
-    pc_q35_4_2_machine_options(m);
+    pc_q35_machine_4_2_options(m);
     compat_props_add(m->compat_props, hw_compat_4_1, hw_compat_4_1_len);
     compat_props_add(m->compat_props, pc_compat_4_1, pc_compat_4_1_len);
 }
 
-DEFINE_Q35_MACHINE(v4_1, "pc-q35-4.1", NULL,
-                   pc_q35_4_1_machine_options);
+DEFINE_Q35_MACHINE(4, 1);
 
-static void pc_q35_4_0_1_machine_options(MachineClass *m)
+static void pc_q35_machine_4_0_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
-    pc_q35_4_1_machine_options(m);
+    pc_q35_machine_4_1_options(m);
     pcmc->default_cpu_version = CPU_VERSION_LEGACY;
     /*
      * This is the default machine for the 4.0-stable branch. It is basically
@@ -562,24 +540,22 @@ static void pc_q35_4_0_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_4_0, pc_compat_4_0_len);
 }
 
-DEFINE_Q35_MACHINE(v4_0_1, "pc-q35-4.0.1", NULL,
-                   pc_q35_4_0_1_machine_options);
+DEFINE_Q35_MACHINE_BUGFIX(4, 0, 1);
 
-static void pc_q35_4_0_machine_options(MachineClass *m)
+static void pc_q35_machine_4_0_options(MachineClass *m)
 {
-    pc_q35_4_0_1_machine_options(m);
+    pc_q35_machine_4_0_1_options(m);
     m->default_kernel_irqchip_split = true;
     /* Compat props are applied by the 4.0.1 machine */
 }
 
-DEFINE_Q35_MACHINE(v4_0, "pc-q35-4.0", NULL,
-                   pc_q35_4_0_machine_options);
+DEFINE_Q35_MACHINE(4, 0);
 
-static void pc_q35_3_1_machine_options(MachineClass *m)
+static void pc_q35_machine_3_1_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_q35_4_0_machine_options(m);
+    pc_q35_machine_4_0_options(m);
     m->default_kernel_irqchip_split = false;
     m->smbus_no_migration_support = true;
     pcmc->pvh_enabled = false;
@@ -587,121 +563,110 @@ static void pc_q35_3_1_machine_options(MachineClass *m)
     compat_props_add(m->compat_props, pc_compat_3_1, pc_compat_3_1_len);
 }
 
-DEFINE_Q35_MACHINE(v3_1, "pc-q35-3.1", NULL,
-                   pc_q35_3_1_machine_options);
+DEFINE_Q35_MACHINE(3, 1);
 
-static void pc_q35_3_0_machine_options(MachineClass *m)
+static void pc_q35_machine_3_0_options(MachineClass *m)
 {
-    pc_q35_3_1_machine_options(m);
+    pc_q35_machine_3_1_options(m);
     compat_props_add(m->compat_props, hw_compat_3_0, hw_compat_3_0_len);
     compat_props_add(m->compat_props, pc_compat_3_0, pc_compat_3_0_len);
 }
 
-DEFINE_Q35_MACHINE(v3_0, "pc-q35-3.0", NULL,
-                    pc_q35_3_0_machine_options);
+DEFINE_Q35_MACHINE(3, 0);
 
-static void pc_q35_2_12_machine_options(MachineClass *m)
+static void pc_q35_machine_2_12_options(MachineClass *m)
 {
-    pc_q35_3_0_machine_options(m);
+    pc_q35_machine_3_0_options(m);
     compat_props_add(m->compat_props, hw_compat_2_12, hw_compat_2_12_len);
     compat_props_add(m->compat_props, pc_compat_2_12, pc_compat_2_12_len);
 }
 
-DEFINE_Q35_MACHINE(v2_12, "pc-q35-2.12", NULL,
-                   pc_q35_2_12_machine_options);
+DEFINE_Q35_MACHINE(2, 12);
 
-static void pc_q35_2_11_machine_options(MachineClass *m)
+static void pc_q35_machine_2_11_options(MachineClass *m)
 {
-    pc_q35_2_12_machine_options(m);
+    pc_q35_machine_2_12_options(m);
     m->default_nic = "e1000";
     compat_props_add(m->compat_props, hw_compat_2_11, hw_compat_2_11_len);
     compat_props_add(m->compat_props, pc_compat_2_11, pc_compat_2_11_len);
 }
 
-DEFINE_Q35_MACHINE(v2_11, "pc-q35-2.11", NULL,
-                   pc_q35_2_11_machine_options);
+DEFINE_Q35_MACHINE(2, 11);
 
-static void pc_q35_2_10_machine_options(MachineClass *m)
+static void pc_q35_machine_2_10_options(MachineClass *m)
 {
-    pc_q35_2_11_machine_options(m);
+    pc_q35_machine_2_11_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
     m->auto_enable_numa_with_memhp = false;
 }
 
-DEFINE_Q35_MACHINE(v2_10, "pc-q35-2.10", NULL,
-                   pc_q35_2_10_machine_options);
+DEFINE_Q35_MACHINE(2, 10);
 
-static void pc_q35_2_9_machine_options(MachineClass *m)
+static void pc_q35_machine_2_9_options(MachineClass *m)
 {
-    pc_q35_2_10_machine_options(m);
+    pc_q35_machine_2_10_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
 }
 
-DEFINE_Q35_MACHINE(v2_9, "pc-q35-2.9", NULL,
-                   pc_q35_2_9_machine_options);
+DEFINE_Q35_MACHINE(2, 9);
 
-static void pc_q35_2_8_machine_options(MachineClass *m)
+static void pc_q35_machine_2_8_options(MachineClass *m)
 {
-    pc_q35_2_9_machine_options(m);
+    pc_q35_machine_2_9_options(m);
     compat_props_add(m->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(m->compat_props, pc_compat_2_8, pc_compat_2_8_len);
 }
 
-DEFINE_Q35_MACHINE(v2_8, "pc-q35-2.8", NULL,
-                   pc_q35_2_8_machine_options);
+DEFINE_Q35_MACHINE(2, 8);
 
-static void pc_q35_2_7_machine_options(MachineClass *m)
+static void pc_q35_machine_2_7_options(MachineClass *m)
 {
-    pc_q35_2_8_machine_options(m);
+    pc_q35_machine_2_8_options(m);
     m->max_cpus = 255;
     compat_props_add(m->compat_props, hw_compat_2_7, hw_compat_2_7_len);
     compat_props_add(m->compat_props, pc_compat_2_7, pc_compat_2_7_len);
 }
 
-DEFINE_Q35_MACHINE(v2_7, "pc-q35-2.7", NULL,
-                   pc_q35_2_7_machine_options);
+DEFINE_Q35_MACHINE(2, 7);
 
-static void pc_q35_2_6_machine_options(MachineClass *m)
+static void pc_q35_machine_2_6_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_q35_2_7_machine_options(m);
+    pc_q35_machine_2_7_options(m);
     pcmc->legacy_cpu_hotplug = true;
     x86mc->fwcfg_dma_enabled = false;
     compat_props_add(m->compat_props, hw_compat_2_6, hw_compat_2_6_len);
     compat_props_add(m->compat_props, pc_compat_2_6, pc_compat_2_6_len);
 }
 
-DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
-                   pc_q35_2_6_machine_options);
+DEFINE_Q35_MACHINE(2, 6);
 
-static void pc_q35_2_5_machine_options(MachineClass *m)
+static void pc_q35_machine_2_5_options(MachineClass *m)
 {
     X86MachineClass *x86mc = X86_MACHINE_CLASS(m);
 
-    pc_q35_2_6_machine_options(m);
+    pc_q35_machine_2_6_options(m);
     x86mc->save_tsc_khz = false;
     m->legacy_fw_cfg_order = 1;
     compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
     compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
 }
 
-DEFINE_Q35_MACHINE(v2_5, "pc-q35-2.5", NULL,
-                   pc_q35_2_5_machine_options);
+DEFINE_Q35_MACHINE(2, 5);
 
-static void pc_q35_2_4_machine_options(MachineClass *m)
+static void pc_q35_machine_2_4_options(MachineClass *m)
 {
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
 
-    pc_q35_2_5_machine_options(m);
+    pc_q35_machine_2_5_options(m);
     m->hw_version = "2.4.0";
     pcmc->broken_reserved_end = true;
     compat_props_add(m->compat_props, hw_compat_2_4, hw_compat_2_4_len);
     compat_props_add(m->compat_props, pc_compat_2_4, pc_compat_2_4_len);
 }
 
-DEFINE_Q35_MACHINE(v2_4, "pc-q35-2.4", NULL,
-                   pc_q35_2_4_machine_options);
+DEFINE_Q35_MACHINE(2, 4);
-- 
2.43.0


