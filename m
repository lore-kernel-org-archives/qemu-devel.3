Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD0606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IucNvbdZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJuBx-0003LD-7v; Thu, 22 Oct 2026 10:54:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJuBt-0003K9-Bm
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:54:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJuBr-0004wf-A6
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 10:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792680884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xMeclBtIsoWDquVey77gYzHp0P0smhDvZpu4FD33fr0=;
 b=IucNvbdZ6TbZxCe6DeZsYt1dhR/RtBkfCEAqibXlxILckWGt5fDCCu++YwOgrnnX5u29ba
 wWnTKfwaBC+b9awu6CQfqniHgzCDrd9vFj5cdLGH/pZlNg/tkuq/E9O/lqKonH3qUTeiET
 NEEt2qs39SuXysD1tfCxF4pKUprC7E8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-81ayABNfNwqAKkbpbOYOEw-1; Thu,
 22 Oct 2026 10:54:42 -0400
X-MC-Unique: 81ayABNfNwqAKkbpbOYOEw-1
X-Mimecast-MFC-AGG-ID: 81ayABNfNwqAKkbpbOYOEw_1792680881
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6BEA1954206
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:41 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9694A30001B9; Thu, 22 Oct 2026 14:54:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] hw/display/ramfb: reject invalid framebuffer mappings
Date: Thu, 22 Oct 2026 18:54:38 +0400
Message-ID: <20261022145437.3546795-2-marcandre.lureau@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

ramfb_create_display_surface() passes the guest-controlled address
straight to physical_memory_map() and only checks whether the returned
length matches the requested size.  Two problems follow.

An address backed by a non-directly-mappable region (device MMIO, an
unassigned hole, ...) is bounced through a temporary host buffer.
Bouncing is pointless for a framebuffer that is only ever read, and it
consumes the limited address_space_memory bounce buffer budget.

When address_space_map() cannot obtain bounce buffer space it returns
NULL with *plen set to 0.  The size check then fails and the function
calls physical_memory_unmap(NULL, 0, ...).  address_space_unmap() treats
the NULL pointer as a BounceBuffer and dereferences its magic field,
crashing QEMU.

A guest can trigger the latter by writing the same configuration twice
via etc/ramfb: the first 16x64 XRGB8888 surface at an unmapped GPA
consumes the entire 4096 byte bounce buffer allowance, and the second
mapping fails because that surface is still being displayed.

Validate up front that the whole framebuffer range is backed by
directly accessible memory, and still return early if the mapping
fails, leaving the previous surface in place.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4740
Reported-by: Karl Mehltretter <https://gitlab.com/kmehltretter>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/ramfb.c      | 38 ++++++++++++++++++++++++++++++++++++--
 hw/display/trace-events |  4 ++++
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index f477bdcc2186..8e2be33b0fcc 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -17,8 +17,10 @@
 #include "hw/display/ramfb.h"
 #include "hw/display/bochs-vbe.h" /* for limits */
 #include "ui/console.h"
+#include "system/memory.h"
 #include "system/physmem.h"
 #include "system/reset.h"
+#include "trace.h"
 #include "exec/cpu-common.h"
 
 struct QEMU_PACKED RAMFBCfg {
@@ -46,6 +48,31 @@ static void ramfb_unmap_display_surface(pixman_image_t *image, void *unused)
     physical_memory_unmap(data, size, 0, 0);
 }
 
+/*
+ * A framebuffer must live in directly mappable host memory. Reject
+ * addresses backed by unrelated regions (MMIO, unassigned holes, ...)
+ */
+static bool ramfb_range_is_direct_access(hwaddr addr, hwaddr size)
+{
+    WITH_RCU_READ_LOCK_GUARD() {
+        while (size > 0) {
+            MemoryRegion *mr;
+            hwaddr len = size, xlat;
+
+            mr = address_space_translate(&address_space_memory, addr,
+                                         &xlat, &len, false,
+                                         MEMTXATTRS_UNSPECIFIED);
+            if (len == 0 || !memory_region_supports_direct_access(mr)) {
+                return false;
+            }
+            addr += len;
+            size -= len;
+        }
+    }
+
+    return true;
+}
+
 static DisplaySurface *ramfb_create_display_surface(int width, int height,
                                                     pixman_format_code_t format,
                                                     hwaddr stride, hwaddr addr)
@@ -65,9 +92,16 @@ static DisplaySurface *ramfb_create_display_surface(int width, int height,
     }
 
     mapsize = size = stride * (height - 1) + linesize;
+    if (!ramfb_range_is_direct_access(addr, size)) {
+        trace_ramfb_bad_range(addr, size);
+        return NULL;
+    }
     data = physical_memory_map(addr, &mapsize, false);
-    if (size != mapsize) {
-        physical_memory_unmap(data, mapsize, 0, 0);
+    if (!data || size != mapsize) {
+        trace_ramfb_map_failed(addr, size, mapsize);
+        if (data) {
+            physical_memory_unmap(data, mapsize, 0, 0);
+        }
         return NULL;
     }
 
diff --git a/hw/display/trace-events b/hw/display/trace-events
index c5e7e42af23b..bc1822b6b023 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -184,6 +184,10 @@ macfb_sense_read(uint32_t value) "video sense: 0x%"PRIx32
 macfb_sense_write(uint32_t value) "video sense: 0x%"PRIx32
 macfb_update_mode(uint32_t width, uint32_t height, uint8_t depth) "setting mode to width %"PRId32 " height %"PRId32 " size %d"
 
+# ramfb.c
+ramfb_bad_range(uint64_t addr, uint64_t size) "addr=0x%"PRIx64" size=0x%"PRIx64
+ramfb_map_failed(uint64_t addr, uint64_t size, uint64_t mapsize) "addr=0x%"PRIx64" size=0x%"PRIx64" mapped=0x%"PRIx64
+
 # dm163.c
 dm163_redraw(uint8_t redraw) "0x%02x"
 dm163_dck(unsigned new_state) "dck : %u"
-- 
2.56.0.116.g6de20f6092dc


