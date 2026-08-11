Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A71BC5B572
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 16:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtpNG-0008Df-IB; Tue, 11 Aug 2026 12:30:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpN0-0007vr-I6
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wtpMx-0000XD-7f
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 12:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786465826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QPVeJDFzbHIEx+MmgXEPIRI9WYXiEhdImoywv813OGs=;
 b=hz4vhunBG3Qd1UcpCXj2x+iBZgnTrw9oijN87oPnIIEHhT0vW0wAtyDmnlkNBuMvdfJr6p
 u7N5/roF5+tIXTxjN1WC/gqZEoBRwnhu8mRSXMseniUYRJ/bveoiUP+Fkywdpvpl+5+d9U
 K6fO6veXwmz5Pr63ILHXV72LnbqBcrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-RpFL31mfPMCTUj7nKLIeuQ-1; Tue,
 11 Aug 2026 12:30:23 -0400
X-MC-Unique: RpFL31mfPMCTUj7nKLIeuQ-1
X-Mimecast-MFC-AGG-ID: RpFL31mfPMCTUj7nKLIeuQ_1786465822
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 576CE1800877; Tue, 11 Aug 2026 16:30:22 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.48.12])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9E9FD195DF98; Tue, 11 Aug 2026 16:30:20 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/83] hw/misc/aspeed_scu: Introduce Aspeed2700SCUState
Date: Tue, 11 Aug 2026 18:28:33 +0200
Message-ID: <20260811162938.1403216-19-clg@redhat.com>
In-Reply-To: <20260811162938.1403216-1-clg@redhat.com>
References: <20260811162938.1403216-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Introduce Aspeed2700SCUState as an AST2700-specific subclass of
AspeedSCUState.

Currently, AST1700 and AST2700 reuse the generic AspeedSCUState.
However, AST2700 requires SCU functionality that is specific to the
platform, particularly for interactions with its coprocessors.

Introduce a dedicated Aspeed2700SCUState to provide an extension point
for AST2700-specific functionality while keeping the generic
AspeedSCUState unchanged.

Subsequent patches will migrate AST2700 users to the new subclass and
move AST2700-specific code into it.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260717084559.3477061-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_scu.h | 5 +++++
 hw/misc/aspeed_scu.c         | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/aspeed_scu.h b/include/hw/misc/aspeed_scu.h
index c30940ab7683..904549465fd1 100644
--- a/include/hw/misc/aspeed_scu.h
+++ b/include/hw/misc/aspeed_scu.h
@@ -20,6 +20,7 @@ OBJECT_DECLARE_TYPE(AspeedSCUState, AspeedSCUClass, ASPEED_SCU)
 #define TYPE_ASPEED_2500_SCU TYPE_ASPEED_SCU "-ast2500"
 #define TYPE_ASPEED_2600_SCU TYPE_ASPEED_SCU "-ast2600"
 #define TYPE_ASPEED_2700_SCU TYPE_ASPEED_SCU "-ast2700"
+OBJECT_DECLARE_SIMPLE_TYPE(Aspeed2700SCUState, ASPEED_2700_SCU)
 #define TYPE_ASPEED_2700_SCUIO TYPE_ASPEED_SCU "io" "-ast2700"
 #define TYPE_ASPEED_1030_SCU TYPE_ASPEED_SCU "-ast1030"
 
@@ -41,6 +42,10 @@ struct AspeedSCUState {
     uint32_t hw_prot_key;
 };
 
+struct Aspeed2700SCUState {
+    AspeedSCUState parent_obj;
+};
+
 #define AST2400_A1_SILICON_REV   0x02010303U
 #define AST2500_A1_SILICON_REV   0x04010303U
 #define AST2600_A3_SILICON_REV   0x05030303U
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 5dbf81c0cec9..efe1d6315b25 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -930,6 +930,11 @@ static void aspeed_ast2700_scu_reset_hold(Object *obj, ResetType type)
     s->regs[AST2700_HW_STRAP1] = s->hw_strap1;
 }
 
+static void aspeed_2700_scu_realize(DeviceState *dev, Error **errp)
+{
+    aspeed_scu_realize(dev, errp);
+}
+
 static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -937,6 +942,7 @@ static void aspeed_2700_scu_class_init(ObjectClass *klass, const void *data)
     AspeedSCUClass *asc = ASPEED_SCU_CLASS(klass);
 
     dc->desc = "ASPEED 2700 System Control Unit";
+    dc->realize = aspeed_2700_scu_realize;
     rc->phases.hold = aspeed_ast2700_scu_reset_hold;
     asc->resets = ast2700_a0_resets;
     asc->calc_hpll = aspeed_2600_scu_calc_hpll;
@@ -1161,7 +1167,7 @@ static const TypeInfo aspeed_scu_types[] = {
     {
         .name = TYPE_ASPEED_2700_SCU,
         .parent = TYPE_ASPEED_SCU,
-        .instance_size = sizeof(AspeedSCUState),
+        .instance_size = sizeof(Aspeed2700SCUState),
         .class_init = aspeed_2700_scu_class_init,
     },
     {
-- 
2.55.0


