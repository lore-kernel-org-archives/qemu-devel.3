Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAF7C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:11:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOg5z-0006pq-5N; Tue, 02 Jul 2024 12:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5w-0006pT-RK
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:11:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOg5i-0008VL-Fi
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:11:04 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3629c517da9so3460998f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719936646; x=1720541446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAGUZtgm/PGc7UqUDzjkHrvf3V8BxDqJV4UN4glZXWQ=;
 b=ps2pXo++TjsbKMcQ1nL2Wn8mtPFqzlcNAKVvMsPyKR3p7gUqYz4g9BMSWcPG8s7/cK
 cfn/BGZIUO8N/slf8f1FuTwoBn7oSLSZx6j8WlGZuhqkWJdEH+iFU4sJzJfF2UZSE04s
 yPQcBH4lUqZKnl4HdhICKdwmEbX3ougHcOvD8XIIeOuPSdiI/2k9Jkt90fO38COp2Wdf
 J3kEl9I1mkhaWmeSOIEidG503zAGIuss3JZ02bYb2XNy8k+hnwQlZOEvjJLewcawte+W
 /TeK62gdD6oICGeXMRTMUyTs9l8Jo1n+IkpkkrdKDhcb+xC4zw/rW60kj9hs4NQyMLMf
 4c3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719936646; x=1720541446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAGUZtgm/PGc7UqUDzjkHrvf3V8BxDqJV4UN4glZXWQ=;
 b=iP2VigrLukDX40jkK+aieOB2A4guqD+u4TJrNVMt1F2sKFmTsdVM2dd+CazIwaohMA
 EapOEakP9YDA0QjqZClr5FHKVd9EI74Tkh6H2S4BLr0xR+EzFHQfi1DO/3/49UFv30FZ
 TJRr+4Kc/tuOm/ns3UgQm8cJODU8EOTJE9KM3YRbwjeXpV3KmuRUKecl5H0JGISOoJcD
 EgQiJDWVySSlhvUj1dSBeUR2hVFhvEkKBgKFy0U9yxD5LDm1ieyXHi6MbPM+zvhICJsH
 26onfEMvgk/5qFzRGIfSQaIay/g9Wc0AmfVigA2snhOlmgAxEm9L8P2mf3V4qi0DYxJc
 glWg==
X-Gm-Message-State: AOJu0YyEjrwtTR3gB8DoGee4mQGAhAng8v4+NjtU6qhuSkIj8XCMue9K
 EyFyCmnGe4dIkRid6rp8jH2ZRbVdY8Myn6pUX/0bVG6DqDcZw/rMTB0gXyMcpNblWmb+FizPkQE
 R
X-Google-Smtp-Source: AGHT+IGDy8aqWhCT6IA9q116CdElJcRLMpSd21bWsAq+l6sFUaAX6vf/Szk32IZ/5C2s3CpmylNYTg==
X-Received: by 2002:a5d:5889:0:b0:366:eba0:8d8c with SMTP id
 ffacd0b85a97d-36775724976mr8465096f8f.54.1719936646060; 
 Tue, 02 Jul 2024 09:10:46 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a103e5esm13610996f8f.108.2024.07.02.09.10.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 09:10:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Luc Michel <luc.michel@amd.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v43 2/2] hw/sd/sdcard: Do not store vendor data on block drive
 (CMD56)
Date: Tue,  2 Jul 2024 18:10:31 +0200
Message-ID: <20240702161031.59362-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702161031.59362-1-philmd@linaro.org>
References: <20240702161031.59362-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
v43: Do not re-use VMSTATE_UNUSED_V (danpb)
---
 hw/sd/sd.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 808dc1cea6..418ccb14a4 100644
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
@@ -835,6 +838,7 @@ static const VMStateDescription sd_vmstate = {
         VMSTATE_UINT32(data_offset, SDState),
         VMSTATE_UINT8_ARRAY(data, SDState, 512),
         VMSTATE_UNUSED_V(1, 512),
+        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
         VMSTATE_BOOL(enable, SDState),
         VMSTATE_END_OF_LIST()
     },
@@ -2187,9 +2191,8 @@ void sd_write_byte(SDState *sd, uint8_t value)
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
@@ -2261,12 +2264,11 @@ uint8_t sd_read_byte(SDState *sd)
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


