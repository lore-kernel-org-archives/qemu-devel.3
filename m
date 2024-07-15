Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EDB7C3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2TN-00058l-L0; Wed, 17 Jul 2024 07:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@intel-mbp.local>)
 id 1sU2SP-0000bd-Mb
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:29 -0400
Received: from 89-104-8-17.customer.bnet.at ([89.104.8.17]
 helo=intel-mbp.local) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <phil@intel-mbp.local>) id 1sU2SM-0006zK-RU
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 07:04:25 -0400
Received: by intel-mbp.local (Postfix, from userid 501)
 id 683FB37964B; Mon, 15 Jul 2024 23:07:38 +0200 (CEST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org, pbonzini@redhat.com, agraf@csgraf.de,
 graf@amazon.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 thuth@redhat.com, philmd@linaro.org, peter.maydell@linaro.org,
 akihiko.odaki@daynix.com, phil@philjordan.eu, lists@philjordan.eu
Subject: [PATCH 22/26] hw/display/apple-gfx: Replaces magic number with
 queried MMIO length
Date: Mon, 15 Jul 2024 23:07:01 +0200
Message-Id: <20240715210705.32365-23-phil@philjordan.eu>
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

Rather than specifying the length of the device's MMIO range as an
unnamed literal constant (which is at least documented as a comment in
the framework headers), we query the PVG framework's API for the
recommended value. This also avoids problems in future, in case the
currently documented value for the default changes.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 hw/display/apple-gfx.m  | 16 +++++++++++++++-
 hw/display/trace-events |  1 +
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/display/apple-gfx.m b/hw/display/apple-gfx.m
index 801ae4ad51..cbcbaf0006 100644
--- a/hw/display/apple-gfx.m
+++ b/hw/display/apple-gfx.m
@@ -303,12 +303,26 @@ static void create_fb(AppleGFXState *s)
     s->cursor_show = true;
 }
 
+static size_t apple_gfx_get_default_mmio_range_size(void)
+{
+    size_t mmio_range_size;
+    @autoreleasepool {
+        PGDeviceDescriptor *desc = [PGDeviceDescriptor new];
+        mmio_range_size = desc.mmioLength;
+        [desc release];
+    }
+    return mmio_range_size;
+}
+
 void apple_gfx_common_init(Object *obj, AppleGFXState *s, const char* obj_name)
 {
     Error *local_err = NULL;
     int r;
+    size_t mmio_range_size = apple_gfx_get_default_mmio_range_size();
 
-    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_name, 0x4000);
+    trace_apple_gfx_common_init(obj_name, mmio_range_size);
+    memory_region_init_io(&s->iomem_gfx, obj, &apple_gfx_ops, s, obj_name,
+                          mmio_range_size);
 
     /* TODO: PVG framework supports serialising device state: integrate it! */
     if (apple_gfx_mig_blocker == NULL) {
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e35582d659..1809a358e3 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -208,6 +208,7 @@ apple_gfx_mode_change(uint64_t x, uint64_t y) "x=%"PRId64" y=%"PRId64
 apple_gfx_cursor_set(uint32_t bpp, uint64_t width, uint64_t height) "bpp=%d width=%"PRId64" height=0x%"PRId64
 apple_gfx_cursor_show(uint32_t show) "show=%d"
 apple_gfx_cursor_move(void) ""
+apple_gfx_common_init(const char *device_name, size_t mmio_size) "device: %s; MMIO size: %zu bytes"
 
 # apple-gfx-vmapple.m
 apple_iosfc_read(uint64_t offset, uint64_t res) "offset=0x%"PRIx64" res=0x%"PRIx64
-- 
2.39.3 (Apple Git-146)


