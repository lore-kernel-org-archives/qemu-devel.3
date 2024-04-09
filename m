Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BFFCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 13:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruBhG-0007f3-6u; Tue, 09 Apr 2024 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgt-0006d6-FZ
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:39:13 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ruBgq-0008Jh-Rc
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 09:39:10 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-343bccc0b2cso4087158f8f.1
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 06:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712669943; x=1713274743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C1Zw+CVRCq/SOI5cLQNhCw7GlRbzROScTIFOWQl3mYw=;
 b=QDLRDwUt9F260+tAmYNolfScg60li8Hg55PKVdG0mGNsqfJdsCZ3EhL2EzRWmqJq2M
 R1lY3Z9ufDqcdj5Wa+ff64cqsDay+cmmHubcElOvq8UpXVOIAKxrRQ4VLIqR/Yy57F6n
 +OH+QVZUUDBcmTTjCeM3Rvy+kI9GXfnjOvnIEUonWKCn6Knu2sroQL4bvu3ijZbnfxyz
 7uXtkkSVoxX94M/+EMLtWyI7ETpb5JdLxU1CgaVyNLMypuUJ1Li8fnEjFvyjL6uCFLz6
 SP9g/kU5AzptsVKOGVyR5vO/CTmLek7e6Z9hkZqJGjr5SuY8A2ukznHdNdy6V5CsRtEC
 KtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712669943; x=1713274743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C1Zw+CVRCq/SOI5cLQNhCw7GlRbzROScTIFOWQl3mYw=;
 b=bF+MTTDY0jvwztw1C9FL3TMCVBFwtzql0uTQIJINiBmmgj358ow+EYzvvKbl6tXNlH
 n7BfJBsE65l2cIHdQE88C15Ae27GW7yMD9X6GgUc/4s2avHf3j1SZpfzzgHiq6c9ULY9
 VzxY0TUXWn8283e6C4lsVHnmsf9SgJWNTYZTzT2by2nl7uCmnukg/R9ihM3iyv3hgWa0
 I7ttUCLiGTKDY/lsy5/n1C6AYj8pxzSpk2q/7B1iED2kQzh/Vyf/exzLqIZ/wK9zYz5m
 wdCpRsa5brmZ26b6Z7q1CC5j5+lV5RVRA7SD43Bo5lMBa0HqUpSp8i46b6vxmcdZAmUW
 atFw==
X-Gm-Message-State: AOJu0YxUe+r3JIP5RDI24qq3DoEVDQTiDGlK87BQYsCzdQOV4s8NRT9h
 mwNmWx3t3jHHK2BJD3arQitIo2mQUl4tOvEUA4g6kex7CBa9WMqizinLY4a9+wbNdZyUyBQsK3/
 N
X-Google-Smtp-Source: AGHT+IFqoIUE/M1R/hh7rdUjgXcFj4C4BeV8e717z8yEIhV19KziG+GNdIbdK7dfgdC9rxxwgqrv4Q==
X-Received: by 2002:adf:e847:0:b0:343:dd56:b941 with SMTP id
 d7-20020adfe847000000b00343dd56b941mr8105877wrn.52.1712669942881; 
 Tue, 09 Apr 2024 06:39:02 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.160.134])
 by smtp.gmail.com with ESMTPSA id
 k7-20020a5d5187000000b003434c764f01sm11479350wrv.107.2024.04.09.06.39.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Apr 2024 06:39:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Chuhong Yuan <hslester96@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH-for-9.1 v2 11/11] hw/net/lan9118: Rename rx_fifo_size ->
 rx_fifo_wordcount
Date: Tue,  9 Apr 2024 15:38:00 +0200
Message-ID: <20240409133801.23503-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240409133801.23503-1-philmd@linaro.org>
References: <20240409133801.23503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

rx_fifo_size is a word count, rename it to avoid confusion.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/lan9118.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 56cc52d450..3db6bae908 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -263,7 +263,7 @@ struct lan9118_state {
     int32_t rx_status_fifo_used;
     int32_t rx_status_fifo_head;
     uint32_t rx_status_fifo[RX_STATUS_FIFO_BYTES / 4];
-    int32_t rx_fifo_size;
+    int32_t rx_fifo_wordcount;
     int32_t rx_fifo_used;
     int32_t rx_fifo_head;
     uint32_t rx_fifo[RX_DATA_FIFO_BYTES / 4];
@@ -335,7 +335,7 @@ static const VMStateDescription vmstate_lan9118 = {
         VMSTATE_UINT32_ARRAY(rx_status_fifo, lan9118_state,
                              RX_STATUS_FIFO_BYTES / 4),
         VMSTATE_UNUSED(896 * 4 - RX_STATUS_FIFO_BYTES),
-        VMSTATE_INT32(rx_fifo_size, lan9118_state),
+        VMSTATE_INT32(rx_fifo_wordcount, lan9118_state),
         VMSTATE_INT32(rx_fifo_used, lan9118_state),
         VMSTATE_INT32(rx_fifo_head, lan9118_state),
         VMSTATE_UINT32_ARRAY(rx_fifo, lan9118_state,
@@ -462,7 +462,7 @@ static void lan9118_reset(DeviceState *d)
     s->txp->fifo_used = 0;
     s->tx_fifo_bytes = TX_DATA_FIFO_BYTES;
     s->tx_status_fifo_used = 0;
-    s->rx_fifo_size = RX_DATA_FIFO_BYTES / 4;
+    s->rx_fifo_wordcount = RX_DATA_FIFO_BYTES / 4;
     s->rx_fifo_used = 0;
     s->rx_status_fifo_wordcount = RX_STATUS_FIFO_BYTES / 4;
     s->rx_status_fifo_used = 0;
@@ -504,8 +504,9 @@ static void rx_fifo_push(lan9118_state *s, uint32_t val)
 {
     int fifo_pos;
     fifo_pos = s->rx_fifo_head + s->rx_fifo_used;
-    if (fifo_pos >= s->rx_fifo_size)
-      fifo_pos -= s->rx_fifo_size;
+    if (fifo_pos >= s->rx_fifo_wordcount) {
+      fifo_pos -= s->rx_fifo_wordcount;
+    }
     s->rx_fifo[fifo_pos] = val;
     s->rx_fifo_used++;
 }
@@ -584,7 +585,7 @@ static ssize_t lan9118_receive(NetClientState *nc, const uint8_t *buf,
     fifo_len = (size + n + 3) >> 2;
     /* Add a word for the CRC.  */
     fifo_len++;
-    if (s->rx_fifo_size - s->rx_fifo_used < fifo_len) {
+    if (s->rx_fifo_wordcount - s->rx_fifo_used < fifo_len) {
         return -1;
     }
 
@@ -672,8 +673,8 @@ static uint32_t rx_fifo_pop(lan9118_state *s)
     } else if (s->rxp_size > 0) {
         s->rxp_size--;
         val = s->rx_fifo[s->rx_fifo_head++];
-        if (s->rx_fifo_head >= s->rx_fifo_size) {
-            s->rx_fifo_head -= s->rx_fifo_size;
+        if (s->rx_fifo_head >= s->rx_fifo_wordcount) {
+            s->rx_fifo_head -= s->rx_fifo_wordcount;
         }
         s->rx_fifo_used--;
     } else if (s->rxp_pad > 0) {
@@ -1135,8 +1136,8 @@ static void lan9118_writel(void *opaque, hwaddr offset,
                 s->rxp_offset = 0;
             }
             s->rx_fifo_head += s->rxp_size;
-            if (s->rx_fifo_head >= s->rx_fifo_size) {
-                s->rx_fifo_head -= s->rx_fifo_size;
+            if (s->rx_fifo_head >= s->rx_fifo_wordcount) {
+                s->rx_fifo_head -= s->rx_fifo_wordcount;
             }
         }
         break;
-- 
2.41.0


