Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E53C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weX1A-0002U4-Bk; Tue, 30 Jun 2026 07:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1weX18-0002SI-GG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:52:42 -0400
Received: from mout02.posteo.de ([185.67.36.66])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1weX15-0001Ld-1G
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:52:42 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout02.posteo.de (Postfix) with ESMTPS id 46E1F240103
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 13:52:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782820356; bh=1a8nVCf5L0n90zM9p8EuZBcSpS2tt5IZlMv/BXN4Q4o=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=o6tMlpjtZso1rgtfM3rPU+1Dd+kYSr1+R5ixJIPe9o5EMnM2KxsRxroKqyTQsk7Cs
 Y5qAqmCFuSv7b7aSgcGLqtYv1kANPkL35zm1/1wQXsD/abPu2gunBI5ZOPUK7/qy88
 czYPwy8gV3B7XmryFxNR6HSkqdH+NYuqCcgtYCU4M98bIIHvAln7Yf1QX0+ewP29Th
 l2DqqRFEau3hqU7el/WZeFDWXCYY3wuHRI1JFvWbV2gjz9S1jyd6tNyFhhNi3nFMqi
 iY0FfY+o/mtrZLbZmVZga9jS2AQdhxfK8lk+sIJlePiHY+kgA8KKeWtS/ks0OsOI8x
 kzHlTXQ4nIcVg==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gqM2n5xDlz6v0F;
 Tue, 30 Jun 2026 13:52:33 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 Klaus Jensen <its@irrelevant.dk>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v4 2/2] hw/nvme: add 'info nvme-queues' HMP command
Date: Tue, 30 Jun 2026 11:52:35 +0000
Message-ID: <416be273b5f007e656d2ac8ec67d817114ac5452.1782819251.git.mateusz.nowicki@posteo.net>
In-Reply-To: <cover.1782819251.git.mateusz.nowicki@posteo.net>
References: <cover.1782819251.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.66;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout02.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add an 'info nvme-queues' HMP command that lists, for every emulated
NVMe controller, the admin SQ/CQ and every active I/O SQ/CQ.

For each queue the command prints:

  - the ring size, head and tail indices;
  - the associated CQ id (for SQ) or interrupt vector (for CQ);
  - the queue's PRP1 (DMA base address of the ring);
  - the BAR0-relative doorbell offset (SQyTDBL / CQyHDBL);
  - the current CQ phase tag.

The doorbell offsets are computed from CAP.DSTRD so they remain
correct if the emulation ever exposes a non-zero stride.

Useful when debugging the Linux NVMe driver against the QEMU
emulation - queue setup, doorbell rings, AERs held in the admin SQ
etc. - without attaching gdb to the QEMU process.

Example, with the long PRP1 ring address and BAR0-relative doorbell
offset replaced by '...'; phase tag column omitted for brevity:

  (qemu) info nvme-queues
  /machine/peripheral-anon/device[0]
  SQ 0  size=32    head=9     tail=9     cqid=0    prp1=...  SQTDBL=...
  CQ 0  size=32    head=8     tail=8     iv=0      prp1=...  CQHDBL=...
  SQ 1  size=1024  head=2     tail=2     cqid=1    prp1=...  SQTDBL=...
  CQ 1  size=1024  head=2     tail=2     iv=1      prp1=...  CQHDBL=...

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx   | 15 ++++++++++
 hw/nvme/monitor-stub.c |  6 ++++
 hw/nvme/monitor.c      | 63 ++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json      | 17 ++++++++++++
 4 files changed, 101 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index b984691c3c..874c1e1970 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -353,6 +353,21 @@ SRST
     Show emulated NVMe controllers.
 ERST
 
+    {
+        .name       = "nvme-queues",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show active NVMe queues and their doorbells",
+        .cmd_info_hrt = qmp_x_query_nvme_queues,
+    },
+
+SRST
+  ``info nvme-queues``
+    Show all active NVMe submission and completion queues, including
+    head/tail, DMA address of the ring and BAR0-relative doorbell
+    offset.
+ERST
+
     {
         .name       = "usbhost",
         .args_type  = "",
diff --git a/hw/nvme/monitor-stub.c b/hw/nvme/monitor-stub.c
index 5eb9f04c8d..489cc4a5c7 100644
--- a/hw/nvme/monitor-stub.c
+++ b/hw/nvme/monitor-stub.c
@@ -13,3 +13,9 @@ HumanReadableText *qmp_x_query_nvme(Error **errp)
     error_setg(errp, "NVMe support is not compiled in");
     return NULL;
 }
+
+HumanReadableText *qmp_x_query_nvme_queues(Error **errp)
+{
+    error_setg(errp, "NVMe support is not compiled in");
+    return NULL;
+}
diff --git a/hw/nvme/monitor.c b/hw/nvme/monitor.c
index 95a6754437..c8161943c0 100644
--- a/hw/nvme/monitor.c
+++ b/hw/nvme/monitor.c
@@ -74,3 +74,66 @@ HumanReadableText *qmp_x_query_nvme(Error **errp)
 
     return human_readable_text_from_str(buf);
 }
+
+static void append_sq(GString *buf, NvmeSQueue *sq, unsigned stride)
+{
+    hwaddr db_off = 0x1000 + 2 * sq->sqid * stride;
+
+    g_string_append_printf(buf,
+        "  SQ %u  size=%-5u head=%-5u tail=%-5u cqid=%-3u  "
+        "prp1=0x%016" PRIx64 "  SQTDBL=BAR0+0x%03" HWADDR_PRIx "\n",
+        sq->sqid, sq->size, sq->head, sq->tail, sq->cqid,
+        sq->dma_addr, db_off);
+}
+
+static void append_cq(GString *buf, NvmeCQueue *cq, unsigned stride)
+{
+    hwaddr db_off = 0x1000 + (2 * cq->cqid + 1) * stride;
+
+    g_string_append_printf(buf,
+        "  CQ %u  size=%-5u head=%-5u tail=%-5u iv=%-5u  "
+        "prp1=0x%016" PRIx64 "  CQHDBL=BAR0+0x%03" HWADDR_PRIx
+        "  phaseTag=%u\n",
+        cq->cqid, cq->size, cq->head, cq->tail, cq->vector,
+        cq->dma_addr, db_off, cq->phase);
+}
+
+static int collect_queues(Object *obj, void *opaque)
+{
+    GString *buf = opaque;
+    NvmeCtrl *n;
+    unsigned stride;
+
+    if (!object_dynamic_cast(obj, TYPE_NVME)) {
+        return 0;
+    }
+    n = NVME(obj);
+    stride = 4u << NVME_CAP_DSTRD(ldq_le_p(&n->bar.cap));
+
+    g_string_append_printf(buf, "%s\n", object_get_canonical_path(obj));
+    append_sq(buf, &n->admin_sq, stride);
+    append_cq(buf, &n->admin_cq, stride);
+
+    for (unsigned i = 1; i <= n->params.max_ioqpairs; i++) {
+        if (n->sq && n->sq[i]) {
+            append_sq(buf, n->sq[i], stride);
+        }
+        if (n->cq && n->cq[i]) {
+            append_cq(buf, n->cq[i], stride);
+        }
+    }
+    return 0;
+}
+
+HumanReadableText *qmp_x_query_nvme_queues(Error **errp)
+{
+    g_autoptr(GString) buf = g_string_new("");
+
+    object_child_foreach_recursive(object_get_root(), collect_queues, buf);
+
+    if (buf->len == 0) {
+        g_string_append(buf, "no NVMe controllers\n");
+    }
+
+    return human_readable_text_from_str(buf);
+}
diff --git a/qapi/machine.json b/qapi/machine.json
index d4a589e768..c21b128e0a 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1789,6 +1789,23 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
+##
+# @x-query-nvme-queues:
+#
+# Query state of all active SQ/CQ for emulated NVMe controllers.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: per-queue state as human-readable text
+#
+# Since: 11.1
+##
+{ 'command': 'x-query-nvme-queues',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ] }
+
 ##
 # @SmbiosEntryPointType:
 #
-- 
2.53.0


