Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F458C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjd3-0002c6-22; Mon, 21 Jul 2025 02:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZA-0008ID-Ar
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 02:00:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ6-000696-Sx
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnYOJbXEeP/53KinnYaU63GnFaShL0QvpZTkjzNCw64=;
 b=MbCCcAhBrGOZdcupWpWL3+sw+yX0O3h8o+wiqUVPI3IrTIBLAWBrM2nqjKezPHbx5Fr4Ay
 kpp3djWsP5LPYSQtp/YZjAWSqlYflmyN4Y4PWFl6IL0Z+wQYCgyAAsFXw6f1Tqxi6XSEOZ
 Mp31kGArmrDkExGgKsB0YtT1ueFVqBk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-jHw9vkwsN4ynLu9qh0-WNw-1; Mon,
 21 Jul 2025 01:59:52 -0400
X-MC-Unique: jHw9vkwsN4ynLu9qh0-WNw-1
X-Mimecast-MFC-AGG-ID: jHw9vkwsN4ynLu9qh0-WNw_1753077591
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE2C6195FD06; Mon, 21 Jul 2025 05:59:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1642195608D; Mon, 21 Jul 2025 05:59:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 06/12] hw/net/npcm_gmac.c: Drop 'buf' local variable
Date: Mon, 21 Jul 2025 13:59:21 +0800
Message-ID: <20250721055927.75951-7-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

We use the local variable 'buf' only when we call dma_memory_read(),
and it is always set to &tx_send_buffer[prev_buf_size] immediately
before both of those calls.  So remove the variable and pass
tx_send_buffer + prev_buf_size to dma_memory_read().

This fixes in passing a place where we set buf = tx_send_buffer
but never used that value because we always updated buf to
something else later before using it.

Coverity: CID 1534027
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/npcm_gmac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 0c17ae9b2a..5e32cd3edf 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -516,7 +516,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
     uint32_t desc_addr;
     struct NPCMGMACTxDesc tx_desc;
     uint32_t tx_buf_addr, tx_buf_len;
-    uint8_t *buf = tx_send_buffer;
     uint32_t prev_buf_size = 0;
     int csum = 0;
 
@@ -567,16 +566,15 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
         tx_buf_addr = tx_desc.tdes2;
         gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
         tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
-        buf = &tx_send_buffer[prev_buf_size];
 
         if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
             tx_buffer_size = prev_buf_size + tx_buf_len;
             tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
-            buf = &tx_send_buffer[prev_buf_size];
         }
 
         /* step 5 */
-        if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+        if (dma_memory_read(&address_space_memory, tx_buf_addr,
+                            tx_send_buffer + prev_buf_size,
                             tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
             qemu_log_mask(LOG_GUEST_ERROR, "%s: Failed to read packet @ 0x%x\n",
                         __func__, tx_buf_addr);
@@ -589,15 +587,14 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             tx_buf_addr = tx_desc.tdes3;
             gmac->regs[R_NPCM_DMA_CUR_TX_BUF_ADDR] = tx_buf_addr;
             tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
-            buf = &tx_send_buffer[prev_buf_size];
 
             if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
                 tx_buffer_size = prev_buf_size + tx_buf_len;
                 tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
-                buf = &tx_send_buffer[prev_buf_size];
             }
 
-            if (dma_memory_read(&address_space_memory, tx_buf_addr, buf,
+            if (dma_memory_read(&address_space_memory, tx_buf_addr,
+                                tx_send_buffer + prev_buf_size,
                                 tx_buf_len, MEMTXATTRS_UNSPECIFIED)) {
                 qemu_log_mask(LOG_GUEST_ERROR,
                               "%s: Failed to read packet @ 0x%x\n",
@@ -615,7 +612,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
-            buf = tx_send_buffer;
             prev_buf_size = 0;
         }
 
-- 
2.42.0


