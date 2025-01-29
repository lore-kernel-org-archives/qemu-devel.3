Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A38C02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:20:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2Ls-000289-0X; Wed, 29 Jan 2025 02:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td2Lp-00023E-5V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:19:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1td2Lh-0003fh-Jc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738135137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eze6jaRUaOErODMTcqq4FVwyGb8xZ9G8Z5QYQ9u0Tl4=;
 b=eAofjihwlHQ7YXVh4mWgtP/YmpvK0lZDIMEkjCaJzf7ai159337LFgk40d9/N85ZjKYm99
 iPhdxTToPzDraOjT+oWd/a+XI2KANjMVTbwZvTQLqxAhfFrsMmm/kURrphL7sSBI/1uR6r
 1I0WAJzUy4ztVjk59KdaLp0T5LyjwfI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-303-KTMcZY9CPwOM8zOBKVYovA-1; Wed,
 29 Jan 2025 02:18:52 -0500
X-MC-Unique: KTMcZY9CPwOM8zOBKVYovA-1
X-Mimecast-MFC-AGG-ID: KTMcZY9CPwOM8zOBKVYovA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50CD21800361; Wed, 29 Jan 2025 07:18:50 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.105])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 85BFA1956060; Wed, 29 Jan 2025 07:18:47 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <troy_lee@aspeedtech.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 4/5] tests/functional: Introduce a witherspoon machine test
Date: Wed, 29 Jan 2025 08:18:19 +0100
Message-ID: <20250129071820.1258133-5-clg@redhat.com>
In-Reply-To: <20250129071820.1258133-1-clg@redhat.com>
References: <20250129071820.1258133-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use do_test_arm_aspeed_openbmc() routine to run the latest OpenBMC
firmware build of the witherspoon BMC.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/functional/meson.build                  |  2 ++
 .../functional/test_arm_aspeed_witherspoon.py | 24 +++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/functional/test_arm_aspeed_witherspoon.py

diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index b7719ab85f90..5c782ceb0a98 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -22,6 +22,7 @@ test_timeouts = {
   'acpi_bits' : 420,
   'arm_aspeed_palmetto' : 120,
   'arm_aspeed_romulus' : 120,
+  'arm_aspeed_witherspoon' : 120,
   'arm_aspeed_ast2500' : 480,
   'arm_aspeed_ast2600' : 720,
   'arm_aspeed_rainier' : 240,
@@ -82,6 +83,7 @@ tests_arm_system_thorough = [
   'arm_aspeed_ast1030',
   'arm_aspeed_palmetto',
   'arm_aspeed_romulus',
+  'arm_aspeed_witherspoon',
   'arm_aspeed_ast2500',
   'arm_aspeed_ast2600',
   'arm_aspeed_rainier',
diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/test_arm_aspeed_witherspoon.py
new file mode 100755
index 000000000000..12714323733a
--- /dev/null
+++ b/tests/functional/test_arm_aspeed_witherspoon.py
@@ -0,0 +1,24 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots the ASPEED machines
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import Asset
+from aspeed import AspeedTest
+
+class WitherspoonMachine(AspeedTest):
+
+    ASSET_WITHERSPOON_FLASH = Asset(
+        'https://github.com/legoater/qemu-aspeed-boot/raw/master/images/witherspoon-bmc/openbmc-20240618035022/obmc-phosphor-image-witherspoon-20240618035022.ubi.mtd',
+        '937d9ed449ea6c6cbed983519088a42d0cafe276bcfe4fce07772ca6673f9213');
+
+    def test_arm_ast2500_witherspoon_openbmc(self):
+        image_path = self.ASSET_WITHERSPOON_FLASH.fetch()
+
+        self.do_test_arm_aspeed_openbmc('witherspoon-bmc', image=image_path,
+                                        uboot='2016.07', cpu_id='0x0',
+                                        soc='AST2500 rev A1');
+
+if __name__ == '__main__':
+    AspeedTest.main()
-- 
2.48.1


