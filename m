Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F29CD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:53:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyvg-0007w5-5L; Mon, 02 Mar 2026 03:47:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuZ-00055z-H1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:46:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyuS-0001v0-0x
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2T5dA1FgY/TpoQcQTw9NSmZNEHPoqxFKitjpjHx9UvQ=;
 b=FvckcAxFHDo4CGhDY6Oz/00FDye9bzqy2oMdy93qX23vKCIrJJBrMZGBnFz2rFW49YU+xY
 u7UPHB0Jeg6lIRJLb2fYFSTwxW0IEWj+JMG7iubZUJJFzEWDnP2b72kOxs6wkibRLgCfoh
 MvrKGq+QgySEZVE38JBcNxX4F6MGhUE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-RiIhaZndPu6lQN4n2P8VFQ-1; Mon, 02 Mar 2026 03:45:29 -0500
X-MC-Unique: RiIhaZndPu6lQN4n2P8VFQ-1
X-Mimecast-MFC-AGG-ID: RiIhaZndPu6lQN4n2P8VFQ_1772441128
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4832c4621c2so46274685e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441128; x=1773045928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2T5dA1FgY/TpoQcQTw9NSmZNEHPoqxFKitjpjHx9UvQ=;
 b=uHkgJwXtosmuUFQ7rZMr8ImT4IhDok10veSRt1Sb8Sxro7gGEgqD6ea2XRMGrvXCs+
 Ohg6ElXBaoJX5s1U2K8dWjJGdlTl+KFlDRlZvW3ZBhs0E7Yq+b5cc3XGEZlDccMMI6UH
 59HUOiHl2hptW99xgbrwERIsn36xMgZeWkEkZzOGL+7Dp7U+dRaOEYw7em26TDGBip25
 k5i4X6/couk1GSrFEKrenLo1gaxtEl2Pprzh4Aq5+0YivXti9cMfl5JxTTz86pFaS3Ax
 Qye9lD8lJie+3Lkyjq/9u7uEkJrFM5q7IMn0jjzbR32cLWCLxSdjqybR8EYc0wzllj9J
 EpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441128; x=1773045928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2T5dA1FgY/TpoQcQTw9NSmZNEHPoqxFKitjpjHx9UvQ=;
 b=mKkuK0ZwWGi6w5RVVVEYRH7fLOUUWNy7eawPLVHCNQpSmWr5y3p25ioDG6Lo6hNsh5
 B/uSB0pZ94Jady6S0at9vJ964t58a9k9PjFzzWaQmDeAP9hV+LX9imSYgG0SIMEjGw6Y
 Ow2QU5k9pTfPhZ1fxkqz7lW6eHdX6LiQEylk6zmuXrR41JUV9MjJtfZ7DDZSI2fPIHtm
 +MC9VaoJWkVfrw6qmJsJOu5Af3vsx5DB4w6Hgdplmvk/R87Gis8x5yXP8wko/U/IcjFd
 GO/IE5o2nmrxXA+G+alBQ3EBLce/CW1Q1GXMM9DeZ6EY+L42VlvQOjgiymJOcULrT1fo
 33yA==
X-Gm-Message-State: AOJu0Yz+tcHELo81NqMYZ8UFm0jc1stLFAtpWFD4+IGbsbUjDvrpzCWb
 t3jEsvTG9t5NDsLx75gyAR4sW546YQ4VxIoxsGdLNVB3j/Ply8liBu9aGLSvQKbytGASnH2uk9i
 g+KKTBjc3PgW82zOQvxmRvFpJNP1lb+D5bZqs3q73n6Jc05g1i5n3MHCRkIIF8tgagmVnDqYZ0A
 sRpvJv7tV6xzU0DZxO+I7S8F1/+k1f6yWgsDAhbwpL
X-Gm-Gg: ATEYQzwK8dIq9FxubV8MhunVEOCiuOon/YqNgB2sQxhvzUpvMNP0Ce1ER9rdyw+1Vv7
 1yxrP7/FrbN3nipQlR41+6knFXK/av+asXQ7R3xpdwcYA5v7ur+F/ifnALkBmTQpZY1YzaMhQq5
 K2d57PgqGa2xUqAwO6eGhMSRy3s9wN9dhUrDehGboiClMREQsfmNXwJASD0f/pz7Uu/mbTqBFMp
 tSC0tLeedvxdMy5WwCuEkBOCjo1RFdFTqMrblLnLTXLO07E9e9d/J05q4OOaxMHP6EK05+PYdBh
 f2VEE+vpqH2z33fPI94i2c1H8s4BsMg1RyyL5fjnvtPULm3IXA00HlLet0xcnN4mi1s+NwR45vL
 yxRtUI+dUTJwTNuMlyRROjPyNUQnXNF84MmCModhTWrutlR+sAz8kATW6DVEQo9EntI9jI4rmLO
 6hyFVmoG91jvA1xwG698/5IlPdcis=
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr194515825e9.22.1772441127838; 
 Mon, 02 Mar 2026 00:45:27 -0800 (PST)
X-Received: by 2002:a05:600c:6994:b0:477:c478:46d7 with SMTP id
 5b1f17b1804b1-483c9c0b88amr194515415e9.22.1772441127275; 
 Mon, 02 Mar 2026 00:45:27 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd75dfaasm355126635e9.12.2026.03.02.00.45.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>, Dorjoy Chowdhury <dorjoychy111@gmail.com>
Subject: [PULL 040/102] hw/nitro: Enable direct kernel boot
Date: Mon,  2 Mar 2026 09:42:35 +0100
Message-ID: <20260302084338.473368-41-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Nitro Enclaves can only boot EIF files which are a combination of
kernel, initramfs and cmdline in a single file. When the kernel image is
not an EIF, treat it like a kernel image and assemble an EIF image on
the fly. This way, users can call QEMU with a direct
kernel/initrd/cmdline combination and everything "just works".

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Link: https://lore.kernel.org/r/20260225220807.33092-11-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/eif.h        |   3 ++
 hw/nitro/machine.c   | 116 +++++++++++++++++++++++++++++++++++++++++++
 hw/nitro/meson.build |   2 +-
 3 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/hw/core/eif.h b/hw/core/eif.h
index a3412377a90..0c432dbc2dc 100644
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
index e28c8e9bf50..8849959359c 100644
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
 static void nitro_machine_init(MachineState *machine)
 {
     const char *eif_path = machine->kernel_filename;
@@ -74,6 +169,27 @@ static void nitro_machine_init(MachineState *machine)
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
index e3f18958906..b9bd0d43002 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1,4 +1,4 @@
 system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-vsock-bus.c'))
 system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
 system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: files('heartbeat.c'))
-system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: files('machine.c'))
+system_ss.add(when: 'CONFIG_NITRO_MACHINE', if_true: [files('machine.c'), zlib])
-- 
2.53.0


