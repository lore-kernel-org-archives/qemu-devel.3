Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C432BE77184
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtzt-0002DL-Rc; Sun, 15 Dec 2024 14:09:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzp-000207-8J
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:42 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzl-0001UE-Lk
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:39 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71e16519031so1794582a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289776; x=1734894576; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ia4b9q8IgClXtnrtpseWfDFTZ/sbygoDlsprgDJCHNQ=;
 b=WsZDjSvsdVUNNH7wGbAA5OY0xlb1hHju4Ct/LZNB9mcvTkLdnx12DP19IY61W6St6z
 MYAfLz+fQ0lRYTSwPq0dFQQfYHGs+wcIkDGTEfDeO/41yFS8eMT6N5M9qtbGEcZ7iUln
 FSTe4jeCkYwaMVHqNS/0aW0uBHvWAyJAer28ytcJUHt6rKMCE4MFEmzvp04X6ulVsV5k
 g9o4Zzg3HALULuyE4iMIuRQ8sa6iG2SK89wJQa3DhF/CIwkAwOk9JWibdQ1p5w0YP+89
 BoQW/Vmf6HTOhsKhNHXcxEt2soqxZvpa1XdvF6tNMQti522ubhgj3t032QfEr2uBzFjh
 n2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289776; x=1734894576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ia4b9q8IgClXtnrtpseWfDFTZ/sbygoDlsprgDJCHNQ=;
 b=bp3UYUWCXx2DtFnCI4UREvrdPNMWghDkFFhVuipw0q8FCxcNGifd1X59ybQQu3HpwA
 MqloPUJThZDtw08108/s1q5DwWjrlnrB8/CJhBN/YOCGXmDxixJ/WpBfLA/zO31wlzOB
 K9m/Ua0j6CWWT3Oze2JGz4E3GN+UgtmzaQM9OntU3/jiwVfnz+zH2EaNKWL5qGY2287x
 xZqnzQlrlB5gRQCuWVwyRdgNqPlwvtbF8VI3Jkrq372Qvj7HojFd5fyfLcOZXS7oKBr+
 TLOuQx0lzitaSdSDHZbZbDemUZjM+4o19S5OoVqXxjPBl9BXdPOxlNN7QYk2UfYtLzy+
 M2Nw==
X-Gm-Message-State: AOJu0YyzPnlSdyuMkhSOV510XpO0SZI3xBdsWFLx6hBL0zRaHJhRxDDD
 Jp+PmWVLMYxwSKITmQ5SaP2ltpv5DOPrNnNnFn3X+GtVlaqBqOfZ6h/TBP8glwwbwz4xENkMoX0
 ZOhXeWqLk
X-Gm-Gg: ASbGnctHYt5DvHXh4eZonVLPunElHbv1ypXa+JMezx7RXtoS7JKA6r9VFtUUbELNgKW
 Yf3gxnSMSJP6TkP6C3MLbDb7cjqfc0ZXqm9v/VQb5n8BWQSxBbNfzn+7u2lB/ij5hKkYr9F5zGh
 aumoBeTyW2EjWPbasa2H6zK0h+Z+3jXskmMesEi/D01H/vrGT8DdLvAnp2kIxAtBUhsFLJ/Lfs+
 hTkEAdCiMz/6gTu1yjQuKBq4j5sVdS7P53xyvrkAAQcBv1YwolnnkrMSMFiSiNnVndaP6QxX2J7
 5w25gjn5Eh5rh9h8b35iTMTMRKVwqWiri5GM7T0bgYs=
X-Google-Smtp-Source: AGHT+IFiZYMz24MSR29FmU4hdMs4To49Dm/1f5ieEJYA0XyGZ/athccta/61VpiNIvWQNBV5VHrxgw==
X-Received: by 2002:a05:6830:3108:b0:710:a425:d6b8 with SMTP id
 46e09a7af769-71e3beb2739mr4881467a34.14.1734289776348; 
 Sun, 15 Dec 2024 11:09:36 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 43/67] hw/nvram: Constify all Property
Date: Sun, 15 Dec 2024 13:05:09 -0600
Message-ID: <20241215190533.3222854-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/nvram/ds1225y.c                 | 2 +-
 hw/nvram/eeprom_at24c.c            | 2 +-
 hw/nvram/fw_cfg.c                  | 6 +++---
 hw/nvram/mac_nvram.c               | 2 +-
 hw/nvram/nrf51_nvm.c               | 2 +-
 hw/nvram/spapr_nvram.c             | 2 +-
 hw/nvram/xlnx-bbram.c              | 2 +-
 hw/nvram/xlnx-efuse.c              | 2 +-
 hw/nvram/xlnx-versal-efuse-cache.c | 2 +-
 hw/nvram/xlnx-versal-efuse-ctrl.c  | 2 +-
 hw/nvram/xlnx-zynqmp-efuse.c       | 2 +-
 11 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/hw/nvram/ds1225y.c b/hw/nvram/ds1225y.c
index 6d510dcc68..19bf8d2091 100644
--- a/hw/nvram/ds1225y.c
+++ b/hw/nvram/ds1225y.c
@@ -142,7 +142,7 @@ static void nvram_sysbus_realize(DeviceState *dev, Error **errp)
     nvram_post_load(s, 0);
 }
 
-static Property nvram_sysbus_properties[] = {
+static const Property nvram_sysbus_properties[] = {
     DEFINE_PROP_UINT32("size", SysBusNvRamState, nvram.chip_size, 0x2000),
     DEFINE_PROP_STRING("filename", SysBusNvRamState, nvram.filename),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index ec748e58e7..669920b2b9 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -234,7 +234,7 @@ void at24c_eeprom_reset(DeviceState *state)
     ee->haveaddr = 0;
 }
 
-static Property at24c_eeprom_props[] = {
+static const Property at24c_eeprom_props[] = {
     DEFINE_PROP_UINT32("rom-size", EEPROMState, rsize, 0),
     DEFINE_PROP_UINT8("address-size", EEPROMState, asize, 0),
     DEFINE_PROP_BOOL("writable", EEPROMState, writable, true),
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 97def3a88b..7461d99ff2 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1082,7 +1082,7 @@ static void fw_cfg_machine_ready(struct Notifier *n, void *data)
     qemu_register_reset(fw_cfg_machine_reset, s);
 }
 
-static Property fw_cfg_properties[] = {
+static const Property fw_cfg_properties[] = {
     DEFINE_PROP_BOOL("acpi-mr-restore", FWCfgState, acpi_mr_restore, true),
     DEFINE_PROP_END_OF_LIST(),
 };
@@ -1273,7 +1273,7 @@ static void fw_cfg_file_slots_allocate(FWCfgState *s, Error **errp)
     s->entry_order = g_new0(int, fw_cfg_max_entry(s));
 }
 
-static Property fw_cfg_io_properties[] = {
+static const Property fw_cfg_io_properties[] = {
     DEFINE_PROP_BOOL("dma_enabled", FWCfgIoState, parent_obj.dma_enabled,
                      true),
     DEFINE_PROP_UINT16("x-file-slots", FWCfgIoState, parent_obj.file_slots,
@@ -1322,7 +1322,7 @@ static const TypeInfo fw_cfg_io_info = {
 };
 
 
-static Property fw_cfg_mem_properties[] = {
+static const Property fw_cfg_mem_properties[] = {
     DEFINE_PROP_UINT32("data_width", FWCfgMemState, data_width, -1),
     DEFINE_PROP_BOOL("dma_enabled", FWCfgMemState, parent_obj.dma_enabled,
                      true),
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index e47e52a677..d62ad719c8 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -134,7 +134,7 @@ static void macio_nvram_unrealizefn(DeviceState *dev)
     g_free(s->data);
 }
 
-static Property macio_nvram_properties[] = {
+static const Property macio_nvram_properties[] = {
     DEFINE_PROP_UINT32("size", MacIONVRAMState, size, 0),
     DEFINE_PROP_UINT32("it_shift", MacIONVRAMState, it_shift, 0),
     DEFINE_PROP_DRIVE("drive", MacIONVRAMState, blk),
diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
index b1f81752a3..236049462b 100644
--- a/hw/nvram/nrf51_nvm.c
+++ b/hw/nvram/nrf51_nvm.c
@@ -354,7 +354,7 @@ static void nrf51_nvm_reset(DeviceState *dev)
     memset(s->uicr_content, 0xFF, sizeof(s->uicr_content));
 }
 
-static Property nrf51_nvm_properties[] = {
+static const Property nrf51_nvm_properties[] = {
     DEFINE_PROP_UINT32("flash-size", NRF51NVMState, flash_size, 0x40000),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
index bfd8aa367e..2251ff2f4c 100644
--- a/hw/nvram/spapr_nvram.c
+++ b/hw/nvram/spapr_nvram.c
@@ -252,7 +252,7 @@ static const VMStateDescription vmstate_spapr_nvram = {
     },
 };
 
-static Property spapr_nvram_properties[] = {
+static const Property spapr_nvram_properties[] = {
     DEFINE_SPAPR_PROPERTIES(SpaprNvram, sdev),
     DEFINE_PROP_DRIVE("drive", SpaprNvram, blk),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/xlnx-bbram.c b/hw/nvram/xlnx-bbram.c
index 1bc58e90ad..4fa528f048 100644
--- a/hw/nvram/xlnx-bbram.c
+++ b/hw/nvram/xlnx-bbram.c
@@ -520,7 +520,7 @@ static const VMStateDescription vmstate_bbram_ctrl = {
     }
 };
 
-static Property bbram_ctrl_props[] = {
+static const Property bbram_ctrl_props[] = {
     DEFINE_PROP("drive", XlnxBBRam, blk, bbram_prop_drive, BlockBackend *),
     DEFINE_PROP_UINT32("crc-zpads", XlnxBBRam, crc_zpads, 1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index f7b849f7de..5dae9e8e9a 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -265,7 +265,7 @@ static const PropertyInfo efuse_prop_drive = {
     .release = efuse_prop_release_drive,
 };
 
-static Property efuse_properties[] = {
+static const Property efuse_properties[] = {
     DEFINE_PROP("drive", XlnxEFuse, blk, efuse_prop_drive, BlockBackend *),
     DEFINE_PROP_UINT8("efuse-nr", XlnxEFuse, efuse_nr, 3),
     DEFINE_PROP_UINT32("efuse-size", XlnxEFuse, efuse_size, 64 * 32),
diff --git a/hw/nvram/xlnx-versal-efuse-cache.c b/hw/nvram/xlnx-versal-efuse-cache.c
index eaec64d785..1aea27afd3 100644
--- a/hw/nvram/xlnx-versal-efuse-cache.c
+++ b/hw/nvram/xlnx-versal-efuse-cache.c
@@ -83,7 +83,7 @@ static void efuse_cache_init(Object *obj)
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
-static Property efuse_cache_props[] = {
+static const Property efuse_cache_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxVersalEFuseCache, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 8252a5cabe..599aa126fb 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -743,7 +743,7 @@ static const VMStateDescription vmstate_efuse_ctrl = {
     }
 };
 
-static Property efuse_ctrl_props[] = {
+static const Property efuse_ctrl_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxVersalEFuseCtrl, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
diff --git a/hw/nvram/xlnx-zynqmp-efuse.c b/hw/nvram/xlnx-zynqmp-efuse.c
index 4e2d1b9d1e..af53187905 100644
--- a/hw/nvram/xlnx-zynqmp-efuse.c
+++ b/hw/nvram/xlnx-zynqmp-efuse.c
@@ -833,7 +833,7 @@ static const VMStateDescription vmstate_efuse = {
     }
 };
 
-static Property zynqmp_efuse_props[] = {
+static const Property zynqmp_efuse_props[] = {
     DEFINE_PROP_LINK("efuse",
                      XlnxZynqMPEFuse, efuse,
                      TYPE_XLNX_EFUSE, XlnxEFuse *),
-- 
2.43.0


