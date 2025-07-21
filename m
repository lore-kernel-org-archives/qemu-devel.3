Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C387AC87FC6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 06:01:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udjZj-0008L6-Ou; Mon, 21 Jul 2025 02:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ4-0008Cl-G9
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1udjZ2-00067s-Rv
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 01:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753077592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5KWT+/o3dTqGxj2GxT8gQwaUixPakGt6yMy2ciNkG3w=;
 b=hvHFMNZZWq1TVipq4SUE3YDx4GaERhrPVFq9RUQSnsGrat1RgHlaS9xB+BgrQzGdO3CkeL
 G0cTvYpz6XrGA5a5RkymkvddjSoCSPhC9C4YYUSlQ4/cVePpmxLBZuqs9tsZeHPIUupdG8
 rEtKUQd9rLdNUrHGjC7q9+Ii7aXbvOc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-JWcRK7uvNIm9-G3zb9D82A-1; Mon,
 21 Jul 2025 01:59:50 -0400
X-MC-Unique: JWcRK7uvNIm9-G3zb9D82A-1
X-Mimecast-MFC-AGG-ID: JWcRK7uvNIm9-G3zb9D82A_1753077589
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D9931800C30; Mon, 21 Jul 2025 05:59:49 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.190])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 33E59195608D; Mon, 21 Jul 2025 05:59:46 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 05/12] hw/net/npcm_gmac.c: Correct test for when to reallocate
 packet buffer
Date: Mon, 21 Jul 2025 13:59:20 +0800
Message-ID: <20250721055927.75951-6-jasowang@redhat.com>
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

In gmac_try_send_next_packet() we have code that does "if this block
of data won't fit in the buffer, reallocate it".  However, the
condition it uses is
  if ((prev_buf_size + tx_buf_len) > sizeof(buf))
where buf is a uint8_t *.

This means that sizeof(buf) is always 8 bytes, and the condition will
almost always be true, so we will reallocate the buffer more often
than we need to.

Correct the condition to test against tx_buffer_size, which is
where we track how big the allocated buffer is.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/npcm_gmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index a0050a7725..0c17ae9b2a 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -569,7 +569,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
         tx_buf_len = TX_DESC_TDES1_BFFR1_SZ_MASK(tx_desc.tdes1);
         buf = &tx_send_buffer[prev_buf_size];
 
-        if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+        if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
             tx_buffer_size = prev_buf_size + tx_buf_len;
             tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
             buf = &tx_send_buffer[prev_buf_size];
@@ -591,7 +591,7 @@ static void gmac_try_send_next_packet(NPCMGMACState *gmac)
             tx_buf_len = TX_DESC_TDES1_BFFR2_SZ_MASK(tx_desc.tdes1);
             buf = &tx_send_buffer[prev_buf_size];
 
-            if ((prev_buf_size + tx_buf_len) > sizeof(buf)) {
+            if ((prev_buf_size + tx_buf_len) > tx_buffer_size) {
                 tx_buffer_size = prev_buf_size + tx_buf_len;
                 tx_send_buffer = g_realloc(tx_send_buffer, tx_buffer_size);
                 buf = &tx_send_buffer[prev_buf_size];
-- 
2.42.0


