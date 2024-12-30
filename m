Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681BDE77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 19:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSL3K-0004G6-BZ; Mon, 30 Dec 2024 14:03:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSL3E-0004Co-PP
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 14:03:41 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tSL3C-0007qz-H5
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 14:03:40 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so107198375e9.1
 for <qemu-devel@nongnu.org>; Mon, 30 Dec 2024 11:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735585411; x=1736190211; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tqX4ZDqJeVvjB3AauIbeUtUX20e9/xznDP4YjX8B+/k=;
 b=liWcT7jCJ/WaXY5s5NWQ2cNCkz6N1V9TgHKFW6zgFtGQeq9EpWklBVSq1Ft45UgfvS
 LVmm4jfjj1b0FGcBLZtkHtKRt+9Bwp12uOzm3diHxrzqRyOhzeXvxOJucZGbu7+8uvjh
 22N7Y0EJ8wfWW+6BewAQT6mSzntti0Wt8fnebQSYEfnIo41hLslemSRBS2zyvyjznRDz
 BwLvvfXn9i11FKPj6OQifKULPQ3EupO3BdN7X1osDY8U3QNYyPPTRxe5GS8x0EfkBRNf
 ZUuRZRBIgn77fDlTHRP2pG36cUUEe+R403LBixXtykrxi27yFEEfniz2WiRf3N3lQCMz
 MTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735585411; x=1736190211;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tqX4ZDqJeVvjB3AauIbeUtUX20e9/xznDP4YjX8B+/k=;
 b=gZ6DSa/mJoWJED62tCTMd+MmnGIVn3err+h8QL6sg8uIgvqgHphtbgF5tQ7MPSmhBQ
 j+jAV0U97Kwg3N7o525n1GBCF/ObhogMAI6OoB84hjcFbSkmQbziAn+oILzVvOQOGoly
 I+OTrUkanqSqaTaYk5IuqxhEHcJW57LFnND/1x+54DrRzWdGNXhnyOMUJop4McH/LH3T
 aTWcNKHZZ2KJmVr1KKI2+QOfwFsRkaogxXLKXM+bv9ok8TFQNbma56dh7lFF0NbxiKZz
 59sAJbkPglwRmwVdsOcHn7aSxy64alX/uPIgD23ALNFXmJdGL13For2n7QCOuTYE2w/T
 /lxg==
X-Gm-Message-State: AOJu0YxFLp2DonQI+Wha3+0yNDwuq9CA4L1sJYLod0GYJq35hRIZyGsF
 dYejDIvddMbC6FmwNgRNxLbo72fdcX0jEPekDFsqX3dLiLOLIiGlxPVeh7KWePcVneI5CXxXlON
 g
X-Gm-Gg: ASbGncsW9+3wKjnhRBo4BpyHeFEoiZ/R6skv/hjqC6ysTP3YxpSWDlrxpAUWHpFMuRB
 zA/8QlGuV58bPIy901P8vMn7PexRhgyLpryDmqZJT64mWT6sfbzsrQI4OX+ytuJcqprQgL9epdr
 NYOyInI0J49qOzYzB9rm1X4vdU2wBMXdNrrWL9I4TpMNkjHUfxX8MZaOFNm6yhnJBw03Q/BqzJ4
 1fUKeCfi5ldNUH9EEXOIuenqQRLWI+48jo2dIjoAZpyP3ATiWzL1fD9Rz6g8DrSVUnbi9lYUu0/
 u56bKYxZr5ASCXaQr/Tj3uBm
X-Google-Smtp-Source: AGHT+IES7PmJHLcqwRbUYA+ckt/6vwxS0oubVQwuf9EDJnQ5KH201seY73gJeHvSTqpx2HOrKhU6WQ==
X-Received: by 2002:a05:600c:1388:b0:434:a7e3:db5c with SMTP id
 5b1f17b1804b1-436686440abmr300241725e9.11.1735585410746; 
 Mon, 30 Dec 2024 11:03:30 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436611ea42esm369813825e9.9.2024.12.30.11.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 11:03:29 -0800 (PST)
Message-ID: <4f6553bb-43e2-4db2-8c9f-cccbb9c817eb@linaro.org>
Date: Mon, 30 Dec 2024 20:03:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 00/14] macOS PV Graphics and new vmapple machine type
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org, agraf@csgraf.de, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 shorne@gmail.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jcmvbkbc@gmail.com,
 marcandre.lureau@redhat.com, berrange@redhat.com, akihiko.odaki@daynix.com,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-riscv@nongnu.org,
 balaton@eik.bme.hu
References: <20241223221645.29911-1-phil@philjordan.eu>
 <8554330d-fd9b-4fa5-b37c-161f70b71f7d@linaro.org>
 <CAAibmn3PGD5oN9nAeUaqYkAxsH1CWhAQrkqGEaFUd7Ohr-uRfg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAAibmn3PGD5oN9nAeUaqYkAxsH1CWhAQrkqGEaFUd7Ohr-uRfg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 27/12/24 13:19, Phil Dennis-Jordan wrote:
> 
> 
> On Mon, 23 Dec 2024 at 23:58, Philippe Mathieu-Daudé <philmd@linaro.org 
> <mailto:philmd@linaro.org>> wrote:


>      > Alexander Graf (8):
>      >    hw: Add vmapple subdir
>      >    hw/misc/pvpanic: Add MMIO interface
>      >    gpex: Allow more than 4 legacy IRQs
>      >    hw/vmapple/aes: Introduce aes engine
>      >    hw/vmapple/bdif: Introduce vmapple backdoor interface
>      >    hw/vmapple/cfg: Introduce vmapple cfg region
>      >    hw/vmapple/virtio-blk: Add support for apple virtio-blk
>      >    hw/vmapple/vmapple: Add vmapple machine type
>      >
>      > Phil Dennis-Jordan (6):
>      >    ui & main loop: Redesign of system-specific main thread event
>     handling
>      >    hw/display/apple-gfx: Introduce ParavirtualizedGraphics.Framework
>      >      support
>      >    hw/display/apple-gfx: Adds PCI implementation
>      >    hw/display/apple-gfx: Adds configurable mode list
>      >    MAINTAINERS: Add myself as maintainer for apple-gfx, reviewer
>     for HVF
>      >    hw/block/virtio-blk: Replaces request free function with g_free
> 
>     If there are no objection or further comments, I'm taking this
>     series and will post a PR after xmas & testing.
> 
> 
> Thanks Phil, much appreciated! Enjoy your time off.
> 
> I've just posted an updated -v3 of my xhci patch series as v2 suffered 
> from the same breakage as this patch set. I recommend applying that one 
> on top for testing vmapple. It helps when you can use keyboard and mouse 
> properly and don't need to mess around with VNC.

I'm first taking patches 1-5 & 8 [*] squashing mostly style fixups,
TypeInfo rebase and header reduction ("qemu/osdep.h" is only for .c):

-- >8 --
diff --git a/hw/display/apple-gfx.h b/hw/display/apple-gfx.h
index a1160bf6619..3900cdbabbb 100644
--- a/hw/display/apple-gfx.h
+++ b/hw/display/apple-gfx.h
@@ -8,17 +8,14 @@
  #ifndef QEMU_APPLE_GFX_H
  #define QEMU_APPLE_GFX_H

-#define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
-#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
-
-#include "qemu/osdep.h"
-#include <dispatch/dispatch.h>
-#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
-#include "qemu/typedefs.h"
+#include "qemu/queue.h"
  #include "exec/memory.h"
  #include "hw/qdev-properties.h"
  #include "ui/surface.h"

+#define TYPE_APPLE_GFX_MMIO         "apple-gfx-mmio"
+#define TYPE_APPLE_GFX_PCI          "apple-gfx-pci"
+
  @class PGDeviceDescriptor;
  @protocol PGDevice;
  @protocol PGDisplay;
@@ -71,7 +68,7 @@ void *apple_gfx_host_ptr_for_gpa_range(uint64_t 
guest_physical,
                                         uint64_t length, bool read_only,
                                         MemoryRegion **mapping_in_region);

-extern const PropertyInfo qdev_prop_display_mode;
+extern const PropertyInfo qdev_prop_apple_gfx_display_mode;

  #endif

diff --git a/hw/display/apple-gfx-mmio.m b/hw/display/apple-gfx-mmio.m
index 60580a373d8..b2e0e7a30fa 100644
--- a/hw/display/apple-gfx-mmio.m
+++ b/hw/display/apple-gfx-mmio.m
@@ -3,9 +3,6 @@
   *
   * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights 
Reserved.
   *
- * This work is licensed under the terms of the GNU GPL, version 2 or 
later.
- * See the COPYING file in the top-level directory.
- *
   * SPDX-License-Identifier: GPL-2.0-or-later
   *
   * ParavirtualizedGraphics.framework is a set of libraries that macOS 
provides
@@ -16,13 +13,14 @@
   */

  #include "qemu/osdep.h"
-#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
-#include "apple-gfx.h"
-#include "monitor/monitor.h"
+#include "qemu/log.h"
+#include "block/aio-wait.h"
  #include "hw/sysbus.h"
  #include "hw/irq.h"
+#include "apple-gfx.h"
  #include "trace.h"
-#include "qemu/log.h"
+
+#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>

  OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXMMIOState, APPLE_GFX_MMIO)

@@ -32,10 +30,9 @@
   * their definitions here so that we can also work with the ARM version.
   */
  typedef bool(^IOSFCRaiseInterrupt)(uint32_t vector);
-typedef bool(^IOSFCUnmapMemory)(
-    void *, void *, void *, void *, void *, void *);
-typedef bool(^IOSFCMapMemory)(
-    uint64_t phys, uint64_t len, bool ro, void **va, void *, void *);
+typedef bool(^IOSFCUnmapMemory)(void *, void *, void *, void *, void *, 
void *);
+typedef bool(^IOSFCMapMemory)(uint64_t phys, uint64_t len, bool ro, 
void **va,
+                              void *, void *);

  @interface PGDeviceDescriptor (IOSurfaceMapper)
  @property (readwrite, nonatomic) bool usingIOSurfaceMapper;
@@ -168,8 +165,8 @@ static bool apple_gfx_mmio_unmap_surface_memory(void 
*ptr)
      RCU_READ_LOCK_GUARD();
      region = memory_region_from_host(ptr, &offset);
      if (!region) {
-        qemu_log_mask(LOG_GUEST_ERROR, "%s: memory at %p to be unmapped 
not "
-                      "found.\n",
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: memory at %p to be unmapped not found.\n",
                        __func__, ptr);
          return false;
      }
@@ -261,7 +258,7 @@ static void apple_gfx_mmio_reset(Object *obj, 
ResetType type)
  static const Property apple_gfx_mmio_properties[] = {
      DEFINE_PROP_ARRAY("display-modes", AppleGFXMMIOState,
                        common.num_display_modes, common.display_modes,
-                      qdev_prop_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode, 
AppleGFXDisplayMode),
  };

  static void apple_gfx_mmio_class_init(ObjectClass *klass, void *data)
@@ -276,7 +273,7 @@ static void apple_gfx_mmio_class_init(ObjectClass 
*klass, void *data)
      device_class_set_props(dc, apple_gfx_mmio_properties);
  }

-static TypeInfo apple_gfx_mmio_types[] = {
+static const TypeInfo apple_gfx_mmio_types[] = {
      {
          .name          = TYPE_APPLE_GFX_MMIO,
          .parent        = TYPE_SYS_BUS_DEVICE,
diff --git a/hw/display/apple-gfx-pci.m b/hw/display/apple-gfx-pci.m
index 4cfc01fc725..b939bb9b233 100644
--- a/hw/display/apple-gfx-pci.m
+++ b/hw/display/apple-gfx-pci.m
@@ -12,11 +12,12 @@
   * aimed primarily at x86-64 macOS VMs.
   */

-#include "apple-gfx.h"
+#include "qemu/osdep.h"
  #include "hw/pci/pci_device.h"
  #include "hw/pci/msi.h"
-#include "qapi/error.h"
+#include "apple-gfx.h"
  #include "trace.h"
+
  #import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>

  OBJECT_DECLARE_SIMPLE_TYPE(AppleGFXPCIState, APPLE_GFX_PCI)
@@ -27,7 +28,7 @@
      AppleGFXState common;
  };

-static const char* apple_gfx_pci_option_rom_path = NULL;
+static const char *apple_gfx_pci_option_rom_path = NULL;

  static void apple_gfx_init_option_rom_path(void)
  {
@@ -117,7 +118,7 @@ static void apple_gfx_pci_reset(Object *obj, 
ResetType type)
  static const Property apple_gfx_pci_properties[] = {
      DEFINE_PROP_ARRAY("display-modes", AppleGFXPCIState,
                        common.num_display_modes, common.display_modes,
-                      qdev_prop_display_mode, AppleGFXDisplayMode),
+                      qdev_prop_apple_gfx_display_mode, 
AppleGFXDisplayMode),
  };

  static void apple_gfx_pci_class_init(ObjectClass *klass, void *data)
@@ -139,7 +140,7 @@ static void apple_gfx_pci_class_init(ObjectClass 
*klass, void *data)
      device_class_set_props(dc, apple_gfx_pci_properties);
  }

-static TypeInfo apple_gfx_pci_types[] = {
+static const TypeInfo apple_gfx_pci_types[] = {
      {
          .name          = TYPE_APPLE_GFX_PCI,
          .parent        = TYPE_PCI_DEVICE,
diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index b00c72fc4dd..aa1455b6295 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -3,9 +3,6 @@
   *
   * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights 
Reserved.
   *
- * This work is licensed under the terms of the GNU GPL, version 2 or 
later.
- * See the COPYING file in the top-level directory.
- *
   * SPDX-License-Identifier: GPL-2.0-or-later
   *
   * ParavirtualizedGraphics.framework is a set of libraries that macOS 
provides
@@ -15,21 +12,24 @@
   */

  #include "qemu/osdep.h"
-#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>
-#include <mach/mach_vm.h>
-#include "apple-gfx.h"
-#include "trace.h"
-#include "qemu-main.h"
-#include "exec/address-spaces.h"
-#include "migration/blocker.h"
-#include "monitor/monitor.h"
-#include "qemu/main-loop.h"
+#include "qemu/lockable.h"
  #include "qemu/cutils.h"
  #include "qemu/log.h"
  #include "qapi/visitor.h"
  #include "qapi/error.h"
+#include "block/aio-wait.h"
+#include "exec/address-spaces.h"
  #include "system/dma.h"
+#include "migration/blocker.h"
  #include "ui/console.h"
+#include "apple-gfx.h"
+#include "trace.h"
+
+#include <mach/mach.h>
+#include <mach/mach_vm.h>
+#include <dispatch/dispatch.h>
+
+#import <ParavirtualizedGraphics/ParavirtualizedGraphics.h>

  static const AppleGFXDisplayMode apple_gfx_default_modes[] = {
      { 1920, 1080, 60 },
@@ -419,7 +419,7 @@ static void set_cursor_glyph(void *opaque)
          s->cursor = NULL;
      }

-    if (bpp == 32) { /* Shouldn't be anything else, but just to be 
safe...*/
+    if (bpp == 32) { /* Shouldn't be anything else, but just to be 
safe... */
          s->cursor = cursor_alloc(width, height);
          s->cursor->hot_x = job->hotspot.x;
          s->cursor->hot_y = job->hotspot.y;
@@ -467,7 +467,7 @@ static void apple_gfx_do_read_memory(void *opaque)

      r = dma_memory_read(&address_space_memory, job->physical_address,
                          job->dst, job->length, MEMTXATTRS_UNSPECIFIED);
-    job->success = r == MEMTX_OK;
+    job->success = (r == MEMTX_OK);

      qemu_sem_post(&job->sem);
  }
@@ -694,12 +694,11 @@ static void new_frame_handler_bh(void *opaque)
  static NSArray<PGDisplayMode *> *apple_gfx_create_display_mode_array(
      const AppleGFXDisplayMode display_modes[], uint32_t 
display_mode_count)
  {
-    uint32_t i;
      PGDisplayMode *mode_obj;
      NSMutableArray<PGDisplayMode *> *mode_array =
          [[NSMutableArray alloc] initWithCapacity:display_mode_count];

-    for (i = 0; i < display_mode_count; i++) {
+    for (unsigned i = 0; i < display_mode_count; i++) {
          const AppleGFXDisplayMode *mode = &display_modes[i];
          trace_apple_gfx_display_mode(i, mode->width_px, mode->height_px);
          PGDisplayCoord_t mode_size = { mode->width_px, mode->height_px };
@@ -836,8 +835,8 @@ static void apple_gfx_set_display_mode(Object *obj, 
Visitor *v,

      ret = qemu_strtoi(endptr, &endptr, 10, &val);
      if (ret || val > UINT16_MAX || val <= 0) {
-        error_setg(errp, "width in '%s' must be a decimal integer number "
-                   "of pixels in the range 1..65535", name);
+        error_setg(errp, "width in '%s' must be a decimal integer number"
+                         " of pixels in the range 1..65535", name);
          return;
      }
      mode->width_px = val;
@@ -847,8 +846,8 @@ static void apple_gfx_set_display_mode(Object *obj, 
Visitor *v,

      ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
      if (ret || val > UINT16_MAX || val <= 0) {
-        error_setg(errp, "height in '%s' must be a decimal integer number "
-                   "of pixels in the range 1..65535", name);
+        error_setg(errp, "height in '%s' must be a decimal integer number"
+                         " of pixels in the range 1..65535", name);
          return;
      }
      mode->height_px = val;
@@ -859,18 +858,18 @@ static void apple_gfx_set_display_mode(Object 
*obj, Visitor *v,
      ret = qemu_strtoi(endptr + 1, &endptr, 10, &val);
      if (ret || val > UINT16_MAX || val <= 0) {
          error_setg(errp, "refresh rate in '%s'"
-                   " must be a positive decimal integer (Hertz)", name);
+                         " must be a positive decimal integer (Hertz)", 
name);
          return;
      }
      mode->refresh_rate_hz = val;
      return;

  separator_error:
-    error_setg(errp, "Each display mode takes the format "
-               "'<width>x<height>@<rate>'");
+    error_setg(errp,
+               "Each display mode takes the format 
'<width>x<height>@<rate>'");
  }

-const PropertyInfo qdev_prop_display_mode = {
+const PropertyInfo qdev_prop_apple_gfx_display_mode = {
      .name  = "display_mode",
      .description =
          "Display mode in pixels and Hertz, as 
<width>x<height>@<refresh-rate> "
---

Regards,

Phil.

[*] I'll share the rebased branch later.

