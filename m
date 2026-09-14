Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A87C88E6F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6CLf-0003ka-Lf; Mon, 14 Sep 2026 15:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CL9-0003Pg-Lq; Mon, 14 Sep 2026 15:27:45 -0400
Received: from smtp-out-1.univ-lille.fr ([194.254.129.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gilles.grimaud@univ-lille.fr>)
 id 1x6CL8-0002v5-2o; Mon, 14 Sep 2026 15:27:43 -0400
Received: from smtp01.univ-lille.fr (smtp01.univ-lille.fr [194.254.129.95])
 by smtp-out-1.univ-lille.fr (Postfix) with ESMTPS id 4hkFXn2gHzzBqZm;
 Mon, 14 Sep 2026 21:27:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=univ-lille.fr;
 s=dkim; t=1789414057;
 bh=w/UqNADqql0RoxyJa098KiPcHZjY4lX1ptO9zRQpReo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=TMtyE9AYLIsSDiLPJkHseJNDf5qkcWOScOvBYqYI7EbJaIohcjR4WX1BrZszYIp5N
 AbkFqKl/svI3MPpPrXAD1k5fZNWzsNHbHjSGGs1n+b52/xfclNrqimxtxM0NBM0/t3
 ap4cBqRTKuoRFM4N7mqwZ5nLMPDsjTMy4q2iiEVPvFbydzd1tf1wPseuQ63VqrJyYG
 oE7rLoqb7X7a+wq+yqAMWVW5YphrYJaPBHZgUSY2zLG56BU4TN2piMiWIcq8tb4oJP
 extOaGMlxvn38WNNyAnex4+lR4wn4SLhC3LLgLHcpRdq40XnDH8T+HS67TRTXIjS8t
 LOFZf+4pRh8YA==
Received: from mac.home (lfbn-lil-1-243-101.w90-45.abo.wanadoo.fr
 [90.45.87.101]) (Authenticated sender: gilles.grimaud)
 by smtp01.univ-lille.fr (Postfix) with ESMTPSA id 4hkFXn1GY0z801c;
 Mon, 14 Sep 2026 21:27:37 +0200 (CEST)
From: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org,
	alex.bennee@linaro.org
Subject: [RFC PATCH v1 4/6] target/arm: MPU_RASR: mask TEX bits for Armv6-M
Date: Mon, 14 Sep 2026 21:23:20 +0200
Message-ID: <20260914192323.29250-5-gilles.grimaud@univ-lille.fr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
References: <20260914192323.29250-1-gilles.grimaud@univ-lille.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=194.254.129.82;
 envelope-from=gilles.grimaud@univ-lille.fr; helo=smtp-out-1.univ-lille.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Keep the existing mask (0x173f) for CPUs with ARM_FEATURE_V7, and use a
mask that excludes TEX (0x1707) for Armv6-M. PMSAv8 is handled by the
earlier branch and is unaffected by this change.

After writing MPU_RASR on an Armv6-M CPU a subsequent read returns zero
for the TEX bits; Armv7-M behaviour remains unchanged.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
---
 hw/intc/armv7m_nvic.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 51d3dba852..4136c91f23 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1996,7 +1996,12 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,
         }
 
         cpu->env.pmsav7.drsr[region] = value & 0xff3f;
-        cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x173f;
+        } else {
+            /* Armv6-M has XN, AP, S, C and B, but no TEX field. */
+            cpu->env.pmsav7.dracr[region] = (value >> 16) & 0x1707;
+        }
         tlb_flush(CPU(cpu));
         break;
     }
-- 
2.55.0


