Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D702C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXVr-0004fD-Nd; Wed, 24 Apr 2024 03:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVp-0004eq-Jh
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rzXVl-000308-TL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 03:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cleTDRu5UND8YfSQ+ceYwLko8HmzOLSJAeH5moAAUec=;
 b=IEBs7xSlckF2EctkaF+iBkgw0ICQtc8X/xDImrAFtAZi79667yDGKZFVRXxXu1yEZc6xad
 wIkJ4AnCkH+fEB5byH0nTAo+1d8NUlrKWUbuQ4Hmze9m1O/LjjqLB6reDkIV98bm7FHZC5
 b9SztWy6Fr9NE2TZ+lllb3uWw0XJuug=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-VqgsnGtZOhy9gS_9Wwk6Mg-1; Wed,
 24 Apr 2024 03:57:42 -0400
X-MC-Unique: VqgsnGtZOhy9gS_9Wwk6Mg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D90A738143A4;
 Wed, 24 Apr 2024 07:57:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 894F43543A;
 Wed, 24 Apr 2024 07:57:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ninad Palsule <ninad@linux.ibm.com>
Subject: [PULL 02/17] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
Date: Wed, 24 Apr 2024 09:57:20 +0200
Message-ID: <20240424075735.248041-3-thuth@redhat.com>
In-Reply-To: <20240424075735.248041-1-thuth@redhat.com>
References: <20240424075735.248041-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

The messages for assertions using hexadecimal numbers will be
easier to understand with `g_assert_cmphex`.

Cases changed : "cmpuint.*0x", "cmpuint.*<<"

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Ninad Palsule <ninad@linux.ibm.com>
Message-ID: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/aspeed_fsi-test.c          |  20 ++--
 tests/qtest/cmsdk-apb-dualtimer-test.c |   2 +-
 tests/qtest/cmsdk-apb-watchdog-test.c  |   2 +-
 tests/qtest/erst-test.c                |   2 +-
 tests/qtest/ivshmem-test.c             |  10 +-
 tests/qtest/libqos/ahci.c              |   4 +-
 tests/qtest/microbit-test.c            |  46 ++++-----
 tests/qtest/sse-timer-test.c           |   4 +-
 tests/qtest/stm32l4x5_exti-test.c      | 138 ++++++++++++-------------
 tests/qtest/stm32l4x5_syscfg-test.c    |  74 ++++++-------
 10 files changed, 151 insertions(+), 151 deletions(-)

diff --git a/tests/qtest/aspeed_fsi-test.c b/tests/qtest/aspeed_fsi-test.c
index b3020dd821..f5ab269972 100644
--- a/tests/qtest/aspeed_fsi-test.c
+++ b/tests/qtest/aspeed_fsi-test.c
@@ -63,22 +63,22 @@ static void test_fsi_setup(QTestState *s, uint32_t base_addr)
         /* Unselect FSI1 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
         curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
-        g_assert_cmpuint(curval, ==, 0x0);
+        g_assert_cmphex(curval, ==, 0x0);
 
         /* Select FSI0 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
         curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
-        g_assert_cmpuint(curval, ==, 0x1);
+        g_assert_cmphex(curval, ==, 0x1);
     } else if (base_addr == AST2600_OPB_FSI1_BASE_ADDR) {
         /* Unselect FSI0 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
         curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
-        g_assert_cmpuint(curval, ==, 0x0);
+        g_assert_cmphex(curval, ==, 0x0);
 
         /* Select FSI1 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
         curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
-        g_assert_cmpuint(curval, ==, 0x1);
+        g_assert_cmphex(curval, ==, 0x1);
     } else {
         g_assert_not_reached();
     }
@@ -145,11 +145,11 @@ static void test_fsi0_getcfam_addr0(const void *data)
     aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
 
     curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
-    g_assert_cmpuint(curval, ==, 0x10000);
+    g_assert_cmphex(curval, ==, 0x10000);
     curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
-    g_assert_cmpuint(curval, ==, 0x0);
+    g_assert_cmphex(curval, ==, 0x0);
     curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
-    g_assert_cmpuint(curval, ==, 0x152d02c0);
+    g_assert_cmphex(curval, ==, 0x152d02c0);
 }
 
 static void test_fsi1_getcfam_addr0(const void *data)
@@ -168,11 +168,11 @@ static void test_fsi1_getcfam_addr0(const void *data)
     aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
 
     curval = aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
-    g_assert_cmpuint(curval, ==, 0x20000);
+    g_assert_cmphex(curval, ==, 0x20000);
     curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
-    g_assert_cmpuint(curval, ==, 0x0);
+    g_assert_cmphex(curval, ==, 0x0);
     curval = aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
-    g_assert_cmpuint(curval, ==, 0x152d02c0);
+    g_assert_cmphex(curval, ==, 0x152d02c0);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/cmsdk-apb-dualtimer-test.c b/tests/qtest/cmsdk-apb-dualtimer-test.c
index ad6a758289..3b89bed97d 100644
--- a/tests/qtest/cmsdk-apb-dualtimer-test.c
+++ b/tests/qtest/cmsdk-apb-dualtimer-test.c
@@ -69,7 +69,7 @@ static void test_dualtimer(void)
      * tick VALUE should have wrapped round to 0xffff.
      */
     clock_step(40);
-    g_assert_cmpuint(readl(TIMER_BASE + TIMER1VALUE), ==, 0xffff);
+    g_assert_cmphex(readl(TIMER_BASE + TIMER1VALUE), ==, 0xffff);
 
     /* Check that any write to INTCLR clears interrupt */
     writel(TIMER_BASE + TIMER1INTCLR, 1);
diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-apb-watchdog-test.c
index 2710cb17b8..00b5dbbc81 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -88,7 +88,7 @@ static void test_clock_change(void)
 
     /* Rewrite RCC.SYSDIV from 16 to 8, so the clock is now 40ns per tick */
     rcc = readl(SSYS_BASE + RCC);
-    g_assert_cmpuint(extract32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH), ==, 0xf);
+    g_assert_cmphex(extract32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH), ==, 0xf);
     rcc = deposit32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH, 7);
     writel(SSYS_BASE + RCC, rcc);
 
diff --git a/tests/qtest/erst-test.c b/tests/qtest/erst-test.c
index c45bee7f05..36bbe122ab 100644
--- a/tests/qtest/erst-test.c
+++ b/tests/qtest/erst-test.c
@@ -109,7 +109,7 @@ static void setup_vm_cmd(ERSTState *s, const char *cmd)
     g_assert_cmpuint(s->reg_barsize, ==, 16);
 
     s->mem_bar = qpci_iomap(s->dev, 1, &s->mem_barsize);
-    g_assert_cmpuint(s->mem_barsize, ==, 0x2000);
+    g_assert_cmphex(s->mem_barsize, ==, 0x2000);
 
     qpci_device_enable(s->dev);
 }
diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index 9bf8e78df6..fb45fdeb07 100644
--- a/tests/qtest/ivshmem-test.c
+++ b/tests/qtest/ivshmem-test.c
@@ -158,7 +158,7 @@ static void test_ivshmem_single(void)
 
     /* trigger interrupt via registers */
     out_reg(s, INTRMASK, 0xffffffff);
-    g_assert_cmpuint(in_reg(s, INTRMASK), ==, 0xffffffff);
+    g_assert_cmphex(in_reg(s, INTRMASK), ==, 0xffffffff);
     out_reg(s, INTRSTATUS, 1);
     /* check interrupt status */
     g_assert_cmpuint(in_reg(s, INTRSTATUS), ==, 1);
@@ -211,11 +211,11 @@ static void test_ivshmem_pair(void)
     memset(tmpshmem, 0x42, TMPSHMSIZE);
     read_mem(s1, 0, data, TMPSHMSIZE);
     for (i = 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], ==, 0x42);
+        g_assert_cmphex(data[i], ==, 0x42);
     }
     read_mem(s2, 0, data, TMPSHMSIZE);
     for (i = 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], ==, 0x42);
+        g_assert_cmphex(data[i], ==, 0x42);
     }
 
     /* guest 1 write, guest 2 read */
@@ -224,7 +224,7 @@ static void test_ivshmem_pair(void)
     memset(data, 0, TMPSHMSIZE);
     read_mem(s2, 0, data, TMPSHMSIZE);
     for (i = 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], ==, 0x43);
+        g_assert_cmphex(data[i], ==, 0x43);
     }
 
     /* guest 2 write, guest 1 read */
@@ -233,7 +233,7 @@ static void test_ivshmem_pair(void)
     memset(data, 0, TMPSHMSIZE);
     read_mem(s1, 0, data, TMPSHMSIZE);
     for (i = 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], ==, 0x44);
+        g_assert_cmphex(data[i], ==, 0x44);
     }
 
     cleanup_vm(s1);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 6d59c7551a..34a75b7f43 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -1046,7 +1046,7 @@ static void ahci_atapi_command_set_offset(AHCICommand *cmd, uint64_t lba)
     case CMD_ATAPI_REQUEST_SENSE:
     case CMD_ATAPI_TEST_UNIT_READY:
     case CMD_ATAPI_START_STOP_UNIT:
-        g_assert_cmpuint(lba, ==, 0x00);
+        g_assert_cmphex(lba, ==, 0x00);
         break;
     default:
         /* SCSI doesn't have uniform packet formats,
@@ -1109,7 +1109,7 @@ static void ahci_atapi_set_size(AHCICommand *cmd, uint64_t xbytes)
         break;
     case CMD_ATAPI_READ_CD:
         /* 24bit BE store */
-        g_assert_cmpuint(nsectors, <, 1ULL << 24);
+        g_assert_cmphex(nsectors, <, 1ULL << 24);
         tmp = nsectors;
         cbd[6] = (tmp & 0xFF0000) >> 16;
         cbd[7] = (tmp & 0xFF00) >> 8;
diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 72190d38f7..505c831f13 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -143,14 +143,14 @@ static void test_microbit_i2c(void)
 
     /* MMA8653 magnetometer detection */
     val = i2c_read_byte(qts, 0x3A, 0x0D);
-    g_assert_cmpuint(val, ==, 0x5A);
+    g_assert_cmphex(val, ==, 0x5A);
 
     val = i2c_read_byte(qts, 0x3A, 0x0D);
-    g_assert_cmpuint(val, ==, 0x5A);
+    g_assert_cmphex(val, ==, 0x5A);
 
     /* LSM303 accelerometer detection */
     val = i2c_read_byte(qts, 0x3C, 0x4F);
-    g_assert_cmpuint(val, ==, 0x40);
+    g_assert_cmphex(val, ==, 0x40);
 
     qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
 
@@ -171,7 +171,7 @@ static void fill_and_erase(QTestState *qts, hwaddr base, hwaddr size,
 
     /* Check memory */
     for (i = 0; i < size / 4; i++) {
-        g_assert_cmpuint(qtest_readl(qts, base + i * 4), ==, 0xFFFFFFFF);
+        g_assert_cmphex(qtest_readl(qts, base + i * 4), ==, 0xFFFFFFFF);
     }
 
     /* Fill memory */
@@ -191,7 +191,7 @@ static void test_nrf51_nvmc(void)
 
     /* Test always ready */
     value = qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_READY);
-    g_assert_cmpuint(value & 0x01, ==, 0x01);
+    g_assert_cmphex(value & 0x01, ==, 0x01);
 
     /* Test write-read config register */
     qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
@@ -302,19 +302,19 @@ static void test_nrf51_gpio(void)
     g_assert_cmpuint(actual, ==, expected);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
              & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
 
     /* Check clear via DIRCLR */
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x80000001);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
-    g_assert_cmpuint(actual, ==, 0x00000000);
+    g_assert_cmphex(actual, ==, 0x00000000);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
              & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
 
     /* Check set via DIR */
     expected = 0x80000001;
@@ -323,9 +323,9 @@ static void test_nrf51_gpio(void)
     g_assert_cmpuint(actual, ==, expected);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START)
              & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
 
     /* Reset DIR */
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
@@ -334,33 +334,33 @@ static void test_nrf51_gpio(void)
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
 
     /* Check pull-up working */
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
 
     /* Check pull-down working */
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
 
@@ -376,11 +376,11 @@ static void test_nrf51_gpio(void)
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x01);
+    g_assert_cmphex(actual, ==, 0x01);
 
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
     actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0x01;
-    g_assert_cmpuint(actual, ==, 0x00);
+    g_assert_cmphex(actual, ==, 0x00);
 
     /*
      * Check short-circuit - generates an guest_error which must be checked
@@ -410,7 +410,7 @@ static void test_nrf51_gpio_detect(void)
         /* Set pin high */
         qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 1);
         uint32_t actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN);
-        g_assert_cmpuint(actual, ==, 1 << i);
+        g_assert_cmphex(actual, ==, 1 << i);
 
         /* Check that DETECT is high */
         g_assert_true(qtest_get_irq(qts, 0));
@@ -418,7 +418,7 @@ static void test_nrf51_gpio_detect(void)
         /* Set pin low, check that DETECT goes low. */
         qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 0);
         actual = qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN);
-        g_assert_cmpuint(actual, ==, 0x0);
+        g_assert_cmphex(actual, ==, 0x0);
         g_assert_false(qtest_get_irq(qts, 0));
     }
 
diff --git a/tests/qtest/sse-timer-test.c b/tests/qtest/sse-timer-test.c
index a65d7542d5..fd5635d4c9 100644
--- a/tests/qtest/sse-timer-test.c
+++ b/tests/qtest/sse-timer-test.c
@@ -181,12 +181,12 @@ static void test_timer(void)
     writel(TIMER_BASE + CNTP_AIVAL_CTL, 0);
     clock_step_ticks(0x42ULL << 32);
     g_assert_cmpuint(readl(TIMER_BASE + CNTPCT_LO), ==, 4400);
-    g_assert_cmpuint(readl(TIMER_BASE + CNTPCT_HI), ==, 0x42);
+    g_assert_cmphex(readl(TIMER_BASE + CNTPCT_HI), ==, 0x42);
 
     /* Turn on the autoinc again to check AIVAL_HI */
     writel(TIMER_BASE + CNTP_AIVAL_CTL, 1);
     g_assert_cmpuint(readl(TIMER_BASE + CNTP_AIVAL_LO), ==, 4600);
-    g_assert_cmpuint(readl(TIMER_BASE + CNTP_AIVAL_HI), ==, 0x42);
+    g_assert_cmphex(readl(TIMER_BASE + CNTP_AIVAL_HI), ==, 0x42);
 }
 
 static void test_timer_scale_change(void)
diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-test.c
index 81830be8ae..7092860b9b 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -70,44 +70,44 @@ static void test_reg_write_read(void)
     /* Test that non-reserved bits in xMR and xTSR can be set and cleared */
 
     exti_writel(EXTI_IMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), ==, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), ==, 0xFFFFFFFF);
     exti_writel(EXTI_IMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), ==, 0x00000000);
 
     exti_writel(EXTI_EMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), ==, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), ==, 0xFFFFFFFF);
     exti_writel(EXTI_EMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), ==, 0x00000000);
 
     exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), ==, 0x007DFFFF);
     exti_writel(EXTI_RTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), ==, 0x00000000);
 
     exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), ==, 0x007DFFFF);
     exti_writel(EXTI_FTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), ==, 0x00000000);
 
     exti_writel(EXTI_IMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), ==, 0x000000FF);
     exti_writel(EXTI_IMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), ==, 0x00000000);
 
     exti_writel(EXTI_EMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), ==, 0x000000FF);
     exti_writel(EXTI_EMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), ==, 0x00000000);
 
     exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), ==, 0x00000078);
     exti_writel(EXTI_RTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), ==, 0x00000000);
 
     exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), ==, 0x00000078);
     exti_writel(EXTI_FTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), ==, 0x00000000);
 }
 
 static void test_direct_lines_write(void)
@@ -115,28 +115,28 @@ static void test_direct_lines_write(void)
     /* Test that direct lines reserved bits are not written to */
 
     exti_writel(EXTI_RTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), ==, 0x00000000);
 
     exti_writel(EXTI_FTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), ==, 0x00000000);
 
     exti_writel(EXTI_SWIER1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), ==, 0x00000000);
 
     exti_writel(EXTI_PR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
 
     exti_writel(EXTI_RTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), ==, 0x00000000);
 
     exti_writel(EXTI_FTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), ==, 0x00000000);
 
     exti_writel(EXTI_SWIER2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), ==, 0x00000000);
 
     exti_writel(EXTI_PR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
 }
 
 static void test_reserved_bits_write(void)
@@ -144,22 +144,22 @@ static void test_reserved_bits_write(void)
     /* Test that reserved bits stay are not written to */
 
     exti_writel(EXTI_IMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), ==, 0x00000000);
 
     exti_writel(EXTI_EMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), ==, 0x00000000);
 
     exti_writel(EXTI_RTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), ==, 0x00000000);
 
     exti_writel(EXTI_FTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), ==, 0x00000000);
 
     exti_writel(EXTI_SWIER2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), ==, 0x00000000);
 
     exti_writel(EXTI_PR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
 }
 
 static void test_software_interrupt(void)
@@ -180,7 +180,7 @@ static void test_software_interrupt(void)
 
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -191,9 +191,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
 
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), ==, 0x00000001);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000001);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
@@ -201,9 +201,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000001);
 
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), ==, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
@@ -214,7 +214,7 @@ static void test_software_interrupt(void)
 
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 
     /* Enable interrupt line EXTI0 */
@@ -224,9 +224,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
 
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), ==, 0x00000008);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000008);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
 
@@ -234,9 +234,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR2, 0x00000008);
 
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), ==, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
 
@@ -259,16 +259,16 @@ static void test_edge_selector(void)
 
     /* Test that an irq is raised on rising edge only */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -280,16 +280,16 @@ static void test_edge_selector(void)
 
     /* Test that an irq is raised on falling edge only */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -300,23 +300,23 @@ static void test_edge_selector(void)
 
     /* Test that an irq is raised on rising edge */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
     /* Test that an irq is raised on falling edge */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
 
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -327,11 +327,11 @@ static void test_edge_selector(void)
 
     /* Test that no irq is raised */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 }
 
@@ -350,7 +350,7 @@ static void test_no_software_interrupt(void)
 
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -361,9 +361,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
 
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), ==, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), ==, 0x00000001);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -371,7 +371,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000001);
 
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 
@@ -382,7 +382,7 @@ static void test_no_software_interrupt(void)
 
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 
@@ -393,9 +393,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
 
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), ==, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), ==, 0x00000008);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 
@@ -403,7 +403,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR2, 0x00000008);
 
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 }
@@ -423,7 +423,7 @@ static void test_masked_interrupt(void)
 
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 
@@ -437,7 +437,7 @@ static void test_masked_interrupt(void)
     exti_set_irq(1, 1);
 
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 
@@ -445,7 +445,7 @@ static void test_masked_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000002);
 
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
@@ -469,7 +469,7 @@ static void test_interrupt(void)
 
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 
@@ -483,7 +483,7 @@ static void test_interrupt(void)
     exti_set_irq(1, 1);
 
     /* Check that the pending bit in PR was set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000002);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000002);
     /* Check that the interrupt is pending in NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
 
@@ -491,7 +491,7 @@ static void test_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000002);
 
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
 
@@ -509,7 +509,7 @@ static void test_orred_interrupts(void)
      */
     enable_nvic_irq(EXTI5_9_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
 
@@ -522,11 +522,11 @@ static void test_orred_interrupts(void)
     /* Raise GPIO line i, check that the interrupt is pending */
     for (unsigned i = 5; i < 10; i++) {
         exti_set_irq(i, 1);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 1 << i);
+        g_assert_cmphex(exti_readl(EXTI_PR1), ==, 1 << i);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
 
         exti_writel(EXTI_PR1, 1 << i);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+        g_assert_cmphex(exti_readl(EXTI_PR1), ==, 0x00000000);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
 
         unpend_nvic_irq(EXTI5_9_IRQ);
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_syscfg-test.c
index ed4801798d..59bac829b7 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -54,27 +54,27 @@ static void test_reset(void)
     /*
      * Test that registers are initialized at the correct values
      */
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SCSR), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SCSR), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
 
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), ==, 0x00000000);
 }
 
 static void test_reserved_bits(void)
@@ -87,25 +87,25 @@ static void test_reserved_bits(void)
      * register is still at reset value
      */
     syscfg_writel(SYSCFG_MEMRMP, 0xFFFFFEF8);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0x7C000001);
 
     syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
 }
 
 static void test_set_and_clear(void)
@@ -114,40 +114,40 @@ static void test_set_and_clear(void)
      * Test that regular bits can be set and cleared
      */
     syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000107);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000107);
     syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), ==, 0x00000000);
 
     /* cfgr1 bit 0 is clear only so we keep it set */
     syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0xFCFF0101);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0xFCFF0101);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000001);
 
     syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), ==, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), ==, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), ==, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), ==, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), ==, 0x00000000);
 
     syscfg_writel(SYSCFG_SKR, 0x000000FF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x000000FF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), ==, 0x000000FF);
     syscfg_writel(SYSCFG_SKR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), ==, 0x00000000);
 }
 
 static void test_clear_by_writing_1(void)
@@ -156,7 +156,7 @@ static void test_clear_by_writing_1(void)
      * Test that writing '1' doesn't set the bit
      */
     syscfg_writel(SYSCFG_CFGR2, 0x00000100);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), ==, 0x00000000);
 }
 
 static void test_set_only_bits(void)
@@ -166,15 +166,15 @@ static void test_set_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
     syscfg_writel(SYSCFG_CFGR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), ==, 0x0000000F);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), ==, 0x0000000F);
 
     syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), ==, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), ==, 0xFFFFFFFF);
 
     syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), ==, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), ==, 0xFFFFFFFF);
 
     system_reset();
 }
@@ -186,7 +186,7 @@ static void test_clear_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR1, 0x00000000);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), ==, 0x00000000);
 
     system_reset();
 }
-- 
2.44.0


