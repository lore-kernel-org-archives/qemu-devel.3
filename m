Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC1BC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 00:02:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubT6V-0002TU-A8; Mon, 14 Jul 2025 20:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6R-00024Z-26
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:59 -0400
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jackson88044@gmail.com>)
 id 1ubT6O-000872-IB
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 20:00:58 -0400
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6fad3400ea3so46462596d6.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 17:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752537655; x=1753142455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f9JWU2FZpgLiV+EApCTTz/IH02kEm79kNGELQwRX6z0=;
 b=DU8ppqiCO5iGmg73UUUlR4HjaXXNyiO4RwQ8AH+hUVOgAc4r80NOYf1XXJ+ukJTvio
 yGrVAFqHy0MkdO2bFBMYFE+wmwmIiL0gMWbJ1Nfe3A4cReEi3u6PIo3FmNkBZbazLKDG
 SksQlKqzRklURpnJa9jTmudUVfq6cjQFaSZ3mTzugvlCBZmqjAOpGuoNl8878zHHoHn6
 uqBBK5EF5T7ISFpFkBMTvLhQK1yEWUFlGOGF598tgMOfBqUKq60Rt2lTL/cklRqY4xcA
 YWRnoEiemhn4fcCzVTFmK0D8JD//ojpPDft+XDfCQ6yzpwOfuDq+1dVEsN+Y8ImNsdeG
 +qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752537655; x=1753142455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f9JWU2FZpgLiV+EApCTTz/IH02kEm79kNGELQwRX6z0=;
 b=gPKcf5aDBDurAUbXnllG5KnPIDOKkjjcQAH1NEsHAiAItrpU4SLyvjBMQSP/8DdNks
 yreKLz0/n+s4RJlwEfwGVogY5+++IcXvXeBf5iRJIy9NYiV0HD7AQSbthDg40I7CUV6T
 9QMH3pbpPXbInrwjQpWrvFeITtote3UMB9/LhMXQWmm6yUak7FL43yRYTAGpOITgHAlp
 WMjIf6U9LU4s/0YgMkkvUj4gwTQBwVgcrznFCA48ddRQnSCo+NduQU84SIJOPiEqmKmt
 TNwaMnaAp+b60P8/HALF2NO1fh8UU4GXxa/JyDVm2vW+KzWiB0SH/8FQgjwu1CIJ3uLu
 A5UQ==
X-Gm-Message-State: AOJu0YyUi/nAdEmDWvLdMAsemKKxTxi5fsjwzoFuRJ+4u/AE1M0s9CVM
 WXoyZlItg9PdL3A2eE/YQskazlcW55F3bJIeiatgwVIlVgQ5A4Faldl9AmcLTw==
X-Gm-Gg: ASbGncvgh7w6Pe1YvOEuppkIuYZHNpkz/t/zIeaeUuGWUsIl1OV7aeeY/mXjBGBBQph
 G/qQhMILdHblf+IM2uTft+PEXN9Oww5h1GIif8iRtBnn9plK1cv31kIh1MTSmBRUgno8vmwJshz
 peNY4gfIyFen+vp2gQ+OmdMjqIieYeA8EHizWPZwkEBvI+b5ACA5LFaZcyIIoKGJdTGDDq4WgOk
 QxxzLL8k7vECaZRRA/t13z5VHYHdVdKJI1vPBeE1i0M/T9rzN9XwuiUMTQJmtdQzbThPeQ2PM4Y
 Yl6xSK3qzcpfMJ0Fn+xXKKhjjPPb9tIEAq8fpTmzvk28no0rwFwrtEcf/nvEYTFZB8OJY0CJPN/
 HW43K08620uo/Kggh/+JRLbPRxL93sx/xd1V40oupxtgLbJwBOi8Vw+h+jw==
X-Google-Smtp-Source: AGHT+IFLQPNLPdg2SHQ02ZguYdMEj6gMUafbvBmcUYxT6RhNu/l04uYGvlswJxEDN8Z+crZCcTSLyA==
X-Received: by 2002:ad4:5606:0:b0:704:e120:50da with SMTP id
 6a1803df08f44-704e1205517mr14756096d6.29.1752537654861; 
 Mon, 14 Jul 2025 17:00:54 -0700 (PDT)
Received: from user-jcksn.mynetworksettings.com
 ([2600:4040:b51a:4200:2f17:e99b:e0cd:fdf7])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-70497d8eee2sm52296276d6.97.2025.07.14.17.00.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 17:00:54 -0700 (PDT)
From: Jackson Donaldson <jackson88044@gmail.com>
X-Google-Original-From: Jackson Donaldson <jcksn@duck.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v5 10/11] MAX78000: AES implementation
Date: Mon, 14 Jul 2025 20:00:44 -0400
Message-Id: <20250715000045.57332-11-jcksn@duck.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715000045.57332-1-jcksn@duck.com>
References: <20250715000045.57332-1-jcksn@duck.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f33;
 envelope-from=jackson88044@gmail.com; helo=mail-qv1-xf33.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This commit implements AES for the MAX78000

Signed-off-by: Jackson Donaldson <jcksn@duck.com>
---
 hw/arm/Kconfig                 |   1 +
 hw/misc/Kconfig                |   3 +
 hw/misc/max78000_aes.c         | 229 +++++++++++++++++++++++++++++++++
 hw/misc/max78000_gcr.c         |   6 +
 hw/misc/meson.build            |   1 +
 include/hw/misc/max78000_aes.h |  68 ++++++++++
 include/hw/misc/max78000_gcr.h |   1 +
 7 files changed, 309 insertions(+)
 create mode 100644 hw/misc/max78000_aes.c
 create mode 100644 include/hw/misc/max78000_aes.h

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index fcac62be6f..3e41120c89 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -370,6 +370,7 @@ config MAX78000_SOC
     select MAX78000_UART
     select MAX78000_GCR
     select MAX78000_TRNG
+    select MAX78000_AES
 
 config RASPI
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index dd6a6e54da..c27285b47a 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -47,6 +47,9 @@ config A9SCU
 config ARM11SCU
     bool
 
+config MAX78000_AES
+    bool
+
 config MAX78000_GCR
     bool
 
diff --git a/hw/misc/max78000_aes.c b/hw/misc/max78000_aes.c
new file mode 100644
index 0000000000..d883ddd2b6
--- /dev/null
+++ b/hw/misc/max78000_aes.c
@@ -0,0 +1,229 @@
+/*
+ * MAX78000 AES
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "trace.h"
+#include "hw/irq.h"
+#include "migration/vmstate.h"
+#include "hw/misc/max78000_aes.h"
+#include "crypto/aes.h"
+
+static void max78000_aes_set_status(Max78000AesState *s)
+{
+    s->status = 0;
+    if (s->result_index >= 16) {
+        s->status |= OUTPUT_FULL;
+    }
+    if (s->result_index == 0) {
+        s->status |= OUTPUT_EMPTY;
+    }
+    if (s->data_index >= 16) {
+        s->status |= INPUT_FULL;
+    }
+    if (s->data_index == 0) {
+        s->status |= INPUT_EMPTY;
+    }
+}
+
+static uint64_t max78000_aes_read(void *opaque, hwaddr addr,
+                                    unsigned int size)
+{
+    Max78000AesState *s = opaque;
+    switch (addr) {
+    case CTRL:
+        return s->ctrl;
+
+    case STATUS:
+        return s->status;
+
+    case INTFL:
+        return s->intfl;
+
+    case INTEN:
+        return s->inten;
+
+    case FIFO:
+        if (s->result_index >= 4) {
+            s->intfl &= ~DONE;
+            s->result_index -= 4;
+            max78000_aes_set_status(s);
+            return ldl_be_p(&s->result[s->result_index]);
+        } else{
+            return 0;
+        }
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+
+    }
+    return 0;
+}
+
+static void max78000_aes_do_crypto(Max78000AesState *s)
+{
+    int keylen = 256;
+    uint8_t *keydata = s->key;
+    if ((s->ctrl & KEY_SIZE) == 0) {
+        keylen = 128;
+        keydata += 16;
+    } else if ((s->ctrl & KEY_SIZE) == 1 << 6) {
+        keylen = 192;
+        keydata += 8;
+    }
+
+    /*
+     * The MAX78000 AES engine stores an internal key, which it uses only
+     * for decryption. This results in the slighly odd looking pairs of
+     * set_encrypt and set_decrypt calls below; s->internal_key is
+     * being stored for later use in both cases.
+     */
+    AES_KEY key;
+    if ((s->ctrl & TYPE) == 0) {
+        AES_set_encrypt_key(keydata, keylen, &key);
+        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
+        AES_encrypt(s->data, s->result, &key);
+        s->result_index = 16;
+    } else if ((s->ctrl & TYPE) == 1 << 8) {
+        AES_set_decrypt_key(keydata, keylen, &key);
+        AES_set_decrypt_key(keydata, keylen, &s->internal_key);
+        AES_decrypt(s->data, s->result, &key);
+        s->result_index = 16;
+    } else{
+        AES_decrypt(s->data, s->result, &s->internal_key);
+        s->result_index = 16;
+    }
+    s->intfl |= DONE;
+}
+
+static void max78000_aes_write(void *opaque, hwaddr addr,
+                    uint64_t val64, unsigned int size)
+{
+    Max78000AesState *s = opaque;
+    uint32_t val = val64;
+    switch (addr) {
+    case CTRL:
+        if (val & OUTPUT_FLUSH) {
+            s->result_index = 0;
+            val &= ~OUTPUT_FLUSH;
+        }
+        if (val & INPUT_FLUSH) {
+            s->data_index = 0;
+            val &= ~INPUT_FLUSH;
+        }
+        if (val & START) {
+            max78000_aes_do_crypto(s);
+        }
+
+        /* Hardware appears to stay enabled even if 0 written */
+        s->ctrl = val | (s->ctrl & AES_EN);
+        break;
+
+    case FIFO:
+        assert(s->data_index <= 12);
+        stl_be_p(&s->data[12 - s->data_index], val);
+        s->data_index += 4;
+        if (s->data_index >= 16) {
+            s->data_index = 0;
+            max78000_aes_do_crypto(s);
+        }
+        break;
+
+    case KEY_BASE ... KEY_END - 4:
+        stl_be_p(&s->key[(KEY_END - KEY_BASE - 4) - (addr - KEY_BASE)], val);
+        break;
+
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"
+            HWADDR_PRIx "\n", __func__, addr);
+        break;
+
+    }
+    max78000_aes_set_status(s);
+}
+
+static void max78000_aes_reset_hold(Object *obj, ResetType type)
+{
+    Max78000AesState *s = MAX78000_AES(obj);
+    s->ctrl = 0;
+    s->status = 0;
+    s->intfl = 0;
+    s->inten = 0;
+
+    s->data_index = 0;
+    s->result_index = 0;
+
+    memset(s->data, 0, sizeof(s->data));
+    memset(s->key, 0, sizeof(s->key));
+    memset(s->result, 0, sizeof(s->result));
+    memset(&s->internal_key, 0, sizeof(s->internal_key));
+}
+
+static const MemoryRegionOps max78000_aes_ops = {
+    .read = max78000_aes_read,
+    .write = max78000_aes_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+};
+
+static const VMStateDescription vmstate_max78000_aes = {
+    .name = TYPE_MAX78000_AES,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT32(ctrl, Max78000AesState),
+        VMSTATE_UINT32(status, Max78000AesState),
+        VMSTATE_UINT32(intfl, Max78000AesState),
+        VMSTATE_UINT32(inten, Max78000AesState),
+        VMSTATE_UINT8_ARRAY(data, Max78000AesState, 16),
+        VMSTATE_UINT8_ARRAY(key, Max78000AesState, 32),
+        VMSTATE_UINT8_ARRAY(result, Max78000AesState, 16),
+        VMSTATE_UINT32_ARRAY(internal_key.rd_key, Max78000AesState, 60),
+        VMSTATE_INT32(internal_key.rounds, Max78000AesState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void max78000_aes_init(Object *obj)
+{
+    Max78000AesState *s = MAX78000_AES(obj);
+    sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    memory_region_init_io(&s->mmio, obj, &max78000_aes_ops, s,
+                        TYPE_MAX78000_AES, 0xc00);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
+
+}
+
+static void max78000_aes_class_init(ObjectClass *klass, const void *data)
+{
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    rc->phases.hold = max78000_aes_reset_hold;
+    dc->vmsd = &vmstate_max78000_aes;
+
+}
+
+static const TypeInfo max78000_aes_info = {
+    .name          = TYPE_MAX78000_AES,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Max78000AesState),
+    .instance_init = max78000_aes_init,
+    .class_init    = max78000_aes_class_init,
+};
+
+static void max78000_aes_register_types(void)
+{
+    type_register_static(&max78000_aes_info);
+}
+
+type_init(max78000_aes_register_types)
diff --git a/hw/misc/max78000_gcr.c b/hw/misc/max78000_gcr.c
index 5916ee615a..fbbc92cca3 100644
--- a/hw/misc/max78000_gcr.c
+++ b/hw/misc/max78000_gcr.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/char/max78000_uart.h"
 #include "hw/misc/max78000_trng.h"
+#include "hw/misc/max78000_aes.h"
 #include "hw/misc/max78000_gcr.h"
 
 
@@ -161,6 +162,9 @@ static void max78000_gcr_write(void *opaque, hwaddr addr,
         if (val & TRNG_RESET) {
             device_cold_reset(s->trng);
         }
+        if (val & AES_RESET) {
+            device_cold_reset(s->aes);
+        }
         /* TODO: As other devices are implemented, add them here */
         break;
 
@@ -263,6 +267,8 @@ static const Property max78000_gcr_properties[] = {
                      TYPE_MAX78000_UART, DeviceState*),
     DEFINE_PROP_LINK("trng", Max78000GcrState, trng,
                         TYPE_MAX78000_TRNG, DeviceState*),
+    DEFINE_PROP_LINK("aes", Max78000GcrState, aes,
+                        TYPE_MAX78000_AES, DeviceState*),
 };
 
 static const MemoryRegionOps max78000_gcr_ops = {
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index c7c57d924b..b1d8d8e5d2 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -70,6 +70,7 @@ system_ss.add(when: 'CONFIG_IMX', if_true: files(
   'imx_ccm.c',
   'imx_rngc.c',
 ))
+system_ss.add(when: 'CONFIG_MAX78000_AES', if_true: files('max78000_aes.c'))
 system_ss.add(when: 'CONFIG_MAX78000_GCR', if_true: files('max78000_gcr.c'))
 system_ss.add(when: 'CONFIG_MAX78000_ICC', if_true: files('max78000_icc.c'))
 system_ss.add(when: 'CONFIG_MAX78000_TRNG', if_true: files('max78000_trng.c'))
diff --git a/include/hw/misc/max78000_aes.h b/include/hw/misc/max78000_aes.h
new file mode 100644
index 0000000000..407c45ef61
--- /dev/null
+++ b/include/hw/misc/max78000_aes.h
@@ -0,0 +1,68 @@
+/*
+ * MAX78000 AES
+ *
+ * Copyright (c) 2025 Jackson Donaldson <jcksn@duck.com>
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_MAX78000_AES_H
+#define HW_MAX78000_AES_H
+
+#include "hw/sysbus.h"
+#include "crypto/aes.h"
+#include "qom/object.h"
+
+#define TYPE_MAX78000_AES "max78000-aes"
+OBJECT_DECLARE_SIMPLE_TYPE(Max78000AesState, MAX78000_AES)
+
+#define CTRL 0
+#define STATUS 4
+#define INTFL 8
+#define INTEN 0xc
+#define FIFO 0x10
+
+#define KEY_BASE 0x400
+#define KEY_END 0x420
+
+/* CTRL */
+#define TYPE (1 << 9 | 1 << 8)
+#define KEY_SIZE (1 << 7 | 1 << 6)
+#define OUTPUT_FLUSH (1 << 5)
+#define INPUT_FLUSH (1 << 4)
+#define START (1 << 3)
+
+#define AES_EN (1 << 0)
+
+/* STATUS */
+#define OUTPUT_FULL (1 << 4)
+#define OUTPUT_EMPTY (1 << 3)
+#define INPUT_FULL (1 << 2)
+#define INPUT_EMPTY (1 << 1)
+#define BUSY (1 << 0)
+
+/* INTFL*/
+#define DONE (1 << 0)
+
+struct Max78000AesState {
+    SysBusDevice parent_obj;
+
+    MemoryRegion mmio;
+
+    uint32_t ctrl;
+    uint32_t status;
+    uint32_t intfl;
+    uint32_t inten;
+    uint32_t data_index;
+    uint8_t data[16];
+
+    uint8_t key[32];
+    AES_KEY internal_key;
+
+    uint32_t result_index;
+    uint8_t result[16];
+
+
+    qemu_irq irq;
+};
+
+#endif
diff --git a/include/hw/misc/max78000_gcr.h b/include/hw/misc/max78000_gcr.h
index 23ddf0885b..d5858a40f3 100644
--- a/include/hw/misc/max78000_gcr.h
+++ b/include/hw/misc/max78000_gcr.h
@@ -124,6 +124,7 @@ struct Max78000GcrState {
     DeviceState *uart1;
     DeviceState *uart2;
     DeviceState *trng;
+    DeviceState *aes;
 
 };
 
-- 
2.34.1


