Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777A8E77198
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlO9-00061b-GL; Fri, 03 Jan 2025 12:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlO7-00060V-Ay
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:07 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlO5-0001PS-3U
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:07 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so34604555e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924983; x=1736529783; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUozoV2sd4YCNhaxO0qe6knCSN/xQB+GkqDltrLuR9M=;
 b=gIMO6pCyasVYbRp3TZcy512tG+FrBvrip70I1tUX32QmvD9BQqWYE7uIbV3Ms5ck2L
 cfHsjCmpsCq7C+CX22ditPZrbhPksbRZoi7nnJ5gPTq3TlGMzM1XFBwjZ4V+hifIal2k
 0j2XonvRfpaNP2mea/GcSgbXu68DtE2ysx6H72syoGD8nlUx9L4d3Oec5WWoEpi+N324
 JaGsxfYuaLGBqqvuqrJvOm1XwB5ljNWyerRjNlRi8DhUAuQh6HZHhMwFHFMfTpt3rCly
 Jva/mi4pFHb2PN0DHGrmzmHwxyhlFV25vJ6mZ5uLBgqhgKJR/kYb6hn1qGk5NTkSedcX
 hJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924983; x=1736529783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUozoV2sd4YCNhaxO0qe6knCSN/xQB+GkqDltrLuR9M=;
 b=e57jSrKDZIoc7QzC10M3QkQ+GyxYH8SVL/ND7LgAqREb+65I96WtoiAP4NENHcptcU
 3sPznFYMVPnaVMYh7heF7jMnDFGI5mx+YQxOG/jD1GnQF8hZNS/csVByi/PTyAFhH/i0
 tnDY9cUM16uqutnBja5o7lQOvWbDQZMxshf6onXcuLjpFCaaDD0Yit/ytXufneDDPKLO
 2P4v3qUku9gM6kXwOoXqgOPhCERAl440Sc8CJK+6bPCN6VIlRfny8lmReF09/Zjfs5Eq
 NtA2DeLprOQxz+YlBxlqhAQ84G4Rapxs548n3K5oDF7NwnW/yUrYYYrVkKrwGOkBzCYm
 rgFA==
X-Gm-Message-State: AOJu0YzGzdmQUXwkA2lyIhzOYGC89FFg0BNzLZhTUz7Ddr1FDi9Xpu+g
 csnDV/MbJqnjIlyldmEVQqY271HyV7NmhpdiA4WRc2ZCNZv3H20iAhKwtD+YN3Tdg0+pJv447oC
 m3cc=
X-Gm-Gg: ASbGncuGCFHCxk97Wk7X9F0SXUC0rFQfZt2kHdMV4ROgnh94MK3zMKzQfoD8vJnL6U8
 94KTZAapznrtFkRYEibJ4XGG91iVmn8LacEyYoWq5XxNCBM4XMTThQU4F1bf9Kijr/p+QJxE5YQ
 QDSLcPJlf927ONSqgwv9W9Rr4pOM8D8gMikPUkurZX8rcORdKkuTPjyfl9GL3QdWcIiMkJ4kPya
 FDh6LEjnH5t7KBmrBFm4oRVB3gSVWGf/n1HVKE80gmcKr88gGF3eOx91e1cHT5/fh1LufTUmQUD
 RIHeJAe2yW+KsolsNxn7xMleIKGi10w=
X-Google-Smtp-Source: AGHT+IHuHyBwdiu6vN6zBS0sMJlcJ6tTdsG6SmA5FtOu3cjwEnui29omhcrLNCOzCVX2SXzORCDUhQ==
X-Received: by 2002:a05:600c:350c:b0:434:fdaf:af2d with SMTP id
 5b1f17b1804b1-43668b7850emr440635435e9.30.1735924983340; 
 Fri, 03 Jan 2025 09:23:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b295sm531386205e9.33.2025.01.03.09.23.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:23:02 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 4/4] tests/qtest/boot-serial-test: Initialize PL011 Control
 register
Date: Fri,  3 Jan 2025 18:22:39 +0100
Message-ID: <20250103172239.18562-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103172239.18562-1-philmd@linaro.org>
References: <20250103172239.18562-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

The tests using the PL011 UART of the virt and raspi machines
weren't properly enabling the UART and its transmitter previous
to sending characters. Follow the PL011 manual initialization
recommendation by setting the proper bits of the control register.

Update the ASM code prefixing:

  *UART_CTRL = UART_ENABLE | TX_ENABLE;

to:

  while (true) {
      *UART_DATA = 'T';
  }

Note, since commit 51b61dd4d56 ("hw/char/pl011: Warn when using
disabled transmitter") incomplete PL011 initialization can be
logged using the '-d guest_errors' command line option.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index bcfa504826c..ffa9e780ad6 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,15 +70,20 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
+    0x10, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #16]  Get &UART0 */
+    0x10, 0x20, 0x9f, 0xe5,                 /*        ldr     r2, [pc, #16]  Get &CR */
+    0xb0, 0x23, 0xc3, 0xe1,                 /*        strh    r2, [r3, #48]  Set CR */
     0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
     0x00, 0x20, 0xc3, 0xe5,                 /* loop:  strb    r2, [r3]       *TXDAT = 'T' */
     0xff, 0xff, 0xff, 0xea,                 /*        b       -4             (loop) */
     0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
+    0x01, 0x01, 0x00, 0x00,                 /* CR:    0x101 = UARTEN|TXE */
 };
 
 static const uint8_t kernel_aarch64[] = {
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x21, 0x20, 0x80, 0x52,                 /*        mov    w1, 0x101       CR = UARTEN|TXE */
+    0x41, 0x60, 0x00, 0x79,                 /*        strh   w1, [x2, #48]   Set CR */
     0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
     0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
-- 
2.47.1


