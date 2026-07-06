Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E51C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wggiB-0006zQ-H8; Mon, 06 Jul 2026 06:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi7-0006xB-HV
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:38:00 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wggi5-0003Ew-Mi
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:37:59 -0400
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-493d3135f62so9043145e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783334275; x=1783939075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=n+h4KcNRD+h0hC6MoEK/ijKM0u4LLci0opUR0sXDBd0=;
 b=i+jpamjD6YMHW89Hqp9qFtmMkqf3R7gwgWrO2iu5g2nYjXuJzFwg9PyjBWVOOwWsqQ
 cnaozvVenJf7QqjnCypMXjq7Jq42Pez6K7L5xFFMMnhWrxM9j8ucaBUMMoYmSSE6yaVF
 1RbT9OguUrC7a55SlHtm4Ddz6rZf2r72INRMAjz/GCjq6/phVKj2RXcbabjEXzSZxJDP
 ex2crZGMo6ZHvKHQck7CF7bUYT9t1HdE78YtxXxiLEvjF4mom2BiFlbETCjCr1Tw0caa
 x6mA9rnUlG+8WMncQ9kNsNTVrKeGMmUNcfYmvztm79b2N1sch+12jzpyLrjXE3xbCdXn
 ZFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783334275; x=1783939075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=n+h4KcNRD+h0hC6MoEK/ijKM0u4LLci0opUR0sXDBd0=;
 b=YsFC25jq7K4hQ46IZVoYikFi/Y4Wo2XmUp/FYlgggXaO4jgFI/XogdZ35e1otESkF2
 d7BY4kVXPY/symBSwqI5BIVxdWySX9z1pJWrkeLuSgU4ofpSR2jKrog+n7r5Q08VbRET
 yaiTmnOAyuURvOxaWdQs922ylqUpmVYWpF3WDIvIYKRJZk8UQWsJYHPOI1cMrpAa8LeO
 WF7kS815RZaJm9oEL39XWrlSRR8v1q4ffXIKHrn2fA3yqzQrKl3u3WePPCy9Owdj5k5m
 0XOL+rrSYAe/vCT7pjTXa9dv7OtLmUusA4iIL5cVIrrGSxCb4yetnKaUT708Hxny//bg
 i9tw==
X-Gm-Message-State: AOJu0Yy5nFK0249aGowcbxQh0KreiRa79g5KCuINWFvtndiF8U61+Irq
 gMiisSGn9F0GjB0QnEwrayfor8qstXdMs46rRsYd3ESJ04IylJ0kSVs/aZ8pv3f1iGN2IuvMro3
 mnkUHVe+mmWaW
X-Gm-Gg: AfdE7cm8qmgO6og2XjSf8E0v7pCOGgADTP2uTp8uFZfRE62ZDxAfFO0bD6PwP+LmKAW
 fLNO79vo4q6kwRVmDwqevo/RG6FP0CAwL261poEqo+ZzbTJqiSOojhEpTQcVs6oVcxgx6nq5DRx
 hYcmu4OxgMa8+A2mWsePZHsF5hNdTNQ2uW9H2nZXUsXB8Yk5A1wJCMFmW1t6y+N8xc8XHYt/fdU
 0+jWDMRqTF0v38kob812OhFeYfGSteqmLeJwDLZLDlh0e/6TxUlJAnJkdePzlsxBa35R+n/dHAe
 4HYE3MTVVrEArd94/EFlzJQXWsnObRNcergmRMWPZv7k/0Wh8C8IMc+vb46Np1IIHmrYgWBigrF
 UYFGPFp0LLyRFrLbM6jtvj4q1hd6hqgzweSAz9XfcrXF84f+drmCuE9qK7VnK7p9pLsyQVXpBk2
 qUldlhqH5pZx8r93KOLj88nHxCIsSG2A4SqBVy8VeczRBajdzXShpuaYfyDTtvn1Od/GLLtXoEA
 jTrXBY58MNgzxKbYZVZWg==
X-Received: by 2002:a05:600c:c4a6:b0:492:70f4:8d1e with SMTP id
 5b1f17b1804b1-493d526d4admr79840495e9.11.1783334275481; 
 Mon, 06 Jul 2026 03:37:55 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63b6f1bsm329501805e9.10.2026.07.06.03.37.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 03:37:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/49] hw/net/fsl_etsec: validate FCB offsets in
 process_tx_fcb()
Date: Mon,  6 Jul 2026 11:37:04 +0100
Message-ID: <20260706103752.320511-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706103752.320511-1-peter.maydell@linaro.org>
References: <20260706103752.320511-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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

From: Feifan Qian <bea1e@proton.me>

The TX Frame Control Block (FCB) is prepended to a TX frame when
BD_TX_TOEUN is set. It contains two guest-controlled u8 offset
fields that process_tx_fcb() uses to locate L3/L4 headers within
the frame buffer:

  l3_header_offset = FCB byte 3 (0..255)
  l4_header_offset = FCB byte 2 (0..255)

These offsets are applied without any bounds check. When the
UDP-no-CTU branch is taken, the function writes zero to
l4_header[6] and l4_header[7]. With both offsets set to 0xFF the
write target is:

  tx_buffer + 8 + 255 + 255 + 6/7 = tx_buffer + 525

A malicious guest can therefore corrupt up to 509 bytes of heap
memory beyond a minimally-sized (16 B) TX frame.

Fix: reject the frame and log a guest error when the minimum
required buffer length

  8 (FCB) + l3_header_offset + l4_header_offset + 8

exceeds tx_buffer_len. Move the l3_header and l4_header pointer
declarations past the new guard so that out-of-bounds pointers
are never materialised.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3517
Signed-off-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/fsl_etsec/rings.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 6d2bf71b52..c8fc5d55d1 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -177,16 +177,31 @@ static void tx_padding_and_crc(eTSEC *etsec, uint32_t min_frame_len)
 static void process_tx_fcb(eTSEC *etsec)
 {
     uint8_t flags = (uint8_t)(*etsec->tx_buffer);
-    /* L3 header offset from start of frame */
+    /* L3 header offset from start of frame (FCB byte 3) */
     uint8_t l3_header_offset = (uint8_t)*(etsec->tx_buffer + 3);
-    /* L4 header offset from start of L3 header */
+    /* L4 header offset from start of L3 header (FCB byte 2) */
     uint8_t l4_header_offset = (uint8_t)*(etsec->tx_buffer + 2);
-    /* L3 header */
-    uint8_t *l3_header = etsec->tx_buffer + 8 + l3_header_offset;
-    /* L4 header */
-    uint8_t *l4_header = l3_header + l4_header_offset;
+    uint8_t *l3_header;
+    uint8_t *l4_header;
     int csum = 0;
 
+    /*
+     * Validate FCB header offsets before pointer arithmetic. The highest
+     * byte accessed is l4_header[7], at offset
+     *   8 (FCB size) + l3_header_offset + l4_header_offset + 7
+     * from tx_buffer. Drop the frame if this exceeds the buffer length.
+     */
+    if (etsec->tx_buffer_len < 8u + l3_header_offset + l4_header_offset + 8u) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "eTSEC: FCB offsets exceed frame length, dropping\n");
+        return;
+    }
+
+    /* L3 header */
+    l3_header = etsec->tx_buffer + 8 + l3_header_offset;
+    /* L4 header */
+    l4_header = l3_header + l4_header_offset;
+
     /* if packet is IP4 and IP checksum is requested */
     if (flags & FCB_TX_IP && flags & FCB_TX_CIP) {
         csum |= CSUM_IP;
-- 
2.43.0


