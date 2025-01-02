Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63586E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 11:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIul-0005IK-FQ; Thu, 02 Jan 2025 05:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuj-0005Hr-Do
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:53 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuh-0000OT-Bs
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:53 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-436341f575fso116668555e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735815529; x=1736420329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7PDwfX0ojLlp4yH1fFPzelM0oZpBBYGTWR3yxzH4/fc=;
 b=RM2BuZEoGRibG/9TFcb3DSHG7q7sc/u+t377pe4esW7K386QPHE079wNBLt8hg2UGr
 6N0W6WSXpkJ382atEVuusIE1XU3fGSp9A8HKj3M2KnHIiV5TyKz9gkvIceJZcJ+pghUv
 +XsXc7ayX03PZKuUmjal+xajhlyygcn+P1eJMFi/07GStc/TadnQoU0j8/cMKuhL178u
 kmZduQJZQimwKh6Yex962nMSPqCou9aa+R+ZU5d3YgQoh2RZBe8VZEX2pp6DqfV2z6YZ
 i4e5oaCoN8ep+D+MLO2Rb8kZrXMqyu3l+TS+P+FzMXwD4kxkhiF3RuRj7h2L8sEk8ieL
 Ve1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735815529; x=1736420329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7PDwfX0ojLlp4yH1fFPzelM0oZpBBYGTWR3yxzH4/fc=;
 b=E4IKb7bRmIwfzKWEtijmk3TRhR+hz9DpEHLVPRVeQE9jj9C9Y/VglnDwn7ZVpYRzJO
 iiOHtK6xsKLYWTKxUjAp5kbTQ0p8GxsCGRbFvaUZWFDf0si4j9ushsyel2Ga6zWNouWK
 QBljQyovpkBmuEaj6+9x7Ml5npZYyht6O0DvAc8dNwSMVsEFEWm+ex5Ck7+vRpLczflf
 nDa2ghueyB4ubFcI20Vs2nrwLzZLFhyCQ+BIkU2z8wot7XLFmOB2kqDCnvEZnjbsMeqJ
 SRvm0cnlxNfpX/WGA5bv1pFQLjzTQ2X2IkynZwzE65yhj4/kj+NrAn/q50qb6HgGOOTy
 uMlA==
X-Gm-Message-State: AOJu0YzJYclZC/9dmXbe8O5TWjWe//3QdQt19uGuRFCiJpLKEilS99ha
 59Vxn2ZEcRT3JlBxGysbitEHxh2EBVQ3qvsJ7zWT0UvYr24rfa8zA3ScIIXhrRfjn1AUnBXY7LD
 flJFBlA==
X-Gm-Gg: ASbGncukgyf/O7fy5wCeoJ9+gHmDBTXu7DEGNFl3xdGWGXgZJ/DozPFAlbkgerUHvzK
 huIVQpTH+cMK3Y7Fn5RSmsscL4EI2npu0vQRBjD9rYHR9ry1fin5YG7CEjGvNggggruPZLp/b3I
 O5hz7hI66w6HXOAG29+szZyOBVln7paqvocr61f5mRkLyODvWzQsxo4dpuasVe51YwOH7WdHGVQ
 dIYMHcrNB56A2kaXurxYVlMHw8+HhCtc426ktpJE3oy2zRg30KptS+nfyI7G0VWSMxn+l1HU4+7
 4M/rZWQIpgyUlxLS54B9oQDa4H/U4wcVnRzypQ/FIWkWOA==
X-Google-Smtp-Source: AGHT+IG+ddtTuGOMtP+yqqCrOaIUyc4c7Ql9T9XdMaXeFXzvhJwWKQTp3nUD4PkVOab5MxntrEXXCw==
X-Received: by 2002:a05:600c:1550:b0:431:4f29:9539 with SMTP id
 5b1f17b1804b1-43668b5f892mr336416215e9.32.1735815529296; 
 Thu, 02 Jan 2025 02:58:49 -0800 (PST)
Received: from localhost.localdomain
 (161.red-88-29-191.dynamicip.rima-tde.net. [88.29.191.161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e1a1sm37393738f8f.69.2025.01.02.02.58.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:58:48 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 4/4] tests/qtest/boot-serial-test: Initialize PL011 Control
 register
Date: Thu,  2 Jan 2025 11:58:22 +0100
Message-ID: <20250102105822.43532-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102105822.43532-1-philmd@linaro.org>
References: <20250102105822.43532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/qtest/boot-serial-test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index bcfa504826c..6ea7e62e076 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,15 +70,20 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
+    0x10, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
+    0x10, 0x20, 0x9f, 0xe5,                 /*        ldr     r2, [pc, #8]   Get &CR */
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


