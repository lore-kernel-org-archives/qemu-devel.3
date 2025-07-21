Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F8BC83F27
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjaJ-0000FS-B0; Mon, 21 Jul 2025 02:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ1-0008Bv-0N
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjYx-000678-SX
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B+YOWVyBM2NC9L7cVU6GfA7Ln+4xlkaVPQo1sEz1p2Y=;
 b=HY8a6WRZUXM2pKtFgSwHYdcMLz6o4N7rXgkTXk56By7+tfZpHHrL5O4DB0c4jTC9FHPGQK
 /vPvMj3t1/8gxe7yLnGp0A004ZofVI/LElBA0AMR5+7PoJG8Kn9b0ID+KfR7Y2km0l0LK+
 SPOY97mphe1U5oBM/kJ/FM+128FLcWg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-wBQNHcxhNaCP1DEBSYW79Q-1; Mon,
 21 Jul 2025 01:59:44 -0400
X-MC-Unique: wBQNHcxhNaCP1DEBSYW79Q-1
X-Mimecast-MFC-AGG-ID: wBQNHcxhNaCP1DEBSYW79Q_1753077583
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C45691800286; Mon, 21 Jul 2025 05:59:43 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D130195608D; Mon, 21 Jul 2025 05:59:41 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 03/12] hw/net/npcm_gmac.c: Send the right data for second
 packet in a row
Date: Mon, 21 Jul 2025 13:59:18 +0800
Message-ID: <20250721055927.75951-4-jasowang@redhat.com>
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

The transmit loop in gmac_try_send_next_packet() is constructed in a
way that means it will send incorrect data if it it sends more than
one packet.

The function assembles the outbound data in a dynamically allocated
block of memory which is pointed to by tx_send_buffer.  We track the
first point in this block of memory which is not yet used with the
prev_buf_size offset, initially zero.  We track the size of the
packet we're sending with the length variable, also initially zero.

As we read chunks of data out of guest memory, we write them to
tx_send_buffer[prev_buf_size], and then increment both prev_buf_size
and length.  (We might dynamically reallocate the buffer if needed.)

When we send a packet, we checksum and send length bytes, starting at
tx_send_buffer, and then we reset length to 0.  This gives the right
data for the first packet.  But we don't reset prev_buf_size.  This
means that if we process more descriptors with further data for the
next packet, that data will continue to accumulate at offset
prev_buf_size, i.e.  after the data for the first packet.  But when
we transmit that second packet, we send length bytes from
tx_send_buffer, so we will send a packet which has the length of the
second packet but the data of the first one.

The fix for this is to also clear prev_buf_size after the packet has
been sent -- we never need the data from packet one after we've sent
it, so we can write packet two's data starting at the beginning of
the buffer.

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/npcm_gmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index a434112580..921327dd8c 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -615,6 +615,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             trace_npcm_gmac_packet_sent(DEVICE(gmac)->canonical_path, length);
             buf = tx_send_buffer;
             length = 0;
+            prev_buf_size = 0;
         }
 
         /* step 6 */
-- 
2.42.0


