Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC09F513E4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 22:10:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyGt4-0001DX-TB; Thu, 05 Mar 2026 17:09:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsx-000166-EL
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:35 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1vyGsv-0002Ho-Un
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 17:09:35 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4837907f535so77743115e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 14:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772748572; x=1773353372; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkqwSLJa0xJ6zHaGrPgGg+nUA0PuvLRB97+M4LUsZGQ=;
 b=PcXAjtoHDLhw0GL7WT39Gsk2o04AvINa0cAOPj+1NknxCrxxi9YLLR7ehCZUBzEYlI
 B5wS07Z5TUKi1h/3ijv88IFHqRVG5xxj6glyIWoOI0GGohaqgknRVCHG3LDELtFoLTqe
 ByOFzfryFwSoBrho5a6Q4tNKcs1aP/nWb7wNTaIAwVkg43g33XtZ/f5uCG9H77xVdmjX
 mIAOV2Jd6co404Xb7IdFSj6dWGgUbOeUoHeRcYirzVl6B0DTr419iMZ0+rtp2JlrWWZu
 F8wvsUxXYBCEDrRm9Rw58j/BWRJHqIml2GKx42LVJKsnrBYawejED9va/xxAt3+Q0nf/
 cs3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772748572; x=1773353372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkqwSLJa0xJ6zHaGrPgGg+nUA0PuvLRB97+M4LUsZGQ=;
 b=QqWOCgjZsRLNMfTn5SgH1+Dag1r3G9WOJJ2xCgj31nKMAfTl6oaS2fIaqlHQBdfcKW
 /c77KViGPOjL47ash0ikugL2RnuIYIMpamdZDIkJBExSKTGcoBVskGTBD0p/N/FxJgV8
 4fP+jVpV97+3JrAiCkw5AjbfjfAWnKRR8ymcTM0ooHHbqXXGAmPuWWCxWBWorLYw7U+N
 H9CrbMyB3sxrqnSoitfwrZR6eHFeiyjnNUXDgBmI61KZNLgrPfqhQAiPwJdWWVrYk5nh
 lvxfOMaSuoiPg0QubsZgB0ViaKRdBsINEVCKJeYvazV3YfiP4mKy7tnDBwlg11dCjoif
 A9LA==
X-Gm-Message-State: AOJu0Yz0vDU86ycWaxJk8/LMH7Hyw5O1Y40iCRv4wvgk3BNYvpTpi7+e
 AoBx8jgQJxTdzukibYdkKcv/vdJXkiY98DK/b6SGlFNkWGFkVz6uUOigANlW+w==
X-Gm-Gg: ATEYQzz6UAIee984QrrgSHH+nF+3Xd/8fwhKYOmKROIeFwcjkV5S0wqK2hq3ivGF2EU
 WHqKczfLcr30VdHb0wsBrqmRTwXxDesZ1HMt443g+tqDSUopq2bzraV1/5OdqtxTu+AlCIac/lA
 eSkOZSu7T5IRpQNUAvgO8w5DwdB9pOy5lB/RyycNKaKfym2jSzIBW34w18Iyr+0gGLy9MM9btiS
 ZHh2zXcScItzYlm0Tui+W4rLLBCuTBxzZDj4nuqRiiKue/zL5fEbeWUV/AsYqbeiPJj+IhrjA6c
 6cN797O0OoQTHL/IVhUsiCnVyM0Jjbr2NGNlztVQQfTt+NMUBnZG0ge4IpWalVh4/KlDlmttc0Z
 7P4UZWhSjroWLLGFZ15PLR7rjv3AS93dVC+Xf6vBVmZMU+js2NEZeVe/MoR5Ph/CyHZFFWMDt6d
 mRbcmz2BjC/9r6mF2puhJHUFEkdMW+txnkO16APNrZ1jotNSMvAw1oelmj/MWRnX2he7ZmXU8Ze
 ZYbnJKX9IhteAl/yeCDBcAfchBvkAEySN/hIww8pdJHCW3AwRJk6BN4Ew==
X-Received: by 2002:a05:600c:46d1:b0:480:6bef:63a0 with SMTP id
 5b1f17b1804b1-48519879438mr136817645e9.21.1772748571741; 
 Thu, 05 Mar 2026 14:09:31 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-2a02-3100-2989-c400-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:2989:c400:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4851fa87e56sm67419615e9.0.2026.03.05.14.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 14:09:31 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 09/14] hw/char/serial: Add constants for Line Control
 Register
Date: Thu,  5 Mar 2026 23:09:06 +0100
Message-ID: <20260305220911.131508-10-shentey@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305220911.131508-1-shentey@gmail.com>
References: <20260305220911.131508-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32b.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


