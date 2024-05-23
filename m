Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF1BC25B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATZ-0007u6-2A; Thu, 23 May 2024 11:35:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0007jt-F1
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:13 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATF-0002Rq-8V
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:11 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-34d7d04808bso1863875f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478508; x=1717083308; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AsQRQeKjgMaSSmYepAKdEFvTM+lwKQ9eFt3DVA5Soas=;
 b=SjLKODFYQYmLX5gAjukmOPLRTaarP3KDX/Qpodw/FhCxMTZVrtxc5qo8Oia4oR0UP6
 1JbxqDhJJNu3qeRyqu2deBIAXXoukCC46XZYVvDLwmH8aXlaU64+udbUItRDBTBzU7m5
 psrWQaLSd/g5vmMd5U5GFqVyeljnxLCit4YcrVcAVvJDiUsy3p0uBttSpl7kh7ea9OWE
 wjb31mq9P1u6LJl7MEKswwqkkVmHpPPRA2isAvR0H+e8P8NeQhmxV/G3QcE39tx7DveG
 F2GIJ9IguvmObICQFy6p49XBUjSL240pL3+aDs9QQpJMR+oql4BR+Fz5DNpeG0EuyVi9
 VzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478508; x=1717083308;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsQRQeKjgMaSSmYepAKdEFvTM+lwKQ9eFt3DVA5Soas=;
 b=SEEZ6pT5WAuaWGgUXCwPcEnuxO9xKzz1JWbtaPP09lzRwG2nEmhNzK78TOrCP6TPBQ
 IV42FGm2LuYCgBvpra1HCCBhr6Kn1/H8iJkNEj1BiegJ9rOCNoqgYfzDRNBTESTHh1W2
 oRrB4O7fR0Gnx46uDdGac/gljxxdaEsoikGZMfGPRq9HYu0UDqNMGFgOBMM51q+5oTKt
 sA8iP6NJDrL+EizBDlRAhFLCkI1vwnq+Irx/47T+dAGhUJzgwgSDVXYzlie8mr28Jrf6
 k/+gtgcnI9ppHe3PAc4As4VH0bezX0sAsLqmfzen5cQMNjxVEI9l5zLRq6w+vCcEEIVE
 MvMg==
X-Gm-Message-State: AOJu0Yya5VvwqKfUCq0yUk95R4FegSMluXxMpStNrZrGOpBkrigzBpu8
 B5Y1liOztqqrLYpjPoPoWkJX0ELND8rWtKoyTh0r85FoKsZo0XfmMpM7MwqdB1r1BBYa5igna6F
 p
X-Google-Smtp-Source: AGHT+IFanNf8OnIUa9l1xyzRALNjThc8b9bckvxwdS3gnB3ZQYxxmKeZIJOFr8VRRpT8w+SCsAAoBw==
X-Received: by 2002:a05:6000:e8f:b0:354:fbb6:1b16 with SMTP id
 ffacd0b85a97d-354fbb61b58mr1444189f8f.52.1716478507829; 
 Thu, 23 May 2024 08:35:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:07 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/37] xlnx_dpdma: fix descriptor endianness bug
Date: Thu, 23 May 2024 16:34:29 +0100
Message-Id: <20240523153505.2900433-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alexandra Diupina <adiupina@astralinux.ru>

Add xlnx_dpdma_read_descriptor() and
xlnx_dpdma_write_descriptor() functions.
xlnx_dpdma_read_descriptor() combines reading a
descriptor from desc_addr by calling dma_memory_read()
and swapping the desc fields from guest memory order
to host memory order. xlnx_dpdma_write_descriptor()
performs similar actions when writing a descriptor.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d3c6369a96 ("introduce xlnx-dpdma")
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
[PMM: tweaked indent, dropped behaviour change for write-failure case]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx_dpdma.c | 68 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 530717d1885..dde4aeca401 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -614,6 +614,65 @@ static void xlnx_dpdma_register_types(void)
     type_register_static(&xlnx_dpdma_info);
 }
 
+static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
+                                              uint64_t desc_addr,
+                                              DPDMADescriptor *desc)
+{
+    MemTxResult res = dma_memory_read(&address_space_memory, desc_addr,
+                                      &desc, sizeof(DPDMADescriptor),
+                                      MEMTXATTRS_UNSPECIFIED);
+    if (res) {
+        return res;
+    }
+
+    /* Convert from LE into host endianness.  */
+    desc->control = le32_to_cpu(desc->control);
+    desc->descriptor_id = le32_to_cpu(desc->descriptor_id);
+    desc->xfer_size = le32_to_cpu(desc->xfer_size);
+    desc->line_size_stride = le32_to_cpu(desc->line_size_stride);
+    desc->timestamp_lsb = le32_to_cpu(desc->timestamp_lsb);
+    desc->timestamp_msb = le32_to_cpu(desc->timestamp_msb);
+    desc->address_extension = le32_to_cpu(desc->address_extension);
+    desc->next_descriptor = le32_to_cpu(desc->next_descriptor);
+    desc->source_address = le32_to_cpu(desc->source_address);
+    desc->address_extension_23 = le32_to_cpu(desc->address_extension_23);
+    desc->address_extension_45 = le32_to_cpu(desc->address_extension_45);
+    desc->source_address2 = le32_to_cpu(desc->source_address2);
+    desc->source_address3 = le32_to_cpu(desc->source_address3);
+    desc->source_address4 = le32_to_cpu(desc->source_address4);
+    desc->source_address5 = le32_to_cpu(desc->source_address5);
+    desc->crc = le32_to_cpu(desc->crc);
+
+    return res;
+}
+
+static MemTxResult xlnx_dpdma_write_descriptor(uint64_t desc_addr,
+                                               DPDMADescriptor *desc)
+{
+    DPDMADescriptor tmp_desc = *desc;
+
+    /* Convert from host endianness into LE.  */
+    tmp_desc.control = cpu_to_le32(tmp_desc.control);
+    tmp_desc.descriptor_id = cpu_to_le32(tmp_desc.descriptor_id);
+    tmp_desc.xfer_size = cpu_to_le32(tmp_desc.xfer_size);
+    tmp_desc.line_size_stride = cpu_to_le32(tmp_desc.line_size_stride);
+    tmp_desc.timestamp_lsb = cpu_to_le32(tmp_desc.timestamp_lsb);
+    tmp_desc.timestamp_msb = cpu_to_le32(tmp_desc.timestamp_msb);
+    tmp_desc.address_extension = cpu_to_le32(tmp_desc.address_extension);
+    tmp_desc.next_descriptor = cpu_to_le32(tmp_desc.next_descriptor);
+    tmp_desc.source_address = cpu_to_le32(tmp_desc.source_address);
+    tmp_desc.address_extension_23 = cpu_to_le32(tmp_desc.address_extension_23);
+    tmp_desc.address_extension_45 = cpu_to_le32(tmp_desc.address_extension_45);
+    tmp_desc.source_address2 = cpu_to_le32(tmp_desc.source_address2);
+    tmp_desc.source_address3 = cpu_to_le32(tmp_desc.source_address3);
+    tmp_desc.source_address4 = cpu_to_le32(tmp_desc.source_address4);
+    tmp_desc.source_address5 = cpu_to_le32(tmp_desc.source_address5);
+    tmp_desc.crc = cpu_to_le32(tmp_desc.crc);
+
+    return dma_memory_write(&address_space_memory, desc_addr, &tmp_desc,
+                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
+}
+
 size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
                                     bool one_desc)
 {
@@ -651,8 +710,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             desc_addr = xlnx_dpdma_descriptor_next_address(s, channel);
         }
 
-        if (dma_memory_read(&address_space_memory, desc_addr, &desc,
-                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
+        if (xlnx_dpdma_read_descriptor(s, desc_addr, &desc)) {
             s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
             xlnx_dpdma_update_irq(s);
             s->operation_finished[channel] = true;
@@ -755,8 +813,10 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             /* The descriptor need to be updated when it's completed. */
             DPRINTF("update the descriptor with the done flag set.\n");
             xlnx_dpdma_desc_set_done(&desc);
-            dma_memory_write(&address_space_memory, desc_addr, &desc,
-                             sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
+            if (xlnx_dpdma_write_descriptor(desc_addr, &desc)) {
+                DPRINTF("Can't write the descriptor.\n");
+                /* TODO: check hardware behaviour for memory write failure */
+            }
         }
 
         if (xlnx_dpdma_desc_completion_interrupt(&desc)) {
-- 
2.34.1


