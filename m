Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB8D9C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOL-0003Px-LM; Sun, 06 Sep 2026 13:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOK-0003Pn-DG
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOD-00004w-Bf
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4W9Uw0wDBGCWcD4nSX/roQoCQn+LXdkKvx9ioSHNXQc=;
 b=fp5kIMySKg7LHrpvPqCKEIhJE5rcate1wXv8MWIXyUMTlYdjhOR7XE5DkTsVWHOvC95sHH
 96SGmsYNJVnCOXkYcU8EPPhLIjr6tQoN+6efOhLbv4uwrnGt9yEq8YL08PqKBbB3Y4WxON
 bIsBPPRs34XSWIH4f/LzLaH+afJ/sRw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-4pE8IDPjPA6yGX7kqULMXw-1; Sun,
 06 Sep 2026 13:10:43 -0400
X-MC-Unique: 4pE8IDPjPA6yGX7kqULMXw-1
X-Mimecast-MFC-AGG-ID: 4pE8IDPjPA6yGX7kqULMXw_1788714642
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE7DC1955BD0; Sun,  6 Sep 2026 17:10:41 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA2F31955F06; Sun,  6 Sep 2026 17:10:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 06/40] hw/misc/aspeed_scu: Support the second random number
 generator
Date: Sun,  6 Sep 2026 19:09:47 +0200
Message-ID: <20260906171021.26568-7-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

Implement SCU530 and SCU534, the control and data registers of the
AST2600 second random number generator.

Per the AST2600 datasheet, only SCU530[5:0] are writable and the
read-only SCU530[31] reports that random data is valid, which is only
meaningful while SCU530[4] is set. Report it as set whenever SCU530[4]
is, and initialise SCU530 to its datasheet reset value.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Link: https://lore.kernel.org/qemu-devel/20260821080408.2503092-1-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_scu.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 1e3db6d03f91..77f9af2ae50e 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -130,6 +130,10 @@
 #define AST2600_HW_STRAP2_PROT    TO_REG(0x518)
 #define AST2600_RNG_CTRL          TO_REG(0x520)
 #define AST2600_RNG_DATA          TO_REG(0x524)
+#define AST2600_RNG2_CTRL         TO_REG(0x530)
+#define AST2600_RNG2_CTRL_MASK    0x3F
+#define AST2600_RNG2_CTRL_VLD     BIT(31)
+#define AST2600_RNG2_DATA         TO_REG(0x534)
 #define AST2600_CHIP_ID0          TO_REG(0x5B0)
 #define AST2600_CHIP_ID1          TO_REG(0x5B4)
 
@@ -679,13 +683,14 @@ static uint64_t aspeed_ast2600_scu_read(void *opaque, hwaddr offset,
         /* PLLs are always "locked" */
         return s->regs[reg] | BIT(31);
     case AST2600_RNG_DATA:
+    case AST2600_RNG2_DATA:
         /*
          * On hardware, RNG_DATA works regardless of the state of the
          * enable bit in RNG_CTRL
          *
          * TODO: Check this is true for ast2600
          */
-        s->regs[AST2600_RNG_DATA] = aspeed_scu_get_random();
+        s->regs[reg] = aspeed_scu_get_random();
         break;
     }
 
@@ -756,6 +761,7 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
         return;
 
     case AST2600_RNG_DATA:
+    case AST2600_RNG2_DATA:
     case AST2600_SILICON_REV:
     case AST2600_SILICON_REV2:
     case AST2600_CHIP_ID0:
@@ -765,6 +771,14 @@ static void aspeed_ast2600_scu_write(void *opaque, hwaddr offset,
                       "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
         return;
+    case AST2600_RNG2_CTRL:
+        data &= AST2600_RNG2_CTRL_MASK;
+        if (data & BIT(4)) {
+            data |= AST2600_RNG2_CTRL_VLD;
+        } else {
+            data &= ~AST2600_RNG2_CTRL_VLD;
+        }
+        break;
     }
 
     s->regs[reg] = data;
@@ -803,6 +817,7 @@ static const uint32_t ast2600_a3_resets[ASPEED_AST2600_SCU_NR_REGS] = {
     [AST2600_HUARTCLK]          = 0x000145C0,
     [AST2600_CHIP_ID0]          = 0x1234ABCD,
     [AST2600_CHIP_ID1]          = 0x88884444,
+    [AST2600_RNG2_CTRL]         = 0x8000000E,
 };
 
 static void aspeed_ast2600_scu_reset_hold(Object *obj, ResetType type)
@@ -1123,6 +1138,7 @@ static void aspeed_ast1030_scu_reset_hold(Object *obj, ResetType type)
     s->regs[AST2600_HW_STRAP1] = s->hw_strap1;
     s->regs[AST2600_HW_STRAP2] = s->hw_strap2;
     s->regs[PROT_KEY] = s->hw_prot_key;
+    s->regs[AST2600_RNG2_CTRL] = 0x8000000E;
 }
 
 static void aspeed_1030_scu_class_init(ObjectClass *klass, const void *data)
-- 
2.55.0


