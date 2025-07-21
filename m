Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B31C87FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:03:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjbE-000100-2f; Mon, 21 Jul 2025 02:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ3-0008CV-J1
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ0-00067R-PK
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=so4o0qh5eAFTTG1tWk2RBAHz3wYv4RnAAL56VvPJxoo=;
 b=eczSgr5tnQcM3apjbeJhPJVrgFvh/l668MtYHZr211z+SuzWAjASX6ILQu3kKqq8buARzG
 9Q0NVBXZyniahAKB6uaUnIoGg4O2vIFZK3Q2m1zqINi9gWpOMrXReWhig0UrrFEAa3kvzu
 zTkDBBOFwpvTLylk1UUUMN+eN4YuEZI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-PnX5GBeuOcWCuSts5n10_A-1; Mon,
 21 Jul 2025 01:59:47 -0400
X-MC-Unique: PnX5GBeuOcWCuSts5n10_A-1
X-Mimecast-MFC-AGG-ID: PnX5GBeuOcWCuSts5n10_A_1753077586
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 747CD195FE11; Mon, 21 Jul 2025 05:59:46 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 838BB195608D; Mon, 21 Jul 2025 05:59:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 04/12] hw/net/npcm_gmac.c: Unify length and prev_buf_size
 variables
Date: Mon, 21 Jul 2025 13:59:19 +0800
Message-ID: <20250721055927.75951-5-jasowang@redhat.com>
In-Reply-To: <20250721055927.75951-1-jasowang@redhat.com>
References: <20250721055927.75951-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

After the bug fix in the previous commit, the length and prev_buf_size
variables are identical, except that prev_buf_size is uint32_t and
length is uint16_t. We can therefore unify them. The only place where
the type makes a difference is that we will truncate the packet
at 64K when sending it; this commit preserves that behaviour
by using a local variable when doing the packet send.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/npcm_gmac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index 921327dd8c..a0050a7725 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -516,7 +516,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
     uint32_t desc_addr;
     struct NPCMGMACTxDesc tx_desc;
     uint32_t tx_buf_addr, tx_buf_len;
-    uint16_t length = 0;
     uint8_t *buf = tx_send_buffer;
     uint32_t prev_buf_size = 0;
     int csum = 0;
@@ -583,7 +582,6 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
                         __func__, tx_buf_addr);
             return;
         }
-        length += tx_buf_len;
         prev_buf_size += tx_buf_len;
 
         /* If not chained we'll have a second buffer. */
@@ -606,15 +604,18 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
                               __func__, tx_buf_addr);
                 return;
             }
-            length += tx_buf_len;
             prev_buf_size += tx_buf_len;
         }
         if (tx_desc.tdes1 & TX_DESC_TDES1_LAST_SEG_MASK) {
+            /*
+             * This will truncate the packet at 64K.
+             * TODO: find out if this is the correct behaviour.
+             */
+            uint16_t length = prev_buf_size;
             net_checksum_calculate(tx_send_buffer, length, csum);
             qemu_send_packet(qemu_get_queue(gmac->nic), tx_send_buffer, length);
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
             buf = tx_send_buffer;
-            length = 0;
             prev_buf_size = 0;
         }
 
-- 
2.42.0


