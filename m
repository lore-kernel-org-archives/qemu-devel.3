Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C71C44501
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 11:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whQGD-0007W6-6F; Wed, 08 Jul 2026 07:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGC-0007Vp-49
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1whQGA-0003H9-CB
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 07:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783509369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k+HCTl3sSuz6R/8BnCQoBNl9aj44Prwz5Ig9Dn7I7cY=;
 b=B6xRFwS4Sc3525ia0EX3DEjQlgQ98FPCE+2kOxEkeK1d+/FLkzas4Rq61sCwymNSly9o61
 mVi1z8h+ugCPPobO+TPMwTgkSstkdb0Uqpx5A4NgsH6Kzzy9aizmvE9x5+DRN8SoZZK7R1
 eMX7YDmXUrkXUWdaDUVU4lMw1i3fq9c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-w3Ks1PU7Np-69k6qiGsRnw-1; Wed,
 08 Jul 2026 07:16:06 -0400
X-MC-Unique: w3Ks1PU7Np-69k6qiGsRnw-1
X-Mimecast-MFC-AGG-ID: w3Ks1PU7Np-69k6qiGsRnw_1783509364
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29BCD180063A; Wed,  8 Jul 2026 11:16:04 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.253])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B19A1955F43; Wed,  8 Jul 2026 11:15:59 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Bin Meng <bin.meng@processmission.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 2/4] tests/qtest: aspeed_smc: Add fast-read test coverage
Date: Wed,  8 Jul 2026 13:15:42 +0200
Message-ID: <20260708111544.1440761-3-clg@redhat.com>
In-Reply-To: <20260708111544.1440761-1-clg@redhat.com>
References: <20260708111544.1440761-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add read_page_mem_fast_read (CTRL_FREADMODE with dummy byte) and
write_page_fast_read (user-mode FAST_READ) tests.

Signed-off-by: Cedric Le Goater <clg@redhat.com>
---
 tests/qtest/aspeed-smc-utils.h |  5 ++++
 tests/qtest/aspeed-smc-utils.c | 49 ++++++++++++++++++++++++++++++++++
 tests/qtest/aspeed_smc-test.c  | 21 +++++++++++++++
 tests/qtest/ast2700-smc-test.c |  4 +++
 4 files changed, 79 insertions(+)

diff --git a/tests/qtest/aspeed-smc-utils.h b/tests/qtest/aspeed-smc-utils.h
index e2fd8ff1bd16..5a86514caf35 100644
--- a/tests/qtest/aspeed-smc-utils.h
+++ b/tests/qtest/aspeed-smc-utils.h
@@ -44,6 +44,8 @@
 #define   CTRL_FREADMODE       0x1
 #define   CTRL_WRITEMODE       0x2
 #define   CTRL_USERMODE        0x3
+#define   CTRL_DUMMY_LOW_SHIFT   6
+#define   CTRL_DUMMY_HIGH_SHIFT  14
 #define SR_WEL BIT(1)
 
 /*
@@ -55,6 +57,7 @@ enum {
     WRDI = 0x4,
     BULK_ERASE = 0xc7,
     READ = 0x03,
+    FAST_READ = 0x0b,
     PP = 0x02,
     WRSR = 0x1,
     WREN = 0x6,
@@ -90,5 +93,7 @@ void aspeed_smc_test_status_reg_write_protection(const void *data);
 void aspeed_smc_test_write_block_protect(const void *data);
 void aspeed_smc_test_write_block_protect_bottom_bit(const void *data);
 void aspeed_smc_test_write_page_qpi(const void *data);
+void aspeed_smc_test_read_page_mem_fast_read(const void *data);
+void aspeed_smc_test_write_page_fast_read(const void *data);
 
 #endif /* TESTS_ASPEED_SMC_UTILS_H */
diff --git a/tests/qtest/aspeed-smc-utils.c b/tests/qtest/aspeed-smc-utils.c
index ed125741eb36..9883ade0815c 100644
--- a/tests/qtest/aspeed-smc-utils.c
+++ b/tests/qtest/aspeed-smc-utils.c
@@ -697,3 +697,52 @@ void aspeed_smc_test_write_page_qpi(const void *data)
     flash_reset(test_data);
 }
 
+static void read_page_mem_fast_read(const AspeedSMCTestData *data,
+                                uint32_t addr, uint32_t *page)
+{
+    uint32_t ctrl_reg = R_CTRL0 + data->cs * 4;
+    uint32_t ctrl = spi_readl(data, ctrl_reg);
+    int i;
+
+    /* Set FREADMODE with FAST_READ command and 1 dummy byte */
+    ctrl &= ~(CTRL_USERMODE | (0xff << 16) |
+              (0x3 << CTRL_DUMMY_LOW_SHIFT) |
+              (0x1 << CTRL_DUMMY_HIGH_SHIFT) |
+              CTRL_IO_MODE_MASK);
+    ctrl |= CTRL_FREADMODE | (FAST_READ << 16) |
+            (1 << CTRL_DUMMY_LOW_SHIFT);
+    spi_writel(data, ctrl_reg, ctrl);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, addr + i * 4));
+    }
+}
+
+void aspeed_smc_test_read_page_mem_fast_read(const void *data)
+{
+    test_read_page_mem(data, read_page_mem_fast_read);
+}
+
+static void read_page_fast_read(const AspeedSMCTestData *data,
+                                uint32_t addr, uint32_t *page)
+{
+    int i;
+
+    spi_ctrl_start_user(data);
+
+    flash_writeb(data, 0, EN_4BYTE_ADDR);
+    flash_writeb(data, 0, FAST_READ);
+    flash_writel(data, 0, make_be32(addr));
+    /* 1 dummy byte for standard SPI fast-read */
+    flash_writeb(data, 0, 0x00);
+
+    for (i = 0; i < FLASH_PAGE_SIZE / 4; i++) {
+        page[i] = make_be32(flash_readl(data, 0));
+    }
+    spi_ctrl_stop_user(data);
+}
+
+void aspeed_smc_test_write_page_fast_read(const void *data)
+{
+    test_write_page(data, read_page_fast_read);
+}
diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.c
index 39af1df0ed75..bbda15ad17ea 100644
--- a/tests/qtest/aspeed_smc-test.c
+++ b/tests/qtest/aspeed_smc-test.c
@@ -68,6 +68,15 @@ static void test_palmetto_bmc(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2400/smc/status_reg_write_protection",
                         data, aspeed_smc_test_status_reg_write_protection);
+    qtest_add_data_func("/ast2400/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2400/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
+    /*
+     * Block protect tests must be run last because the block protect
+     * state is not cleared by reset_memory() and silently prevents
+     * subsequent flash writes.
+     */
     qtest_add_data_func("/ast2400/smc/write_block_protect",
                         data, aspeed_smc_test_write_block_protect);
     qtest_add_data_func("/ast2400/smc/write_block_protect_bottom_bit",
@@ -115,6 +124,10 @@ static void test_ast2500_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2500/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2500/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2500/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 static void test_ast2600_evb(AspeedSMCTestData *data)
@@ -158,6 +171,10 @@ static void test_ast2600_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2600/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2600/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2600/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 static void test_ast1030_evb(AspeedSMCTestData *data)
@@ -201,6 +218,10 @@ static void test_ast1030_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast1030/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast1030/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast1030/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-test.c
index 33fc47230ee5..9ad04b574c0d 100644
--- a/tests/qtest/ast2700-smc-test.c
+++ b/tests/qtest/ast2700-smc-test.c
@@ -52,6 +52,10 @@ static void test_ast2700_evb(AspeedSMCTestData *data)
                         data, aspeed_smc_test_read_status_reg);
     qtest_add_data_func("/ast2700/smc/write_page_qpi",
                         data, aspeed_smc_test_write_page_qpi);
+    qtest_add_data_func("/ast2700/smc/read_page_mem_fast_read",
+                        data, aspeed_smc_test_read_page_mem_fast_read);
+    qtest_add_data_func("/ast2700/smc/write_page_fast_read",
+                        data, aspeed_smc_test_write_page_fast_read);
 }
 
 int main(int argc, char **argv)
-- 
2.54.0


