Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFBCEEA855
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:41:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqeQQ-0008MZ-KM; Thu, 12 Feb 2026 16:40:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQN-0008L0-Uq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqeQM-0006CD-GR
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TKYz2OOq/Yo22Lz/U0vqNR0yCFTqQBKR1flNZGBJoNM=;
 b=GoCICgEFZxxakSSII6BIJuJ+alNiUhSkEQXTBjY2FzkFTAAi3kC8P8iXQM1yiGJ6LJDD6s
 m/OuDiSqkEcyuLkn06QxBkEBAxbXkL56mug+WOH5mJGPrxVcEMgP6eTf4JthVw6VWgUfV1
 0jxW2QnW4XEKr6+T//JWtx0kCBplSUs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-91-a1cCpMhgNfeWcidFkTOfXw-1; Thu,
 12 Feb 2026 16:40:30 -0500
X-MC-Unique: a1cCpMhgNfeWcidFkTOfXw-1
X-Mimecast-MFC-AGG-ID: a1cCpMhgNfeWcidFkTOfXw_1770932429
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79C8C1955D76; Thu, 12 Feb 2026 21:40:29 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE95E180035A; Thu, 12 Feb 2026 21:40:27 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/16] hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine to
 A2 SoC
Date: Thu, 12 Feb 2026 22:39:53 +0100
Message-ID: <20260212213955.2225662-15-clg@redhat.com>
In-Reply-To: <20260212213955.2225662-1-clg@redhat.com>
References: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Update the AST2700 FC machine to use the AST2700 A2 SoC model instead of
the A1-specific variant.

This change removes A1-specific naming and definitions from the FC
machine and aligns it with the newer AST2700 A2 silicon.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260211021527.119674-10-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 0502a137f3d9..9b9bb2df7580 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -24,8 +24,8 @@
 #include "hw/arm/aspeed_coprocessor.h"
 #include "hw/arm/machines-qom.h"
 
-#define TYPE_AST2700A1FC MACHINE_TYPE_NAME("ast2700fc")
-OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700A1FC);
+#define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
+OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
 
 static struct arm_boot_info ast2700fc_board_info = {
     .board_id = -1, /* device-tree-only board */
@@ -49,7 +49,6 @@ struct Ast2700FCState {
 };
 
 #define AST2700FC_BMC_RAM_SIZE (1 * GiB)
-#define AST2700FC_CM4_DRAM_SIZE (32 * MiB)
 
 #define AST2700FC_HW_STRAP1 0x000000C0
 #define AST2700FC_HW_STRAP2 0x00000003
@@ -58,7 +57,7 @@ struct Ast2700FCState {
 
 static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 {
-    Ast2700FCState *s = AST2700A1FC(machine);
+    Ast2700FCState *s = AST2700FC(machine);
     AspeedSoCState *soc;
     AspeedSoCClass *sc;
     const char *bios_name = NULL;
@@ -66,7 +65,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     DeviceState *dev = NULL;
     uint64_t rom_size;
 
-    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a1");
+    object_initialize_child(OBJECT(s), "ca35", &s->ca35, "ast2700-a2");
     soc = ASPEED_SOC(&s->ca35);
     sc = ASPEED_SOC_GET_CLASS(soc);
 
@@ -135,7 +134,7 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 {
-    Ast2700FCState *s = AST2700A1FC(machine);
+    Ast2700FCState *s = AST2700FC(machine);
     AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
 
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
@@ -167,7 +166,7 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
 
 static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 {
-    Ast2700FCState *s = AST2700A1FC(machine);
+    Ast2700FCState *s = AST2700FC(machine);
     AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
 
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
-- 
2.53.0


