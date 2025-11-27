Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 276BCD11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 12:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObEm-0001Rh-7i; Thu, 27 Nov 2025 07:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vObEa-0001Qh-1U
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 07:36:29 -0500
Received: from m16.mail.163.com ([220.197.31.3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alanosong@163.com>) id 1vObEU-0008Rl-C2
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 07:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=YM
 QzfcmVAO/ZKbbAKahlxEw6B3E/ozn2+Lf9iFneBwg=; b=UUhgONcJOLgzpGirlo
 8BHunCrFtk1sOnFPmwWdTLH7pSTMiJG8awtRheAWR2VULECECG8LIHPuH/LeEwKk
 5AhrnU6IHUB4npTXIlLuFE3nCugVSmP20O0d40L/i++6YN48/s8lMGpkqgi5MjZe
 ybVONjU6/UB6AI55Xyy8Flirs=
Received: from DESKTOP-V2BFH29.localdomain (unknown [])
 by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id
 _____wD3Dn2zRShpZxBLCg--.1138S2; 
 Thu, 27 Nov 2025 20:36:05 +0800 (CST)
From: AlanoSong@163.com
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, anisinha@redhat.com,
 Alano Song <AlanoSong@163.com>
Subject: [PATCH] hw/acpi: Add aml_gpio_io() wrapper for GPIO IO Connection
Date: Thu, 27 Nov 2025 20:36:02 +0800
Message-ID: <20251127123602.24478-1-AlanoSong@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3Dn2zRShpZxBLCg--.1138S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWr1xJryxGF4UKF1ktF4fXwb_yoW5XF4Upr
 s2yanxtr1UJF17XrZ8Jr1DCFs3KF4vkw4ayFZFvrna9FW7Z34vvF1DtFn09a4agr1qyrWU
 Wa9Yqw18WaykZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRDrcsUUUUU=
X-Originating-IP: [59.174.57.70]
X-CM-SenderInfo: xdod00pvrqwqqrwthudrp/xtbC1BXi9mkoRbXFwgAA3j
Received-SPF: pass client-ip=220.197.31.3; envelope-from=alanosong@163.com;
 helo=m16.mail.163.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

According to ACPI 5.0 section 19.5.54, I add aml_gpio_io()
wrapper for GPIO IO Connection purpose.

Signed-off-by: Alano Song <AlanoSong@163.com>
---
 hw/acpi/aml-build.c         | 19 +++++++++++++++++++
 include/hw/acpi/aml-build.h | 17 +++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 2d5826a8f1..b4dd0bc665 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -962,6 +962,25 @@ Aml *aml_gpio_int(AmlConsumerAndProducer con_and_pro,
                                vendor_data_len);
 }
 
+/*
+ * ACPI 5.0: 19.5.54
+ * GpioIo(GPIO Connection IO Resource Descriptor Macro)
+ */
+Aml *aml_gpio_io(AmlConsumerAndProducer con_and_pro,
+                 AmlIoRestriction io_restriction, AmlShared shared,
+                 AmlPinConfig pin_config, uint16_t debounce_timeout,
+                 const uint32_t pin_list[], uint32_t pin_count,
+                 const char *resource_source_name,
+                 const uint8_t *vendor_data, uint16_t vendor_data_len)
+{
+    uint8_t flags = io_restriction | shared << 3;
+
+    return aml_gpio_connection(AML_IO_CONNECTION, con_and_pro, flags,
+                               pin_config, 0, debounce_timeout, pin_list,
+                               pin_count, resource_source_name, vendor_data,
+                               vendor_data_len);
+}
+
 /*
  * ACPI 1.0b: 6.4.3.4 32-Bit Fixed Location Memory Range Descriptor
  * (Type 1, Large Item Name 0x6)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index f38e129719..f5c0c5886b 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -167,6 +167,17 @@ typedef enum {
     AML_ACTIVE_LOW = 1,
 } AmlActiveHighAndLow;
 
+/*
+ * ACPI 5.0: Table 5-133 Predefined ACPI Names
+ * _IOR field definition
+ */
+typedef enum {
+    AML_IO_RESTRICTION_NONE = 0,
+    AML_IO_RESTRICTION_INPUT_ONLY = 1,
+    AML_IO_RESTRICTION_OUTPUT_ONLY = 2,
+    AML_IO_RESTRICTION_NONE_AND_PRESERVE = 3,
+} AmlIoRestriction;
+
 /*
  * ACPI 5.0: Table 6-187 Extended Interrupt Descriptor Definition
  * _SHR field definition
@@ -331,6 +342,12 @@ Aml *aml_gpio_int(AmlConsumerAndProducer con_and_pro,
                   const uint32_t pin_list[], uint32_t pin_count,
                   const char *resource_source_name,
                   const uint8_t *vendor_data, uint16_t vendor_data_len);
+Aml *aml_gpio_io(AmlConsumerAndProducer con_and_pro,
+                 AmlIoRestriction io_restriction, AmlShared shared,
+                 AmlPinConfig pin_config, uint16_t debounce_timeout,
+                 const uint32_t pin_list[], uint32_t pin_count,
+                 const char *resource_source_name,
+                 const uint8_t *vendor_data, uint16_t vendor_data_len);
 Aml *aml_memory32_fixed(uint32_t addr, uint32_t size,
                         AmlReadAndWrite read_and_write);
 Aml *aml_interrupt(AmlConsumerAndProducer con_and_pro,
-- 
2.43.0


