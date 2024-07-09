Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E1C3DA47
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 11:52:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sR9Ou-0000iN-LI; Tue, 09 Jul 2024 07:52:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Ot-0000Vl-CT
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sR9Oo-0006WX-48
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 07:52:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720525962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dEDuTv8Lc1Ps4eGjmhzrrf4rkRo15i2vTl21HQehUUo=;
 b=gl+E5jDbSDg8yEm0GOV7tCLdTM8qI8WKo3pn2tgDsQe9iKhwOtGIb8GnBE3mvFW09YFAQh
 k+X+LYqjt7bkH5YBdIt1bBfxLWVwWi++wIO53LvIqdTUIuANNxpkTjQZW6H9wFrOIMLY5T
 zkO2nzzclNcJ5YV896P00aQZrXo0rzE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-YLozJ8FFN8G1G4rbod1jaQ-1; Tue,
 09 Jul 2024 07:52:41 -0400
X-MC-Unique: YLozJ8FFN8G1G4rbod1jaQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 553A61956048; Tue,  9 Jul 2024 11:52:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 947423000181; Tue,  9 Jul 2024 11:52:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/8] hw/net:ftgmac100: update memory region size to 64KB
Date: Tue,  9 Jul 2024 13:52:21 +0200
Message-ID: <20240709115228.798904-2-clg@redhat.com>
In-Reply-To: <20240709115228.798904-1-clg@redhat.com>
References: <20240709115228.798904-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

According to the datasheet of ASPEED SOCs,
one MAC controller owns 128KB of register space for AST2500.
However, one MAC controller only owns 64KB of register space for AST2600
and AST2700. It set the memory region size 128KB and it occupied another
controllers Address Spaces.

Update one MAC controller memory region size to 0x1000
because AST2500 did not use register spaces over than 64KB.

Introduce a new container region size to 0x1000 and its range
is from 0 to 0xfff. This container is mapped a sub region
for the current set of register.
This sub region range is from 0 to 0xff.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/net/ftgmac100.h |  4 ++++
 hw/net/ftgmac100.c         | 11 ++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/ftgmac100.h b/include/hw/net/ftgmac100.h
index 765d1538a49f..269446e85838 100644
--- a/include/hw/net/ftgmac100.h
+++ b/include/hw/net/ftgmac100.h
@@ -14,6 +14,9 @@
 #define TYPE_FTGMAC100 "ftgmac100"
 OBJECT_DECLARE_SIMPLE_TYPE(FTGMAC100State, FTGMAC100)
 
+#define FTGMAC100_MEM_SIZE 0x1000
+#define FTGMAC100_REG_MEM_SIZE 0x100
+
 #include "hw/sysbus.h"
 #include "net/net.h"
 
@@ -30,6 +33,7 @@ struct FTGMAC100State {
     NICState *nic;
     NICConf conf;
     qemu_irq irq;
+    MemoryRegion iomem_container;
     MemoryRegion iomem;
 
     uint8_t frame[FTGMAC100_MAX_FRAME_SIZE];
diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 25e4c0cd5bfe..9e1f12cd331b 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1107,9 +1107,14 @@ static void ftgmac100_realize(DeviceState *dev, Error **errp)
         s->rxdes0_edorr = FTGMAC100_RXDES0_EDORR;
     }
 
-    memory_region_init_io(&s->iomem, OBJECT(dev), &ftgmac100_ops, s,
-                          TYPE_FTGMAC100, 0x2000);
-    sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_init(&s->iomem_container, OBJECT(s),
+                       TYPE_FTGMAC100 ".container", FTGMAC100_MEM_SIZE);
+    sysbus_init_mmio(sbd, &s->iomem_container);
+
+    memory_region_init_io(&s->iomem, OBJECT(s), &ftgmac100_ops, s,
+                          TYPE_FTGMAC100 ".regs", FTGMAC100_REG_MEM_SIZE);
+    memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
+
     sysbus_init_irq(sbd, &s->irq);
     qemu_macaddr_default_if_unset(&s->conf.macaddr);
 
-- 
2.45.2


