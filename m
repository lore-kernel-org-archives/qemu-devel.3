Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A30CDE001
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Nov 2025 03:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJknj-0004MD-Ur; Thu, 13 Nov 2025 22:48:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJkni-0004Le-ME
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vJknh-0003G5-7L
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 22:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763092120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDH6UsnTMYflk4QtSUUdLj4cMeywLf2SlGbbNGsdxN8=;
 b=I3Bv4B9nOgEF25fKH7rQcTEcVTx5EqCSZZ/VSIGIIkZXJbRWq37q4KO1mChneukZIIxFWA
 Uk2k6X2mJ1yQSc/Sd4MlL+utk9BwjWti9ULBmUBGHm9ZV6bc4NQ3B3kYzQaZbYeiEZ8EFu
 QsSwgAMVoEdkWP0VkDbDDlG8k5IIjQM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-06cP9rBGMl-CkHD1btIsGQ-1; Thu,
 13 Nov 2025 22:48:38 -0500
X-MC-Unique: 06cP9rBGMl-CkHD1btIsGQ-1
X-Mimecast-MFC-AGG-ID: 06cP9rBGMl-CkHD1btIsGQ_1763092117
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B01918AB414; Fri, 14 Nov 2025 03:48:37 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.120.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 06F21180049F; Fri, 14 Nov 2025 03:48:32 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-stable@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Jason Wang <jasowang@redhat.com>
Subject: [PULL 4/5] hw/net/e1000e_core: Adjust
 e1000e_write_payload_frag_to_rx_buffers() assert
Date: Fri, 14 Nov 2025 11:48:05 +0800
Message-ID: <20251114034806.2440-5-jasowang@redhat.com>
In-Reply-To: <20251114034806.2440-1-jasowang@redhat.com>
References: <20251114034806.2440-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

An assertion in e1000e_write_payload_frag_to_rx_buffers() attempts to
guard against the calling code accidentally trying to write too much
data to a single RX descriptor, such that the E1000EBAState::cur_idx
indexes off the end of the EB1000BAState::written[] array.

Unfortunately it is overzealous: it asserts that cur_idx is in
range after it has been incremented. This will fire incorrectly
for the case where the guest configures four buffers and exactly
enough bytes are written to fill all four of them.

The only places where we use cur_idx and index in to the written[]
array are the functions e1000e_write_hdr_frag_to_rx_buffers() and
e1000e_write_payload_frag_to_rx_buffers(), so we can rewrite this to
assert before doing the array dereference, rather than asserting
after updating cur_idx.

Cc: qemu-stable@nongnu.org
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 471c3ed20b..46e156a5dd 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -1392,10 +1392,13 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
                                         dma_addr_t data_len)
 {
     while (data_len > 0) {
-        uint32_t cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
-        uint32_t cur_buf_bytes_left = cur_buf_len -
-                                      bastate->written[bastate->cur_idx];
-        uint32_t bytes_to_write = MIN(data_len, cur_buf_bytes_left);
+        uint32_t cur_buf_len, cur_buf_bytes_left, bytes_to_write;
+
+        assert(bastate->cur_idx < MAX_PS_BUFFERS);
+
+        cur_buf_len = core->rxbuf_sizes[bastate->cur_idx];
+        cur_buf_bytes_left = cur_buf_len - bastate->written[bastate->cur_idx];
+        bytes_to_write = MIN(data_len, cur_buf_bytes_left);
 
         trace_e1000e_rx_desc_buff_write(bastate->cur_idx,
                                         ba[bastate->cur_idx],
@@ -1414,8 +1417,6 @@ e1000e_write_payload_frag_to_rx_buffers(E1000ECore *core,
         if (bastate->written[bastate->cur_idx] == cur_buf_len) {
             bastate->cur_idx++;
         }
-
-        assert(bastate->cur_idx < MAX_PS_BUFFERS);
     }
 }
 
-- 
2.42.0


