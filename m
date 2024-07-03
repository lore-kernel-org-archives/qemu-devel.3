Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F20DC31D97
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:52:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOvin-0001Xe-1I; Wed, 03 Jul 2024 04:52:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvil-0001XB-2h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOvii-00044u-9X
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:52:10 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-42641dec7c3so1446085e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719996726; x=1720601526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GULqliqQH80JFHfX+S6uCfl3unrMvquKhQ3WGcPZsrw=;
 b=HhFdsZpnEAzrT3kEpRtGisS0iC+u8u0EgSXg+h+PmOkkJzV4AvT2qBFa+ilN0jU9uu
 FgSlfzAmizsNgJ7bKWWZfwfZ4J+oiErNPal2kfyeuPQxrSfbmPzmhdn8GLD6pcBwFIXO
 PWtN6tOau6fBPptyF69hrRjwfsVbjuLyYB6dyDDHmID2XDCQoUjypLqiBmySXI2IWMOF
 wsqjeVoGBGmu9XK2SB0jfHC0e5h6TT8ETXkCZdx+OrN8oxBBYzca/Huwc3X1bTrmy8/W
 PRRVXDoP9Y52mavQ0VFq5v5ZVjdL+t9a8/BtZOS2CGQ9ddRHGWB2YZHMfilJIcQGIvD+
 GmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719996726; x=1720601526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GULqliqQH80JFHfX+S6uCfl3unrMvquKhQ3WGcPZsrw=;
 b=CCleKqLacp51AanaxCXd5WJ22UlZD6l6sYi3mtewU2E1dQseE/be3lkzWGNnJVEB5T
 3jG06+zigf6gxrZbs4O5pT6H2kRLOxOI2qLb0kv8+llyVYt/HoUFrZdm2VeIDw5aIG2S
 HbrsZ+/d3SZNS3QIJf376TqAdq7mVhe9bO1N4PAc//2I0mqQgcyq4Z/LeVR1NBxDl6ts
 DXGjsPKkGplp+CO8PkmnnGmxgtPVhtX7DGqINhlvtoZ1lms3LOSbAASpMRIalImViyt3
 RgdkHxPzh6hkcWJnt7jluFQqQanQHKT27IIYmffdVMP5VN97SP2DFTRUtB/tHVprNEju
 ts6g==
X-Gm-Message-State: AOJu0YwLbyjNPIH2NGOxIoEj2h00WJ/fFaJ1nPrFGgLI9Y7YetPejex4
 d9ckxWKxkNHofFNYREA6EC4qIvP8NhMoPsnXhbF2N5QXtpmpbTk7XjOVTiFNjfVGy7w4i0fuaA2
 s
X-Google-Smtp-Source: AGHT+IHzn8r/qR24VgNclBA6yelwvXL2lVDrgiuox7a8hFZRTgMIkMKNKctx5wArl7KJXh0XyysmVQ==
X-Received: by 2002:a05:600c:63c8:b0:424:a48a:99ff with SMTP id
 5b1f17b1804b1-4257a0257cemr69894585e9.8.1719996726347; 
 Wed, 03 Jul 2024 01:52:06 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af376easm230227865e9.5.2024.07.03.01.52.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Jul 2024 01:52:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PATCH v44 2/3] hw/sd/sdcard: Do not store vendor data on block drive
 (CMD56)
Date: Wed,  3 Jul 2024 10:51:47 +0200
Message-ID: <20240703085148.66188-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240703085148.66188-1-philmd@linaro.org>
References: <20240703085148.66188-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
---
 hw/sd/sd.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 808dc1cea6..000b923c73 100644
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
@@ -2187,9 +2201,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2261,12 +2274,11 @@ uint8_t sd_read_byte(SDState *sd)
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


