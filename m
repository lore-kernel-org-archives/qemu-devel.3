Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ADE5CCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:48:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvp-00051F-JK; Mon, 13 Oct 2025 08:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvG-0004bB-Si
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hv9-0007xC-Ls
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ndGAITILTBfTxJbWiNsuyE3u127Ud0cKP6n5GASFFH4=;
 b=ZP/AeMUSvXDCl/Q5JG74bHbDD5PSlD0VkRf+UkKmlKFj8VB6I+11yDMH9IgIaWh74Xy1k8
 +NSPJCObhgM5JcYBZbEJKpE4k/0spSjjT+pD0XD43w24vXyGO8iQBkwGIowW35v5lb69oL
 FrO+D5gw2qKlT8jWZqhHYb/KNeZ4KYQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-1LmrVFt0Na6gjZ5cZeTeng-1; Mon,
 13 Oct 2025 08:44:53 -0400
X-MC-Unique: 1LmrVFt0Na6gjZ5cZeTeng-1
X-Mimecast-MFC-AGG-ID: 1LmrVFt0Na6gjZ5cZeTeng_1760359493
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E941619560B2; Mon, 13 Oct 2025 12:44:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75B1E180141C; Mon, 13 Oct 2025 12:44:51 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 14/29] hw/arm/aspeed: Remove AspeedSoCState dependency from
 aspeed_uart_first() API
Date: Mon, 13 Oct 2025 14:44:05 +0200
Message-ID: <20251013124421.71977-15-clg@redhat.com>
In-Reply-To: <20251013124421.71977-1-clg@redhat.com>
References: <20251013124421.71977-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Refactor the aspeed_uart_first() helper to remove its dependency on
AspeedSoCState and make the UART helper APIs more generic.

The function now takes uarts_base as an integer parameter instead of
requiring a full SoC class instance. Corresponding call sites in
aspeed.c and aspeed_soc_common.c are updated accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 6 +++---
 hw/arm/aspeed.c             | 2 +-
 hw/arm/aspeed_soc_common.c  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ed32efb543f4..5786fbbcbbe7 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -326,14 +326,14 @@ static inline int aspeed_uart_index(int uart_dev)
     return uart_dev - ASPEED_DEV_UART0;
 }
 
-static inline int aspeed_uart_first(AspeedSoCClass *sc)
+static inline int aspeed_uart_first(int uarts_base)
 {
-    return aspeed_uart_index(sc->uarts_base);
+    return aspeed_uart_index(uarts_base);
 }
 
 static inline int aspeed_uart_last(AspeedSoCClass *sc)
 {
-    return aspeed_uart_first(sc) + sc->uarts_num - 1;
+    return aspeed_uart_first(sc->uarts_base) + sc->uarts_num - 1;
 }
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e73185eeb35c..49d8debf9988 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1310,7 +1310,7 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     AspeedMachineClass *amc = ASPEED_MACHINE_GET_CLASS(bmc);
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
     int val;
-    int uart_first = aspeed_uart_first(sc);
+    int uart_first = aspeed_uart_first(sc->uarts_base);
     int uart_last = aspeed_uart_last(sc);
 
     if (sscanf(value, "uart%u", &val) != 1) {
diff --git a/hw/arm/aspeed_soc_common.c b/hw/arm/aspeed_soc_common.c
index bc70e864fba7..a4e74acdce77 100644
--- a/hw/arm/aspeed_soc_common.c
+++ b/hw/arm/aspeed_soc_common.c
@@ -62,7 +62,7 @@ bool aspeed_soc_uart_realize(AspeedSoCState *s, Error **errp)
 void aspeed_soc_uart_set_chr(AspeedSoCState *s, int dev, Chardev *chr)
 {
     AspeedSoCClass *sc = ASPEED_SOC_GET_CLASS(s);
-    int uart_first = aspeed_uart_first(sc);
+    int uart_first = aspeed_uart_first(sc->uarts_base);
     int uart_index = aspeed_uart_index(dev);
     int i = uart_index - uart_first;
 
-- 
2.51.0


