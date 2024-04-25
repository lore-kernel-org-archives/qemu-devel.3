Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F27C41513
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 18:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s044w-0000bL-Nq; Thu, 25 Apr 2024 14:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s044t-0000an-Vk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s0449-0004rQ-0X
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 14:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714070607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N9vbo3uUKhHLnzOebXa1LE4hx2mSttzc84PuJ7uRBhA=;
 b=FnIKJtV9etFsfE8c25gqT7ZSer/IbFMMpJS9VoAEAEazANFp8+nWMxFxml3JTxkeLx6GwR
 20bmkrGutyGumxFY+GSptoTkO1t5g2BTYTG6kuC2K7h8qwlyi7qFWb66I6t72ChmxZdJtp
 zQdRYiJtDZhBU5thB/01YLSrojv39z4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-mChfVDq6O26UZud04czTgA-1; Thu, 25 Apr 2024 14:43:25 -0400
X-MC-Unique: mChfVDq6O26UZud04czTgA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64FA518065AF;
 Thu, 25 Apr 2024 18:43:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 661925AD060;
 Thu, 25 Apr 2024 18:43:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>
Subject: [RFC PATCH 3/3] hw/i386: Add the possibility to use i440fx and isapc
 without FDC
Date: Thu, 25 Apr 2024 20:43:15 +0200
Message-ID: <20240425184315.553329-4-thuth@redhat.com>
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
References: <20240425184315.553329-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
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

The i440fx and the isapc machines can be used in binaries without
FDC, too. We just have to make sure that they don't try to instantiate
the FDC when it is not available.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/i386/pc_piix.c | 6 ++++--
 hw/i386/Kconfig   | 2 --
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 8850c49c66..99efb3c45c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -317,8 +317,8 @@ static void pc_init1(MachineState *machine, const char *pci_type)
     }
 
     /* init basic PC hardware */
-    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc, true,
-                         0x4);
+    pc_basic_device_init(pcms, isa_bus, x86ms->gsi, x86ms->rtc,
+                         !MACHINE_CLASS(pcmc)->no_floppy, 0x4);
 
     pc_nic_init(pcmc, isa_bus, pcms->pcibus);
 
@@ -501,6 +501,7 @@ static void pc_i440fx_machine_options(MachineClass *m)
     m->default_machine_opts = "firmware=bios-256k.bin";
     m->default_display = "std";
     m->default_nic = "e1000";
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_RAMFB_DEVICE);
     machine_class_allow_dynamic_sysbus_dev(m, TYPE_VMBUS_BRIDGE);
@@ -931,6 +932,7 @@ static void isapc_machine_options(MachineClass *m)
     pcmc->has_reserved_memory = false;
     m->default_nic = "ne2k_isa";
     m->default_cpu_type = X86_CPU_TYPE_NAME("486");
+    m->no_floppy = !module_object_class_by_name(TYPE_ISA_FDC);
     m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
 }
 
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 0b08580862..f2ef6d1ef2 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -70,7 +70,6 @@ config I440FX
     imply VMPORT
     imply VMMOUSE
     select ACPI_PIIX4
-    select FDC_ISA
     select PC_PCI
     select PC_ACPI
     select PCI_I440FX
@@ -84,7 +83,6 @@ config ISAPC
     bool
     imply VGA_ISA
     select ISA_BUS
-    select FDC_ISA
     select PC
     select IDE_ISA
     # FIXME: it is in the same file as i440fx, and does not compile
-- 
2.44.0


