Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A0ACAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 14:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5loO-0003K5-Bx; Mon, 06 Oct 2025 10:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v5loM-0003Jg-Qx
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:03:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1v5loJ-0001Ad-HU
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 10:03:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759759405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4WY03YEuU+G3rZiNKmw1qWeknptuOYy6v+IQXbOhcpI=;
 b=IuBzVsIjBhL3yovPkqF5KtSYAsmrHLkiaDqf7T7L3GGyaFZFLM8d+KUR3xmfuXck7LqZlJ
 kUqoM6ecS7KO0FYsmuSdR2HH2bDL6E90y23Wq0TCtXSnTiFo6ccoV79Ii7dQR/sBf4Qstb
 srrEP/fs2k5/k2YGdeZzSqd3/D2p3hg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-O9eOhSx6M-eKpl2mrmkSVQ-1; Mon,
 06 Oct 2025 10:03:22 -0400
X-MC-Unique: O9eOhSx6M-eKpl2mrmkSVQ-1
X-Mimecast-MFC-AGG-ID: O9eOhSx6M-eKpl2mrmkSVQ_1759759402
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5DB719560B0; Mon,  6 Oct 2025 14:03:21 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.183])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1DBB3001FF0; Mon,  6 Oct 2025 14:03:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 252521800082; Mon, 06 Oct 2025 16:03:18 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] RfC: hw/uefi: add "info ovmf-log" monitor command
Date: Mon,  6 Oct 2025 16:03:17 +0200
Message-ID: <20251006140318.578490-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Starting with the edk2-stable202508 tag OVMF (and ArmVirt too) have
optional support for logging to a memory buffer.  There is guest side
support -- for example in linux kernels v6.17+ -- to read that buffer.
But that might not helpful if your guest stops booting early enough that
guest tooling can not be used yet.  So host side support to read that
log buffer is a useful thing to have.

This proof-of-concept patch implements one possible approach for the
problem.  It adds a qemu monitor command to read the log.  It is a hmp
command and it will send the complete firmware log (assuming the guest
firmware created one) to your monitor connection.

Obviously this is not the only way to do it.  Other ideas:

 * Have a qmp command which returns the log some way as json.
 * Have a qmp command which writes the log to a file.
 * Have both qmp and hmp commands.
 * Implement support for giving other processes access to guest
   memory (roughly comparable to what vhost-user already allows),
   then build some external utility for firmware log access.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/monitor/hmp.h |   1 +
 hw/uefi/ovmf-log.c    | 168 ++++++++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx  |  14 ++++
 hw/uefi/meson.build   |   2 +-
 4 files changed, 184 insertions(+), 1 deletion(-)
 create mode 100644 hw/uefi/ovmf-log.c

diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804a3..fc5917c1eed5 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -178,5 +178,6 @@ void hmp_boot_set(Monitor *mon, const QDict *qdict);
 void hmp_info_mtree(Monitor *mon, const QDict *qdict);
 void hmp_info_cryptodev(Monitor *mon, const QDict *qdict);
 void hmp_dumpdtb(Monitor *mon, const QDict *qdict);
+void hmp_info_ovmf_log(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/hw/uefi/ovmf-log.c b/hw/uefi/ovmf-log.c
new file mode 100644
index 000000000000..19d90231a57e
--- /dev/null
+++ b/hw/uefi/ovmf-log.c
@@ -0,0 +1,168 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * print ovmf debug log
+ *
+ * see OvmfPkg/Library/MemDebugLogLib/ in edk2
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "system/dma.h"
+#include "monitor/hmp.h"
+#include "monitor/monitor.h"
+
+
+/* ----------------------------------------------------------------------- */
+/* copy from edk2                                                          */
+
+#define MEM_DEBUG_LOG_MAGIC1  0x3167646d666d766f  // "ovmfmdg1"
+#define MEM_DEBUG_LOG_MAGIC2  0x3267646d666d766f  // "ovmfmdg2"
+
+/*
+ * Mem Debug Log buffer header.
+ * The Log buffer is circular. Only the most
+ * recent messages are retained. Older messages
+ * will be discarded if the buffer overflows.
+ * The Debug Log starts just after the header.
+ */
+typedef struct {
+    /*
+     * Magic values
+     * These fields are used by tools to locate the buffer in
+     * memory. These MUST be the first two fields of the structure.
+     * Use a 128 bit Magic to vastly reduce the possibility of
+     * a collision with random data in memory.
+     */
+    uint64_t             Magic1;
+    uint64_t             Magic2;
+    /*
+     * Header Size
+     * This MUST be the third field of the structure
+     */
+    uint64_t             HeaderSize;
+    /*
+     * Debug log size (minus header)
+     */
+    uint64_t             DebugLogSize;
+    /*
+     * edk2 uses this for locking access.
+     */
+    uint64_t             MemDebugLogLock;
+    /*
+     * Debug log head offset
+     */
+    uint64_t             DebugLogHeadOffset;
+    /*
+     *  Debug log tail offset
+     */
+    uint64_t             DebugLogTailOffset;
+    /*
+     * Flag to indicate if the buffer wrapped and was thus truncated.
+     */
+    uint64_t             Truncated;
+    /*
+     * Firmware Build Version (PcdFirmwareVersionString)
+     */
+    char                 FirmwareVersion[128];
+} MEM_DEBUG_LOG_HDR;
+
+
+/* ----------------------------------------------------------------------- */
+/* qemu monitor command                                                    */
+
+typedef struct {
+    uint64_t             Magic1;
+    uint64_t             Magic2;
+} MEM_DEBUG_LOG_MAGIC;
+
+/* find log buffer in guest memory by searching for the magic cookie */
+static dma_addr_t find_ovmf_log(void)
+{
+    static const MEM_DEBUG_LOG_MAGIC magic = {
+        .Magic1 = MEM_DEBUG_LOG_MAGIC1,
+        .Magic2 = MEM_DEBUG_LOG_MAGIC2,
+    };
+    MEM_DEBUG_LOG_MAGIC check;
+    dma_addr_t offset;
+
+    /*
+     * FIXME: Search range probably need arch specific tweaks for non-x86.
+     */
+    dma_addr_t start = 0;
+    dma_addr_t step = 4 * KiB; /* buffer is page aligned */
+    dma_addr_t end = start + 4 * GiB; /* buffer is in low memory */
+
+    for (offset = start; offset < end; offset += step) {
+        if (dma_memory_read(&address_space_memory, offset,
+                            &check, sizeof(check),
+                            MEMTXATTRS_UNSPECIFIED)) {
+            /* dma error -> stop searching */
+            return -1;
+        }
+        if (memcmp(&magic, &check, sizeof(check)) == 0) {
+            return offset;
+        }
+    };
+
+    return -1;
+}
+
+static void handle_ovmf_log_range(Monitor *mon,
+                                  dma_addr_t start,
+                                  dma_addr_t end)
+{
+    g_autofree char *buf = NULL;
+
+    if (start > end) {
+        return;
+    }
+
+    buf = g_malloc(end - start + 1);
+    if (dma_memory_read(&address_space_memory, start,
+                        buf, end - start,
+                        MEMTXATTRS_UNSPECIFIED)) {
+        monitor_printf(mon, "firmware log: buffer read error\n");
+        return;
+    }
+
+    buf[end - start] = 0;
+    monitor_printf(mon, "%s", buf);
+}
+
+void hmp_info_ovmf_log(Monitor *mon, const QDict *qdict)
+{
+    MEM_DEBUG_LOG_HDR header;
+    dma_addr_t offset, base;
+
+    offset = find_ovmf_log();
+    if (offset == -1) {
+        monitor_printf(mon, "firmware log: not found\n");
+        return;
+    }
+
+    if (dma_memory_read(&address_space_memory, offset,
+                        &header, sizeof(header),
+                        MEMTXATTRS_UNSPECIFIED)) {
+        monitor_printf(mon, "firmware log: header read error\n");
+        return;
+    }
+
+    monitor_printf(mon, "firmware log: version \"%s\"\n",
+                   header.FirmwareVersion);
+
+    base = offset + header.HeaderSize;
+    if (header.DebugLogHeadOffset > header.DebugLogTailOffset) {
+        /* wrap around */
+        handle_ovmf_log_range(mon,
+                              base + header.DebugLogHeadOffset,
+                              base + header.DebugLogSize);
+        handle_ovmf_log_range(mon,
+                              base + 0,
+                              base + header.DebugLogTailOffset);
+    } else {
+        handle_ovmf_log_range(mon,
+                              base + header.DebugLogHeadOffset,
+                              base + header.DebugLogTailOffset);
+    }
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6142f60e7b16..4bd2102a8df5 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -977,3 +977,17 @@ SRST
   ``info cryptodev``
     Show the crypto devices.
 ERST
+
+    {
+        .name       = "ovmf-log",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the ovmf debug log",
+        .cmd        = hmp_info_ovmf_log,
+        .flags      = "p",
+    },
+
+SRST
+  ``info ovmf-log``
+    Show the ovmf debug log.
+ERST
diff --git a/hw/uefi/meson.build b/hw/uefi/meson.build
index 91eb95f89e6d..c8f38dfae247 100644
--- a/hw/uefi/meson.build
+++ b/hw/uefi/meson.build
@@ -1,4 +1,4 @@
-system_ss.add(files('hardware-info.c'))
+system_ss.add(files('hardware-info.c', 'ovmf-log.c'))
 
 uefi_vars_ss = ss.source_set()
 if (config_all_devices.has_key('CONFIG_UEFI_VARS'))
-- 
2.51.0


