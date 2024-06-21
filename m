Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D7CC2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJZ-0002HZ-0D; Fri, 21 Jun 2024 04:08:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJW-00026A-TY
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJV-00008x-91
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:08:06 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42198492353so15656125e9.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957283; x=1719562083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qHkD/9LfuqpSjqb2mzBbMf8GF2z2q7mW//xxpk6LGc4=;
 b=nEOrne24IypY8qe9EB8u2LxFPLrRTv3lnOPw3oqicn1HEKtMFhpInduKz19c1z9tLL
 aAE6vTUyAyxiSAK8oTWT+Fjcz1YUEB/QZKwdS8ZcR1KeYa7mt9FP/6byFp9o6OluNXJS
 JUH4PwKceDLDPUlGhasBEYmbkjN4FPeVLi9b3Gi6MuLbmVzqMB43kbRiG1uDPitAzwE8
 hipZjbdwbrLt6MAevT+5ZfZDZ53xX2efFOE0YMkvdb491i5Q9Qktkm4Uwl2hm5Mi4kNz
 AUkwd5OQkkYLfCVfiQLuiH5g/pqIxF2/k6bNJXN6zMjJ4HMU6qkLxQn3vt+vqsOaL/sD
 qfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957283; x=1719562083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qHkD/9LfuqpSjqb2mzBbMf8GF2z2q7mW//xxpk6LGc4=;
 b=gjVP/vdoAXN99rhIPz3sCrMFu+Pon9iSPt+8pjF5Zg8hKdGPz8+XUzPLbRlVRSdeKI
 aIh92Z7z4BrAfRrL3E9iMZIlqZERM+mW1v/wNuUEtnZubQe2ojlMb9UhUUTxKKKiXPKA
 ZNGAqGFKP4jYs2hmGYIH4iq5fpC9/RdD1Sm7VC0mPbHuwd0+6FnT4Ux3ZgUHAsG3Y1an
 oCWOZ7m1y2dLnM2wEp5JNJybfa6Xo6stRx1/D25teoJFURqi5/5BUxW0YJhoh0oy8knq
 NHfS3HAsBVsKWMPy3+XpSeqEcci/XZQS9inwFg60uSEpFoyH5bR4wxNJWRjsBaeg2b2q
 WFBQ==
X-Gm-Message-State: AOJu0YwGKdqR9wEMAMazdskHccb0G046GoQKlkHt0mLKzQnG3naELEqc
 jE2OxoX7vQWG5FBgAbZinhJhhnzV7TymNkQrqz+dciYdc2ZHMWM202zj3shVRGboHUTkwFbZDoY
 P
X-Google-Smtp-Source: AGHT+IE+07FWD1HD+iLXztwcy908d7cHYMN3e4/OV1PssO4as9rMtk5a2We2Haoa+wkRzyMpCyN3OA==
X-Received: by 2002:a05:600c:2e09:b0:421:79c8:dd37 with SMTP id
 5b1f17b1804b1-4247529d570mr50153715e9.40.1718957283661; 
 Fri, 21 Jun 2024 01:08:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248482f1c4sm2264205e9.10.2024.06.21.01.08.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:08:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 21/23] hw/sd/sdcard: Do not store vendor data on block drive
 (CMD56)
Date: Fri, 21 Jun 2024 10:05:52 +0200
Message-ID: <20240621080554.18986-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
to be the same size)?

Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
---
 hw/sd/sd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 95e23abd30..712fbc0926 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -143,6 +143,8 @@ struct SDState {
     uint64_t data_start;
     uint32_t data_offset;
     uint8_t data[512];
+    uint8_t vendor_data[512];
+
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -647,6 +649,7 @@ static void sd_reset(DeviceState *dev)
     sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
     sd->wp_group_bits = sect;
     sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
+    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = INVALID_ADDRESS;
     sd->erase_end = INVALID_ADDRESS;
@@ -762,7 +765,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT64(data_start, SDState),
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
-        VMSTATE_UNUSED_V(1, 512),
+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
     },
@@ -2019,9 +2022,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
-            APP_WRITE_BLOCK(sd->data_start, sd->data_offset);
+        sd->vendor_data[sd->data_offset ++] = value;
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
         }
         break;
@@ -2155,12 +2157,11 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 56:  /* CMD56:  GEN_CMD */
-        if (sd->data_offset == 0)
-            APP_READ_BLOCK(sd->data_start, sd->blk_len);
-        ret = sd->data[sd->data_offset ++];
+        ret = sd->vendor_data[sd->data_offset ++];
 
-        if (sd->data_offset >= sd->blk_len)
+        if (sd->data_offset >= sizeof(sd->vendor_data)) {
             sd->state = sd_transfer_state;
+        }
         break;
 
     default:
-- 
2.41.0


