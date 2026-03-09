Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCCAAF41807
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcus-0003lO-CN; Mon, 09 Mar 2026 11:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcuj-0003XY-6Q
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzcug-0008AE-Um
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:53:00 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48534237460so18198695e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773071576; x=1773676376; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UjlYj7EvBnMKHImEQ8XvxuaNoxFu0RUHBwONjSEDr6Y=;
 b=WURiTKvcRwwzHW+kRYmrHgJ6Wcqhsozd5mMYeRNk8eu2B3ptH50bfD6B4ho97EOdh0
 wk34Etsb1DS0zQcyHP4Tnha2Grizxu6hB6Nh0MZvwwmH/VW7KuKv2uEPyIJSuFbuJdgg
 5QRwuIQKeeQBXrYmxdZAET/Gh0HzAZ9H24lsirMrwiLlSazTMSzpxRdXLtQKUAZDstIh
 jcMQrlMT3c9kGfgY2sUli5uurnJgfO/WneDgTcPK6V2d9ByhqO5jVQcg0hecW4a1CIuj
 WwgD/mviA2nIhA5D1/mIdfbluuMDX+Q0UpCehEeO8NWa8OgVNvi6kgySq+yMF/4/8549
 Ca6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773071576; x=1773676376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UjlYj7EvBnMKHImEQ8XvxuaNoxFu0RUHBwONjSEDr6Y=;
 b=HmKFQP5p9T7fNv6vb/TQPQ79qpec+unSwJ04/wM4k3BFoqSk/T8ioSLM5GNHaHW7OF
 hPINoWufCGS5ChTfq4xEadgy3dLukZkL3xpBXxMqzN+NHJob1qpdeZD1BE6y4IUbvC6k
 q0RZqeEz3+wBXUGi1hxeolOfPHAk91k1841O+nTW1qVIo31ZO/MswGUSehKnMaUYyPNH
 Ku8ITb02Ijji+/m6MQhE+cFB7EYwNblZ5iuQ8UwCopDE7urEtgK2ANGE8QVvJR+93/5j
 Az426vpseY9l6Ylqc+1XCRFDsTq+SaZgVBqt/L4rPJSgdWGTUtRWCLxScD9W+cYw1qqp
 AEaQ==
X-Gm-Message-State: AOJu0Yx0qVsrsVMwwanN1o1Y4mqBEofF8hzIuZgAhudKK7X7/MbdA17A
 iWwAMelF80VCViC71JDpp5+JHZciETb3eTA6gOxN68wisDfgE+Rsudx8YkZrjB6M4bQK/yNXT46
 AgSw3Clg=
X-Gm-Gg: ATEYQzw5dzpP+zmGdgSz9qKQRqKihWgKcdLjvxdY83kHu8HvcW9xULtqj+1+0q2O1Gl
 ffTfcyfn10xZ6JhPIXwwNazi/red6uqkFwmEeX9cNHpSq06ugDdBP+GlYgfbBESHl301nzlfl6I
 6cmrDRtQuDBUxce3mzhQYYcPcprDKAIiKje3Z9KtoYoghL0Kd15rMAmh4dwt/BY7e3cu5+J5H0L
 0p0spMz3NO9APxJy3dSDjkWMhmpcFKsV4QWpllvboTESMDk6dDwkzeiBy3rHl8PLZN5OBtRR5D6
 pR+oJxwV4BgdkiFqcd1vzaxb+wkhtAZwAonknrIIKRvbS0Ynjbz8H5GhrMauBYzv04h0p+ua2ih
 bP22RiV2MTLuaqk9t/JErj1aP3f7i1yaaEq/ev/3MIqK1KnvpuW/MXY9d9xGyqKYi01ulPSzW1S
 eKbU873PvVcEDtQWXZp/bW8MHoRnX45yN98cUuTCc0uWai6ysMVkNFCN6xn1mEc0xJT7ENnZ9y
X-Received: by 2002:a05:600c:310f:b0:485:390d:74f8 with SMTP id
 5b1f17b1804b1-485390d7719mr77360355e9.25.1773071575711; 
 Mon, 09 Mar 2026 08:52:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485419c2930sm2739455e9.0.2026.03.09.08.52.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 09 Mar 2026 08:52:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/49] hw/core/boards: Remove
 MachineClass::smbus_no_migration_support field
Date: Mon,  9 Mar 2026 16:51:35 +0100
Message-ID: <20260309155219.62400-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309155219.62400-1-philmd@linaro.org>
References: <20260309155219.62400-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Corey Minyard <corey@minyard.net>
Message-Id: <20260307152635.83893-5-philmd@linaro.org>
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
2.53.0


