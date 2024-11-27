Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F93D6ACE4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 15:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGJdy-0003al-OT; Wed, 27 Nov 2024 10:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGJcn-0001xt-Ci
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 10:06:42 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1tGJcj-000061-EW
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 10:06:40 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434aafd68e9so6374365e9.0
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 07:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1732719996; x=1733324796;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eD7MJs3r84SBzX4ObGFcoh1sx/E1Dk/XLpA94N0Z7Bk=;
 b=GR+OPAAge+8z2ZRMljsB2WyZHXvS8l5/OLAeniLqFlo3l/sRJHLBYI6qmca4nlt3ko
 Lu1JX0edXELqVThqhAtH2RWrmRTgbkBQmOddt+baUDi2clvljAB98o0b6chn1uHuTw5i
 mavhbShWDSmQNiWA0/dccpmIZDU7p2pKkDfZDWHHtN8qUBv22A+XL4RxBCyZ6ouaEhYs
 tQPMnWnZ5mh09VzFF7ayJEDrTRY0bNY3eyplqgTPRrIQq3aX/bAFrLk7RK/kMZ0jRHMe
 os8yG0I2jPjcXhcZk3frPT/iF818kDXYgvFyiDNAqSgLFOxM6BSM5xpWx+JTqDgRDkWt
 1Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732719996; x=1733324796;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eD7MJs3r84SBzX4ObGFcoh1sx/E1Dk/XLpA94N0Z7Bk=;
 b=uWAxfQuWIx4uyJHcnjEuVsUf068sTWeOOJgBzJqBAIL1xmMzzzsWR5Gp4Z0jMDJgxV
 1CWYDAWaHjHzX9XeyKqfdWIcOmF2/1DPD/37tGFCKlbo6LIm0wwWxlVoem7ZcFOgTBeR
 IfmUk4PFB1ZYHkcqHEH5o5TJLBwBw00L2Hj3+EtiUEzgljSk+KTVagwpVD51qYIg7Zbw
 sisuacJY5iucab1caduIFPTa1bDGMuVcajd5PUW/WyYhH/Ofdikh/ITZY/vDSdeKn5nR
 zg4060ObPv2F9ALlsupXkTGPIDcB+/1RwHGPb+BefU5w2fur3kPZkUtRcCywXwwbTUZd
 z9pg==
X-Gm-Message-State: AOJu0YxX4u/j44oYoBeROztYejLtC+R8gRBuzuxWsSBmLwbZ6KsEU/4v
 0EWr8AQdh9318MA1RkVBU4xvnyl+Ysx2PWuUjwJagEeRpRHwLczo6vwttOqLmJI0gzDBtkbH+DF
 3Xg==
X-Gm-Gg: ASbGncu0Q5pH/jERsC9DCWSFbj91dINbsI3je5UBck7X/ectgTZYGVxNa4UrDhpU/uu
 rDjebrud+RbzXKOdHXBHu1lWdaGlxLaR5ulOQawC56o0gGEEQPzT0jBEopeG80PGorYwMUY/Jc6
 dwW/vuYxoRKwZyT6DXut13Uz4W2YOfAYPaTuODZ5Mz0FuPI32nwnwt89d0JyxWyTrYknItMqML/
 Zzov6qiFNtTif303JusAyS0iICLD3JNKhsyAunYTeeH5bHwspV5c/tDS7fwhwWk0diUEB/uRzX+
 rqhL2dv4gem2pLsNjXnujHUpgw==
X-Google-Smtp-Source: AGHT+IFEjNWkw8ImJOXY2equf7Aswm7Pww+0lP86AH9ijvJsdpZ4SE+Hmsy1gGlOUn67s/uS7tbAbQ==
X-Received: by 2002:a05:600c:4fc1:b0:434:a29d:6c71 with SMTP id
 5b1f17b1804b1-434a9df0385mr30198195e9.27.1732719987286; 
 Wed, 27 Nov 2024 07:06:27 -0800 (PST)
Received: from localhost.localdomain (h082218084190.host.wavenet.at.
 [82.218.84.190]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7e256esm23339155e9.32.2024.11.27.07.06.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 27 Nov 2024 07:06:26 -0800 (PST)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: agraf@csgraf.de, phil@philjordan.eu, peter.maydell@linaro.org,
 pbonzini@redhat.com, rad@semihalf.com, quic_llindhol@quicinc.com,
 stefanha@redhat.com, mst@redhat.com, slp@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, gaosong@loongson.cn, jiaxun.yang@flygoat.com,
 chenhuacai@kernel.org, kwolf@redhat.com, hreitz@redhat.com,
 philmd@linaro.org, shorne@gmail.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 jcmvbkbc@gmail.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 akihiko.odaki@daynix.com, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 qemu-riscv@nongnu.org, balaton@eik.bme.hu, Alexander Graf <graf@amazon.com>
Subject: [PATCH v11 12/15] hw/vmapple/cfg: Introduce vmapple cfg region
Date: Wed, 27 Nov 2024 16:02:46 +0100
Message-Id: <20241127150249.50767-13-phil@philjordan.eu>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241127150249.50767-1-phil@philjordan.eu>
References: <20241127150249.50767-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::32a;
 envelope-from=phil@philjordan.eu; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

From: Alexander Graf <graf@amazon.com>

Instead of device tree or other more standardized means, VMApple passes
platform configuration to the first stage boot loader in a binary encoded
format that resides at a dedicated RAM region in physical address space.

This patch models this configuration space as a qdev device which we can
then map at the fixed location in the address space. That way, we can
influence and annotate all configuration fields easily.

Signed-off-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---

v3:

 * Replaced legacy device reset method with Resettable method

v4:

 * Fixed initialisation of default values for properties
 * Dropped superfluous endianness conversions
 * Moved most header code to .c, device name #define goes in vmapple.h

v5:

 * Improved error reporting in case of string property buffer overflow.

v7:

 * Changed error messages for overrun of properties with
   fixed-length strings to be more useful to users than developers.

v8:

 * Consistent parenthesising of macro arguments for better safety.

v10:

 * Slightly tidier error reporting for overlong property values.

 hw/vmapple/Kconfig           |   3 +
 hw/vmapple/cfg.c             | 196 +++++++++++++++++++++++++++++++++++
 hw/vmapple/meson.build       |   1 +
 include/hw/vmapple/vmapple.h |   2 +
 4 files changed, 202 insertions(+)
 create mode 100644 hw/vmapple/cfg.c

diff --git a/hw/vmapple/Kconfig b/hw/vmapple/Kconfig
index 68f88876eb9..8bbeb9a9237 100644
--- a/hw/vmapple/Kconfig
+++ b/hw/vmapple/Kconfig
@@ -4,3 +4,6 @@ config VMAPPLE_AES
 config VMAPPLE_BDIF
     bool
 
+config VMAPPLE_CFG
+    bool
+
diff --git a/hw/vmapple/cfg.c b/hw/vmapple/cfg.c
new file mode 100644
index 00000000000..d854b49269b
--- /dev/null
+++ b/hw/vmapple/cfg.c
@@ -0,0 +1,196 @@
+/*
+ * VMApple Configuration Region
+ *
+ * Copyright © 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/vmapple/vmapple.h"
+#include "hw/sysbus.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "net/net.h"
+
+OBJECT_DECLARE_SIMPLE_TYPE(VMAppleCfgState, VMAPPLE_CFG)
+
+#define VMAPPLE_CFG_SIZE 0x00010000
+
+typedef struct VMAppleCfg {
+    uint32_t version;         /* 0x000 */
+    uint32_t nr_cpus;         /* 0x004 */
+    uint32_t unk1;            /* 0x008 */
+    uint32_t unk2;            /* 0x00c */
+    uint32_t unk3;            /* 0x010 */
+    uint32_t unk4;            /* 0x014 */
+    uint64_t ecid;            /* 0x018 */
+    uint64_t ram_size;        /* 0x020 */
+    uint32_t run_installer1;  /* 0x028 */
+    uint32_t unk5;            /* 0x02c */
+    uint32_t unk6;            /* 0x030 */
+    uint32_t run_installer2;  /* 0x034 */
+    uint32_t rnd;             /* 0x038 */
+    uint32_t unk7;            /* 0x03c */
+    MACAddr mac_en0;          /* 0x040 */
+    uint8_t pad1[2];
+    MACAddr mac_en1;          /* 0x048 */
+    uint8_t pad2[2];
+    MACAddr mac_wifi0;        /* 0x050 */
+    uint8_t pad3[2];
+    MACAddr mac_bt0;          /* 0x058 */
+    uint8_t pad4[2];
+    uint8_t reserved[0xa0];   /* 0x060 */
+    uint32_t cpu_ids[0x80];   /* 0x100 */
+    uint8_t scratch[0x200];   /* 0x180 */
+    char serial[32];          /* 0x380 */
+    char unk8[32];            /* 0x3a0 */
+    char model[32];           /* 0x3c0 */
+    uint8_t unk9[32];         /* 0x3e0 */
+    uint32_t unk10;           /* 0x400 */
+    char soc_name[32];        /* 0x404 */
+} VMAppleCfg;
+
+struct VMAppleCfgState {
+    SysBusDevice parent_obj;
+    VMAppleCfg cfg;
+
+    MemoryRegion mem;
+    char *serial;
+    char *model;
+    char *soc_name;
+};
+
+static void vmapple_cfg_reset(Object *obj, ResetType type)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(obj);
+    VMAppleCfg *cfg;
+
+    cfg = memory_region_get_ram_ptr(&s->mem);
+    memset(cfg, 0, VMAPPLE_CFG_SIZE);
+    *cfg = s->cfg;
+}
+
+static bool set_fixlen_property_or_error(char *restrict dst,
+                                         const char *restrict src,
+                                         size_t dst_size, Error **errp,
+                                         const char *property_name)
+{
+    ERRP_GUARD();
+    size_t len;
+
+    len = g_strlcpy(dst, src, dst_size);
+    if (len < dst_size) { /* len does not count nul terminator */
+        return true;
+    }
+
+    error_setg(errp, "Provided value too long for property '%s'", property_name);
+    error_append_hint(errp, "length (%zu) exceeds maximum of %zu\n",
+                      len, dst_size - 1);
+    return false;
+}
+
+#define set_fixlen_property_or_return(dst_array, src, errp, property_name) \
+    do { \
+        if (!set_fixlen_property_or_error((dst_array), (src), \
+                                          ARRAY_SIZE(dst_array), \
+                                          (errp), (property_name))) { \
+            return; \
+        } \
+    } while (0)
+
+static void vmapple_cfg_realize(DeviceState *dev, Error **errp)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(dev);
+    uint32_t i;
+
+    if (!s->serial) {
+        s->serial = g_strdup("1234");
+    }
+    if (!s->model) {
+        s->model = g_strdup("VM0001");
+    }
+    if (!s->soc_name) {
+        s->soc_name = g_strdup("Apple M1 (Virtual)");
+    }
+
+    set_fixlen_property_or_return(s->cfg.serial, s->serial, errp, "serial");
+    set_fixlen_property_or_return(s->cfg.model, s->model, errp, "model");
+    set_fixlen_property_or_return(s->cfg.soc_name, s->soc_name, errp, "soc_name");
+    set_fixlen_property_or_return(s->cfg.unk8, "D/A", errp, "unk8");
+    s->cfg.version = 2;
+    s->cfg.unk1 = 1;
+    s->cfg.unk2 = 1;
+    s->cfg.unk3 = 0x20;
+    s->cfg.unk4 = 0;
+    s->cfg.unk5 = 1;
+    s->cfg.unk6 = 1;
+    s->cfg.unk7 = 0;
+    s->cfg.unk10 = 1;
+
+    if (s->cfg.nr_cpus > ARRAY_SIZE(s->cfg.cpu_ids)) {
+        error_setg(errp,
+                   "Failed to create %u CPUs, vmapple machine supports %zu max",
+                   s->cfg.nr_cpus, ARRAY_SIZE(s->cfg.cpu_ids));
+        return;
+    }
+    for (i = 0; i < s->cfg.nr_cpus; i++) {
+        s->cfg.cpu_ids[i] = i;
+    }
+}
+
+static void vmapple_cfg_init(Object *obj)
+{
+    VMAppleCfgState *s = VMAPPLE_CFG(obj);
+
+    memory_region_init_ram(&s->mem, obj, "VMApple Config", VMAPPLE_CFG_SIZE,
+                           &error_fatal);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mem);
+}
+
+static Property vmapple_cfg_properties[] = {
+    DEFINE_PROP_UINT32("nr-cpus", VMAppleCfgState, cfg.nr_cpus, 1),
+    DEFINE_PROP_UINT64("ecid", VMAppleCfgState, cfg.ecid, 0),
+    DEFINE_PROP_UINT64("ram-size", VMAppleCfgState, cfg.ram_size, 0),
+    DEFINE_PROP_UINT32("run_installer1", VMAppleCfgState, cfg.run_installer1, 0),
+    DEFINE_PROP_UINT32("run_installer2", VMAppleCfgState, cfg.run_installer2, 0),
+    DEFINE_PROP_UINT32("rnd", VMAppleCfgState, cfg.rnd, 0),
+    DEFINE_PROP_MACADDR("mac-en0", VMAppleCfgState, cfg.mac_en0),
+    DEFINE_PROP_MACADDR("mac-en1", VMAppleCfgState, cfg.mac_en1),
+    DEFINE_PROP_MACADDR("mac-wifi0", VMAppleCfgState, cfg.mac_wifi0),
+    DEFINE_PROP_MACADDR("mac-bt0", VMAppleCfgState, cfg.mac_bt0),
+    DEFINE_PROP_STRING("serial", VMAppleCfgState, serial),
+    DEFINE_PROP_STRING("model", VMAppleCfgState, model),
+    DEFINE_PROP_STRING("soc_name", VMAppleCfgState, soc_name),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void vmapple_cfg_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
+
+    dc->realize = vmapple_cfg_realize;
+    dc->desc = "VMApple Configuration Region";
+    device_class_set_props(dc, vmapple_cfg_properties);
+    rc->phases.hold = vmapple_cfg_reset;
+}
+
+static const TypeInfo vmapple_cfg_info = {
+    .name          = TYPE_VMAPPLE_CFG,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(VMAppleCfgState),
+    .instance_init = vmapple_cfg_init,
+    .class_init    = vmapple_cfg_class_init,
+};
+
+static void vmapple_cfg_register_types(void)
+{
+    type_register_static(&vmapple_cfg_info);
+}
+
+type_init(vmapple_cfg_register_types)
diff --git a/hw/vmapple/meson.build b/hw/vmapple/meson.build
index d4624713deb..64b78693a31 100644
--- a/hw/vmapple/meson.build
+++ b/hw/vmapple/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(when: 'CONFIG_VMAPPLE_AES',  if_true: files('aes.c'))
 system_ss.add(when: 'CONFIG_VMAPPLE_BDIF', if_true: files('bdif.c'))
+system_ss.add(when: 'CONFIG_VMAPPLE_CFG',  if_true: files('cfg.c'))
diff --git a/include/hw/vmapple/vmapple.h b/include/hw/vmapple/vmapple.h
index 9090e9c5ac8..3bba59f5ec7 100644
--- a/include/hw/vmapple/vmapple.h
+++ b/include/hw/vmapple/vmapple.h
@@ -16,4 +16,6 @@
 
 #define TYPE_VMAPPLE_BDIF "vmapple-bdif"
 
+#define TYPE_VMAPPLE_CFG "vmapple-cfg"
+
 #endif /* HW_VMAPPLE_VMAPPLE_H */
-- 
2.39.5 (Apple Git-154)


