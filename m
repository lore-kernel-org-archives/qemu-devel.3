Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96077E77194
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 11:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTIua-0005FM-7t; Thu, 02 Jan 2025 05:58:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuX-0005Ec-84
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:41 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTIuV-0000NR-QB
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 05:58:41 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso67990505e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 02:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735815518; x=1736420318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BHcoHA/RQIZe+ped96wKcqmPBxHPHj0rhc9qRvCdUxE=;
 b=dn7lKPvymV07NQcU+g889w3jGEWrZV1+WydbxyZW9/sLCodrAJE2uiEXpuKGEYQKdt
 /fGsPTYqh/Cek4CoYfqsr959oOxPAOPJZcrvO2TYGQFVeVPntOiUGLtGteTADKmiDQfW
 YLmkwj3Sl20d0MwnQJYRsSr2wkkDGJsLee6rEo19FadkGmzFCpPzmx3ADPewk82auH0y
 VvSEbEZasNq+7w8QVaOSDuDs+1UqobrkdWr+ezBkjyvWGVEBySIla02cYG/YXLw53+QM
 BsgbXmjc0R5b+SW5iCmzoG31VkkK+JGikrnrPRMJINKWWCMs/MdQC2qYfIyDq5YU28Wj
 +b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735815518; x=1736420318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BHcoHA/RQIZe+ped96wKcqmPBxHPHj0rhc9qRvCdUxE=;
 b=wM3+1wm5eC+fwrQdMNZPvQQZ8KbVlFY+qJwfK6ILSeNvbkmWkzPKAopZk/ngc+PxSi
 i7ysyGS9OKopJ/QjXQFQcMp80wCMOL36VFl6z33Rc3YC3zK5Xo/CzxZBYsZYK7ZKpqZn
 r0r7exwpKwkdWP9d6vEt27PFNpe/ipfFUSVTIZ81EhnHNwpkZinW12hCdE1firyRHdyT
 dSLuydbWLBHTBvtAE3Sr3yaj8FuKiT2EOFigTju/aZrKCsQsiEU/dWRPbNukZN6XrKVE
 SxNIus2nu9/iuYFkNw32C5ZmI5aa2jQiMXZwRbfdIxcRTpYshqo3x5yw/eYZibXztE+Z
 Xrjg==
X-Gm-Message-State: AOJu0YyX4hSM8bjjA+6ZslkH6+wtb9bSsWcMY/JXtqy4KBYYSQghL3Yo
 lsR+06271WLzdFfQ1MqWGz5O2M2ikXCBwKpPxrUZBayLAuJtLm+VxRvHKgc1mZ7b3+YonXq082e
 Z5EOIcA==
X-Gm-Gg: ASbGncuDxqn+0ErVXaccPUSjd9lFqbrXpMbZJZfYm/hJeopVPgeaGBitm06AQ/cZiBn
 u47bhvk4DrhjDXA6c7M2Cc4/EoQQe88JaA0SMWh9kwRsrcejM+xZsnnUXqIOs2M2ZvItrtszCbp
 Pthb9MFWbB0ySrfi7QVUaMqIZqP3UWPEbxx40/zoZPQCUdvJNXKP0n3ZX2bHxp7+WiBIkE34Eow
 kSenQOdk6+IGnJA4wG6U7KO0SrqgQB+fTm/IhTgBNtL9nKe+Skp8RgDLJRWKgPJm9R1IxahpDUg
 oosOFbPi+yvUp1+bpaCAFsOJ+ayUBj91QBn52rVQkcGYwg==
X-Google-Smtp-Source: AGHT+IEKRCky/yyUHMRuXOE9UXP6e4nrziMa9ersCHkpgsDo8ZraJEler8Y5EuFdnm7k2zrq1NX41g==
X-Received: by 2002:a05:600c:5850:b0:436:1b0b:2633 with SMTP id
 5b1f17b1804b1-436699ffa24mr342304835e9.9.1735815517971; 
 Thu, 02 Jan 2025 02:58:37 -0800 (PST)
Received: from localhost.localdomain
 (161.red-88-29-191.dynamicip.rima-tde.net. [88.29.191.161])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b2afsm493916515e9.35.2025.01.02.02.58.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 02:58:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v6 2/4] tests/qtest/boot-serial-test: Reduce for() loop in
 PL011 tests
Date: Thu,  2 Jan 2025 11:58:20 +0100
Message-ID: <20250102105822.43532-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102105822.43532-1-philmd@linaro.org>
References: <20250102105822.43532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since registers are not modified, we don't need
to refill their values. Directly jump to the previous
store instruction to keep filling the TXDAT register.

The equivalent C code remains:

  while (true) {
      *UART_DATA = 'T';
  }

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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
2.47.1


