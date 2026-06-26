Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64404CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 11:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd4cv-0006aC-CG; Fri, 26 Jun 2026 07:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd4cm-0006YI-7Z
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:21:32 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mateusz.nowicki@posteo.net>)
 id 1wd4cj-0007hW-I7
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 07:21:31 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 9D6A324002B
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 13:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
 t=1782472887; bh=q7susRhhQnQCDaxcc3Llh204x+fBSknDmH84e4MZlmU=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
 Content-Transfer-Encoding:From;
 b=KChrknIp1A4E8jqpKC1fx9Iho87J5XWsnnFO9OLXTNYJluvo5K773oEb8d/ekBPN1
 M941Oz+yS1JZrRykmbY8sDd+sTjl/VoAamnxu7nEvYHL1NUOdU1NwNj8R4cltV1Jwp
 LR8FRz7BH9sWN4xvYo9ITBqJMGS9cmqiV/59VfET0rI3zpI+pLMkCqBwKN9+aZxmj6
 Byc9N8HtN71wCiQkZJD1FurmXp0tIrx8Ofo66GUjHD0IXEH2B/+0gw3kq7PJ/jAu3b
 E1R7t50FsgHPkBfCCJhu8eII4LuD6SAS+j+ai6KYQV1a7Y6LAPZidaYzUV9omT+mme
 HKAgwycF1HnrA==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4gmtXk1fBnz6twg;
 Fri, 26 Jun 2026 13:21:26 +0200 (CEST)
From: Mateusz Nowicki <mateusz.nowicki@posteo.net>
To: qemu-devel@nongnu.org
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v3 1/2] hw/nvme: add 'info nvme' HMP command
Date: Fri, 26 Jun 2026 11:21:27 +0000
Message-ID: <20260626112116.7621-2-mateusz.nowicki@posteo.net>
In-Reply-To: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
References: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.67.36.65;
 envelope-from=mateusz.nowicki@posteo.net; helo=mout01.posteo.de
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

Add an 'info nvme' HMP command for inspecting emulated NVMe
controllers from the QEMU monitor.

For each NVMe controller in the QOM tree the command prints:

  - PCI BDF, vendor/device ID and BAR0 base address;
  - Identify Controller fields visible to the host driver: SN, MN, FR
    and CNTLID;
  - the CC, CSTS and AQA registers (raw 32-bit values);
  - the number of admin and active I/O submission/completion queues.

Useful when debugging the Linux NVMe driver against the QEMU emulation
without attaching gdb to the QEMU process.

Example:

  (qemu) info nvme
  /machine/peripheral-anon/device[0]
    PCI:    BDF 00:04.0  VID=8086 DID=5845  BAR0=0x00000000feb50000
    ID:     SN=NVME0001  MN=QEMU NVMe Ctrl  FR=...  CNTLID=0x0000
    CC:     0x00460001
    CSTS:   0x00000001
    AQA:    0x001f001f
    Queues: 1 admin + 4 IO SQ / 4 IO CQ

Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
Acked-by: Markus Armbruster <armbru@redhat.com>
---
 hmp-commands-info.hx | 15 +++++++++
 hw/nvme/meson.build  |  2 +-
 hw/nvme/monitor.c    | 76 ++++++++++++++++++++++++++++++++++++++++++++
 qapi/machine.json    | 18 +++++++++++
 4 files changed, 110 insertions(+), 1 deletion(-)
 create mode 100644 hw/nvme/monitor.c

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 82134eb6c2..c3456e1b65 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -340,6 +340,21 @@ SRST
     Show guest USB devices.
 ERST
 
+#if defined(CONFIG_NVME_PCI)
+    {
+        .name       = "nvme",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show emulated NVMe controllers",
+        .cmd_info_hrt = qmp_x_query_nvme,
+    },
+#endif
+
+SRST
+  ``info nvme``
+    Show emulated NVMe controllers.
+ERST
+
     {
         .name       = "usbhost",
         .args_type  = "",
diff --git a/hw/nvme/meson.build b/hw/nvme/meson.build
index 7d5caa53c2..6c57f14930 100644
--- a/hw/nvme/meson.build
+++ b/hw/nvme/meson.build
@@ -1 +1 @@
-system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'ns.c', 'subsys.c', 'nguid.c'))
\ No newline at end of file
+system_ss.add(when: 'CONFIG_NVME_PCI', if_true: files('ctrl.c', 'dif.c', 'monitor.c', 'nguid.c', 'ns.c', 'subsys.c'))
diff --git a/hw/nvme/monitor.c b/hw/nvme/monitor.c
new file mode 100644
index 0000000000..95a6754437
--- /dev/null
+++ b/hw/nvme/monitor.c
@@ -0,0 +1,76 @@
+/*
+ * QEMU NVMe Controller monitor commands
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/type-helpers.h"
+#include "hw/pci/pci.h"
+
+#include "nvme.h"
+
+static int collect_one(Object *obj, void *opaque)
+{
+    GString *buf = opaque;
+    NvmeCtrl *n;
+    PCIDevice *pci;
+    pcibus_t bar0;
+    unsigned io_sq = 0, io_cq = 0;
+
+    if (!object_dynamic_cast(obj, TYPE_NVME)) {
+        return 0;
+    }
+    n = NVME(obj);
+    pci = PCI_DEVICE(n);
+    bar0 = pci_get_bar_addr(pci, 0);
+
+    for (unsigned i = 1; i <= n->params.max_ioqpairs; i++) {
+        if (n->sq && n->sq[i]) {
+            io_sq++;
+        }
+        if (n->cq && n->cq[i]) {
+            io_cq++;
+        }
+    }
+
+    g_string_append_printf(buf, "%s\n", object_get_canonical_path(obj));
+    g_string_append_printf(buf,
+        "  PCI:    BDF %02x:%02x.%x  VID=%04x DID=%04x  ",
+        pci_dev_bus_num(pci), PCI_SLOT(pci->devfn), PCI_FUNC(pci->devfn),
+        pci_get_word(pci->config + PCI_VENDOR_ID),
+        pci_get_word(pci->config + PCI_DEVICE_ID));
+    if (bar0 == PCI_BAR_UNMAPPED) {
+        g_string_append(buf, "BAR0=unmapped\n");
+    } else {
+        g_string_append_printf(buf, "BAR0=0x%016" PRIx64 "\n",
+                               (uint64_t)bar0);
+    }
+    g_string_append_printf(buf,
+        "  ID:     SN=%.20s  MN=%.40s  FR=%.8s  CNTLID=0x%04x\n",
+        n->id_ctrl.sn, n->id_ctrl.mn, n->id_ctrl.fr, n->cntlid);
+    g_string_append_printf(buf, "  CC:     0x%08x\n",
+                           ldl_le_p(&n->bar.cc));
+    g_string_append_printf(buf, "  CSTS:   0x%08x\n",
+                           ldl_le_p(&n->bar.csts));
+    g_string_append_printf(buf, "  AQA:    0x%08x\n",
+                           ldl_le_p(&n->bar.aqa));
+    g_string_append_printf(buf,
+        "  Queues: 1 admin + %u IO SQ / %u IO CQ\n", io_sq, io_cq);
+    return 0;
+}
+
+HumanReadableText *qmp_x_query_nvme(Error **errp)
+{
+    g_autoptr(GString) buf = g_string_new("");
+
+    object_child_foreach_recursive(object_get_root(), collect_one, buf);
+
+    if (buf->len == 0) {
+        g_string_append(buf, "no NVMe controllers\n");
+    }
+
+    return human_readable_text_from_str(buf);
+}
diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..5f75341438 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1772,6 +1772,24 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
+##
+# @x-query-nvme:
+#
+# Query state of emulated NVMe controllers.
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: NVMe controller state as human-readable text
+#
+# Since: 11.1
+##
+{ 'command': 'x-query-nvme',
+  'returns': 'HumanReadableText',
+  'if': 'CONFIG_NVME_PCI',
+  'features': [ 'unstable' ] }
+
 ##
 # @SmbiosEntryPointType:
 #
-- 
2.53.0


