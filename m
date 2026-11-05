Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECB606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owAJgG7h
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP5zt-00049U-6j; Thu, 05 Nov 2026 17:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zc-00047U-IM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:42 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xP5zb-0002KT-1S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 17:31:36 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85690600C8;
 Thu,  5 Nov 2026 22:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328921F0089F;
 Thu,  5 Nov 2026 22:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793917893;
 bh=mm2CYRxMsInl+GVTZGW1+/ZurMr4oEaYdmz+xvIUU6Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=owAJgG7hjnCdOLe8GOxCZtbdnGA5Y18tOTA+HPjEYRfR2C+S1rscRV/3+8CY6W28e
 WSwBhJ+8POHPHAo1Yy2GugyxImNLs7JulwFgRjDFY/OYaVIIAHdEgJ60I6Dvof38LN
 kW1HmpZnOXL13GKxlhN3bq9NDmKD5qLLN0s1AWq1b9AFIA3fRV4Y0B0Mz6x/Np0gqp
 hNhekXDXd4XjkUvSpw6EKal50UrmzjO5SqMzxjgDUfjEWCG8JPwGPdGQJTFJBdkwJN
 MBwtjDTPwlJ61vQm+cvR7QL+BtxGukhy7ShX+smO556BbqINYv/nDekfDjQDAOTTQP
 Gdp4aRKGymmpg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Keith Monahan <keith@techtravels.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL v2 5/8] i82596: Initialize variables at chip reset
Date: Thu,  5 Nov 2026 23:31:19 +0100
Message-ID: <20261105223122.8729-6-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105223122.8729-1-deller@kernel.org>
References: <20261105223122.8729-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Helge Deller <deller@gmx.de>

Do proper initialization of various pointers and register values at chip
reset and add a timer to trigger delivery retry when the RX ring is
full.

Noticed-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 hw/net/i82596.c | 7 +++++++
 hw/net/i82596.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index a518aa7696..35e0b58330 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -359,6 +359,13 @@ static void i82596_s_reset(I82596State *s)
     s->last_tx_len = 0;
 
     s->last_good_rfa = 0;
+    s->rbd_p = I596_NULL;
+    s->rx_take_el = false;
+    s->rfd_p = I596_NULL;
+    s->rx_hold_start = 0;
+    if (s->rx_retry_timer) {
+        timer_del(s->rx_retry_timer);
+    }
     s->queue_head = 0;
     s->queue_tail = 0;
     s->queue_count = 0;
diff --git a/hw/net/i82596.h b/hw/net/i82596.h
index ec0b6a75ba..15370837cd 100644
--- a/hw/net/i82596.h
+++ b/hw/net/i82596.h
@@ -25,6 +25,7 @@ struct I82596State_st {
     NICState *nic;
     NICConf conf;
     QEMUTimer *flush_queue_timer;
+    QEMUTimer *rx_retry_timer;  /* retries delivery while the RX ring is full */
     uint8_t mode;
 
     QEMUTimer *throttle_timer;
@@ -78,6 +79,7 @@ struct I82596State_st {
     uint32_t rbd_p;         /* next free RBD, loaded from the first RFD at RU start */
     bool rx_take_el;        /* hold timed out: fill the EL RBD like the chip does */
     uint32_t rfd_p;         /* next RFD, loaded from the SCB at RU start */
+    int64_t rx_hold_start;  /* frames held since (virtual ns), 0 if not */
     uint8_t packet_queue[PACKET_QUEUE_SIZE][PKT_BUF_SZ];
     size_t packet_queue_len[PACKET_QUEUE_SIZE];
     int queue_head;
-- 
2.54.0


