Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B638FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 12:31:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJsSf-000387-TP; Mon, 04 May 2026 08:31:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSd-0002yO-Tq
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJsSb-0006zj-2V
 for qemu-devel@nongnu.org; Mon, 04 May 2026 08:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777897900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcmYJKczFdNS6+10IiTyAAAA3xk/hj/5vhP6W5tDrI0=;
 b=Mg/j/CWPjALrXz3rXZIn6mqs/6/vl8jOArDNqFquJ/pDRrGciTpb2pIbrAWuZeMDakV0hg
 nNyxfeOYA2yrUwX2tfuw5wIpQsjqI3kDp0uRIV55BvtTxu0FEfGgXhPEwe29cCpZXE0rdk
 kehkvrBVm7YyM/GA9ZjEg6IXoLV5teg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-DMx0qLunNK-rTNnHbsUowQ-1; Mon,
 04 May 2026 08:31:38 -0400
X-MC-Unique: DMx0qLunNK-rTNnHbsUowQ-1
X-Mimecast-MFC-AGG-ID: DMx0qLunNK-rTNnHbsUowQ_1777897898
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E9C1E18001EF
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 12:31:37 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 91B381800480; Mon,  4 May 2026 12:31:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 16:30:18 +0400
Subject: [PATCH v4 12/13] monitor: add 'info ramblock-attributes' command
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-rdm5-v4-12-bdf61e57c1e1@redhat.com>
References: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
In-Reply-To: <20260504-rdm5-v4-0-bdf61e57c1e1@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8506;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bSLDIQ7pzHskHJGAX8SB1wKv/elLW1gRn22yUDyLfVk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+JFZ34WfLFgzKM4dZiFtHeK04UCTHGcZI+JQ2
 TV58Ps3CMGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiRWQAKCRDa6OEJdZac
 5WBoD/98z0fSor6BYgxKrhf66Hy3uPq9zDjcNZoJ+JkceQMPkYvm1eeJpoiWZXrE0j0/paC35s5
 gheDCYPAirNzWrcDync49xVjpYoU01g+QE80F6mUpWqW3J29TXw4g5TNUq66vyllKQwEDwCWC5D
 vH8Zlgpw4MrpBxJQjefcNcCYqZLHHqhpYGmSqwV72g+DoJGb1wWTwne62CFLFNtJ6hTf+xxAs3B
 T3MSLSFT6+6hha2tbsadF65FBYIqcl2W8Gh6C8P4sIqrnehB+v25FTpUWFyrg51LJd68YIj1J/J
 ItsOP/1RTJIPm6a+PiKCkNuaZrMIPZOzMheieMB3J4DEYHXXBqX96qddnitfeXhdkbettMxxk+h
 fMBAOHcRDGO3L1yLacr1iya2K4VEYd1hvnjjnwbjDXogUXVqXivDpEm424SXaykNrAZPJbGQyu1
 P5jVLVX+f9RQ/QYJNGZY/f11IuSXq9eIFmM5cP8xTr+NbMUJvRR77iM3jStJbRi6zrDzs+7KGxf
 wdcFs++LhmvfXq93FOXOPoiJNA/CVxlv5aNRcCVhw0thw5WSssyUblFCuIarYXUr/4jtBCtHY58
 Zj1+0zsIEKq0oiQtFyx8Swp73sSRTiWIh774n7WokC02LwcDaASS9vRd3ofjD+eRzcKEqG1lWuw
 CfaPTjEero9p3AA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a new 'info ramblock-attributes' HMP command and the corresponding
'x-query-ramblock-attributes' QMP command to display the shared/private
memory attributes for ram blocks.

The QMP command returns structured data (RamBlockAttributesInfo list
with per-range shared/populated attributes), while HMP formats it for
human consumption.

This is useful for debugging confidential guests (TDX, SNP) to inspect
which memory regions are shared vs private, and their population state
when a RamDiscardManager is present (e.g. virtio-mem).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/machine.json             | 55 +++++++++++++++++++++++++++++++++
 include/monitor/hmp.h         |  1 +
 hw/core/machine-hmp-cmds.c    | 32 +++++++++++++++++++
 system/ram-block-attributes.c | 72 +++++++++++++++++++++++++++++++++++++++++++
 hmp-commands-info.hx          | 13 ++++++++
 5 files changed, 173 insertions(+)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b87..aac8a235cf6 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1738,6 +1738,61 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
+##
+# @RamBlockAttributeRange:
+#
+# A contiguous range within a ram block with uniform attributes.
+#
+# @start: start offset in bytes within the ram block
+#
+# @length: length in bytes of the range
+#
+# @shared: true if the range is shared, false if private
+#
+# @populated: true if the range is populated (only present when a
+#     RamDiscardManager is managing the block)
+#
+# Since: 11.1
+##
+{ 'struct': 'RamBlockAttributeRange',
+  'data': { 'start': 'uint64',
+            'length': 'uint64',
+            'shared': 'bool',
+            '*populated': 'bool' } }
+
+##
+# @RamBlockAttributesInfo:
+#
+# Shared/private memory attributes for a ram block.
+#
+# @name: the ram block identifier
+#
+# @ranges: list of attribute ranges
+#
+# Since: 11.1
+##
+{ 'struct': 'RamBlockAttributesInfo',
+  'data': { 'name': 'str',
+            'ranges': [ 'RamBlockAttributeRange' ] } }
+
+##
+# @x-query-ramblock-attributes:
+#
+# Query ram block shared/private attributes.  This is useful
+# to debug confidential guests.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: list of ram block attributes
+#
+# Since: 11.1
+##
+{ 'command': 'x-query-ramblock-attributes',
+  'returns': [ 'RamBlockAttributesInfo' ],
+  'features': [ 'unstable' ] }
+
 ##
 # @x-query-roms:
 #
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index e222bea60cd..4493952b417 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -143,6 +143,7 @@ void hmp_info_dump(Monitor *mon, const QDict *qdict);
 void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
+void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict);
 void hmp_info_replay(Monitor *mon, const QDict *qdict);
 void hmp_replay_break(Monitor *mon, const QDict *qdict);
 void hmp_replay_delete_break(Monitor *mon, const QDict *qdict);
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 46846f741a2..122e1a0f735 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -24,6 +24,7 @@
 #include "qapi/string-output-visitor.h"
 #include "qemu/error-report.h"
 #include "system/numa.h"
+#include "system/ramblock.h"
 #include "hw/core/boards.h"
 
 void hmp_info_cpus(Monitor *mon, const QDict *qdict)
@@ -388,3 +389,34 @@ void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict)
     }
     hmp_handle_error(mon, err);
 }
+
+void hmp_info_ramblock_attributes(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+    g_autoptr(RamBlockAttributesInfoList) list = NULL;
+    RamBlockAttributesInfoList *it;
+
+    list = qmp_x_query_ramblock_attributes(&err);
+    if (hmp_handle_error(mon, err)) {
+        return;
+    }
+
+    for (it = list; it; it = it->next) {
+        RamBlockAttributesInfo *rba = it->value;
+        RamBlockAttributeRangeList *r;
+
+        monitor_printf(mon, "%s:\n", rba->name);
+        for (r = rba->ranges; r; r = r->next) {
+            RamBlockAttributeRange *range = r->value;
+            const char *shared = range->shared ? "shared" : "private";
+            const char *pop = range->has_populated ?
+                (range->populated ? "+populated" : "-populated") : "";
+
+            monitor_printf(mon,
+                           "  0x%016" PRIx64 "-0x%016" PRIx64 " %s%s\n",
+                           range->start,
+                           range->start + range->length - 1,
+                           shared, pop);
+        }
+    }
+}
diff --git a/system/ram-block-attributes.c b/system/ram-block-attributes.c
index 59ec7a28eb0..f9573801b60 100644
--- a/system/ram-block-attributes.c
+++ b/system/ram-block-attributes.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-commands-machine.h"
 #include "system/ramblock.h"
 #include "trace.h"
 
@@ -221,3 +222,74 @@ static void ram_block_attributes_class_init(ObjectClass *klass,
     rdsc->get_min_granularity = ram_block_attributes_rds_get_min_granularity;
     rdsc->is_populated = ram_block_attributes_rds_is_populated;
 }
+
+RamBlockAttributesInfoList *qmp_x_query_ramblock_attributes(Error **errp)
+{
+    RamBlockAttributesInfoList *head = NULL, **tail = &head;
+    RAMBlock *block;
+    size_t rba_block_size = ram_block_attributes_get_block_size();
+
+    RCU_READ_LOCK_GUARD();
+
+    RAMBLOCK_FOREACH(block) {
+        RamBlockAttributesInfo *rba;
+        RamBlockAttributeRangeList **range_tail;
+        RamBlockAttributes *attr = block->attributes;
+        RamDiscardManager *rdm;
+        bool has_rdm;
+        unsigned long pos;
+
+        if (!attr) {
+            continue;
+        }
+
+        rdm = memory_region_get_ram_discard_manager(block->mr);
+        has_rdm = rdm != NULL;
+
+        rba = g_new0(RamBlockAttributesInfo, 1);
+        rba->name = g_strdup(block->idstr);
+        range_tail = &rba->ranges;
+
+        pos = 0;
+        while (pos < attr->bitmap_size) {
+            bool is_shared = test_bit(pos, attr->bitmap);
+            unsigned long next;
+            uint64_t start_offset, length;
+            RamBlockAttributeRange *range;
+
+            if (is_shared) {
+                next = find_next_zero_bit(attr->bitmap,
+                                          attr->bitmap_size, pos);
+            } else {
+                next = find_next_bit(attr->bitmap,
+                                     attr->bitmap_size, pos);
+            }
+
+            start_offset = (uint64_t)pos * rba_block_size;
+            length = (uint64_t)(next - pos) * rba_block_size;
+
+            range = g_new0(RamBlockAttributeRange, 1);
+            range->start = start_offset;
+            range->length = length;
+            range->shared = is_shared;
+
+            if (has_rdm) {
+                MemoryRegionSection section = {
+                    .mr = block->mr,
+                    .offset_within_region = start_offset,
+                    .size = int128_make64(length),
+                };
+                range->has_populated = true;
+                range->populated =
+                    ram_discard_manager_is_populated(rdm, &section);
+            }
+
+            QAPI_LIST_APPEND(range_tail, range);
+            pos = next;
+        }
+
+        QAPI_LIST_APPEND(tail, rba);
+    }
+
+    return head;
+}
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 74c741f80e2..1168b4c20ca 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -774,6 +774,19 @@ SRST
     Dump all the ramblocks of the system.
 ERST
 
+    {
+        .name       = "ramblock-attributes",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Display ramblock shared/private attributes",
+        .cmd        = hmp_info_ramblock_attributes,
+    },
+
+SRST
+  ``info ramblock-attributes``
+    Display the shared/private memory attributes for ram blocks.
+ERST
+
     {
         .name       = "hotpluggable-cpus",
         .args_type  = "",

-- 
2.54.0


