Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20805E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 01:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsWku-0000W1-Me; Tue, 17 Feb 2026 20:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWks-0000RL-GX; Tue, 17 Feb 2026 20:53:30 -0500
Received: from pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
 ([35.83.148.184])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=502105d20=graf@amazon.de>)
 id 1vsWkq-0005hY-Mq; Tue, 17 Feb 2026 20:53:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1771379608; x=1802915608;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=vGUcozSGDe3LdA51buWeDnWuA1XOyLH+O+KdKgLB5Pc=;
 b=S1elGRZYfYi6eeLSA2ZbHPAvKxbrFZUe9HNijDZ+AIxE006rvcw8K3uG
 +uqZ6gwrUU975KYvUQJjyMoetT518uGs0q5kdZeAo90dZYNsj1ZjeRHVq
 r95HXvOcn3QQX+vibiL7QFEKZSgt6wkRprT1YG42cDztl8e349KrU6B8V
 K5xwQdjIT5eWpgCNt9E5CEBt6UQ/8MYJsZpK66CqkTlm7wVMHZM84N6ew
 O1Pwtpw6pnh5uKmgpH0G7JquvUStob4qQ9ZOG3SwSRyKWeoBihajB8oVv
 JIej/CwTp+xVwwvWvojxoChlNKOHuzr3QZAXFbxaXVMZzluuDE2QGgyUi A==;
X-CSE-ConnectionGUID: 6RaYNiU/T8y49rRrUjpGMA==
X-CSE-MsgGUID: Pxs3kH1ESw2hw1KvXZzSRg==
X-IronPort-AV: E=Sophos;i="6.21,297,1763424000"; d="scan'208";a="13037688"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2026 01:53:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:30148]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.241:2525]
 with esmtp (Farcaster)
 id 0c8131c5-47b6-420c-ad7d-5afbafb4ae0e; Wed, 18 Feb 2026 01:53:23 +0000 (UTC)
X-Farcaster-Flow-ID: 0c8131c5-47b6-420c-ad7d-5afbafb4ae0e
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:53:23 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D020UWC004.ant.amazon.com (10.13.138.149) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.35;
 Wed, 18 Feb 2026 01:53:20 +0000
From: Alexander Graf <graf@amazon.com>
To: <qemu-devel@nongnu.org>
CC: <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, "Thomas
 Huth" <thuth@redhat.com>, <alex.bennee@linaro.org>, <philmd@linaro.org>,
 <berrange@redhat.com>, <marcandre.lureau@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, <mst@redhat.com>, Dorjoy Chowdhury
 <dorjoychy111@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Tyler Fanelli <tfanelli@redhat.com>,
 <mknaust@amazon.com>, <nh-open-source@amazon.com>
Subject: [PATCH 09/10] hw/nitro: Enable direct kernel boot
Date: Wed, 18 Feb 2026 01:51:49 +0000
Message-ID: <20260218015151.4052-10-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260218015151.4052-1-graf@amazon.com>
References: <20260218015151.4052-1-graf@amazon.com>
MIME-Version: 1.0
X-Originating-IP: [172.19.99.218]
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=35.83.148.184;
 envelope-from=prvs=502105d20=graf@amazon.de;
 helo=pdx-out-014.esa.us-west-2.outbound.mail-perimeter.amazon.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Nitro Enclaves can only boot EIF files which are a combination of
kernel, initramfs and cmdline in a single file. When the kernel image is
not an EIF, treat it like a kernel image and assemble an EIF image on
the fly. This way, users can call QEMU with a direct
kernel/initrd/cmdline combination and everything "just works".

Signed-off-by: Alexander Graf <graf@amazon.com>
---
 hw/core/eif.h        |   3 ++
 hw/nitro/machine.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
 hw/nitro/meson.build |   2 +-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/hw/core/eif.h b/hw/core/eif.h
index a3412377a9..0c432dbc2d 100644
--- a/hw/core/eif.h
+++ b/hw/core/eif.h
@@ -12,6 +12,7 @@
 #define HW_CORE_EIF_H
 
 #define MAX_SECTIONS 32
+#define EIF_HDR_ARCH_ARM64 0x1
 
 /* members are ordered according to field order in .eif file */
 typedef struct EifHeader {
@@ -49,6 +50,8 @@ enum EifSectionTypes {
     EIF_SECTION_MAX = 6,
 };
 
+#define EIF_MAGIC { '.', 'e', 'i', 'f' }
+
 bool read_eif_file(const char *eif_path, const char *machine_initrd,
                    char **kernel_path, char **initrd_path,
                    char **kernel_cmdline, uint8_t *image_sha384,
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 197adfbdb5..33b0749288 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -32,9 +32,104 @@
 #include "system/nitro-accel.h"
 #include "qemu/accel.h"
 #include "hw/arm/machines-qom.h"
+#include "hw/core/eif.h"
+#include <zlib.h> /* for crc32 */
 
 #define EIF_LOAD_ADDR   (8 * 1024 * 1024)
 
+static bool is_eif(char *eif, gsize len)
+{
+    const char eif_magic[] = EIF_MAGIC;
+
+    return len >= sizeof(eif_magic) &&
+           !memcmp(eif, eif_magic, sizeof(eif_magic));
+}
+
+static void build_eif_section(EifHeader *hdr, GByteArray *buf, uint16_t type,
+                              const char *data, uint64_t size)
+{
+    uint16_t section = be16_to_cpu(hdr->section_cnt);
+    EifSectionHeader shdr = {
+        .section_type = cpu_to_be16(type),
+        .flags = 0,
+        .section_size = cpu_to_be64(size),
+    };
+
+    hdr->section_offsets[section] = cpu_to_be64(buf->len);
+    hdr->section_sizes[section] = cpu_to_be64(size);
+
+    g_byte_array_append(buf, (const uint8_t *)&shdr, sizeof(shdr));
+    if (size) {
+        g_byte_array_append(buf, (const uint8_t *)data, size);
+    }
+
+    hdr->section_cnt = cpu_to_be16(section + 1);
+}
+
+/*
+ * Nitro Enclaves only support loading EIF files. When the user provides
+ * a Linux kernel, initrd and cmdline, convert them into EIF format.
+ */
+static char *build_eif(const char *kernel_data, gsize kernel_size,
+                       const char *initrd_path, const char *cmdline,
+                       gsize *out_size, Error **errp)
+{
+    g_autofree char *initrd_data = NULL;
+    static const char metadata[] = "{}";
+    size_t metadata_len = sizeof(metadata) - 1;
+    gsize initrd_size = 0;
+    GByteArray *buf;
+    EifHeader hdr;
+    uint32_t crc = 0;
+    size_t cmdline_len;
+
+    if (initrd_path) {
+        if (!g_file_get_contents(initrd_path, &initrd_data,
+                                 &initrd_size, NULL)) {
+            error_setg(errp, "Failed to read initrd '%s'", initrd_path);
+            return NULL;
+        }
+    }
+
+    buf = g_byte_array_new();
+
+    cmdline_len = cmdline ? strlen(cmdline) : 0;
+
+    hdr = (EifHeader) {
+        .magic = EIF_MAGIC,
+        .version = cpu_to_be16(4),
+        .flags = cpu_to_be16(target_aarch64() ? EIF_HDR_ARCH_ARM64 : 0),
+    };
+
+    g_byte_array_append(buf, (const uint8_t *)&hdr, sizeof(hdr));
+
+    /* Kernel */
+    build_eif_section(&hdr, buf, EIF_SECTION_KERNEL, kernel_data, kernel_size);
+
+    /* Command line */
+    build_eif_section(&hdr, buf, EIF_SECTION_CMDLINE, cmdline, cmdline_len);
+
+    /* Initramfs */
+    build_eif_section(&hdr, buf, EIF_SECTION_RAMDISK, initrd_data, initrd_size);
+
+    /* Metadata */
+    build_eif_section(&hdr, buf, EIF_SECTION_METADATA, metadata, metadata_len);
+
+    /*
+     * Patch the header into the buffer first (with real section offsets
+     * and sizes), then compute CRC over everything except the CRC field.
+     */
+    memcpy(buf->data, &hdr, sizeof(hdr));
+    crc = crc32(crc, buf->data, offsetof(EifHeader, eif_crc32));
+    crc = crc32(crc, &buf->data[sizeof(hdr)], buf->len - sizeof(hdr));
+
+    /* Finally write the CRC into the in-buffer header */
+    ((EifHeader *)buf->data)->eif_crc32 = cpu_to_be32(crc);
+
+    *out_size = buf->len;
+    return (char *)g_byte_array_free(buf, false);
+}
+
 static void nitro_create_cpu(const char *cpu_type, int index)
 {
     Object *obj = object_new(cpu_type);
@@ -87,6 +182,27 @@ static void nitro_machine_init(MachineState *machine)
         error_report("nitro: failed to read EIF '%s'", eif_path);
         exit(1);
     }
+
+    if (!is_eif(eif_data, eif_size)) {
+        char *kernel_data = eif_data;
+        gsize kernel_size = eif_size;
+        Error *err = NULL;
+
+        /*
+         * The user gave us a non-EIF kernel, likely a Linux kernel image.
+         * Assemble an EIF file from it, the -initrd and the -append arguments,
+         * so that users can perform a natural direct kernel boot.
+         */
+        eif_data = build_eif(kernel_data, kernel_size, machine->initrd_filename,
+                             machine->kernel_cmdline, &eif_size, &err);
+        if (!eif_data) {
+            error_report_err(err);
+            exit(1);
+        }
+
+        g_free(kernel_data);
+    }
+
     address_space_write(&address_space_memory, EIF_LOAD_ADDR,
                         MEMTXATTRS_UNSPECIFIED, eif_data, eif_size);
 
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
index 813f5a9c87..7b23f71d5a 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1,3 +1,3 @@
 system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
 system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: files('heartbeat.c'))
-system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: files('machine.c'))
+system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: [files('machine.c'), zlib])
-- 
2.47.1




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


