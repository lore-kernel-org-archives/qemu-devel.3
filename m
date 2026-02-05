Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6CEECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vn-00079z-OY; Thu, 05 Feb 2026 14:59:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vk-00075F-Ce
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:32 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vi-0003DM-4Q
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:32 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4362ab556f5so16840f8f.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321568; x=1770926368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X7UzQPgmBiRY/upCcfubCk3rZyvcBcdMj1LuFEKqEEs=;
 b=aACq35yd7CVghLv0MoCHCn9c41VCypCzExQQso5a2Yr1nSTVD2uyEUfTLitJ1XnK0Y
 U8KYKMzHjiyMADw03E/CUYnIPoTYqDnKLSm1w4iTQiNw3z/cfkYu1QkHGVzGddnwa5XR
 EDHlT51bLI8cHpEGz6XVbcIA5OXAq4aNg+a8e7LImX4ZGg7bmnxnLGZVen/OxmH8zDt8
 8770MeySgFWJols8SgLwgv0TD+Ybcx1S0bY5ba9PBcmoImRtTRtD6oABBPUp/13f1ess
 OegmIalT6g78KhG9yE2hN5x9jg8TZcBUvm9uFmg4GUNxvg6eBf6K0yAfSq481x3mBynI
 vDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321568; x=1770926368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X7UzQPgmBiRY/upCcfubCk3rZyvcBcdMj1LuFEKqEEs=;
 b=G2Ge2b55yGnfutjEmsjf0iUBz1SQSC5/ZbOoQ2RSVF441TSkEQO14FXE5evKSwvdPr
 7FmHaNB9EDQojvOdTMH+ePpKBT5UTC4PTiqVrzrUYSWDgrlEZPdgLGXneKvDyobeluI1
 AB4AYNghH3E9zFBrDPGHlHzV//pSLZ4y1rSbMf2tzcLD1nPUQtY942EkbQZN1nR/uXAi
 6Fo0ASFLjVhT7XyMzrzwvVm1ST2+ee92dw8TP7GBIBosDaDjlie3YCBi3znBXriZ69we
 9gmQDNETUCRSLqXOMPVKSzW8VSSEsvoahniOMJcEA5r5qMdFwZ3w+V1dBcoNH6Jb2eEE
 nf3Q==
X-Gm-Message-State: AOJu0Yy/3m/gjmE6SfeB+qVvI36GmhrW9uupoMARY0IXrHtpSifHhbns
 KoNaMbXK/YtUh1R+YbV7V7szoVwZpR2t3nnmQD2K5staEGnBo9f+QPsi8mV5qkEPc4I=
X-Gm-Gg: AZuq6aK1JXPIsM6AxVAgi9eqU8MmR0MS+cmBWkOBvOR5M+KIQewzxTuMiVPxjAi23zX
 TfJe6cJUIYvKNtBP7cOLt8Kkv8sqwuhxkiqEIm5M6lH/z2vwYp+dlLA/h/o7dX71v5BdHNEnY7P
 kAYXZO+idqy3df/U8TiO5wm1VxlI4egOf1M+d77ifCx1DkXgXg0jEdUmLZ0LgwuEwJEaXAfdGuF
 P2I8ioWLssRE74gmdVjk8pUvP6Mp8VgUSmY+F66c2EO9JQRe7wIhfmnVyPnWRksp8ivd+cZevjR
 28WwyqH7l9JScTams0TsXSSW1OdGX82nbUQX1xNirNmpwIimgqWXhu+9PAGjLlO7Gpu+rqXHxVf
 yhGsZOv2QIWLbQu+QfohkoRBsF6qSMPLCJNpY+xelTYneHw82hqALKzc5wbf8nfOZ6fNnfNyerR
 aGGkro/anb468Y4aEboTo=
X-Received: by 2002:a5d:5f54:0:b0:435:9ce0:f93c with SMTP id
 ffacd0b85a97d-4362969509amr574711f8f.62.1770321567939; 
 Thu, 05 Feb 2026 11:59:27 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:27 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Subject: [PATCH 29/29] hw/core: Add ATS support to Remote Port memory slave
Date: Thu,  5 Feb 2026 20:58:24 +0100
Message-ID: <20260205195824.2610192-30-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

Integrate Address Translation Services (ATS) into the Remote Port Memory Slave
to support IOMMU translation for remote transactions.

This patch implements:
- Support for creation of RP ATS as RP Memory Slave subdevice
- Dynamic configuration of the ATS device, linking it to the
  same IOMMU context (iommu-id, stream-id) as the parent memory slave.
- Update for FDT generic utility to parse 'remote-port-ats'
  properties and propagate the configuration to the device.

This allows external masters to request address translations via the Remote
Port protocol, which are then serviced by the QEMU IOMMU infrastructure.

Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c                 | 10 +++
 hw/core/remote-port-ats.c                  | 97 +++++++++++++++++++++-
 hw/core/remote-port-memory-slave.c         | 36 +++++++-
 include/hw/core/remote-port-ats.h          |  3 +
 include/hw/core/remote-port-memory-slave.h |  4 +-
 5 files changed, 145 insertions(+), 5 deletions(-)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index 180038baf6..817e7209e1 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -1221,6 +1221,16 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
                 fprintf(stderr, "cant set device link for adaptor\n");
                 break;
             }
+
+            if (object_dynamic_cast(dev, TYPE_REMOTE_PORT_MEMORY_SLAVE)) {
+                uint32_t rp_ats_id;
+                rp_ats_id = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                  "remote-port-ats", 0,
+                                                  false, &errp);
+
+                object_property_set_int(OBJECT(dev), "rp-ats-id",
+                                        rp_ats_id, &errp);
+            }
         }
         errp = NULL;
     }
diff --git a/hw/core/remote-port-ats.c b/hw/core/remote-port-ats.c
index 1f6c8d7410..27cf8c6c7b 100644
--- a/hw/core/remote-port-ats.c
+++ b/hw/core/remote-port-ats.c
@@ -33,10 +33,29 @@
 #include "migration/vmstate.h"
 #include "hw/core/qdev-properties.h"
 #include "trace.h"
+#include "qemu/cutils.h"
 
 #include "hw/core/remote-port-proto.h"
 #include "hw/core/remote-port-ats.h"
 
+#define RP_TRACE_LVL_NONE   (0u)
+#define RR_TRACE_LVL_ERROR  (1u)
+#define RP_TRACE_LVL_WARN   (2u)
+#define RP_TRACE_LVL_INFO   (3u)
+
+#define RP_TRACE_LEVEL (RP_TRACE_LVL_INFO)
+
+#ifndef RP_TRACE_LEVEL
+#define RP_TRACE_LEVEL (RP_TRACE_LVL_NONE)
+#endif
+
+#define RP_TRACE(level, ...) do { \
+    if (RP_TRACE_LEVEL >= level) { \
+        fprintf(stderr,  "[TRACE] %s(): ", __func__); \
+        fprintf(stderr, ## __VA_ARGS__); \
+    } \
+} while (0)
+
 typedef struct ATSIOMMUNotifier {
     IOMMUNotifier n;
     MemoryRegion *mr;
@@ -190,6 +209,17 @@ static void rp_ats_cache_insert(RemotePortATS *s,
     iotlb->addr_mask = mask;
     iotlb->target_as = target_as;
     g_array_append_val(s->cache, iotlb);
+
+    char *target_as_name = strdup(iotlb->target_as->name);
+    RP_TRACE(RP_TRACE_LVL_INFO, "IOMMUTLBEntry entry added to cache\r\n");
+    RP_TRACE(RP_TRACE_LVL_INFO, "iova: 0x%" PRIx64 " translated_addr: 0x%" \
+       PRIx64 " addr_mask: 0x%" PRIx64 " target_as: %s perm: 0x%" PRIx32 "\r\n",
+        iotlb->iova,
+        iotlb->translated_addr,
+        iotlb->addr_mask,
+        target_as_name,
+        iotlb->perm);
+    free(target_as_name);
 }
 
 static void rp_ats_iommu_unmap_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
@@ -215,11 +245,20 @@ static bool ats_translate_address(RemotePortATS *s, struct rp_pkt *pkt,
     mr = ats_do_translate(&s->as, pkt->ats.addr, phys_addr, phys_len,
                           &target_as, &prot, attrs);
     if (!mr) {
+        RP_TRACE(RP_TRACE_LVL_INFO, "Remote Port ATS translation failed\r\n");
         return false;
     }
 
+    RP_TRACE(RP_TRACE_LVL_INFO,
+        "Remote Port ATS translation succeeded - aka. ats_do_translate()\r\n");
+    RP_TRACE(RP_TRACE_LVL_INFO,
+        "phys_addr: 0x%" PRIx64 " phys_len: 0x%" PRIx64 "\r\n",
+        *phys_addr, *phys_len);
+
     iommu_mr = memory_region_get_iommu(mr);
     if (iommu_mr) {
+        RP_TRACE(RP_TRACE_LVL_INFO,
+        "Memory region obtained from ats_do_translate() is associated with IOMMU\r\n");
         int iommu_idx = memory_region_iommu_attrs_to_index(iommu_mr, attrs);
         ATSIOMMUNotifier *notifier;
         int i;
@@ -284,11 +323,23 @@ static void rp_ats_req(RemotePortDevice *dev, struct rp_pkt *pkt)
 
     assert(!(pkt->hdr.flags & RP_PKT_FLAGS_response));
 
+    RP_TRACE(RP_TRACE_LVL_INFO, "Remote Port ATS request is received\r\n")
+    RP_TRACE(RP_TRACE_LVL_INFO, "cmd 0x%" PRIx32 " len: 0x%" PRIx32 " id: 0x%" \
+        PRIx32 " flags: 0x%" PRIx32 " dev: 0x%" PRIx32 "\r\n",
+        pkt->hdr.cmd, pkt->hdr.len, pkt->hdr.id, pkt->hdr.flags, pkt->hdr.dev);
+    RP_TRACE(RP_TRACE_LVL_INFO, "timestamp 0x%" PRIx64 " attributes: 0x%" PRIx64
+        " addr: 0x%" PRIx64 " len: 0x%" PRIx64 " result: 0x%" PRIx32 "\r\n",
+        pkt->ats.timestamp, pkt->ats.attributes, pkt->ats.addr, pkt->ats.len,
+        pkt->ats.result);
+
     rp_dpkt_alloc(&s->rsp, pktlen);
 
     result = ats_translate_address(s, pkt, &phys_addr, &phys_len) ?
         RP_ATS_RESULT_ok : RP_ATS_RESULT_error;
 
+    RP_TRACE(RP_TRACE_LVL_INFO, "Remote Port ATS translation is %s\r\n",
+            ((result == RP_ATS_RESULT_ok) ? "successful" : "unsuccessful"));
+
     /*
      * delay here could be set to the annotated cost of doing issuing
      * these accesses. QEMU doesn't support this kind of annotations
@@ -307,18 +358,60 @@ static void rp_ats_req(RemotePortDevice *dev, struct rp_pkt *pkt)
                              pkt->hdr.flags | RP_PKT_FLAGS_response);
     assert(enclen == pktlen);
 
+    RP_TRACE(RP_TRACE_LVL_INFO, "Remote Port ATS response is generated\r\n")
+    RP_TRACE(RP_TRACE_LVL_INFO, "cmd 0x%" PRIx32 " len: 0x%" PRIx32 " id: 0x%" \
+        PRIx32 " flags: 0x%" PRIx32 " dev: 0x%" PRIx32 "\r\n",
+        be32toh(s->rsp.pkt->hdr.cmd),
+        be32toh(s->rsp.pkt->hdr.len),
+        be32toh(s->rsp.pkt->hdr.id),
+        be32toh(s->rsp.pkt->hdr.flags),
+        be32toh(s->rsp.pkt->hdr.dev));
+    RP_TRACE(RP_TRACE_LVL_INFO, "timestamp 0x%" PRIx64 " attributes: 0x%" \
+    PRIx64 " addr: 0x%" PRIx64 " len: 0x%" PRIx64 " result: 0x%" PRIx32 "\r\n",
+        be64toh(s->rsp.pkt->ats.timestamp),
+        be64toh(s->rsp.pkt->ats.attributes),
+        be64toh(s->rsp.pkt->ats.addr),
+        be64toh(s->rsp.pkt->ats.len),
+        be32toh(s->rsp.pkt->ats.result));
+
     rp_write(s->rp, (void *)s->rsp.pkt, enclen);
 }
 
+static AddressSpace *bus_iommu_address_space(BusState *iommu_bus,
+                                             uint32_t iommu_id, uint16_t devid)
+{
+    if (iommu_bus && iommu_bus->iommu[iommu_id].iommu_ops) {
+        return iommu_bus->iommu[iommu_id].iommu_ops->get_address_space(
+            iommu_bus, iommu_bus->iommu[iommu_id].iommu_opaque, devid);
+    }
+    return &address_space_memory;
+}
+
+static void rp_ats_init_done(Notifier *notifier, void *data)
+{
+    RemotePortATS *s = container_of(notifier, RemotePortATS, machine_done);
+    AddressSpace *as;
+
+    if (s->rp_stream_id) {
+        as = bus_iommu_address_space(sysbus_get_default(),
+                                     s->iommu_id, s->rp_stream_id);
+        address_space_init(&s->as, as->root, "dma");
+    } else {
+        address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "dma");
+    }
+}
+
 static void rp_ats_realize(DeviceState *dev, Error **errp)
 {
     RemotePortATS *s = REMOTE_PORT_ATS(dev);
 
     s->peer = rp_get_peer(s->rp);
-    address_space_init(&s->as, s->mr ? s->mr : get_system_memory(), "ats-as");
 
     s->iommu_notifiers = g_array_new(false, true, sizeof(ATSIOMMUNotifier *));
     s->cache = g_array_new(false, true, sizeof(IOMMUTLBEntry *));
+
+    s->machine_done.notify = rp_ats_init_done;
+    qemu_add_machine_init_done_notifier(&s->machine_done);
 }
 
 static void rp_prop_allow_set_link(const Object *obj, const char *name,
@@ -363,7 +456,9 @@ static void rp_ats_unrealize(DeviceState *dev)
 }
 
 static Property rp_properties[] = {
+    DEFINE_PROP_UINT32("iommu-id", RemotePortATS, iommu_id, 0),
     DEFINE_PROP_UINT32("rp-chan0", RemotePortATS, rp_dev, 0),
+    DEFINE_PROP_UINT32("rp-stream-id", RemotePortATS, rp_stream_id, 0),
 };
 
 static void rp_ats_class_init(ObjectClass *oc, const void *data)
diff --git a/hw/core/remote-port-memory-slave.c b/hw/core/remote-port-memory-slave.c
index 0419e75bfa..2694f3edae 100644
--- a/hw/core/remote-port-memory-slave.c
+++ b/hw/core/remote-port-memory-slave.c
@@ -192,13 +192,38 @@ static AddressSpace *bus_iommu_address_space(BusState *iommu_bus,
     return &address_space_memory;
 }
 
+static void rp_memory_slave_create_ats(RemotePortMemorySlave *s)
+{
+    Object *tmp_obj;
+
+    /* Create RP ATS dev. */
+    tmp_obj = object_new(TYPE_REMOTE_PORT_ATS);
+    s->rp_ats = REMOTE_PORT_ATS(tmp_obj);
+    object_property_add_child(OBJECT(s), "rp-ats", tmp_obj);
+    object_unref(tmp_obj);
+
+     /* Setup the RP ATS dev. */
+    rp_device_attach(OBJECT(s->rp), OBJECT(s->rp_ats), 0,
+                     s->rp_ats_id, &error_abort);
+    object_property_set_int(OBJECT(s->rp_ats), "iommu-id",
+                            s->iommu_id, &error_abort);
+    object_property_set_int(OBJECT(s->rp_ats), "rp-stream-id",
+                            s->rp_stream_id, &error_abort);
+    object_property_set_bool(OBJECT(s->rp_ats), "realized",
+                             true, &error_abort);
+
+    /* Setup the RP Slave dev. */
+    object_property_set_link(OBJECT(s), "rp-ats-cache",
+                             OBJECT(s->rp_ats), &error_abort);
+}
+
 static void rp_memory_slave_init_done(Notifier *notifier, void *data)
 {
     RemotePortMemorySlave *s = container_of(notifier, RemotePortMemorySlave,
                                             machine_done);
     AddressSpace *as;
 
-    if (s->channel_id) {
+    if (s->rp_stream_id) {
         as = bus_iommu_address_space(sysbus_get_default(), s->iommu_id,
                                      s->rp_stream_id);
         address_space_init(&s->as, as->root, "dma");
@@ -212,6 +237,11 @@ static void rp_memory_slave_realize(DeviceState *dev, Error **errp)
     RemotePortMemorySlave *s = REMOTE_PORT_MEMORY_SLAVE(dev);
 
     s->peer = rp_get_peer(s->rp);
+
+    if (s->rp_ats_id > 0) {
+        rp_memory_slave_create_ats(s);
+    }
+
     s->machine_done.notify = rp_memory_slave_init_done;
     qemu_add_machine_init_done_notifier(&s->machine_done);
 }
@@ -260,8 +290,8 @@ static void rp_memory_slave_unrealize(DeviceState *dev)
 
 static Property rp_properties[] = {
     DEFINE_PROP_UINT32("iommu-id", RemotePortMemorySlave, iommu_id, 0),
-    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemorySlave, channel_id, 0),
-    DEFINE_PROP_END_OF_LIST()
+    DEFINE_PROP_UINT32("rp-chan0", RemotePortMemorySlave, rp_stream_id, 0),
+    DEFINE_PROP_UINT32("rp-ats-id", RemotePortMemorySlave, rp_ats_id, 0),
 };
 
 static void rp_memory_slave_class_init(ObjectClass *oc, const void *data)
diff --git a/include/hw/core/remote-port-ats.h b/include/hw/core/remote-port-ats.h
index 8bdae1bce9..9e1a2cf419 100644
--- a/include/hw/core/remote-port-ats.h
+++ b/include/hw/core/remote-port-ats.h
@@ -45,6 +45,9 @@ typedef struct {
     GArray *iommu_notifiers;
     uint32_t rp_dev;
     GArray *cache; /* Translation cache */
+    Notifier machine_done;
+    uint32_t rp_stream_id;
+    uint32_t iommu_id;
 } RemotePortATS;
 
 #define TYPE_REMOTE_PORT_ATS_CACHE "remote-port-ats-cache"
diff --git a/include/hw/core/remote-port-memory-slave.h b/include/hw/core/remote-port-memory-slave.h
index 3161073a3f..56959ee124 100644
--- a/include/hw/core/remote-port-memory-slave.h
+++ b/include/hw/core/remote-port-memory-slave.h
@@ -23,7 +23,6 @@ typedef struct RemotePortMemorySlave {
     /* private */
     SysBusDevice parent;
     /* public */
-    uint32_t channel_id;
     struct RemotePort *rp;
     struct rp_peer_state *peer;
     MemoryRegion *mr;
@@ -32,6 +31,9 @@ typedef struct RemotePortMemorySlave {
     RemotePortDynPkt rsp;
     RemotePortATSCache *ats_cache;
     Notifier machine_done;
+    uint32_t rp_stream_id;
+    RemotePortATS *rp_ats;
+    uint32_t rp_ats_id;
     uint32_t iommu_id;
 } RemotePortMemorySlave;
 #endif
-- 
2.43.0


