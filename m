Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B68AC30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:59:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvq9-0000pN-ER; Wed, 03 Jul 2024 04:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpz-0000g2-U5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:41 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvpq-0005sV-Ku
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:59:36 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-424aa70fbc4so35952935e9.1
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719997169; x=1720601969; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4MgGyBVxwX1M4Hn3MnicvgZ+xuzRIKQbPBK1uXP0gk=;
 b=Y/q5GELgkF5/biDa+u8D8QnrZ4qOda6X29g1EZN/t7Lv7BYGB/PrEYJQY0/DaEU5RH
 R923hOMTyt8ADZi1t4mCtz9MgNncxpow0woe2jEJXMHA5DQQS5xr/U9iTG40H+D2i/nQ
 4IueVe/X1OaMZzpSqPSzCe9wHqV/L4GxFxyt7ToeruRcVaVnzTlGf+S1dHenK3gH6i52
 eNiE8OiznElWTftYYlnj1E0l834npQTJ9N698SVgNUj5DkB7ERgsolV4cFoSjZ1F06Oc
 QM/Q33PHXy0zrhkLANfhGS2iNI90UBqjFI7kc5vB012SWU4XpAUyBrPZafyrfhR/vdjT
 2z7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719997169; x=1720601969;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V4MgGyBVxwX1M4Hn3MnicvgZ+xuzRIKQbPBK1uXP0gk=;
 b=roGmbnMUBfD/XzUWo4cFV8hV4F6+3nf7a2iGNm5SXIaPDOaEPAR1KTqayl3q7VFyq2
 3S2KUM/HXJEkUKCi9ZmFS6ENdtorcE4bUExYwdn0iIR/vriMUL6OlSBABDzXaK3DHbut
 FZnbzsS1pZX/gFTaf1Fb7qIzFTVXwEL26youDW8uCNYINH/ghlMZn04PrYcX+cQfYb1x
 idTlqBpmD/oWfD4gCU3TJPnRD3nNg4v7bd5J4kGrY/qRwcdBEkth0QpVTHXYU+xPaGGq
 ySIuFRlU2M+NuV4Eug0TvsPaMB+FoFEa6XSQIAedByIsJw5Plwww2BUfsW98wE8YButh
 uV1Q==
X-Gm-Message-State: AOJu0Ywac3xh0CN5J2fpZWRdll8soGW3BcciXOYk+1DBoCa1nMSbKBpg
 EFb5qICqHHOdPeHu/+8i9v37A2LQATytuCYFy4rbuRb8mf+BVt49p8pftmHILe6rQeB1Bj9Zopr
 f
X-Google-Smtp-Source: AGHT+IGhK0BtFPOrUb67PinywajZa4c2vqNgVF7KDtEqAW/hBhfA4XLGCQEHOR7JPhZEJG4K4wf7UQ==
X-Received: by 2002:a05:600c:4f8f:b0:425:d61c:77b1 with SMTP id
 5b1f17b1804b1-425d61c791dmr13330675e9.35.1719997168853; 
 Wed, 03 Jul 2024 01:59:28 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b099c72sm229124995e9.37.2024.07.03.01.59.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:59:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v45 3/3] hw/sd/sdcard: Do not store vendor data on block drive
 (CMD56)
Date: Wed,  3 Jul 2024 10:59:07 +0200
Message-ID: <20240703085907.66775-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085907.66775-1-philmd@linaro.org>
References: <20240703085907.66775-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

"General command" (GEN_CMD, CMD56) is described as:

  GEN_CMD is the same as the single block read or write
  commands (CMD24 or CMD17). The difference is that [...]
  the data block is not a memory payload data but has a
  vendor specific format and meaning.

Thus this block must not be stored overwriting data block
on underlying storage drive. Keep it in a dedicated
'vendor_data[]' array.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
v43: Do not re-use VMSTATE_UNUSED_V (danpb)
v44: Use subsection (Luc)
v45: Remove APP_READ_BLOCK/APP_WRITE_BLOCK macros
---
 hw/sd/sd.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index a08a452d81..5d58937dd4 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -153,6 +153,8 @@ struct SDState {
     uint32_t data_offset;
     size_t data_size;
     uint8_t data[512];
+    uint8_t vendor_data[512];
+
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -719,6 +721,7 @@ static void sd_reset(DeviceState *dev)
     sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
     sd->wp_group_bits = sect;
     sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
+    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = INVALID_ADDRESS;
     sd->erase_end = INVALID_ADDRESS;
@@ -793,6 +796,16 @@ static const VMStateDescription sd_ocr_vmstate = {
     },
 };
 
+static const VMStateDescription sd_vendordata_vmstate = {
+    .name = "sd-card/vendor_data-state",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static int sd_vmstate_pre_load(void *opaque)
 {
     SDState *sd = opaque;
@@ -840,6 +853,7 @@ static const VMStateDescription sd_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sd_ocr_vmstate,
+        &sd_vendordata_vmstate,
         NULL
     },
 };
@@ -902,9 +916,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
-#define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
-#define APP_WRITE_BLOCK(a, len)
-
 static void sd_erase(SDState *sd)
 {
     uint64_t erase_start = sd->erase_start;
@@ -2187,9 +2198,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
-            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
+        sd->vendor_data[sd->data_offset++] = value;
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
         }
         break;
@@ -2261,12 +2271,11 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        if (sd->data_offset == 0)
-            APP_READ_BLOCK(sd->data_start, sd->blk_len);
-        ret = sd->data[sd->data_offset ++];
+        ret = sd->vendor_data[sd->data_offset++];
 
-        if (sd->data_offset >= sd->blk_len)
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
+        }
         break;
 
     default:
-- 
2.41.0


