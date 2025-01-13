Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0067C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKu6-0005d6-4E; Mon, 13 Jan 2025 08:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtY-0005YJ-UK
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:26 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtW-0007f5-4I
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:19 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso29839095e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776456; x=1737381256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XyxQFIaesklbSi1xUcLqY7yAiP7hbZCiorkIOLRK+G8=;
 b=JUpdaGnX4rEO4Sdi6uUJ9hHsfXtNnuFEQrfVezs0wKY8f/EeJ2PN9aLM//H+5ZKnkh
 3fhTwNM8LdtS6+IL3TY1ofxArHkbIREi2aQUfbNd9TK16hSuaW72R4YUAMlphEMBQgDn
 uIrwjAC9sx+jF+xuMXzn7qksFKRVY1LzHspjX9mTF1cHTuhMjM40OwaCHBU1f72yFclv
 utfftUMIA4uAYzwGiu2lNIiKbs5mm5m1uLhtqH5XuCD/7GoQC+EvK1xV55IUlqSILUqQ
 cxaEb675MXA8KNhmdO+PyRTTFOQahjpFAuKmy6GLQUkBXJpK6lQRLPvFpY1S6YX0tlPi
 Vi0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776456; x=1737381256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XyxQFIaesklbSi1xUcLqY7yAiP7hbZCiorkIOLRK+G8=;
 b=u1KUQwhnaDyXIs+W7huqnSmcUVE8Kn8871+wt2E/3tH0MhFksQ2VNzygRwACRZiaNc
 kV05FT+4RuYH8fED2ywrLRe/r0Yle7im3nehzXSh3wm8f8/jFCN6Cz8pxJQVY6h3Uzkd
 c/ZtteE8NwdHzrjZq48iMoy1vyBdPAeFA9wOCILN0rNpukNI1tKuQHjFiuSIjflajjhb
 fu2dbaStNmQf9weLIi9eQwqhWICgk2S6E3L31KcqFuqiJMWNlF2j+hOsSTy7IJLmWDlH
 B8wd+RhtM0kIKTieiEU7zApgd1m1oXWqadVg+k376roEes/xp4g8y1CU6NwjsnqLLcjf
 S+iQ==
X-Gm-Message-State: AOJu0YxSWJKEhveOHppCHc/pvmaYg8mA/nuLn9JEfzjmWkyLit4b7D8F
 1bpTLbnAnj9NxPJYN5bA18ibpYkBup8ZC4u6DUFdljtrTaXatdjLRoFQTIg6Se1/Wk3HQnX73t8
 b
X-Gm-Gg: ASbGncth2DSvnIs/OhBh6sU4ICf70ouJEegap+6kQ/BFoMfbmPLjErfUtrU1jCzOygH
 pdL/N4Y/HflNNkmo6kaCo0HcLt8mwxtlqGCDf1H1d4coWv2R9XnULnJta6XkdokJl6yPoMcU5Nx
 VUMEBLwdl7j+u68sHToiYulJox0ScyD90UGydAhaFqX3S7e0bi8GSBq/H9UShNnv1rbg82Ob4cw
 WZu9PFhVzMY65vLR08mtgCRknVgNULqrM3oprqwNTooHjuZpXHqeiFXoBWkwA4=
X-Google-Smtp-Source: AGHT+IGFBWiBXz7PtgZdMWImdmss+Giw6GrEeDbWqeGLWJJeLf1E/m7fL6uVjf+gfFBfym1xuUVgUA==
X-Received: by 2002:a05:600c:3b99:b0:434:f925:f5c9 with SMTP id
 5b1f17b1804b1-436e266dfe9mr165345905e9.6.1736776456581; 
 Mon, 13 Jan 2025 05:54:16 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/11] tests/qtest/boot-serial-test: Initialize PL011 Control
 register
Date: Mon, 13 Jan 2025 13:54:03 +0000
Message-Id: <20250113135408.3164401-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

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
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.34.1


