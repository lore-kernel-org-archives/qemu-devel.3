Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBA3F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:27:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytYe-00050Y-7p; Sat, 07 Mar 2026 10:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYb-0004ze-7r
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:09 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytYZ-00085a-F1
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439c944bb62so2981998f8f.3
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897226; x=1773502026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i5IyQN2SJFLJ6QDcX5nSCyHv0PTm61zI92Uq2QIvVm4=;
 b=yeYYQtBzfmGHAO6WYKPxAOHcCEbRjOh5IQXmOrm07ZdtnZHji65M99hmhQuFc7RPgE
 FudJA/+ckOqHH/Lv0W9o5O4DSg3VvaEu27g5UQterJ5xYJTTCBcvm+rmHUAJWICW797y
 7sShfIs0KWnpiP4O1/rqW9j8oGSWrd/7ZFYN9qmIlXSVaH57Nr8GeGY/ZOxvG+rTO/5J
 qnNR95S636WzakDWNOJFwZ8ru37n/KzOiag4bYeGhaj6yTKVtbPiK8L1BbD8nRwQ7OOA
 fAwR+2ry2eZk7ezCiIbOnAZTYY7geFkjSJllSQMtl03SszPhExXhBAsNbpAmUmXFqtqG
 uzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897226; x=1773502026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i5IyQN2SJFLJ6QDcX5nSCyHv0PTm61zI92Uq2QIvVm4=;
 b=NY4V4d9d8UuJLRsABJ6HTZT2R+zy0rlsvxtPi/YN9enV5IawZDEAIQQoZ1Wb9WIa8q
 Ci4xRuztbE11kc1Ij9rgaknzUSH/M1NVKpzyI4d6uxxbbRyNzPa3Xc/pMM2PVQR/TwAv
 mIiBnrjfUENnk0+98tigvHqE+aA7s8ntoXKk/mCjd4qAFKq2SGu0mYPhvonYgE65PN/i
 /t3RbNmF8h3gUyuYYcOnFO+BZBuhLaBfEFtKCn+kWEcTggF68tAzDgB4Jv/D9gcfqBnG
 dyNeinXOuly8OfDy9XH+gjdpPdIpC9Q/0dKma2qNmmBROiCYqvBzoWUkrsE9MJeWuhKK
 aghQ==
X-Gm-Message-State: AOJu0Yw6CSiGKf8d0tTKH7nBacov3gCj257FC2PAy1So44Noy4pwuoF2
 ujmWg76oqaFq6EwIA9dep+MeNdTDvGcO8TfiIktq6JJVQKzzU9AD4bePmSvuC8luT7dYMT579Vh
 mkldqSk4=
X-Gm-Gg: ATEYQzzla87Bk6jmUvKEkp5Zqtabicd247fqdy2bWS2zxXn8C9BIfvdqA0kS7kApnLi
 EGrufQiJ4M0V6pxHxZJn+RQh1JTNKJuK1/FpkpvPjPWYZTdtdqmLaplp/gtJ0m8K03jv1q2m2Oq
 vmDNtfZqtFDeIzZqwj/eHoByAd8rrwrspVw03Whye8FUaET8Q3i+XCTQSYj5mrF2xc3LetuzboP
 A3MxBJqy6gBUWrVkMa8Xp+NpOmanZrVlvbkbx/LaVcvWFCDS9sLhyJf2OjqhB6yO3ONS/m4escB
 XVHAg0qs7lpaRjrXYJh1DpZoXaUsEc/g21KjKJ2QelDI9i1lPJJZxYJMgfSOryQhE9Se6amWMeX
 NMcoPNSx3Yz01mq/Deb4cjkRgyJWH6IEPONzvHyY8XXobvfrL0YxAk+TdMoLQzHZevMCCLfswWJ
 qJNrpDmgTfb3kQoiMROWGV7Lftlu/IuaAbn2tQe7A5VKbU7FC+pPXNHTGnOYUkjmrTQ6qENjqw
X-Received: by 2002:a05:6000:4301:b0:439:bce5:64fb with SMTP id
 ffacd0b85a97d-439da6578d6mr9835670f8f.23.1772897225598; 
 Sat, 07 Mar 2026 07:27:05 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2b9d8sm12464452f8f.21.2026.03.07.07.27.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:05 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH 04/10] hw/core/boards: Remove
 MachineClass::smbus_no_migration_support field
Date: Sat,  7 Mar 2026 16:26:28 +0100
Message-ID: <20260307152635.83893-5-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The MachineClass::smbus_no_migration_support boolean was only used
by the pc-q35-3.1 and pc-i440fx-3.1 machines, which got removed.
Remove it, along with pm_smbus_vmstate_needed().

Use the unconditional VMSTATE_BOOL() and VMSTATE_STRUCT() macros.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/boards.h  |  1 -
 include/hw/i2c/pm_smbus.h |  7 -------
 hw/acpi/piix4.c           |  8 +-------
 hw/i2c/pm_smbus.c         |  7 -------
 hw/i2c/smbus_eeprom.c     |  4 +---
 hw/i2c/smbus_ich9.c       | 10 ++--------
 6 files changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h
index 9ad2a7d5c97..e15dbcea83b 100644
--- a/include/hw/core/boards.h
+++ b/include/hw/core/boards.h
@@ -314,7 +314,6 @@ struct MachineClass {
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
     bool ignore_boot_device_suffixes;
-    bool smbus_no_migration_support;
     bool nvdimm_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
diff --git a/include/hw/i2c/pm_smbus.h b/include/hw/i2c/pm_smbus.h
index dafe0df4f69..62bbd45e803 100644
--- a/include/hw/i2c/pm_smbus.h
+++ b/include/hw/i2c/pm_smbus.h
@@ -44,13 +44,6 @@ typedef struct PMSMBus {
 
 void pm_smbus_init(DeviceState *parent, PMSMBus *smb, bool force_aux_blk);
 
-/*
- * For backwards compatibility on migration, older versions don't have
- * working migration for pm_smbus, this lets us ignore the migrations
- * for older machine versions.
- */
-bool pm_smbus_vmstate_needed(void);
-
 extern const VMStateDescription pmsmb_vmstate;
 
 #endif /* PM_SMBUS_H */
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 138ac3d3940..43860d12278 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -205,11 +205,6 @@ static const VMStateDescription vmstate_cpuhp_state = {
     }
 };
 
-static bool piix4_vmstate_need_smbus(void *opaque, int version_id)
-{
-    return pm_smbus_vmstate_needed();
-}
-
 /*
  * This is a fudge to turn off the acpi_index field,
  * whose test was always broken on piix4 with 6.2 and older machine types.
@@ -238,8 +233,7 @@ static const VMStateDescription vmstate_acpi = {
         VMSTATE_UINT16(ar.pm1.evt.en, PIIX4PMState),
         VMSTATE_UINT16(ar.pm1.cnt.cnt, PIIX4PMState),
         VMSTATE_STRUCT(apm, PIIX4PMState, 0, vmstate_apm, APMState),
-        VMSTATE_STRUCT_TEST(smb, PIIX4PMState, piix4_vmstate_need_smbus, 3,
-                            pmsmb_vmstate, PMSMBus),
+        VMSTATE_STRUCT(smb, PIIX4PMState, 3, pmsmb_vmstate, PMSMBus),
         VMSTATE_TIMER_PTR(ar.tmr.timer, PIIX4PMState),
         VMSTATE_INT64(ar.tmr.overflow_time, PIIX4PMState),
         VMSTATE_STRUCT(ar.gpe, PIIX4PMState, 2, vmstate_gpe, ACPIGPE),
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index ead53d2724d..5654d516382 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -443,13 +443,6 @@ static const MemoryRegionOps pm_smbus_ops = {
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-bool pm_smbus_vmstate_needed(void)
-{
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
-
-    return !mc->smbus_no_migration_support;
-}
-
 const VMStateDescription pmsmb_vmstate = {
     .name = "pmsmb",
     .version_id = 1,
diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
index d9ac556a0ab..693d4762205 100644
--- a/hw/i2c/smbus_eeprom.c
+++ b/hw/i2c/smbus_eeprom.c
@@ -88,11 +88,9 @@ static int eeprom_write_data(SMBusDevice *dev, uint8_t *buf, uint8_t len)
 
 static bool smbus_eeprom_vmstate_needed(void *opaque)
 {
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
     SMBusEEPROMDevice *eeprom = opaque;
 
-    return (eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev)) &&
-        !mc->smbus_no_migration_support;
+    return eeprom->accessed || smbus_vmstate_needed(&eeprom->smbusdev);
 }
 
 static const VMStateDescription vmstate_smbus_eeprom = {
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index 956c9b59bbc..51513e73fde 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -41,20 +41,14 @@ struct ICH9SMBState {
     PMSMBus smb;
 };
 
-static bool ich9_vmstate_need_smbus(void *opaque, int version_id)
-{
-    return pm_smbus_vmstate_needed();
-}
-
 static const VMStateDescription vmstate_ich9_smbus = {
     .name = "ich9_smb",
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, ICH9SMBState),
-        VMSTATE_BOOL_TEST(irq_enabled, ICH9SMBState, ich9_vmstate_need_smbus),
-        VMSTATE_STRUCT_TEST(smb, ICH9SMBState, ich9_vmstate_need_smbus, 1,
-                            pmsmb_vmstate, PMSMBus),
+        VMSTATE_BOOL(irq_enabled, ICH9SMBState),
+        VMSTATE_STRUCT(smb, ICH9SMBState, 1, pmsmb_vmstate, PMSMBus),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.52.0


