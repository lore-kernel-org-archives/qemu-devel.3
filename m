Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A2FAC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 13:49:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rokh6-0002hs-FW; Mon, 25 Mar 2024 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rokh1-0002ed-6o
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1rokgy-0001oX-2k
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 09:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711374527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VaH6K/ABk6YQuJNNhWyqrYmxsgNY5PnuamIwvpzT35o=;
 b=VtY4DBeIJdRSwQ5PzvLjjNaRgyCnEifeJE5A9YYoOBI0MZMz0DWYq1DquTmQIDgPUvlkaK
 TElgBO3ofOzWCibnLzd9Om0beSSOcszmDu+xxnINV7Nc1+L4hAw2ZxYDiknXalU6+siUbO
 LYhy6wGE44vbjG1LP5ytskuIHgoGHBc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-BV9l-_hpNYG3UXhpoXojSA-1; Mon, 25 Mar 2024 09:48:42 -0400
X-MC-Unique: BV9l-_hpNYG3UXhpoXojSA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B7F485A58C;
 Mon, 25 Mar 2024 13:48:41 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED07C2024517;
 Mon, 25 Mar 2024 13:48:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Glenn Miles <milesg@linux.vnet.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH] misc/pca955*: Move models under hw/gpio
Date: Mon, 25 Mar 2024 14:48:32 +0100
Message-ID: <20240325134833.1484265-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The PCA9552 and PCA9554 devices are both I2C GPIO controllers and the
PCA9552 also can drive LEDs. Do all the necessary adjustments to move
the models under hw/gpio.

Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 MAINTAINERS                              | 4 ++--
 include/hw/{misc => gpio}/pca9552.h      | 0
 include/hw/{misc => gpio}/pca9552_regs.h | 0
 include/hw/{misc => gpio}/pca9554.h      | 0
 include/hw/{misc => gpio}/pca9554_regs.h | 0
 hw/arm/aspeed.c                          | 2 +-
 hw/{misc => gpio}/pca9552.c              | 4 ++--
 hw/{misc => gpio}/pca9554.c              | 4 ++--
 tests/qtest/pca9552-test.c               | 2 +-
 tests/qtest/pnv-host-i2c-test.c          | 4 ++--
 hw/gpio/meson.build                      | 2 ++
 hw/gpio/trace-events                     | 4 ++++
 hw/misc/meson.build                      | 2 --
 hw/misc/trace-events                     | 4 ----
 14 files changed, 16 insertions(+), 16 deletions(-)
 rename include/hw/{misc => gpio}/pca9552.h (100%)
 rename include/hw/{misc => gpio}/pca9552_regs.h (100%)
 rename include/hw/{misc => gpio}/pca9554.h (100%)
 rename include/hw/{misc => gpio}/pca9554_regs.h (100%)
 rename hw/{misc => gpio}/pca9552.c (99%)
 rename hw/{misc => gpio}/pca9554.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 409d7db4d457..a07af6b9d48e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1549,8 +1549,8 @@ M: Glenn Miles <milesg@linux.vnet.ibm.com>
 L: qemu-ppc@nongnu.org
 L: qemu-arm@nongnu.org
 S: Odd Fixes
-F: hw/misc/pca955*.c
-F: include/hw/misc/pca955*.h
+F: hw/gpio/pca955*.c
+F: include/hw/gpio/pca955*.h
 
 virtex_ml507
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
diff --git a/include/hw/misc/pca9552.h b/include/hw/gpio/pca9552.h
similarity index 100%
rename from include/hw/misc/pca9552.h
rename to include/hw/gpio/pca9552.h
diff --git a/include/hw/misc/pca9552_regs.h b/include/hw/gpio/pca9552_regs.h
similarity index 100%
rename from include/hw/misc/pca9552_regs.h
rename to include/hw/gpio/pca9552_regs.h
diff --git a/include/hw/misc/pca9554.h b/include/hw/gpio/pca9554.h
similarity index 100%
rename from include/hw/misc/pca9554.h
rename to include/hw/gpio/pca9554.h
diff --git a/include/hw/misc/pca9554_regs.h b/include/hw/gpio/pca9554_regs.h
similarity index 100%
rename from include/hw/misc/pca9554_regs.h
rename to include/hw/gpio/pca9554_regs.h
diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 729f66941462..badf6f6fa09d 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -18,7 +18,7 @@
 #include "hw/block/flash.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
-#include "hw/misc/pca9552.h"
+#include "hw/gpio/pca9552.h"
 #include "hw/nvram/eeprom_at24c.h"
 #include "hw/sensor/tmp105.h"
 #include "hw/misc/led.h"
diff --git a/hw/misc/pca9552.c b/hw/gpio/pca9552.c
similarity index 99%
rename from hw/misc/pca9552.c
rename to hw/gpio/pca9552.c
index 2ae13af35e93..27d4db068095 100644
--- a/hw/misc/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -15,8 +15,8 @@
 #include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "hw/qdev-properties.h"
-#include "hw/misc/pca9552.h"
-#include "hw/misc/pca9552_regs.h"
+#include "hw/gpio/pca9552.h"
+#include "hw/gpio/pca9552_regs.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/hw/misc/pca9554.c b/hw/gpio/pca9554.c
similarity index 99%
rename from hw/misc/pca9554.c
rename to hw/gpio/pca9554.c
index 5e31696797d9..7d10a64ba7c1 100644
--- a/hw/misc/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -11,8 +11,8 @@
 #include "qemu/module.h"
 #include "qemu/bitops.h"
 #include "hw/qdev-properties.h"
-#include "hw/misc/pca9554.h"
-#include "hw/misc/pca9554_regs.h"
+#include "hw/gpio/pca9554.h"
+#include "hw/gpio/pca9554_regs.h"
 #include "hw/irq.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
diff --git a/tests/qtest/pca9552-test.c b/tests/qtest/pca9552-test.c
index ccca2b3d9140..747495769239 100644
--- a/tests/qtest/pca9552-test.c
+++ b/tests/qtest/pca9552-test.c
@@ -12,7 +12,7 @@
 #include "libqtest.h"
 #include "libqos/qgraph.h"
 #include "libqos/i2c.h"
-#include "hw/misc/pca9552_regs.h"
+#include "hw/gpio/pca9552_regs.h"
 
 #define PCA9552_TEST_ID   "pca9552-test"
 #define PCA9552_TEST_ADDR 0x60
diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index c6351772520c..7f64d597ac1d 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -8,8 +8,8 @@
  */
 #include "qemu/osdep.h"
 #include "libqtest.h"
-#include "hw/misc/pca9554_regs.h"
-#include "hw/misc/pca9552_regs.h"
+#include "hw/gpio/pca9554_regs.h"
+#include "hw/gpio/pca9552_regs.h"
 #include "pnv-xscom.h"
 
 #define PPC_BIT(bit)            (0x8000000000000000ULL >> (bit))
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build
index 791e93a97bcc..a7495d196ae9 100644
--- a/hw/gpio/meson.build
+++ b/hw/gpio/meson.build
@@ -2,6 +2,8 @@ system_ss.add(when: 'CONFIG_GPIO_KEY', if_true: files('gpio_key.c'))
 system_ss.add(when: 'CONFIG_GPIO_MPC8XXX', if_true: files('mpc8xxx.c'))
 system_ss.add(when: 'CONFIG_GPIO_PWR', if_true: files('gpio_pwr.c'))
 system_ss.add(when: 'CONFIG_MAX7310', if_true: files('max7310.c'))
+system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
+system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PL061', if_true: files('pl061.c'))
 system_ss.add(when: 'CONFIG_ZAURUS', if_true: files('zaurus.c'))
 
diff --git a/hw/gpio/trace-events b/hw/gpio/trace-events
index 9331f4289d5a..b91cc7e9a45d 100644
--- a/hw/gpio/trace-events
+++ b/hw/gpio/trace-events
@@ -13,6 +13,10 @@ nrf51_gpio_write(uint64_t offset, uint64_t value) "offset 0x%" PRIx64 " value 0x
 nrf51_gpio_set(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
 nrf51_gpio_update_output_irq(int64_t line, int64_t value) "line %" PRIi64 " value %" PRIi64
 
+# pca9552.c
+pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
+pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
+
 # pl061.c
 pl061_update(const char *id, uint32_t dir, uint32_t data, uint32_t pullups, uint32_t floating) "%s GPIODIR 0x%x GPIODATA 0x%x pullups 0x%x floating 0x%x"
 pl061_set_output(const char *id, int gpio, int level) "%s setting output %d to %d"
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 8e1ddc00f9b2..dd6cf89a5449 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -3,8 +3,6 @@ system_ss.add(when: 'CONFIG_EDU', if_true: files('edu.c'))
 system_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmcoreinfo.c'))
 system_ss.add(when: 'CONFIG_ISA_DEBUG', if_true: files('debugexit.c'))
 system_ss.add(when: 'CONFIG_ISA_TESTDEV', if_true: files('pc-testdev.c'))
-system_ss.add(when: 'CONFIG_PCA9552', if_true: files('pca9552.c'))
-system_ss.add(when: 'CONFIG_PCA9554', if_true: files('pca9554.c'))
 system_ss.add(when: 'CONFIG_PCI_TESTDEV', if_true: files('pci-testdev.c'))
 system_ss.add(when: 'CONFIG_UNIMP', if_true: files('unimp.c'))
 system_ss.add(when: 'CONFIG_EMPTY_SLOT', if_true: files('empty_slot.c'))
diff --git a/hw/misc/trace-events b/hw/misc/trace-events
index 0374eb33ac52..4896001f35de 100644
--- a/hw/misc/trace-events
+++ b/hw/misc/trace-events
@@ -340,10 +340,6 @@ grlib_apb_pnp_read(uint64_t addr, unsigned size, uint32_t value) "APB PnP read a
 led_set_intensity(const char *color, const char *desc, uint8_t intensity_percent) "LED desc:'%s' color:%s intensity: %u%%"
 led_change_intensity(const char *color, const char *desc, uint8_t old_intensity_percent, uint8_t new_intensity_percent) "LED desc:'%s' color:%s intensity %u%% -> %u%%"
 
-# pca9552.c
-pca955x_gpio_status(const char *description, const char *buf) "%s GPIOs 0-15 [%s]"
-pca955x_gpio_change(const char *description, unsigned id, unsigned prev_state, unsigned current_state) "%s GPIO id:%u status: %u -> %u"
-
 # bcm2835_cprman.c
 bcm2835_cprman_read(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
 bcm2835_cprman_write(uint64_t offset, uint64_t value) "offset:0x%" PRIx64 " value:0x%" PRIx64
-- 
2.44.0


