Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE803E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 06:41:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLGHW-0007sF-Ls; Wed, 11 Dec 2024 01:33:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGY-0005FW-KH
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tLGGS-00007X-1b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 01:32:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733898718;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FuaCftXGIJpJdR2uydxBMsgZtI8BYLAUbkKcZ5YYDPc=;
 b=U106eUvYGk92vRV+sKDahCcUJ5XPy93xKe2D/uy3eihiddbpTM6Qm7qsyZoHrOnnfuOzmY
 +bdeuprfb4h10gg52FfxEQxs/31VcwCoyCdbauxItsHspkIGRALAuJkqx3aMfzoEFuMzzs
 HG4dS1txZBKjBn3ZCI06fdlYmZhP/LI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-KdjZI7HOM6uNWhrZI9xk2Q-1; Wed,
 11 Dec 2024 01:31:56 -0500
X-MC-Unique: KdjZI7HOM6uNWhrZI9xk2Q-1
X-Mimecast-MFC-AGG-ID: KdjZI7HOM6uNWhrZI9xk2Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECFAE1955E70; Wed, 11 Dec 2024 06:31:55 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.194.144])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 87664195606C; Wed, 11 Dec 2024 06:31:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 24/24] test/qtest/ast2700-smc-test: Support to test AST2700
Date: Wed, 11 Dec 2024 07:30:58 +0100
Message-ID: <20241211063058.1222038-25-clg@redhat.com>
In-Reply-To: <20241211063058.1222038-1-clg@redhat.com>
References: <20241211063058.1222038-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.52,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Add test_ast2700_evb function and reused testcases which are from
aspeed_smc-test.c for AST2700 testing. The base address, flash base address
and ce index of fmc_cs0 are 0x14000000, 0x100000000 and 0, respectively.
The default flash model of fmc_cs0 is "w25q01jvq" whose size is 128MB,
so set jedec_id 0xef4021.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20241127091543.1243114-11-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/qtest/ast2700-smc-test.c | 71 ++++++++++++++++++++++++++++++++++
 tests/qtest/meson.build        |  4 +-
 2 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 tests/qtest/ast2700-smc-test.c

diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
new file mode 100644
index 000000000000..d1c485630744
--- /dev/null
+++ b/tests/qtest/ast2700-smc-test.c
@@ -0,0 +1,71 @@
+/*
+ * QTest testcase for the M25P80 Flash using the ASPEED SPI Controller since
+ * AST2700.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (C) 2024 ASPEED Technology Inc.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/bswap.h"
+#include "libqtest-single.h"
+#include "qemu/bitops.h"
+#include "aspeed-smc-utils.h"
+
+static void test_ast2700_evb(AspeedSMCTestData *data)
+{
+    int ret;
+    int fd;
+
+    fd = g_file_open_tmp("qtest.m25p80.w25q01jvq.XXXXXX",
+                         &data->tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, 128 * 1024 * 1024);
+    g_assert(ret == 0);
+    close(fd);
+
+    data->s = qtest_initf("-machine ast2700-evb "
+                          "-drive file=%s,format=raw,if=mtd",
+                          data->tmp_path);
+
+    /* fmc cs0 with w25q01jvq flash */
+    data->flash_base = 0x100000000;
+    data->spi_base = 0x14000000;
+    data->jedec_id = 0xef4021;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 64MB */
+    data->page_addr = 0x40000 * FLASH_PAGE_SIZE;
+
+    qtest_add_data_func("/ast2700/smc/read_jedec",
+                        data, aspeed_smc_test_read_jedec);
+    qtest_add_data_func("/ast2700/smc/erase_sector",
+                        data, aspeed_smc_test_erase_sector);
+    qtest_add_data_func("/ast2700/smc/erase_all",
+                        data, aspeed_smc_test_erase_all);
+    qtest_add_data_func("/ast2700/smc/write_page",
+                        data, aspeed_smc_test_write_page);
+    qtest_add_data_func("/ast2700/smc/read_page_mem",
+                        data, aspeed_smc_test_read_page_mem);
+    qtest_add_data_func("/ast2700/smc/write_page_mem",
+                        data, aspeed_smc_test_write_page_mem);
+    qtest_add_data_func("/ast2700/smc/read_status_reg",
+                        data, aspeed_smc_test_read_status_reg);
+    qtest_add_data_func("/ast2700/smc/write_page_qpi",
+                        data, aspeed_smc_test_write_page_qpi);
+}
+
+int main(int argc, char **argv)
+{
+    AspeedSMCTestData ast2700_evb_data;
+    int ret;
+
+    g_test_init(&argc, &argv, NULL);
+
+    test_ast2700_evb(&ast2700_evb_data);
+    ret = g_test_run();
+
+    qtest_quit(ast2700_evb_data.s);
+    unlink(ast2700_evb_data.tmp_path);
+    return ret;
+}
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index f8b3907e370d..89db3ecf2ff7 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -214,7 +214,8 @@ qtests_aspeed = \
    'aspeed_smc-test',
    'aspeed_gpio-test']
 qtests_aspeed64 = \
-  ['ast2700-gpio-test']
+  ['ast2700-gpio-test',
+   'ast2700-smc-test']
 
 qtests_stm32l4x5 = \
   ['stm32l4x5_exti-test',
@@ -361,6 +362,7 @@ qtests = {
   'vmgenid-test': files('boot-sector.c', 'acpi-utils.c'),
   'netdev-socket': files('netdev-socket.c', '../unit/socket-helpers.c'),
   'aspeed_smc-test': files('aspeed-smc-utils.c', 'aspeed_smc-test.c'),
+  'ast2700-smc-test': files('aspeed-smc-utils.c', 'ast2700-smc-test.c'),
 }
 
 if vnc.found()
-- 
2.47.1


