Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A119F433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8DE-0002DY-Qh; Wed, 15 Apr 2026 17:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8DB-0002BI-8g
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:55:53 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8D9-0002cy-16
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:55:52 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso68085395e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290148; x=1776894948; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuzviMl1wmLNCePSminxPRECrcBokMjkzSTP18yd1OY=;
 b=pD98zgRopECYuPYK/ack7Mbgy/S61amnk5yVpz9Z9Ic93O9pJV+Sma9oMs/Cucy9Hz
 vU4EwX+eUQP+bHzsgGnNqI7xorveQAZjJYFwsX1op2eeG7s2ktSjLpBmYfHSnUU36fDp
 s9cUjhIpMBm5ElGKZX7qw1bRLbOU4MIhTZckdZ6Xvu9RkNNYMYhGTVUIMRPAY85vacoG
 DTmYDGjXKhB0yFNm3RhgnfJDe/l0Qrikmat0nW0ftdb/U8n7qYcEnbihlJQm+j9jH/+h
 DaEqnxxvTy5bz2RxnLZwcMp4IyzlWjRegngTZBi/XTdk32SsOG65nXXqcCB9utwKxwW1
 LVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290148; x=1776894948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VuzviMl1wmLNCePSminxPRECrcBokMjkzSTP18yd1OY=;
 b=NGV8zlX7DIi8C3iWp+MXwpg6UHHmECSlKqj6csd4IjMPKheJV9Rm0udA41jqdYpg6Z
 oV9zoCxcH6dKBHIRnQ6OHz3ac65ElEP/RgaOaCp1FO817Ujt9gD7Af/IoABC55A3+GU2
 jlgYgDghsUypO1+QhD5xc6pV88IAL+NHGJ4o4WS/dGKMIWc5AqQ3aRB2rWJhiHp9JoPD
 AwUBQZuniUFZDOzwZm947/Ic/81wtIyZcZIJfzu1o4ocFGPz6pZUD4LpjZWOc4VvXizW
 qk2JjaXoqKKL0+EPhjM9hZPPpwE9/ZaekjerCD9vKs12lOmpRWOJCH9Jg/z1yQbuaO+O
 wcWQ==
X-Gm-Message-State: AOJu0YxTyOpALu9INZxszORw11NHCxdsOhn2iDZXc3sqZFxAvXW2LorO
 HoyS0ZJHpe/K8jO0IJtJbY+ZZBbxXzr/AxYeGLCICZRhewCEeo4JfFO9ZYk6jr/9zRhV4XjA7jI
 AMl6Eyag=
X-Gm-Gg: AeBDiet+ub2UF6Q11riSEZ9Y/9+e85V0V7u+brXAsDmnqcACIY4q+4ki6MG2Euq3+MI
 CPyQaFXA7ksA42xXXmc5PAzY/jwIZqpRbBCd0bNr2Mbdxh83reZgAuXq5MfOpCXqtRTtrPLjGCn
 jeBLlqMfXU2dQsNFBoylGsdm3WFqT2uSMgwBQsCFJ2jcmi181+sSwd2vzjKV7QzjEsSA/aLIHfI
 e2yHSUAwWZZZTPrguEwgycGhyVFs0OOzY24Jq14SDzHmdepQV/uVkhAhc1LIIrEYP/bo9Xp2gko
 P/GD4LcJSJsVRwRJgneWlmzPMqLiD95t0m9I/ty/6jxMElVv8xcyCLmYkVujJKH+z6eOeoilRIM
 H5WwKCsx/B1VMgnvfh4r84SOR1BLCTsxG1WKyeuggOdZXqP+h84+HYXTfGMV/N5fVPex4KzrSVe
 uTzCbLtHCykqc4ftpn1xe28tJDRy4Vlczy8RdQUw1pTVeq+HwxFa220oaCmKyHMmArBdWJw+38
X-Received: by 2002:a05:600c:34cc:b0:485:557d:9fe with SMTP id
 5b1f17b1804b1-488d67e65e7mr307710595e9.12.1776290148183; 
 Wed, 15 Apr 2026 14:55:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5813954sm651235e9.3.2026.04.15.14.55.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:55:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 1/8] cocci: Do not initialize variable used by QLIST_FOREACH
 macro
Date: Wed, 15 Apr 2026 23:55:32 +0200
Message-ID: <20260415215539.92629-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The QLIST_FOREACH() macro, defined in "qemu/queue.h",
always assigns its iterator variable when entering the
loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 block/blkio.c               | 2 +-
 block/gluster.c             | 4 ++--
 hw/arm/virt-acpi-build.c    | 2 +-
 hw/i386/xen/xen-hvm.c       | 4 ++--
 hw/riscv/riscv-iommu.c      | 2 +-
 hw/vfio/cpr-legacy.c        | 2 +-
 hw/vfio/listener.c          | 4 ++--
 hw/xen/xen_pt_config_init.c | 4 ++--
 8 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 20f138a38c5..fb8bec27d71 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -124,7 +124,7 @@ blkio_do_alloc_bounce_buffer(BDRVBlkioState *s, BlkioBounceBuf *bounce,
                              int64_t bytes)
 {
     void *addr = s->bounce_pool.addr;
-    BlkioBounceBuf *cur = NULL;
+    BlkioBounceBuf *cur;
     BlkioBounceBuf *prev = NULL;
     ptrdiff_t space;
 
diff --git a/block/gluster.c b/block/gluster.c
index 4fb25b2c6d8..279f650241c 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -251,7 +251,7 @@ static void glfs_set_preopened(const char *volume, glfs_t *fs)
 
 static glfs_t *glfs_find_preopened(const char *volume)
 {
-    ListElement *entry = NULL;
+    ListElement *entry;
 
      QLIST_FOREACH(entry, &glfs_list, list) {
         if (strcmp(entry->saved.volume, volume) == 0) {
@@ -265,7 +265,7 @@ static glfs_t *glfs_find_preopened(const char *volume)
 
 static void glfs_clear_preopened(glfs_t *fs)
 {
-    ListElement *entry = NULL;
+    ListElement *entry;
     ListElement *next;
 
     if (fs == NULL) {
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c6..a38a835d48d 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -146,7 +146,7 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
 {
     int ecam_id = VIRT_ECAM_ID(vms->highmem_ecam);
     bool cxl_present = false;
-    PCIBus *bus = vms->bus;
+    PCIBus *bus;
     bool acpi_pcihp = false;
 
     if (vms->acpi_dev) {
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 67d3e836eb1..d3ce082e07a 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -184,7 +184,7 @@ static void xen_ram_init(PCMachineState *pcms,
 static XenPhysmap *get_physmapping(hwaddr start_addr, ram_addr_t size,
                                    int page_mask)
 {
-    XenPhysmap *physmap = NULL;
+    XenPhysmap *physmap;
 
     start_addr &= page_mask;
 
@@ -200,7 +200,7 @@ static hwaddr xen_phys_offset_to_gaddr(hwaddr phys_offset, ram_addr_t size,
                                        int page_mask)
 {
     hwaddr addr = phys_offset & page_mask;
-    XenPhysmap *physmap = NULL;
+    XenPhysmap *physmap;
 
     QLIST_FOREACH(physmap, &xen_physmap, list) {
         if (range_covers_byte(physmap->phys_offset, physmap->size, addr)) {
diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
index c3c9ed6469a..bdc64b70ff2 100644
--- a/hw/riscv/riscv-iommu.c
+++ b/hw/riscv/riscv-iommu.c
@@ -1681,7 +1681,7 @@ static void riscv_iommu_ats(RISCVIOMMUState *s,
     IOMMUAccessFlags perm,
     void (*trace_fn)(const char *id))
 {
-    RISCVIOMMUSpace *as = NULL;
+    RISCVIOMMUSpace *as;
     IOMMUNotifier *n;
     IOMMUTLBEvent event;
     uint32_t pid;
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 033a546c301..c431d899731 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -212,7 +212,7 @@ void vfio_legacy_cpr_unregister_container(VFIOLegacyContainer *container)
 void vfio_cpr_giommu_remap(VFIOContainer *bcontainer,
                            MemoryRegionSection *section)
 {
-    VFIOGuestIOMMU *giommu = NULL;
+    VFIOGuestIOMMU *giommu;
     hwaddr as_offset = section->offset_within_address_space;
     hwaddr iommu_offset = as_offset - section->offset_within_region;
 
diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 960da9e0a93..cf2f9ef5e8f 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -337,7 +337,7 @@ static void vfio_ram_discard_unregister_listener(VFIOContainer *bcontainer,
                                                  MemoryRegionSection *section)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
-    VFIORamDiscardListener *vrdl = NULL;
+    VFIORamDiscardListener *vrdl;
 
     QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
@@ -467,7 +467,7 @@ static void vfio_device_error_append(VFIODevice *vbasedev, Error **errp)
 VFIORamDiscardListener *vfio_find_ram_discard_listener(
     VFIOContainer *bcontainer, MemoryRegionSection *section)
 {
-    VFIORamDiscardListener *vrdl = NULL;
+    VFIORamDiscardListener *vrdl;
 
     QLIST_FOREACH(vrdl, &bcontainer->vrdl_list, next) {
         if (vrdl->mr == section->mr &&
diff --git a/hw/xen/xen_pt_config_init.c b/hw/xen/xen_pt_config_init.c
index 3edaeab1e34..bbc82a2bcfa 100644
--- a/hw/xen/xen_pt_config_init.c
+++ b/hw/xen/xen_pt_config_init.c
@@ -62,7 +62,7 @@ static int xen_pt_hide_dev_cap(const XenHostPCIDevice *d, uint8_t grp_id)
 /*   find emulate register group entry */
 XenPTRegGroup *xen_pt_find_reg_grp(XenPCIPassthroughState *s, uint32_t address)
 {
-    XenPTRegGroup *entry = NULL;
+    XenPTRegGroup *entry;
 
     /* find register group entry */
     QLIST_FOREACH(entry, &s->reg_grps, entries) {
@@ -80,7 +80,7 @@ XenPTRegGroup *xen_pt_find_reg_grp(XenPCIPassthroughState *s, uint32_t address)
 /* find emulate register entry */
 XenPTReg *xen_pt_find_reg(XenPTRegGroup *reg_grp, uint32_t address)
 {
-    XenPTReg *reg_entry = NULL;
+    XenPTReg *reg_entry;
     XenPTRegInfo *reg = NULL;
     uint32_t real_offset = 0;
 
-- 
2.53.0


