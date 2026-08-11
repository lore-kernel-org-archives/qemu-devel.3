Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F505C5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNd-0000ga-Ld; Tue, 11 Aug 2026 12:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN7-00085X-DP
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN4-0000bS-Nz
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3iBsmncndZX3hlxtfnYzg6iigcXfUFrsWsFn7YPpJh4=;
 b=Fx/im03Oa0vJyCQNsDAvh7UqcSUmaQyG5FhBvvdJOH9DqKkI+38REqqNUUIADTvNDPHjYp
 UZJabY3XrtphNSLbHkDf8ItTfCxiqQAq3OxvEc+RrQWtfV3mRWDu0faJml/jy/ASQXSwQ6
 zXG5DwkCipTGGv56n3AhVjGIH6IzgF8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-woJd2kGRPfS6O3dRKNiorA-1; Tue,
 11 Aug 2026 12:30:32 -0400
X-MC-Unique: woJd2kGRPfS6O3dRKNiorA-1
X-Mimecast-MFC-AGG-ID: woJd2kGRPfS6O3dRKNiorA_1786465831
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66E4B19560B2; Tue, 11 Aug 2026 16:30:31 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A3AB195DF98; Tue, 11 Aug 2026 16:30:29 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/83] hw/arm/aspeed_ast27x0: Pass realized PSP SoC to SSP/TSP
 initialization
Date: Tue, 11 Aug 2026 18:28:37 +0200
Message-ID: <20260811162938.1403216-23-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Pass the realized PSP SoC to the SSP/TSP initialization helpers instead
of retrieving it from the MachineState.

This makes the dependency explicit, since the SSP and TSP coprocessors
use resources owned by the PSP SoC, including the UARTs, SRAM, SCU and
SCUIO. The PSP SoC must therefore be realized before the coprocessors
are initialized.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0-fc.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 8d49bb95d67b..58d0b4d7cd59 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -134,11 +134,9 @@ static bool ast2700fc_ca35_init(MachineState *machine, Error **errp)
     return true;
 }
 
-static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
+static bool ast2700fc_ssp_init(Ast2700FCState *s, AspeedSoCState *psp,
+                               Error **errp)
 {
-    Ast2700FCState *s = AST2700FC(machine);
-    AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
-
     s->ssp_sysclk = clock_new(OBJECT(s), "SSP_SYSCLK");
     clock_set_hz(s->ssp_sysclk, 200000000ULL);
 
@@ -166,11 +164,9 @@ static bool ast2700fc_ssp_init(MachineState *machine, Error **errp)
     return true;
 }
 
-static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
+static bool ast2700fc_tsp_init(Ast2700FCState *s, AspeedSoCState *psp,
+                               Error **errp)
 {
-    Ast2700FCState *s = AST2700FC(machine);
-    AspeedSoCState *psp = ASPEED_SOC(&s->ca35);
-
     s->tsp_sysclk = clock_new(OBJECT(s), "TSP_SYSCLK");
     clock_set_hz(s->tsp_sysclk, 200000000ULL);
 
@@ -200,9 +196,19 @@ static bool ast2700fc_tsp_init(MachineState *machine, Error **errp)
 
 static void ast2700fc_init(MachineState *machine)
 {
+    Ast2700FCState *s = AST2700FC(machine);
+    AspeedSoCState *psp;
+
     ast2700fc_ca35_init(machine, &error_abort);
-    ast2700fc_ssp_init(machine, &error_abort);
-    ast2700fc_tsp_init(machine, &error_abort);
+
+    /*
+     * SSP and TSP use resources owned by the PSP SoC, such as UART,
+     * SRAM, SCU and SCUIO.  Therefore the PSP SoC must be realized
+     * before the coprocessors are initialized.
+     */
+    psp = ASPEED_SOC(&s->ca35);
+    ast2700fc_ssp_init(s, psp, &error_abort);
+    ast2700fc_tsp_init(s, psp, &error_abort);
 }
 
 static void ast2700fc_class_init(ObjectClass *oc, const void *data)
-- 
2.55.0


