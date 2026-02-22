Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C978C636A0
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 14:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuASn-0000UC-WC; Sun, 22 Feb 2026 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASi-0008VQ-PD
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vuASg-0006wm-AB
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 09:29:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771770567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6zOzo7hNaZJwVvFx3QDu84NhS7TzXFaebjcVobYQalE=;
 b=PU3OHmNHBUZqst8Kruwzs6V9wV1nvKxpFcKIhgZFyQNAvcTSgoS5xVO47/mOryT+OkOorh
 Vt4JaZCBmETKCwd5dB7jiey6LLrs9Ucla0bTvbuE/QiiRvrEmdkbDYGCSpGjuc2kKhXQtI
 pJDv/M8QEZvwhMkFCO2GCUbGYeegrl8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-__gQXQ97PmKzYrPP3gxmLg-1; Sun, 22 Feb 2026 09:29:25 -0500
X-MC-Unique: __gQXQ97PmKzYrPP3gxmLg-1
X-Mimecast-MFC-AGG-ID: __gQXQ97PmKzYrPP3gxmLg_1771770565
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4830e7c6131so34984555e9.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771770564; x=1772375364; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6zOzo7hNaZJwVvFx3QDu84NhS7TzXFaebjcVobYQalE=;
 b=BOvFZCsOf0f8b+iy0EWmRBXhChgPqkt9JjoMilF2eauYU8ysz5aIolMlu1QBRIeMpN
 p7TouQoHB5SM9XNKkPOBBcvK/gDQ+wgwBjrzqp/Y8BBXx/ZibYCFi+0Lin8vTYiMrFQj
 BnoNMq3WrLvx9phyCNXQKiPxt5MzU9CjOPqb0t9ywQDkrQfF2nOVXQOkXWpickv5OLYH
 My/lq8Y1HiYLFU8dotZGvlaOYb2M8RHhf6aNNXFgb58s0IQ0HXBfnM3xZePwjWOJG8Kj
 SqhYDm9YpzmH771ncpjE51XqexSwNm5ZS4BwyIkTjYxinMl209TTaajinnfYozlI5dHX
 +5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771770564; x=1772375364;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6zOzo7hNaZJwVvFx3QDu84NhS7TzXFaebjcVobYQalE=;
 b=WTm2tMxGxBvEXvCWqRpp2U4oOYssl4TsCrxITfWLQXmWTOwDLiNmZWW6aGCZ9OQ+sg
 WXLr38FHoOB/nTQgVX1lXyuQtPU5tBIjxKVkIENmgbpGz+6ECcEMwxNMbBbM9MVTBWWS
 SJ2FNUhW6LYtCu89giClxIP+4fwve+nSoBilUmRRmFHio6lOiBZHxrfWAb3dRBpPgUdP
 N1rp488lT/amRdCtA7Emzq97cfhNADEcmcayZnSf7czamGFNKf4RVp+vE6G//UB6mpx/
 yNWtyWCGMuFWSQq8tv6j8PhtR+gbRUuvqaqjXdQLqSJ5G+DifPhGxUlyWzTD955K5NKx
 VYVw==
X-Gm-Message-State: AOJu0YzquSbK30e8oBr2YN54Eh2iWO8zg8A8Qjo2ZA9Ln3YK5zAbgW/b
 xEoiHBZRoQmWiIWv6ckr0Zq90FsxZvxvX951BUwq3MqIdbpA2+kUkEnblyMetoSQpBLs35ReT1P
 SjZ4Hmyrgv9bsA2tV54q2EuuNKCJBbyQAX1iyn+jn5LRK1clMZyE7nCHXmVMb4rZf2TGDc2/dh2
 ZwMgjsOnhAYWDPMBwKY/RuEc7qG3g7neA2PQ==
X-Gm-Gg: AZuq6aLJAySpdv94RLkw2ytY+0EbUHj1ExnnVgxjmDLol2wb8i5pB58gU3W98pXFAL2
 TxEoFjWtp0eI1t6CZRVh9P++iinlgCpkcjBRkR1Voh+ZFH0/lp+l1pgR54RGg+L0M+JUOMvWmQJ
 dWZ3WSERSYTTpDVv/sqBJB21kkyQwAE8AZJEWwqAH8K+vm7w65zXOC2/pu9ewOCJGrs46MqpIKn
 lR4Wsoj9Rmz+MpLXHq6+BCKg0q7vNcfiDLo8tc5wgwtw/UmKPQ723s5TIH1fnx+6xWC74ZeyDBP
 LmZPwQAfHo6aEtAXIy/8LKUc1uUoSNAl6m8nyfu18z7E0leRXMvBDpqtcY8ao565vyl1v5o+3GK
 NhRlK6GqffbTnIa6nrGnFavljw+hTYmhdI8q3YrF1Sk0sUw==
X-Received: by 2002:a05:600c:5020:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483a95fb698mr105551985e9.11.1771770564228; 
 Sun, 22 Feb 2026 06:29:24 -0800 (PST)
X-Received: by 2002:a05:600c:5020:b0:477:5cc6:7e44 with SMTP id
 5b1f17b1804b1-483a95fb698mr105551465e9.11.1771770563659; 
 Sun, 22 Feb 2026 06:29:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-79-166.inter.net.il. [80.230.79.166])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a430a33esm78968565e9.32.2026.02.22.06.29.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Feb 2026 06:29:22 -0800 (PST)
Date: Sun, 22 Feb 2026 09:29:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Arpit Kumar <arpit1.kumar@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PULL 27/33] hw/cxl: Add Physical Port Control FMAPI Command (Opcode
 5102h)
Message-ID: <6e1410fdcf7040b2c32a7845b423ab604384aded.1771770471.git.mst@redhat.com>
References: <cover.1771770471.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1771770471.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Arpit Kumar <arpit1.kumar@samsung.com>

Added assert-deassert PERST implementation for physical ports (both USP
and DSP's).

Assert PERST involves bg operation for holding 100ms.
Reset PPB implementation for physical ports.

Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260204173223.44122-4-Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c                  | 130 ++++++++++++++++++++
 hw/pci-bridge/cxl_downstream.c              |   9 ++
 hw/pci-bridge/cxl_upstream.c                |   1 +
 include/hw/cxl/cxl_port.h                   |  20 +++
 include/hw/pci-bridge/cxl_downstream_port.h |  12 ++
 include/hw/pci-bridge/cxl_upstream_port.h   |   2 +
 6 files changed, 174 insertions(+)
 create mode 100644 include/hw/pci-bridge/cxl_downstream_port.h

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b6ac987ee0..c83b5f90d4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -17,6 +17,7 @@
 #include "hw/cxl/cxl_mailbox.h"
 #include "hw/cxl/cxl_port.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/pci-bridge/cxl_upstream_port.h"
 #include "qemu/cutils.h"
 #include "qemu/host-utils.h"
@@ -119,6 +120,7 @@ enum {
     PHYSICAL_SWITCH = 0x51,
         #define IDENTIFY_SWITCH_DEVICE      0x0
         #define GET_PHYSICAL_PORT_STATE     0x1
+        #define PHYSICAL_PORT_CONTROL       0x2
     TUNNEL = 0x53,
         #define MANAGEMENT_COMMAND     0x0
     FMAPI_DCD_MGMT = 0x56,
@@ -616,6 +618,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         struct cxl_fmapi_port_state_info_block *port;
         /* First try to match on downstream port */
         PCIDevice *port_dev;
+        CXLPhyPortPerst *perst;
         uint16_t lnkcap, lnkcap2, lnksta;
 
         port = &out->ports[i];
@@ -663,6 +666,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
                 CXL_PORT_SUPPORTS_256B;
             port->supported_ld_count = 3;
+            perst = cxl_dsp_get_perst(CXL_DSP(port_dev));
         } else if (usp->port == in->ports[i]) { /* USP */
             port_dev = PCI_DEVICE(usp);
             port->config_state = CXL_PORT_CONFIG_STATE_USP;
@@ -670,6 +674,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
             port->connected_device_mode = 0; /* Reserved for USP */
             port->supported_cxl_mode_bitmask = CXL_PORT_SUPPORTS_68B_VH |
                 (CXL_USP(usp)->flitmode ? CXL_PORT_SUPPORTS_256B : 0);
+            perst = &CXL_USP(usp)->perst;
         } else {
             return CXL_MBOX_INVALID_INPUT;
         }
@@ -698,6 +703,7 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
         /* TODO: Track down if we can get the rest of the info */
         port->ltssm_state = 0x7;
         port->first_lane_num = 0;
+        port->link_state = perst ? CXL_PORT_LINK_STATE_FLAG_PERST_ASSERTED : 0;
     }
 
     pl_size = sizeof(*out) + sizeof(*out->ports) * in->num_ports;
@@ -706,6 +712,115 @@ static CXLRetCode cmd_get_physical_port_state(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void *bg_assertcb(void *opaque)
+{
+    CXLPhyPortPerst *perst = opaque;
+
+    /* holding reset phase for 100ms */
+    while (perst->asrt_time--) {
+        usleep(1000);
+    }
+    perst->issued_assert_perst = true;
+    return NULL;
+}
+
+static CXLRetCode cxl_deassert_perst(Object *obj, CXLPhyPortPerst *perst)
+{
+    if (!perst->issued_assert_perst) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&perst->lock);
+    resettable_release_reset(obj, RESET_TYPE_COLD);
+    perst->issued_assert_perst = false;
+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLRetCode cxl_assert_perst(Object *obj, CXLPhyPortPerst *perst)
+{
+    if (cxl_perst_asserted(perst)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    QEMU_LOCK_GUARD(&perst->lock);
+    resettable_assert_reset(obj, RESET_TYPE_COLD);
+    qemu_thread_create(&perst->asrt_thread, "assert_thread", bg_assertcb,
+                       perst, QEMU_THREAD_DETACHED);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+static CXLDownstreamPort *cxl_find_dsp_on_bus(PCIBus *bus, uint8_t pn)
+{
+
+    PCIDevice *port_dev = pcie_find_port_by_pn(bus, pn);
+
+    if (object_dynamic_cast(OBJECT(port_dev), TYPE_CXL_DSP)) {
+        return CXL_DSP(port_dev);
+    }
+
+    return NULL;
+}
+
+/* CXL r3.2 Section 7.6.7.1.3: Get Physical Port Control (Opcode 5102h) */
+static CXLRetCode cmd_physical_port_control(const struct cxl_cmd *cmd,
+                                            uint8_t *payload_in,
+                                            size_t len_in,
+                                            uint8_t *payload_out,
+                                            size_t *len_out,
+                                            CXLCCI *cci)
+{
+   CXLUpstreamPort *pp = CXL_USP(cci->d);
+   CXLPhyPortPerst *perst;
+   PCIDevice *dev;
+
+   struct cxl_fmapi_get_physical_port_control_req_pl {
+        uint8_t ppb_id;
+        uint8_t ports_op;
+    } QEMU_PACKED *in = (void *)payload_in;
+
+    if (len_in < sizeof(*in)) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    if (PCIE_PORT(pp)->port == in->ppb_id) {
+        dev = PCI_DEVICE(pp);
+        perst = &pp->perst;
+    } else {
+        CXLDownstreamPort *dsp =
+            cxl_find_dsp_on_bus(&PCI_BRIDGE(pp)->sec_bus, in->ppb_id);
+
+        if (!dsp) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        dev = PCI_DEVICE(dsp);
+        perst = cxl_dsp_get_perst(dsp);
+    }
+
+    switch (in->ports_op) {
+    case 0:
+        return cxl_assert_perst(OBJECT(&dev->qdev), perst);
+    case 1:
+        return cxl_deassert_perst(OBJECT(&dev->qdev), perst);
+    case 2: {
+        if (!perst) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        if (perst->issued_assert_perst ||
+            perst->asrt_time < ASSERT_WAIT_TIME_MS) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+        device_cold_reset(&dev->qdev);
+        return CXL_MBOX_SUCCESS;
+    }
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+}
+
 /* CXL r3.1 Section 8.2.9.1.2: Background Operation Status (Opcode 0002h) */
 static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in,
@@ -4412,6 +4527,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0 },
     [PHYSICAL_SWITCH][GET_PHYSICAL_PORT_STATE] = { "SWITCH_PHYSICAL_PORT_STATS",
         cmd_get_physical_port_state, ~0, 0 },
+    [PHYSICAL_SWITCH][PHYSICAL_PORT_CONTROL] = { "SWITCH_PHYSICAL_PORT_CONTROL",
+        cmd_physical_port_control, 2, 0 },
     [TUNNEL][MANAGEMENT_COMMAND] = { "TUNNEL_MANAGEMENT_COMMAND",
                                      cmd_tunnel_management_cmd, ~0, 0 },
 };
@@ -4618,6 +4735,19 @@ static void cxl_rebuild_cel(CXLCCI *cci)
     }
 }
 
+void cxl_init_physical_port_control(CXLPhyPortPerst *perst)
+{
+    qemu_mutex_init(&perst->lock);
+    perst->issued_assert_perst = false;
+    /*
+     * Assert PERST involves physical port to be in
+     * hold reset phase for minimum 100ms. No other
+     * physical port control requests are entertained
+     * until Deassert PERST command.
+     */
+    perst->asrt_time = ASSERT_WAIT_TIME_MS;
+}
+
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
     cci->payload_max = payload_max;
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 320818a8f1..ec450d1aa0 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -13,9 +13,11 @@
 #include "hw/pci/msi.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/pci-bridge/cxl_downstream_port.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-properties-system.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_port.h"
 #include "qapi/error.h"
 
 typedef struct CXLDownstreamPort {
@@ -24,6 +26,7 @@ typedef struct CXLDownstreamPort {
 
     /*< public >*/
     CXLComponentState cxl_cstate;
+    CXLPhyPortPerst perst;
 } CXLDownstreamPort;
 
 #define CXL_DOWNSTREAM_PORT_MSI_OFFSET 0x70
@@ -81,6 +84,11 @@ static void cxl_dsp_config_write(PCIDevice *d, uint32_t address,
     cxl_dsp_dvsec_write_config(d, address, val, len);
 }
 
+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp)
+{
+    return &dsp->perst;
+}
+
 static void cxl_dsp_reset(DeviceState *qdev)
 {
     PCIDevice *d = PCI_DEVICE(qdev);
@@ -92,6 +100,7 @@ static void cxl_dsp_reset(DeviceState *qdev)
     pci_bridge_reset(qdev);
 
     latch_registers(dsp);
+    cxl_init_physical_port_control(&dsp->perst);
 }
 
 static void build_dvsecs(PCIDevice *d, CXLComponentState *cxl)
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index fb8d19539c..b6281cbd4c 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -103,6 +103,7 @@ static void cxl_usp_reset(DeviceState *qdev)
     pcie_cap_deverr_reset(d);
     pcie_cap_fill_link_ep_usp(d, usp->width, usp->speed, usp->flitmode);
     latch_registers(usp);
+    cxl_init_physical_port_control(&usp->perst);
 }
 
 static void build_dvsecs(CXLUpstreamPort *usp)
diff --git a/include/hw/cxl/cxl_port.h b/include/hw/cxl/cxl_port.h
index 04db60f7bc..fb2e22a9f2 100644
--- a/include/hw/cxl/cxl_port.h
+++ b/include/hw/cxl/cxl_port.h
@@ -3,6 +3,8 @@
 #ifndef CXL_PORT_H
 #define CXL_PORT_H
 
+#include "qemu/thread.h"
+
 /* CXL r3.2 Table 7-19: Get Physical Port State Port Information Block Format */
 #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
 #define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1
@@ -50,4 +52,22 @@
 #define CXL_PORT_LINK_STATE_FLAG_PRSNT            BIT(2)
 #define CXL_PORT_LINK_STATE_FLAG_POWER_OFF        BIT(3)
 
+#define CXL_MAX_PHY_PORTS 256
+#define ASSERT_WAIT_TIME_MS 100 /* Assert - Deassert PERST */
+
+/* Assert - Deassert PERST */
+typedef struct CXLPhyPortPerst {
+    bool issued_assert_perst;
+    QemuMutex lock; /* protecting assert-deassert reset request */
+    uint64_t asrt_time;
+    QemuThread asrt_thread; /* thread for 100ms delay */
+} CXLPhyPortPerst;
+
+void cxl_init_physical_port_control(CXLPhyPortPerst *perst);
+
+static inline bool cxl_perst_asserted(CXLPhyPortPerst *perst)
+{
+    return perst->issued_assert_perst || perst->asrt_time < ASSERT_WAIT_TIME_MS;
+}
+
 #endif /* CXL_PORT_H */
diff --git a/include/hw/pci-bridge/cxl_downstream_port.h b/include/hw/pci-bridge/cxl_downstream_port.h
new file mode 100644
index 0000000000..1611504c87
--- /dev/null
+++ b/include/hw/pci-bridge/cxl_downstream_port.h
@@ -0,0 +1,12 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef CXL_DOWNSTREAM_PORT_H
+#define CXL_DOWNSTREAM_PORT_H
+#include "include/hw/cxl/cxl_port.h"
+
+typedef struct CXLDownstreamPort CXLDownstreamPort;
+CXLPhyPortPerst *cxl_dsp_get_perst(CXLDownstreamPort *dsp);
+
+#endif
diff --git a/include/hw/pci-bridge/cxl_upstream_port.h b/include/hw/pci-bridge/cxl_upstream_port.h
index e3d6a27acc..dfe01771c7 100644
--- a/include/hw/pci-bridge/cxl_upstream_port.h
+++ b/include/hw/pci-bridge/cxl_upstream_port.h
@@ -4,6 +4,7 @@
 #include "hw/pci/pcie.h"
 #include "hw/pci/pcie_port.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_port.h"
 
 typedef struct CXLUpstreamPort {
     /*< private >*/
@@ -12,6 +13,7 @@ typedef struct CXLUpstreamPort {
     /*< public >*/
     CXLComponentState cxl_cstate;
     CXLCCI swcci;
+    CXLPhyPortPerst perst;
 
     PCIExpLinkSpeed speed;
     PCIExpLinkWidth width;
-- 
MST


