Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8465E1077605
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vrJ-00045g-R6; Wed, 18 Mar 2026 14:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrI-00045P-SR
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:08 -0400
Received: from butterfly.birch.relay.mailchannels.net ([23.83.209.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2vrH-0001kI-9E
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:43:08 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id B0C056C27B2;
 Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (trex-green-7.trex.outbound.svc.cluster.local [100.116.110.109])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 526E76C3602;
 Wed, 18 Mar 2026 18:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773859384;
 b=6Ym49KxayjYQ+Gf90AILgzyMqypg+KpJRYh6KI0EaHOu7egKvawtmrcUwHSrqds4wdruXm
 8nBHqtKMipgk6b4+VMQ5MhfC1xKxEBtUaQ+dCS4twgE1bXMOcPueWisu7FYcSA0OGzKXcY
 tTENh1KgrLqlf86WiKtUtlHcRwWVCh9cpGglIOJKVHJTkOBYafjreiUOo8nzMIkrfbwCL2
 DR7XO8VwhdUDXTuMQzE7ayxNWVFxkHXczFwA8siv0hXDbRkkFkjQxpe8Qu4szXesGMyAKJ
 ITRnemi81zv0ED5SfWtrCz5KEIvxU+Hdlx9eCyJxPY0lG8lcs7m5ZcgH53NvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773859384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=UYw2Q5vPynmZ8IsRFlBFNocCRgzUvdsH0CMtqKUoRT0=;
 b=XsfPXVn1sf31VDAmvXA7XK7Zya7yszXLoSMpfoXgq7wRp+Zaug3zCDiZbQ/hp5mVuo0988
 exg+YShohzpVKEY1eOTSEca/Ta9ciNMSgrsizqghwBFWrMo7hlkD6JXKifuQrnCR3WTnsV
 OvxWYAwDXxuU2ohWRFhEj54rBsGvyqbjZXXJhrjGak3QcOD3honJKuPFZgTNX3BvuQde3k
 JRlgAdihmu+qYuGb4VPzxhmJQs1InG/E40K1HsQKepeVBP0Py9sAtgjO8WI0hZ77q1S5hT
 Bi0p/8NR9UrQn/G1PUtv3rnOdT0BVZt4/xVPmQSIi0kkJ/X+8n4y7Xf0bSOcHw==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-247dc;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stop-Bitter: 448b188407346c4d_1773859384551_1194585304
X-MC-Loop-Signature: 1773859384551:2770047674
X-MC-Ingress-Time: 1773859384551
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.116.110.109 (trex/7.1.5); Wed, 18 Mar 2026 18:43:04 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbd4R6hSYz103R;
 Wed, 18 Mar 2026 11:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773859384;
 bh=UYw2Q5vPynmZ8IsRFlBFNocCRgzUvdsH0CMtqKUoRT0=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=g7LIdIOq9W+LUiwk//Lz2dBxExMGU81mRP9l+OJpyGitIEN+tAex7WaU4umMEws5p
 O13ATZbGGSYkOPdPg57Rhaoxkmh4AOz+K3/u4DfYWL67DOsScvc4n2KNeMTuDTWfN6
 2eaQp9XgkwGdV+0YZ4ZEDDPR6N+lCxcZPvgobYAovcmOJk6X+UKfYJTzIVMZlsFlkE
 ttGAYEMgmc4w2g1Lf1ko0fTOgcvyybxvHpMP5EF0RvfJUmBkEZ9dA9KscSUURuB3O4
 J47/iXsS92jaMePK42pC9m3EHUrB/Ahy9B8yn5xUcHkV9qIUd0UzPjDpAkCbCNkxPW
 nSsqHYmWTiPLg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation Discovery
 output
Date: Wed, 18 Mar 2026 11:42:56 -0700
Message-Id: <20260318184256.3680349-3-dave@stgolabs.net>
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

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 71a012121c87..90540f59dedd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2593,7 +2593,10 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
     } QEMU_PACKED *media_op_in_disc_pl = (void *)payload_in;
     struct media_op_discovery_out_pl *media_out_pl =
         (struct media_op_discovery_out_pl *)payload_out;
-    int total = ARRAY_SIZE(media_op_matrix);
+    /*
+     * Per Table 8-331, the returned list excludes Discovery (entry 0).
+     */
+    int total = ARRAY_SIZE(media_op_matrix) - 1;
     int num_ops, start_index, i;
     int count = 0;
 
@@ -2619,10 +2622,12 @@ static CXLRetCode media_operations_discovery(uint8_t *payload_in,
 
     num_ops = MIN(num_ops, total - start_index);
     for (i = 0; i < num_ops; i++) {
+        int idx = start_index + i + 1; /* +1 skips Discovery at entry 0 */
+
         media_out_pl->entry[count].media_op_class =
-                media_op_matrix[start_index + i].media_op_class;
+                media_op_matrix[idx].media_op_class;
         media_out_pl->entry[count].media_op_subclass =
-                    media_op_matrix[start_index + i].media_op_subclass;
+                    media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.39.5


