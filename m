Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0CFF109190D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 18:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3IL9-0000Z0-3p; Thu, 19 Mar 2026 14:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL3-0000Q4-U5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:22 -0400
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w3IL2-0007NB-D6
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 14:43:21 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 810C16C1EF8;
 Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com
 (trex-green-1.trex.outbound.svc.cluster.local [100.117.57.254])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 2CBED6C1EA4;
 Thu, 19 Mar 2026 18:43:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773945794;
 b=WVWlmv+CUR+e5RSuut2hyHI3PgtmRgM3VmAa+VJLQ1Xpw4ADUSNmquqr1v51M+EN8Gzsiz
 yO2i+JgobLa9PBsC1fYiT5UW9XRb2AQG8gaexMINi4DG73nEdwML9r2ufugXG3FtM12Z3F
 BeqDYV6O5gq42n3L83YN3HIUZYLT1Vih6w3tbDKKZP1UGQmbj5XJp+19xgcBKVx89fgl+G
 QPvG/t2WPBTq7ucbaVJCyfXS8puuU9JiWV7MKdQ27w8mnaQaP3d9hXt0A5ygtnrEgiAxRV
 bV0RYObciLKr2fqJ1jbjnn6qJQXPep+SdZLcFG74nuOb3YJLCXaaS/qWEKbPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773945794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=RIbQtIMyzdXuMVMoDhozBVahIPjXPJ8h2fuqB+pj6EE=;
 b=Zd4YSpai5YxGjx+xUItuQlMcPteKG8qQX2LgkIW+zqC0/p+MjeGERhYAmqWScIv3a4+E7M
 RMtTP8QqUmtdZ2eWuUI7QCyt1/zJeRE8rMl3838cLVwFbGD9ZpjyOhK7uRDIMBxH2WdNcr
 SvdKajvJ16J/8ldeJG4fF8KDsnEvacjtuY8S9cZhZEpBHd+yrtvr6NWTpajSqxH03oU3Vb
 bOPQm4yVV3BwMyA6FYQWjNFrdOVhZgfHpia++aNYP73HkhjrBYCDsyZpDWNdqTqkRbPCAc
 ySJ4ft1AFOHDT5iGX/gfMKeY07ucfBDvN2b6VQ9jqv0Vns8+j1x2awZuzoHpYQ==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-t2cws;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Quick: 382cf0ca1031cfcc_1773945794423_907135795
X-MC-Loop-Signature: 1773945794423:878038627
X-MC-Ingress-Time: 1773945794423
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.117.57.254 (trex/7.1.5); Thu, 19 Mar 2026 18:43:14 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4fcF294Fdrz3P; 
 Thu, 19 Mar 2026 11:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773945793;
 bh=RIbQtIMyzdXuMVMoDhozBVahIPjXPJ8h2fuqB+pj6EE=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=KQ/70riacnd6U++PMQmFq+2ud8Fo840lbJzMbuuOS9jHr9ICMWSGCOyjQKJ9vSfwK
 CSkSv2lkRWjb2EltyOuQtW9tJOsulmq6fHx8a2y35dR4bQP+4C4Q+flzI4PiYSj5xb
 nkNGZvJFJ6Q1+5xmfoRKLdJurKfuoK6YUKWbcEe5wR/CZF7TmNKTyvEeWogRCTEDzp
 BCrAlZqKwTQ/unML+dYU5osXBUO3NYhneSouxHyqwbXum9zOhyhz9tP1bRpV0kCAtB
 nugIiwLludnwwT8XEi6t0mRc/K7K2WO3RzA6fZQe9dBo6JIivEpJHDsqlHStyiE+ng
 vMYaNokTjUROA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: mst@redhat.com,
	jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 1/2] hw/cxl: Respect Media Operation max ops discovery
 semantics
Date: Thu, 19 Mar 2026 11:42:55 -0700
Message-Id: <20260319184256.3762391-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260319184256.3762391-1-dave@stgolabs.net>
References: <20260319184256.3762391-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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

The Discovery rejects requests where start_index + num_ops
exceeds the total number of supported operations. Per CXL 4.0
Table 8-332, num_ops is the "Maximum number of Media Operation to
return" - a maximum, not an exact count. The device should return
up to that many entries, not reject the request.

Cap num_ops to the available entries from start_index instead of
erroring the command.

Fixes: 77a8e9fe0ecb ("hw/cxl/cxl-mailbox-utils: Add support for Media operations discovery commands cxl r3.2 (8.2.10.9.5.3)")
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index a3143f3faa23..c628f775ac48 100644
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
+                media_op_matrix[start_index + i].media_op_subclass;
+        count++;
     }
 
     media_out_pl->num_of_supported_operations = count;
-- 
2.39.5


