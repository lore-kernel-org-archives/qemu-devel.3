Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39681E67800
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 14:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7FIU-0001Zt-7z; Sat, 02 Nov 2024 10:40:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7FIR-0001ZT-Gt
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 10:40:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7FIO-0007F4-Nz
 for qemu-devel@nongnu.org; Sat, 02 Nov 2024 10:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730558405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8MbxtM9zKtquGKObGbaLz0NeOQN2pH32upqIbkhv+60=;
 b=XHFx9ru88VAsT4B46VI992XL/6aJLwFbLBfH3qMHEBlbDDbYqF5uZ9OmirSaaqtreTxeaN
 8aNunMHna5Ze/JZ+3yAGvOCtrZ9IkI43W8CAPZuMHeGzp0A9R2M5q1xvyI6Ngs5c5+2go0
 b/OkTC3JFZXe+Neqw+VU4a7zPn2iifg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-527-QJTKwB_KMgWO6tAURxTt-A-1; Sat,
 02 Nov 2024 10:40:02 -0400
X-MC-Unique: QJTKwB_KMgWO6tAURxTt-A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5B7F5195608A; Sat,  2 Nov 2024 14:39:54 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.193.155])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 542A21956086; Sat,  2 Nov 2024 14:39:45 +0000 (UTC)
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
Subject: [PATCH] aspeed: Don't set always boot properties of the emmc device
Date: Sat,  2 Nov 2024 15:39:43 +0100
Message-ID: <20241102143943.1929177-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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
 hw/arm/aspeed.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index e161e6b1c582..ac6d8dde71b3 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -338,7 +338,18 @@ static void sdhci_attach_drive(SDHCIState *sdhci, DriveInfo *dinfo, bool emmc,
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
             qdev_prop_set_uint8(card, "boot-config",
                                 boot_emmc ? 0x1 << 3 : 0x0);
-- 
2.47.0


