Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC09EC04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 14:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2XFM-0002v2-2Q; Thu, 02 May 2024 10:17:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1s2XFG-0002uG-Ck; Thu, 02 May 2024 10:17:10 -0400
Received: from new-mail.astralinux.ru ([51.250.53.244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adiupina@astralinux.ru>)
 id 1s2XFB-0007KH-OS; Thu, 02 May 2024 10:17:09 -0400
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.234.226])
 by new-mail.astralinux.ru (Postfix) with ESMTPA id 4VVbbQ6mlnzlVth;
 Thu,  2 May 2024 17:16:50 +0300 (MSK)
From: Alexandra Diupina <adiupina@astralinux.ru>
To: Alistair Francis <alistair@alistair23.me>
Cc: Alexandra Diupina <adiupina@astralinux.ru>,
 "Konrad, Frederic" <Frederic.Konrad@amd.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, sdl.qemu@linuxtesting.org
Subject: [PATCH v5] xlnx_dpdma: fix descriptor endianness bug
Date: Thu,  2 May 2024 17:16:28 +0300
Message-Id: <20240502141628.28103-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <87y18u3hjf.fsf@draig.linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DrWeb-SpamScore: -100
X-DrWeb-SpamState: legit
X-DrWeb-SpamDetail: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehuddgtddvucetufdoteggodetrfcurfhrohhfihhlvgemucfftfghgfeunecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeetlhgvgigrnhgurhgrucffihhuphhinhgruceorgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhuqeenucggtffrrghtthgvrhhnpeefkedufedvkeffuedtgfdugeeutdegvdffffejfffgleffieduhfejvdelffdvudenucffohhmrghinheplhhinhhugihtvghsthhinhhgrdhorhhgnecukfhppedutddrudejjedrvdefgedrvddvieenucfrrghrrghmpehhvghloheprhgsthgrqdhmshhkqdhlthdqfedtvdeiledtrdgrshhtrhgrlhhinhhugidrrhhupdhinhgvthepuddtrddujeejrddvfeegrddvvdeimeegudehfeegpdhmrghilhhfrhhomheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhnsggprhgtphhtthhopeekpdhrtghpthhtoheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgvpdhrtghpthhtoheprgguihhuphhinhgrsegrshhtrhgrlhhinhhugidrrhhupdhrtghpthhtohephfhrvgguvghrihgtrdfmohhnrhgrugesrghmugdrtghomhdprhgtphhtthhopegvughgrghrrdhighhlvghsihgrshesghhmrghilhdrtghomhdprhgtphhtth
 hopehpvghtvghrrdhmrgihuggvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehqvghmuhdqrghrmhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehsughlrdhqvghmuheslhhinhhugihtvghsthhinhhgrdhorhhg
X-DrWeb-SpamVersion: Vade Retro 01.423.251#02 AS+AV+AP Profile: DRWEB;
 Bailout: 300
X-AntiVirus: Checked by Dr.Web [MailD: 11.1.19.2307031128,
 SE: 11.1.12.2210241838, Core engine: 7.00.62.01180, Virus records: 12656802,
 Updated: 2024-May-02 12:36:40 UTC]
Received-SPF: pass client-ip=51.250.53.244;
 envelope-from=adiupina@astralinux.ru; helo=new-mail.astralinux.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
---
v5: fix subject and make xlnx_dpdma_write_descriptor() not void
v4: remove rewriting desc in place
v3: add xlnx_dpdma_write_descriptor()
v2: minor changes in xlnx_dpdma_read_descriptor()
 hw/dma/xlnx_dpdma.c | 66 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 1f5cd64ed1..f582c1a085 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -614,6 +614,63 @@ static void xlnx_dpdma_register_types(void)
     type_register_static(&xlnx_dpdma_info);
 }
 
+static MemTxResult xlnx_dpdma_read_descriptor(XlnxDPDMAState *s,
+                                    uint64_t desc_addr, DPDMADescriptor *desc)
+{
+    MemTxResult res = dma_memory_read(&address_space_memory, desc_addr,
+                &desc, sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
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
+                                                DPDMADescriptor *desc)
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
@@ -651,8 +708,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             desc_addr = xlnx_dpdma_descriptor_next_address(s, channel);
         }
 
-        if (dma_memory_read(&address_space_memory, desc_addr, &desc,
-                            sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED)) {
+        if (xlnx_dpdma_read_descriptor(s, desc_addr, &desc)) {
             s->registers[DPDMA_EISR] |= ((1 << 1) << channel);
             xlnx_dpdma_update_irq(s);
             s->operation_finished[channel] = true;
@@ -755,8 +811,10 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             /* The descriptor need to be updated when it's completed. */
             DPRINTF("update the descriptor with the done flag set.\n");
             xlnx_dpdma_desc_set_done(&desc);
-            dma_memory_write(&address_space_memory, desc_addr, &desc,
-                             sizeof(DPDMADescriptor), MEMTXATTRS_UNSPECIFIED);
+            if (xlnx_dpdma_write_descriptor(desc_addr, &desc)) {
+                DPRINTF("Can't write the descriptor.\n");
+                break;
+            }
         }
 
         if (xlnx_dpdma_desc_completion_interrupt(&desc)) {
-- 
2.30.2


