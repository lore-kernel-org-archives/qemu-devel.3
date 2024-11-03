Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92556D11192
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 21:10:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7hqH-0004Qe-9m; Sun, 03 Nov 2024 16:09:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7hqG-0004QH-5Q
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 16:09:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7hqD-0007GS-JH
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 16:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730668135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=47FrWmDp2fvQtorP4IU2/OCcFoxoYcF/j8n/zVjbRsA=;
 b=dMgBTBw+Gt8A1Xp5BE3BMrJ+mH+RfmQDNJ41jZia2cyAAC56pbu8A8uqItqQmuKene4AI2
 Se8+Rt6ZNqv9Eqj+bJwg8Sq73InjETDwjLVxVkmkH8BEIFz1wuoKMZ77rY47Huxw8RUEBP
 svkNaF8E7KCQfexl+6mFfCkFtPJWCmQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-689-JA5CT5eINHmCGCWMQ99rEg-1; Sun,
 03 Nov 2024 16:08:50 -0500
X-MC-Unique: JA5CT5eINHmCGCWMQ99rEg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 291EB19560B8; Sun,  3 Nov 2024 21:08:45 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.67])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C370C300018D; Sun,  3 Nov 2024 21:08:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Jan Luebbe <jlu@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] aspeed: Don't set always boot properties of the emmc device
Date: Sun,  3 Nov 2024 22:08:29 +0100
Message-ID: <20241103210829.2307729-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Commit e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
HW strapping") added support to boot from an eMMC device by setting
the boot properties of the eMMC device. This change made the
assumption that the device always has boot areas.

However, if the machine boots from the flash device (or -kernel) and
uses an eMMC device without boot areas, support would be broken. This
impacts the ast2600-evb machine which can choose to boot from flash or
eMMC using the "boot-emmc" machine option.

To provide some flexibility for Aspeed machine users to use different
flavors of eMMC devices (with or without boot areas), do not set the
eMMC device boot properties when the machine is not configured to boot
from eMMC. However, this approach makes another assumption about eMMC
devices, namely that eMMC devices from which the machine does not boot
do not have boot areas.

A preferable alternative would be to add support for user creatable
eMMC devices and define the device boot properties on the QEMU command
line :

  -blockdev node-name=emmc0,driver=file,filename=mmc-ast2600-evb.raw \
  -device emmc,bus=sdhci-bus.2,drive=emmc0,boot-partition-size=1048576,boot-config=8

This is a global change requiring more thinking. Nevertheless, in the
case of the ast2600-evb machine booting from an eMMC device and when
default devices are created, the proposed change still makes sense
since the device is required to have boot areas.

Cc: Jan Luebbe <jlu@pengutronix.de>
Fixes: e554e45b4478 ("aspeed: Tune eMMC device properties to reflect
HW strapping")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
---

 Changes in v2:

 - Simplified "boot-config setting

 hw/arm/aspeed.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e447923536b4..6ca145362cbd 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -338,10 +338,20 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
             return;
         }
         card = qdev_new(emmc ? TYPE_EMMC : TYPE_SD_CARD);
-        if (emmc) {
+
+        /*
+         * Force the boot properties of the eMMC device only when the
+         * machine is strapped to boot from eMMC. Without these
+         * settings, the machine would not boot.
+         *
+         * This also allows the machine to use an eMMC device without
+         * boot areas when booting from the flash device (or -kernel)
+         * Ideally, the device and its properties should be defined on
+         * the command line.
+         */
+        if (emmc && boot_emmc) {
             qdev_prop_set_uint64(card, "boot-partition-size", 1 * MiB);
-            qdev_prop_set_uint8(card, "boot-config",
-                                boot_emmc ? 0x1 << 3 : 0x0);
+            qdev_prop_set_uint8(card, "boot-config", 0x1 << 3);
         }
         qdev_prop_set_drive_err(card, "drive", blk_by_legacy_dinfo(dinfo),
                                 &error_fatal);
-- 
2.47.0


