Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E141C28B30
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH4L-0007UE-J0; Sun, 09 Mar 2025 09:51:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4H-0007Sl-3V
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4F-00023d-BX
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JwFxSyWTITBoQgA4dZTSfBimbMefFeDdtwL7om0gW0g=;
 b=FWC2Lu8DOpbPmpmvO/9lpp79qrjct3D8MxsHgcraFW3Z6Hng8BehbsT+7QpEiaQG1kfYYS
 oXci3WFEAAvjwJy1EMU2hW9zfgMJUb889QZudDeVW4LJQOkrG+ecO9K/rHo5GE5WhX6gTk
 AET2OUl/0EXTkq0mAcAwsLPc+X5nmkw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-1b7nSySPOsWhCirGMJ2GpQ-1; Sun,
 09 Mar 2025 09:51:43 -0400
X-MC-Unique: 1b7nSySPOsWhCirGMJ2GpQ-1
X-Mimecast-MFC-AGG-ID: 1b7nSySPOsWhCirGMJ2GpQ_1741528302
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B470F1801A07; Sun,  9 Mar 2025 13:51:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 14D631956094; Sun,  9 Mar 2025 13:51:39 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 02/46] tests/functional: Update OpenBMC image of palmetto
 machine
Date: Sun,  9 Mar 2025 14:50:46 +0100
Message-ID: <20250309135130.545764-3-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Use the new do_test_arm_aspeed_openbmc() routine to run the latest
OpenBMC firmware build of the palmetto BMC.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250129071820.1258133-3-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/test_arm_aspeed_palmetto.py | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/test_arm_aspeed_palmetto.py
index 6588c02aad79..35d832bc98ec 100755
--- a/tests/functional/test_arm_aspeed_palmetto.py
+++ b/tests/functional/test_arm_aspeed_palmetto.py
@@ -7,18 +7,19 @@
 from qemu_test import Asset
 from aspeed import AspeedTest
 
+
 class PalmettoMachine(AspeedTest):
 
     ASSET_PALMETTO_FLASH = Asset(
-        ('https://github.com/openbmc/openbmc/releases/download/2.9.0/'
-         'obmc-phosphor-image-palmetto.static.mtd'),
-        '3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d');
+        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/palmetto-bmc/openbmc-20250128071432/obmc-phosphor-image-palmetto-20250128071432.static.mtd',
+        'bce7c392eec75c707a91cfc8fad7ca9a69d7e4f10df936930d65c1cb9897ac81');
 
-    def test_arm_ast2400_palmetto_openbmc_v2_9_0(self):
+    def test_arm_ast2400_palmetto_openbmc(self):
         image_path = self.ASSET_PALMETTO_FLASH.fetch()
 
-        self.do_test_arm_aspeed('palmetto-bmc', image_path)
-
+        self.do_test_arm_aspeed_openbmc('palmetto-bmc', image=image_path,
+                                        uboot='2019.04', cpu_id='0x0',
+                                        soc='AST2400 rev A1');
 
 if __name__ == '__main__':
     AspeedTest.main()
-- 
2.48.1


