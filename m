Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A505CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvM1-0002Qr-5D; Wed, 14 Oct 2026 05:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLy-0002PC-Oi
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:54 -0400
Received: from mail-dl1-x122d.google.com ([2607:f8b0:4864:20::122d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvLu-0000N5-BQ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:32:54 -0400
Received: by mail-dl1-x122d.google.com with SMTP id
 a92af1059eb24-1517bda04a0so2465574c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970367; x=1792575167; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6xYuinyraJZ3kNDPg1OnLvsNSqJAVrLxx26GE6Un3go=;
 b=nCv5pVL8huLemWSbYHCyv0gsMwpH+yw2m+n/KguXxAv/zS2YY8Ntyf6lKUP9SnXsix
 sABanaX1WMTjrxWa017hncqn2X8AD9hGHyFMKRcWuuALlBijRCRERzrPMlS22Uz5nWNi
 i2/4oeV46UGPN8ClJkRDz26Oe47Gsu46ECvr9TI12as5wvVueMdyHSjNCkY0ZAnuWsWG
 udE+wUnPfJ8iIlDzD30hh7xFb9F7D/3u6ozpOXtNc3bs8aaT8cQ5C/xcCkWXeQmz6nQv
 SAEDdZzZRROq7RLqRudTOHLR/lS4B7zI2goe6oQ1Z0kNhELPU6w0pwfHzl6vLK+2J/No
 upWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970367; x=1792575167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6xYuinyraJZ3kNDPg1OnLvsNSqJAVrLxx26GE6Un3go=;
 b=OufPtsQciyapni3nALs/2w4rGpmDmOMeONtxb5hGX4b69whi6VJOJWraZrcpQPW3Gt
 AO09fsvRSc0q3bBHJUEJeo4sTLIAx69fLm14msQBmPGAgADZMxbIrTPhihDn4n8HQLhd
 plpCHvLsVGU3fVgvd0bVH76xgKv9XnvTgeWx0VzDGzA4bzgre4uMgtO4SHz2rJqZcQN1
 zNy+ICZYN4aUnF43uwGTl8a/3i7r2UdMHFd+9OTEe9pLn9V5o22HBgwS0pKtEWZR2vP5
 uZbbStb4tIysycVSdSl5A6PceHFcahpMTFWrARby5lMdrNJ1pQWg1sm3P1iG3fb1ZOLd
 98vw==
X-Gm-Message-State: AFq9FYIe3MOp5C6Mt86QDJ/8r/HNqWK0yAwOVtDYpBS1qaSxWgDJdLKz
 zpWoU3iydCtLO6Gvv/59pADrXLEFxFaIPQToBnFezQgqkplNsfypB1AOd0Y20xhUHQg=
X-Gm-Gg: AYBFou2zlXdnTKgwtoDR9G7d6MKejEhTy3vhSjQ0jnKgpKLnhqF1dRUA0Bn56KVeQic
 o38l9cp5BCGElV8SJzMqNStd+9oYTb6bv7bLg2nYgY/jLUlGaV2C4vFd/O/5HS3rBZG1j6hgUcx
 aXKZks9cNfU3Ed4sShv1ReQ/XhyYbwi5c26gj5HWnOOA3/alX7AtecoCR5Uljf1hvsxIWBJtNaD
 SfLp5QU10ZmBYaNciA+Pwb5Dhi2wlXLbDistG4gZ0I/QNN2nAKHtNnrwSWQp4UVzHjXgnVd/U0G
 4D5hv0L4YPIqTk+XXhslMnNckfMatzzjesHy0kuoDfr5K7WO5Wybk/cwMEEnXiN6r0+Yi3oJa5q
 gVRy5nYLcYDUig9X7aO0Ai4rJfyH+8FC/K4yu0kDTO9fysnZlkRBMFzTGLu1hLw/TAf6lal3p68
 tHFmtwKTbWj4jSpUGsLVMlXr11nr9sp8KQfdDDJ4DZodxuS5HtYbAugJ5ghVdjPaksVMAiBNCK5
 w0umIF5i5iX9iogOw==
X-Received: by 2002:a05:701b:261b:b0:154:dc96:c1d8 with SMTP id
 a92af1059eb24-16a54ad2602mr27976993c88.2.1791970366860; 
 Wed, 14 Oct 2026 02:32:46 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1698de65af7sm48769303c88.0.2026.10.14.02.32.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:32:45 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-riscv@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-s390x@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Farman <farman@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Ani Sinha <anisinha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@kernel.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 Chao Liu <chao.liu@processmission.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 04/34] qapi: rename SysEmuTarget to EmuTarget
Date: Wed, 14 Oct 2026 17:31:14 +0800
Message-ID: <20261014093152.834-5-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014093152.834-1-luoyonggang@gmail.com>
References: <20261014093152.834-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122d;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

As now it's also expressing user-mode targets.

This changes the type name exposed by query-qmp-schema; enum values and
serialized target values remain unchanged.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 backends/igvm.c                 |  4 +--
 hw/core/machine-qmp-cmds.c      |  2 +-
 hw/misc/vmlaunchupdate.c        |  6 ++--
 hw/uefi/ovmf-log.c              |  4 +--
 hw/virtio/virtio-mem.c          | 14 ++++----
 include/qemu/base-arch-defs.h   | 62 ++++++++++++++++-----------------
 include/qemu/target-info-def.h  |  2 +-
 include/qemu/target-info-qapi.h |  4 +--
 qapi/machine.json               |  8 ++---
 qapi/pragma.json                |  4 +--
 target-info-def.c               |  2 +-
 target-info.c                   | 26 +++++++-------
 12 files changed, 69 insertions(+), 69 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 58f3097e851..f4045bb8651 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -535,7 +535,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
             vp_context->gpa, data,
             igvm_get_buffer_size(ctx->cfg->file, data_handle),
             CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
-    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
+    } else if (target_arch() == EMU_TARGET_X86_64) {
         result = qigvm_x86_set_vp_context(data, vp_context->vp_index, errp);
     } else {
         error_setg(
@@ -647,7 +647,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     if (ctx->machine_state->cgs && ctx->cgsc->get_mem_map_entry) {
         get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
 
-    } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
+    } else if (target_arch() == EMU_TARGET_X86_64) {
         get_mem_map_entry = qigvm_x86_get_mem_map_entry;
 
     } else {
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 9c08b17510a..bc614a75c7d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -64,7 +64,7 @@ CpuInfoFastList *qmp_query_cpus_fast(Error **errp)
     MachineState *ms = MACHINE(qdev_get_machine());
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     CpuInfoFastList *head = NULL, **tail = &head;
-    SysEmuTarget target = target_arch();
+    EmuTarget target = target_arch();
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
diff --git a/hw/misc/vmlaunchupdate.c b/hw/misc/vmlaunchupdate.c
index 847d2d963f1..95cb2263828 100644
--- a/hw/misc/vmlaunchupdate.c
+++ b/hw/misc/vmlaunchupdate.c
@@ -35,7 +35,7 @@ static VMLaunchUpdateState *vm_launchupdate_find(void)
 
 static bool vmlaunchupdate_supported(void)
 {
-    return target_arch() == SYS_EMU_TARGET_X86_64;
+    return target_arch() == EMU_TARGET_X86_64;
 }
 
 static void init_vm_launch_update(VMLaunchUpdateState *s)
@@ -192,7 +192,7 @@ static void launch_update_write(void *dev, off_t offset, size_t len)
 
     /* process guest provided IGVM image */
     if (s->launch_update.control & VM_LAUNCHUPDATE_FORMAT_IGVM) {
-        if (target_arch() == SYS_EMU_TARGET_X86_64) {
+        if (target_arch() == EMU_TARGET_X86_64) {
             addr = le64_to_cpu(s->launch_update.fw_image_addr);
             size = le64_to_cpu(s->launch_update.fw_image_size);
             rc = process_x86_igvm(s, addr, size);
@@ -229,7 +229,7 @@ static void vmlaunch_reset_enter(Object *obj, ResetType type)
 {
     VMLaunchUpdateState *s = VMLAUNCHUPDATE(obj);
 
-    if (target_arch() != SYS_EMU_TARGET_X86_64) {
+    if (target_arch() != EMU_TARGET_X86_64) {
         return;
     }
 
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
index c4e6a506410..2d8961b80ec 100644
--- a/hw/uefi/ovmf-log.c
+++ b/hw/uefi/ovmf-log.c
@@ -114,7 +114,7 @@ static dma_addr_t find_ovmf_log(void)
     MachineState *ms = MACHINE(qdev_get_machine());
     dma_addr_t start, end, offset;
 
-    if (target_arch() == SYS_EMU_TARGET_X86_64 &&
+    if (target_arch() == EMU_TARGET_X86_64 &&
         object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
         X86MachineState *x86ms = X86_MACHINE(ms);
 
@@ -133,7 +133,7 @@ static dma_addr_t find_ovmf_log(void)
         return find_ovmf_log_range(start, end);
     }
 
-    if (target_arch() == SYS_EMU_TARGET_AARCH64 &&
+    if (target_arch() == EMU_TARGET_AARCH64 &&
         object_dynamic_cast(OBJECT(ms), TYPE_VIRT_MACHINE)) {
         VirtMachineState *vms = VIRT_MACHINE(ms);
 
diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index 7130ed852d9..a4110d61312 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -43,8 +43,8 @@ static bool virtio_mem_has_legacy_guests(void)
      * legacy guests.
      */
     switch (target_arch()) {
-    case SYS_EMU_TARGET_I386:
-    case SYS_EMU_TARGET_X86_64:
+    case EMU_TARGET_I386:
+    case EMU_TARGET_X86_64:
         return true;
     default:
         return false;
@@ -181,12 +181,12 @@ static bool virtio_mem_has_shared_zeropage(RAMBlock *rb)
 static uint64_t virtio_mem_usable_extent_size(void)
 {
     switch (target_arch()) {
-    case SYS_EMU_TARGET_I386:
-    case SYS_EMU_TARGET_X86_64:
-    case SYS_EMU_TARGET_S390X:
+    case EMU_TARGET_I386:
+    case EMU_TARGET_X86_64:
+    case EMU_TARGET_S390X:
         return 2 * 128 * MiB;
-    case SYS_EMU_TARGET_AARCH64:
-    case SYS_EMU_TARGET_ARM:
+    case EMU_TARGET_AARCH64:
+    case EMU_TARGET_ARM:
         return 2 * 512 * MiB;
     default:
         g_assert_not_reached();
diff --git a/include/qemu/base-arch-defs.h b/include/qemu/base-arch-defs.h
index f2e3bc54203..7ddecc3d0be 100644
--- a/include/qemu/base-arch-defs.h
+++ b/include/qemu/base-arch-defs.h
@@ -12,40 +12,40 @@
 #define QEMU_ARCH_BIT(target) (1ULL << (target))
 
 enum {
-    QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(SYS_EMU_TARGET_ALPHA),
-    QEMU_ARCH_ARM =         QEMU_ARCH_BIT(SYS_EMU_TARGET_ARM) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_AARCH64),
-    QEMU_ARCH_I386 =        QEMU_ARCH_BIT(SYS_EMU_TARGET_I386) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_X86_64),
-    QEMU_ARCH_M68K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_M68K),
-    QEMU_ARCH_MICROBLAZE =  QEMU_ARCH_BIT(SYS_EMU_TARGET_MICROBLAZE),
-    QEMU_ARCH_MIPS =        QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPSEL) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_MIPS64EL),
-    QEMU_ARCH_PPC =         QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_PPC64),
-    QEMU_ARCH_S390X =       QEMU_ARCH_BIT(SYS_EMU_TARGET_S390X),
-    QEMU_ARCH_SH4 =         QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SH4EB),
-    QEMU_ARCH_SPARC =       QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_SPARC64),
-    QEMU_ARCH_XTENSA =      QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSA) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_XTENSAEB),
-    QEMU_ARCH_OR1K =        QEMU_ARCH_BIT(SYS_EMU_TARGET_OR1K),
-    QEMU_ARCH_TRICORE =     QEMU_ARCH_BIT(SYS_EMU_TARGET_TRICORE),
-    QEMU_ARCH_HPPA =        QEMU_ARCH_BIT(SYS_EMU_TARGET_HPPA),
-    QEMU_ARCH_RISCV =       QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV32) |
-                            QEMU_ARCH_BIT(SYS_EMU_TARGET_RISCV64),
-    QEMU_ARCH_RX =          QEMU_ARCH_BIT(SYS_EMU_TARGET_RX),
-    QEMU_ARCH_AVR =         QEMU_ARCH_BIT(SYS_EMU_TARGET_AVR),
-    QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(SYS_EMU_TARGET_HEXAGON),
-    QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(SYS_EMU_TARGET_LOONGARCH64),
-    QEMU_ARCH_ALL =         QEMU_ARCH_BIT(SYS_EMU_TARGET__MAX) - 1,
+    QEMU_ARCH_ALPHA =       QEMU_ARCH_BIT(EMU_TARGET_ALPHA),
+    QEMU_ARCH_ARM =         QEMU_ARCH_BIT(EMU_TARGET_ARM) |
+                            QEMU_ARCH_BIT(EMU_TARGET_AARCH64),
+    QEMU_ARCH_I386 =        QEMU_ARCH_BIT(EMU_TARGET_I386) |
+                            QEMU_ARCH_BIT(EMU_TARGET_X86_64),
+    QEMU_ARCH_M68K =        QEMU_ARCH_BIT(EMU_TARGET_M68K),
+    QEMU_ARCH_MICROBLAZE =  QEMU_ARCH_BIT(EMU_TARGET_MICROBLAZE),
+    QEMU_ARCH_MIPS =        QEMU_ARCH_BIT(EMU_TARGET_MIPS) |
+                            QEMU_ARCH_BIT(EMU_TARGET_MIPSEL) |
+                            QEMU_ARCH_BIT(EMU_TARGET_MIPS64) |
+                            QEMU_ARCH_BIT(EMU_TARGET_MIPS64EL),
+    QEMU_ARCH_PPC =         QEMU_ARCH_BIT(EMU_TARGET_PPC) |
+                            QEMU_ARCH_BIT(EMU_TARGET_PPC64),
+    QEMU_ARCH_S390X =       QEMU_ARCH_BIT(EMU_TARGET_S390X),
+    QEMU_ARCH_SH4 =         QEMU_ARCH_BIT(EMU_TARGET_SH4) |
+                            QEMU_ARCH_BIT(EMU_TARGET_SH4EB),
+    QEMU_ARCH_SPARC =       QEMU_ARCH_BIT(EMU_TARGET_SPARC) |
+                            QEMU_ARCH_BIT(EMU_TARGET_SPARC64),
+    QEMU_ARCH_XTENSA =      QEMU_ARCH_BIT(EMU_TARGET_XTENSA) |
+                            QEMU_ARCH_BIT(EMU_TARGET_XTENSAEB),
+    QEMU_ARCH_OR1K =        QEMU_ARCH_BIT(EMU_TARGET_OR1K),
+    QEMU_ARCH_TRICORE =     QEMU_ARCH_BIT(EMU_TARGET_TRICORE),
+    QEMU_ARCH_HPPA =        QEMU_ARCH_BIT(EMU_TARGET_HPPA),
+    QEMU_ARCH_RISCV =       QEMU_ARCH_BIT(EMU_TARGET_RISCV32) |
+                            QEMU_ARCH_BIT(EMU_TARGET_RISCV64),
+    QEMU_ARCH_RX =          QEMU_ARCH_BIT(EMU_TARGET_RX),
+    QEMU_ARCH_AVR =         QEMU_ARCH_BIT(EMU_TARGET_AVR),
+    QEMU_ARCH_HEXAGON =     QEMU_ARCH_BIT(EMU_TARGET_HEXAGON),
+    QEMU_ARCH_LOONGARCH =   QEMU_ARCH_BIT(EMU_TARGET_LOONGARCH64),
+    QEMU_ARCH_ALL =         QEMU_ARCH_BIT(EMU_TARGET__MAX) - 1,
 };
 
 /* Keep target-specific masks within qemu_opt_set_number()'s int64_t range. */
-QEMU_BUILD_BUG_ON(SYS_EMU_TARGET__MAX > 63);
+QEMU_BUILD_BUG_ON(EMU_TARGET__MAX > 63);
 
 /**
  * qemu_arch_available:
diff --git a/include/qemu/target-info-def.h b/include/qemu/target-info-def.h
index 8019d2c7196..479f7ddd39c 100644
--- a/include/qemu/target-info-def.h
+++ b/include/qemu/target-info-def.h
@@ -16,7 +16,7 @@ typedef struct TargetInfo {
     /* runtime equivalent of TARGET_NAME definition */
     const char *target_name;
     /* related to TARGET_ARCH definition */
-    SysEmuTarget target_arch;
+    EmuTarget target_arch;
     /* runtime equivalent of TARGET_LONG_BITS definition */
     unsigned long_bits;
     /* runtime equivalent of CPU_RESOLVING_TYPE definition */
diff --git a/include/qemu/target-info-qapi.h b/include/qemu/target-info-qapi.h
index d5ce0523238..42a78ee38bc 100644
--- a/include/qemu/target-info-qapi.h
+++ b/include/qemu/target-info-qapi.h
@@ -15,9 +15,9 @@
 /**
  * target_arch:
  *
- * Returns: QAPI SysEmuTarget enum (e.g. SYS_EMU_TARGET_X86_64).
+ * Returns: QAPI EmuTarget enum (e.g. EMU_TARGET_X86_64).
  */
-SysEmuTarget target_arch(void);
+EmuTarget target_arch(void);
 
 /**
  * target_endian_mode:
diff --git a/qapi/machine.json b/qapi/machine.json
index 9b145c635ba..07fac4f0764 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -14,7 +14,7 @@
 { 'include': 'machine-common.json' }
 
 ##
-# @SysEmuTarget:
+# @EmuTarget:
 #     The comprehensive enumeration of QEMU system emulation
 #     ("softmmu") targets.  Run "./configure --help" in the project
 #     root directory, and look for the \*-softmmu targets near the
@@ -35,7 +35,7 @@
 #
 # Since: 3.0
 ##
-{ 'enum' : 'SysEmuTarget',
+{ 'enum' : 'EmuTarget',
   'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
              'loongarch64', 'm68k', 'microblaze', 'mips', 'mips64',
              'mips64el', 'mipsel', 'or1k', 'ppc',
@@ -95,7 +95,7 @@
                       'qom-path'     : 'str',
                       'thread-id'    : 'int',
                       '*props'       : 'CpuInstanceProperties',
-                      'target'       : 'SysEmuTarget' },
+                      'target'       : 'EmuTarget' },
   'discriminator' : 'target',
   'data'          : { 's390x'        : 'CpuInfoS390' } }
 
@@ -281,7 +281,7 @@
 # Since: 1.2
 ##
 { 'struct': 'QemuTargetInfo',
-  'data': { 'arch': 'SysEmuTarget' } }
+  'data': { 'arch': 'EmuTarget' } }
 
 ##
 # @query-target:
diff --git a/qapi/pragma.json b/qapi/pragma.json
index 342cedc42e7..93a710ee937 100644
--- a/qapi/pragma.json
+++ b/qapi/pragma.json
@@ -72,7 +72,7 @@
         'SsidSizeMode',
         'String',
         'StringWrapper',
-        'SysEmuTarget',
+        'EmuTarget',
         'ThrottleGroupProperties',
         'VncPrimaryAuth',
         'VncVencryptSubAuth',
@@ -109,7 +109,7 @@
         'QKeyCode',                 # send-key, input-sent-event
         'QapiErrorClass',           # QMP error replies
         'SshHostKeyCheckMode',      # blockdev-add, -blockdev
-        'SysEmuTarget',             # query-cpu-fast, query-target
+        'EmuTarget',                # query-cpu-fast, query-target
         'UuidInfo',                 # query-uuid
         'VncClientInfo',            # query-vnc, query-vnc-servers, ...
         'X86CPURegister32'          # qom-get of x86 CPU properties
diff --git a/target-info-def.c b/target-info-def.c
index bcf9cfe1e43..028816f4cf1 100644
--- a/target-info-def.c
+++ b/target-info-def.c
@@ -26,7 +26,7 @@ QEMU_BUILD_BUG_ON(TARGET_PAGE_BITS < TARGET_PAGE_BITS_MIN);
 
 static const TargetInfo target_info_stub = {
     .target_name = TARGET_NAME,
-    .target_arch = glue(SYS_EMU_TARGET_, TARGET_ARCH_VARIANT),
+    .target_arch = glue(EMU_TARGET_, TARGET_ARCH_VARIANT),
     .long_bits = TARGET_LONG_BITS,
     .cpu_type = CPU_RESOLVING_TYPE,
     .endianness = TARGET_BIG_ENDIAN ? ENDIAN_MODE_BIG : ENDIAN_MODE_LITTLE,
diff --git a/target-info.c b/target-info.c
index 6b365113955..241be2b5563 100644
--- a/target-info.c
+++ b/target-info.c
@@ -22,7 +22,7 @@ unsigned target_long_bits(void)
     return target_info()->long_bits;
 }
 
-SysEmuTarget target_arch(void)
+EmuTarget target_arch(void)
 {
     return target_info()->target_arch;
 }
@@ -45,8 +45,8 @@ bool target_big_endian(void)
 bool target_base_arm(void)
 {
     switch (target_arch()) {
-    case SYS_EMU_TARGET_ARM:
-    case SYS_EMU_TARGET_AARCH64:
+    case EMU_TARGET_ARM:
+    case EMU_TARGET_AARCH64:
         return true;
     default:
         return false;
@@ -55,29 +55,29 @@ bool target_base_arm(void)
 
 bool target_arm(void)
 {
-    return target_arch() == SYS_EMU_TARGET_ARM;
+    return target_arch() == EMU_TARGET_ARM;
 }
 
 bool target_aarch64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_AARCH64;
+    return target_arch() == EMU_TARGET_AARCH64;
 }
 
 bool target_m68k(void)
 {
-    return target_arch() == SYS_EMU_TARGET_M68K;
+    return target_arch() == EMU_TARGET_M68K;
 }
 
 bool target_or1k(void)
 {
-    return target_arch() == SYS_EMU_TARGET_OR1K;
+    return target_arch() == EMU_TARGET_OR1K;
 }
 
 bool target_base_ppc(void)
 {
     switch (target_arch()) {
-    case SYS_EMU_TARGET_PPC:
-    case SYS_EMU_TARGET_PPC64:
+    case EMU_TARGET_PPC:
+    case EMU_TARGET_PPC64:
         return true;
     default:
         return false;
@@ -86,20 +86,20 @@ bool target_base_ppc(void)
 
 bool target_ppc(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC;
+    return target_arch() == EMU_TARGET_PPC;
 }
 
 bool target_ppc64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_PPC64;
+    return target_arch() == EMU_TARGET_PPC64;
 }
 
 bool target_s390x(void)
 {
-    return target_arch() == SYS_EMU_TARGET_S390X;
+    return target_arch() == EMU_TARGET_S390X;
 }
 
 bool target_riscv64(void)
 {
-    return target_arch() == SYS_EMU_TARGET_RISCV64;
+    return target_arch() == EMU_TARGET_RISCV64;
 }
-- 
2.55.0.windows.3


