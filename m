Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B544CC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2024 16:24:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMruq-0005DD-NE; Thu, 27 Jun 2024 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMrun-0004oc-Tg
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:06 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sMruk-0008PL-J5
 for qemu-devel@nongnu.org; Thu, 27 Jun 2024 12:24:05 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42565cdf99cso8429235e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2024 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719505441; x=1720110241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8X6AtOCpBUXAQ/1xHubY59Be7qdcbmyzPDPReyo42Nc=;
 b=lDZhQmlnBgasyBcj7jL/oMVauEXD9X2Y2rsmp+UadHuV97/s1Eh3FHwyp3hgCMuCej
 SsAALmXkLtX4DC7I5wDGyE5b7PMMbH94WFnUoRFmVudWkw8Ka8FYQ3LiUToVlgLleG2j
 xgCZww43gkC3dK8tL1sOMOz8qBy7BE//cGvFgGFzOB7CJa03h7G2q8+dCHNy7mIOatHd
 jrKxlaXiejTZ2C3G+8EMFKQvTyPVkVFENEb1h+lfhnHaDPAre49mEd0nzxdGEFqqVAlu
 ZXe0N1ZQ7u6FSxW6TyFiFa6zft6vfHILVUA3C8aOSP4KoIkZbCz/RI27oUhOrKUda4Nc
 DaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719505441; x=1720110241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X6AtOCpBUXAQ/1xHubY59Be7qdcbmyzPDPReyo42Nc=;
 b=bqPf4WsVYqdlA2e12Ft8xTjNABg6ZPfsaUgnHVgqskAVNuPRGBCUgKGqQ3gsVPLCUl
 RjlUHj7wSgpx4tb5g6Ud9oDIL8m03RhwWnwtAB75GqdZQ1aLvsb0ykXPMPKXgELsP7fc
 71Ty6/dKj4osTDk78/iNJUxJNkSYxWj15ml4UEH4QZG0J0l/FKemLZdjj7ndkwgduXc/
 PGVNKYLTmu6i2IY61RxRgEMcRTsi9ktbvDL4iHSLlG2WXBo+el8KnGeKZUtd/E0XhJ5V
 usWKbnXOR52a1QIXeO9VVmMKKyooKUO6ohwEHQtDFnHXPpsXuJWa4j3LgaptQI2I5Ftw
 /rag==
X-Gm-Message-State: AOJu0YxW67/x7+1sBnVXtkUpcJmQOAVI8fCBBZ90gAG/B0LpjveOXpcI
 PGSVujIEF6FWnxq1fRbgMiqU3Xrn2FeL6kvREOdOyKWI+gnAO+Maqcmmd71Nh0PxeDzlQSE6eJl
 FgC8=
X-Google-Smtp-Source: AGHT+IHFhVoufCdvBfDNvagVn5p34PLe86CiYRsxIjjhPSD1BvJLJJNbCSXssHH758sWjmfqowailQ==
X-Received: by 2002:a05:600c:4f07:b0:421:dd8c:35a3 with SMTP id
 5b1f17b1804b1-4248cc586d0mr116166515e9.26.1719505440758; 
 Thu, 27 Jun 2024 09:24:00 -0700 (PDT)
Received: from localhost.localdomain (33.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.33]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c8246b1dsm76798185e9.6.2024.06.27.09.23.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 27 Jun 2024 09:24:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Tyrone Ting <kfting@nuvoton.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Hao Wu <wuhaotsh@google.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 devel@lists.libvirt.org, Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v3 06/17] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Date: Thu, 27 Jun 2024 18:22:21 +0200
Message-ID: <20240627162232.80428-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240627162232.80428-1-philmd@linaro.org>
References: <20240627162232.80428-1-philmd@linaro.org>
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
Tested-by: Cédric Le Goater <clg@redhat.com>
---
RFC: Is it safe to reuse VMSTATE_UNUSED_V() (which happens
to be the same size)?

Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
---
 hw/sd/sd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 464576751a..1f3eea6e84 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -142,6 +142,8 @@ struct SDState {
     uint64_t data_start;
     uint32_t data_offset;
     uint8_t data[512];
+    uint8_t vendor_data[512];
+
     qemu_irq readonly_cb;
     qemu_irq inserted_cb;
     QEMUTimer *ocr_power_timer;
@@ -656,6 +658,7 @@ static void sd_reset(DeviceState *dev)
     sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
     sd->wp_group_bits = sect;
     sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
+    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
     memset(sd->function_group, 0, sizeof(sd->function_group));
     sd->erase_start = INVALID_ADDRESS;
     sd->erase_end = INVALID_ADDRESS;
@@ -771,7 +774,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT64(data_start, SDState),
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
-        VMSTATE_UNUSED_V(1, 512),
+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
     },
@@ -2029,9 +2032,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2165,12 +2167,11 @@ uint8_t sd_read_byte(SDState *sd)
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


