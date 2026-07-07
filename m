Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF56CC44500
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh0fr-00070W-N3; Tue, 07 Jul 2026 03:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fq-000700-2r
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:58 -0400
Received: from web05.whitelabeldomein.nl ([2a09:8b00:300:8::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rclobus@rclobus.nl>)
 id 1wh0fo-0002e2-L8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 03:56:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rclobus.nl; 
 s=x;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=m4AEfBD534WbCgUTAzr9lOvChEdBMDh0qwB8cmn7u+g=; b=BQJpl2vGpcSlqcXQnG9inJEHC0
 iOwgO07ZpqjvIHiRcR9um25X49oATy8jxd02Mspqj2VwbisBpDCMwYjCbrzWyHeLCL2qX5ylgmjIY
 nPJPdlHY8HPx9QtiWF6lJY40GtF4uNmCW/Ufp7iVvaNN+Jm9GDsfLjI3ApnVBqb8O7WCrZktpQSdj
 c9sEDFSKYkepJmC7PAnP3cspHdXpikA2qbCYKy1bwI9HeEQbBf4ST/s9hoeBsfuZTjPZYEOENqmZ3
 ijdRw3AwqWIUZXAbsaD+oHqTpH8lRT+RNctzqfEvMgdhi3V1itWYghIHXwaDbLw/f9NfjzRTj55Rl
 12L8EbLQ==;
Received: from p4fe11eec.dip0.t-ipconnect.de ([79.225.30.236] helo=silent.lan)
 by web05.whitelabeldomein.nl with esmtpsa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.99.4)
 (envelope-from <rclobus@rclobus.nl>) id 1wh0fn-0000000Cnb2-27SM;
 Tue, 07 Jul 2026 09:56:55 +0200
From: Roland Clobus <rclobus@rclobus.nl>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Roland Clobus <rclobus@rclobus.nl>
Subject: [PATCH v2 3/5] virtio-gpu: Allow modifications to the outputs
Date: Tue,  7 Jul 2026 09:47:58 +0200
Message-ID: <20260707075536.126865-3-rclobus@rclobus.nl>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707075536.126865-1-rclobus@rclobus.nl>
References: <20260707075536.126865-1-rclobus@rclobus.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Id: rclobus@rclobus.nl
Received-SPF: pass client-ip=2a09:8b00:300:8::10;
 envelope-from=rclobus@rclobus.nl; helo=web05.whitelabeldomein.nl
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Some systems need a stub for the event sender

Signed-off-by: Roland Clobus <rclobus@rclobus.nl>
---
 hw/core/meson.build              | 1 +
 hw/core/qdev-properties-system.c | 7 +++++++
 hw/core/virtio-gpu-stubs.c       | 6 ++++++
 3 files changed, 14 insertions(+)
 create mode 100644 hw/core/virtio-gpu-stubs.c

diff --git a/hw/core/meson.build b/hw/core/meson.build
index 8a96567de8..3e0d917d67 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,6 +26,7 @@ system_ss.add(when: 'CONFIG_SPLIT_IRQ', if_true: files('split-irq.c'))
 system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
+system_ss.add(when: 'CONFIG_VIRTIO_GPU', if_false: files('virtio-gpu-stubs.c'))
 
 system_ss.add(files(
   'cpu-system.c',
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index 04e5acac08..79b6c27986 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -37,6 +37,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/pcie.h"
 #include "hw/i386/x86.h"
+#include "hw/virtio/virtio-gpu.h"
+#include "standard-headers/linux/virtio_gpu.h"
 #include "util/block-helpers.h"
 
 static bool check_prop_still_unset(Object *obj, const char *name,
@@ -1413,6 +1415,10 @@ static void set_virtio_gpu_output_list(Object *obj, Visitor *v,
 
     qapi_free_VirtIOGPUOutputList(*prop_ptr);
     *prop_ptr = list;
+
+    VirtIOGPUBase *g = VIRTIO_GPU_BASE(obj);
+    g->virtio_config.events_read |= VIRTIO_GPU_EVENT_DISPLAY;
+    virtio_notify_config(&g->parent_obj);
 }
 
 static void release_virtio_gpu_output_list(Object *obj,
@@ -1428,6 +1434,7 @@ static void release_virtio_gpu_output_list(Object *obj,
 const PropertyInfo qdev_prop_virtio_gpu_output_list = {
     .type = "VirtIOGPUOutputList",
     .description = "VirtIO GPU output list [{\"name\":\"<name>\"},...]",
+    .realized_set_allowed = true,
     .get = get_virtio_gpu_output_list,
     .set = set_virtio_gpu_output_list,
     .release = release_virtio_gpu_output_list,
diff --git a/hw/core/virtio-gpu-stubs.c b/hw/core/virtio-gpu-stubs.c
new file mode 100644
index 0000000000..a3048a8d45
--- /dev/null
+++ b/hw/core/virtio-gpu-stubs.c
@@ -0,0 +1,6 @@
+typedef struct VirtIODevice VirtIODevice;
+
+void virtio_notify_config(VirtIODevice *);
+
+void virtio_notify_config(VirtIODevice *) {
+}
-- 
2.53.0


