Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A760A2614
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=fujitsu.com header.i=@fujitsu.com header.a=rsa-sha256 header.s=fj2 header.b=sKzCggFM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLJbO-0002MQ-93; Mon, 26 Oct 2026 08:14:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPK-0002nI-Je
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:25 -0400
Received: from esa3.hc1455-7.c3s2.iphmx.com ([207.54.90.49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fj2110jc@fujitsu.com>)
 id 1xLHPH-00081p-Vp
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1793008461; x=1824544461;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zik1LQCP4muzbLl4LIyGNKML35lWt8i7n3q+ukChy+c=;
 b=sKzCggFM8qn7Bf4QWevbFDeKQS9IilWBWRHBeDA8KbcziqdXmW+PZGjQ
 ri03T+7SEDWJKwJRP86E4a3bhfcaS4s5/0sf9bHBPkQgkrTxHBBqngIeX
 oPtVxmzloyyHHByrwgJZz9gNjjUm/PxVVBKirTvShHlT6yV0y+DDTE+wC
 3HTCc/mNMUGicP1TXa+o9DvSM2dijBqBZ21SPC9CWnBAXL/fKACKZGIRQ
 CEFav5BlzXDIdIiIF18v9N+2zM/JuuFcT4DBqnthLrn8C5pB2UCf8+iue
 tyFQfWsOD+9guEiAfagBD/yisAmK/op1oRQKRzi5qF6UqQ26jJclexFCG w==;
X-CSE-ConnectionGUID: 1BSE75S9TaqsUPDLIemF1Q==
X-CSE-MsgGUID: 5ByKEOAxQgKsghCHXl9zdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="259392330"
X-IronPort-AV: E=Sophos;i="6.27,179,1786978800"; d="scan'208";a="259392330"
Received: from gmgwuk01.global.fujitsu.com ([172.187.114.235])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2026 18:54:20 +0900
Received: from az2uksmgm2.o.css.fujitsu.com (unknown [10.151.22.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by gmgwuk01.global.fujitsu.com (Postfix) with ESMTPS id 55488820732
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:18 +0000 (UTC)
Received: from m3003.s.css.fujitsu.com (unknown [10.128.233.114])
 by az2uksmgm2.o.css.fujitsu.com (Postfix) with ESMTP id BBB6B180025B
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 09:54:17 +0000 (UTC)
Received: from tanjiro.soft.fujitsu.com (unknown [10.118.236.61])
 by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 78101202EBDE;
 Mon, 26 Oct 2026 18:54:16 +0900 (JST)
To: qemu-devel@nongnu.org
Cc: Yukiya Takaki <fj2110jc@fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anisa Su <anisa.su@samsung.com>,
 Jonathan Cameron <jic23@kernel.org>, Junjie Cao <junjie.cao@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-cxl@vger.kernel.org, "Wolski, Tomasz" <tomasz.wolski@fujitsu.com>,
 lizhijian@fujitsu.com, y-goto@fujitsu.com, yukiya.takaki@gmail.com
Subject: [PATCH RFC 6/7] QEMU/hw/cxl: Create NUMA nodes for CXL Type 3 memory
Date: Mon, 26 Oct 2026 19:03:27 +0900
Message-ID: <a6789d2cbcbc7a4543ee7781173e189171199b91.1793003983.git.fj2110jc@fujitsu.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793003983.git.fj2110jc@fujitsu.com>
References: <cover.1793003983.git.fj2110jc@fujitsu.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.54.90.49; envelope-from=fj2110jc@fujitsu.com;
 helo=esa3.hc1455-7.c3s2.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:14:57 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Yukiya Takaki <fj2110jc@fujitsu.com>
From:  Yukiya Takaki via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On the actual hardware, CXL memory is exposed to the OS as a "Memory Only Node."
This allows the OS to recognize that accessing CXL memory takes time.
As a preliminary step, a function was created to automatically add a NUMA node for each instance of CXL memory.
This function generates one NUMA node per instance of CXL memory.
This function is executed when program_hdm_decoder is set.

Signed-off-by: Yukiya Takaki <fj2110jc@fujitsu.com>
---
 hw/cxl/cxl-host.c           | 38 +++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c                |  1 +
 include/hw/cxl/cxl_device.h |  1 +
 include/hw/cxl/cxl_host.h   |  1 +
 4 files changed, 41 insertions(+)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 1967c9a9c3..ba321841dc 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -720,6 +720,44 @@ void cxl_c3_update_mmio(void)
     object_child_foreach_recursive(object_get_root(), cxl_c3_mmio_map, NULL);
 }
 
+static int setup_cxl_numa_node_inner(Object *obj, void *opaque)
+{
+    MachineState *machine = opaque;
+    DeviceState *dev;
+    CXLType3Dev *c3d;
+    int node_id;
+
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        return 0;
+    }
+
+    dev = DEVICE(obj);
+    c3d = CXL_TYPE3(dev);
+    node_id = machine->numa_state->num_nodes;
+
+    if (!c3d->program_hdm_decoder) {
+        return 0;
+    }
+
+    NumaOptions option = {
+        .type = NUMA_OPTIONS_TYPE_NODE,
+        .u.node = {
+            .has_nodeid = true,
+            .nodeid = node_id,
+        },
+    };
+
+    set_numa_options(machine, &option, &error_fatal);
+    c3d->node = node_id;
+    return 0;
+}
+
+void setup_cxl_numa_node(MachineState *machine)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   setup_cxl_numa_node_inner, machine);
+}
+
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr)
 {
     GSList *cfmws_list, *iter;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f843629543..b1d1f03468 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -534,6 +534,7 @@ void pc_machine_done(Notifier *notifier, void *data)
 
     if (pcms->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
+        setup_cxl_numa_node(MACHINE(pcms));
         cxl_c3_update_mmio();
     }
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 07654f4b62..9001aacf0e 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -780,6 +780,7 @@ struct CXLType3Dev {
     bool program_hdm_decoder;
     hwaddr hpa_offset;
     int idx;
+    int node;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 6c142a5b89..70285328c4 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -19,6 +19,7 @@ void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
 hwaddr cxl_fmws_set_memmap(hwaddr base, hwaddr max_addr);
 void cxl_fmws_update_mmio(void);
 void cxl_c3_update_mmio(void);
+void setup_cxl_numa_node(MachineState *machine);
 void cxl_c3_add_memory_map(hwaddr base, hwaddr size);
 GSList *cxl_fmws_get_all_sorted(void);
 
-- 
2.52.0


