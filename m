Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E3FC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:39:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNQ-0000Kz-BC; Tue, 11 Aug 2026 12:30:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN6-00083M-2m
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN4-0000bN-FY
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6nD805QcU3lauxKFHd7JuJdIeZkv8M/07CaY9b6a0Q=;
 b=Y9UgTD/3Xni2RIdbvJJyvzCMh0nEV9E4rBNDeL26tRlsxteayWMS6KZ2f+zrrnmPkln4TT
 tM0xCc0xzYfH1AO02v06QlqStI55KW0nixGOed2brLfsooxmoXtDiKvde6PpFyxsnJOmFT
 gXbuyOZiImqzQAKW46KEDDWxIaXEJS4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-1V6YUn08MhGAQ6XK5tMeJA-1; Tue,
 11 Aug 2026 12:30:30 -0400
X-MC-Unique: 1V6YUn08MhGAQ6XK5tMeJA-1
X-Mimecast-MFC-AGG-ID: 1V6YUn08MhGAQ6XK5tMeJA_1786465829
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A1F51800637; Tue, 11 Aug 2026 16:30:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75841195DF91; Tue, 11 Aug 2026 16:30:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 21/83] hw/misc/aspeed_scu: Add separate reset handler for
 AST2700 SCUIO
Date: Tue, 11 Aug 2026 18:28:36 +0200
Message-ID: <20260811162938.1403216-22-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce a dedicated reset handler for SCUIO.

Previously, SCU and SCUIO shared the same reset handler. This no longer
fits the AST2700 design, where SCU uses the Aspeed2700SCUState subclass
and will handle coprocessor-related control in future changes.

Since these controls are defined in SCU (not SCUIO), SCU and SCUIO
should not share the same reset logic.

This change gives SCUIO its own reset handler and prepares for upcoming
SCU-specific functionality.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index efe1d6315b25..ca93c3699d81 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -1069,6 +1069,16 @@ static const uint32_t ast2700_a0_resets_io[ASPEED_AST2700_SCU_NR_REGS] = {
     [AST2700_SCUIO_FREQ_CNT_CTL]        = 0x00000080,
 };
 
+static void aspeed_ast2700_scuio_reset_hold(Object *obj, ResetType type)
+{
+    AspeedSCUState *s = ASPEED_SCU(obj);
+    AspeedSCUClass *asc = ASPEED_SCU_GET_CLASS(obj);
+
+    memcpy(s->regs, asc->resets, asc->nr_regs * 4);
+    s->regs[AST2700_SILICON_REV] = s->silicon_rev;
+    s->regs[AST2700_HW_STRAP1] = s->hw_strap1;
+}
+
 static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1076,7 +1086,7 @@ static void aspeed_2700_scuio_class_init(ObjectClass *klass, const void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit I/O";
-    rc->phases.hold = aspeed_ast2700_scu_reset_hold;
+    rc->phases.hold = aspeed_ast2700_scuio_reset_hold;
     asc->resets = ast2700_a0_resets_io;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
     asc->get_apb = aspeed_2700_scuio_get_apb_freq;
-- 
2.55.0


