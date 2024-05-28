Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D40C27C44
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 14:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBxUh-0001VT-MX; Tue, 28 May 2024 10:08:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUf-0001Ts-7R
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBxUc-00070A-FA
 for qemu-devel@nongnu.org; Tue, 28 May 2024 10:08:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso810467f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 07:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716905277; x=1717510077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AsQRQeKjgMaSSmYepAKdEFvTM+lwKQ9eFt3DVA5Soas=;
 b=kI5ggoQj2nP6FxdUW0bGZ9XzdctSvs8aV1H1+IqyY1ElSwQnqwcr0lq1VHtrIdndOU
 TOydKExB68kFUL9mlZd+Sg1co1FOmj9doZtPw3CxCOpvgeHJqhgQs5TAdo7dS6ooJoF6
 DNvLkoYHoEGgfs5+TkQ2SQ6G6BK+X8ZX7X3NC+kn9Eqg4MT/998CbKc68er+RRkE/pNc
 WR/gguHGyIr4atKpbIMVlxEBWfyeMFavOCO0ZSBWDmob25D/gBGpk4A8Gg8bzPOv50lZ
 PXcszROAgU8Q297b1R5jqVm/uwixpEZIvjK4qtN3UQ91HDd/G1joN5xag1Js9P+HhLow
 3QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716905277; x=1717510077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsQRQeKjgMaSSmYepAKdEFvTM+lwKQ9eFt3DVA5Soas=;
 b=PQfYb++MzOtTQvHeVal//o62NEDV/sfrcxX0RU/gBU/BrlenzJDl+/hDTYkAIlOQyZ
 Ubt7nglr27U160JWgeRCh5DxvYdcU6/yFzKj2L4BOBGJnPdqMzr2XuIkDDWqSp4iv0CK
 8gt/VE+trEd2RICKPQ7aEiTEqnrS5ZHpNkfG0Uz/DDioFQHXskm9PzA+wh/pHtjUUFit
 DAihZxPr5b3067hGGc5oCR53VYP/QPb9xKTu8icddGnY3t4PfqR13/pACOSASIQ5aO+D
 tALkD1JDE62rGHqfiQI0KVeyucWR1Fy3uBKPO5ZZazgUZr9QQ3eGpuEnO+kz6VbZijQn
 r8bQ==
X-Gm-Message-State: AOJu0YzQiQ28uDaVNYGdruL6VgeVsKe/zJCsE3ImCWikI/1ay+teQyM8
 9HMtuy3XS5oriHeXhaCuaa7XqmZ2TAPdRsVpkGRtZrjLNdAYqpZ2zip106HH/SBGC+ONI7kffGu
 i
X-Google-Smtp-Source: AGHT+IGObDU/9tlRDrCmdPRw4PtsxoyjrxRN09hGnbXhAYtT466X9qsNLnxuPxnohZ4z/TsULLo4/w==
X-Received: by 2002:a5d:4f8b:0:b0:355:2c1:cbba with SMTP id
 ffacd0b85a97d-3552217f5c2mr8805791f8f.16.1716905276615; 
 Tue, 28 May 2024 07:07:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3564afc3577sm11361473f8f.102.2024.05.28.07.07.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 May 2024 07:07:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/42] xlnx_dpdma: fix descriptor endianness bug
Date: Tue, 28 May 2024 15:07:12 +0100
Message-Id: <20240528140753.3620597-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240528140753.3620597-1-peter.maydell@linaro.org>
References: <20240528140753.3620597-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


