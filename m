Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBBDC54754
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 13:21:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFYVx-0008Kh-KX; Thu, 15 May 2025 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYVu-0008Jv-2P
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uFYVr-0003be-Vn
 for qemu-devel@nongnu.org; Thu, 15 May 2025 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747315239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EaeNKiOOemve9IbW+AchKk2dKkD+8+vWm8PKCOXYIAo=;
 b=B7xc8MttW9yXEhca+qZCAIQ+tlQSbbWpQWxOU3N+S8rly0a5z08WecimT++ZKAdHirM8kV
 5QazqSzoT0TKmtTfoXGvdebO3z1acHXHqy8huWLyETEB2ufrOVxEk0+VYIy7Sur8PXVBDM
 N9JKkVGnBZImBWyJ8dHdPj1tfrCY2aY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-Y-r30376PCysHXRiaqjnSA-1; Thu,
 15 May 2025 09:20:38 -0400
X-MC-Unique: Y-r30376PCysHXRiaqjnSA-1
X-Mimecast-MFC-AGG-ID: Y-r30376PCysHXRiaqjnSA_1747315236
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 383A218011D3; Thu, 15 May 2025 13:20:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.27])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE6BB1956094; Thu, 15 May 2025 13:20:32 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 1/4] hw/microblaze: Add endianness property to the
 petalogix_s3adsp1800 machine
Date: Thu, 15 May 2025 15:20:16 +0200
Message-ID: <20250515132019.569365-2-thuth@redhat.com>
In-Reply-To: <20250515132019.569365-1-thuth@redhat.com>
References: <20250515132019.569365-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

Since the microblaze target can now handle both endianness, big and
little, we should provide a config knob for the user to select the
desired endianness.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 41 +++++++++++++++++++++---
 1 file changed, 36 insertions(+), 5 deletions(-)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index 032f6f70eac..edc5d0dcfd0 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -58,9 +58,20 @@
 #define TYPE_PETALOGIX_S3ADSP1800_MACHINE \
             MACHINE_TYPE_NAME("petalogix-s3adsp1800")
 
+struct S3Adsp1800MachineState {
+    MachineState parent_class;
+
+    EndianMode endianness;
+};
+
+OBJECT_DECLARE_TYPE(S3Adsp1800MachineState, MachineClass,
+                    PETALOGIX_S3ADSP1800_MACHINE)
+
+
 static void
 petalogix_s3adsp1800_init(MachineState *machine)
 {
+    S3Adsp1800MachineState *psms = PETALOGIX_S3ADSP1800_MACHINE(machine);
     ram_addr_t ram_size = machine->ram_size;
     DeviceState *dev;
     MicroBlazeCPU *cpu;
@@ -71,13 +82,12 @@ petalogix_s3adsp1800_init(MachineState *machine)
     MemoryRegion *phys_ram = g_new(MemoryRegion, 1);
     qemu_irq irq[32];
     MemoryRegion *sysmem = get_system_memory();
-    EndianMode endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG
-                                              : ENDIAN_MODE_LITTLE;
+    EndianMode endianness = psms->endianness;
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
     object_property_set_bool(OBJECT(cpu), "little-endian",
-                             !TARGET_BIG_ENDIAN, &error_abort);
+                             endianness == ENDIAN_MODE_LITTLE, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
@@ -135,20 +145,41 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     create_unimplemented_device("xps_gpio", GPIO_BASEADDR, 0x10000);
 
-    microblaze_load_kernel(cpu, !TARGET_BIG_ENDIAN, ddr_base, ram_size,
-                           machine->initrd_filename,
+    microblaze_load_kernel(cpu, endianness == ENDIAN_MODE_LITTLE, ddr_base,
+                           ram_size, machine->initrd_filename,
                            BINARY_DEVICE_TREE_FILE,
                            NULL);
 }
 
+static int machine_get_endianness(Object *obj, Error **errp G_GNUC_UNUSED)
+{
+    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
+    return ms->endianness;
+}
+
+static void machine_set_endianness(Object *obj, int endianness, Error **errp)
+{
+    S3Adsp1800MachineState *ms = PETALOGIX_S3ADSP1800_MACHINE(obj);
+    ms->endianness = endianness;
+}
+
 static void petalogix_s3adsp1800_machine_class_init(ObjectClass *oc,
                                                     const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
+    ObjectProperty *prop;
 
     mc->desc = "PetaLogix linux refdesign for xilinx Spartan 3ADSP1800";
     mc->init = petalogix_s3adsp1800_init;
     mc->is_default = true;
+
+    prop = object_class_property_add_enum(oc, "endianness", "EndianMode",
+                                          &EndianMode_lookup,
+                                          machine_get_endianness,
+                                          machine_set_endianness);
+    object_property_set_default_str(prop, TARGET_BIG_ENDIAN ? "big" : "little");
+    object_class_property_set_description(oc, "endianness",
+            "Defines whether the machine runs in big or little endian mode");
 }
 
 static const TypeInfo petalogix_s3adsp1800_machine_types[] = {
-- 
2.49.0


