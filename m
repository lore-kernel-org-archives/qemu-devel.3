Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EB4EB3637
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 22:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxBMB-0000OM-TN; Mon, 02 Mar 2026 17:03:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBMA-0000Mr-0j
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vxBM8-00018a-HK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 17:03:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48375f10628so33732925e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 14:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772488991; x=1773093791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8rm5SPZBoUqRm6XOyb5xovdZ963vq4PbXKDUME9t5Mg=;
 b=RHCTkLBI/jT84p7pZi5rmEsFVTgWH59mUpk/RRNzworAfs1Ojg9XsI73Tai1uyRnTx
 dKDwwEL6ZNINqBjKFsZbeLxfAd1Qlsesf/+3+APDNa2w6eUqgHjj7xJvV02eAk0oimQ3
 1N1VrcHU1yu/x71+EfnLNqQmc4gYWby95HUN18Af3JmJ04GFJp4UK8IDupp/MyDnBBVF
 nOJk3BCEGLcyc3F+JQTAAJwpeC7LMOaeevIeCaGKpJdiCmGb7zuj3OUVoSQ86IvkIT20
 w3A3QFxW5Jw7hxv5/SJH3gb0UPieV6toMCGAURWVJ395X8qw0CJSwuK/6CR0Fga8S5Ja
 ohPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772488991; x=1773093791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8rm5SPZBoUqRm6XOyb5xovdZ963vq4PbXKDUME9t5Mg=;
 b=ADbuG6cHlhar3g1s5KWG7Cv82C0cyxVJkU5wbjRaToFuIiYA2jJ8trDAlqmXQ6hB6j
 TzrkQ4N41p/nsNOjyJC/rk/eF17cWZ8rwslub7VOTF4yhpo0Ubad7zpnOVssfUc1JU5U
 RPeV7IXg9xiJFNZsm6cH1eZElcBBmfyIfzWnRXCwPCJ/KBIfxm10T0Qm3w5+j1g8voA9
 Zm32DsfPGxlSKdBXg+j4OjvkjI76EBN/vmk+1IQJtfzqfdzUzxDNugvMqFauz+hBMwTX
 8adB5P3gQBljI7X68/Hmb2Cfivhvb6JTQDnIbxEVHWKsVlZ8zOZ8jQsxIGKzGTWhNT56
 seww==
X-Gm-Message-State: AOJu0YzHy3iQmeVdHjjBMJkE8DHQzqO5zdzZF6GLr7DuIETayBRPlML8
 2KHoUAxdfxPbwqkVbVckjJEr/oHpAyREaiCgs96GK7gMyObxBtPj86ps4xyViA==
X-Gm-Gg: ATEYQzwLMfuOpvUO2/SDZvgC+7Odnl+B8k3qmaQmwpgOy0m+FSWgp5wkS2oe56KrmoV
 SaEePCCteXehKRHxgxH/kkAQZnq/pOIpZ+MPBWLjW4tbWo8z9K/OlRRu71XaS8cxNc6lZk2S99A
 Bz58gtNDGLQbCu5x/zScT8m9nkhA5S2Zn072EATQnDynxZJAh/Xx5SGf3Swh+w5+q1MPd3y9Jon
 WJ4BvUUicWWHdaDK802VV27IzE4K8SSouKCqJxuPf8CX0YdvAOzKvO58r2qONoOngP/zYadwJun
 I5HfxkgS3jvk5whQcLHXihZMXniOwQ6LTv6rLS2CPzJd5hC5zMPJKud0Yx7L/W0J71252A5BExb
 KK/rZJJA2ocsVzNYsnuFkrQ7+J0sEMHijAfn9sy/9EH4jE/d2P/2Noka0Us2d9wgctt8HqM/EBc
 1zJ1s/Qj1JSTGwlj+3k11sS92/skdwiNhAHfJdi/9nk0OXibgosm3iFUzeD96lIfnfl4Xy6gzXw
 noGUHKiCPkSgsUfZHE2JnawI8G9Ne1b8JTXSFpeXhhHwf71zX/7m5nRcg==
X-Received: by 2002:a05:600c:6812:b0:483:8062:b2f with SMTP id
 5b1f17b1804b1-483c9ba3af1mr213708465e9.6.1772488990633; 
 Mon, 02 Mar 2026 14:03:10 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2e0b-4800-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2e0b:4800:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c765c38sm29308102f8f.31.2026.03.02.14.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 14:03:10 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Helge Deller <deller@gmx.de>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Troy Lee <leetroy@gmail.com>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 06/12] hw/char/serial: Add constants for Line Control Register
Date: Mon,  2 Mar 2026 23:02:48 +0100
Message-ID: <20260302220254.1166849-7-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302220254.1166849-1-shentey@gmail.com>
References: <20260302220254.1166849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Substitute some magic numbers by named constants for slightly improved
readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/char/serial.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index f73de1ae4f..485b98f03f 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -39,6 +39,11 @@
 #include "hw/core/qdev-properties-system.h"
 
 #define UART_LCR_DLAB   0x80    /* Divisor latch access bit */
+#define UART_LCR_SB     0x40    /* Set break */
+#define UART_LCR_EPS    0x10    /* Even parity select */
+#define UART_LCR_PEN    0x08    /* Parity enable */
+#define UART_LCR_NSTB   0x04    /* Number of stop bits */
+#define UART_LCR_WLS    0x03    /* Word length select */
 
 #define UART_IER_MSI    0x08    /* Enable Modem status interrupt */
 #define UART_IER_RLSI   0x04    /* Enable receiver line status interrupt */
@@ -153,23 +158,23 @@ static void serial_update_parameters(SerialState *s)
 
     /* Start bit. */
     frame_size = 1;
-    if (s->lcr & 0x08) {
+    if (s->lcr & UART_LCR_PEN) {
         /* Parity bit. */
         frame_size++;
-        if (s->lcr & 0x10)
+        if (s->lcr & UART_LCR_EPS)
             parity = 'E';
         else
             parity = 'O';
     } else {
             parity = 'N';
     }
-    if (s->lcr & 0x04) {
+    if (s->lcr & UART_LCR_NSTB) {
         stop_bits = 2;
     } else {
         stop_bits = 1;
     }
 
-    data_bits = (s->lcr & 0x03) + 5;
+    data_bits = (s->lcr & UART_LCR_WLS) + 5;
     frame_size += data_bits + stop_bits;
     /* Zero divisor should give about 3500 baud */
     speed = (s->divider == 0) ? 3500 : (float) s->baudbase / s->divider;
@@ -430,7 +435,7 @@ static void serial_ioport_write(void *opaque, hwaddr addr, uint64_t val,
             int break_enable;
             s->lcr = val;
             serial_update_parameters(s);
-            break_enable = (val >> 6) & 1;
+            break_enable = !!(val & UART_LCR_SB);
             if (break_enable != s->last_break_enable) {
                 s->last_break_enable = break_enable;
                 qemu_chr_fe_ioctl(&s->chr, CHR_IOCTL_SERIAL_SET_BREAK,
@@ -676,7 +681,7 @@ static int serial_post_load(void *opaque, int version_id)
         }
     }
 
-    s->last_break_enable = (s->lcr >> 6) & 1;
+    s->last_break_enable = !!(s->lcr & UART_LCR_SB);
     /* Initialize fcr via setter to perform essential side-effects */
     serial_write_fcr(s, s->fcr_vmstate);
     serial_update_parameters(s);
-- 
2.53.0


