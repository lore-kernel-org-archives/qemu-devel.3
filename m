Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D98E77199
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlNt-0005xb-IP; Fri, 03 Jan 2025 12:22:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNq-0005wp-DG
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:51 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNn-0001NU-VA
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:22:50 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4368a293339so88037345e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924966; x=1736529766; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MtpMvbVNvoKM9SuvMPCquWt8IFwwWj8rGKGNS/75JWg=;
 b=d/a0xUdTFjj5mEo2Pj3yGoWaHYG9Espjgj4eMRMdH1KUWha6GL2yT9oZsKdNyOG8hu
 VvKe20Hg17Oe7iSzSx9/n1sqiwTLU8GdsfxJLZ33b88u0j/wSC3lWIW8S2BnAYfco8qu
 0KDcSS4HWzLSbkqPA3q9POhU496HyUEYSnIzc11sg0TabozpjRPpOAr/7PgJHaLa1mHG
 7UJ2kSUr/g+bDc82cGJo5LbFkDRo5ZsLhJXZMxH8eI2rWF/UgpWNTdHYKD4vIpSyzmNE
 2Ered9RsglDCNJpVG2K0V90TYzO6LuuEmQU18AZOvdod2vEkZPOteUf6UT3DMz/ohype
 rMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924966; x=1736529766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MtpMvbVNvoKM9SuvMPCquWt8IFwwWj8rGKGNS/75JWg=;
 b=Fy3g/qQXMthmaoAw/K7IuPbtEuOrxc5CGngwwdtcSUbj3B8XiILlH3WdAfrKJavJ+O
 Scvi5XJ2salr+d4B0Xh49+YircoMUQDlYLrlQ+7rgH+XcfHDxCUnDOnJOLTARc0fkqgc
 fG37H2QQUPa8v9edw8OH+oTPUiIW6WoLxZdYwCgouN3FSbgrLW1vyC+kXDDNSR1hXZAf
 FbRCvyUz/mwrzdPrnj04LgltO3wn3VP0EMjZP3EPyfqd1xpVmGsZPdp0+e/M8k78WD2Q
 Hi0LNI8vFttyRCK11jpfsoehVs5krscxut3NFJnyV5gNLShO8eJlrjvoqR3wBymjzyv3
 /ozQ==
X-Gm-Message-State: AOJu0YwRQ4hM3G6ui39UwRkTiBIblhZuIJZLzdtmwDWloUexPKf465Z2
 JQOr/3iZImEO6DXvPKbyWJkpNPTJS+HQuUQXQxrvfQoxD/eDuzFFGRS6ptkLtH7w/pfyT/nT19R
 xjMM=
X-Gm-Gg: ASbGnctr2/VaBdVxQWRfNQyJdiJo+5eumAOLF3ZUkAuhrvbb+FejhWKzsXJdH9lZjJo
 8M1JCD9rjyCN0nfsAJAoi+sqQOgLDhThvqMjEsDQ8Y+vqp4kw93fvW5HiJ9fpKx38PxayGIFsDK
 6aykX+3adt3fTSk3OEziWLc62MQotedvSlNE/TYMg48+za8bmgJF3wlvUGPa3Cb6A7yGNCbZ972
 dYn7wbOnrmS/mYAg6rb/n0UwT/SQfPIfODMIMfiT5bQxZlT8Re3+/UwXaBlKYA6+XVj71w5mjLl
 ImA+dNBURO0ngGECWFzUwLMnsP4SpEs=
X-Google-Smtp-Source: AGHT+IH11Gn30ZNT6Y69v5V/iRxE5A2dAA5roGdJuSulNNNyJ0JwndcIHeupcLdn7JFSuPNDoRyN0w==
X-Received: by 2002:a05:600c:1990:b0:435:294:f1c8 with SMTP id
 5b1f17b1804b1-43668b93834mr341817175e9.28.1735924966014; 
 Fri, 03 Jan 2025 09:22:46 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b214sm528921215e9.28.2025.01.03.09.22.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:22:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 1/4] tests/qtest/boot-serial-test: Improve ASM comments of
 PL011 tests
Date: Fri,  3 Jan 2025 18:22:36 +0100
Message-ID: <20250103172239.18562-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103172239.18562-1-philmd@linaro.org>
References: <20250103172239.18562-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Re-indent ASM comments adding the 'loop:' label.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
2.47.1


