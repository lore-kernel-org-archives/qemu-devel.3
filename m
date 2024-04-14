Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B5AC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 17:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw3k5-0007F7-5E; Sun, 14 Apr 2024 13:34:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rw3k2-0007EZ-Hr; Sun, 14 Apr 2024 13:34:10 -0400
Received: from zproxy1.enst.fr ([2001:660:330f:2::dc])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ines.varhol@telecom-paris.fr>)
 id 1rw3jy-0000LA-75; Sun, 14 Apr 2024 13:34:10 -0400
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id 83497C061B;
 Sun, 14 Apr 2024 19:34:00 +0200 (CEST)
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id KQlGQPOxOpaY; Sun, 14 Apr 2024 19:33:58 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
 by zproxy1.enst.fr (Postfix) with ESMTP id C7B4DC05F8;
 Sun, 14 Apr 2024 19:33:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy1.enst.fr C7B4DC05F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1713116038;
 bh=AojkWWCgedBO+mZAjUpgdTofhWOaW1nAB4DZsUpkPnE=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=7o9hgkds9JUIP9QqhffYOwXkz9oCnZaxKEXYqF34N9ssYibYSgl5Nlj3UjglqtdzB
 kvlUGMCt2QZKCKQOCzMYkiWPb3WtJCxD+bdcLeEdENV1LRbPiRIwGAA8ljJJj9riNW
 cbk179xEGmuBwcm/aOdVlnDaOR+aEOh4fRc781bc=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy1.enst.fr ([IPv6:::1])
 by localhost (zproxy1.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id MzcIfotiHxKp; Sun, 14 Apr 2024 19:33:58 +0200 (CEST)
Received: from inesv-Inspiron-3501.. (unknown
 [IPv6:2a02:1808:204:ac85:d9f9:fe2c:cd32:5d75])
 by zproxy1.enst.fr (Postfix) with ESMTPSA id 02F4DC0574;
 Sun, 14 Apr 2024 19:33:56 +0200 (CEST)
From: =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org, Ninad Palsule <ninad@linux.ibm.com>,
 Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?In=C3=A8s=20Varhol?= <ines.varhol@telecom-paris.fr>
Subject: [PATCH v2] tests/qtest : Use `g_assert_cmphex` instead of
 `g_assert_cmpuint`
Date: Sun, 14 Apr 2024 19:28:21 +0200
Message-ID: <20240414173349.31194-1-ines.varhol@telecom-paris.fr>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dc;
 envelope-from=ines.varhol@telecom-paris.fr; helo=zproxy1.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The messages for assertions using hexadecimal numbers will be
easier to understand with `g_assert_cmphex`.

Cases changed : "cmpuint.*0x", "cmpuint.*<<"

Signed-off-by: In=C3=A8s Varhol <ines.varhol@telecom-paris.fr>
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

diff --git a/tests/qtest/aspeed_fsi-test.c b/tests/qtest/aspeed_fsi-test.=
c
index b3020dd821..f5ab269972 100644
--- a/tests/qtest/aspeed_fsi-test.c
+++ b/tests/qtest/aspeed_fsi-test.c
@@ -63,22 +63,22 @@ static void test_fsi_setup(QTestState *s, uint32_t ba=
se_addr)
         /* Unselect FSI1 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x0);
         curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
-        g_assert_cmpuint(curval, =3D=3D, 0x0);
+        g_assert_cmphex(curval, =3D=3D, 0x0);
=20
         /* Select FSI0 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x1);
         curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
-        g_assert_cmpuint(curval, =3D=3D, 0x1);
+        g_assert_cmphex(curval, =3D=3D, 0x1);
     } else if (base_addr =3D=3D AST2600_OPB_FSI1_BASE_ADDR) {
         /* Unselect FSI0 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB0_BUS_SELECT, 0x0);
         curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_SELECT);
-        g_assert_cmpuint(curval, =3D=3D, 0x0);
+        g_assert_cmphex(curval, =3D=3D, 0x0);
=20
         /* Select FSI1 */
         aspeed_fsi_writel(s, ASPEED_FSI_OPB1_BUS_SELECT, 0x1);
         curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_SELECT);
-        g_assert_cmpuint(curval, =3D=3D, 0x1);
+        g_assert_cmphex(curval, =3D=3D, 0x1);
     } else {
         g_assert_not_reached();
     }
@@ -145,11 +145,11 @@ static void test_fsi0_getcfam_addr0(const void *dat=
a)
     aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
=20
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
-    g_assert_cmpuint(curval, =3D=3D, 0x10000);
+    g_assert_cmphex(curval, =3D=3D, 0x10000);
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB0_BUS_STATUS);
-    g_assert_cmpuint(curval, =3D=3D, 0x0);
+    g_assert_cmphex(curval, =3D=3D, 0x0);
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB0_READ_DATA);
-    g_assert_cmpuint(curval, =3D=3D, 0x152d02c0);
+    g_assert_cmphex(curval, =3D=3D, 0x152d02c0);
 }
=20
 static void test_fsi1_getcfam_addr0(const void *data)
@@ -168,11 +168,11 @@ static void test_fsi1_getcfam_addr0(const void *dat=
a)
     aspeed_fsi_writel(s, ASPEED_FSI_ENGINER_TRIGGER, 0x1);
=20
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_INTRRUPT_STATUS);
-    g_assert_cmpuint(curval, =3D=3D, 0x20000);
+    g_assert_cmphex(curval, =3D=3D, 0x20000);
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB1_BUS_STATUS);
-    g_assert_cmpuint(curval, =3D=3D, 0x0);
+    g_assert_cmphex(curval, =3D=3D, 0x0);
     curval =3D aspeed_fsi_readl(s, ASPEED_FSI_OPB1_READ_DATA);
-    g_assert_cmpuint(curval, =3D=3D, 0x152d02c0);
+    g_assert_cmphex(curval, =3D=3D, 0x152d02c0);
 }
=20
 int main(int argc, char **argv)
diff --git a/tests/qtest/cmsdk-apb-dualtimer-test.c b/tests/qtest/cmsdk-a=
pb-dualtimer-test.c
index ad6a758289..3b89bed97d 100644
--- a/tests/qtest/cmsdk-apb-dualtimer-test.c
+++ b/tests/qtest/cmsdk-apb-dualtimer-test.c
@@ -69,7 +69,7 @@ static void test_dualtimer(void)
      * tick VALUE should have wrapped round to 0xffff.
      */
     clock_step(40);
-    g_assert_cmpuint(readl(TIMER_BASE + TIMER1VALUE), =3D=3D, 0xffff);
+    g_assert_cmphex(readl(TIMER_BASE + TIMER1VALUE), =3D=3D, 0xffff);
=20
     /* Check that any write to INTCLR clears interrupt */
     writel(TIMER_BASE + TIMER1INTCLR, 1);
diff --git a/tests/qtest/cmsdk-apb-watchdog-test.c b/tests/qtest/cmsdk-ap=
b-watchdog-test.c
index 2710cb17b8..00b5dbbc81 100644
--- a/tests/qtest/cmsdk-apb-watchdog-test.c
+++ b/tests/qtest/cmsdk-apb-watchdog-test.c
@@ -88,7 +88,7 @@ static void test_clock_change(void)
=20
     /* Rewrite RCC.SYSDIV from 16 to 8, so the clock is now 40ns per tic=
k */
     rcc =3D readl(SSYS_BASE + RCC);
-    g_assert_cmpuint(extract32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH), =3D=3D=
, 0xf);
+    g_assert_cmphex(extract32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH), =3D=3D,=
 0xf);
     rcc =3D deposit32(rcc, SYSDIV_SHIFT, SYSDIV_LENGTH, 7);
     writel(SSYS_BASE + RCC, rcc);
=20
diff --git a/tests/qtest/erst-test.c b/tests/qtest/erst-test.c
index c45bee7f05..36bbe122ab 100644
--- a/tests/qtest/erst-test.c
+++ b/tests/qtest/erst-test.c
@@ -109,7 +109,7 @@ static void setup_vm_cmd(ERSTState *s, const char *cm=
d)
     g_assert_cmpuint(s->reg_barsize, =3D=3D, 16);
=20
     s->mem_bar =3D qpci_iomap(s->dev, 1, &s->mem_barsize);
-    g_assert_cmpuint(s->mem_barsize, =3D=3D, 0x2000);
+    g_assert_cmphex(s->mem_barsize, =3D=3D, 0x2000);
=20
     qpci_device_enable(s->dev);
 }
diff --git a/tests/qtest/ivshmem-test.c b/tests/qtest/ivshmem-test.c
index 9bf8e78df6..fb45fdeb07 100644
--- a/tests/qtest/ivshmem-test.c
+++ b/tests/qtest/ivshmem-test.c
@@ -158,7 +158,7 @@ static void test_ivshmem_single(void)
=20
     /* trigger interrupt via registers */
     out_reg(s, INTRMASK, 0xffffffff);
-    g_assert_cmpuint(in_reg(s, INTRMASK), =3D=3D, 0xffffffff);
+    g_assert_cmphex(in_reg(s, INTRMASK), =3D=3D, 0xffffffff);
     out_reg(s, INTRSTATUS, 1);
     /* check interrupt status */
     g_assert_cmpuint(in_reg(s, INTRSTATUS), =3D=3D, 1);
@@ -211,11 +211,11 @@ static void test_ivshmem_pair(void)
     memset(tmpshmem, 0x42, TMPSHMSIZE);
     read_mem(s1, 0, data, TMPSHMSIZE);
     for (i =3D 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], =3D=3D, 0x42);
+        g_assert_cmphex(data[i], =3D=3D, 0x42);
     }
     read_mem(s2, 0, data, TMPSHMSIZE);
     for (i =3D 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], =3D=3D, 0x42);
+        g_assert_cmphex(data[i], =3D=3D, 0x42);
     }
=20
     /* guest 1 write, guest 2 read */
@@ -224,7 +224,7 @@ static void test_ivshmem_pair(void)
     memset(data, 0, TMPSHMSIZE);
     read_mem(s2, 0, data, TMPSHMSIZE);
     for (i =3D 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], =3D=3D, 0x43);
+        g_assert_cmphex(data[i], =3D=3D, 0x43);
     }
=20
     /* guest 2 write, guest 1 read */
@@ -233,7 +233,7 @@ static void test_ivshmem_pair(void)
     memset(data, 0, TMPSHMSIZE);
     read_mem(s1, 0, data, TMPSHMSIZE);
     for (i =3D 0; i < TMPSHMSIZE; i++) {
-        g_assert_cmpuint(data[i], =3D=3D, 0x44);
+        g_assert_cmphex(data[i], =3D=3D, 0x44);
     }
=20
     cleanup_vm(s1);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 6d59c7551a..34a75b7f43 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -1046,7 +1046,7 @@ static void ahci_atapi_command_set_offset(AHCIComma=
nd *cmd, uint64_t lba)
     case CMD_ATAPI_REQUEST_SENSE:
     case CMD_ATAPI_TEST_UNIT_READY:
     case CMD_ATAPI_START_STOP_UNIT:
-        g_assert_cmpuint(lba, =3D=3D, 0x00);
+        g_assert_cmphex(lba, =3D=3D, 0x00);
         break;
     default:
         /* SCSI doesn't have uniform packet formats,
@@ -1109,7 +1109,7 @@ static void ahci_atapi_set_size(AHCICommand *cmd, u=
int64_t xbytes)
         break;
     case CMD_ATAPI_READ_CD:
         /* 24bit BE store */
-        g_assert_cmpuint(nsectors, <, 1ULL << 24);
+        g_assert_cmphex(nsectors, <, 1ULL << 24);
         tmp =3D nsectors;
         cbd[6] =3D (tmp & 0xFF0000) >> 16;
         cbd[7] =3D (tmp & 0xFF00) >> 8;
diff --git a/tests/qtest/microbit-test.c b/tests/qtest/microbit-test.c
index 72190d38f7..505c831f13 100644
--- a/tests/qtest/microbit-test.c
+++ b/tests/qtest/microbit-test.c
@@ -143,14 +143,14 @@ static void test_microbit_i2c(void)
=20
     /* MMA8653 magnetometer detection */
     val =3D i2c_read_byte(qts, 0x3A, 0x0D);
-    g_assert_cmpuint(val, =3D=3D, 0x5A);
+    g_assert_cmphex(val, =3D=3D, 0x5A);
=20
     val =3D i2c_read_byte(qts, 0x3A, 0x0D);
-    g_assert_cmpuint(val, =3D=3D, 0x5A);
+    g_assert_cmphex(val, =3D=3D, 0x5A);
=20
     /* LSM303 accelerometer detection */
     val =3D i2c_read_byte(qts, 0x3C, 0x4F);
-    g_assert_cmpuint(val, =3D=3D, 0x40);
+    g_assert_cmphex(val, =3D=3D, 0x40);
=20
     qtest_writel(qts, NRF51_TWI_BASE + NRF51_TWI_REG_ENABLE, 0);
=20
@@ -171,7 +171,7 @@ static void fill_and_erase(QTestState *qts, hwaddr ba=
se, hwaddr size,
=20
     /* Check memory */
     for (i =3D 0; i < size / 4; i++) {
-        g_assert_cmpuint(qtest_readl(qts, base + i * 4), =3D=3D, 0xFFFFF=
FFF);
+        g_assert_cmphex(qtest_readl(qts, base + i * 4), =3D=3D, 0xFFFFFF=
FF);
     }
=20
     /* Fill memory */
@@ -191,7 +191,7 @@ static void test_nrf51_nvmc(void)
=20
     /* Test always ready */
     value =3D qtest_readl(qts, NRF51_NVMC_BASE + NRF51_NVMC_READY);
-    g_assert_cmpuint(value & 0x01, =3D=3D, 0x01);
+    g_assert_cmphex(value & 0x01, =3D=3D, 0x01);
=20
     /* Test write-read config register */
     qtest_writel(qts, NRF51_NVMC_BASE + NRF51_NVMC_CONFIG, 0x03);
@@ -302,19 +302,19 @@ static void test_nrf51_gpio(void)
     g_assert_cmpuint(actual, =3D=3D, expected);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_STA=
RT)
              & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END=
) & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
=20
     /* Check clear via DIRCLR */
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIRCLR, 0x8000000=
1);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR);
-    g_assert_cmpuint(actual, =3D=3D, 0x00000000);
+    g_assert_cmphex(actual, =3D=3D, 0x00000000);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_STA=
RT)
              & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END=
) & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
=20
     /* Check set via DIR */
     expected =3D 0x80000001;
@@ -323,9 +323,9 @@ static void test_nrf51_gpio(void)
     g_assert_cmpuint(actual, =3D=3D, expected);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_STA=
RT)
              & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_END=
) & 0x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
=20
     /* Reset DIR */
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_DIR, 0x00000000);
@@ -334,33 +334,33 @@ static void test_nrf51_gpio(void)
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x00);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
=20
     /* Check pull-up working */
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 0);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000=
);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b1110=
);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
=20
     /* Check pull-down working */
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, 1);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0000=
);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b0110=
);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0x02);
     qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", 0, -1);
=20
@@ -376,11 +376,11 @@ static void test_nrf51_gpio(void)
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_CNF_START, 0b01);
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTSET, 0x01);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x01);
+    g_assert_cmphex(actual, =3D=3D, 0x01);
=20
     qtest_writel(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_OUTCLR, 0x01);
     actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN) & 0=
x01;
-    g_assert_cmpuint(actual, =3D=3D, 0x00);
+    g_assert_cmphex(actual, =3D=3D, 0x00);
=20
     /*
      * Check short-circuit - generates an guest_error which must be chec=
ked
@@ -410,7 +410,7 @@ static void test_nrf51_gpio_detect(void)
         /* Set pin high */
         qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 1)=
;
         uint32_t actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPI=
O_REG_IN);
-        g_assert_cmpuint(actual, =3D=3D, 1 << i);
+        g_assert_cmphex(actual, =3D=3D, 1 << i);
=20
         /* Check that DETECT is high */
         g_assert_true(qtest_get_irq(qts, 0));
@@ -418,7 +418,7 @@ static void test_nrf51_gpio_detect(void)
         /* Set pin low, check that DETECT goes low. */
         qtest_set_irq_in(qts, "/machine/nrf51", "unnamed-gpio-in", i, 0)=
;
         actual =3D qtest_readl(qts, NRF51_GPIO_BASE + NRF51_GPIO_REG_IN)=
;
-        g_assert_cmpuint(actual, =3D=3D, 0x0);
+        g_assert_cmphex(actual, =3D=3D, 0x0);
         g_assert_false(qtest_get_irq(qts, 0));
     }
=20
diff --git a/tests/qtest/sse-timer-test.c b/tests/qtest/sse-timer-test.c
index a65d7542d5..fd5635d4c9 100644
--- a/tests/qtest/sse-timer-test.c
+++ b/tests/qtest/sse-timer-test.c
@@ -181,12 +181,12 @@ static void test_timer(void)
     writel(TIMER_BASE + CNTP_AIVAL_CTL, 0);
     clock_step_ticks(0x42ULL << 32);
     g_assert_cmpuint(readl(TIMER_BASE + CNTPCT_LO), =3D=3D, 4400);
-    g_assert_cmpuint(readl(TIMER_BASE + CNTPCT_HI), =3D=3D, 0x42);
+    g_assert_cmphex(readl(TIMER_BASE + CNTPCT_HI), =3D=3D, 0x42);
=20
     /* Turn on the autoinc again to check AIVAL_HI */
     writel(TIMER_BASE + CNTP_AIVAL_CTL, 1);
     g_assert_cmpuint(readl(TIMER_BASE + CNTP_AIVAL_LO), =3D=3D, 4600);
-    g_assert_cmpuint(readl(TIMER_BASE + CNTP_AIVAL_HI), =3D=3D, 0x42);
+    g_assert_cmphex(readl(TIMER_BASE + CNTP_AIVAL_HI), =3D=3D, 0x42);
 }
=20
 static void test_timer_scale_change(void)
diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_ex=
ti-test.c
index 81830be8ae..7092860b9b 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -70,44 +70,44 @@ static void test_reg_write_read(void)
     /* Test that non-reserved bits in xMR and xTSR can be set and cleare=
d */
=20
     exti_writel(EXTI_IMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), =3D=3D, 0xFFFFFFFF);
     exti_writel(EXTI_IMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), =3D=3D, 0xFFFFFFFF);
     exti_writel(EXTI_EMR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x007DFFFF);
     exti_writel(EXTI_RTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR1, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x007DFFFF);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x007DFFFF);
     exti_writel(EXTI_FTSR1, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_IMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x000000FF);
     exti_writel(EXTI_IMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x000000FF);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x000000FF);
     exti_writel(EXTI_EMR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000078);
     exti_writel(EXTI_RTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0xFFFFFFFF);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000078);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000078);
     exti_writel(EXTI_FTSR2, 0x00000000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
 }
=20
 static void test_direct_lines_write(void)
@@ -115,28 +115,28 @@ static void test_direct_lines_write(void)
     /* Test that direct lines reserved bits are not written to */
=20
     exti_writel(EXTI_RTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR1, 0xFF820000);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR2, 0x00000087);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
 }
=20
 static void test_reserved_bits_write(void)
@@ -144,22 +144,22 @@ static void test_reserved_bits_write(void)
     /* Test that reserved bits stay are not written to */
=20
     exti_writel(EXTI_IMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_IMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_EMR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_EMR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_RTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_RTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_FTSR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_FTSR2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_SWIER2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
=20
     exti_writel(EXTI_PR2, 0xFFFFFF00);
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
 }
=20
 static void test_software_interrupt(void)
@@ -180,7 +180,7 @@ static void test_software_interrupt(void)
=20
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -191,9 +191,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
@@ -201,9 +201,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000001);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
@@ -214,7 +214,7 @@ static void test_software_interrupt(void)
=20
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
     /* Enable interrupt line EXTI0 */
@@ -224,9 +224,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
     /* Check that the corresponding pending bit in PR is set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000008);
     /* Check that the corresponding interrupt is pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
=20
@@ -234,9 +234,9 @@ static void test_software_interrupt(void)
     exti_writel(EXTI_PR2, 0x00000008);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the corresponding bit in SWIER was cleared */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI35_IRQ));
=20
@@ -259,16 +259,16 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on rising edge only */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -280,16 +280,16 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on falling edge only */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -300,23 +300,23 @@ static void test_edge_selector(void)
=20
     /* Test that an irq is raised on rising edge */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     /* Test that an irq is raised on falling edge */
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000001);
     g_assert_true(check_nvic_pending(EXTI0_IRQ));
=20
     /* Clean the test */
     exti_writel(EXTI_PR1, 0x00000001);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     unpend_nvic_irq(EXTI0_IRQ);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -327,11 +327,11 @@ static void test_edge_selector(void)
=20
     /* Test that no irq is raised */
     exti_set_irq(0, 1);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
     exti_set_irq(0, 0);
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
 }
=20
@@ -350,7 +350,7 @@ static void test_no_software_interrupt(void)
=20
     enable_nvic_irq(EXTI0_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -361,9 +361,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER1, 0x00000001);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
+    g_assert_cmphex(exti_readl(EXTI_SWIER1), =3D=3D, 0x00000001);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -371,7 +371,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000001);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI0_IRQ));
=20
@@ -382,7 +382,7 @@ static void test_no_software_interrupt(void)
=20
     enable_nvic_irq(EXTI35_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
@@ -393,9 +393,9 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_SWIER2, 0x00000008);
=20
     /* Check that the write in SWIER was effective */
-    g_assert_cmpuint(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
+    g_assert_cmphex(exti_readl(EXTI_SWIER2), =3D=3D, 0x00000008);
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
=20
@@ -403,7 +403,7 @@ static void test_no_software_interrupt(void)
     exti_writel(EXTI_IMR2, 0x00000008);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR2), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI35_IRQ));
 }
@@ -423,7 +423,7 @@ static void test_masked_interrupt(void)
=20
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -437,7 +437,7 @@ static void test_masked_interrupt(void)
     exti_set_irq(1, 1);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -445,7 +445,7 @@ static void test_masked_interrupt(void)
     exti_writel(EXTI_IMR1, 0x00000002);
=20
     /* Check that the pending bit in PR wasn't set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
@@ -469,7 +469,7 @@ static void test_interrupt(void)
=20
     enable_nvic_irq(EXTI1_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
=20
@@ -483,7 +483,7 @@ static void test_interrupt(void)
     exti_set_irq(1, 1);
=20
     /* Check that the pending bit in PR was set */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000002);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000002);
     /* Check that the interrupt is pending in NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
=20
@@ -491,7 +491,7 @@ static void test_interrupt(void)
     exti_writel(EXTI_PR1, 0x00000002);
=20
     /* Check that the write in PR was effective */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that the interrupt is still pending in the NVIC */
     g_assert_true(check_nvic_pending(EXTI1_IRQ));
=20
@@ -509,7 +509,7 @@ static void test_orred_interrupts(void)
      */
     enable_nvic_irq(EXTI5_9_IRQ);
     /* Check that there are no interrupts already pending in PR */
-    g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
     /* Check that this specific interrupt isn't pending in NVIC */
     g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
=20
@@ -522,11 +522,11 @@ static void test_orred_interrupts(void)
     /* Raise GPIO line i, check that the interrupt is pending */
     for (unsigned i =3D 5; i < 10; i++) {
         exti_set_irq(i, 1);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
+        g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 1 << i);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
=20
         exti_writel(EXTI_PR1, 1 << i);
-        g_assert_cmpuint(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
+        g_assert_cmphex(exti_readl(EXTI_PR1), =3D=3D, 0x00000000);
         g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
=20
         unpend_nvic_irq(EXTI5_9_IRQ);
diff --git a/tests/qtest/stm32l4x5_syscfg-test.c b/tests/qtest/stm32l4x5_=
syscfg-test.c
index ed4801798d..59bac829b7 100644
--- a/tests/qtest/stm32l4x5_syscfg-test.c
+++ b/tests/qtest/stm32l4x5_syscfg-test.c
@@ -54,27 +54,27 @@ static void test_reset(void)
     /*
      * Test that registers are initialized at the correct values
      */
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SCSR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SCSR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
=20
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0x00000000);
 }
=20
 static void test_reserved_bits(void)
@@ -87,25 +87,25 @@ static void test_reserved_bits(void)
      * register is still at reset value
      */
     syscfg_writel(SYSCFG_MEMRMP, 0xFFFFFEF8);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_CFGR1, 0x7F00FEFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x7C000001);
=20
     syscfg_writel(SYSCFG_EXTICR1, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR2, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR3, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR4, 0xFFFF0000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_SKR, 0xFFFFFF00);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
 }
=20
 static void test_set_and_clear(void)
@@ -114,40 +114,40 @@ static void test_set_and_clear(void)
      * Test that regular bits can be set and cleared
      */
     syscfg_writel(SYSCFG_MEMRMP, 0x00000107);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000107);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000107);
     syscfg_writel(SYSCFG_MEMRMP, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_MEMRMP), =3D=3D, 0x00000000);
=20
     /* cfgr1 bit 0 is clear only so we keep it set */
     syscfg_writel(SYSCFG_CFGR1, 0xFCFF0101);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0xFCFF0101);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0xFCFF0101);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000001);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000001);
=20
     syscfg_writel(SYSCFG_EXTICR1, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR1, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR1), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR2, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR2), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR3, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR3, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR3), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_EXTICR4, 0x0000FFFF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x0000FFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x0000FFFF);
     syscfg_writel(SYSCFG_EXTICR4, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_EXTICR4), =3D=3D, 0x00000000);
=20
     syscfg_writel(SYSCFG_SKR, 0x000000FF);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x000000FF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x000000FF);
     syscfg_writel(SYSCFG_SKR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SKR), =3D=3D, 0x00000000);
 }
=20
 static void test_clear_by_writing_1(void)
@@ -156,7 +156,7 @@ static void test_clear_by_writing_1(void)
      * Test that writing '1' doesn't set the bit
      */
     syscfg_writel(SYSCFG_CFGR2, 0x00000100);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x00000000);
 }
=20
 static void test_set_only_bits(void)
@@ -166,15 +166,15 @@ static void test_set_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR2, 0x0000000F);
     syscfg_writel(SYSCFG_CFGR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x0000000F);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR2), =3D=3D, 0x0000000F);
=20
     syscfg_writel(SYSCFG_SWPR, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR), =3D=3D, 0xFFFFFFFF);
=20
     syscfg_writel(SYSCFG_SWPR2, 0xFFFFFFFF);
     syscfg_writel(SYSCFG_SWPR2, 0x00000000);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0xFFFFFFFF);
+    g_assert_cmphex(syscfg_readl(SYSCFG_SWPR2), =3D=3D, 0xFFFFFFFF);
=20
     system_reset();
 }
@@ -186,7 +186,7 @@ static void test_clear_only_bits(void)
      */
     syscfg_writel(SYSCFG_CFGR1, 0x00000000);
     syscfg_writel(SYSCFG_CFGR1, 0x00000001);
-    g_assert_cmpuint(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000000);
+    g_assert_cmphex(syscfg_readl(SYSCFG_CFGR1), =3D=3D, 0x00000000);
=20
     system_reset();
 }
--=20
2.43.2


