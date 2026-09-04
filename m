Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23338C61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:05:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2M6d-00019t-QY; Fri, 04 Sep 2026 01:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2M6Y-00018c-U2
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:04:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x2M6X-0007E0-HG
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:04:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788498284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3zbrrTfpNCiI80LrZY76fQiVDv/IhpMBVxNLriffQ2I=;
 b=CXNOdAAYnOipENNor+6tYbcliW9R5CpbNWR1s/LGd0zffkfIGQQzZkW0A7BG32zfCOmX+w
 b1KGBBc+ofaUTN4GteOTy+ndkKzZUQiIg+GwyWOxCe45hBMCxMqQ13IA9TMgWB+2/WvwPQ
 JNqDX/CBHImEAiy7KI/RHIPjYgH6YWs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-7iMCXGtKNCe9V1Seladm4g-1; Fri,
 04 Sep 2026 01:04:39 -0400
X-MC-Unique: 7iMCXGtKNCe9V1Seladm4g-1
X-Mimecast-MFC-AGG-ID: 7iMCXGtKNCe9V1Seladm4g_1788498278
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69262195DE63; Fri,  4 Sep 2026 05:04:37 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86F6040E; Fri,  4 Sep 2026 05:04:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, kane_chen@aspeedtech.com,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/2] hw/arm: Add /machine/labels container for Aspeed machines
Date: Fri,  4 Sep 2026 07:04:23 +0200
Message-ID: <20260904050424.4049984-2-clg@redhat.com>
In-Reply-To: <20260904050424.4049984-1-clg@redhat.com>
References: <20260904050424.4049984-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Add a DT-style alias container /machine/labels where board code registers
link<> properties pointing to well-known devices. Tests can then resolve
a device with a single QMP call (qom-get /machine/labels/<name>) instead
of walking the bus hierarchy.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
---
 include/hw/arm/aspeed.h | 12 ++++++++++++
 hw/arm/aspeed.c         | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/include/hw/arm/aspeed.h b/include/hw/arm/aspeed.h
index 245d02e5f757..0b8b40262767 100644
--- a/include/hw/arm/aspeed.h
+++ b/include/hw/arm/aspeed.h
@@ -128,4 +128,16 @@ void aspeed_machine_ast2600_class_emmc_init(ObjectClass *oc);
  */
 void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc);
 
+/*
+ * aspeed_machine_add_label:
+ * @bmc: pointer to the #AspeedMachineState.
+ * @label: the label name for the device.
+ * @target: the device object to register.
+ *
+ * Register a well-known device under /machine/labels/<label> as a
+ * read-only link.  Aborts on duplicate label names.
+ */
+void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
+                              Object *target);
+
 #endif
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 1f8d5d3e132d..79b8d55d66da 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -127,6 +127,14 @@ void aspeed_connect_serial_hds_to_uarts(AspeedMachineState *bmc)
     }
 }
 
+void aspeed_machine_add_label(AspeedMachineState *bmc, const char *label,
+                              Object *target)
+{
+    Object *labels = object_resolve_path_component(OBJECT(bmc), "labels");
+
+    object_property_add_const_link(labels, label, target);
+}
+
 static void aspeed_machine_init(MachineState *machine)
 {
     AspeedMachineState *bmc = ASPEED_MACHINE(machine);
@@ -137,6 +145,8 @@ static void aspeed_machine_init(MachineState *machine)
     DriveInfo *emmc0 = NULL;
     bool boot_emmc;
 
+    object_property_add_new_container(OBJECT(machine), "labels");
+
     bmc->soc = ASPEED_SOC(object_new(amc->soc_name));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(bmc->soc));
     object_unref(OBJECT(bmc->soc));
-- 
2.55.0


