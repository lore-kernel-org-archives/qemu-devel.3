Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2351C1077603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vrK-00046J-AG; Wed, 18 Mar 2026 14:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrI-00045Q-TF
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:08 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrH-0001kG-9J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:08 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 44855563242;
 Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (trex-green-3.trex.outbound.svc.cluster.local [100.119.11.147])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id EC796562147;
 Wed, 18 Mar 2026 18:43:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773859384;
 b=50Syu+A3EGHXqetX3x3EKIyGVe+0fzIJXxozjSfU9sQrKU2EqxDDPCjzLmS5RKSoxr4Ww9
 ev3/NETOiurEQVfXl09G6cmABtjfHWtvTsXQKmf8wSTQ08/o5AGxdPUR4SK66n+Bni/6NP
 3CHLFeDP7WsJdR5Dia6zn4merYPK06YV+26msalpFgJPGMw+sV9vgke71W3OcaPY630gw5
 2skj90uUM3xIIxPRGWgSihXo/kf0ze97ybbC6V1zdg3INIn61cU36dxtq2VW5S4FFZRCPZ
 Wer8FJ4NHfEh5Oq5vKkUUx0Atlxg7lgtxoOVC/k/9wtON/5R2SKIvcCzYe0KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773859384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
 b=zCNPhny0Ho5tlD0SYd8S5mDkjy4DlmxBEiXO25iqvbhHiIEdZSuJteWUbJMxCkLkYl9+Jv
 GJ8pQR0o8kidR0fWwIvn9QlhZ6a2wPs8T5XAeXatiXLS+FXZ/bkHCN89eyjw+b3Yr97un0
 NzXCQqWGZxTWfvFxWkVxbmENUnZ8qq8yuTxeBt7fJ9Q+BVEj1yBPKlr7ohpMq7/N5q9MCR
 13ng9+vAzxu82XOQlg7i22I3PVwFsetmmMt+W2EXcFkwoo0qvc5+23GLqLc00kpzsPkMaO
 yBfZxKK2WP3gZJqPe5TIMYvbSz5R3hZZOUGCm6NpYy9ZoFxym4EapXOPqtl7dQ==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-247dc;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Unite: 6b723cc63ca56a5f_1773859384180_1099865106
X-MC-Loop-Signature: 1773859384180:2440543161
X-MC-Ingress-Time: 1773859384180
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.119.11.147 (trex/7.1.5); Wed, 18 Mar 2026 18:43:04 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbd4R3p3Xz107D;
 Wed, 18 Mar 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773859383;
 bh=nZPQxWJbTH2wzVLrbyTk3/yQ3pbXmRcf7ppDh2wu9DY=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=Q8AmT7e4gCi9sRd5SdC3Az5kjo8YUK1O3K/DtopS8Wte9W7eA0q/Ds1VoDfvf5ijh
 JUG6wv64eVFNcS0vwi2q8Mk5EgkctnYBj2sS+daVdakX/TPa7PxFV803EXxwKJqFHP
 MlC/TrLfUAd51klBdnZyiYWQjKJTQnpcr5h5qO9WJh8vy05wTJdaGqQ4Mc3pORjpG2
 DegrmFyVnzlRo9wHLm68xH5AfqKhS1M1QGEl7NAXH9UK0HUNS4BJ2Af/tKjheBiVrr
 o1oJENTDgFijkO1U63i4M9/A8L2d42ujxFqW3gWAEQx0llvhtFZGpaVOGDwkS+VHok
 Ly5uh1TxRBw9w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery
 semantics
Date: Wed, 18 Mar 2026 11:42:55 -0700
Message-Id: <20260318184256.3680349-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318184256.3680349-1-dave@stgolabs.net>
References: <20260318184256.3680349-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.209.27; envelope-from=dave@stgolabs.net;
 helo=butterfly.birch.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

The Discovery handler rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a3143f3faa23..71a012121c87 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,6 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
+    int total = ARRAY_SIZE(media_op_matrix);
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2609,24 +2610,20 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
      * sub class command.
      */
     if (media_op_in_disc_pl->dpa_range_count ||
-        start_index + num_ops > ARRAY_SIZE(media_op_matrix)) {
+        start_index >= total) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
     media_out_pl->dpa_range_granularity = CXL_CACHE_LINE_SIZE;
-    media_out_pl->total_supported_operations =
-                                     ARRAY_SIZE(media_op_matrix);
-    if (num_ops > 0) {
-        for (i = start_index; i < start_index + num_ops; i++) {
-            media_out_pl->entry[count].media_op_class =
-                    media_op_matrix[i].media_op_class;
-            media_out_pl->entry[count].media_op_subclass =
-                        media_op_matrix[i].media_op_subclass;
-            count++;
-            if (count == num_ops) {
-                break;
-            }
-        }
+    media_out_pl->total_supported_operations = total;
+
+    num_ops = MIN(num_ops, total - start_index);
+    for (i = 0; i < num_ops; i++) {
+        media_out_pl->entry[count].media_op_class =
+                media_op_matrix[start_index + i].media_op_class;
+        media_out_pl->entry[count].media_op_subclass =
+                    media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.39.5


