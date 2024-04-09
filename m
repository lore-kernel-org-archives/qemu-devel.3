Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96347C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBhE-0007MO-Ay; Tue, 09 Apr 2024 09:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgd-0006CJ-Ud
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:39:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgc-0008Gq-04
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:38:55 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-343c2f5b50fso3735527f8f.2
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669932; x=1713274732; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REIm1SfLMUgG42n/AOyva4uJWnD7BJmJ3hGw4grtNrQ=;
 b=LSZmv35s7D27V3+dGrZnCHfE9CB5s/cbgVpq5VCM3FIjLogRnulB1NLvrZtcIIwGJh
 eJM+XFKPxDKbq5MAaQEO0ZDYTxIZOGayb4oY2c55XFTHcddBjq3XoplVkrupSYjbdgBs
 H+TmTVSv2qO6ifSkFvUskg4L+8eryWlfQ9Q7ugUmZbQjc2qqTsWbEhjrCD0uqyvRQvil
 CCnUz9o2+VO3g16PfnWXrr18rSrsLFHFN8hDa788XgpEhNMby5Yy9G+lAIZj6PEcPhue
 MtDxkOTibz42wArgsv/0sXAz7XIMcKVGjQdVfUIDpJNtn6gOaWlSNM4bdGTnWUn8FMUO
 t4cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669932; x=1713274732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REIm1SfLMUgG42n/AOyva4uJWnD7BJmJ3hGw4grtNrQ=;
 b=SpYjdaaB4n/U3px1Prq+yvRg8hqytId8co433g9EVpbNq5qqwvayJ8maG98nSfKsEt
 6uOt9JHbtHvqT/Jzxzjs/dlsJH4FxOT2449YmWYF33QdViGnUYKsIPsXD6dHmLrZsrJf
 t/xyuNCrO1D4KW6B89krbgvSgOo9c8OCyPG4Tc5Lml4GhK1zLqmPBhl5cmDFCcMHv2P2
 D5ugS0wVxLreOl1xeez8CbZTfZQqQ32bmJWwEJ4956nxrHJ54CGLXvI+UOt54xAQUZ0Y
 0IErE9fEonQaC9sbFQxXS/k7bZZSJy0RwF6gijtg4A/7D90c80Z29vZ5x2LYn651aEQr
 WdSQ==
X-Gm-Message-State: AOJu0YwIoNnBRM5ayn+tgmCiKfnchYmDSCieXvad1sacSgZdA4B0cU2J
 2b6c6ui6nQ8du3vbRU3JfaC/F8nWUnHJ2CoCMgjYVy0wp5bB8b/mk4zH1Ppy0RUF37ox6z9Nrhb
 u
X-Google-Smtp-Source: AGHT+IHi8laSSIRUoQSHm4FD2sdjylQ5LL7q86l9s0xiAn9IQNCqQk/PleCS3bDLIwpbLTpVP1wAgQ==
X-Received: by 2002:a05:6000:1864:b0:33e:48f9:169d with SMTP id
 d4-20020a056000186400b0033e48f9169dmr11866184wri.31.1712669932225; 
 Tue, 09 Apr 2024 06:38:52 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 j1-20020adfb301000000b003464e150e30sm236605wrd.15.2024.04.09.06.38.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:38:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 v2 09/11] hw/net/lan9118: Rename rx_status_fifo_size
 -> rx_status_fifo_wordcount
Date: Tue,  9 Apr 2024 15:37:58 +0200
Message-ID: <20240409133801.23503-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

rx_status_fifo_size is a word count, rename it to avoid confusion.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index cace22381d..663776f575 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -259,7 +259,7 @@ struct lan9118_state {
     int32_t tx_status_fifo_head;
     uint32_t tx_status_fifo[512];
 
-    int32_t rx_status_fifo_size;
+    int32_t rx_status_fifo_wordcount;
     int32_t rx_status_fifo_used;
     int32_t rx_status_fifo_head;
     uint32_t rx_status_fifo[RX_STATUS_FIFO_BYTES / 4];
@@ -329,7 +329,7 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_INT32(tx_status_fifo_used, lan9118_state),
         VMSTATE_INT32(tx_status_fifo_head, lan9118_state),
         VMSTATE_UINT32_ARRAY(tx_status_fifo, lan9118_state, 512),
-        VMSTATE_INT32(rx_status_fifo_size, lan9118_state),
+        VMSTATE_INT32(rx_status_fifo_wordcount, lan9118_state),
         VMSTATE_INT32(rx_status_fifo_used, lan9118_state),
         VMSTATE_INT32(rx_status_fifo_head, lan9118_state),
         VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state,
@@ -462,7 +462,7 @@ static void lan9118_reset(DeviceState *d)
     s->tx_status_fifo_used = 0;
     s->rx_fifo_size = 2640;
     s->rx_fifo_used = 0;
-    s->rx_status_fifo_size = RX_STATUS_FIFO_BYTES / 4;
+    s->rx_status_fifo_wordcount = RX_STATUS_FIFO_BYTES / 4;
     s->rx_status_fifo_used = 0;
     s->rxp_offset = 0;
     s->rxp_size = 0;
@@ -568,7 +568,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
     }
 
     /* TODO: Implement FIFO overflow notification.  */
-    if (s->rx_status_fifo_used == s->rx_status_fifo_size) {
+    if (s->rx_status_fifo_used == s->rx_status_fifo_wordcount) {
         return -1;
     }
 
@@ -609,8 +609,8 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
         rx_fifo_push(s, crc);
     }
     n = s->rx_status_fifo_head + s->rx_status_fifo_used;
-    if (n >= s->rx_status_fifo_size) {
-        n -= s->rx_status_fifo_size;
+    if (n >= s->rx_status_fifo_wordcount) {
+        n -= s->rx_status_fifo_wordcount;
     }
     s->rx_packet_size[s->rx_packet_size_tail] = fifo_len;
     s->rx_packet_size_tail = (s->rx_packet_size_tail + 1023) & 1023;
@@ -732,8 +732,8 @@ static uint32_t rx_status_fifo_pop(lan9118_state *s)
     if (s->rx_status_fifo_used != 0) {
         s->rx_status_fifo_used--;
         s->rx_status_fifo_head++;
-        if (s->rx_status_fifo_head >= s->rx_status_fifo_size) {
-            s->rx_status_fifo_head -= s->rx_status_fifo_size;
+        if (s->rx_status_fifo_head >= s->rx_status_fifo_wordcount) {
+            s->rx_status_fifo_head -= s->rx_status_fifo_wordcount;
         }
         /* ??? What value should be returned when the FIFO is empty?  */
         DPRINTF("RX status pop 0x%08x\n", val);
-- 
2.41.0


