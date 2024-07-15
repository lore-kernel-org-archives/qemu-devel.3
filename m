Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946D2C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:07:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TM-00053l-6f; Wed, 17 Jul 2024 07:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SQ-0000d3-1v
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SN-0006zs-GT
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:25 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id D447C37960A; Mon, 15 Jul 2024 23:07:37 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 03/26] hw/display/apple-gfx: Moved from hw/vmapple/
Date: Mon, 15 Jul 2024 23:06:42 +0200
Message-Id: <20240715210705.32365-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240715210705.32365-1-phil@philjordan.eu>
References: <20240715210705.32365-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=89.104.8.17; envelope-from=phil@intel-mbp.local;
 helo=intel-mbp.local
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, KHOP_HELO_FCRDNS=0.261,
 NO_DNS_FOR_FROM=0.001, RDNS_DYNAMIC=0.982, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 TVD_RCVD_IP=0.001 autolearn=no autolearn_force=no
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

The macOS PV graphics device is useful outside the (as yet incomplete)
vmapple machine type, so this patch moves it to hw/display.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/Kconfig                  |  4 ++++
 hw/{vmapple => display}/apple-gfx.m |  0
 hw/display/meson.build              |  1 +
 hw/display/trace-events             | 23 +++++++++++++++++++++++
 hw/vmapple/Kconfig                  |  4 ----
 hw/vmapple/meson.build              |  1 -
 hw/vmapple/trace-events             | 23 -----------------------
 7 files changed, 28 insertions(+), 28 deletions(-)
 rename hw/{vmapple => display}/apple-gfx.m (100%)
 delete mode 100644 hw/vmapple/Kconfig
 delete mode 100644 hw/vmapple/meson.build
 delete mode 100644 hw/vmapple/trace-events

diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a4552c8ed7..13cd256c06 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -143,3 +143,7 @@ config XLNX_DISPLAYPORT
 
 config DM163
     bool
+
+config MAC_PVG
+    bool
+
diff --git a/hw/vmapple/apple-gfx.m b/hw/display/apple-gfx.m
similarity index 100%
rename from hw/vmapple/apple-gfx.m
rename to hw/display/apple-gfx.m
diff --git a/hw/display/meson.build b/hw/display/meson.build
index 7db05eace9..713786bd07 100644
--- a/hw/display/meson.build
+++ b/hw/display/meson.build
@@ -65,6 +65,7 @@ system_ss.add(when: 'CONFIG_ARTIST', if_true: files('artist.c'))
 
 system_ss.add(when: 'CONFIG_ATI_VGA', if_true: [files('ati.c', 'ati_2d.c', 'ati_dbg.c'), pixman])
 
+system_ss.add(when: 'CONFIG_MAC_PVG', if_true: [files('apple-gfx.m'), pvg, metal])
 
 if config_all_devices.has_key('CONFIG_VIRTIO_GPU')
   virtio_gpu_ss = ss.source_set()
diff --git a/hw/display/trace-events b/hw/display/trace-events
index 781f8a3320..98e1a3a3a0 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -191,3 +191,26 @@ dm163_bits_ppi(unsigned dest_width) "dest_width : %u"
 dm163_leds(int led, uint32_t value) "led %d: 0x%x"
 dm163_channels(int channel, uint8_t value) "channel %d: 0x%x"
 dm163_refresh_rate(uint32_t rr) "refresh rate %d"
+
+# apple-gfx.m
+apple_gfx_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
+apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
+apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x base_addr=%p"
+apple_gfx_destroy_task(void *task) "task=%p"
+apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtual_offset, uint32_t read_only) "task=%p range_count=0x%x virtual_offset=0x%"PRIx64" read_only=%d"
+apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len, void *va) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64" va=%p"
+apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
+apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
+apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
+apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
+apple_gfx_new_frame(void) ""
+apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
+apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d width=%"PRId64" height=0x%"PRId64
+apple_gfx_cursor_show(uint32_t show) "show=%d"
+apple_gfx_cursor_move(void) ""
+apple_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
+apple_iosfc_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
+apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p"
+apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
+apple_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
+
diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
deleted file mode 100644
index 5835790a31..0000000000
--- a/hw/vmapple/Kconfig
+++ /dev/null
@@ -1,4 +0,0 @@
-
-config VMAPPLE_PVG
-    bool
-
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
deleted file mode 100644
index f9ab2194d9..0000000000
--- a/hw/vmapple/meson.build
+++ /dev/null
@@ -1 +0,0 @@
-system_ss.add(when: 'CONFIG_VMAPPLE_PVG',  if_true: [files('apple-gfx.m'), pvg, metal])
diff --git a/hw/vmapple/trace-events b/hw/vmapple/trace-events
deleted file mode 100644
index 497f64064b..0000000000
--- a/hw/vmapple/trace-events
+++ /dev/null
@@ -1,23 +0,0 @@
-# See docs/devel/tracing.rst for syntax documentation.
-
-# apple-gfx.m
-apple_gfx_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
-apple_gfx_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
-apple_gfx_create_task(uint32_t vm_size, void *va) "vm_size=0x%x base_addr=%p"
-apple_gfx_destroy_task(void *task) "task=%p"
-apple_gfx_map_memory(void *task, uint32_t range_count, uint64_t virtual_offset, uint32_t read_only) "task=%p range_count=0x%x virtual_offset=0x%"PRIx64" read_only=%d"
-apple_gfx_map_memory_range(uint32_t i, uint64_t phys_addr, uint64_t phys_len, void *va) "[%d] phys_addr=0x%"PRIx64" phys_len=0x%"PRIx64" va=%p"
-apple_gfx_remap(uint64_t retval, uint64_t source, uint64_t target) "retval=%"PRId64" source=0x%"PRIx64" target=0x%"PRIx64
-apple_gfx_unmap_memory(void *task, uint64_t virtual_offset, uint64_t length) "task=%p virtual_offset=0x%"PRIx64" length=0x%"PRIx64
-apple_gfx_read_memory(uint64_t phys_address, uint64_t length, void *dst) "phys_addr=0x%"PRIx64" length=0x%"PRIx64" dest=%p"
-apple_gfx_raise_irq(uint32_t vector) "vector=0x%x"
-apple_gfx_new_frame(void) ""
-apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
-apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d width=%"PRId64" height=0x%"PRId64
-apple_gfx_cursor_show(uint32_t show) "show=%d"
-apple_gfx_cursor_move(void) ""
-apple_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
-apple_iosfc_write(uint64_t offset, uint64_t val) "offset=0x%"PRIx64" val=0x%"PRIx64
-apple_iosfc_map_memory(uint64_t phys, uint64_t len, uint32_t ro, void *va, void *e, void *f) "phys=0x%"PRIx64" len=0x%"PRIx64" ro=%d va=%p e=%p f=%p"
-apple_iosfc_unmap_memory(void *a, void *b, void *c, void *d, void *e, void *f) "a=%p b=%p c=%p d=%p e=%p f=%p"
-apple_iosfc_raise_irq(uint32_t vector) "vector=0x%x"
-- 
2.39.3 (Apple Git-146)


