Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE96CD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:11:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDO-0008Tr-QC; Sun, 14 Jun 2026 15:09:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCp-0007LK-Ho
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqCn-0002TR-Kh
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:09:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a46sKVH32bCRMvIBLUmf7FNMvT7dbG+TFR4oxcl+h58=;
 b=EwKh7aKKn8Zs0h3PANIhEqmFTMnOgm8XWk1kVECBAgVXeqM8xvzZuAP6uVh8IT71HRyBIV
 eKyV8cZpp0XwbJyzkrGzW4R7KVpwJETZL+sSzrD1n1utiD7nxU9OlVtXw2VSt7Y0Rw7H6Y
 6sAAw6yGbn5kKFU7FlI/+OR476pwokQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-v3dYr8BqOCy_v_Ujp0NRJw-1; Sun, 14 Jun 2026 15:09:11 -0400
X-MC-Unique: v3dYr8BqOCy_v_Ujp0NRJw-1
X-Mimecast-MFC-AGG-ID: v3dYr8BqOCy_v_Ujp0NRJw_1781464150
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-4601102c30dso1475037f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464150; x=1782068950; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=a46sKVH32bCRMvIBLUmf7FNMvT7dbG+TFR4oxcl+h58=;
 b=CQkiu1kMwSICm40fe97iMkPL1Yh8uG75ihKZsp+7LaNtYY5ltkwL8W9FoF5kxGZ5ec
 lBJzZgOIuSoLaU+QXpo7oXy7hsOXXG+oeB5KQ9gADQc3drN9C3w48cv1HFMNvcTKqCKx
 GYF01ZaUlsR35byjfJYTowSGqU4NXIz0EldcZNoQW1UaZEPeRLOGJ1c0flap2w90Z+Ux
 pxxEKoSXcioX6M20W6ziBq6bOjU139hd3c+wRNKX8lLydRTx0iLJ7ICvoDbDVIKI9Olh
 WipRnNyuowS+Q0DRbUTahd4kDeRtk7Fo66ZfCc/KOgHNgM2B8AKsI9YqIYLfRbcbjkvF
 xWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464150; x=1782068950;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a46sKVH32bCRMvIBLUmf7FNMvT7dbG+TFR4oxcl+h58=;
 b=NwPrVRq4JvTIpeKT8ibhhoEnozLhaqVEkXwhrz8X/dqAm+2D8vCRfIwXt6FO6iJHbg
 kD5rRgGyVOKfbFDbaBqhefsOq8ct0PuDqg7kzZ1DRds1IDwxNRjJacKGYerA2xhhufR2
 KA3w9sVYURqVpc6m95eAC7IZaX9IP83XjWmVzjVkS/zoZm7wdEDXS809gOYAi6PZasmG
 J/hUk5TD8TDQePDPOGEOu7OlNKPwQ/ZCa16JLTi3+Rr9fuATURaoSyyQjAfPJR4DOKSJ
 QI2ToIFkDzUBQgzhKu5biCD8HxzKgv62PjOYII+30timRhF0jcgFGrb11MqYi8DgDXyj
 tspw==
X-Gm-Message-State: AOJu0YwY3QgASh5kn1UMnwPx5e+UlJ7pOxvt2b/slz3VmdMC7bUVWJDV
 v/SLXvuCfk2cy6dKt45jJUHRSmMtTDBxVSmAzScYsg49dtK47F53gR+Ht7iN77yol8m+ht8/qlc
 HzkBXGzU9eY5tfMLpzDHJvL8CjoJiPijkLI1Lay9QA9PXM6tjOnDhK3PkTxafNO3k2hQEr8ZDZj
 9JXE/gKRTwfNu8KYzSHH4tCkiGDOB99lcMgA==
X-Gm-Gg: Acq92OET5i7fEOlYlO4PXXCDXWPXJvR9EvHCjSFRFbs591As+E8duK+4n4PDz0BpWMu
 FiKsCgeGd2Y1gsaoRSrcUjzjHKQB5BIXG06+vcq+TF/fA7acbotKYOUexOqEUbtiQM6uLKKglJG
 XtLG7+/O/rBlnFEXnxFh70e3k9MdVDRdNhpUjRohPGhkgaEi/JDT2smhUnKOr+PqRleX4Qjs81r
 admr/RCjOI9f8zicVenEtWxKsLSW7kIl0kki6Gu/mc+wCMmsZVUJLwYpXcWe7pYbfkL8JU1sV7Q
 hI303QVbJ3+bCs4DCNxq6HFkNhraYQ22HPiqEAJT3VNPz4e/X5So507zgGDQzO21I1V+Uqk1tJs
 xbI/XQBoGkyqMJ2io5js52p6VE7W3NtCZFKDgtl9IxC8=
X-Received: by 2002:a05:6000:188e:b0:45e:f271:5019 with SMTP id
 ffacd0b85a97d-4606db8c6fbmr15479974f8f.14.1781464150041; 
 Sun, 14 Jun 2026 12:09:10 -0700 (PDT)
X-Received: by 2002:a05:6000:188e:b0:45e:f271:5019 with SMTP id
 ffacd0b85a97d-4606db8c6fbmr15479934f8f.14.1781464149535; 
 Sun, 14 Jun 2026 12:09:09 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2cf5d9sm23855994f8f.32.2026.06.14.12.09.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:09:09 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:09:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 081/106] amd_iommu: Generate XT interrupts when xt support is
 enabled
Message-ID: <cf0210df65aa4f582e444b910c950e2b4a80b194.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sairaj Kodilkar <sarunkod@amd.com>

When MMIO 0x18[IntCapXTEn]=1, interrupts originating from the IOMMU itself are
sent based on the programming in XT IOMMU Interrupt Control Registers in MMIO
0x170-0x180 instead of the programming in the IOMMU's MSI capability registers.
The guest programs these registers with appropriate vector and destination
ID instead of writing to PCI MSI capability.

Current AMD vIOMMU is capable of generating interrupts only through PCI
MSI capability and does not care about xt mode. Because of this AMD
vIOMMU cannot generate event log interrupts when the guest has enabled
xt mode.

Introduce a new flag "intcapxten" which is set when guest writes control
register [IntCapXTEn] (bit 51) and use vector and destination field in
the XT MMIO register (0x170) to support XT mode.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260302115130.5903-4-sarunkod@amd.com>
---
 hw/i386/amd_iommu.c  | 47 ++++++++++++++++++++++++++++++++++++++------
 hw/i386/amd_iommu.h  | 17 ++++++++++++++++
 hw/i386/trace-events |  1 +
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5947d3aecf..79216fb305 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -192,18 +192,38 @@ static void amdvi_assign_andq(AMDVIState *s, hwaddr addr, uint64_t val)
    amdvi_writeq_raw(s, addr, amdvi_readq(s, addr) & val);
 }
 
+static void amdvi_build_xt_msi_msg(AMDVIState *s, MSIMessage *msg)
+{
+    union mmio_xt_intr xt_reg;
+    struct X86IOMMUIrq irq;
+
+    xt_reg.val = amdvi_readq(s, AMDVI_MMIO_XT_GEN_INTR);
+
+    irq.vector = xt_reg.vector;
+    irq.delivery_mode = xt_reg.delivery_mode;
+    irq.dest_mode = xt_reg.destination_mode;
+    irq.dest = (xt_reg.destination_hi << 24) | xt_reg.destination_lo;
+    irq.trigger_mode = 0;
+    irq.redir_hint = 0;
+
+    x86_iommu_irq_to_msi_message(&irq, msg);
+}
+
 static void amdvi_generate_msi_interrupt(AMDVIState *s)
 {
     MSIMessage msg = {};
-    MemTxAttrs attrs = {
-        .requester_id = pci_requester_id(&s->pci->dev)
-    };
 
-    if (msi_enabled(&s->pci->dev)) {
+    if (s->intcapxten) {
+        trace_amdvi_generate_msi_interrupt("XT GEN");
+        amdvi_build_xt_msi_msg(s, &msg);
+    } else if (msi_enabled(&s->pci->dev)) {
+        trace_amdvi_generate_msi_interrupt("MSI");
         msg = msi_get_message(&s->pci->dev, 0);
-        address_space_stl_le(&address_space_memory, msg.address, msg.data,
-                             attrs, NULL);
+    } else {
+        trace_amdvi_generate_msi_interrupt("NO MSI");
+        return;
     }
+    apic_get_class(NULL)->send_msi(&msg);
 }
 
 static uint32_t get_next_eventlog_entry(AMDVIState *s)
@@ -1538,6 +1558,7 @@ const char *amdvi_mmio_get_name(hwaddr addr)
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_BASE);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_HEAD);
     MMIO_REG_TO_STRING(AMDVI_MMIO_PPR_TAIL);
+    MMIO_REG_TO_STRING(AMDVI_MMIO_XT_GEN_INTR);
 #undef MMIO_REG_TO_STRING
     default:
         return "UNHANDLED";
@@ -1581,6 +1602,15 @@ static void amdvi_handle_control_write(AMDVIState *s)
     s->ga_enabled = !!(control & AMDVI_MMIO_CONTROL_GAEN);
     s->xten = !!(control & AMDVI_MMIO_CONTROL_XTEN) && s->xtsup &&
               s->ga_enabled;
+    /*
+     * IntCapXTEn controls whether IOMMU-originated interrupts are sent based
+     * on the information in XT IOMMU Interrupt Control Registers rather than
+     * the IOMMU’s MSI capability registers. Therefore it requires IOMMU
+     * x2APIC support capabilities (i.e. XTSup=1), but it is independent of
+     * whether a driver chooses to enable x2APIC mode for interrupt remapping
+     * (i.e. XTEn=1).
+     */
+    s->intcapxten = !!(control & AMDVI_MMIO_CONTROL_INTCAPXTEN) && s->xtsup;
 
     /* update the flags depending on the control register */
     if (s->cmdbuf_enabled) {
@@ -1790,6 +1820,9 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
     case AMDVI_MMIO_STATUS:
         amdvi_mmio_reg_write(s, size, val, addr);
         break;
+    case AMDVI_MMIO_XT_GEN_INTR:
+        amdvi_mmio_reg_write(s, size, val, addr);
+        break;
     }
 }
 
@@ -2440,6 +2473,7 @@ static void amdvi_init(AMDVIState *s)
     s->enabled = false;
     s->cmdbuf_enabled = false;
     s->xten = false;
+    s->intcapxten = false;
 
     /* reset MMIO */
     memset(s->mmior, 0, AMDVI_MMIO_SIZE);
@@ -2510,6 +2544,7 @@ static const VMStateDescription vmstate_xt = {
        .minimum_version_id = 1,
        .fields = (VMStateField[]) {
            VMSTATE_BOOL(xten, AMDVIState),
+           VMSTATE_BOOL(intcapxten, AMDVIState),
            VMSTATE_END_OF_LIST()
        }
 };
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 300d91b34d..3cab04a6d4 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -53,6 +53,7 @@
 #define AMDVI_MMIO_EXCL_BASE          0x0020
 #define AMDVI_MMIO_EXCL_LIMIT         0x0028
 #define AMDVI_MMIO_EXT_FEATURES       0x0030
+#define AMDVI_MMIO_XT_GEN_INTR        0x0170
 #define AMDVI_MMIO_COMMAND_HEAD       0x2000
 #define AMDVI_MMIO_COMMAND_TAIL       0x2008
 #define AMDVI_MMIO_EVENT_HEAD         0x2010
@@ -103,6 +104,7 @@
 #define AMDVI_MMIO_CONTROL_CMDBUFLEN      (1ULL << 12)
 #define AMDVI_MMIO_CONTROL_GAEN           (1ULL << 17)
 #define AMDVI_MMIO_CONTROL_XTEN           (1ULL << 50)
+#define AMDVI_MMIO_CONTROL_INTCAPXTEN     (1ULL << 51)
 
 /* MMIO status register bits */
 #define AMDVI_MMIO_STATUS_CMDBUF_RUN  (1 << 4)
@@ -338,6 +340,20 @@ struct irte_ga {
   union irte_ga_hi hi;
 };
 
+union mmio_xt_intr {
+    uint64_t val;
+    struct {
+        uint64_t rsvd_1:2,
+                 destination_mode:1,
+                 rsvd_2:5,
+                 destination_lo:24,
+                 vector:8,
+                 delivery_mode:1,
+                 rsvd_3:15,
+                 destination_hi:8;
+    };
+};
+
 #define TYPE_AMD_IOMMU_DEVICE "amd-iommu"
 OBJECT_DECLARE_SIMPLE_TYPE(AMDVIState, AMD_IOMMU_DEVICE)
 
@@ -416,6 +432,7 @@ struct AMDVIState {
     bool ga_enabled;
     bool xtsup;     /* xtsup=on command line */
     bool xten;      /* guest controlled, x2apic mode enabled */
+    bool intcapxten; /* guest controlled, IOMMU x2apic interrupts enabled */
 
     /* DMA address translation */
     bool dma_remap;
diff --git a/hw/i386/trace-events b/hw/i386/trace-events
index 5fa5e93b68..a1dfade20f 100644
--- a/hw/i386/trace-events
+++ b/hw/i386/trace-events
@@ -118,6 +118,7 @@ amdvi_ir_intctl(uint8_t val) "int_ctl 0x%"PRIx8
 amdvi_ir_target_abort(const char *str) "%s"
 amdvi_ir_delivery_mode(const char *str) "%s"
 amdvi_ir_irte_ga_val(uint64_t hi, uint64_t lo) "hi 0x%"PRIx64" lo 0x%"PRIx64
+amdvi_generate_msi_interrupt(const char *str) "Mode: %s"
 
 # vmport.c
 vmport_register(unsigned char command, void *func, void *opaque) "command: 0x%02x func: %p opaque: %p"
-- 
MST


