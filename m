Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64772606A31B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2026 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e7uZ9CCG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOXEf-0001cd-QD; Wed, 04 Nov 2026 04:24:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEb-0001cJ-Aw
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:45 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kaloz@kernel.org>) id 1xOXEZ-0000A4-Sp
 for qemu-devel@nongnu.org; Wed, 04 Nov 2026 04:24:45 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA8D360611;
 Wed,  4 Nov 2026 09:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256741F000C1;
 Wed,  4 Nov 2026 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793784275;
 bh=BFfHK97HAZVzOVicMNjPfUhsSwp5eAIY+fq6kQMYqVU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=e7uZ9CCGKUGa2VKoHhuNkI3X9NEdz7EnWT04ipnE5jgkFp6Dzwcv38Do6r2WDK2ul
 3xjL1/GIsFB82gqYWho4DScOSVP0YbH384reWrF3NNVd5idMmLCrybjMh8DYFZ+Bda
 GJe4f9gGy+EEHe1pKAqFtri4ewFqNO+3BA6dH/zjDQAf153KNAySVsa/xS/LuVEqP5
 /7D4jM0Oe0RIDoXyyenDxpyYkiuzPYha51UCduFr1RTEIDVxShucFdgVTPOs2KJJHF
 xxvYZkp6sNTHLu6QKHPRhLgpMC7AqHxRllT5Fu3gW8G0EmZ/HXoBMSjyw0fbvkVtYg
 FuMlRBOFfUSIw==
From: Imre Kaloz <kaloz@kernel.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 1/2] hw/sparc/sun4m: End the empty slot at iommu_base
Date: Wed,  4 Nov 2026 10:23:15 +0100
Message-ID: <20261104092316.13052-2-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261104092316.13052-1-kaloz@kernel.org>
References: <20261104092316.13052-1-kaloz@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=kaloz@kernel.org;
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

Memory decode on machines without ECC ends at iommu_base, so the empty
slot for missing RAM should end there. max_mem equals iommu_base on these
machines today, so nothing changes, but a later patch lowers max_mem.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 hw/sparc/sun4m.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550acdff6d..2f4eb19f7f 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -840,10 +840,13 @@ static void sun4m_hw_init(MachineState *machine)
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0);
 
-    /* models without ECC don't trap when missing ram is accessed */
+    /*
+     * models without ECC don't trap when missing ram is accessed,
+     * up to the end of memory decode at iommu_base
+     */
     if (!hwdef->ecc_base) {
         empty_slot_init("ecc", machine->ram_size,
-                        hwdef->max_mem - machine->ram_size);
+                        hwdef->iommu_base - machine->ram_size);
     }
 
     prom_init(hwdef->slavio_base, machine->firmware);
-- 
2.47.3


