Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EA9E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 14:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL0o7-0007Cj-NS; Tue, 10 Dec 2024 09:01:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0nx-0007BJ-KN
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:39 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tL0nt-00072v-5W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 09:01:37 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso2997951f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733839291; x=1734444091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HohvXLOuMKpD8+EthZDjFAnvS2ouA/Hip2K84SCEESc=;
 b=pnXlivcA0uO00MfOUiEMCupfmj/BlQVCctDQ1TdaKkJTox3z9D+zzLTRrgsmOlu2qt
 HPmq6SYFhXdE/s0k/C/E0V1d/vzbkuUGpZZp0AxkNQ9kezOO46Gq4GztWVhEyynTL5Vu
 L7Rz6xNk0OortMTHokY6cxQQEqvRu0ExUpR+sRIUh12PtYU7eZWrbGrnVLNAuK9P8zq3
 9Eq2JAbsHEkyxCdqBxHuoNL+ixH32zVXUz7cvOI1WcjDwHu1dJiDv84OymSFYwW+N2te
 FxRMV3TOWYQOyTKdPkENwkm3tckaZsdXDJD5pA9MoQpBOpxGNy0SF9ADTjrDfp4yaKlY
 L0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733839291; x=1734444091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HohvXLOuMKpD8+EthZDjFAnvS2ouA/Hip2K84SCEESc=;
 b=epy3YASIpbyagubUxh2KLxcEsLbccusIsPxlVUk8aszXsrQmuum6UYjHlZiHkfcbLv
 4y6wW2CIm6RpcbFjPmlzn+gQaHbnAhl3V3paTpVNG0y/PKSrzIhv3ibcVCCLJk0L32fE
 FjCyFJOKayGSkBVL/MOKnUGKl8bsnGIE32oUpbk36wNCSth7ZT1C+fiWULFUkLD5DbIt
 lkJPpTOx+9uoD4gCeJJwFwYk0B+6mbwxM9Q1O4cPlc2ehBwzHjuVH9rNUQTXOLOzPnc4
 EmfNinembc01OhbXJAHEHDzZrUGEXZQ0ZhcLDhlFE9MoltwrUNxtA2FpksqVABnzpS2R
 FJyA==
X-Gm-Message-State: AOJu0Yw2P4hythvynHp0VvffD9FeGtBWvZFKq9zZt8r3P/WlvHGJQSjJ
 AuW790+NWggtsQfeyIaUc0Q5h85pgbi25hsp/sYgBrg0g/hmik9V/k6rU9vwNY+5tFfBjO+eGNt
 nNqU=
X-Gm-Gg: ASbGncscfpda0GK8kNfigCk9NK1qoEYzma/R0Ui+8LH9UWCiUmo3iCzoO/Hn7xfiXf4
 jsMUi/ShQ7kvfjGKiFxM4bWa1cwIprYHt/9y4Ofl+4exc3AdGRuwPOHt5eccyOUqNQRobtvAoNw
 fUrKlMulV59RKHs2jf04Msa4TxLApIHtglTmYNPuX6XazCgnTLn2x1FuYAgT+Eg1cvyHfwyeWBv
 //kgBN7RnOkfGpoJFdRkjtcfLGdn8QAmW0wot66T16maNq5mBU5iySyRrGpVkVyXOI+RvVr68Ox
 ML+ioHbo1VzDTZvlF65w4rkz
X-Google-Smtp-Source: AGHT+IErr5fQjEEl+HC0wVLAZOPYjzQrixf4tvsLJzoaiyk8cMbw9MMVBd9pjC2jcQ8PAcpJkAsdww==
X-Received: by 2002:a05:6000:1869:b0:386:3213:5ba1 with SMTP id
 ffacd0b85a97d-386453e10ffmr4746088f8f.24.1733839289706; 
 Tue, 10 Dec 2024 06:01:29 -0800 (PST)
Received: from localhost.localdomain (223.132.22.93.rev.sfr.net.
 [93.22.132.223]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3861f4a85f2sm15772584f8f.29.2024.12.10.06.01.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Dec 2024 06:01:28 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] bulk: Replace legacy cpu_physical_memory_rw() API
Date: Tue, 10 Dec 2024 15:01:11 +0100
Message-ID: <20241210140112.43313-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210140112.43313-1-philmd@linaro.org>
References: <20241210140112.43313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

Use the following coccinelle script:

    @@
    expression addr, buf, len, is_write;
    @@
    (
    - cpu_physical_memory_read(addr, buf, len)
    + address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, buf, len)
    |
    - cpu_physical_memory_rw(addr, buf, len, false)
    + address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, buf, len)
    |
    - cpu_physical_memory_write(addr, buf, len)
    + address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, buf, len)
    |
    - cpu_physical_memory_rw(addr, buf, len, true)
    + address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, buf, len)
    |
    - cpu_physical_memory_rw(addr, buf, len, is_write)
    + address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, buf, len, is_write)
    )

running:

  $ spatch \
           --macro-file scripts/cocci-macro-file.h \
           --sp-file cpu_physical_memory_rw.cocci \
           --keep-comments --in-place --dir .

to mechanically replace cpu_physical_memory_rw() legacy
calls (deprecated since commit b7ecba0f6f6 in 2017) to the
more recent address_space_rw(&address_space_memory) API.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/bootparam.h       |  7 ++-
 accel/kvm/kvm-all.c         |  5 ++-
 dump/dump.c                 |  4 +-
 gdbstub/system.c            |  7 ++-
 hw/acpi/ghes.c              | 19 +++++---
 hw/acpi/nvdimm.c            | 21 ++++++---
 hw/acpi/vmgenid.c           |  6 ++-
 hw/arm/omap1.c              | 18 +++++---
 hw/audio/marvell_88w8618.c  |  4 +-
 hw/char/riscv_htif.c        |  8 +++-
 hw/display/omap_lcdc.c      | 13 +++---
 hw/dma/i8257.c              | 17 ++++---
 hw/dma/omap_dma.c           | 15 ++++---
 hw/dma/rc4030.c             |  3 +-
 hw/dma/sifive_pdma.c        | 13 ++++--
 hw/gpio/zaurus.c            |  5 ++-
 hw/i386/kvm/clock.c         |  4 +-
 hw/i386/vapic.c             | 42 ++++++++++-------
 hw/intc/apic.c              |  6 ++-
 hw/m68k/next-cube.c         |  4 +-
 hw/microblaze/boot.c        |  4 +-
 hw/net/fsl_etsec/rings.c    | 24 +++++-----
 hw/net/mcf_fec.c            | 16 ++++---
 hw/net/opencores_eth.c      | 15 ++++---
 hw/net/xgmac.c              | 13 ++++--
 hw/ppc/e500.c               |  4 +-
 hw/ppc/pegasos2.c           |  6 ++-
 hw/ppc/pnv.c                |  4 +-
 hw/ppc/ppc405_boards.c      |  5 ++-
 hw/ppc/spapr.c              |  4 +-
 hw/ppc/spapr_drc.c          |  7 ++-
 hw/ppc/spapr_events.c       | 21 +++++----
 hw/ppc/spapr_hcall.c        | 15 ++++---
 hw/ppc/spapr_rtas.c         |  7 ++-
 hw/ppc/spapr_tpm_proxy.c    |  7 ++-
 hw/ppc/virtex_ml507.c       |  4 +-
 hw/s390x/css.c              |  6 ++-
 hw/s390x/ipl.c              |  8 ++--
 hw/s390x/sclp.c             | 11 +++--
 hw/scsi/vmw_pvscsi.c        | 16 ++++---
 hw/xen/xen-hvm-common.c     | 10 +++--
 hw/xen/xen_pt_graphics.c    |  4 +-
 hw/xtensa/xtfpga.c          |  7 ++-
 system/cpus.c               |  4 +-
 target/i386/kvm/xen-emu.c   |  3 +-
 target/i386/monitor.c       | 90 +++++++++++++++++++++++++------------
 target/i386/nvmm/nvmm-all.c |  3 +-
 target/i386/whpx/whpx-all.c |  5 ++-
 target/riscv/kvm/kvm-cpu.c  |  6 ++-
 target/riscv/monitor.c      |  4 +-
 target/s390x/diag.c         | 13 ++++--
 target/s390x/helper.c       |  5 ++-
 target/s390x/mmu_helper.c   |  6 ++-
 53 files changed, 390 insertions(+), 188 deletions(-)

diff --git a/hw/xtensa/bootparam.h b/hw/xtensa/bootparam.h
index f57ff850bcb..8c0b948f67b 100644
--- a/hw/xtensa/bootparam.h
+++ b/hw/xtensa/bootparam.h
@@ -1,6 +1,7 @@
 #ifndef HW_XTENSA_BOOTPARAM_H
 #define HW_XTENSA_BOOTPARAM_H
 
+#include "exec/address-spaces.h"
 #include "exec/cpu-common.h"
 
 #define BP_TAG_COMMAND_LINE     0x1001  /* command line (0-terminated string)*/
@@ -40,9 +41,11 @@ static inline ram_addr_t put_tag(ram_addr_t addr, uint16_t tag,
         .size = tswap16((size + 3) & ~3),
     };
 
-    cpu_physical_memory_write(addr, &bp_tag, sizeof(bp_tag));
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        &bp_tag, sizeof(bp_tag));
     addr += sizeof(bp_tag);
-    cpu_physical_memory_write(addr, data, size);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        data, size);
     addr += (size + 3) & ~3;
 
     return addr;
diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 801cff16a5a..a2ea54a9260 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -33,6 +33,7 @@
 #include "sysemu/cpus.h"
 #include "sysemu/accel-blocker.h"
 #include "qemu/bswap.h"
+#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
 #include "qemu/event_notifier.h"
@@ -2839,7 +2840,9 @@ void kvm_flush_coalesced_mmio_buffer(void)
                                     MEMTXATTRS_UNSPECIFIED, ent->data,
                                     ent->len);
             } else {
-                cpu_physical_memory_write(ent->phys_addr, ent->data, ent->len);
+                address_space_write(&address_space_memory, ent->phys_addr,
+                                    MEMTXATTRS_UNSPECIFIED, ent->data,
+                                    ent->len);
             }
             smp_wmb();
             ring->first = (ring->first + 1) % KVM_COALESCED_MMIO_MAX;
diff --git a/dump/dump.c b/dump/dump.c
index 58c57d4e4f5..4a723dd5519 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "qemu/bswap.h"
+#include "exec/address-spaces.h"
 #include "exec/memory.h"
 #include "exec/target_page.h"
 #include "monitor/monitor.h"
@@ -1889,7 +1890,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
             warn_report("guest note format is unsupported: %" PRIu16, guest_format);
         } else {
             s->guest_note = g_malloc(size + 1); /* +1 for adding \0 */
-            cpu_physical_memory_read(addr, s->guest_note, size);
+            address_space_read(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, s->guest_note, size);
 
             get_note_sizes(s, s->guest_note, NULL, &name_size, &desc_size);
             s->guest_note_size = ELF_NOTE_SIZE(note_head_size, name_size,
diff --git a/gdbstub/system.c b/gdbstub/system.c
index c9f236e94f7..7b9518c9bf8 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/cutils.h"
+#include "exec/address-spaces.h"
 #include "exec/gdbstub.h"
 #include "gdbstub/syscalls.h"
 #include "gdbstub/commands.h"
@@ -454,9 +455,11 @@ int gdb_target_memory_rw_debug(CPUState *cpu, hwaddr addr,
 
     if (phy_memory_mode) {
         if (is_write) {
-            cpu_physical_memory_write(addr, buf, len);
+            address_space_write(&address_space_memory, addr,
+                                MEMTXATTRS_UNSPECIFIED, buf, len);
         } else {
-            cpu_physical_memory_read(addr, buf, len);
+            address_space_read(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, buf, len);
         }
         return 0;
     }
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index e9511d9b8f7..4b7e3d83fb5 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
+#include "exec/address-spaces.h"
 
 #define ACPI_GHES_ERRORS_FW_CFG_FILE        "etc/hardware_errors"
 #define ACPI_GHES_DATA_ADDR_FW_CFG_FILE     "etc/hardware_errors_addr"
@@ -224,7 +225,8 @@ static int acpi_ghes_record_mem_error(uint64_t error_block_address,
     acpi_ghes_build_append_mem_cper(block, error_physical_addr);
 
     /* Write the generic error data entry into guest memory */
-    cpu_physical_memory_write(error_block_address, block->data, block->len);
+    address_space_write(&address_space_memory, error_block_address,
+                        MEMTXATTRS_UNSPECIFIED, block->data, block->len);
 
     g_array_free(block, true);
 
@@ -411,16 +413,18 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
             start_addr += source_id * sizeof(uint64_t);
         }
 
-        cpu_physical_memory_read(start_addr, &error_block_addr,
-                                 sizeof(error_block_addr));
+        address_space_read(&address_space_memory, start_addr,
+                           MEMTXATTRS_UNSPECIFIED, &error_block_addr,
+                           sizeof(error_block_addr));
 
         error_block_addr = le64_to_cpu(error_block_addr);
 
         read_ack_register_addr = start_addr +
             ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t);
 
-        cpu_physical_memory_read(read_ack_register_addr,
-                                 &read_ack_register, sizeof(read_ack_register));
+        address_space_read(&address_space_memory, read_ack_register_addr,
+                           MEMTXATTRS_UNSPECIFIED, &read_ack_register,
+                           sizeof(read_ack_register));
 
         /* zero means OSPM does not acknowledge the error */
         if (!read_ack_register) {
@@ -432,8 +436,9 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
              * Clear the Read Ack Register, OSPM will write it to 1 when
              * it acknowledges this error.
              */
-            cpu_physical_memory_write(read_ack_register_addr,
-                &read_ack_register, sizeof(uint64_t));
+            address_space_write(&address_space_memory, read_ack_register_addr,
+                                MEMTXATTRS_UNSPECIFIED, &read_ack_register,
+                                sizeof(uint64_t));
 
             ret = acpi_ghes_record_mem_error(error_block_addr,
                                              physical_address);
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 9ba90806f26..0d1eece1246 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -35,6 +35,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
+#include "exec/address-spaces.h"
 #include "trace.h"
 
 /*
@@ -514,7 +515,8 @@ nvdimm_dsm_function0(uint32_t supported_func, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(func0)),
         .supported_func = cpu_to_le32(supported_func),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &func0, sizeof(func0));
+    address_space_write(&address_space_memory, dsm_mem_addr,
+                        MEMTXATTRS_UNSPECIFIED, &func0, sizeof(func0));
 }
 
 static void
@@ -524,7 +526,8 @@ nvdimm_dsm_no_payload(uint32_t func_ret_status, hwaddr dsm_mem_addr)
         .len = cpu_to_le32(sizeof(out)),
         .func_ret_status = cpu_to_le32(func_ret_status),
     };
-    cpu_physical_memory_write(dsm_mem_addr, &out, sizeof(out));
+    address_space_write(&address_space_memory, dsm_mem_addr,
+                        MEMTXATTRS_UNSPECIFIED, &out, sizeof(out));
 }
 
 #define NVDIMM_DSM_RET_STATUS_SUCCESS        0 /* Success */
@@ -579,7 +582,8 @@ exit:
     read_fit_out->func_ret_status = cpu_to_le32(func_ret_status);
     memcpy(read_fit_out->fit, fit->data + read_fit->offset, read_len);
 
-    cpu_physical_memory_write(dsm_mem_addr, read_fit_out, size);
+    address_space_write(&address_space_memory, dsm_mem_addr,
+                        MEMTXATTRS_UNSPECIFIED, read_fit_out, size);
 
     g_free(read_fit_out);
 }
@@ -665,8 +669,9 @@ static void nvdimm_dsm_label_size(NVDIMMDevice *nvdimm, hwaddr dsm_mem_addr)
     label_size_out.label_size = cpu_to_le32(label_size);
     label_size_out.max_xfer = cpu_to_le32(mxfer);
 
-    cpu_physical_memory_write(dsm_mem_addr, &label_size_out,
-                              sizeof(label_size_out));
+    address_space_write(&address_space_memory, dsm_mem_addr,
+                        MEMTXATTRS_UNSPECIFIED, &label_size_out,
+                        sizeof(label_size_out));
 }
 
 static uint32_t nvdimm_rw_label_data_check(NVDIMMDevice *nvdimm,
@@ -734,7 +739,8 @@ static void nvdimm_dsm_get_label_data(NVDIMMDevice *nvdimm, NvdimmDsmIn *in,
     nvc->read_label_data(nvdimm, get_label_data_out->out_buf,
                          get_label_data->length, get_label_data->offset);
 
-    cpu_physical_memory_write(dsm_mem_addr, get_label_data_out, size);
+    address_space_write(&address_space_memory, dsm_mem_addr,
+                        MEMTXATTRS_UNSPECIFIED, get_label_data_out, size);
     g_free(get_label_data_out);
 }
 
@@ -844,7 +850,8 @@ nvdimm_dsm_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
      * this by copying DSM memory to QEMU local memory.
      */
     in = g_new(NvdimmDsmIn, 1);
-    cpu_physical_memory_read(dsm_mem_addr, in, sizeof(*in));
+    address_space_read(&address_space_memory, dsm_mem_addr,
+                       MEMTXATTRS_UNSPECIFIED, in, sizeof(*in));
 
     in->revision = le32_to_cpu(in->revision);
     in->function = le32_to_cpu(in->function);
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index e63c8af4c3f..a0c895ed15d 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -19,6 +19,7 @@
 #include "hw/nvram/fw_cfg.h"
 #include "hw/qdev-properties.h"
 #include "hw/qdev-properties-system.h"
+#include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 #include "sysemu/reset.h"
 
@@ -155,8 +156,9 @@ static void vmgenid_update_guest(VmGenIdState *vms)
              * in order to implement the "OVMF SDT Header probe suppressor"
              * see docs/specs/vmgenid.txt for more details.
              */
-            cpu_physical_memory_write(vmgenid_addr, guid_le.data,
-                                      sizeof(guid_le.data));
+            address_space_write(&address_space_memory, vmgenid_addr,
+                                MEMTXATTRS_UNSPECIFIED, guid_le.data,
+                                sizeof(guid_le.data));
             /* Send _GPE.E05 event */
             acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
         }
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 25030c7e404..ab4f9d14441 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -54,7 +54,8 @@ uint32_t omap_badwidth_read8(void *opaque, hwaddr addr)
     uint8_t ret;
 
     omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_read(addr, &ret, 1);
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                       &ret, 1);
     return ret;
 }
 
@@ -64,7 +65,8 @@ void omap_badwidth_write8(void *opaque, hwaddr addr,
     uint8_t val8 = value;
 
     omap_log_badwidth(__func__, addr, 1);
-    cpu_physical_memory_write(addr, &val8, 1);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        &val8, 1);
 }
 
 uint32_t omap_badwidth_read16(void *opaque, hwaddr addr)
@@ -72,7 +74,8 @@ uint32_t omap_badwidth_read16(void *opaque, hwaddr addr)
     uint16_t ret;
 
     omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_read(addr, &ret, 2);
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                       &ret, 2);
     return ret;
 }
 
@@ -82,7 +85,8 @@ void omap_badwidth_write16(void *opaque, hwaddr addr,
     uint16_t val16 = value;
 
     omap_log_badwidth(__func__, addr, 2);
-    cpu_physical_memory_write(addr, &val16, 2);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        &val16, 2);
 }
 
 uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
@@ -90,7 +94,8 @@ uint32_t omap_badwidth_read32(void *opaque, hwaddr addr)
     uint32_t ret;
 
     omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_read(addr, &ret, 4);
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                       &ret, 4);
     return ret;
 }
 
@@ -98,7 +103,8 @@ void omap_badwidth_write32(void *opaque, hwaddr addr,
                 uint32_t value)
 {
     omap_log_badwidth(__func__, addr, 4);
-    cpu_physical_memory_write(addr, &value, 4);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        &value, 4);
 }
 
 /* MPU OS timers */
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 28f9af320de..a875ff116ea 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -16,6 +16,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/audio/wm8750.h"
+#include "exec/address-spaces.h"
 #include "audio/audio.h"
 #include "qapi/error.h"
 #include "qemu/module.h"
@@ -86,7 +87,8 @@ static void mv88w8618_audio_callback(void *opaque, int free_out, int free_in)
     if (block_size > 4096) {
         return;
     }
-    cpu_physical_memory_read(s->target_buffer + s->play_pos, buf, block_size);
+    address_space_read(&address_space_memory, s->target_buffer + s->play_pos,
+                       MEMTXATTRS_UNSPECIFIED, buf, block_size);
     mem_buffer = buf;
     if (s->playback_mode & MP_AUDIO_16BIT_SAMPLE) {
         if (s->playback_mode & MP_AUDIO_MONO) {
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index 0345088e8b3..ff31d140780 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -211,12 +211,16 @@ static void htif_handle_tohost_write(HTIFState *s, uint64_t val_written)
                 return;
             } else {
                 uint64_t syscall[8];
-                cpu_physical_memory_read(payload, syscall, sizeof(syscall));
+                address_space_read(&address_space_memory, payload,
+                                   MEMTXATTRS_UNSPECIFIED, syscall,
+                                   sizeof(syscall));
                 if (tswap64(syscall[0]) == PK_SYS_WRITE &&
                     tswap64(syscall[1]) == HTIF_DEV_CONSOLE &&
                     tswap64(syscall[3]) == HTIF_CONSOLE_CMD_PUTC) {
                     uint8_t ch;
-                    cpu_physical_memory_read(tswap64(syscall[2]), &ch, 1);
+                    address_space_read(&address_space_memory,
+                                       tswap64(syscall[2]),
+                                       MEMTXATTRS_UNSPECIFIED, &ch, 1);
                     /*
                      * XXX this blocks entire thread. Rewrite to use
                      * qemu_chr_fe_write and background I/O callbacks
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 3532a801be2..a62aa90d01f 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -23,6 +23,7 @@
 #include "hw/arm/omap.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
+#include "exec/address-spaces.h"
 
 struct omap_lcd_panel_s {
     MemoryRegion *sysmem;
@@ -216,9 +217,9 @@ static void omap_update_display(void *opaque)
 
     frame_offset = 0;
     if (omap_lcd->plm != 2) {
-        cpu_physical_memory_read(
-                omap_lcd->dma->phys_framebuffer[omap_lcd->dma->current_frame],
-                omap_lcd->palette, 0x200);
+        address_space_read(&address_space_memory,
+                           omap_lcd->dma->phys_framebuffer[omap_lcd->dma->current_frame],
+                           MEMTXATTRS_UNSPECIFIED, omap_lcd->palette, 0x200);
         switch (omap_lcd->palette[0] >> 12 & 7) {
         case 3 ... 7:
             frame_offset += 0x200;
@@ -368,9 +369,9 @@ static void omap_lcd_update(struct omap_lcd_panel_s *s) {
     s->dma->phys_framebuffer[1] = s->dma->src_f2_top;
 
     if (s->plm != 2 && !s->palette_done) {
-        cpu_physical_memory_read(
-                            s->dma->phys_framebuffer[s->dma->current_frame],
-                            s->palette, 0x200);
+        address_space_read(&address_space_memory,
+                           s->dma->phys_framebuffer[s->dma->current_frame],
+                           MEMTXATTRS_UNSPECIFIED, s->palette, 0x200);
         s->palette_done = 1;
         omap_lcd_interrupts(s);
     }
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 3e6700e53b0..b71d169b243 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -26,6 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "migration/vmstate.h"
+#include "exec/address-spaces.h"
 #include "hw/dma/i8257.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -413,15 +414,17 @@ static int i8257_dma_read_memory(IsaDma *obj, int nchan, void *buf, int pos,
         int i;
         uint8_t *p = buf;
 
-        cpu_physical_memory_read (addr - pos - len, buf, len);
+        address_space_read(&address_space_memory, addr - pos - len,
+                           MEMTXATTRS_UNSPECIFIED, buf, len);
         /* What about 16bit transfers? */
         for (i = 0; i < len >> 1; i++) {
             uint8_t b = p[len - i - 1];
             p[i] = b;
         }
+    } else {
+        address_space_read(&address_space_memory, addr + pos,
+                           MEMTXATTRS_UNSPECIFIED, buf, len);
     }
-    else
-        cpu_physical_memory_read (addr + pos, buf, len);
 
     return len;
 }
@@ -441,15 +444,17 @@ static int i8257_dma_write_memory(IsaDma *obj, int nchan, void *buf, int pos,
         int i;
         uint8_t *p = buf;
 
-        cpu_physical_memory_write (addr - pos - len, buf, len);
+        address_space_write(&address_space_memory, addr - pos - len,
+                            MEMTXATTRS_UNSPECIFIED, buf, len);
         /* What about 16bit transfers? */
         for (i = 0; i < len; i++) {
             uint8_t b = p[len - i - 1];
             p[i] = b;
         }
+    } else {
+        address_space_write(&address_space_memory, addr + pos,
+                            MEMTXATTRS_UNSPECIFIED, buf, len);
     }
-    else
-        cpu_physical_memory_write (addr + pos, buf, len);
 
     return len;
 }
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 9a8c3c34a07..8836310af13 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -23,6 +23,7 @@
 #include "hw/arm/omap.h"
 #include "hw/irq.h"
 #include "hw/arm/soc_dma.h"
+#include "exec/address-spaces.h"
 
 struct omap_dma_channel_s {
     /* transfer data */
@@ -379,13 +380,17 @@ static void omap_dma_transfer_generic(struct soc_dma_ch_s *dma)
     do {
         /* Transfer a single element */
         /* FIXME: check the endianness */
-        if (!ch->constant_fill)
-            cpu_physical_memory_read(a->src, value, ch->data_type);
-        else
+        if (!ch->constant_fill) {
+            address_space_read(&address_space_memory, a->src,
+                               MEMTXATTRS_UNSPECIFIED, value, ch->data_type);
+        } else {
             *(uint32_t *) value = ch->color;
+        }
 
-        if (!ch->transparent_copy || *(uint32_t *) value != ch->color)
-            cpu_physical_memory_write(a->dest, value, ch->data_type);
+        if (!ch->transparent_copy || *(uint32_t *) value != ch->color) {
+            address_space_write(&address_space_memory, a->dest,
+                                MEMTXATTRS_UNSPECIFIED, value, ch->data_type);
+        }
 
         a->src += a->elem_delta[0];
         a->dest += a->elem_delta[1];
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 5bf54347ed4..478ee0d5ffe 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -302,7 +302,8 @@ static void rc4030_write(void *opaque, hwaddr addr, uint64_t data,
         if (s->cache_ltag == 0x80000001 && s->cache_bmask == 0xf0f0f0f) {
             hwaddr dest = s->cache_ptag & ~0x1;
             dest += (s->cache_maint & 0x3) << 3;
-            cpu_physical_memory_write(dest, &val, 4);
+            address_space_write(&address_space_memory, dest,
+                                MEMTXATTRS_UNSPECIFIED, &val, 4);
         }
         break;
     /* Remote Speed Registers */
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 1dd88f3479d..7142058a667 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -27,6 +27,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
+#include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 #include "sysemu/dma.h"
 #include "hw/dma/sifive_pdma.h"
@@ -120,16 +121,20 @@ static void sifive_pdma_run(SiFivePDMAState *s, int ch)
     s->chan[ch].exec_src = src;
 
     for (n = 0; n < bytes / size; n++) {
-        cpu_physical_memory_read(s->chan[ch].exec_src, buf, size);
-        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, size);
+        address_space_read(&address_space_memory, s->chan[ch].exec_src,
+                           MEMTXATTRS_UNSPECIFIED, buf, size);
+        address_space_write(&address_space_memory, s->chan[ch].exec_dst,
+                            MEMTXATTRS_UNSPECIFIED, buf, size);
         s->chan[ch].exec_src += size;
         s->chan[ch].exec_dst += size;
         s->chan[ch].exec_bytes -= size;
     }
 
     if (remainder) {
-        cpu_physical_memory_read(s->chan[ch].exec_src, buf, remainder);
-        cpu_physical_memory_write(s->chan[ch].exec_dst, buf, remainder);
+        address_space_read(&address_space_memory, s->chan[ch].exec_src,
+                           MEMTXATTRS_UNSPECIFIED, buf, remainder);
+        address_space_write(&address_space_memory, s->chan[ch].exec_dst,
+                            MEMTXATTRS_UNSPECIFIED, buf, remainder);
         s->chan[ch].exec_src += remainder;
         s->chan[ch].exec_dst += remainder;
         s->chan[ch].exec_bytes -= remainder;
diff --git a/hw/gpio/zaurus.c b/hw/gpio/zaurus.c
index 7342440b958..6ccc0a216db 100644
--- a/hw/gpio/zaurus.c
+++ b/hw/gpio/zaurus.c
@@ -20,6 +20,7 @@
 #include "hw/irq.h"
 #include "hw/arm/sharpsl.h"
 #include "hw/sysbus.h"
+#include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
@@ -303,6 +304,6 @@ static struct QEMU_PACKED sl_param_info {
 
 void sl_bootparam_write(hwaddr ptr)
 {
-    cpu_physical_memory_write(ptr, &zaurus_bootparam,
-                              sizeof(struct sl_param_info));
+    address_space_write(&address_space_memory, ptr, MEMTXATTRS_UNSPECIFIED,
+                        &zaurus_bootparam, sizeof(struct sl_param_info));
 }
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 40aa9a32c32..c3b87dd7f57 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -21,6 +21,7 @@
 #include "sysemu/hw_accel.h"
 #include "kvm/kvm_i386.h"
 #include "migration/vmstate.h"
+#include "exec/address-spaces.h"
 #include "hw/sysbus.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/qdev-properties.h"
@@ -83,7 +84,8 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     }
 
     kvmclock_struct_pa = env->system_time_msr & ~1ULL;
-    cpu_physical_memory_read(kvmclock_struct_pa, &time, sizeof(time));
+    address_space_read(&address_space_memory, kvmclock_struct_pa,
+                       MEMTXATTRS_UNSPECIFIED, &time, sizeof(time));
 
     assert(time.tsc_timestamp <= migration_tsc);
     delta = migration_tsc - time.tsc_timestamp;
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index ef7f8b967f3..da50d921bed 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -135,14 +135,16 @@ static const TPRInstruction tpr_instr[] = {
 
 static void read_guest_rom_state(VAPICROMState *s)
 {
-    cpu_physical_memory_read(s->rom_state_paddr, &s->rom_state,
-                             sizeof(GuestROMState));
+    address_space_read(&address_space_memory, s->rom_state_paddr,
+                       MEMTXATTRS_UNSPECIFIED, &s->rom_state,
+                       sizeof(GuestROMState));
 }
 
 static void write_guest_rom_state(VAPICROMState *s)
 {
-    cpu_physical_memory_write(s->rom_state_paddr, &s->rom_state,
-                              sizeof(GuestROMState));
+    address_space_write(&address_space_memory, s->rom_state_paddr,
+                        MEMTXATTRS_UNSPECIFIED, &s->rom_state,
+                        sizeof(GuestROMState));
 }
 
 static void update_guest_rom_state(VAPICROMState *s)
@@ -322,14 +324,17 @@ static int update_rom_mapping(VAPICROMState *s, CPUX86State *env, target_ulong i
     for (pos = le32_to_cpu(s->rom_state.fixup_start);
          pos < le32_to_cpu(s->rom_state.fixup_end);
          pos += 4) {
-        cpu_physical_memory_read(paddr + pos - s->rom_state.vaddr,
-                                 &offset, sizeof(offset));
+        address_space_read(&address_space_memory,
+                           paddr + pos - s->rom_state.vaddr,
+                           MEMTXATTRS_UNSPECIFIED, &offset, sizeof(offset));
         offset = le32_to_cpu(offset);
-        cpu_physical_memory_read(paddr + offset, &patch, sizeof(patch));
+        address_space_read(&address_space_memory, paddr + offset,
+                           MEMTXATTRS_UNSPECIFIED, &patch, sizeof(patch));
         patch = le32_to_cpu(patch);
         patch += rom_state_vaddr - le32_to_cpu(s->rom_state.vaddr);
         patch = cpu_to_le32(patch);
-        cpu_physical_memory_write(paddr + offset, &patch, sizeof(patch));
+        address_space_write(&address_space_memory, paddr + offset,
+                            MEMTXATTRS_UNSPECIFIED, &patch, sizeof(patch));
     }
     read_guest_rom_state(s);
     s->vapic_paddr = paddr + le32_to_cpu(s->rom_state.vapic_vaddr) -
@@ -373,8 +378,9 @@ static int vapic_enable(VAPICROMState *s, X86CPU *cpu)
     }
     vapic_paddr = s->vapic_paddr +
         (((hwaddr)cpu_number) << VAPIC_CPU_SHIFT);
-    cpu_physical_memory_write(vapic_paddr + offsetof(VAPICState, enabled),
-                              &enabled, sizeof(enabled));
+    address_space_write(&address_space_memory,
+                        vapic_paddr + offsetof(VAPICState, enabled),
+                        MEMTXATTRS_UNSPECIFIED, &enabled, sizeof(enabled));
     apic_enable_vapic(cpu->apic_state, vapic_paddr);
 
     s->state = VAPIC_ACTIVE;
@@ -544,7 +550,8 @@ static int patch_hypercalls(VAPICROMState *s)
     uint8_t *rom;
 
     rom = g_malloc(s->rom_size);
-    cpu_physical_memory_read(rom_paddr, rom, s->rom_size);
+    address_space_read(&address_space_memory, rom_paddr,
+                       MEMTXATTRS_UNSPECIFIED, rom, s->rom_size);
 
     for (pos = 0; pos < s->rom_size - sizeof(vmcall_pattern); pos++) {
         if (kvm_irqchip_in_kernel()) {
@@ -560,7 +567,8 @@ static int patch_hypercalls(VAPICROMState *s)
         }
         if (memcmp(rom + pos, pattern, 7) == 0 &&
             (rom[pos + 7] == alternates[0] || rom[pos + 7] == alternates[1])) {
-            cpu_physical_memory_write(rom_paddr + pos + 5, patch, 3);
+            address_space_write(&address_space_memory, rom_paddr + pos + 5,
+                                MEMTXATTRS_UNSPECIFIED, patch, 3);
             /*
              * Don't flush the tb here. Under ordinary conditions, the patched
              * calls are miles away from the current IP. Under malicious
@@ -741,8 +749,9 @@ static void do_vapic_enable(CPUState *cs, run_on_cpu_data data)
     X86CPU *cpu = X86_CPU(cs);
 
     static const uint8_t enabled = 1;
-    cpu_physical_memory_write(s->vapic_paddr + offsetof(VAPICState, enabled),
-                              &enabled, sizeof(enabled));
+    address_space_write(&address_space_memory,
+                        s->vapic_paddr + offsetof(VAPICState, enabled),
+                        MEMTXATTRS_UNSPECIFIED, &enabled, sizeof(enabled));
     apic_enable_vapic(cpu->apic_state, s->vapic_paddr);
     s->state = VAPIC_ACTIVE;
 }
@@ -762,8 +771,9 @@ static void vapic_vm_state_change(void *opaque, bool running, RunState state)
             run_on_cpu(first_cpu, do_vapic_enable, RUN_ON_CPU_HOST_PTR(s));
         } else {
             zero = g_malloc0(s->rom_state.vapic_size);
-            cpu_physical_memory_write(s->vapic_paddr, zero,
-                                      s->rom_state.vapic_size);
+            address_space_write(&address_space_memory, s->vapic_paddr,
+                                MEMTXATTRS_UNSPECIFIED, zero,
+                                s->rom_state.vapic_size);
             g_free(zero);
         }
     }
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index 4186c57b34c..7b3b806d780 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -29,6 +29,7 @@
 #include "sysemu/kvm.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
+#include "exec/address-spaces.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
@@ -105,8 +106,9 @@ static void apic_sync_vapic(APICCommonState *s, int sync_type)
         return;
     }
     if (sync_type & SYNC_FROM_VAPIC) {
-        cpu_physical_memory_read(s->vapic_paddr, &vapic_state,
-                                 sizeof(vapic_state));
+        address_space_read(&address_space_memory, s->vapic_paddr,
+                           MEMTXATTRS_UNSPECIFIED, &vapic_state,
+                           sizeof(vapic_state));
         s->tpr = vapic_state.tpr;
     }
     if (sync_type & (SYNC_TO_VAPIC | SYNC_ISR_IRR_TO_VAPIC)) {
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 08886d432c8..0cae462e92a 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -28,6 +28,7 @@
 #include "ui/console.h"
 #include "target/m68k/cpu.h"
 #include "migration/vmstate.h"
+#include "exec/address-spaces.h"
 
 /* #define DEBUG_NEXT */
 #ifdef DEBUG_NEXT
@@ -784,7 +785,8 @@ static void nextdma_write(void *opaque, uint8_t *buf, int size, int type)
         base_addr = next_state->dma[type].next_initbuf;
     }
 
-    cpu_physical_memory_write(base_addr, buf, size);
+    address_space_write(&address_space_memory, base_addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, size);
 
     next_state->dma[type].next_initbuf = 0;
 
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index ed61e483ee8..179441436d9 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -37,6 +37,7 @@
 #include "hw/loader.h"
 #include "elf.h"
 #include "qemu/cutils.h"
+#include "exec/address-spaces.h"
 
 #include "boot.h"
 
@@ -104,7 +105,8 @@ static int microblaze_load_dtb(hwaddr addr,
                               initrd_end);
     }
 
-    cpu_physical_memory_write(addr, fdt, fdt_size);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        fdt, fdt_size);
     g_free(fdt);
     return fdt_size;
 }
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 42216de6c9a..17520460f32 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "etsec.h"
 #include "registers.h"
+#include "exec/address-spaces.h"
 
 /* #define ETSEC_RING_DEBUG */
 /* #define HEX_DUMP */
@@ -110,9 +111,8 @@ static void read_buffer_descriptor(eTSEC         *etsec,
     assert(bd != NULL);
 
     RING_DEBUG("READ Buffer Descriptor @ 0x" HWADDR_FMT_plx"\n", addr);
-    cpu_physical_memory_read(addr,
-                             bd,
-                             sizeof(eTSEC_rxtx_bd));
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                       bd, sizeof(eTSEC_rxtx_bd));
 
     if (etsec->regs[DMACTRL].value & DMACTRL_LE) {
         bd->flags  = lduw_le_p(&bd->flags);
@@ -142,9 +142,8 @@ static void write_buffer_descriptor(eTSEC         *etsec,
     }
 
     RING_DEBUG("Write Buffer Descriptor @ 0x" HWADDR_FMT_plx"\n", addr);
-    cpu_physical_memory_write(addr,
-                              bd,
-                              sizeof(eTSEC_rxtx_bd));
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        bd, sizeof(eTSEC_rxtx_bd));
 }
 
 static void ievent_set(eTSEC    *etsec,
@@ -239,7 +238,8 @@ static void process_tx_bd(eTSEC         *etsec,
     etsec->tx_buffer = g_realloc(etsec->tx_buffer,
                                     etsec->tx_buffer_len + bd->length);
     tmp_buff = etsec->tx_buffer + etsec->tx_buffer_len;
-    cpu_physical_memory_read(bd->bufptr + tbdbth, tmp_buff, bd->length);
+    address_space_read(&address_space_memory, bd->bufptr + tbdbth,
+                       MEMTXATTRS_UNSPECIFIED, tmp_buff, bd->length);
 
     /* Update buffer length */
     etsec->tx_buffer_len += bd->length;
@@ -400,7 +400,9 @@ static void fill_rx_bd(eTSEC          *etsec,
     /* This operation will only write FCB */
     if (etsec->rx_fcb_size != 0) {
 
-        cpu_physical_memory_write(bufptr, etsec->rx_fcb, etsec->rx_fcb_size);
+        address_space_write(&address_space_memory, bufptr,
+                            MEMTXATTRS_UNSPECIFIED, etsec->rx_fcb,
+                            etsec->rx_fcb_size);
 
         bufptr             += etsec->rx_fcb_size;
         bd->length         += etsec->rx_fcb_size;
@@ -416,7 +418,8 @@ static void fill_rx_bd(eTSEC          *etsec,
 
     /* This operation can only write packet data and no padding */
     if (to_write > 0) {
-        cpu_physical_memory_write(bufptr, *buf, to_write);
+        address_space_write(&address_space_memory, bufptr,
+                            MEMTXATTRS_UNSPECIFIED, *buf, to_write);
 
         *buf   += to_write;
         bufptr += to_write;
@@ -438,7 +441,8 @@ static void fill_rx_bd(eTSEC          *etsec,
             etsec->rx_padding -= rem;
             *size             -= rem;
             bd->length        += rem;
-            cpu_physical_memory_write(bufptr, padd, rem);
+            address_space_write(&address_space_memory, bufptr,
+                                MEMTXATTRS_UNSPECIFIED, padd, rem);
         }
     }
 }
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 037cd2028ea..da4702f4ade 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -16,6 +16,7 @@
 #include "hw/net/mii.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
+#include "exec/address-spaces.h"
 #include <zlib.h> /* for crc32 */
 
 //#define DEBUG_FEC 1
@@ -174,7 +175,8 @@ typedef struct {
 
 static void mcf_fec_read_bd(mcf_fec_bd *bd, uint32_t addr)
 {
-    cpu_physical_memory_read(addr, bd, sizeof(*bd));
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                       bd, sizeof(*bd));
     be16_to_cpus(&bd->flags);
     be16_to_cpus(&bd->length);
     be32_to_cpus(&bd->data);
@@ -186,7 +188,8 @@ static void mcf_fec_write_bd(mcf_fec_bd *bd, uint32_t addr)
     tmp.flags = cpu_to_be16(bd->flags);
     tmp.length = cpu_to_be16(bd->length);
     tmp.data = cpu_to_be32(bd->data);
-    cpu_physical_memory_write(addr, &tmp, sizeof(tmp));
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        &tmp, sizeof(tmp));
 }
 
 static void mcf_fec_update(mcf_fec_state *s)
@@ -259,7 +262,8 @@ static void mcf_fec_do_tx(mcf_fec_state *s)
             len = FEC_MAX_FRAME_SIZE - frame_size;
             s->eir |= FEC_INT_BABT;
         }
-        cpu_physical_memory_read(bd.data, ptr, len);
+        address_space_read(&address_space_memory, bd.data,
+                           MEMTXATTRS_UNSPECIFIED, ptr, len);
         ptr += len;
         frame_size += len;
         if (bd.flags & FEC_BD_L) {
@@ -595,10 +599,12 @@ static ssize_t mcf_fec_receive(NetClientState *nc, const uint8_t *buf, size_t si
         if (size < 4)
             buf_len += size - 4;
         buf_addr = bd.data;
-        cpu_physical_memory_write(buf_addr, buf, buf_len);
+        address_space_write(&address_space_memory, buf_addr,
+                            MEMTXATTRS_UNSPECIFIED, buf, buf_len);
         buf += buf_len;
         if (size < 4) {
-            cpu_physical_memory_write(buf_addr + buf_len, crc_ptr, 4 - size);
+            address_space_write(&address_space_memory, buf_addr + buf_len,
+                                MEMTXATTRS_UNSPECIFIED, crc_ptr, 4 - size);
             crc_ptr += 4 - size;
         }
         bd.flags &= ~FEC_BD_E;
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 2c0ebda100a..9a9f967897f 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -41,6 +41,7 @@
 #include "net/eth.h"
 #include "trace.h"
 #include "qom/object.h"
+#include "exec/address-spaces.h"
 
 /* RECSMALL is not used because it breaks tap networking in linux:
  * incoming ARP responses are too short
@@ -430,7 +431,8 @@ static ssize_t open_eth_receive(NetClientState *nc,
         }
 #endif
 
-        cpu_physical_memory_write(desc->buf_ptr, buf, copy_size);
+        address_space_write(&address_space_memory, desc->buf_ptr,
+                            MEMTXATTRS_UNSPECIFIED, buf, copy_size);
 
         if (GET_REGBIT(s, MODER, PAD) && copy_size < minfl) {
             if (minfl - copy_size > fcsl) {
@@ -442,8 +444,9 @@ static ssize_t open_eth_receive(NetClientState *nc,
                 size_t zero_sz = minfl - copy_size < sizeof(zero) ?
                     minfl - copy_size : sizeof(zero);
 
-                cpu_physical_memory_write(desc->buf_ptr + copy_size,
-                        zero, zero_sz);
+                address_space_write(&address_space_memory,
+                                    desc->buf_ptr + copy_size,
+                                    MEMTXATTRS_UNSPECIFIED, zero, zero_sz);
                 copy_size += zero_sz;
             }
         }
@@ -452,7 +455,8 @@ static ssize_t open_eth_receive(NetClientState *nc,
          * Don't do it if the frame is cut at the MAXFL or padded with 4 or
          * more bytes to the MINFL.
          */
-        cpu_physical_memory_write(desc->buf_ptr + copy_size, zero, fcsl);
+        address_space_write(&address_space_memory, desc->buf_ptr + copy_size,
+                            MEMTXATTRS_UNSPECIFIED, zero, fcsl);
         copy_size += fcsl;
 
         SET_FIELD(desc->len_flags, RXD_LEN, copy_size);
@@ -508,7 +512,8 @@ static void open_eth_start_xmit(OpenEthState *s, desc *tx)
     if (len > tx_len) {
         len = tx_len;
     }
-    cpu_physical_memory_read(tx->buf_ptr, buf, len);
+    address_space_read(&address_space_memory, tx->buf_ptr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
     if (tx_len > len) {
         memset(buf + len, 0, tx_len - len);
     }
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index ffe3fc8dbef..8966e9633c9 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -28,6 +28,7 @@
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
+#include "exec/address-spaces.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "net/net.h"
@@ -184,7 +185,8 @@ static void xgmac_read_desc(XgmacState *s, struct desc *d, int rx)
 {
     uint32_t addr = rx ? s->regs[DMA_CUR_RX_DESC_ADDR] :
         s->regs[DMA_CUR_TX_DESC_ADDR];
-    cpu_physical_memory_read(addr, d, sizeof(*d));
+    address_space_read(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, d,
+                       sizeof(*d));
 }
 
 static void xgmac_write_desc(XgmacState *s, struct desc *d, int rx)
@@ -199,7 +201,8 @@ static void xgmac_write_desc(XgmacState *s, struct desc *d, int rx)
     } else {
         s->regs[reg] += sizeof(*d);
     }
-    cpu_physical_memory_write(addr, d, sizeof(*d));
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        d, sizeof(*d));
 }
 
 static void xgmac_enet_send(XgmacState *s)
@@ -247,7 +250,8 @@ static void xgmac_enet_send(XgmacState *s)
             break;
         }
 
-        cpu_physical_memory_read(bd.buffer1_addr, ptr, len);
+        address_space_read(&address_space_memory, bd.buffer1_addr,
+                           MEMTXATTRS_UNSPECIFIED, ptr, len);
         ptr += len;
         frame_size += len;
         if (bd.ctl_stat & 0x20000000) {
@@ -359,7 +363,8 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
         goto out;
     }
 
-    cpu_physical_memory_write(bd.buffer1_addr, buf, size);
+    address_space_write(&address_space_memory, bd.buffer1_addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, size);
 
     /* Add in the 4 bytes for crc (the real hw returns length incl crc) */
     size += 4;
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 46261223f3c..32bd230a47b 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -19,6 +19,7 @@
 #include "qemu/units.h"
 #include "qemu/guest-random.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "e500.h"
 #include "e500-ccsr.h"
 #include "net/net.h"
@@ -659,7 +660,8 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
 done:
     if (!dry_run) {
         qemu_fdt_dumpdtb(fdt, fdt_size);
-        cpu_physical_memory_write(addr, fdt, fdt_size);
+        address_space_write(&address_space_memory, addr,
+                            MEMTXATTRS_UNSPECIFIED, fdt, fdt_size);
 
         /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
         g_free(machine->fdt);
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index 16abeaac824..27a6851d582 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -315,8 +315,10 @@ static void pegasos2_pci_config_write(Pegasos2MachineState *pm, int bus,
 
 static void pegasos2_superio_write(uint8_t addr, uint8_t val)
 {
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f0, &addr, 1);
-    cpu_physical_memory_write(PCI1_IO_BASE + 0x3f1, &val, 1);
+    address_space_write(&address_space_memory, PCI1_IO_BASE + 0x3f0,
+                        MEMTXATTRS_UNSPECIFIED, &addr, 1);
+    address_space_write(&address_space_memory, PCI1_IO_BASE + 0x3f1,
+                        MEMTXATTRS_UNSPECIFIED, &val, 1);
 }
 
 static void pegasos2_machine_reset(MachineState *machine, ResetType type)
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f0f0d7567da..91c4bbc8c6b 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -40,6 +40,7 @@
 #include "qapi/visitor.h"
 #include "hw/intc/intc.h"
 #include "hw/ipmi/ipmi.h"
+#include "exec/address-spaces.h"
 #include "target/ppc/mmu-hash64.h"
 #include "hw/pci/msi.h"
 #include "hw/pci-host/pnv_phb.h"
@@ -745,7 +746,8 @@ static void pnv_reset(MachineState *machine, ResetType type)
     }
 
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
-    cpu_physical_memory_write(PNV_FDT_ADDR, fdt, fdt_totalsize(fdt));
+    address_space_write(&address_space_memory, PNV_FDT_ADDR,
+                        MEMTXATTRS_UNSPECIFIED, fdt, fdt_totalsize(fdt));
 
     /* Update machine->fdt with latest fdt */
     if (machine->fdt != fdt) {
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index 347428e6330..7d56eb61cbc 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
+#include "exec/address-spaces.h"
 #include "cpu.h"
 #include "hw/ppc/ppc.h"
 #include "hw/qdev-properties.h"
@@ -258,7 +259,9 @@ static void boot_from_kernel(MachineState *machine, PowerPCCPU *cpu)
     if (machine->kernel_cmdline) {
         len = strlen(machine->kernel_cmdline);
         bdloc -= ((len + 255) & ~255);
-        cpu_physical_memory_write(bdloc, machine->kernel_cmdline, len + 1);
+        address_space_write(&address_space_memory, bdloc,
+                            MEMTXATTRS_UNSPECIFIED, machine->kernel_cmdline,
+                            len + 1);
         boot_info.cmdline_base = bdloc;
         boot_info.cmdline_size = bdloc + len;
     }
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 0d4efaa0c09..df69da15674 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -46,6 +46,7 @@
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
 #include "sysemu/hw_accel.h"
+#include "exec/address-spaces.h"
 #include "kvm_ppc.h"
 #include "migration/misc.h"
 #include "migration/qemu-file-types.h"
@@ -1758,7 +1759,8 @@ static void spapr_machine_reset(MachineState *machine, ResetType type)
 
         spapr_cpu_set_entry_state(first_ppc_cpu, SPAPR_ENTRY_POINT,
                                   0, fdt_addr, 0);
-        cpu_physical_memory_write(fdt_addr, fdt, fdt_totalsize(fdt));
+        address_space_write(&address_space_memory, fdt_addr,
+                            MEMTXATTRS_UNSPECIFIED, fdt, fdt_totalsize(fdt));
     }
     qemu_fdt_dumpdtb(fdt, fdt_totalsize(fdt));
 
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index 1484e3209d9..de8a600c676 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -14,6 +14,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qnull.h"
 #include "qemu/cutils.h"
+#include "exec/address-spaces.h"
 #include "hw/ppc/spapr_drc.h"
 #include "qom/object.h"
 #include "migration/vmstate.h"
@@ -1140,8 +1141,10 @@ out:
 static void configure_connector_st(target_ulong addr, target_ulong offset,
                                    const void *buf, size_t len)
 {
-    cpu_physical_memory_write(ppc64_phys_to_real(addr + offset),
-                              buf, MIN(len, CC_WA_LEN - offset));
+    address_space_write(&address_space_memory,
+                        ppc64_phys_to_real(addr + offset),
+                        MEMTXATTRS_UNSPECIFIED, buf,
+                        MIN(len, CC_WA_LEN - offset));
 }
 
 static void rtas_ibm_configure_connector(PowerPCCPU *cpu,
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4dbf8e2e2ef..0cf5565925a 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/runstate.h"
+#include "exec/address-spaces.h"
 
 #include "hw/ppc/fdt.h"
 #include "hw/ppc/spapr.h"
@@ -854,11 +855,13 @@ static void spapr_mce_dispatch_elog(SpaprMachineState *spapr, PowerPCCPU *cpu,
 
     stq_be_phys(&address_space_memory, rtas_addr + RTAS_ERROR_LOG_OFFSET,
                 env->gpr[3]);
-    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
-                              sizeof(env->gpr[3]), &log, sizeof(log));
-    cpu_physical_memory_write(rtas_addr + RTAS_ERROR_LOG_OFFSET +
-                              sizeof(env->gpr[3]) + sizeof(log), ext_elog,
-                              sizeof(*ext_elog));
+    address_space_write(&address_space_memory,
+                        rtas_addr + RTAS_ERROR_LOG_OFFSET + sizeof(env->gpr[3]),
+                        MEMTXATTRS_UNSPECIFIED, &log, sizeof(log));
+    address_space_write(&address_space_memory,
+                        rtas_addr + RTAS_ERROR_LOG_OFFSET
+                                  + sizeof(env->gpr[3]) + sizeof(log),
+                        MEMTXATTRS_UNSPECIFIED, ext_elog, sizeof(*ext_elog));
     g_free(ext_elog);
 
     env->gpr[3] = rtas_addr + RTAS_ERROR_LOG_OFFSET;
@@ -963,9 +966,11 @@ static void check_exception(PowerPCCPU *cpu, SpaprMachineState *spapr,
 
     header.summary = cpu_to_be32(event->summary);
     header.extended_length = cpu_to_be32(event->extended_length);
-    cpu_physical_memory_write(buf, &header, sizeof(header));
-    cpu_physical_memory_write(buf + sizeof(header), event->extended_log,
-                              event->extended_length);
+    address_space_write(&address_space_memory, buf, MEMTXATTRS_UNSPECIFIED,
+                        &header, sizeof(header));
+    address_space_write(&address_space_memory, buf + sizeof(header),
+                        MEMTXATTRS_UNSPECIFIED, event->extended_log,
+                        event->extended_length);
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
     g_free(event->extended_log);
     g_free(event);
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 5e1d020e3df..c0196aa4035 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
@@ -1360,9 +1361,11 @@ static target_ulong h_client_architecture_support(PowerPCCPU *cpu,
         spapr->fdt_size = fdt_totalsize(spapr->fdt_blob);
         spapr->fdt_initial_size = spapr->fdt_size;
 
-        cpu_physical_memory_write(fdt_buf, &hdr, sizeof(hdr));
-        cpu_physical_memory_write(fdt_buf + sizeof(hdr), spapr->fdt_blob,
-                                  spapr->fdt_size);
+        address_space_write(&address_space_memory, fdt_buf,
+                            MEMTXATTRS_UNSPECIFIED, &hdr, sizeof(hdr));
+        address_space_write(&address_space_memory, fdt_buf + sizeof(hdr),
+                            MEMTXATTRS_UNSPECIFIED, spapr->fdt_blob,
+                            spapr->fdt_size);
         trace_spapr_cas_continue(spapr->fdt_size + sizeof(hdr));
     }
 
@@ -1466,7 +1469,8 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     SpaprMachineClass *smc = SPAPR_MACHINE_GET_CLASS(spapr);
     void *fdt;
 
-    cpu_physical_memory_read(dt, &hdr, sizeof(hdr));
+    address_space_read(&address_space_memory, dt, MEMTXATTRS_UNSPECIFIED,
+                       &hdr, sizeof(hdr));
     cb = fdt32_to_cpu(hdr.totalsize);
 
     if (!smc->update_dt_enabled) {
@@ -1481,7 +1485,8 @@ static target_ulong h_update_dt(PowerPCCPU *cpu, SpaprMachineState *spapr,
     }
 
     fdt = g_malloc0(cb);
-    cpu_physical_memory_read(dt, fdt, cb);
+    address_space_read(&address_space_memory, dt, MEMTXATTRS_UNSPECIFIED, fdt,
+                       cb);
 
     /* Check the fdt consistency */
     if (fdt_check_full(fdt, cb)) {
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index f329693c554..ec3ac828dcd 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
+#include "exec/address-spaces.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/device_tree.h"
 #include "sysemu/cpus.h"
@@ -260,7 +261,8 @@ static inline int sysparm_st(target_ulong addr, target_ulong len,
         return RTAS_OUT_SYSPARM_PARAM_ERROR;
     }
     stw_be_phys(&address_space_memory, phys, vallen);
-    cpu_physical_memory_write(phys + 2, val, MIN(len - 2, vallen));
+    address_space_write(&address_space_memory, phys + 2,
+                        MEMTXATTRS_UNSPECIFIED, val, MIN(len - 2, vallen));
     return RTAS_OUT_SUCCESS;
 }
 
@@ -350,7 +352,8 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
     target_ulong msgaddr = rtas_ld(args, 0);
     char msg[512];
 
-    cpu_physical_memory_read(msgaddr, msg, sizeof(msg) - 1);
+    address_space_read(&address_space_memory, msgaddr, MEMTXATTRS_UNSPECIFIED,
+                       msg, sizeof(msg) - 1);
     msg[sizeof(msg) - 1] = 0;
 
     error_report("OS terminated: %s", msg);
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index e10af35a185..101d85020f5 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
+#include "exec/address-spaces.h"
 #include "sysemu/reset.h"
 #include "hw/ppc/spapr.h"
 #include "hw/qdev-properties.h"
@@ -68,7 +69,8 @@ static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
         }
     }
 
-    cpu_physical_memory_read(data_in, buf_in, data_in_size);
+    address_space_read(&address_space_memory, data_in, MEMTXATTRS_UNSPECIFIED,
+                       buf_in, data_in_size);
 
     do {
         ret = write(tpm_proxy->host_fd, buf_in, data_in_size);
@@ -93,7 +95,8 @@ static ssize_t tpm_execute(SpaprTpmProxy *tpm_proxy, target_ulong *args)
         return H_RESOURCE;
     }
 
-    cpu_physical_memory_write(data_out, buf_out, ret);
+    address_space_write(&address_space_memory, data_out,
+                        MEMTXATTRS_UNSPECIFIED, buf_out, ret);
     args[0] = ret;
 
     return H_SUCCESS;
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index f378e5c4a90..995b6de7d88 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qemu/units.h"
+#include "exec/address-spaces.h"
 #include "exec/page-protection.h"
 #include "cpu.h"
 #include "hw/sysbus.h"
@@ -173,7 +174,8 @@ static int xilinx_load_device_tree(MachineState *machine,
                                 machine->kernel_cmdline);
     if (r < 0)
         fprintf(stderr, "couldn't set /chosen/bootargs\n");
-    cpu_physical_memory_write(addr, fdt, fdt_size);
+    address_space_write(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
+                        fdt, fdt_size);
 
     /* Set machine->fdt for 'dumpdtb' QMP/HMP command */
     machine->fdt = fdt;
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index b2d5327dbf4..ba53312ebbf 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -782,13 +782,15 @@ static CCW1 copy_ccw_from_guest(hwaddr addr, bool fmt1)
     CCW1 ret;
 
     if (fmt1) {
-        cpu_physical_memory_read(addr, &tmp1, sizeof(tmp1));
+        address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, &tmp1, sizeof(tmp1));
         ret.cmd_code = tmp1.cmd_code;
         ret.flags = tmp1.flags;
         ret.count = be16_to_cpu(tmp1.count);
         ret.cda = be32_to_cpu(tmp1.cda);
     } else {
-        cpu_physical_memory_read(addr, &tmp0, sizeof(tmp0));
+        address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, &tmp0, sizeof(tmp0));
         if ((tmp0.cmd_code & 0x0f) == CCW_CMD_TIC) {
             ret.cmd_code = CCW_CMD_TIC;
             ret.flags = 0;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 30734661adb..846313984e8 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/datadir.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
 #include "sysemu/tcg.h"
@@ -412,7 +413,8 @@ static uint64_t s390_ipl_map_iplb_chain(IplParameterBlock *iplb_chain)
     uint64_t len = sizeof(IplParameterBlock) * count;
     uint64_t chain_addr = find_iplb_chain_addr(ipl->bios_start_addr, count);
 
-    cpu_physical_memory_write(chain_addr, iplb_chain, len);
+    address_space_write(&address_space_memory, chain_addr,
+                        MEMTXATTRS_UNSPECIFIED, iplb_chain, len);
     return chain_addr;
 }
 
@@ -694,8 +696,8 @@ int s390_ipl_prepare_pv_header(Error **errp)
     void *hdr = g_malloc(ipib_pv->pv_header_len);
     int rc;
 
-    cpu_physical_memory_read(ipib_pv->pv_header_addr, hdr,
-                             ipib_pv->pv_header_len);
+    address_space_read(&address_space_memory, ipib_pv->pv_header_addr,
+                       MEMTXATTRS_UNSPECIFIED, hdr, ipib_pv->pv_header_len);
     rc = s390_pv_set_sec_parms((uintptr_t)hdr, ipib_pv->pv_header_len, errp);
     g_free(hdr);
     return rc;
diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index 8757626b5cc..bb5b80c0b20 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -15,6 +15,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "hw/s390x/sclp.h"
 #include "hw/s390x/event-facility.h"
@@ -313,7 +314,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(&address_space_memory, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -326,7 +328,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(&address_space_memory, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -340,8 +343,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(&address_space_memory, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(work_sccb->h.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 57761b55946..8f65dad1834 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -29,6 +29,7 @@
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
+#include "exec/address-spaces.h"
 #include "hw/scsi/scsi.h"
 #include "migration/vmstate.h"
 #include "scsi/constants.h"
@@ -407,7 +408,8 @@ pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
 
     cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
-    cpu_physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
+    address_space_write(&address_space_memory, cmp_descr_pa,
+                        MEMTXATTRS_UNSPECIFIED, cmp_desc, sizeof(*cmp_desc));
 }
 
 static void
@@ -417,7 +419,8 @@ pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
 
     msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
-    cpu_physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
+    address_space_write(&address_space_memory, msg_descr_pa,
+                        MEMTXATTRS_UNSPECIFIED, msg_desc, sizeof(*msg_desc));
 }
 
 static void
@@ -492,7 +495,8 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
 {
     struct PVSCSISGElement elem;
 
-    cpu_physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
+    address_space_read(&address_space_memory, sg->elemAddr,
+                       MEMTXATTRS_UNSPECIFIED, &elem, sizeof(elem));
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
@@ -513,7 +517,8 @@ pvscsi_write_sense(PVSCSIRequest *r, uint8_t *sense, int len)
 {
     r->cmp.senseLen = MIN(r->req.senseLen, len);
     r->sense_key = sense[(sense[0] & 2) ? 1 : 2];
-    cpu_physical_memory_write(r->req.senseAddr, sense, r->cmp.senseLen);
+    address_space_write(&address_space_memory, r->req.senseAddr,
+                        MEMTXATTRS_UNSPECIFIED, sense, r->cmp.senseLen);
 }
 
 static void
@@ -770,7 +775,8 @@ pvscsi_process_io(PVSCSIState *s)
         smp_rmb();
 
         trace_pvscsi_process_io(next_descr_pa);
-        cpu_physical_memory_read(next_descr_pa, &descr, sizeof(descr));
+        address_space_read(&address_space_memory, next_descr_pa,
+                           MEMTXATTRS_UNSPECIFIED, &descr, sizeof(descr));
         pvscsi_process_request_descriptor(s, &descr);
     }
 
diff --git a/hw/xen/xen-hvm-common.c b/hw/xen/xen-hvm-common.c
index 7ffbbfea23b..2536bea2cfa 100644
--- a/hw/xen/xen-hvm-common.c
+++ b/hw/xen/xen-hvm-common.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
@@ -272,8 +273,10 @@ static void do_outp(uint32_t addr,
  * memory, as part of the implementation of an ioreq.
  *
  * Equivalent to
- *   cpu_physical_memory_rw(addr + (req->df ? -1 : +1) * req->size * i,
- *                          val, req->size, 0/1)
+ *   address_space_rw(&address_space_memory,
+ *                    addr + (req->df ? -1 : +1) * req->size * i,
+ *                    MEMTXATTRS_UNSPECIFIED, val, req->size, 0/1)
+ *
  * except without the integer overflow problems.
  */
 static void rw_phys_req_item(hwaddr addr,
@@ -288,7 +291,8 @@ static void rw_phys_req_item(hwaddr addr,
     } else {
         addr += offset;
     }
-    cpu_physical_memory_rw(addr, val, req->size, rw);
+    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED, val,
+                     req->size, rw);
 }
 
 static inline void read_phys_req_item(hwaddr addr,
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 6c2e3f4840f..1089442f19c 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -3,6 +3,7 @@
  */
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
 #include "xen-host-pci-device.h"
@@ -222,7 +223,8 @@ void xen_pt_setup_vga(XenPCIPassthroughState *s, XenHostPCIDevice *dev,
     }
 
     /* Currently we fixed this address as a primary for legacy BIOS. */
-    cpu_physical_memory_write(0xc0000, bios, bios_size);
+    address_space_write(&address_space_memory, 0xc0000,
+                        MEMTXATTRS_UNSPECIFIED, bios, bios_size);
 }
 
 uint32_t igd_read_opregion(XenPCIPassthroughState *s)
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 398e6256e1d..1641d5549b9 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -28,6 +28,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "exec/address-spaces.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
 #include "hw/boards.h"
@@ -366,7 +367,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 exit(EXIT_FAILURE);
             }
 
-            cpu_physical_memory_write(cur_lowmem, fdt, fdt_size);
+            address_space_write(&address_space_memory, cur_lowmem,
+                                MEMTXATTRS_UNSPECIFIED, fdt, fdt_size);
             cur_tagptr = put_tag(cur_tagptr, BP_TAG_FDT,
                                  sizeof(dtb_addr), &dtb_addr);
             cur_lowmem = QEMU_ALIGN_UP(cur_lowmem + fdt_size, 4 * KiB);
@@ -443,7 +445,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
 
             memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
             memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
-            cpu_physical_memory_write(env->pc, boot, boot_sz);
+            address_space_write(&address_space_memory, env->pc,
+                                MEMTXATTRS_UNSPECIFIED, boot, boot_sz);
         }
     } else {
         if (flash) {
diff --git a/system/cpus.c b/system/cpus.c
index 1c818ff6828..b66799a3d05 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -30,6 +30,7 @@
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-events-run-state.h"
 #include "qapi/qmp/qerror.h"
+#include "exec/address-spaces.h"
 #include "exec/gdbstub.h"
 #include "sysemu/hw_accel.h"
 #include "exec/cpu-common.h"
@@ -857,7 +858,8 @@ void qmp_pmemsave(uint64_t addr, uint64_t size, const char *filename,
         l = sizeof(buf);
         if (l > size)
             l = size;
-        cpu_physical_memory_read(addr, buf, l);
+        address_space_read(&address_space_memory, addr,
+                           MEMTXATTRS_UNSPECIFIED, buf, l);
         if (fwrite(buf, 1, l, f) != l) {
             error_setg(errp, "writing memory to '%s' failed",
                        filename);
diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 2f89dc628ef..d3fbc7e9e55 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -86,7 +86,8 @@ static int kvm_gva_rw(CPUState *cs, uint64_t gva, void *_buf, size_t sz,
             len = sz;
         }
 
-        cpu_physical_memory_rw(gpa, buf, len, is_write);
+        address_space_rw(&address_space_memory, gpa, MEMTXATTRS_UNSPECIFIED,
+                         buf, len, is_write);
 
         buf += len;
         sz -= len;
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 2d766b2637f..5e8c7b002d4 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp-target.h"
 #include "monitor/hmp.h"
@@ -76,7 +77,8 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
 
     pgd = env->cr[3] & ~0xfff;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        address_space_read(&address_space_memory, pgd + l1 * 4,
+                           MEMTXATTRS_UNSPECIFIED, &pde, 4);
         pde = le32_to_cpu(pde);
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
@@ -84,7 +86,9 @@ static void tlb_info_32(Monitor *mon, CPUArchState *env)
                 print_pte(mon, env, (l1 << 22), pde, ~((1 << 21) - 1));
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    address_space_read(&address_space_memory,
+                                       (pde & ~0xfff) + l2 * 4,
+                                       MEMTXATTRS_UNSPECIFIED, &pte, 4);
                     pte = le32_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l1 << 22) + (l2 << 12),
@@ -105,12 +109,14 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
 
     pdp_addr = env->cr[3] & ~0x1f;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        address_space_read(&address_space_memory, pdp_addr + l1 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pdpe, 8);
         pdpe = le64_to_cpu(pdpe);
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                address_space_read(&address_space_memory, pd_addr + l2 * 8,
+                                   MEMTXATTRS_UNSPECIFIED, &pde, 8);
                 pde = le64_to_cpu(pde);
                 if (pde & PG_PRESENT_MASK) {
                     if (pde & PG_PSE_MASK) {
@@ -120,7 +126,10 @@ static void tlb_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            address_space_read(&address_space_memory,
+                                               pt_addr + l3 * 8,
+                                               MEMTXATTRS_UNSPECIFIED, &pte,
+                                               8);
                             pte = le64_to_cpu(pte);
                             if (pte & PG_PRESENT_MASK) {
                                 print_pte(mon, env, (l1 << 30) + (l2 << 21)
@@ -145,7 +154,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
     uint64_t pdp_addr, pd_addr, pt_addr;
 
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        address_space_read(&address_space_memory, pml4_addr + l1 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pml4e, 8);
         pml4e = le64_to_cpu(pml4e);
         if (!(pml4e & PG_PRESENT_MASK)) {
             continue;
@@ -153,7 +163,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
         pdp_addr = pml4e & 0x3fffffffff000ULL;
         for (l2 = 0; l2 < 512; l2++) {
-            cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+            address_space_read(&address_space_memory, pdp_addr + l2 * 8,
+                               MEMTXATTRS_UNSPECIFIED, &pdpe, 8);
             pdpe = le64_to_cpu(pdpe);
             if (!(pdpe & PG_PRESENT_MASK)) {
                 continue;
@@ -168,7 +179,8 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l3 = 0; l3 < 512; l3++) {
-                cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                address_space_read(&address_space_memory, pd_addr + l3 * 8,
+                                   MEMTXATTRS_UNSPECIFIED, &pde, 8);
                 pde = le64_to_cpu(pde);
                 if (!(pde & PG_PRESENT_MASK)) {
                     continue;
@@ -183,9 +195,9 @@ static void tlb_info_la48(Monitor *mon, CPUArchState *env,
 
                 pt_addr = pde & 0x3fffffffff000ULL;
                 for (l4 = 0; l4 < 512; l4++) {
-                    cpu_physical_memory_read(pt_addr
-                            + l4 * 8,
-                            &pte, 8);
+                    address_space_read(&address_space_memory,
+                                       pt_addr + l4 * 8,
+                                       MEMTXATTRS_UNSPECIFIED, &pte, 8);
                     pte = le64_to_cpu(pte);
                     if (pte & PG_PRESENT_MASK) {
                         print_pte(mon, env, (l0 << 48) + (l1 << 39) +
@@ -206,7 +218,8 @@ static void tlb_info_la57(Monitor *mon, CPUArchState *env)
 
     pml5_addr = env->cr[3] & 0x3fffffffff000ULL;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        address_space_read(&address_space_memory, pml5_addr + l0 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pml5e, 8);
         pml5e = le64_to_cpu(pml5e);
         if (pml5e & PG_PRESENT_MASK) {
             tlb_info_la48(mon, env, l0, pml5e & 0x3fffffffff000ULL);
@@ -283,7 +296,8 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for(l1 = 0; l1 < 1024; l1++) {
-        cpu_physical_memory_read(pgd + l1 * 4, &pde, 4);
+        address_space_read(&address_space_memory, pgd + l1 * 4,
+                           MEMTXATTRS_UNSPECIFIED, &pde, 4);
         pde = le32_to_cpu(pde);
         end = l1 << 22;
         if (pde & PG_PRESENT_MASK) {
@@ -292,7 +306,9 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
                 mem_print(mon, env, &start, &last_prot, end, prot);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
-                    cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
+                    address_space_read(&address_space_memory,
+                                       (pde & ~0xfff) + l2 * 4,
+                                       MEMTXATTRS_UNSPECIFIED, &pte, 4);
                     pte = le32_to_cpu(pte);
                     end = (l1 << 22) + (l2 << 12);
                     if (pte & PG_PRESENT_MASK) {
@@ -325,13 +341,15 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 4; l1++) {
-        cpu_physical_memory_read(pdp_addr + l1 * 8, &pdpe, 8);
+        address_space_read(&address_space_memory, pdp_addr + l1 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pdpe, 8);
         pdpe = le64_to_cpu(pdpe);
         end = l1 << 30;
         if (pdpe & PG_PRESENT_MASK) {
             pd_addr = pdpe & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pd_addr + l2 * 8, &pde, 8);
+                address_space_read(&address_space_memory, pd_addr + l2 * 8,
+                                   MEMTXATTRS_UNSPECIFIED, &pde, 8);
                 pde = le64_to_cpu(pde);
                 end = (l1 << 30) + (l2 << 21);
                 if (pde & PG_PRESENT_MASK) {
@@ -342,7 +360,10 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pt_addr + l3 * 8, &pte, 8);
+                            address_space_read(&address_space_memory,
+                                               pt_addr + l3 * 8,
+                                               MEMTXATTRS_UNSPECIFIED, &pte,
+                                               8);
                             pte = le64_to_cpu(pte);
                             end = (l1 << 30) + (l2 << 21) + (l3 << 12);
                             if (pte & PG_PRESENT_MASK) {
@@ -381,13 +402,15 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l1 = 0; l1 < 512; l1++) {
-        cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+        address_space_read(&address_space_memory, pml4_addr + l1 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pml4e, 8);
         pml4e = le64_to_cpu(pml4e);
         end = l1 << 39;
         if (pml4e & PG_PRESENT_MASK) {
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                address_space_read(&address_space_memory, pdp_addr + l2 * 8,
+                                   MEMTXATTRS_UNSPECIFIED, &pdpe, 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -399,7 +422,10 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                     } else {
                         pd_addr = pdpe & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
-                            cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                            address_space_read(&address_space_memory,
+                                               pd_addr + l3 * 8,
+                                               MEMTXATTRS_UNSPECIFIED, &pde,
+                                               8);
                             pde = le64_to_cpu(pde);
                             end = (l1 << 39) + (l2 << 30) + (l3 << 21);
                             if (pde & PG_PRESENT_MASK) {
@@ -412,9 +438,10 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                 } else {
                                     pt_addr = pde & 0x3fffffffff000ULL;
                                     for (l4 = 0; l4 < 512; l4++) {
-                                        cpu_physical_memory_read(pt_addr
-                                                                 + l4 * 8,
-                                                                 &pte, 8);
+                                        address_space_read(&address_space_memory,
+                                                           pt_addr + l4 * 8,
+                                                           MEMTXATTRS_UNSPECIFIED,
+                                                           &pte, 8);
                                         pte = le64_to_cpu(pte);
                                         end = (l1 << 39) + (l2 << 30) +
                                             (l3 << 21) + (l4 << 12);
@@ -461,7 +488,8 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
     last_prot = 0;
     start = -1;
     for (l0 = 0; l0 < 512; l0++) {
-        cpu_physical_memory_read(pml5_addr + l0 * 8, &pml5e, 8);
+        address_space_read(&address_space_memory, pml5_addr + l0 * 8,
+                           MEMTXATTRS_UNSPECIFIED, &pml5e, 8);
         pml5e = le64_to_cpu(pml5e);
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
@@ -472,7 +500,8 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
         pml4_addr = pml5e & 0x3fffffffff000ULL;
         for (l1 = 0; l1 < 512; l1++) {
-            cpu_physical_memory_read(pml4_addr + l1 * 8, &pml4e, 8);
+            address_space_read(&address_space_memory, pml4_addr + l1 * 8,
+                               MEMTXATTRS_UNSPECIFIED, &pml4e, 8);
             pml4e = le64_to_cpu(pml4e);
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
@@ -483,7 +512,8 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
             pdp_addr = pml4e & 0x3fffffffff000ULL;
             for (l2 = 0; l2 < 512; l2++) {
-                cpu_physical_memory_read(pdp_addr + l2 * 8, &pdpe, 8);
+                address_space_read(&address_space_memory, pdp_addr + l2 * 8,
+                                   MEMTXATTRS_UNSPECIFIED, &pdpe, 8);
                 pdpe = le64_to_cpu(pdpe);
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
@@ -502,7 +532,9 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                 pd_addr = pdpe & 0x3fffffffff000ULL;
                 for (l3 = 0; l3 < 512; l3++) {
-                    cpu_physical_memory_read(pd_addr + l3 * 8, &pde, 8);
+                    address_space_read(&address_space_memory,
+                                       pd_addr + l3 * 8,
+                                       MEMTXATTRS_UNSPECIFIED, &pde, 8);
                     pde = le64_to_cpu(pde);
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
@@ -521,7 +553,9 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
 
                     pt_addr = pde & 0x3fffffffff000ULL;
                     for (l4 = 0; l4 < 512; l4++) {
-                        cpu_physical_memory_read(pt_addr + l4 * 8, &pte, 8);
+                        address_space_read(&address_space_memory,
+                                           pt_addr + l4 * 8,
+                                           MEMTXATTRS_UNSPECIFIED, &pte, 8);
                         pte = le64_to_cpu(pte);
                         end = (l0 << 48) + (l1 << 39) + (l2 << 30) +
                             (l3 << 21) + (l4 << 12);
diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
index 65768aca037..d3b9c62791c 100644
--- a/target/i386/nvmm/nvmm-all.c
+++ b/target/i386/nvmm/nvmm-all.c
@@ -514,7 +514,8 @@ nvmm_io_callback(struct nvmm_io *io)
 static void
 nvmm_mem_callback(struct nvmm_mem *mem)
 {
-    cpu_physical_memory_rw(mem->gpa, mem->data, mem->size, mem->write);
+    address_space_rw(&address_space_memory, mem->gpa, MEMTXATTRS_UNSPECIFIED,
+                     mem->data, mem->size, mem->write);
 
     /* Needed, otherwise infinite loop. */
     current_cpu->accel->dirty = false;
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index a6674a826d6..6b4faea4135 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -790,8 +790,9 @@ static HRESULT CALLBACK whpx_emu_mmio_callback(
     void *ctx,
     WHV_EMULATOR_MEMORY_ACCESS_INFO *ma)
 {
-    cpu_physical_memory_rw(ma->GpaAddress, ma->Data, ma->AccessSize,
-                           ma->Direction);
+    address_space_rw(&address_space_memory, ma->GpaAddress,
+                     MEMTXATTRS_UNSPECIFIED, ma->Data, ma->AccessSize,
+                     ma->Direction);
     return S_OK;
 }
 
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index c53ca1f76bf..e5d0869dcb5 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1478,9 +1478,11 @@ static void kvm_riscv_handle_sbi_dbcn(CPUState *cs, struct kvm_run *run)
                 exit(1);
             }
 
-            cpu_physical_memory_write(addr, buf, ret);
+            address_space_write(&address_space_memory, addr,
+                                MEMTXATTRS_UNSPECIFIED, buf, ret);
         } else {
-            cpu_physical_memory_read(addr, buf, num_bytes);
+            address_space_read(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, buf, num_bytes);
 
             ret = qemu_chr_fe_write_all(serial_hd(0)->be, buf, num_bytes);
             if (ret < 0) {
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 100005ea4e9..1f1912a5ab8 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/address-spaces.h"
 #include "cpu.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
@@ -100,7 +101,8 @@ static void walk_pte(Monitor *mon, hwaddr base, target_ulong start,
 
     for (idx = 0; idx < (1UL << ptidxbits); idx++) {
         pte_addr = base + idx * ptesize;
-        cpu_physical_memory_read(pte_addr, &pte, ptesize);
+        address_space_read(&address_space_memory, pte_addr,
+                           MEMTXATTRS_UNSPECIFIED, &pte, ptesize);
 
         paddr = (hwaddr)(pte >> PTE_PPN_SHIFT) << PGSHIFT;
         attr = pte & 0xff;
diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index a1fd54ddac0..f5f097fcf8f 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -14,6 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "s390x-internal.h"
 #include "hw/watchdog/wdt_diag288.h"
 #include "sysemu/cpus.h"
@@ -115,7 +116,9 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
         iplb = g_new0(IplParameterBlock, 1);
         if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+            address_space_read(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, iplb,
+                               sizeof(iplb->len));
         } else {
             s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
         }
@@ -126,7 +129,9 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
         }
 
         if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+            address_space_read(&address_space_memory, addr,
+                               MEMTXATTRS_UNSPECIFIED, iplb,
+                               be32_to_cpu(iplb->len));
         } else {
             s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
         }
@@ -165,7 +170,9 @@ out:
         }
 
         if (!s390_is_pv()) {
-            cpu_physical_memory_write(addr, iplb, be32_to_cpu(iplb->len));
+            address_space_write(&address_space_memory, addr,
+                                MEMTXATTRS_UNSPECIFIED, iplb,
+                                be32_to_cpu(iplb->len));
         } else {
             s390_cpu_pv_mem_write(cpu, 0, iplb, be32_to_cpu(iplb->len));
         }
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 00d5d403f31..1dda0b8092b 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "exec/address-spaces.h"
 #include "s390x-internal.h"
 #include "gdbstub/helpers.h"
 #include "qemu/timer.h"
@@ -213,7 +214,9 @@ int s390_store_status(S390CPU *cpu, hwaddr addr, bool store_arch)
     }
 
     if (store_arch) {
-        cpu_physical_memory_write(offsetof(LowCore, ar_access_id), &ar_id, 1);
+        address_space_write(&address_space_memory,
+                            offsetof(LowCore, ar_access_id),
+                            MEMTXATTRS_UNSPECIFIED, &ar_id, 1);
     }
     for (i = 0; i < 16; ++i) {
         sa->fprs[i] = cpu_to_be64(*get_freg(&cpu->env, i));
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 6c59d0d216e..f427e782950 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -545,8 +545,10 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(&address_space_memory,
+                             pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen,
+                             is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.45.2


