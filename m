Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFCFE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:58:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKu4-0005cX-2k; Mon, 13 Jan 2025 08:54:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtW-0005YB-Rj
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:20 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtV-0007ec-0C
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43623f0c574so30837495e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776454; x=1737381254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1ldNjIBGlXcB7GHvIaahhXw/jNRalb5uO3ZvAdqQJUU=;
 b=Tv5KBuYTJT8blB+DcdyHvtlbJm5IzdzLQndmrXGU8FHnD3QQZa2i8OzinyEm4tM/gm
 5UJ18YQyFmILV7RwRRBcEWq3S+B5Rw0HhY6lIcE6O3m7OyrQ8/OYbZYcgcxvREJ65qKA
 mdfDfQHZXZT0tWvw88VmwDnWsZknd0L/4uccVFuZorVMImLN4ssGW8BrI4XqyxYjMBz5
 BWS1PiKe+Toa/pQL/GvkAD1LYow7kfI4S8ju7hY23TVrmXnHhumXYmLAgPmMsPEG9RPb
 EmIAPx+rN6daK+3uuUO/3W2dIzGOHoiRv7F84N4DzWsgwgZcv1bHj3M7xiam2ZR0OzBS
 9RoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776454; x=1737381254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1ldNjIBGlXcB7GHvIaahhXw/jNRalb5uO3ZvAdqQJUU=;
 b=DFCWMz67uqVotensI4fGRz4zUWrYLQFAeVPbq1zQXlz4Sk17MKGq4NoNeeB7ZgYrYh
 lF7Lg1nHuhSNDI6XD/8vxEGYWAyvHwcF2ViODoVCZHAmVR1aYKw3JY3tDyR57CUzonkG
 qy9cGYyPbJyW87B6MXrkTXwFTJpqnMHkgsjlnQ0LehjOETOdfvv5TdOTxze2CKW+lk+0
 sEQRenesQ9Ps+0p3EXQBePxMn4i04T7hvmzQ3ixTMfzjcBG678TY73FScdl2EgL6TOKh
 m/KnQke9D5vtBxYluxoWkwfCPtqeB91UaakGIGnc47wPBDYLteafLeq4IolmHBML99Rc
 VX9Q==
X-Gm-Message-State: AOJu0YyAde6hzlUB/Ht3OZ6WUKCNXLN5zwKxkFYVnHDkBPKyWBp3qLFD
 t+yfL1rNd7D2+unCSPyMbuX3qjBQA6/1I/2PdNOktvcuJG+7jeH/cgfWhZmawDHC7oLLydsO8Vb
 t
X-Gm-Gg: ASbGncuXHMDvBwoe5Dbybl2mFXpBoH+FDehMhwPK7wvV14SGdyvqSmHkTlM+RpVt3F4
 xUFMc7U7dB0uFphc4UG5TYahTm5+fyDSOqgC54mB3YeSsdoXctzD7ETe9Y3LI6//O+XEjwSnwZt
 q4dSs06I339cfpu/BF6bF3fecNunOa7VPClv8PECfFvAQM/BHZPcZGY4aJ2A0AvMMA0wfMEmE1d
 tzSnzLJkwN3QNYbSTlrPoG4NYwX+wzXqaSAYlZkLJOfxbKTflfnoKlD34wPSIA=
X-Google-Smtp-Source: AGHT+IF3PN/GPN4P1+yGPcqxv69rKI/Md+mMjdjcVyaIsMV5/pd2iNPBBXiupTwldhjzb+ahkTecTg==
X-Received: by 2002:a05:600c:1e0e:b0:434:fd01:2e5f with SMTP id
 5b1f17b1804b1-436e26ef441mr187356355e9.29.1736776454199; 
 Mon, 13 Jan 2025 05:54:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/11] tests/qtest/boot-serial-test: Reduce for() loop in PL011
 tests
Date: Mon, 13 Jan 2025 13:54:01 +0000
Message-Id: <20250113135408.3164401-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

Since registers are not modified, we don't need
to refill their values. Directly jump to the previous
store instruction to keep filling the TXDAT register.

The equivalent C code remains:

  while (true) {
      *UART_DATA = 'T';
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/boot-serial-test.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index a71d2857807..553575ca75c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,18 +70,18 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /* loop:  ldr     r3, [pc, #8]   Get &UART0 */
+    0x08, 0x30, 0x9f, 0xe5,                 /*        ldr     r3, [pc, #8]   Get &UART0 */
     0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
-    0x00, 0x20, 0xc3, 0xe5,                 /*        strb    r2, [r3]       *TXDAT = 'T' */
-    0xfb, 0xff, 0xff, 0xea,                 /*        b       -12            (loop) */
+    0x00, 0x20, 0xc3, 0xe5,                 /* loop:  strb    r2, [r3]       *TXDAT = 'T' */
+    0xff, 0xff, 0xff, 0xea,                 /*        b       -4             (loop) */
     0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /* loop:  mov    w1, #'T' */
+    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
-    0x41, 0x00, 0x00, 0x39,                 /*        strb   w1, [x2]        *TXDAT = 'T' */
-    0xfd, 0xff, 0xff, 0x17,                 /*        b      -12             (loop) */
+    0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
+    0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
 };
 
 static const uint8_t kernel_nrf51[] = {
-- 
2.34.1


