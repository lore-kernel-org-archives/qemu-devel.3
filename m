Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F29A2FD88C6
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 22:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w05d2-0001IF-F7; Tue, 10 Mar 2026 18:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05ct-0001FJ-DH
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1w05cr-00073U-53
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 18:32:31 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 1e6f612582d8e6ea78e31b03d159c855fc7eb810e72dc882606776588dbb7e94 with SMTP id
 69b09bf51e765c4d743de419; Tue, 10 Mar 2026 22:32:21 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1773181940;
 bh=8btuivVHx9jZDLNVGpxt3hf5jtlrtv8N+0WKXP/gfAE=;
 h=X-Mailgun-Dkim:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Developer-Signature:X-Developer-Key:From:Reply-to:Subject:Date:
 Message-id:To:Cc:Mime-version:Content-type:
 Content-transfer-encoding:In-reply-to:References;
 b=Mv1DURfIFlTwuI+MjCNnj3lQyyLJvasMGQ5t9NgrWzmBIbzS7EwRDavsLv91C2Pck
 S0C9X05l72zTmZgi2/hnks5hwB+LnlyUp5GW8d491WbeIFf26XyRgWsoSCV65EpCld
 1nIeYwoqucRO6A2Nsqv9WwqLtUee//Pffnfs88CGVLY+LbKUipDjEjG+HjWwTDZuDV
 ZedrFO8T0VEYUIb1qtSvOwDjuXliwXxPLCU0SUR/sqiPJrBfKoUeGqckjV1WLBJLox
 CGDLtIX9mzHrQCcW4gPCL8lEWYGAtPd8faXuBwjV5fxPuJLzwhRi46tKDd1O8OPBUe
 cpCba2BfJyeQg==
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Date: Tue, 10 Mar 2026 17:31:45 -0500
Subject: [PATCH 05/15] hw/alpha/typhoon: Create instance_init and
 class_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-MS-Reactions: disallow
Message-Id: <20260310-qomify-alpha-v1-5-4375b00a85ff@yodel.dev>
References: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
In-Reply-To: <20260310-qomify-alpha-v1-0-4375b00a85ff@yodel.dev>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, 
 Yodel Eldar <yodel.eldar@yodel.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1970; i=yodel.eldar@yodel.dev; 
 h=from:subject:message-id;
 bh=Z7htNhCxf6/XeOs5Vmu49NibrQGy2pwcp0UfC62NjQ0=; 
 b=owGbwMvMwCU29Z3/drNU3zWMp9WSGDI3zP7oY7IrZZbfTMOfVQ8XcDDMWXtfy4hTeHP6PemjV
 n0ZrWwmHaUsDGJcDLJiiiyXz0qcdcjd3ZW28sd9mDmsTCBDGLg4BWAiT24wMhyzy2KrO3jLReEa
 08wcLQax2pthdXa2X5vOlYUFVryY5cbIsMtsUuO1Q1KLEl/JX/Q/LMSyUKmO20tgy5SdUs0/J6x
 dyAAA
X-Developer-Key: i=yodel.eldar@yodel.dev; a=openpgp;
 fpr=D3CD18CD406DBB8A66A9F8DF95EE4FB736654DAC
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HELO_STATIC_HOST=-0.001,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

Define the Typhoon class and instance initializers.

Add "cpu[*]" link properties in the instance_init of Typhoon.
Setting these cpu link properties will occur in a later commit.

Note: This is one step towards splitting typhoon_init() into the
instance_init and realize hooks. typhoon_init() currently takes
a fixed cpus array as a parameter; that array will be removed soon.

Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
---
 hw/alpha/typhoon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/alpha/typhoon.c b/hw/alpha/typhoon.c
index f392772500..5789829818 100644
--- a/hw/alpha/typhoon.c
+++ b/hw/alpha/typhoon.c
@@ -15,6 +15,7 @@
 #include "cpu.h"
 #include "hw/core/irq.h"
 #include "alpha_sys.h"
+#include "hw/core/qdev-properties.h"
 
 
 #define TYPE_TYPHOON_PCI_HOST_BRIDGE "typhoon-pcihost"
@@ -948,10 +949,32 @@ PCIBus *typhoon_init(MemoryRegion *ram, qemu_irq *p_isa_irq,
     return b;
 }
 
+static void typhoon_pcihost_init(Object *obj)
+{
+    TyphoonState *s = TYPHOON_PCI_HOST_BRIDGE(obj);
+
+    int i;
+    for (i = 0; i < 4; ++i) {
+        g_autofree char *name = g_strdup_printf("cpu[%d]", i);
+        object_property_add_link(obj, name,  TYPE_ALPHA_CPU,
+                                 (Object **)&s->cchip.cpu[i],
+                                 qdev_prop_allow_set_link_before_realize, 0);
+    }
+}
+
+static void typhoon_pcihost_class_init(ObjectClass *klass, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->user_creatable = false;
+}
+
 static const TypeInfo typhoon_pcihost_info = {
     .name          = TYPE_TYPHOON_PCI_HOST_BRIDGE,
     .parent        = TYPE_PCI_HOST_BRIDGE,
     .instance_size = sizeof(TyphoonState),
+    .instance_init = typhoon_pcihost_init,
+    .class_init    = typhoon_pcihost_class_init,
 };
 
 static void typhoon_iommu_memory_region_class_init(ObjectClass *klass,

-- 
2.53.0


