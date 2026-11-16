Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32371606A32A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Y8t39v3D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3D1-00015v-9p; Mon, 16 Nov 2026 15:21:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3Ca-0008VE-Jh; Mon, 16 Nov 2026 15:21:23 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xT3CU-0002DP-Rg; Mon, 16 Nov 2026 15:21:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1794860369; bh=dkIYV88F++fuun4HBVYk+d3sRiDjGOPufvdE13OHfPE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y8t39v3DbWtZ0fidmu6KOoS06FMSjLTTTwtY+yiuoCj0wdl/NCama0SMBW/RhAwqG
 snoLdlFKLmZw0xYz+qOIsG5cxBelb5CMfT4mTwFlhv7BnnPfuy1Q4u28nObwvq3jO2
 VDIlTRZyHbVo9xabvdOMUVF8ubz1rLV6rpX906CAKeKSpcl6FbhOFtZ4Kt+gCigabC
 rO0d5Djc8xQhmoF2I5fhi6Hk4RsZbE/tAtPuHIwgPkROkTAQe2CKM/lrwwSGhWCB0L
 /PXUCcMgMbUmX/wJVkskpitwwsgSyRsJrjLLj/8UMf1//mHb6wwT9qEN0hU8cnq6DX
 WFK4nNF60l//Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D01BA1E714B;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CD72D45FB81;
 Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7B679B8DF8; Mon, 16 Nov 2026 23:19:29 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 21/59] hw/dma/xlnx_dpdma: Don't allow DMA off end of
 host buffers
Date: Mon, 16 Nov 2026 23:18:25 +0300
Message-ID: <20261116201922.534306-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261116212616@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Peter Maydell <peter.maydell@linaro.org>

The xlnx_dpdma DMA engine allows the guest to do DMA to host buffers
for audio and graphics data.  These buffers are set up by the xlnx_dp
device, which calls xlnx_dpdma_set_host_data_location() to tell the
DMA engine where they are.  However, this API doesn't provide any way
to say how big the host buffers are, and the DMA engine does not
check whether the guest is trying to write off the end of the buffer.

Add a length argument to xlnx_dpdma_set_host_data_location(), and
bounds check the guest's DMA writes against it.  The DPDMA ISR has
bits for each channel for "descriptor payload is too large", so we
report such overflows there.

Cc: qemu-stable@nongnu.org
Fixes: d3c6369a96a8 ("introduce xlnx-dpdma")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4134
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20261025110857.1973128-1-peter.maydell@linaro.org
(cherry picked from commit c8b6ce2fa6d65a65e8b535d6d9a94593a2927929)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 6fd56016354..d5843a40a65 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -333,9 +333,11 @@ static inline void xlnx_dp_audio_activate(XlnxDPState *s)
                    & DP_TX_AUD_CTRL) != 0);
     AUD_set_active_out(s->amixer_output_stream, activated);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(0),
-                                      &s->audio_buffer_0);
+                                      &s->audio_buffer_0,
+                                      sizeof(s->audio_buffer_0));
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_AUDIO_DMA_CHANNEL(1),
-                                      &s->audio_buffer_1);
+                                      &s->audio_buffer_1,
+                                      sizeof(s->audio_buffer_1));
 }
 
 static inline void xlnx_dp_audio_mix_buffer(XlnxDPState *s)
@@ -566,6 +568,18 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
     s->core_registers[DP_INTERRUPT_SIGNAL_STATE] |= 0x04;
 }
 
+/*
+ * Return the size of the surface in bytes. Pixman doesn't provide
+ * a helper function/accessor for this, so we must calculate it
+ * from the stride and height. Note that a pixman stride can
+ * potentially be negative, hence the abs().
+ */
+static inline uint64_t surface_data_size(DisplaySurface *s)
+{
+    /* Can't overflow because stride and height are both int */
+    return (uint64_t)abs(surface_stride(s)) * surface_height(s);
+}
+
 static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
@@ -574,7 +588,8 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);
         xlnx_dpdma_set_host_data_location(dma, DP_GRAPHIC_DMA_CHANNEL,
-                                          surface_data(surface));
+                                          surface_data(surface),
+                                          surface_data_size(surface));
     }
 }
 
@@ -638,9 +653,11 @@ static void xlnx_dp_recreate_surface(XlnxDPState *s)
         }
 
         xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
-                                            surface_data(s->g_plane.surface));
+                                          surface_data(s->g_plane.surface),
+                                          surface_data_size(s->g_plane.surface));
         xlnx_dpdma_set_host_data_location(s->dpdma, DP_VIDEO_DMA_CHANNEL,
-                                            surface_data(s->v_plane.surface));
+                                          surface_data(s->v_plane.surface),
+                                          surface_data_size(s->v_plane.surface));
     }
 }
 
@@ -1384,7 +1401,8 @@ static void xlnx_dp_realize(DeviceState *dev, Error **errp)
     s->console = graphic_console_init(dev, 0, &xlnx_dp_gfx_ops, s);
     surface = qemu_console_surface(s->console);
     xlnx_dpdma_set_host_data_location(s->dpdma, DP_GRAPHIC_DMA_CHANNEL,
-                                      surface_data(surface));
+                                      surface_data(surface),
+                                      surface_data_size(surface));
 
     as.freq = 44100;
     as.nchannels = 2;
diff --git a/hw/dma/xlnx_dpdma.c b/hw/dma/xlnx_dpdma.c
index 2657808d379..13a6eb96eb6 100644
--- a/hw/dma/xlnx_dpdma.c
+++ b/hw/dma/xlnx_dpdma.c
@@ -589,6 +589,7 @@ static void xlnx_dpdma_reset(DeviceState *dev)
 
     for (i = 0; i < 6; i++) {
         s->data[i] = NULL;
+        s->datalen[i] = 0;
         s->operation_finished[i] = true;
     }
 }
@@ -760,6 +761,14 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             int64_t transfer_len = xlnx_dpdma_desc_get_transfer_size(&desc);
             uint32_t line_size = xlnx_dpdma_desc_get_line_size(&desc);
             uint32_t line_stride = xlnx_dpdma_desc_get_line_stride(&desc);
+
+            if (transfer_len > s->datalen[channel]) {
+                s->registers[DPDMA_ISR] |= ((1 << 18) << channel);
+                xlnx_dpdma_update_irq(s);
+                DPRINTF("Descriptor payload too large..\n");
+                goto update_descriptor;
+            }
+
             if (xlnx_dpdma_desc_is_contiguous(&desc)) {
                 source_addr[0] = xlnx_dpdma_desc_get_source_address(&desc, 0);
                 while (transfer_len != 0) {
@@ -809,6 +818,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
             }
         }
 
+    update_descriptor:
         if (xlnx_dpdma_desc_update_enabled(&desc)) {
             /* The descriptor need to be updated when it's completed. */
             DPRINTF("update the descriptor with the done flag set.\n");
@@ -831,7 +841,7 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
 }
 
 void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
-                                         void *p)
+                                       void *p, uint64_t len)
 {
     if (!s) {
         qemu_log_mask(LOG_UNIMP, "DPDMA client not attached to valid DPDMA"
@@ -841,6 +851,7 @@ void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
 
     assert(channel <= 5);
     s->data[channel] = p;
+    s->datalen[channel] = len;
 }
 
 void xlnx_dpdma_trigger_vsync_irq(XlnxDPDMAState *s)
diff --git a/include/hw/dma/xlnx_dpdma.h b/include/hw/dma/xlnx_dpdma.h
index 1ec0d265be2..f490534b3f1 100644
--- a/include/hw/dma/xlnx_dpdma.h
+++ b/include/hw/dma/xlnx_dpdma.h
@@ -39,6 +39,7 @@ struct XlnxDPDMAState {
     MemoryRegion iomem;
     uint32_t registers[XLNX_DPDMA_REG_ARRAY_SIZE];
     uint8_t *data[6];
+    uint64_t datalen[6];
     bool operation_finished[6];
     qemu_irq irq;
 };
@@ -70,10 +71,10 @@ size_t xlnx_dpdma_start_operation(XlnxDPDMAState *s, uint8_t channel,
  * @s The DPDMA state.
  * @channel The channel associated to the pointer.
  * @p The buffer where to store the data.
+ * @len: The length of the buffer in bytes.
  */
-/* XXX: add a maximum size arg and send an interrupt in case of overflow. */
 void xlnx_dpdma_set_host_data_location(XlnxDPDMAState *s, uint8_t channel,
-                                       void *p);
+                                       void *p, uint64_t len);
 
 /*
  * xlnx_dpdma_trigger_vsync_irq: Trigger a VSYNC IRQ when the display is
-- 
2.47.3


