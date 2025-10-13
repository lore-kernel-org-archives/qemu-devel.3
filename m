Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AD1CCD18C
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hvs-000581-AE; Mon, 13 Oct 2025 08:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvH-0004c2-Hy
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8HvB-0007xj-GF
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SrwrWKaIS2o37Qz4VfMfpXaOvS9X4oGUK9EI9bLyxAM=;
 b=Tb3zTJ2XkxAtuEVEKrvEkIZ3wislfHhLYsq+yXMCKuCHsAYZSRto1hnBPxmDHiLaXFZ15s
 xiRfR0ON+obAs2THzIEXPK26ZtlaGKzrIAxsSpeQ6rxd61LcIRGOn524tCrWKklTXAxuxG
 PWDMeJjKe2jPGSc4Fo+tHxg5AMH3Uhw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-4wUgr6e5N_CzxqvL0IlM5w-1; Mon,
 13 Oct 2025 08:44:55 -0400
X-MC-Unique: 4wUgr6e5N_CzxqvL0IlM5w-1
X-Mimecast-MFC-AGG-ID: 4wUgr6e5N_CzxqvL0IlM5w_1760359495
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8AEA1800285; Mon, 13 Oct 2025 12:44:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66C53180141F; Mon, 13 Oct 2025 12:44:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 15/29] hw/arm/aspeed: Remove AspeedSoCClass dependency from
 aspeed_uart_last() API
Date: Mon, 13 Oct 2025 14:44:06 +0200
Message-ID: <20251013124421.71977-16-clg@redhat.com>
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

Refactor the aspeed_uart_last() helper to remove its dependency on
AspeedSoCClass and make the UART helper APIs more generic.

The function now takes uarts_base and uarts_num as integer
parameters instead of requiring a full SoC class instance.
All related call sites in aspeed.c are updated accordingly.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20251013054334.955331-3-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/arm/aspeed_soc.h | 4 ++--
 hw/arm/aspeed.c             | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index 5786fbbcbbe7..0162738f884e 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -331,9 +331,9 @@ static inline int aspeed_uart_first(int uarts_base)
     return aspeed_uart_index(uarts_base);
 }
 
-static inline int aspeed_uart_last(AspeedSoCClass *sc)
+static inline int aspeed_uart_last(int uarts_base, int uarts_num)
 {
-    return aspeed_uart_first(sc->uarts_base) + sc->uarts_num - 1;
+    return aspeed_uart_first(uarts_base) + uarts_num - 1;
 }
 
 #endif /* ASPEED_SOC_H */
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 49d8debf9988..ad17471c8d61 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -1311,7 +1311,7 @@ static void aspeed_set_bmc_console(Object *obj, const char *value, Error **errp)
     AspeedSoCClass *sc = ASPEED_SOC_CLASS(object_class_by_name(amc->soc_name));
     int val;
     int uart_first = aspeed_uart_first(sc->uarts_base);
-    int uart_last = aspeed_uart_last(sc);
+    int uart_last = aspeed_uart_last(sc->uarts_base, sc->uarts_num);
 
     if (sscanf(value, "uart%u", &val) != 1) {
         error_setg(errp, "Bad value for \"uart\" property");
-- 
2.51.0


