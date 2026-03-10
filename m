Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CCFEEB1072
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:34:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzz5r-0002s6-34; Tue, 10 Mar 2026 11:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzz5g-0002qn-4s
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:33:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzz5a-0007rV-Bt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:33:45 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-439b2965d4bso7700669f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773156820; x=1773761620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phyKVf8+i/f8H3jvXeFmhE7LF3Q9UMc/WnROb/AlnvU=;
 b=VHFukDTYvgQifa5JNQVGn4XcO3r/CBxqZqQOG3t3FNnY0lNDtyU9OlCWTvo5kErZg9
 fux9IzMNe5QovtYxV4lKjL5J3G2JJUA9jqdaWvMPwN8TKbFs0NBAd86SWusuOqCluVzU
 fMUSXKcigUDHxV77tRVxMg4tg5I8N8UN+d1vczaWUk6jV+svfogE2IlrVBdhLRlZP393
 ofXhlEunLfZeVvJZYlv/AZ/hK063NgRKHPgMesIdgsFdpGclRNPTINP0zipO5ibS8duc
 79iM4upuWMISY7MJ1GyoLyzgheUI17btfilHi+lo26TC3I/AyYZaYJvEy4sexEJTUfTw
 cRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773156820; x=1773761620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=phyKVf8+i/f8H3jvXeFmhE7LF3Q9UMc/WnROb/AlnvU=;
 b=spywgkAlBgOrnT+ibt0xQCoz/z9IwSOtKBgQcTFjwOWlqfnXwm4uP4NOwy2+V2qFSb
 vc2DYM/otOa+apq//wy7nUSidodsZNOV4wMOPr1paFcUGzLQnntNh/VQiuvFj8mpAxye
 x+iLpd5YGhKc4epXQsQSi8/LYDrVA7OBVY9xA/Fm9vu4WmsFOx9JPPXdYWcTCP57h2tD
 6t6MhyECNOixwoWCTZAxDv2JtDuxZXu6HyQInUfuqelmXx2ke3Tt+r6Y3uZmrznSwgVt
 MLcpStxF4EnhI7+FUN/rMR/xxEyYVNJ8qNGBZJlk7is+n2rVt4IYEw1HsO9lNG2d9itl
 etcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0AWYOBpM+ruddYj6WCHPJ7gBCegmzemzf6NlvI0T1hW8wSO0zpHaJ2TnnetkY0pldu5t5jpy6Gn6@nongnu.org
X-Gm-Message-State: AOJu0YxzG2l+u5T01YYy1iUweM/WjoDOmvLASnFuVVLosboLlAyZZOsu
 0ozpByQhTbjyNxiFxj5TknCU7Nu+OkMsuYtWvQhCrp7R2JUT970TJGQ9aAMKIOQ7qJc=
X-Gm-Gg: ATEYQzyZCrEFcIf2Ou1P+Wf4cIgqbuTLW+d0xRllnZdSo+nPKjCbtgb2UvJEAEls23w
 aNz6/UTUXtMG8UXOQE3dAmWE1TH8szpM+dGpZZf6XQe4d4N3z0qjc7C2M+FRjaeXNZCBsTYaYWx
 HOY3wmaObIewebScGq37earT9aOz6+eYaJc6NrSNQEER57Ar3t8O5TAZmx7T+RhH59EqbMBuQaB
 FVqS+RE56SVNAPZjjyC1MBjaIXFmZ6EHb5eAa03DK4+ykTM6JYiQbUCbUS/0C12WsOae7hAdRRM
 EWJ1Z9SVJtStrV7L6JQklqO2Gezj2IgmnAMfJR8LuOKI8m6VbDK1U/mxwfSAt+jFmokv9IWrPhC
 vkYA+b5xrAhRFq2O9pelnwj1KILeDffqjj3pnAZCB2CHIi5yPN36F4GtcQ3lOhvRMUem5163DN+
 PP0K6AS/8IoMZ2XjCYMZslvlZsbi2GHzcnoh8x1d/x35/GECyRiQmoSTTsieN8o8V4KmVxXB8gD
 BomIgbXy3/HX6PffHkAL6SAp4Bm80++DeisFEosmw==
X-Received: by 2002:a5d:5d06:0:b0:439:b8e5:5c36 with SMTP id
 ffacd0b85a97d-439da35ca0emr27292959f8f.24.1773156819959; 
 Tue, 10 Mar 2026 08:33:39 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae45786sm41709388f8f.32.2026.03.10.08.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:33:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/2] tests/qtest/ast2700-gpio-test: Use g_strdup_printf()
 instead of char arrays
Date: Tue, 10 Mar 2026 15:33:33 +0000
Message-ID: <20260310153334.3063224-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310153334.3063224-1-peter.maydell@linaro.org>
References: <20260310153334.3063224-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Older versions of gcc with -Wformat-overflow=2 don't like the usage of
fixed size char arrays in this test; gcc 7.5.0 (SUSE Linux) says:

../tests/qtest/ast2700-gpio-test.c: In function ‘test_input_pins’:
../tests/qtest/ast2700-gpio-test.c:54:36: error: ‘sprintf’ may write a terminating nul past the end of the destination [-Werror=format-overflow=]
             sprintf(name, "gpio%c%d", c, i);
                                    ^
../tests/qtest/ast2700-gpio-test.c:54:13: note: ‘sprintf’ output between 7 and 17 bytes into a destination of size 16
             sprintf(name, "gpio%c%d", c, i);
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This can't actually happen because of the limited size of the values
being substituted in.  However rather than require readers to check
whether the arrays really have been declared large enough, we prefer
to use g_strdup_printf() for this kind of string work.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/ast2700-gpio-test.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qtest/ast2700-gpio-test.c b/tests/qtest/ast2700-gpio-test.c
index eeae9bf11f..533feea7da 100644
--- a/tests/qtest/ast2700-gpio-test.c
+++ b/tests/qtest/ast2700-gpio-test.c
@@ -44,14 +44,13 @@ static void test_output_pins(const char *machine, const uint32_t base)
 static void test_input_pins(const char *machine, const uint32_t base)
 {
     QTestState *s = qtest_init(machine);
-    char name[16];
     uint32_t offset = 0;
     uint32_t value = 0;
     uint32_t pin = 0;
 
     for (char c = 'A'; c <= 'D'; c++) {
         for (int i = 0; i < 8; i++) {
-            sprintf(name, "gpio%c%d", c, i);
+            g_autofree const char *name = g_strdup_printf("gpio%c%d", c, i);
             offset = base + (pin * 4);
             /* input direction */
             qtest_writel(s, offset, 0);
-- 
2.43.0


