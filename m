Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAD9C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 13:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXKu4-0005ct-NF; Mon, 13 Jan 2025 08:54:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtX-0005YD-6f
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:23 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXKtV-0007en-KG
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 08:54:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43618283dedso41304145e9.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 05:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736776456; x=1737381256; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GWUNcZKxKH1utC8rl9Z3vhv6hG0D9P5xMDHSC53HwPo=;
 b=CCthGWrHCb5536siOFOBSaWAxkekt3Q/pn2eAyK0rswUCzqL752uRwSW+bLPPu9eeL
 OLvpFwBr7EILmi8qn8lytCmv4MXVi9AAOmAX88Ga+0HKqN7eMCAm0hBAaHTavh6veWKI
 2hbXLajvM/IgFPsJx4IRQaNbyIt4ANJJ9peRYLUbFKlrHBPoolToQYmQZXPOI+pdh9oT
 WCPXKdVQUBOk983AEkLg794AEMDxen4e7LKsaHlq+4KJumh1PzsXXE7xQiVZDEvMLZty
 f0bQMYZzKMnYvCRISaCYcteOJCjjwnvkWk4mbtLaoHQHrpNL1aWrUFx0XttX1eav00WW
 v+Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736776456; x=1737381256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GWUNcZKxKH1utC8rl9Z3vhv6hG0D9P5xMDHSC53HwPo=;
 b=fUS5W+hcQoNJhCagQ0zFthIw2d4DO2f9E+188hOf/3zEBdzuhUTWgK9WmnlYn6E5u6
 58hET0KTPpKVAWKiqhNSfq7xlK7pAzwpl7sgNUqHZp1qHjQXU1FFsXtM/8Vs7XWy/rVA
 7lYJRE7h8MLAhrthelWp6Uen1InfuNOX7ahyhDdMrlGTVvBJBPPK8qgrVnFFNmBvQktT
 ReDfBJnVHA7zJFFGu3hyxzuFqdFpQB4njIcPk5NlU/lb3kUyiKY54RR5pb7cpJEYhfrt
 1YQUwy6t4UpkBmAxSmMv8aaQ0dAcckfZXAAP1ppRK7PyICpTYLEF68aXojUmL7QrNEY+
 /x1Q==
X-Gm-Message-State: AOJu0YzG5FfH497Z9ovDs55jW3tcNnxR6JOJdWZ5u86jHYWe3xI1BoX7
 EvybWeBhDoNU8ztgD7Q+vA2Du7dX9d01NGC5xH85bcD9yYWMNXEirISpUZLSuK+Jc/p/sskYLEf
 p
X-Gm-Gg: ASbGnctgxDdwLZlEJlUp6FeewMkGJ4M1DY1VUFxFr5msEa0V0Wm2Q+GjBxBqK6G0or0
 PTnXHR3YyoAvvyebEeUvtsRukOmJr4wD+Cpbs3Viba2MN42wQ9GGPKmzTXz4zV06MlAVvgtWGkz
 O+tVYMWC0CK2Q0mXACN9ohrjtTG2o89bvTL+w/X8DlU3nniitjpgb5ZdY896WS1EcycF6jqJfuc
 66783x3wBPnGe1xT0hi8JOUgMKi3esp5UcvbDaVDvRk9I16jBL56LC3A3Q09nU=
X-Google-Smtp-Source: AGHT+IHBWkdm7pXPIz0orpsnfjlXcUV2vKxU67zv53ZAbfJrMdyoBzREdPdVZ+4/aBcg9lTsln8cww==
X-Received: by 2002:a05:600c:8711:b0:431:93d8:e1a1 with SMTP id
 5b1f17b1804b1-436f475f6a3mr69790895e9.27.1736776455765; 
 Mon, 13 Jan 2025 05:54:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9d8fba4sm145245205e9.4.2025.01.13.05.54.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 05:54:14 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] tests/qtest/boot-serial-test: Reorder pair of
 instructions in PL011 test
Date: Mon, 13 Jan 2025 13:54:02 +0000
Message-Id: <20250113135408.3164401-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250113135408.3164401-1-peter.maydell@linaro.org>
References: <20250113135408.3164401-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In the next commit we are going to use a different value
for the $w1 register, maintaining the same $x2 value. In
order to keep the next commit trivial to review, set $x2
before $w1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 553575ca75c..bcfa504826c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -78,8 +78,8 @@ static const uint8_t bios_raspi2[] = {
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
     0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
 };
-- 
2.34.1


