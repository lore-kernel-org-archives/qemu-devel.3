Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F477C54E64
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:14:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rol4G-00034o-40; Mon, 25 Mar 2024 10:12:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol4B-00033s-M4
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rol4A-0005pe-4S
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711375965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ycGmDfvDeFicWZJFBS1f9ILM3U5NokHMksdsoOEEHJI=;
 b=QJWkHp1iyjL/HFmlFEh5WMQyrOg24uT3axpBleiGS/Iuy7s6zBTZo1xJWmn4njkCidDv14
 fJIe3byb40OeeIZf/5p8Xs7cRc9Sv340sm2By4bkhVsYUX2m4UP/AxOW22UjrBYNiaEhCT
 Vzq1b4059AU/SO/s5/70xEGvpq6oUpo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-rimA6MAfNDCyE6oL0zYbsw-1; Mon,
 25 Mar 2024 10:12:39 -0400
X-MC-Unique: rimA6MAfNDCyE6oL0zYbsw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4213E3C0C483;
 Mon, 25 Mar 2024 14:12:39 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 791A1479;
 Mon, 25 Mar 2024 14:12:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 4/9] aspeed: Make the ast2600-a3 SoC not user creatable
Date: Mon, 25 Mar 2024 15:12:05 +0100
Message-ID: <20240325141210.788356-5-thuth@redhat.com>
In-Reply-To: <20240325141210.788356-1-thuth@redhat.com>
References: <20240325141210.788356-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Cédric Le Goater <clg@redhat.com>

Aspeed SoCs are complex devices that can not be specified on the
command line. Fix that to avoid QEMU aborts.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2227
Fixes: f25c0ae1079d ("aspeed/soc: Add AST2600 support")
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240319150903.413662-1-clg@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 174be53770..31713de74a 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -656,6 +656,8 @@ static void aspeed_soc_ast2600_class_init(ObjectClass *oc, void *data)
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(oc);
 
     dc->realize      = aspeed_soc_ast2600_realize;
+    /* Reason: The Aspeed SoC can only be instantiated from a board */
+    dc->user_creatable = false;
 
     sc->name         = "ast2600-a3";
     sc->valid_cpu_types = valid_cpu_types;
-- 
2.44.0


