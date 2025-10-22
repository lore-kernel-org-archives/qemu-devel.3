Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA78ACCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXz0-0001GB-Us; Wed, 22 Oct 2025 08:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyx-0001Cu-0e
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyu-0008NN-4Z
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nAgQ1I7e4bYUpQNPSKgwIRQqQ39LlJBUSouGvNb4faE=;
 b=KFZgmDiFMBFArl+egti0y57TdYNfpBBVEShQ6luyiDudUuta3sWk01OJwgISd3uwoUG37U
 3rZeE2V13pM2S6+IKFbZWqIhVlN5qGveUjfW3+K/V7LLztCAgLKIyvtmHTptGRM6xmJg4f
 qJ+NRuHpaUcd9GlkxSXIRanggm7GYt8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-HjHAZ_GiM-mfoy2aTouE5Q-1; Wed,
 22 Oct 2025 08:30:12 -0400
X-MC-Unique: HjHAZ_GiM-mfoy2aTouE5Q-1
X-Mimecast-MFC-AGG-ID: HjHAZ_GiM-mfoy2aTouE5Q_1761136211
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F271180899B; Wed, 22 Oct 2025 12:30:11 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2920180057E; Wed, 22 Oct 2025 12:30:09 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/16] hw/arm/ast27x0: Add SRAM link and alias mapping for TSP
 coprocessor
Date: Wed, 22 Oct 2025 14:29:41 +0200
Message-ID: <20251022122953.877335-5-clg@redhat.com>
In-Reply-To: <20251022122953.877335-1-clg@redhat.com>
References: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

AST2700 has a 128KB SRAM, physically mapped at 0x10000000–0x1001FFFF for
the PSP (CA35) processor. The TSP coprocessor shares this same SRAM but
accesses it through a different address window at 0x70000000–0x7001FFFF.

To model this shared-memory behavior in QEMU, this commit introduces a
linked SRAM property and alias mapping between the PSP and TSP subsystems.

Changes include:
- Add the SRAM alias mapping at 0x70000000 in aspeed_ast27x0-tsp.c.
- In aspeed_ast27x0-fc.c, connect the TSP coprocessor’s "sram" link to
  the PSP’s SRAM region.
- Ensure the alias region is initialized during TSP SoC realization so
  the TSP can correctly access shared SRAM through its own address space.

This ensures that the TSP and PSP share the same physical SRAM backing.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251015062210.3128710-5-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c  | 4 ++++
 hw/arm/aspeed_ast27x0-tsp.c | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 25e668a648fa..dfac7d1e17b8 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -150,6 +150,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     AspeedCoprocessorState *soc;
     AspeedCoprocessorClass *sc;
     Ast2700FCState *s = AST2700A1FC(machine);
+    AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
+
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
 
@@ -166,6 +168,8 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
     sc = ASPEED_COPROCESSOR_GET_CLASS(soc);
     aspeed_soc_uart_set_chr(soc->uart, ASPEED_DEV_UART7, sc->uarts_base,
                             sc->uarts_num, serial_hd(2));
+    object_property_set_link(OBJECT(&s->tsp), "sram",
+                             OBJECT(&psp->sram), &error_abort);
     if (!qdev_realize(DEVICE(&s->tsp), NULL, errp)) {
         return false;
     }
diff --git a/hw/arm/aspeed_ast27x0-tsp.c b/hw/arm/aspeed_ast27x0-tsp.c
index caeb3392a8e6..56b68adf541b 100644
--- a/hw/arm/aspeed_ast27x0-tsp.c
+++ b/hw/arm/aspeed_ast27x0-tsp.c
@@ -20,6 +20,7 @@
 
 static const hwaddr aspeed_soc_ast27x0tsp_memmap[] = {
     [ASPEED_DEV_SDRAM]     =  0x00000000,
+    [ASPEED_DEV_SRAM]      =  0x70000000,
     [ASPEED_DEV_INTC]      =  0x72100000,
     [ASPEED_DEV_SCU]       =  0x72C02000,
     [ASPEED_DEV_SCUIO]     =  0x74C02000,
@@ -195,6 +196,12 @@ static void aspeed_soc_ast27x0tsp_realize(DeviceState *dev_soc, Error **errp)
                                 sc->memmap[ASPEED_DEV_SDRAM],
                                 &s->sdram);
 
+    /* SRAM */
+    memory_region_init_alias(&s->sram_alias, OBJECT(s), "sram.alias",
+                             s->sram, 0, memory_region_size(s->sram));
+    memory_region_add_subregion(s->memory, sc->memmap[ASPEED_DEV_SRAM],
+                                &s->sram_alias);
+
     /* SCU */
     if (!sysbus_realize(SYS_BUS_DEVICE(&s->scu), errp)) {
         return;
-- 
2.51.0


