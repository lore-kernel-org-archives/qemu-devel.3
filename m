Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34B28C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 05:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLz8P-0001fs-R4; Tue, 25 Jun 2024 01:54:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8O-0001fP-TI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:28 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLz8N-0001bl-9P
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 01:54:28 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3636c572257so4373476f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 22:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719294865; x=1719899665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jx8nddqay2J5qb2F3WGg5BgvSRB/NLqHqQ/hS1TB/ro=;
 b=BHgf19KFSS35ocGMl5MjIlgWSey0IrQlkmrvZVEQI7itULuEjgpaCyKzgvGIVqTyce
 fmk9a0ZOVbieokPHS9d5DNQ2cUjZA7pYuD4DDJieHkgFvXTSgIh/NTCBe4PmjRtdVpVx
 kNu1JW9X26TsvZozqD0XDZk7x8jYSCkLynsmA8PI8kF51g1VpGHF0C+cJ0YwbZCGEUnL
 3Mu2o+tptn1xNJlH9Q7X04yz3dt6Y/0JUT936PdlpsTDl7Ny8V+TNYbd0DQ9MfYJvojI
 QTi5hS9xTVoDdE4+xnmay60kxpO3JIrdkv6uQERK8luydxHTKCTm7cTYibFFpUezRFBG
 EvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719294865; x=1719899665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jx8nddqay2J5qb2F3WGg5BgvSRB/NLqHqQ/hS1TB/ro=;
 b=l1sZtTdpMOiF/cW2bI5Wxo3f9ymEN9+cDszYRmnTpl+Y4D+yxhWRxUXpNaV+UggtBZ
 rIYfQxFEUp66K+mE/hzFu8MazfAPHX7pcRaL69yUnbxjpwbvBxW4Ok+ySUF++O1n+NYn
 3TUpvNuLG1DvgMzby68ognRHcjG/YGBcRy4EBn0aEea4qKmkoik1JCnMvCIvCaOC5v7W
 CVfjltcfREoPIQzFQPoTwvEL72A/yYwzgaoG1lgkFzTigh/rxSydYt77CGgcYBvzRRtc
 7Ptlvfwoib6Jdr/LaXwJPOAvVS4sG+yoYeboAiO9JQ55/4LTandHTYL250YVaQNavkBl
 3USA==
X-Gm-Message-State: AOJu0YxxPtUmUG3qfU8qQ2m68OPF1NGi74OzQFN33AzM/Wpocxkb+ptK
 LtRjvond+c7nP3aVkPKqpT4s6QskvN7G6eizzKc0maQGLUrJuk42ZwEqWYqN4C7iDSBZbJIiwqT
 j
X-Google-Smtp-Source: AGHT+IHFXhdXxP7UQ/eJnv5ppGcrgkC88yZHp35w9j0TvL7sbB31jFVa1rEMIclc953ODSLvxbciKw==
X-Received: by 2002:adf:f450:0:b0:360:9a40:3dd8 with SMTP id
 ffacd0b85a97d-366e96567cemr5210858f8f.65.1719294865378; 
 Mon, 24 Jun 2024 22:54:25 -0700 (PDT)
Received: from m1x-phil.lan (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4247d208e13sm195345575e9.36.2024.06.24.22.54.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Jun 2024 22:54:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 05/12] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
Date: Tue, 25 Jun 2024 07:53:46 +0200
Message-ID: <20240625055354.23273-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240625055354.23273-1-philmd@linaro.org>
References: <20240625055354.23273-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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
index e4587a0a37..0f8440efcc 100644
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
@@ -2020,9 +2023,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2156,12 +2158,11 @@ uint8_t sd_read_byte(SDState *sd)
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


