Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C611077609
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2w3G-0002yr-Lh; Wed, 18 Mar 2026 14:55:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3E-0002yU-Kt
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:28 -0400
Received: from iguana.tulip.relay.mailchannels.net ([23.83.218.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1w2w3C-00070W-Qh
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 14:55:28 -0400
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id A55FB5615FA;
 Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a234.dreamhost.com
 (100-113-227-94.trex-nlb.outbound.svc.cluster.local [100.113.227.94])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 553865625C9;
 Wed, 18 Mar 2026 18:55:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
 t=1773860124;
 b=+VxWY99mYz/0NNpHxqabOxxa2eRNcw+v3I0ASqyHTIHRgzTJ5KFTCra4Jjxk8rjEFn4u11
 LqnZif0pzWQ1ngkLDEwfmIKCs6mJmwh9r6mItwAhM5wGiumU0AHsV2AL3D/eevWRDjqwMm
 NAK7KLodbeHHSQ/OAT64dxemm5JA4mNy/AcUvITJH6zrwH29U9bH43ZaRpYeTahIfT0eeq
 Al4UwY8vPpOZL3AUgPEAuewrSbbspe1NaGskfHZn/n1zsKIOJU48hmMWgdf/6siL/7Ti5z
 MYae4rwJYRqpu1Y6HZl+3xPb+w8q/FRK5WlczKhrAAFzaQITTgSlugKTYF6tjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1773860124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=/iDOI+sSh+9Yee0cSH/s/5Ywv6VbWKUUjfu46SL03Fk=;
 b=i7rcYlJADz5XgKBZGz1owolu51FFwHeeG7rshkaVF/8A3mOlXnsffIVitay4sMx/0IIHoD
 JxU8UpXuNpVyDhEdfvTC2cxdZo+4W5PmdqgFcomPmrbN5HIs6lqL751sX6r8O4p7yZwBr8
 CTnifK9Bjkyr6PnydebCDx7h0PMAhGPRBgJsWPc/NuSz68nt3Z1glBNXEBgQWemN7XTinJ
 05IUTXj1pv59P5yvW9UfOTHpXhcJH6+wyDEC4VFi6DvSty5oYhAo/eAQt/xuTdfCzR5BYe
 ijoqKUOJadezeaHvKhnZvCWcg7BE2aaMIF5n5TdqDB05RN7szzpmT8z0ahwBKA==
ARC-Authentication-Results: i=1; rspamd-6d4cb6745-2x4br;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Print-Unite: 5792d40165fcc169_1773860124576_2741740077
X-MC-Loop-Signature: 1773860124576:1920558480
X-MC-Ingress-Time: 1773860124576
Received: from pdx1-sub0-mail-a234.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.113.227.94 (trex/7.1.5); Wed, 18 Mar 2026 18:55:24 +0000
Received: from offworld.lan (unknown [76.167.199.67])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a234.dreamhost.com (Postfix) with ESMTPSA id 4fbdLg6ldRz1079;
 Wed, 18 Mar 2026 11:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1773860124;
 bh=/iDOI+sSh+9Yee0cSH/s/5Ywv6VbWKUUjfu46SL03Fk=;
 h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
 b=enaPONgh2aOjuyK00GMVXJygXsC1Cmb/e00v7i2Y2WazMTJV/Ai5X/d/DWEzU0PtG
 vtj+8PyyDYobi8taAHnN45hYEV0YxfibJ2MZy36TIrZJahpo4STQA0g51jPEY7zo3a
 6blZJhCDZnFfmZAeZcT8ebpNEEYHgMmD7d1mSwocyxM9+vul+KJI/7EUDIC9bJimnO
 NXMzRf8qQ0LkC5yrxRYrVUqyvTqgUDAqzZ/Z568dSRERDOIEkiNrR4UNOCJnQDquTj
 lR9fzNcT9uGRETa1gsK/0pRf6VYk6qqqNXthCq75zIyWww1Kdpdd+Jhgi7mrCDyeUz
 GIE3pevbMAA/g==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 2/2] hw/cxl: Exclude Discovery from Media Operation Discovery
 output
Date: Wed, 18 Mar 2026 11:55:08 -0700
Message-Id: <20260318185508.3683044-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260318185508.3683044-1-dave@stgolabs.net>
References: <20260318185508.3683044-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: softfail client-ip=23.83.218.253; envelope-from=dave@stgolabs.net;
 helo=iguana.tulip.relay.mailchannels.net
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

Per CXL 4.0 Table 8-331, the Discovery operation "returns a list of
all Media Operations that the device supports, with the exception of
the Discovery operation (Class=0, Subclass=0)."

Filter out Discovery entries when building the output list and adjust
total_supported_operations accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 71a012121c87..6932db963788 100644
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
-                    media_op_matrix[start_index + i].media_op_subclass;
+                    media_op_matrix[idx].media_op_subclass;
         count++;
     }
 
-- 
2.39.5


