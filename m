Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21589CD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 09:32:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waVa0-00060Z-UM; Fri, 19 Jun 2026 05:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVZr-0005zY-K2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waVZq-0003Kr-5C
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 05:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781861512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7d3hejmPS8Cty7Wq2vvEVZx9APcf+hzhdVW5f8yQ/Y=;
 b=Kb7utZkovFuuDPVXDFWovkJ9zeRtxpUVE9EF17+KfSgeDhckAP7LrBH0U/DiqdT8U3aUtQ
 FmM+iTHlgFux8gzTP9TGFM5hvQ9I+xNo3Kj2N7gDvZ8Q1UkwvF9pS/v2egoQaJQnH1w7YG
 q05WvXSv9/MKuDWb911vV6Jve+q6ioU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-odXh5Tl0Os2Cj_RzpdblTw-1; Fri,
 19 Jun 2026 05:31:50 -0400
X-MC-Unique: odXh5Tl0Os2Cj_RzpdblTw-1
X-Mimecast-MFC-AGG-ID: odXh5Tl0Os2Cj_RzpdblTw_1781861509
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43CD7195605B; Fri, 19 Jun 2026 09:31:49 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6529C1956088; Fri, 19 Jun 2026 09:31:46 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 1/3] hw/core/platform-bus: guard
 platform_bus_get_mmio_addr() against NULL
Date: Fri, 19 Jun 2026 15:01:38 +0530
Message-ID: <20260619093140.832136-2-mbawa@redhat.com>
In-Reply-To: <20260619093140.832136-1-mbawa@redhat.com>
References: <20260619093140.832136-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

sysbus_mmio_get_region() returns NULL when a device has fewer MMIO
regions than the requested slot index.  platform_bus_get_mmio_addr()
passes the result directly to memory_region_is_mapped() without a
NULL check, causing a SIGSEGV.

Return -1 early when the region pointer is NULL, consistent with the
existing "not mapped" path.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/core/platform-bus.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index a2217a2dee..16d0ecc0f3 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -59,8 +59,7 @@ hwaddr platform_bus_get_mmio_addr(PlatformBusDevice *pbus, SysBusDevice *sbdev,
     Object *pbus_mr_obj = OBJECT(pbus_mr);
     Object *parent_mr;
 
-    if (!memory_region_is_mapped(sbdev_mr)) {
-        /* Region is not mapped? */
+    if (!sbdev_mr || !memory_region_is_mapped(sbdev_mr)) {
         return -1;
     }
 
-- 
2.54.0


