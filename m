Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D1FEA8546
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 22:39:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzMmF-0005ng-CG; Sun, 08 Mar 2026 18:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMmA-0005WX-F9
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzMm7-0003hh-Sz
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 18:39:06 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so17238165e9.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773009542; x=1773614342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eD9KrrMRpUnsRRcfrIHopUracPsWULIHud3yN+PZeC4=;
 b=y677n0mENZluNG1iVMmQtpbxPRfORJ4Vi912iycLJMoy9HuYVei7yzAwA/n1TxvrrA
 r9C7KgABklElTQrh8Zrsvpw6y1H8QGJs7mL+iWPiVxpQsNGFPxq7ApQ/SOzSLrn34+ij
 E4rqXkbt9Sd0U/aaZAzeQLnkUz/cdheMrhMg37Lxz0rMhGZrGZR8mIQTmh+UiZKH5GkB
 8XXM41FX+7yfsES1rLReb7buwJtcmdD5PQabI+lcfJNL4iWxbP+vcKW9fuk9vhmwCrq/
 6tKY/KVExeibtoRZ893zOQliehLA0J+V7ri7cns4lButNm5utjMr2ivlMqIdQiRrcwyr
 ObrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773009542; x=1773614342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eD9KrrMRpUnsRRcfrIHopUracPsWULIHud3yN+PZeC4=;
 b=lBAfq/7zth6oiRYQzuzxbx6V28wuyGDsVPeux/FBsluG2fRtyftsf+e/FNCtU/8SbY
 llGWNPOAoV/MIS5j0NexcJmiVCg4EZYqNBbh+zkok4tefW1Uis1uvhrlgR5FYtKzuNho
 +atnpz8hUMUrux/YXVY/X/Dq884mQh3J3gHeQH6r3z0Eg73dXxdeqVIcjaOiG2YFgPXc
 76wpCLPMprQTs5vh5pJEFX4vVc7A0OPHc13wv3pjuu5kRIRXPyFVYoXi7vbRaDzdDAzr
 KRpmbfSER+S8pFEcojx+rQ39PMaUItZJLu0qB1RI0CGmKHhVIKnJYOmOwnYRFVAkB5uU
 /ztA==
X-Gm-Message-State: AOJu0YxzKxLnSSIlp1T33GrwuKk0GO7reUOH5BmFz3WlMfvS3vumnyIw
 m7/kyFYAwrlxOlNKAu+qjT6ZceI6OmBUPMScnJ9iAddrQ++ZCl/oWWjSwTMvJaIMn8+ht1itX6B
 fze6ZQgY=
X-Gm-Gg: ATEYQzwNPQuBYlInAptkcoh5HfYD+S54lDewlXxJ5VxfHLGZENxk+18IaPfCrj5ArGM
 SOnrlABzH+WhgyfPLQ9BqjkbrUCJfnK14/c7iC9PHTrfmJAgHEOMdWamYtMsuBsXvYr+lR7HBRh
 riO+3I0Nc2sJ/hHmrzkLW6ndDg5vmp+agIXrxjTqvCWI4nkLOdaUBtUu0dPqpXKX/xSwPkLf8jH
 ChHKg0dSg9tIwqrFo7YmyLPxq/WpXNYaWUc534ZcGNaRaAzbOP3B4ytHE60is4nkZFSfr+CL6Zk
 GjSO23M6nGFckglNEaoYaXdto4KdS6yrklr46QDufspFbTrkuBQbgeWwLjl6rPLsZAMipARfRRi
 mJxx2VDKZoDkiqARuFT11PUEvItrYfq3qSXKO3m+BBQTTZ5YCtOlvcsGvJyL/84hPGR1eLZ9qt/
 DeX7UpbqzABnzU5OkxYR15vyfqGSAARqzdNXJEVSzky7m3PFAgIcZCBl/wtq81hXBr7Lh+5tDMq
 MRZzQ==
X-Received: by 2002:a05:600c:4591:b0:483:c3f3:1dad with SMTP id
 5b1f17b1804b1-485269791e2mr154074335e9.34.1773009541932; 
 Sun, 08 Mar 2026 15:39:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48523803b5fsm73706055e9.7.2026.03.08.15.39.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 08 Mar 2026 15:39:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 39/49] hw/char/serial: Add constants for Line Control Register
Date: Sun,  8 Mar 2026 23:34:23 +0100
Message-ID: <20260308223433.25503-40-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308223433.25503-1-philmd@linaro.org>
References: <20260308223433.25503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Substitute some magic numbers by named constants for slightly improved
readability.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260305220911.131508-10-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/char/serial.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/char/serial.c b/hw/char/serial.c
index f73de1ae4f6..485b98f03ff 100644
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


