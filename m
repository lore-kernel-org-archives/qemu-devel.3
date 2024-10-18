Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2E6D3C54D
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 05:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1fb2-0000vL-B4; Fri, 18 Oct 2024 01:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t1fax-0000jH-At; Fri, 18 Oct 2024 01:32:15 -0400
Received: from mail.aspeedtech.com ([211.20.114.72] helo=TWMBX01.aspeed.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1t1fav-0008E2-Qu; Fri, 18 Oct 2024 01:32:15 -0400
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Fri, 18 Oct
 2024 13:31:17 +0800
Received: from localhost.localdomain (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 18 Oct 2024 13:31:17 +0800
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Peter Maydell
 <peter.maydell@linaro.org>, Steven Lee <steven_lee@aspeedtech.com>, Troy Lee
 <leetroy@gmail.com>, Andrew Jeffery <andrew@codeconstruct.com.au>, "Joel
 Stanley" <joel@jms.id.au>, Alistair Francis <alistair@alistair23.me>, "Kevin
 Wolf" <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, "open
 list:All patches CC here" <qemu-devel@nongnu.org>, "open list:Block layer
 core" <qemu-block@nongnu.org>
CC: <jamin_lin@aspeedtech.com>, <troy_lee@aspeedtech.com>,
 <yunlin.tang@aspeedtech.com>
Subject: [PATCH v1 14/16] test/qtest/aspeed_smc-test: Support to test AST1030
Date: Fri, 18 Oct 2024 13:31:10 +0800
Message-ID: <20241018053112.1886173-15-jamin_lin@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
References: <20241018053112.1886173-1-jamin_lin@aspeedtech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: pass client-ip=211.20.114.72;
 envelope-from=jamin_lin@aspeedtech.com; helo=TWMBX01.aspeed.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_FAIL=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jamin Lin <jamin_lin@aspeedtech.com>
From:  Jamin Lin via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add test_ast1030_evb function and reused testcases for AST1030 testing.
The base address, flash base address and ce index of fmc_cs0 are
0x7E620000, 0x80000000 and 0, respectively.
The default flash model of fmc_cs0 is "w25q80bl" whose size is 1MB,
so set jedec_id 0xef4014.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
---
 tests/qtest/aspeed_smc-test.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 30f997679c..c5c38e23c5 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -774,11 +774,50 @@ static void test_ast2600_evb(TestData *data)
     qtest_add_data_func("/ast2600/smc/read_status_reg",
                         data, test_read_status_reg);
 }
+
+static void test_ast1030_evb(TestData *data)
+{
+    int ret;
+    int fd;
+
+    fd = g_file_open_tmp("qtest.m25p80.w25q80bl.XXXXXX",
+                         &data->tmp_path, NULL);
+    g_assert(fd >= 0);
+    ret = ftruncate(fd, 1 * 1024 * 1024);
+    g_assert(ret == 0);
+    close(fd);
+
+    data->s = qtest_initf("-machine ast1030-evb "
+                          "-drive file=%s,format=raw,if=mtd",
+                          data->tmp_path);
+
+    /* fmc cs0 with w25q80bl flash */
+    data->flash_base = 0x80000000;
+    data->spi_base = 0x7E620000;
+    data->jedec_id = 0xef4014;
+    data->cs = 0;
+    data->node = "/machine/soc/fmc/ssi.0/child[0]";
+    /* beyond 512KB */
+    data->page_addr = 0x800 * FLASH_PAGE_SIZE;
+
+    qtest_add_data_func("/ast1030/smc/read_jedec", data, test_read_jedec);
+    qtest_add_data_func("/ast1030/smc/erase_sector", data, test_erase_sector);
+    qtest_add_data_func("/ast1030/smc/erase_all",  data, test_erase_all);
+    qtest_add_data_func("/ast1030/smc/write_page", data, test_write_page);
+    qtest_add_data_func("/ast1030/smc/read_page_mem",
+                        data, test_read_page_mem);
+    qtest_add_data_func("/ast1030/smc/write_page_mem",
+                        data, test_write_page_mem);
+    qtest_add_data_func("/ast1030/smc/read_status_reg",
+                        data, test_read_status_reg);
+}
+
 int main(int argc, char **argv)
 {
     TestData palmetto_data;
     TestData ast2500_evb_data;
     TestData ast2600_evb_data;
+    TestData ast1030_evb_data;
     int ret;
 
     g_test_init(&argc, &argv, NULL);
@@ -786,13 +825,16 @@ int main(int argc, char **argv)
     test_palmetto_bmc(&palmetto_data);
     test_ast2500_evb(&ast2500_evb_data);
     test_ast2600_evb(&ast2600_evb_data);
+    test_ast1030_evb(&ast1030_evb_data);
     ret = g_test_run();
 
     qtest_quit(palmetto_data.s);
     qtest_quit(ast2500_evb_data.s);
     qtest_quit(ast2600_evb_data.s);
+    qtest_quit(ast1030_evb_data.s);
     unlink(palmetto_data.tmp_path);
     unlink(ast2500_evb_data.tmp_path);
     unlink(ast2600_evb_data.tmp_path);
+    unlink(ast1030_evb_data.tmp_path);
     return ret;
 }
-- 
2.34.1


