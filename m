Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AEFCC83030
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbvV-0006YC-9Q; Fri, 04 Jul 2025 04:37:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvS-0006Wg-6f
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvQ-0004La-Ic
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sWr81vkL5T7DDDCC7TyKIQDpax0Lrf+zBaTUE1REbDA=;
 b=DU6qX/ppZdZEQ5+3uR/500VPvTQycUX5/Y681i0i6qTwx2soOSWl1d2gYw6aVl4hc44SIT
 t1tmn8JHA91lHNlwfrkyFfzsg+p8SFrnhBAkjEMpxwa1lMRT+0nEH+0zamB2Yv24sEvsQL
 XId+fmMcO9/Kg7WI0YqMqgbBm9jXuKE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-vjlii2tUNz6fEWfFH0G-SQ-1; Fri,
 04 Jul 2025 04:37:38 -0400
X-MC-Unique: vjlii2tUNz6fEWfFH0G-SQ-1
X-Mimecast-MFC-AGG-ID: vjlii2tUNz6fEWfFH0G-SQ_1751618257
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C14D1801207; Fri,  4 Jul 2025 08:37:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95F58180045C; Fri,  4 Jul 2025 08:37:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/11] hw/misc/aspeed_sdmc: Skipping dram_init in u-boot for
 AST2700
Date: Fri,  4 Jul 2025 10:37:13 +0200
Message-ID: <20250704083723.1410455-2-clg@redhat.com>
In-Reply-To: <20250704083723.1410455-1-clg@redhat.com>
References: <20250704083723.1410455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

On AST2700 SoC, QEMU now sets BIT6 in VGA0 SCRATCH register to indicate
that DDR training has completed, thus skipping the dram_init().

To align with the recent U-Boot changes, where the Main Control Register's
BIT16 is checked to skip the dram_init() process, this patch sets BIT16 in
the SDMC Main Control Register at reset time.

This allows both the main U-Boot stage to correctly detect and bypass DRAM
initialization when running under QEMU.

Reference:
- QEMU: https://github.com/qemu/qemu/commit/2d082fea485ee455a70ed3e963cdf9a70f34858a
- U-Boot: https://github.com/AspeedTech-BMC/u-boot/commit/94e5435504fb0d8888f5c1bfd3fa284cdd6aaf9b

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250618080006.846355-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_sdmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f04d9930dd79..dff7cc362d32 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -570,6 +570,9 @@ static void aspeed_2700_sdmc_reset(DeviceState *dev)
     /* Set ram size bit and defaults values */
     s->regs[R_MAIN_CONF] = asc->compute_conf(s, 0);
 
+    /* Skipping dram init */
+    s->regs[R_MAIN_CONTROL] = BIT(16);
+
     if (s->unlocked) {
         s->regs[R_2700_PROT] = PROT_UNLOCKED;
     }
-- 
2.50.0


