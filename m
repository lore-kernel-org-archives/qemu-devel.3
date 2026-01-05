Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA417C79F8C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck98-0004Jd-93; Mon, 05 Jan 2026 07:57:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck94-0004Dw-6d
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck92-000840-Hs
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ODD8+M+lXInDffmXAIyevk2C2JoBR0MtSv17yxCG0us=;
 b=YPi6xwdDRf1MtKTG1aEt1p3TOjSiKOXYPrpbd7UH8sZiDTIlCVOe7ptI6pd8MSZtl/Ot/P
 54FWKV3ottQCn08Ikvwlzy5cdKMtspTWN43PjEZoi0Wr4FwNr56SHXSV0OGdqKHo4vmnZD
 /jgcD/a0pTaWnnwO3NvQGgIjjywfJUc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-FhG-ZahnOxK5uph1xfKpeQ-1; Mon,
 05 Jan 2026 07:57:07 -0500
X-MC-Unique: FhG-ZahnOxK5uph1xfKpeQ-1
X-Mimecast-MFC-AGG-ID: FhG-ZahnOxK5uph1xfKpeQ_1767617826
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 079EF1800358; Mon,  5 Jan 2026 12:57:06 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B11919560A7; Mon,  5 Jan 2026 12:57:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Yubin Zou <yubinz@google.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/36] hw/gpio/aspeed_sgpio: Add QOM property accessors for
 SGPIO pins
Date: Mon,  5 Jan 2026 13:56:01 +0100
Message-ID: <20260105125613.622667-25-clg@redhat.com>
In-Reply-To: <20260105125613.622667-1-clg@redhat.com>
References: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Yubin Zou <yubinz@google.com>

The `aspeed_sgpio_get_pin` and `aspeed_sgpio_set_pin` functions are
implemented to get and set the level of individual SGPIO pins. These
are then exposed as boolean properties on the SGPIO device object.

Signed-off-by: Yubin Zou <yubinz@google.com>
Reviewed-by: Kane Chen <kane_chen@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20251219-aspeed-sgpio-v5-2-fd5593178144@google.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/aspeed_sgpio.c | 79 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 538fb5145c3d..cf5efa70e8d0 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -51,6 +51,8 @@ static uint64_t aspeed_sgpio_2700_read(void *opaque, hwaddr offset,
     reg = offset >> 2;
 
     switch (reg) {
+    case R_SGPIO_INT_STATUS_0 ... R_SGPIO_INT_STATUS_7:
+        break;
     case R_SGPIO_0_CONTROL ... R_SGPIO_255_CONTROL:
         value = aspeed_sgpio_2700_read_control_reg(s, reg);
         break;
@@ -82,6 +84,73 @@ static void aspeed_sgpio_2700_write(void *opaque, hwaddr offset, uint64_t data,
     }
 }
 
+static bool aspeed_sgpio_get_pin_level(AspeedSGPIOState *s, int pin)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    return value & bit_mask;
+}
+
+static void aspeed_sgpio_set_pin_level(AspeedSGPIOState *s, int pin, bool level)
+{
+    uint32_t value = s->ctrl_regs[pin >> 1];
+    bool is_input = !(pin % 2);
+    uint32_t bit_mask = 0;
+
+    if (is_input) {
+        bit_mask = SGPIO_SERIAL_IN_VAL_MASK;
+    } else {
+        bit_mask = SGPIO_SERIAL_OUT_VAL_MASK;
+    }
+
+    if (level) {
+        value |= bit_mask;
+    } else {
+        value &= ~bit_mask;
+    }
+    s->ctrl_regs[pin >> 1] = value;
+}
+
+static void aspeed_sgpio_get_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level = true;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (sscanf(name, "sgpio%03d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    level = aspeed_sgpio_get_pin_level(s, pin);
+    visit_type_bool(v, name, &level, errp);
+}
+
+static void aspeed_sgpio_set_pin(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    bool level;
+    int pin = 0xfff;
+    AspeedSGPIOState *s = ASPEED_SGPIO(obj);
+
+    if (!visit_type_bool(v, name, &level, errp)) {
+        return;
+    }
+    if (sscanf(name, "sgpio%03d", &pin) != 1) {
+        error_setg(errp, "%s: error reading %s", __func__, name);
+        return;
+    }
+    aspeed_sgpio_set_pin_level(s, pin, level);
+}
+
 static const MemoryRegionOps aspeed_sgpio_2700_ops = {
     .read       = aspeed_sgpio_2700_read,
     .write      = aspeed_sgpio_2700_write,
@@ -105,6 +174,15 @@ static void aspeed_sgpio_realize(DeviceState *dev, Error **errp)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
+static void aspeed_sgpio_init(Object *obj)
+{
+    for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR * 2; i++) {
+        g_autofree char *name = g_strdup_printf("sgpio%03d", i);
+        object_property_add(obj, name, "bool", aspeed_sgpio_get_pin,
+                            aspeed_sgpio_set_pin, NULL, NULL);
+    }
+}
+
 static void aspeed_sgpio_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -134,6 +212,7 @@ static const TypeInfo aspeed_sgpio_ast2700_info = {
     .name           = TYPE_ASPEED_SGPIO "-ast2700",
     .parent         = TYPE_ASPEED_SGPIO,
     .class_init     = aspeed_sgpio_2700_class_init,
+    .instance_init  = aspeed_sgpio_init,
 };
 
 static void aspeed_sgpio_register_types(void)
-- 
2.52.0


