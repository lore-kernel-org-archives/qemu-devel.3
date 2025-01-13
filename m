Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFBEE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:58:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKuI-0005e6-KD; Mon, 13 Jan 2025 08:55:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtW-0005YA-Mg
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:18 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtT-0007eT-4t
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:18 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43635796b48so26700805e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776453; x=1737381253; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=79v/1gKgmYQk7SK0X40y7DTYrx0JaX5qxpw+HIAXaes=;
 b=rBw3TyTOIC8nFfr5/QolX6sEK5CUop1LILfAaBrGXuqwX0lJv3eIpuGB7biroBl8vU
 ay03VzddiH6iAGkgjQuQDC0AhZUxS/zdkqYaNLc7XIH52ItqG0ada/J8dzEBTFYtpIKn
 4LycFay7P3A9jaxBYJm8kYVUYGNhZATI4LUUvhtaEW9+n1RcdtScqvINtxqfz/hL6ie3
 NzxQtnAjuCV+Gl9jl56oWCqL+ss6axlytJl1CgUNkgNCiSt/cp4Api4XzL5/dnmzztSR
 8R+Le7H9p2q9AnVTiMNttJsXs/Zr71a/dgCyxHiTZn96pn22B597aej5ZrftliMQ/clT
 /IeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776453; x=1737381253;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=79v/1gKgmYQk7SK0X40y7DTYrx0JaX5qxpw+HIAXaes=;
 b=ZdpftqfPuWpuX0ps5MDYiFcLEq/pSxMY3MuXbc/zKbYG1TjzLjIRAd/H9MHHQl3InM
 N2944SlmI5krWWJa5wGNcmNRStZXySGsRL7TaQTvOaQOhyhEReNKLh7WguHISTS1M2VS
 FXIVZb6i69GSajKSOpenNfwr/3004pEbGR4x6RFpmGkurBiYSAc76HmeCBXeFBLu7z78
 mFiatqZZua7v/ufpU6rfIkTlV2jKbQke1LIAT1ezMmfKHKD4BgriMs+AKpzLMI+oYU/K
 zdCDO/5xlH0uusIbc3ByFzB4cf/w2xTdHzJVAM/xdxV5MVHKIuxVycy19RN+pjU4SP0i
 hecQ==
X-Gm-Message-State: AOJu0YzMgL8fm0/2sLi1MNEhiWkM8o6f3S+WZNGksQ5wQRgDRCadvk7v
 gx3K+eCreCLvQD3S2kH5AhGk4h8Y5UwHrwP6YG2dPMJVPG2zchA5JW4IVwIuY2MgIIgt7ZgFe9a
 t
X-Gm-Gg: ASbGnctr79YlLbyaqM7jGp/pwhVnZS1ewQiDf1ngPnJJ95NiQN3gQtbKT7Apwv7HNtp
 qGufsONUxiWFL2wVz2ebJZF/+1RYJLZr+YGsJPo8Z+pa5i6AkWh4bdYHpVZ5lFbgJOH2by47emy
 qwQJ1qdupk05bjSg51glGJcTfZcuvVRUWIuyFZLwpqtLcM037lu6gu9UgVOjF+FAfPnGFYgIFlw
 JWcFA3jIq9vy59fScA6PqzEh5Mziz9HBE+HLKxpYc8IzFKvf28COGK1x2TUy6A=
X-Google-Smtp-Source: AGHT+IHeD7qM3gm07r0LeSt87T9GzqqRAfDMth0YqnJO5gxyG7saemVJg4yKHJJdrUjqyE3lzip8Ew==
X-Received: by 2002:a05:600c:3143:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-436e9d74908mr139135915e9.9.1736776453362; 
 Mon, 13 Jan 2025 05:54:13 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.12
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] tests/qtest/boot-serial-test: Improve ASM comments of
 PL011 tests
Date: Mon, 13 Jan 2025 13:54:00 +0000
Message-Id: <20250113135408.3164401-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Re-indent ASM comments adding the 'loop:' label.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/boot-serial-test.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 3b92fa5d506..a71d2857807 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -70,18 +70,18 @@ static const uint8_t kernel_plml605[] = {
 };
 
 static const uint8_t bios_raspi2[] = {
-    0x08, 0x30, 0x9f, 0xe5,                 /* ldr   r3,[pc,#8]    Get base */
-    0x54, 0x20, 0xa0, 0xe3,                 /* mov     r2,#'T' */
-    0x00, 0x20, 0xc3, 0xe5,                 /* strb    r2,[r3] */
-    0xfb, 0xff, 0xff, 0xea,                 /* b       loop */
-    0x00, 0x10, 0x20, 0x3f,                 /* 0x3f201000 = UART0 base addr */
+    0x08, 0x30, 0x9f, 0xe5,                 /* loop:  ldr     r3, [pc, #8]   Get &UART0 */
+    0x54, 0x20, 0xa0, 0xe3,                 /*        mov     r2, #'T' */
+    0x00, 0x20, 0xc3, 0xe5,                 /*        strb    r2, [r3]       *TXDAT = 'T' */
+    0xfb, 0xff, 0xff, 0xea,                 /*        b       -12            (loop) */
+    0x00, 0x10, 0x20, 0x3f,                 /* UART0: 0x3f201000 */
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /* mov     w1, #0x54 */
-    0x02, 0x20, 0xa1, 0xd2,                 /* mov     x2, #0x9000000 */
-    0x41, 0x00, 0x00, 0x39,                 /* strb    w1, [x2] */
-    0xfd, 0xff, 0xff, 0x17,                 /* b       -12 (loop) */
+    0x81, 0x0a, 0x80, 0x52,                 /* loop:  mov    w1, #'T' */
+    0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x41, 0x00, 0x00, 0x39,                 /*        strb   w1, [x2]        *TXDAT = 'T' */
+    0xfd, 0xff, 0xff, 0x17,                 /*        b      -12             (loop) */
 };
 
 static const uint8_t kernel_nrf51[] = {
-- 
2.34.1


