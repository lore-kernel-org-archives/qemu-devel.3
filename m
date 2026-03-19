Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F762109190F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3ILA-0000cl-6k; Thu, 19 Mar 2026 14:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL3-0000Pq-Ng
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:22 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL0-0007NC-NE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:21 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 0C868823B0C;
 Thu, 19 Mar 2026 18:43:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com
 (100-115-116-28.trex-nlb.outbound.svc.cluster.local [100.115.116.28])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 799B6823B68;
 Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773945794;
 b=FANOe5QurSWHW0Sl2domycUXXa1lVPJuXzWFIHBlHzkimutBqtibnI2bWkDe0ayt4xWpTJ
 +faDhHwxb52nlTfXlkCc2/Luef/BorMzVEmo04OaKlyp/azeknc6j3/O9rbIoBC2jsWwLv
 XUEE2tty9/JjyInWQ6Jfz8TxSCfaYPdudFDG4c5bZW9zbYy548KF5t59uZUuBLPAH5LKhG
 jEMLxJsu8XAjw6eX3k7U93n848f963/hK2kIxRtFYzlCl7CbiQvvs2HkDrJ/+Uh4NX5wRU
 /V/ZmrEv0uDBZRd//Y7C1ClZqsBJSCHb8i0egC++2xwcYpdIt4ZCC8a+81fazw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773945794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=PoI4BK3hvU2nKIds7DnxJnNUvQd2NTtab+MbLNuAEt8=;
 b=N2u1xxeaauXu3Ki1wM4GLdXEiSK4e3iRaNYErPXWu6I6l0Yv32YBACjamOVUrmePuSVinJ
 l4oLOlerldIr/exU3gafo5oPixW7UwYfEI8XScFILI/nD5xwj4adXw2oajoRSiX1vtJ4JL
 f31wMgWKfqQw4J4bUXkJ9uH315BHdzSULargWgoz3DFKQrnI7ezGJ0jppiH380aRAqbGdE
 +jDF+6kGA8t7965lSIbpzbA2iJcyGzEeFKTKLHyMHhwV5FLbVFap1IyhCJL3Qo63RHsnpP
 L62fh32M7kFZJwlqhZlzzCScwLojk24F+qBTMMR5yBZpShtXg7hy69ZRFG1/8A==
ARC-Authentication-Results: i=1; rspamd-7f98bb5847-7xrmz;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Tasty-Continue: 207cc2b574cbcc62_1773945794938_171937942
X-MC-Loop-Signature: 1773945794938:617296039
X-MC-Ingress-Time: 1773945794937
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.115.116.28 (trex/7.1.5); Thu, 19 Mar 2026 18:43:14 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF2B0K0Mz2P; 
 Thu, 19 Mar 2026 11:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773945794;
 bh=PoI4BK3hvU2nKIds7DnxJnNUvQd2NTtab+MbLNuAEt8=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=ahu6Sxt6X+am35BnljL0eFLcwF1K+MK9Q8DRI0Y08gTvEsERDYKW+jq6qJR3UqHTr
 YO+uMBWT+hKAhAF5CxoLk/DC3GCRdscNMXTF8Wf2iP6q+2rPwio3/aRPe/eG9HMbnB
 n4JAp3k1+kPehvEwKJnlHMgQzv+vgTcgiZ9wNIKBKQjO4vrSrZgoNswcy7Nxejlxna
 g9jRueistD7knMBA8Q+dhFHPoikS2KVHWmcdNw9Pu1VJQfgvE6OPv3RfvJXRWJcCJt
 szTzkQmfZGiH+io8Ez5fnS+IycLBDZ7/DODqk4eDMGs6rwM4H5JndL/BjH3K051rp3
 pVy28lEj7wSYA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation Discovery
 output
Date: Thu, 19 Mar 2026 11:42:56 -0700
Message-Id: <20260319184256.3762391-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260319184256.3762391-1-dave@stgolabs.net>
References: <20260319184256.3762391-1-dave@stgolabs.net>
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

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c628f775ac48..9a5caf62417a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,7 +2593,7 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
-    int total = ARRAY_SIZE(media_op_matrix);
+    int total = ARRAY_SIZE(media_op_matrix) - 1; /* exclude Discovery */
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2619,10 +2619,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
 
     num_ops = MIN(num_ops, total - start_index);
     for (i = 0; i < num_ops; i++) {
+        int idx = start_index + i + 1; /* skip Discovery (first entry) */
+
         media_out_pl->entry[count].media_op_class =
-                media_op_matrix[start_index + i].media_op_class;
+                media_op_matrix[idx].media_op_class;
         media_out_pl->entry[count].media_op_subclass =
-                media_op_matrix[start_index + i].media_op_subclass;
+                media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.39.5


