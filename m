Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E23DC5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNK-00005N-GY; Tue, 11 Aug 2026 12:30:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMu-0007pw-W5
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMt-0000Tp-8T
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SviGQmEnOFxa95M1RRR7BxGgoO/BWIg21BE44djhjp4=;
 b=WfJMKdwCrjwx0JUO7nXB70omm6e3gmlGuIORDo4othy4K8UQRmXttL/mPJu9NQu8kM2rLG
 4PwwGiwzQsFX+M6OPfvNLK+lmwd4vOGhJtIrURyLDNP5dOG1Y6sSllAWVvqlUxcvFzw8in
 A1UFuJt01KtaaZqj2bnDtetveFIIlKg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-T0rmoFYyOyC-fFXPrkCpPw-1; Tue,
 11 Aug 2026 12:30:08 -0400
X-MC-Unique: T0rmoFYyOyC-fFXPrkCpPw-1
X-Mimecast-MFC-AGG-ID: T0rmoFYyOyC-fFXPrkCpPw_1786465807
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE0A61956040; Tue, 11 Aug 2026 16:30:07 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 15BB5195DF91; Tue, 11 Aug 2026 16:30:05 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/83] hw/arm/aspeed_ast27x0: Set EHCI ctrldssegment-default
Date: Tue, 11 Aug 2026 18:28:26 +0200
Message-ID: <20260811162938.1403216-12-clg@redhat.com>
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

On AST2700 platforms, system DRAM is mapped above 4GB with a base
address at 0x400000000.

The Linux EHCI driver programs the segment register to zero when
64-bit addressing is supported. As a result, descriptor addresses
derived from the EHCI registers do not include the DRAM base
address.

Descriptor memory is allocated through the DMA API with a 64-bit
DMA mask, allowing descriptors to reside in DRAM above 4GB. On
AST2700, EHCI queue heads (QH) and queue element transfer
descriptors (qTD) are therefore placed at addresses starting from
0x400000000.

Set the ctrldssegment-default property to "sc->memmap[ASPEED_DEV_SDRAM] >> 32"
so the upper 32 bits of descriptor addresses are adjusted accordingly. This
allows the emulated EHCI controller to construct correct system
addresses when accessing descriptors in DRAM above 4GB.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260713032704.3583103-9-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index dddd7d21060c..0b56d2bb6704 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -870,6 +870,9 @@ static void aspeed_soc_ast2700_realize(DeviceState *dev, Error **errp)
 
     /* EHCI */
     for (i = 0; i < sc->ehcis_num; i++) {
+        object_property_set_int(OBJECT(&s->ehci[i]), "ctrldssegment-default",
+                                sc->memmap[ASPEED_DEV_SDRAM] >> 32,
+                                &error_abort);
         if (!sysbus_realize(SYS_BUS_DEVICE(&s->ehci[i]), errp)) {
             return;
         }
-- 
2.55.0


