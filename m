Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42AE6D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObtC-00069v-Lr; Thu, 27 Nov 2025 08:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObrC-0002rD-Gg
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObr6-0001Js-GT
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qY+rQ8H8hkB4As/VQV6sKAHUnvXUagRrq1D5YbzHfpY=;
 b=R3nI0AIHuFrZTTaW3mXZyDk1kNtI4OAAPs53/UlL2kJZFKW8WrZUw8E/ghmn5ow2Skz3XK
 sIkoyIfnXa1OKaQq6Zbkc7jtWg2uuKToEWNAnHgp5fRsAOOLTm9/rVAhYgshCF9PocxKFN
 xSRKTswySGCCaDDNrZo9wyAxod8kM34=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-JCG7tl6rOq-Y4tZbizRejw-1; Thu, 27 Nov 2025 08:16:12 -0500
X-MC-Unique: JCG7tl6rOq-Y4tZbizRejw-1
X-Mimecast-MFC-AGG-ID: JCG7tl6rOq-Y4tZbizRejw_1764249371
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6450f3e7e71so808023a12.3
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249370; x=1764854170; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qY+rQ8H8hkB4As/VQV6sKAHUnvXUagRrq1D5YbzHfpY=;
 b=edzh1Bbge/eMWG8wn1Ew0ZeLIr+b/RKc0xojWqtn7oxJHBPSAWw/dttFy1z0320+N8
 DkrCmcuf2bX8BVT+qiBmzenmpP43rY5qBBat+tbjQK/jWvzEGYFg+zkGBoQ7QQaLfOJM
 0jM+0wGCS6r3QwWOARqmFttTN4BpVRVmfSBqx1FIynzfHultboIleMynUtwFLGIGzjad
 qCgvzyIrnRq5c+/v3ouvmARTxH+qJWGNIx7f+tElWodMOA/v1oQ6i1DCITrIGij34e2v
 Q8Qog/2MvTcows43ulOF9frZiosoa4crDCoUqL67wTMeLBkZueuYGgcFCWi+B8UtLzMH
 Xpnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249370; x=1764854170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qY+rQ8H8hkB4As/VQV6sKAHUnvXUagRrq1D5YbzHfpY=;
 b=wyfZPL23K73XmYWeNpRDtZgszUx8Cqi+nBvVOTMFFDpvcW7u+g79tHHa3Aq07YqPp5
 8yOSdoiW/3X/0JgdHf5DSAn/Jmt05m3oNG9wfuCXoD540o/Mx8i5hTIBsBn5n+8jaGCI
 UmToHiCtbe8ZkeXGCggRghTz9A9gCleK1OlUMbNFxXkdue1cWWxVMl0H2l1AQpv5P7BG
 +45dS/kqVMAQ+xD7TgAM29jSMizcWETDqt0yTap2L5uW7mAB/4a8k1W0om0bQJ4HqETT
 2eGA2AJSv+ChnabOmmmH9mwkYVo22jJetzNja9wIXVcZ2JTIxzq19zzDvE2qPJ6g/ukd
 /Sew==
X-Gm-Message-State: AOJu0YzkP6hO2+Zykp52jDG20a+wsrSgUonhB9LUGtzNMy8AyABrAbDv
 xq+CaDUQ+WD+wRH03LkkK1EZ0k+5JJ6Zr2S+hZUMhHZlVLycc4vARoh6ha7ZZkYrxTTryM5V4HU
 9LVUnE7113YzA1VBJDe6Vt6U16gIYgnW0h4CQmuM4wHUxs/bcOlJdTGhqIfqBMrV4QyPNR7Y+Xy
 CMvkXIymScW9fAsHfaoEPFw8YbvTEGTL7FY5I8tyyO
X-Gm-Gg: ASbGncuzAJuSH9x3ZAjTCOaqaw6ayZo/mwmou1D/MWu7I1A2vVVj3yVSBuPwZHDo7md
 lehg2BQNJlyXpRGDMmQnfMOggz6eEXybdsmgRc7ZGkVuG/+YOt7MZlt73T2qBRLZMUpnzQV/3/6
 z7IDLEGPtgtqJWkmXdlURXpHu8ozokKx1qZTo4saXD8ASMSEoBRQ6epbnsZve5de+9PgRyhDQTB
 dJSemdS6OERYKPhD0Oh+WCnn6OtXmYmcDd8kkMGQSHdjrbr+OCZkmCPmX39vhOEgmek7PzIp9rg
 I4SF1pCXzcrjY1vjUHVTGbkL1B1LPY0q4Wb3vdFt4ApPrW11bfFIiTDd3+aaeiE4zXsyjj/Wj+G
 6jDBMwsx88SvDIVUFKcBNJQXpIJd6u0f1R97gmQ9hqqh+nvhtL/m6ZRf8hz2zclcSQonxz+7J6R
 gsPhlRqxbbgJ4iB7Q=
X-Received: by 2002:a05:6402:280a:b0:645:d75d:3dc2 with SMTP id
 4fb4d7f45d1cf-645eb258ff8mr10590707a12.10.1764249369191; 
 Thu, 27 Nov 2025 05:16:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHqkCUDjB3lw9dCLoae7m0naA3RaYuEeSfFWRYg+RPLXgokY7WxNZFkQXCOY0PtsHPoMN66PA==
X-Received: by 2002:a05:6402:280a:b0:645:d75d:3dc2 with SMTP id
 4fb4d7f45d1cf-645eb258ff8mr10590617a12.10.1764249367580; 
 Thu, 27 Nov 2025 05:16:07 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c3bsm1463046a12.19.2025.11.27.05.16.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:16:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 28/28] include: reorganize memory API headers
Date: Thu, 27 Nov 2025 14:15:15 +0100
Message-ID: <20251127131516.80807-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127131516.80807-1-pbonzini@redhat.com>
References: <20251127131516.80807-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                              |   2 +-
 include/exec/cpu-common.h                |  76 +----------
 include/hw/core/qdev-properties-system.h |   1 +
 include/hw/i2c/smbus_eeprom.h            |   2 +-
 include/hw/xen/xen-hvm-common.h          |   1 +
 include/system/balloon.h                 |   2 +-
 include/system/block-ram-registrar.h     |   2 +-
 include/system/iommufd.h                 |   2 +-
 include/system/memory.h                  |  16 ++-
 include/system/memory_mapping.h          |   4 +-
 include/system/physmem.h                 |   2 +-
 include/system/ram_addr.h                | 136 +++----------------
 include/system/ramblock.h                | 160 ++++++++++++++++++++++-
 include/{exec => system}/ramlist.h       |  10 +-
 include/system/xen-mapcache.h            |   1 -
 include/system/xen.h                     |   3 +-
 migration/migration.h                    |   3 +-
 accel/mshv/mshv-all.c                    |   1 +
 accel/tcg/cputlb.c                       |   2 +-
 accel/tcg/tcg-accel-ops-mttcg.c          |   1 +
 backends/hostmem.c                       |   1 +
 block/blkio.c                            |   2 +-
 dump/dump.c                              |   1 +
 hw/acpi/ghes.c                           |   1 +
 hw/acpi/nvdimm.c                         |   1 +
 hw/acpi/vmgenid.c                        |   1 +
 hw/arm/omap1.c                           |   1 +
 hw/audio/marvell_88w8618.c               |   1 +
 hw/char/riscv_htif.c                     |   1 +
 hw/core/cpu-common.c                     |   1 +
 hw/core/machine-qmp-cmds.c               |   1 +
 hw/core/numa.c                           |   3 +-
 hw/display/exynos4210_fimd.c             |   1 +
 hw/display/omap_lcdc.c                   |   1 +
 hw/display/ramfb.c                       |   1 +
 hw/display/vga.c                         |   1 +
 hw/dma/i8257.c                           |   1 +
 hw/dma/omap_dma.c                        |   1 +
 hw/dma/rc4030.c                          |   1 +
 hw/dma/sifive_pdma.c                     |   1 +
 hw/hyperv/hyperv.c                       |   1 +
 hw/hyperv/syndbg.c                       |   1 +
 hw/hyperv/vmbus.c                        |   1 +
 hw/i386/kvm/clock.c                      |   1 +
 hw/i386/vapic.c                          |   1 +
 hw/intc/apic.c                           |   1 +
 hw/intc/xive2.c                          |   1 +
 hw/m68k/next-cube.c                      |   1 +
 hw/microblaze/boot.c                     |   1 +
 hw/misc/pc-testdev.c                     |   1 +
 hw/net/fsl_etsec/rings.c                 |   1 +
 hw/net/mcf_fec.c                         |   1 +
 hw/net/opencores_eth.c                   |   1 +
 hw/net/xgmac.c                           |   1 +
 hw/nvram/spapr_nvram.c                   |   1 +
 hw/ppc/amigaone.c                        |   1 +
 hw/ppc/e500.c                            |   1 +
 hw/ppc/pegasos.c                         |   1 +
 hw/ppc/pnv.c                             |   1 +
 hw/ppc/ppc440_uc.c                       |   1 +
 hw/ppc/spapr.c                           |   1 +
 hw/ppc/spapr_drc.c                       |   1 +
 hw/ppc/spapr_events.c                    |   1 +
 hw/ppc/spapr_hcall.c                     |   1 +
 hw/ppc/spapr_rtas.c                      |   1 +
 hw/ppc/spapr_tpm_proxy.c                 |   1 +
 hw/ppc/virtex_ml507.c                    |   1 +
 hw/remote/proxy-memory-listener.c        |   1 +
 hw/s390x/css.c                           |   1 +
 hw/s390x/ipl.c                           |   1 +
 hw/s390x/s390-pci-bus.c                  |   1 +
 hw/s390x/virtio-ccw.c                    |   1 +
 hw/scsi/vmw_pvscsi.c                     |   1 +
 hw/sparc/leon3.c                         |   1 +
 hw/vfio-user/container.c                 |   1 +
 hw/vfio/container.c                      |   2 +-
 hw/vfio/helpers.c                        |   1 +
 hw/vfio/migration.c                      |   2 +-
 hw/virtio/vhost.c                        |   1 +
 hw/xen/xen-mapcache.c                    |   1 +
 hw/xen/xen_pt_graphics.c                 |   1 +
 hw/xtensa/xtfpga.c                       |   1 +
 migration/ram.c                          |   2 +-
 stubs/physmem.c                          |   2 +-
 stubs/ram-block.c                        |   4 +-
 system/ioport.c                          |   1 +
 system/memory.c                          |   2 +-
 system/physmem.c                         |   2 +-
 target/arm/kvm.c                         |   1 +
 target/i386/kvm/kvm.c                    |   1 +
 target/i386/sev.c                        |   1 +
 target/ppc/kvm.c                         |   2 +-
 target/s390x/kvm/kvm.c                   |   2 +-
 util/vfio-helpers.c                      |   2 +-
 94 files changed, 290 insertions(+), 226 deletions(-)
 rename include/{exec => system}/ramlist.h (94%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0a70bc03889..dab02da37a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3254,9 +3254,9 @@ R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
 F: include/exec/memop.h
+F: include/exec/ram_addr.h
 F: include/system/memory.h
 F: include/system/physmem.h
-F: include/system/ram_addr.h
 F: include/system/ramblock.h
 F: include/system/memory_mapping.h
 F: system/dma-helpers.c
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index e0be4ee2b8f..fba4d782e91 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -10,6 +10,8 @@
 
 #include "exec/vaddr.h"
 #include "exec/hwaddr.h"
+#include "exec/hwaddr.h"
+#include "system/ram_addr.h"
 #include "hw/core/cpu.h"
 #include "tcg/debug-assert.h"
 #include "exec/page-protection.h"
@@ -38,69 +40,6 @@ int cpu_get_free_index(void);
 void tcg_iommu_init_notifier_list(CPUState *cpu);
 void tcg_iommu_free_notifier_list(CPUState *cpu);
 
-enum device_endian {
-    DEVICE_NATIVE_ENDIAN,
-    DEVICE_BIG_ENDIAN,
-    DEVICE_LITTLE_ENDIAN,
-};
-
-/* address in the RAM (different from a physical address) */
-#if defined(CONFIG_XEN_BACKEND)
-typedef uint64_t ram_addr_t;
-#  define RAM_ADDR_MAX UINT64_MAX
-#  define RAM_ADDR_FMT "%" PRIx64
-#else
-typedef uintptr_t ram_addr_t;
-#  define RAM_ADDR_MAX UINTPTR_MAX
-#  define RAM_ADDR_FMT "%" PRIxPTR
-#endif
-
-/* memory API */
-
-void qemu_ram_remap(ram_addr_t addr);
-/* This should not be used by devices.  */
-ram_addr_t qemu_ram_addr_from_host(void *ptr);
-ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
-RAMBlock *qemu_ram_block_by_name(const char *name);
-
-/*
- * Translates a host ptr back to a RAMBlock and an offset in that RAMBlock.
- *
- * @ptr: The host pointer to translate.
- * @round_offset: Whether to round the result offset down to a target page
- * @offset: Will be set to the offset within the returned RAMBlock.
- *
- * Returns: RAMBlock (or NULL if not found)
- *
- * By the time this function returns, the returned pointer is not protected
- * by RCU anymore.  If the caller is not within an RCU critical section and
- * does not hold the BQL, it must have other means of protecting the
- * pointer, such as a reference to the memory region that owns the RAMBlock.
- */
-RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
-                                   ram_addr_t *offset);
-ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
-void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
-void qemu_ram_unset_idstr(RAMBlock *block);
-const char *qemu_ram_get_idstr(RAMBlock *rb);
-void *qemu_ram_get_host_addr(RAMBlock *rb);
-ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
-ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
-ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
-bool qemu_ram_is_shared(RAMBlock *rb);
-bool qemu_ram_is_noreserve(RAMBlock *rb);
-bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
-void qemu_ram_set_uf_zeroable(RAMBlock *rb);
-bool qemu_ram_is_migratable(RAMBlock *rb);
-void qemu_ram_set_migratable(RAMBlock *rb);
-void qemu_ram_unset_migratable(RAMBlock *rb);
-bool qemu_ram_is_named_file(RAMBlock *rb);
-int qemu_ram_get_fd(RAMBlock *rb);
-
-size_t qemu_ram_pagesize(RAMBlock *block);
-size_t qemu_ram_pagesize_largest(void);
-
 /**
  * cpu_address_space_init:
  * @cpu: CPU to add this address space to
@@ -139,17 +78,6 @@ void *cpu_physical_memory_map(hwaddr addr,
 void cpu_physical_memory_unmap(void *buffer, hwaddr len,
                                bool is_write, hwaddr access_len);
 
-/* Coalesced MMIO regions are areas where write operations can be reordered.
- * This usually implies that write operations are side-effect free.  This allows
- * batching which can make a major impact on performance when using
- * virtualization.
- */
-void qemu_flush_coalesced_mmio_buffer(void);
-
-typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
-
-int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
-
 /* vl.c */
 void list_cpus(void);
 
diff --git a/include/hw/core/qdev-properties-system.h b/include/hw/core/qdev-properties-system.h
index ec39ef3bd6e..ec21732ce52 100644
--- a/include/hw/core/qdev-properties-system.h
+++ b/include/hw/core/qdev-properties-system.h
@@ -2,6 +2,7 @@
 #define HW_QDEV_PROPERTIES_SYSTEM_H
 
 #include "hw/core/qdev-properties.h"
+#include "qapi/qapi-types-common.h"
 
 bool qdev_prop_sanitize_s390x_loadparm(uint8_t *loadparm, const char *str,
                                        Error **errp);
diff --git a/include/hw/i2c/smbus_eeprom.h b/include/hw/i2c/smbus_eeprom.h
index 68b0063ab6f..61a54cda761 100644
--- a/include/hw/i2c/smbus_eeprom.h
+++ b/include/hw/i2c/smbus_eeprom.h
@@ -23,7 +23,7 @@
 #ifndef HW_SMBUS_EEPROM_H
 #define HW_SMBUS_EEPROM_H
 
-#include "exec/cpu-common.h"
+#include "system/ram_addr.h"
 #include "hw/i2c/i2c.h"
 
 void smbus_eeprom_init_one(I2CBus *bus, uint8_t address, uint8_t *eeprom_buf);
diff --git a/include/hw/xen/xen-hvm-common.h b/include/hw/xen/xen-hvm-common.h
index 19df5600a39..e1beca062ff 100644
--- a/include/hw/xen/xen-hvm-common.h
+++ b/include/hw/xen/xen-hvm-common.h
@@ -5,6 +5,7 @@
 #include "exec/hwaddr.h"
 #include "hw/xen/xen_native.h"
 #include "hw/xen/xen_backend_ops.h"
+#include "system/runstate.h"
 #include <xen/hvm/ioreq.h>
 
 extern MemoryRegion xen_memory;
diff --git a/include/system/balloon.h b/include/system/balloon.h
index 867687b73ac..066c7e1ddf4 100644
--- a/include/system/balloon.h
+++ b/include/system/balloon.h
@@ -14,7 +14,7 @@
 #ifndef QEMU_BALLOON_H
 #define QEMU_BALLOON_H
 
-#include "exec/cpu-common.h"
+#include "system/ram_addr.h"
 #include "qapi/qapi-types-machine.h"
 
 typedef void (QEMUBalloonEvent)(void *opaque, ram_addr_t target);
diff --git a/include/system/block-ram-registrar.h b/include/system/block-ram-registrar.h
index d8b2f7942ba..61b0dff3400 100644
--- a/include/system/block-ram-registrar.h
+++ b/include/system/block-ram-registrar.h
@@ -7,7 +7,7 @@
 #ifndef BLOCK_RAM_REGISTRAR_H
 #define BLOCK_RAM_REGISTRAR_H
 
-#include "exec/ramlist.h"
+#include "system/ramlist.h"
 
 /**
  * struct BlockRAMRegistrar:
diff --git a/include/system/iommufd.h b/include/system/iommufd.h
index a659f36a20f..9f5eb872454 100644
--- a/include/system/iommufd.h
+++ b/include/system/iommufd.h
@@ -16,7 +16,7 @@
 
 #include "qom/object.h"
 #include "exec/hwaddr.h"
-#include "exec/cpu-common.h"
+#include "system/ram_addr.h"
 #include "system/host_iommu_device.h"
 
 #define TYPE_IOMMUFD_BACKEND "iommufd"
diff --git a/include/system/memory.h b/include/system/memory.h
index 1cacc117cc6..b3597fb2d04 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -14,11 +14,10 @@
 #ifndef SYSTEM_MEMORY_H
 #define SYSTEM_MEMORY_H
 
-#include "exec/cpu-common.h"
 #include "exec/hwaddr.h"
+#include "system/ram_addr.h"
 #include "exec/memattrs.h"
 #include "exec/memop.h"
-#include "exec/ramlist.h"
 #include "qemu/bswap.h"
 #include "qemu/queue.h"
 #include "qemu/int128.h"
@@ -27,6 +26,12 @@
 #include "qom/object.h"
 #include "qemu/rcu.h"
 
+enum device_endian {
+    DEVICE_NATIVE_ENDIAN,
+    DEVICE_BIG_ENDIAN,
+    DEVICE_LITTLE_ENDIAN,
+};
+
 #define RAM_ADDR_INVALID (~(ram_addr_t)0)
 
 #define MAX_PHYS_ADDR_SPACE_BITS 62
@@ -3266,6 +3271,13 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
 MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
                               uint8_t c, hwaddr len, MemTxAttrs attrs);
 
+/* Coalesced MMIO regions are areas where write operations can be reordered.
+ * This usually implies that write operations are side-effect free.  This allows
+ * batching which can make a major impact on performance when using
+ * virtualization.
+ */
+void qemu_flush_coalesced_mmio_buffer(void);
+
 /*
  * Inhibit technologies that require discarding of pages in RAM blocks, e.g.,
  * to manage the actual amount of memory consumed by the VM (then, the memory
diff --git a/include/system/memory_mapping.h b/include/system/memory_mapping.h
index 021e0a62309..4c770bf0b83 100644
--- a/include/system/memory_mapping.h
+++ b/include/system/memory_mapping.h
@@ -15,7 +15,9 @@
 #define MEMORY_MAPPING_H
 
 #include "qemu/queue.h"
-#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
+#include "exec/vaddr.h"
+#include "system/ram_addr.h"
 
 typedef struct GuestPhysBlock {
     /* visible to guest, reflects PCI hole, etc */
diff --git a/include/system/physmem.h b/include/system/physmem.h
index 879f6eae38b..ed337130228 100644
--- a/include/system/physmem.h
+++ b/include/system/physmem.h
@@ -9,7 +9,7 @@
 #define QEMU_SYSTEM_PHYSMEM_H
 
 #include "exec/hwaddr.h"
-#include "exec/ramlist.h"
+#include "system/ramlist.h"
 
 #define DIRTY_CLIENTS_ALL     ((1 << DIRTY_MEMORY_NUM) - 1)
 #define DIRTY_CLIENTS_NOCODE  (DIRTY_CLIENTS_ALL & ~(1 << DIRTY_MEMORY_CODE))
diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 683485980ce..129f6b8757d 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -1,5 +1,5 @@
 /*
- * Declarations for cpu physical memory functions
+ * Declarations of basic RAMBlock-related types and macros
  *
  * Copyright 2011 Red Hat, Inc. and/or its affiliates
  *
@@ -11,125 +11,23 @@
  *
  */
 
-/*
- * This header is for use by exec.c and memory.c ONLY.  Do not include it.
- * The functions declared here will be removed soon.
- */
+#ifndef RAM_ADDR_H
+#define RAM_ADDR_H
 
-#ifndef SYSTEM_RAM_ADDR_H
-#define SYSTEM_RAM_ADDR_H
+/* address in the RAM (different from a physical address) */
+#if defined(CONFIG_XEN_BACKEND)
+typedef uint64_t ram_addr_t;
+#  define RAM_ADDR_MAX UINT64_MAX
+#  define RAM_ADDR_FMT "%" PRIx64
+#else
+typedef uintptr_t ram_addr_t;
+#  define RAM_ADDR_MAX UINTPTR_MAX
+#  define RAM_ADDR_FMT "%" PRIxPTR
+#endif
 
-#include "system/ramblock.h"
-#include "exec/target_page.h"
-#include "exec/hwaddr.h"
-
-extern uint64_t total_dirty_pages;
-
-/**
- * clear_bmap_size: calculate clear bitmap size
- *
- * @pages: number of guest pages
- * @shift: guest page number shift
- *
- * Returns: number of bits for the clear bitmap
- */
-static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
-{
-    return DIV_ROUND_UP(pages, 1UL << shift);
-}
-
-/**
- * clear_bmap_set: set clear bitmap for the page range.  Must be with
- * bitmap_mutex held.
- *
- * @rb: the ramblock to operate on
- * @start: the start page number
- * @size: number of pages to set in the bitmap
- *
- * Returns: None
- */
-static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
-                                  uint64_t npages)
-{
-    uint8_t shift = rb->clear_bmap_shift;
-
-    bitmap_set(rb->clear_bmap, start >> shift, clear_bmap_size(npages, shift));
-}
-
-/**
- * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set.
- * Must be with bitmap_mutex held.
- *
- * @rb: the ramblock to operate on
- * @page: the page number to check
- *
- * Returns: true if the bit was set, false otherwise
- */
-static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
-{
-    uint8_t shift = rb->clear_bmap_shift;
-
-    return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
-}
-
-static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
-                                                            RAMBlock *rb)
-{
-    uint64_t host_addr_offset =
-            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
-    return host_addr_offset >> TARGET_PAGE_BITS;
-}
-
-/**
- * qemu_ram_alloc_from_file,
- * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
- *                          file or device
- *
- * Parameters:
- *  @size: the size in bytes of the ram block
- *  @max_size: the maximum size of the block after resizing
- *  @mr: the memory region where the ram block is
- *  @resized: callback after calls to qemu_ram_resize
- *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
- *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
- *              RAM_READONLY_FD, RAM_GUEST_MEMFD
- *  @mem_path or @fd: specify the backing file or device
- *  @offset: Offset into target file
- *  @grow: extend file if necessary (but an empty file is always extended).
- *  @errp: pointer to Error*, to store an error if it happens
- *
- * Return:
- *  On success, return a pointer to the ram block.
- *  On failure, return NULL.
- */
-typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
-
-RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
-                                   uint32_t ram_flags, const char *mem_path,
-                                   off_t offset, Error **errp);
-RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
-                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
-                                 uint32_t ram_flags, int fd, off_t offset,
-                                 bool grow,
-                                 Error **errp);
-
-RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
-                                  MemoryRegion *mr, Error **errp);
-RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
-                         Error **errp);
-RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
-                                    qemu_ram_resize_cb resized,
-                                    MemoryRegion *mr, Error **errp);
-void qemu_ram_free(RAMBlock *block);
-
-int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
-
-void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
-
-/* Clear whole block of mem */
-static inline void qemu_ram_block_writeback(RAMBlock *block)
-{
-    qemu_ram_msync(block, 0, block->used_length);
-}
+#define DIRTY_MEMORY_VGA       0
+#define DIRTY_MEMORY_CODE      1
+#define DIRTY_MEMORY_MIGRATION 2
+#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
 
 #endif
diff --git a/include/system/ramblock.h b/include/system/ramblock.h
index 76694fe1b5b..e9f58ac0457 100644
--- a/include/system/ramblock.h
+++ b/include/system/ramblock.h
@@ -14,9 +14,9 @@
 #ifndef SYSTEM_RAMBLOCK_H
 #define SYSTEM_RAMBLOCK_H
 
-#include "exec/cpu-common.h"
 #include "qemu/rcu.h"
-#include "exec/ramlist.h"
+#include "system/ram_addr.h"
+#include "system/ramlist.h"
 #include "system/hostmem.h"
 
 #define TYPE_RAM_BLOCK_ATTRIBUTES "ram-block-attributes"
@@ -130,4 +130,160 @@ static inline void *ramblock_ptr(RAMBlock *block, ram_addr_t offset)
     return (char *)block->host + offset;
 }
 
+/* memory API */
+
+void qemu_ram_remap(ram_addr_t addr);
+/* This should not be used by devices.  */
+ram_addr_t qemu_ram_addr_from_host(void *ptr);
+ram_addr_t qemu_ram_addr_from_host_nofail(void *ptr);
+RAMBlock *qemu_ram_block_by_name(const char *name);
+
+/*
+ * Translates a host ptr back to a RAMBlock and an offset in that RAMBlock.
+ *
+ * @ptr: The host pointer to translate.
+ * @round_offset: Whether to round the result offset down to a target page
+ * @offset: Will be set to the offset within the returned RAMBlock.
+ *
+ * Returns: RAMBlock (or NULL if not found)
+ *
+ * By the time this function returns, the returned pointer is not protected
+ * by RCU anymore.  If the caller is not within an RCU critical section and
+ * does not hold the BQL, it must have other means of protecting the
+ * pointer, such as a reference to the memory region that owns the RAMBlock.
+ */
+RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
+                                   ram_addr_t *offset);
+ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, void *host);
+void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
+void qemu_ram_unset_idstr(RAMBlock *block);
+const char *qemu_ram_get_idstr(RAMBlock *rb);
+void *qemu_ram_get_host_addr(RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_fd_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
+ram_addr_t qemu_ram_get_max_length(RAMBlock *rb);
+bool qemu_ram_is_shared(RAMBlock *rb);
+bool qemu_ram_is_noreserve(RAMBlock *rb);
+bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
+void qemu_ram_set_uf_zeroable(RAMBlock *rb);
+bool qemu_ram_is_migratable(RAMBlock *rb);
+void qemu_ram_set_migratable(RAMBlock *rb);
+void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_named_file(RAMBlock *rb);
+int qemu_ram_get_fd(RAMBlock *rb);
+
+size_t qemu_ram_pagesize(RAMBlock *block);
+size_t qemu_ram_pagesize_largest(void);
+#include "exec/target_page.h"
+#include "exec/hwaddr.h"
+
+extern uint64_t total_dirty_pages;
+
+/**
+ * clear_bmap_size: calculate clear bitmap size
+ *
+ * @pages: number of guest pages
+ * @shift: guest page number shift
+ *
+ * Returns: number of bits for the clear bitmap
+ */
+static inline long clear_bmap_size(uint64_t pages, uint8_t shift)
+{
+    return DIV_ROUND_UP(pages, 1UL << shift);
+}
+
+/**
+ * clear_bmap_set: set clear bitmap for the page range.  Must be with
+ * bitmap_mutex held.
+ *
+ * @rb: the ramblock to operate on
+ * @start: the start page number
+ * @size: number of pages to set in the bitmap
+ *
+ * Returns: None
+ */
+static inline void clear_bmap_set(RAMBlock *rb, uint64_t start,
+                                  uint64_t npages)
+{
+    uint8_t shift = rb->clear_bmap_shift;
+
+    bitmap_set(rb->clear_bmap, start >> shift, clear_bmap_size(npages, shift));
+}
+
+/**
+ * clear_bmap_test_and_clear: test clear bitmap for the page, clear if set.
+ * Must be with bitmap_mutex held.
+ *
+ * @rb: the ramblock to operate on
+ * @page: the page number to check
+ *
+ * Returns: true if the bit was set, false otherwise
+ */
+static inline bool clear_bmap_test_and_clear(RAMBlock *rb, uint64_t page)
+{
+    uint8_t shift = rb->clear_bmap_shift;
+
+    return bitmap_test_and_clear(rb->clear_bmap, page >> shift, 1);
+}
+
+static inline unsigned long int ramblock_recv_bitmap_offset(void *host_addr,
+                                                            RAMBlock *rb)
+{
+    uint64_t host_addr_offset =
+            (uint64_t)(uintptr_t)(host_addr - (void *)rb->host);
+    return host_addr_offset >> TARGET_PAGE_BITS;
+}
+
+/**
+ * qemu_ram_alloc_from_file,
+ * qemu_ram_alloc_from_fd:  Allocate a ram block from the specified backing
+ *                          file or device
+ *
+ * Parameters:
+ *  @size: the size in bytes of the ram block
+ *  @max_size: the maximum size of the block after resizing
+ *  @mr: the memory region where the ram block is
+ *  @resized: callback after calls to qemu_ram_resize
+ *  @ram_flags: RamBlock flags. Supported flags: RAM_SHARED, RAM_PMEM,
+ *              RAM_NORESERVE, RAM_PROTECTED, RAM_NAMED_FILE, RAM_READONLY,
+ *              RAM_READONLY_FD, RAM_GUEST_MEMFD
+ *  @mem_path or @fd: specify the backing file or device
+ *  @offset: Offset into target file
+ *  @grow: extend file if necessary (but an empty file is always extended).
+ *  @errp: pointer to Error*, to store an error if it happens
+ *
+ * Return:
+ *  On success, return a pointer to the ram block.
+ *  On failure, return NULL.
+ */
+typedef void (*qemu_ram_resize_cb)(const char *, uint64_t length, void *host);
+
+RAMBlock *qemu_ram_alloc_from_file(ram_addr_t size, MemoryRegion *mr,
+                                   uint32_t ram_flags, const char *mem_path,
+                                   off_t offset, Error **errp);
+RAMBlock *qemu_ram_alloc_from_fd(ram_addr_t size, ram_addr_t max_size,
+                                 qemu_ram_resize_cb resized, MemoryRegion *mr,
+                                 uint32_t ram_flags, int fd, off_t offset,
+                                 bool grow,
+                                 Error **errp);
+
+RAMBlock *qemu_ram_alloc_from_ptr(ram_addr_t size, void *host,
+                                  MemoryRegion *mr, Error **errp);
+RAMBlock *qemu_ram_alloc(ram_addr_t size, uint32_t ram_flags, MemoryRegion *mr,
+                         Error **errp);
+RAMBlock *qemu_ram_alloc_resizeable(ram_addr_t size, ram_addr_t max_size,
+                                    qemu_ram_resize_cb resized,
+                                    MemoryRegion *mr, Error **errp);
+void qemu_ram_free(RAMBlock *block);
+
+int qemu_ram_resize(RAMBlock *block, ram_addr_t newsize, Error **errp);
+
+void qemu_ram_msync(RAMBlock *block, ram_addr_t start, ram_addr_t length);
+
+/* Clear whole block of mem */
+static inline void qemu_ram_block_writeback(RAMBlock *block)
+{
+    qemu_ram_msync(block, 0, block->used_length);
+}
 #endif
diff --git a/include/exec/ramlist.h b/include/system/ramlist.h
similarity index 94%
rename from include/exec/ramlist.h
rename to include/system/ramlist.h
index d9cfe530bea..c7f388f487d 100644
--- a/include/exec/ramlist.h
+++ b/include/system/ramlist.h
@@ -5,14 +5,10 @@
 #include "qemu/thread.h"
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
+#include "system/ram_addr.h"
 
 typedef struct RAMBlockNotifier RAMBlockNotifier;
 
-#define DIRTY_MEMORY_VGA       0
-#define DIRTY_MEMORY_CODE      1
-#define DIRTY_MEMORY_MIGRATION 2
-#define DIRTY_MEMORY_NUM       3        /* num of dirty bits */
-
 /* The dirty memory bitmap is split into fixed-size blocks to allow growth
  * under RCU.  The bitmap for a block can be accessed as follows:
  *
@@ -75,6 +71,10 @@ struct RAMBlockNotifier {
     QLIST_ENTRY(RAMBlockNotifier) next;
 };
 
+typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
+
+int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
+
 void ram_block_notifier_add(RAMBlockNotifier *n);
 void ram_block_notifier_remove(RAMBlockNotifier *n);
 void ram_block_notify_add(void *host, size_t size, size_t max_size);
diff --git a/include/system/xen-mapcache.h b/include/system/xen-mapcache.h
index bb454a7c96c..fa2cff38d1a 100644
--- a/include/system/xen-mapcache.h
+++ b/include/system/xen-mapcache.h
@@ -9,7 +9,6 @@
 #ifndef XEN_MAPCACHE_H
 #define XEN_MAPCACHE_H
 
-#include "exec/cpu-common.h"
 #include "system/xen.h"
 
 typedef hwaddr (*phys_offset_to_gaddr_t)(hwaddr phys_offset,
diff --git a/include/system/xen.h b/include/system/xen.h
index c2f283d1c26..9a7c53f2838 100644
--- a/include/system/xen.h
+++ b/include/system/xen.h
@@ -10,7 +10,8 @@
 #ifndef SYSTEM_XEN_H
 #define SYSTEM_XEN_H
 
-#include "exec/cpu-common.h"
+#include "exec/hwaddr.h"
+#include "system/ram_addr.h"
 
 #ifdef COMPILING_PER_TARGET
 # ifdef CONFIG_XEN
diff --git a/migration/migration.h b/migration/migration.h
index fbe02d5bb1a..43fbe5488ca 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -14,7 +14,8 @@
 #ifndef QEMU_MIGRATION_H
 #define QEMU_MIGRATION_H
 
-#include "exec/cpu-common.h"
+#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "hw/core/qdev.h"
 #include "qapi/qapi-types-migration.h"
 #include "qobject/json-writer.h"
diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
index 47c67ef8cc9..4675cb886fe 100644
--- a/accel/mshv/mshv-all.c
+++ b/accel/mshv/mshv-all.c
@@ -31,6 +31,7 @@
 #include "qemu/guest-random.h"
 #include "accel/accel-ops.h"
 #include "accel/accel-cpu-ops.h"
+#include "exec/cpu-common.h"
 #include "system/cpus.h"
 #include "system/runstate.h"
 #include "system/accel-blocker.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index fd1606c8565..655d1e113f9 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -30,7 +30,7 @@
 #include "accel/tcg/cpu-mmu-index.h"
 #include "exec/cputlb.h"
 #include "exec/tb-flush.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "exec/mmu-access-type.h"
 #include "exec/tlb-common.h"
 #include "exec/vaddr.h"
diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index 89299829c3a..4160e2ba947 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -24,6 +24,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-common.h"
 #include "system/tcg.h"
 #include "system/replay.h"
 #include "exec/icount.h"
diff --git a/backends/hostmem.c b/backends/hostmem.c
index 67827c42b87..15d4365b697 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "system/hostmem.h"
+#include "system/ramblock.h"
 #include "hw/core/boards.h"
 #include "qapi/error.h"
 #include "qapi/qapi-builtin-visit.h"
diff --git a/block/blkio.c b/block/blkio.c
index 41426739847..20f138a38c5 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -12,7 +12,7 @@
 #include <blkio.h>
 #include "block/block_int.h"
 #include "system/memory.h"
-#include "exec/cpu-common.h" /* for qemu_ram_get_fd() */
+#include "system/ramblock.h"
 #include "qemu/defer-call.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/dump/dump.c b/dump/dump.c
index 15bbcc0c619..f7a99a7af2e 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -15,6 +15,7 @@
 #include "qemu/cutils.h"
 #include "elf.h"
 #include "qemu/bswap.h"
+#include "exec/cpu-common.h"
 #include "exec/target_page.h"
 #include "monitor/monitor.h"
 #include "system/dump.h"
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 06555905ceb..365156dff90 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/generic_event_device.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qemu/uuid.h"
+#include "exec/cpu-common.h"
 
 #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
 #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 732d613ac09..eb4b4770765 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -36,6 +36,7 @@
 #include "hw/mem/nvdimm.h"
 #include "qemu/nvdimm-utils.h"
 #include "trace.h"
+#include "exec/cpu-common.h"
 
 /*
  * define Byte Addressable Persistent Memory (PM) Region according to
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index e87c0256964..70ad029057b 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -21,6 +21,7 @@
 #include "hw/core/qdev-properties-system.h"
 #include "migration/vmstate.h"
 #include "system/reset.h"
+#include "exec/cpu-common.h"
 
 void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
                         BIOSLinker *linker, const char *oem_id)
diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index f5ff4b107ae..9ca8eecfa09 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -24,6 +24,7 @@
 #include "qapi/error.h"
 #include "cpu.h"
 #include "system/address-spaces.h"
+#include "exec/cpu-common.h"
 #include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/audio/marvell_88w8618.c b/hw/audio/marvell_88w8618.c
index 6d5e99123d6..4ad4a220a98 100644
--- a/hw/audio/marvell_88w8618.c
+++ b/hw/audio/marvell_88w8618.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
index a78ea9b01c0..e9efab16e99 100644
--- a/hw/char/riscv_htif.c
+++ b/hw/char/riscv_htif.c
@@ -31,6 +31,7 @@
 #include "system/address-spaces.h"
 #include "system/dma.h"
 #include "system/runstate.h"
+#include "exec/cpu-common.h"
 #include "trace.h"
 
 #define HTIF_DEV_SHIFT          56
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 2e925880afa..6d54c12a778 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "exec/cpu-common.h"
 #include "qapi/error.h"
 #include "hw/core/cpu.h"
 #include "system/hw_accel.h"
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index d23466177d8..79cbcdd63e8 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -26,6 +26,7 @@
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
 #include "system/numa.h"
+#include "system/ramlist.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
diff --git a/hw/core/numa.c b/hw/core/numa.c
index fa78dacb6be..f462883c87c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -27,7 +27,8 @@
 #include "system/hostmem.h"
 #include "system/numa.h"
 #include "exec/cpu-common.h"
-#include "exec/ramlist.h"
+#include "system/ramlist.h"
+#include "system/ramblock.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qapi/opts-visitor.h"
diff --git a/hw/display/exynos4210_fimd.c b/hw/display/exynos4210_fimd.c
index a97054132fb..2d8fa7ee944 100644
--- a/hw/display/exynos4210_fimd.c
+++ b/hw/display/exynos4210_fimd.c
@@ -27,6 +27,7 @@
 #include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/omap_lcdc.c b/hw/display/omap_lcdc.c
index 90a97314541..c41c65bb2e0 100644
--- a/hw/display/omap_lcdc.c
+++ b/hw/display/omap_lcdc.c
@@ -23,6 +23,7 @@
 #include "hw/arm/omap.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
+#include "exec/cpu-common.h"
 
 struct omap_lcd_panel_s {
     MemoryRegion *sysmem;
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index ad12fb1782e..50c25706a52 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -18,6 +18,7 @@
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
 #include "system/reset.h"
+#include "exec/cpu-common.h"
 
 struct QEMU_PACKED RAMFBCfg {
     uint64_t addr;
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 90b89cf4044..59a65cbbff5 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "system/reset.h"
+#include "system/ramblock.h"
 #include "qapi/error.h"
 #include "qemu/target-info.h"
 #include "hw/display/vga.h"
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index d909d6c8fc2..3637d8f82d7 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -27,6 +27,7 @@
 #include "hw/core/qdev-properties.h"
 #include "migration/vmstate.h"
 #include "hw/dma/i8257.h"
+#include "exec/cpu-common.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 2bf9ebad565..963ce6fd102 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -23,6 +23,7 @@
 #include "hw/arm/omap.h"
 #include "hw/core/irq.h"
 #include "hw/arm/soc_dma.h"
+#include "exec/cpu-common.h"
 
 struct omap_dma_channel_s {
     /* transfer data */
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 93db286e690..159d0173913 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -27,6 +27,7 @@
 #include "hw/core/irq.h"
 #include "hw/mips/mips.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 2844515b2d7..6d06ec0375f 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -27,6 +27,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "system/dma.h"
 #include "hw/dma/sifive_pdma.h"
diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index e4d0688dbfa..27e323a8196 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -14,6 +14,7 @@
 #include "system/address-spaces.h"
 #include "system/memory.h"
 #include "exec/target_page.h"
+#include "exec/cpu-common.h"
 #include "linux/kvm.h"
 #include "system/kvm.h"
 #include "qemu/bitops.h"
diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
index dc6cc84b503..1e177f9dd82 100644
--- a/hw/hyperv/syndbg.c
+++ b/hw/hyperv/syndbg.c
@@ -19,6 +19,7 @@
 #include "hw/hyperv/hyperv.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/hyperv/hyperv-proto.h"
+#include "exec/cpu-common.h"
 #include "net/net.h"
 #include "net/eth.h"
 #include "net/checksum.h"
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c01f3392360..c5bab5d2452 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -19,6 +19,7 @@
 #include "hw/hyperv/vmbus.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "exec/target_page.h"
 #include "trace.h"
 
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 8ca88afae24..aba6842a22c 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -24,6 +24,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/i386/kvm/clock.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/cpu-common.h"
 #include "qapi/error.h"
 
 #include <linux/kvm.h>
diff --git a/hw/i386/vapic.c b/hw/i386/vapic.c
index 32f92a28b88..670a50524d6 100644
--- a/hw/i386/vapic.c
+++ b/hw/i386/vapic.c
@@ -21,6 +21,7 @@
 #include "hw/i386/apic_internal.h"
 #include "hw/core/sysbus.h"
 #include "hw/core/boards.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
 
diff --git a/hw/intc/apic.c b/hw/intc/apic.c
index aad253af158..dd8c77f8180 100644
--- a/hw/intc/apic.c
+++ b/hw/intc/apic.c
@@ -30,6 +30,7 @@
 #include "system/mshv.h"
 #include "trace.h"
 #include "hw/i386/apic-msidef.h"
+#include "exec/cpu-common.h"
 #include "qapi/error.h"
 #include "qom/object.h"
 
diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
index 495925196a8..d353391208e 100644
--- a/hw/intc/xive2.c
+++ b/hw/intc/xive2.c
@@ -17,6 +17,7 @@
 #include "hw/ppc/xive.h"
 #include "hw/ppc/xive2.h"
 #include "hw/ppc/xive2_regs.h"
+#include "exec/cpu-common.h"
 #include "trace.h"
 
 static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index ca3df7b887b..26177c7b867 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "exec/hwaddr.h"
+#include "exec/cpu-common.h"
 #include "exec/cpu-interrupt.h"
 #include "system/system.h"
 #include "system/qtest.h"
diff --git a/hw/microblaze/boot.c b/hw/microblaze/boot.c
index 8ff99b3339d..a6f9ebab90c 100644
--- a/hw/microblaze/boot.c
+++ b/hw/microblaze/boot.c
@@ -33,6 +33,7 @@
 #include "qemu/guest-random.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
+#include "exec/cpu-common.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
 #include "elf.h"
diff --git a/hw/misc/pc-testdev.c b/hw/misc/pc-testdev.c
index 4093cb3c99c..228012e772f 100644
--- a/hw/misc/pc-testdev.c
+++ b/hw/misc/pc-testdev.c
@@ -39,6 +39,7 @@
 #include "qemu/module.h"
 #include "hw/core/irq.h"
 #include "hw/isa/isa.h"
+#include "exec/cpu-common.h"
 #include "qom/object.h"
 
 #define IOMEM_LEN    0x10000
diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 42216de6c9a..22660c32b84 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -26,6 +26,7 @@
 #include "qemu/log.h"
 #include "etsec.h"
 #include "registers.h"
+#include "exec/cpu-common.h"
 
 /* #define ETSEC_RING_DEBUG */
 /* #define HEX_DUMP */
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 5f267e5ea38..79a5c4385c6 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -16,6 +16,7 @@
 #include "hw/net/mii.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include <zlib.h> /* for crc32 */
 
 //#define DEBUG_FEC 1
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index ec3301414cc..6abeffcc9c7 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -36,6 +36,7 @@
 #include "hw/net/mii.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "net/net.h"
 #include "qemu/module.h"
 #include "net/eth.h"
diff --git a/hw/net/xgmac.c b/hw/net/xgmac.c
index 8d316e94c17..204c78aba37 100644
--- a/hw/net/xgmac.c
+++ b/hw/net/xgmac.c
@@ -28,6 +28,7 @@
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/sysbus.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "net/net.h"
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index 58d81f77c88..3af7e6ecbec 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -38,6 +38,7 @@
 #include "hw/ppc/spapr_vio.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
+#include "exec/cpu-common.h"
 #include "qom/object.h"
 
 struct SpaprNvram {
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index 4b858443806..8074713fbe9 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -21,6 +21,7 @@
 #include "hw/ide/pci.h"
 #include "hw/i2c/smbus_eeprom.h"
 #include "hw/ppc/ppc.h"
+#include "exec/cpu-common.h"
 #include "system/block-backend.h"
 #include "system/qtest.h"
 #include "system/reset.h"
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 113a2daca1d..eb0d3a418e2 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -52,6 +52,7 @@
 #include "hw/core/irq.h"
 #include "hw/sd/sdhci.h"
 #include "hw/misc/unimp.h"
+#include "exec/cpu-common.h"
 
 #define EPAPR_MAGIC                (0x45504150)
 #define DTC_LOAD_PAD               0x1800000
diff --git a/hw/ppc/pegasos.c b/hw/ppc/pegasos.c
index 3e4d19fbe84..ac9fc5a6542 100644
--- a/hw/ppc/pegasos.c
+++ b/hw/ppc/pegasos.c
@@ -39,6 +39,7 @@
 #include "qemu/datadir.h"
 #include "system/device_tree.h"
 #include "hw/ppc/vof.h"
+#include "exec/cpu-common.h"
 
 #include <libfdt.h>
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f891c3a797c..1513575b8f3 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -58,6 +58,7 @@
 #include "hw/isa/isa.h"
 #include "hw/char/serial-isa.h"
 #include "hw/rtc/mc146818rtc.h"
+#include "exec/cpu-common.h"
 
 #include <libfdt.h>
 
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index fc6dd332e88..0f28a7937fb 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -17,6 +17,7 @@
 #include "hw/pci-host/ppc4xx.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci.h"
+#include "exec/cpu-common.h"
 #include "system/reset.h"
 #include "cpu.h"
 #include "ppc440.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index eb626547ebd..bcf6aa560f3 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -43,6 +43,7 @@
 #include "system/reset.h"
 #include "system/runstate.h"
 #include "qemu/log.h"
+#include "exec/cpu-common.h"
 #include "hw/core/fw-path-provider.h"
 #include "elf.h"
 #include "net/net.h"
diff --git a/hw/ppc/spapr_drc.c b/hw/ppc/spapr_drc.c
index d2044b4fb52..9bc65c760ea 100644
--- a/hw/ppc/spapr_drc.c
+++ b/hw/ppc/spapr_drc.c
@@ -23,6 +23,7 @@
 #include "hw/ppc/spapr.h" /* for RTAS return codes */
 #include "hw/pci-host/spapr.h" /* spapr_phb_remove_pci_device_cb callback */
 #include "hw/ppc/spapr_nvdimm.h"
+#include "exec/cpu-common.h"
 #include "system/device_tree.h"
 #include "system/reset.h"
 #include "trace.h"
diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index b1774e88f2b..1a21ac7bbf8 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -41,6 +41,7 @@
 #include "qemu/bcd.h"
 #include "qemu/main-loop.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "exec/cpu-common.h"
 #include <libfdt.h>
 #include "migration/blocker.h"
 
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8f03b3e7764..032805a8d0d 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -24,6 +24,7 @@
 #include "hw/ppc/spapr_numa.h"
 #include "mmu-book3s-v3.h"
 #include "hw/mem/memory-device.h"
+#include "exec/cpu-common.h"
 
 bool is_ram_address(SpaprMachineState *spapr, hwaddr addr)
 {
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index a6715b4026d..cb79ad34053 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -46,6 +46,7 @@
 #include "qemu/cutils.h"
 #include "trace.h"
 #include "hw/ppc/fdt.h"
+#include "exec/cpu-common.h"
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
 #include "migration/blocker.h"
diff --git a/hw/ppc/spapr_tpm_proxy.c b/hw/ppc/spapr_tpm_proxy.c
index a48dab7e7a6..361a3dc817d 100644
--- a/hw/ppc/spapr_tpm_proxy.c
+++ b/hw/ppc/spapr_tpm_proxy.c
@@ -16,6 +16,7 @@
 #include "system/reset.h"
 #include "hw/ppc/spapr.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/cpu-common.h"
 #include "trace.h"
 
 #define TPM_SPAPR_BUFSIZE 4096
diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
index 8b3e67b627c..51b3d7d7121 100644
--- a/hw/ppc/virtex_ml507.c
+++ b/hw/ppc/virtex_ml507.c
@@ -44,6 +44,7 @@
 #include "hw/ppc/ppc.h"
 #include "hw/ppc/ppc4xx.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/cpu-common.h"
 
 #include <libfdt.h>
 
diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
index e1a52d24f0b..d0c856b0939 100644
--- a/hw/remote/proxy-memory-listener.c
+++ b/hw/remote/proxy-memory-listener.c
@@ -11,6 +11,7 @@
 #include "qemu/int128.h"
 #include "qemu/range.h"
 #include "system/memory.h"
+#include "system/ramblock.h"
 #include "exec/cpu-common.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index d2c0af6a9bf..ccc9c1c243b 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -22,6 +22,7 @@
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/s390-ccw.h"
+#include "exec/cpu-common.h"
 
 typedef struct CrwContainer {
     CRW crw;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index b119a87a864..d34adb55220 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -28,6 +28,7 @@
 #include "hw/s390x/ebcdic.h"
 #include "hw/scsi/scsi.h"
 #include "hw/virtio/virtio-net.h"
+#include "exec/cpu-common.h"
 #include "ipl.h"
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index ff415b6312d..30fdca1e8a6 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -25,6 +25,7 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/msi.h"
+#include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/reset.h"
diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
index 4a3ffb84f8f..b4011c4049d 100644
--- a/hw/s390x/virtio-ccw.c
+++ b/hw/s390x/virtio-ccw.c
@@ -32,6 +32,7 @@
 #include "trace.h"
 #include "hw/s390x/css-bridge.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "exec/cpu-common.h"
 #include "system/replay.h"
 
 #define NR_CLASSIC_INDICATOR_BITS 64
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index b3cdc255b46..11ae6b9b747 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -34,6 +34,7 @@
 #include "scsi/constants.h"
 #include "hw/pci/msi.h"
 #include "hw/core/qdev-properties.h"
+#include "exec/cpu-common.h"
 #include "vmw_pvscsi.h"
 #include "trace.h"
 #include "qom/object.h"
diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index ec9a386b48d..d4e25f761a6 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "qemu/datadir.h"
+#include "exec/cpu-common.h"
 #include "cpu.h"
 #include "hw/core/irq.h"
 #include "qemu/timer.h"
diff --git a/hw/vfio-user/container.c b/hw/vfio-user/container.c
index dab7a23224c..d5275a463b8 100644
--- a/hw/vfio-user/container.c
+++ b/hw/vfio-user/container.c
@@ -15,6 +15,7 @@
 #include "hw/vfio-user/trace.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/vfio/vfio-listener.h"
+#include "system/ramblock.h"
 #include "qapi/error.h"
 
 /*
diff --git a/hw/vfio/container.c b/hw/vfio/container.c
index 013a691bc5a..5993d905457 100644
--- a/hw/vfio/container.c
+++ b/hw/vfio/container.c
@@ -15,7 +15,7 @@
 #include <linux/vfio.h>
 
 #include "system/tcg.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "hw/vfio/vfio-container.h"
diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
index 2cbc7b4964f..c595f860cea 100644
--- a/hw/vfio/helpers.c
+++ b/hw/vfio/helpers.c
@@ -23,6 +23,7 @@
 #include <sys/ioctl.h>
 
 #include "system/kvm.h"
+#include "exec/cpu-common.h"
 #include "hw/vfio/vfio-device.h"
 #include "hw/core/hw-error.h"
 #include "qapi/error.h"
diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
index fde343f06e3..58a4940b00e 100644
--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -27,7 +27,7 @@
 #include "migration-multifd.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-vfio.h"
-#include "exec/ramlist.h"
+#include "system/ramlist.h"
 #include "pci.h"
 #include "trace.h"
 #include "hw/core/hw-error.h"
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 266a11514a1..2e33e78e775 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -28,6 +28,7 @@
 #include "migration/qemu-file-types.h"
 #include "system/dma.h"
 #include "system/memory.h"
+#include "system/ramblock.h"
 #include "trace.h"
 
 /* enabled until disconnected backend stabilizes */
diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index e31d3797025..11115f60845 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -18,6 +18,7 @@
 #include "hw/xen/xen_native.h"
 #include "qemu/bitmap.h"
 
+#include "system/ramlist.h"
 #include "system/runstate.h"
 #include "system/xen-mapcache.h"
 #include "trace.h"
diff --git a/hw/xen/xen_pt_graphics.c b/hw/xen/xen_pt_graphics.c
index 2c0cec97234..445f33e1726 100644
--- a/hw/xen/xen_pt_graphics.c
+++ b/hw/xen/xen_pt_graphics.c
@@ -5,6 +5,7 @@
 #include "qapi/error.h"
 #include "hw/xen/xen_pt.h"
 #include "hw/xen/xen_igd.h"
+#include "exec/cpu-common.h"
 #include "xen-host-pci-device.h"
 
 static unsigned long igd_guest_opregion;
diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 5e6f897429d..d427d68e505 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -49,6 +49,7 @@
 #include "bootparam.h"
 #include "xtensa_memory.h"
 #include "hw/xtensa/mx_pic.h"
+#include "exec/cpu-common.h"
 #include "migration/vmstate.h"
 
 typedef struct XtfpgaFlashDesc {
diff --git a/migration/ram.c b/migration/ram.c
index 6b469238ad2..a57f4f49b34 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -48,7 +48,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "trace.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "exec/target_page.h"
 #include "qemu/rcu_queue.h"
 #include "migration/colo.h"
diff --git a/stubs/physmem.c b/stubs/physmem.c
index 1fc5f2df29f..14667f2bd8f 100644
--- a/stubs/physmem.c
+++ b/stubs/physmem.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "exec/cpu-common.h"
+#include "system/ramblock.h"
 
 RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
                                    ram_addr_t *offset)
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index e88fab31a5d..8790a59593e 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
-#include "exec/ramlist.h"
-#include "exec/cpu-common.h"
+#include "system/ramlist.h"
+#include "system/ramblock.h"
 #include "system/memory.h"
 
 void *qemu_ram_get_host_addr(RAMBlock *rb)
diff --git a/system/ioport.c b/system/ioport.c
index 4f96e9119fc..801e2490c36 100644
--- a/system/ioport.c
+++ b/system/ioport.c
@@ -29,6 +29,7 @@
 #include "system/ioport.h"
 #include "system/memory.h"
 #include "system/address-spaces.h"
+#include "hw/core/qdev.h"
 #include "trace.h"
 
 struct MemoryRegionPortioList {
diff --git a/system/memory.c b/system/memory.c
index b65219c2e49..25950756604 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -26,7 +26,7 @@
 #include "qom/object.h"
 #include "trace.h"
 #include "system/physmem.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "system/kvm.h"
 #include "system/runstate.h"
 #include "system/tcg.h"
diff --git a/system/physmem.c b/system/physmem.c
index e3221ce00de..2547687d137 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -68,7 +68,7 @@
 #include "qemu/main-loop.h"
 #include "system/replay.h"
 
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 
 #include "qemu/pmem.h"
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 12a63602b11..48f853fff80 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -22,6 +22,7 @@
 #include "qapi/error.h"
 #include "system/system.h"
 #include "system/runstate.h"
+#include "system/ramblock.h"
 #include "system/kvm.h"
 #include "system/kvm_int.h"
 #include "kvm_arm.h"
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 60c79811382..e98da47a451 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -35,6 +35,7 @@
 #include "system/hw_accel.h"
 #include "system/kvm_int.h"
 #include "system/runstate.h"
+#include "system/ramblock.h"
 #include "kvm_i386.h"
 #include "../confidential-guest.h"
 #include "sev.h"
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013b..fb5a3b5d778 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -41,6 +41,7 @@
 #include "confidential-guest.h"
 #include "hw/i386/pc.h"
 #include "system/address-spaces.h"
+#include "system/ramlist.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "qemu/queue.h"
 #include "qemu/cutils.h"
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 2c96eca584e..3b2f1077da6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -41,7 +41,7 @@
 #include "trace.h"
 #include "gdbstub/enums.h"
 #include "exec/memattrs.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "system/hostmem.h"
 #include "qemu/cutils.h"
 #include "qemu/main-loop.h"
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 916dac1f14e..fe3bf408dda 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -41,7 +41,7 @@
 #include "system/runstate.h"
 #include "system/device_tree.h"
 #include "gdbstub/enums.h"
-#include "system/ram_addr.h"
+#include "system/ramblock.h"
 #include "trace.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index fdff042ab46..44b457c442f 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -14,7 +14,7 @@
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qapi/error.h"
-#include "exec/ramlist.h"
+#include "system/ramlist.h"
 #include "exec/cpu-common.h"
 #include "system/memory.h"
 #include "trace.h"
-- 
2.51.1


