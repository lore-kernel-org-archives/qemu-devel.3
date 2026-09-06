Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EAAC79F8C
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GPA-00041v-G3; Sun, 06 Sep 2026 13:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GP0-0003oT-Q7
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOz-0000FD-4H
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNernrUB0JLDgmtKtMx6Ha3i+rQJKLDJjCsX63mW5v4=;
 b=GNJ4AuUSBPwdlbja+1whRzVm+RqlqKYjSyWTFn8ekDewAp2wKeQS2YJGEv3O9KzD8/kVaQ
 8MMA5BRTpSsUK98p1ElD3sOnGCoQtysfFNliySnU/uhX1KrVfILoOOATIZBZMyesI7hwRc
 XaBL2xrvw308up23jYgxRRjAC/57NqI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569--iwiHqAON36fm2wEhfodBQ-1; Sun,
 06 Sep 2026 13:11:31 -0400
X-MC-Unique: -iwiHqAON36fm2wEhfodBQ-1
X-Mimecast-MFC-AGG-ID: -iwiHqAON36fm2wEhfodBQ_1788714690
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4EC1B1801358; Sun,  6 Sep 2026 17:11:30 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E1F0B1955F06; Sun,  6 Sep 2026 17:11:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Emmanuel Blot <emmanuel.blot@free.fr>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/40] hw/arm: aspeed: guard board-local temperature-sensor
 aliases
Date: Sun,  6 Sep 2026 19:10:11 +0200
Message-ID: <20260906171021.26568-31-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Emmanuel Blot <emmanuel.blot@free.fr>

The Catalina and Fuji machines define TYPE_TMP75 (and, on Fuji,
TYPE_LM75) as local aliases of TYPE_TMP105 because no distinct model
existed. A following change adds a canonical TYPE_TMP75 to
hw/sensor/tmp105.h that would clash with these aliases.

Guard each alias with an #undef so the header definition can be
introduced without a redefinition warning, ahead of switching the boards
to the real models. No functional change.

Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260731-sanmiguel-bmc-locator-v2-6-1266926ba769@free.fr
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast2600_catalina.c | 5 +++++
 hw/arm/aspeed_ast2600_fuji.c     | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 23636ab6985e..d3cc0fc5c0ac 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -21,6 +21,11 @@
 #define CATALINA_BMC_HW_STRAP2 0x00000800
 #define CATALINA_BMC_RAM_SIZE ASPEED_RAM_SIZE(2 * GiB)
 
+/*
+ * Guard the alias against the TYPE_TMP75 that hw/sensor/tmp105.h now
+ * defines.
+ */
+#undef TYPE_TMP75
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP421 "tmp421"
 #define TYPE_DS1338 "ds1338"
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 8a87c2dbee33..6318aa606b6b 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -14,7 +14,13 @@
 #include "hw/sensor/tmp105.h"
 #include "hw/nvram/eeprom_at24c.h"
 
+/*
+ * Guard the aliases against the TYPE_TMP75 that hw/sensor/tmp105.h now defines;
+ * TYPE_LM75 is guarded too for consistency (no LM75 model exists yet).
+ */
+#undef TYPE_LM75
 #define TYPE_LM75 TYPE_TMP105
+#undef TYPE_TMP75
 #define TYPE_TMP75 TYPE_TMP105
 #define TYPE_TMP422 "tmp422"
 
-- 
2.55.0


