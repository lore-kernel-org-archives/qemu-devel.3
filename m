Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA725C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDEL-0003hf-3e; Tue, 23 Jul 2024 06:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEE-0003MF-GW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEC-0002HP-OZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmqhjtW3VVd/s0tK/0z/W3SbHoTTKsvguEWbJfZllQs=;
 b=BNENl+EqPo0MKZ++21VbVJSF3mJNTbaK9OfbmkzUl7bAqYyb7/x02nlXLqbnmZ48NbR3U7
 auLjx4aY4W/qH25EhRJBbkMD2QQFp9XpRzcuDy775WuBftCjOZX3a4gLLcPBq1GxRo7pFn
 2UXShn8dfj1eeP/ijBivL2aojKZrA0M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-enijoQrVMKqRxYYwmOnqiA-1; Tue, 23 Jul 2024 06:58:42 -0400
X-MC-Unique: enijoQrVMKqRxYYwmOnqiA-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a7a9761bf6dso48742466b.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732321; x=1722337121;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmqhjtW3VVd/s0tK/0z/W3SbHoTTKsvguEWbJfZllQs=;
 b=VV96IggrwFqSy79h/Dqcy2XTYw3jADn56nMiVYv0MEGxfSfwwUR4BbjvpNrKxgXdHi
 CT9+H2qUbjecz34x7bdC5y3Kp5b/5G4KEscNBXHmPnN9++K35ha88ePb+jOfSIm7Vlmm
 rt+7r4DVaL8cdnW5XvkKVxcUsQdqRNcQvtybHzAawUwHVMmk8YwjQ73c07c10AzSTQdp
 vQug7KKBmhsNfcKSh/osMty9d7UGA9cLFPlF0CyB9m71FMfDLQ1e/JVl7jl1mFJfomWA
 fgU3zp5hMARxkbpu9CHT36N6uir6/+xYviLURMDIu7NlO1k7oGmhmy6MEVPmKxjG7jc+
 OZVA==
X-Gm-Message-State: AOJu0YwgGsYlsidfhbkpidb2QPxS3QkTs9twjzhlGP63o8oTPBZIStCJ
 3M0wdqYtsNjehVK1Xl/QnSFpbuccsYa7/Zkj8OzWRa4JePt9b/f7X26/upivcxwpKHrUrG/T8XR
 DwsJoSguARRcCVPOhHNlgxfHvW+O7KGB4Cf2r4StC7ZzWQCBgvHMg9S70kvOQ5qUE2dWFUJ1+6s
 kqEeKsDf/1BLOYRLDwwYRBX6pJxxLL5w==
X-Received: by 2002:a17:907:6d17:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a7a4bfa2290mr646429566b.2.1721732321257; 
 Tue, 23 Jul 2024 03:58:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPiDP6q4yFh2zc8g244p/9/BKe3OcO4IPrS8Gp/M67qY/vw4jzg6IKp/NzrzMhDC9zSSgkPQ==
X-Received: by 2002:a17:907:6d17:b0:a72:5f9a:159a with SMTP id
 a640c23a62f3a-a7a4bfa2290mr646427366b.2.1721732320657; 
 Tue, 23 Jul 2024 03:58:40 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a8c70c3b9sm87295866b.136.2024.07.23.03.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:58:40 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:58:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org
Subject: [PULL v2 36/61] smbios: make memory device size configurable per
 Machine
Message-ID: <62f182c97b31445012d37181005a83ff8453edaa.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Igor Mammedov <imammedo@redhat.com>

Currently QEMU describes initial[1] RAM* in SMBIOS as a series of
virtual DIMMs (capped at 16Gb max) using type 17 structure entries.

Which is fine for the most cases.  However when starting guest
with terabytes of RAM this leads to too many memory device
structures, which eventually upsets linux kernel as it reserves
only 64K for these entries and when that border is crossed out
it runs out of reserved memory.

Instead of partitioning initial RAM on 16Gb DIMMs, use maximum
possible chunk size that SMBIOS spec allows[2]. Which lets
encode RAM in lower 31 bits of 32bit field (which amounts upto
2047Tb per DIMM).
As result initial RAM will generate only one type 17 structure
until host/guest reach ability to use more RAM in the future.

Compat changes:
We can't unconditionally change chunk size as it will break
QEMU<->guest ABI (and migration). Thus introduce a new machine
class field that would let older versioned machines to use
legacy 16Gb chunks, while new(er) machine type[s] use maximum
possible chunk size.

PS:
While it might seem to be risky to rise max entry size this large
(much beyond of what current physical RAM modules support),
I'd not expect it causing much issues, modulo uncovering bugs
in software running within guest. And those should be fixed
on guest side to handle SMBIOS spec properly, especially if
guest is expected to support so huge RAM configs.

In worst case, QEMU can reduce chunk size later if we would
care enough about introducing a workaround for some 'unfixable'
guest OS, either by fixing up the next machine type or
giving users a CLI option to customize it.

1) Initial RAM - is RAM configured with help '-m SIZE' CLI option/
   implicitly defined by machine. It doesn't include memory
   configured with help of '-device' option[s] (pcdimm,nvdimm,...)
2) SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size

PS:
* tested on 8Tb host with RHEL6 guest, which seems to parse
  type 17 SMBIOS table entries correctly (according to 'dmidecode').

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240715122417.4059293-1-imammedo@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/boards.h |  4 ++++
 hw/arm/virt.c       |  1 +
 hw/core/machine.c   |  6 ++++++
 hw/i386/pc_piix.c   |  1 +
 hw/i386/pc_q35.c    |  1 +
 hw/smbios/smbios.c  | 11 ++++++-----
 6 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ef6f18f2c1..48ff6d8b93 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -237,6 +237,9 @@ typedef struct {
  *    purposes only.
  *    Applies only to default memory backend, i.e., explicit memory backend
  *    wasn't used.
+ * @smbios_memory_device_size:
+ *    Default size of memory device,
+ *    SMBIOS 3.1.0 "7.18 Memory Device (Type 17)"
  */
 struct MachineClass {
     /*< private >*/
@@ -304,6 +307,7 @@ struct MachineClass {
     const CPUArchIdList *(*possible_cpu_arch_ids)(MachineState *machine);
     int64_t (*get_default_cpu_node_id)(const MachineState *ms, int idx);
     ram_addr_t (*fixup_ram_size)(ram_addr_t size);
+    uint64_t smbios_memory_device_size;
 };
 
 /**
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b0c68d66a3..719e83e6a1 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3308,6 +3308,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 1)
 static void virt_machine_9_0_options(MachineClass *mc)
 {
     virt_machine_9_1_options(mc);
+    mc->smbios_memory_device_size = 16 * GiB;
     compat_props_add(mc->compat_props, hw_compat_9_0, hw_compat_9_0_len);
 }
 DEFINE_VIRT_MACHINE(9, 0)
diff --git a/hw/core/machine.c b/hw/core/machine.c
index bc38cad7f2..ac30544e7f 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -1004,6 +1004,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     /* Default 128 MB as guest ram size */
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
+    /*
+     * SMBIOS 3.1.0 7.18.5 Memory Device — Extended Size
+     * use max possible value that could be encoded into
+     * 'Extended Size' field (2047Tb).
+     */
+    mc->smbios_memory_device_size = 2047 * TiB;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9445b07b4f..d9e69243b4 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -495,6 +495,7 @@ static void pc_i440fx_machine_9_0_options(MachineClass *m)
     pc_i440fx_machine_9_1_options(m);
     m->alias = NULL;
     m->is_default = false;
+    m->smbios_memory_device_size = 16 * GiB;
 
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 71d3c6d122..9d108b194e 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -374,6 +374,7 @@ static void pc_q35_machine_9_0_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     pc_q35_machine_9_1_options(m);
     m->alias = NULL;
+    m->smbios_memory_device_size = 16 * GiB;
     compat_props_add(m->compat_props, hw_compat_9_0, hw_compat_9_0_len);
     compat_props_add(m->compat_props, pc_compat_9_0, pc_compat_9_0_len);
     pcmc->isa_bios_alias = false;
diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 3b7703489d..a394514264 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -1093,6 +1093,7 @@ static bool smbios_get_tables_ep(MachineState *ms,
                        Error **errp)
 {
     unsigned i, dimm_cnt, offset;
+    MachineClass *mc = MACHINE_GET_CLASS(ms);
     ERRP_GUARD();
 
     assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
@@ -1123,12 +1124,12 @@ static bool smbios_get_tables_ep(MachineState *ms,
     smbios_build_type_9_table(errp);
     smbios_build_type_11_table();
 
-#define MAX_DIMM_SZ (16 * GiB)
-#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? MAX_DIMM_SZ \
-                                        : ((current_machine->ram_size - 1) % MAX_DIMM_SZ) + 1)
+#define GET_DIMM_SZ ((i < dimm_cnt - 1) ? mc->smbios_memory_device_size \
+    : ((current_machine->ram_size - 1) % mc->smbios_memory_device_size) + 1)
 
-    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size, MAX_DIMM_SZ) /
-               MAX_DIMM_SZ;
+    dimm_cnt = QEMU_ALIGN_UP(current_machine->ram_size,
+                             mc->smbios_memory_device_size) /
+               mc->smbios_memory_device_size;
 
     /*
      * The offset determines if we need to keep additional space between
-- 
MST


