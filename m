Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593ACD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 05:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waRuM-0005Xc-6R; Fri, 19 Jun 2026 01:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRuH-0005Wt-O4
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1waRuF-0003Gu-UM
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 01:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781847403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WTFD6r5+wM+NXRvQowKZ30Avvw7E0gKC4ERV2hOG6HA=;
 b=JOz8aF/SvmbTdqHyamxegnrVvsL6jHoVuEH1s5FjMGlDim9/gHfOF74BjNjiU0s0x3GT8L
 MUH7Zreui+G62xBel8iI7xgyvLe9Z1Cf0+kv/Wg6rqU9wLL4ZGkRvVHNQ9b2lT+IEHxcTy
 BIAzYaM1iCXVS37CUgIem6bD2SUj0Jw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-apprc6jNNmO9Nx4lDBu9Tw-1; Fri,
 19 Jun 2026 01:36:39 -0400
X-MC-Unique: apprc6jNNmO9Nx4lDBu9Tw-1
X-Mimecast-MFC-AGG-ID: apprc6jNNmO9Nx4lDBu9Tw_1781847398
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D76751805A1E; Fri, 19 Jun 2026 05:36:37 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.redhat.corp
 (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84C8C180058F; Fri, 19 Jun 2026 05:36:35 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 3/3] hw/core/platform-bus: guard
 platform_bus_get_mmio_addr() against NULL
Date: Fri, 19 Jun 2026 11:06:23 +0530
Message-ID: <20260619053623.756021-4-mbawa@redhat.com>
In-Reply-To: <20260619053623.756021-1-mbawa@redhat.com>
References: <20260619053623.756021-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

sysbus_mmio_get_region() returns NULL when a device has fewer MMIO
regions than the requested slot index.  platform_bus_get_mmio_addr()
passes the result directly to memory_region_is_mapped() without a
NULL check, causing a SIGSEGV.

Return -1 early when the region pointer is NULL, consistent with the
existing "not mapped" path.

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


