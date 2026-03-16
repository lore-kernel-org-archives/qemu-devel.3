Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7136AF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PU-0001zP-Bt; Mon, 16 Mar 2026 06:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PR-0001qG-9W
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:53 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PP-0003h3-La
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso38809835e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657770; x=1774262570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o0P6vt/hzdopXfQcHvxln1E4PPuo52b8fU4UsoyK39o=;
 b=RaYIe6bpnHEW79As7UeWXFFmhGbSiAUbCaxbFmuITcxQ2cGRQncjafYW0zQLA0B3j3
 Kzq16HSM0bnn1jCYqbd26GmbI8wHo238Zxdzp13syk2sO7lYvtjrqOxXoZ2P0iSb0OtH
 LmczkPr7MRyt1GuatjqHYiAn7RcZA4Bk5IuOeiVp+EUx53h5bqdA3hI5mTLiRlGPEQ5b
 zaKa5MUbh1kLB0XQ1VuV3lhrWaMNgYUN0DcYRtsLXHmI++hGLEw6DyGXCxSEBUkLT0xA
 LhZwCDbLET54/rt0JdDbK5VCLdY62Qg12Nr04x1ZM70auVw0hVeE2BbY6LYLPNpJ83vo
 fiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657770; x=1774262570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=o0P6vt/hzdopXfQcHvxln1E4PPuo52b8fU4UsoyK39o=;
 b=YA9YoQk9VueNXjqqTJGU7STloLVKnstQs1y6ffHCEjF/bxbm42nd7f/wpnXnHxU6/T
 tFJ6S4BE1JrD0MYQKUZCkFVa6P7Z9FwBQ1HK+s6uJ43aNm3TSuhaFe0e0wdwCp5rdHsl
 atzV0DAzaJ9ljvo3DzS73zDni60udCwzIdlA60BGBD+HAp9f/BRoqFE+y0USWDOzASiP
 vf0DG4YkxFA9K2/pc9FayMSrapCw1UvfPfMylrd8hahdYe6fpR12WpgZLAL9RxROPrrX
 BKlzLPRZkCZMldXEPchiMRvFWj+6ReeHZRG35RgPRzutpn/42LvNDBTLvidbM1pFnL7R
 H6bg==
X-Gm-Message-State: AOJu0YzwFwbQ5oSg+302yol6HNpisSAKuhu5EKpfTw/nQwvzCRuraa+z
 kVQCC1M8h+8aYaU/ymrJV09QVs5l5e/5qxvvTjaRitip8USDKBD5vz2dqKOQE8ZpPz2PgJbJ66L
 SXVDi
X-Gm-Gg: ATEYQzx/LEjBy+tfSgNhsHBceb8HI7Z1ZubjANGOIwoB2POOIlS/elxz22yZVj/iKAk
 y+b1PJT4eE603sToxlxEqOGoiJ91af/+08oT5y9n7X2XAmEiFaQMJXe68vHT/4G4e00iw6pimv/
 CK+B9ZB7l4FfGUNzglNxXz1OOB4SLsJIOT15Dcpo60uz93YDJj0S2rBaVApUCYPfoaY7WEufKGW
 8U6nRQ0+Dtf5XcrFXHSV+TSkcQIeEse8hye5TpZ3nuvv/7R60+xAO4JJcFu1Amn4lLYIK3R8BKp
 o9O/nSnjM8KnMBgSuyOyrowbuupFIbIrbeimg3qYSgNBePjNk+0EwJ1rX4Je0C2yKx2BvtaoAGM
 C40tXHC4fjpyjLtD9Q+euQvNqBO07B/r+xh5xj+EZ2mE8OETVdAlMsVVFL5nQl/o7XzkA/5yV3C
 lVSzLJ2Sv/B50ZbWB0Pu4qUsmjm24GWHbcC8rjGnz5YzM28v1oqpgGkRY2ER3fVZSAW1cM5alQk
 lcNzGA1+UM=
X-Received: by 2002:a05:600c:a46:b0:480:4d38:7abc with SMTP id
 5b1f17b1804b1-485566d6ec5mr216120095e9.11.1773657770142; 
 Mon, 16 Mar 2026 03:42:50 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/17] tests/qtest/ast2700-gpio-test: Use g_strdup_printf()
 instead of char arrays
Date: Mon, 16 Mar 2026 10:42:29 +0000
Message-ID: <20260316104230.836962-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20260310153334.3063224-2-peter.maydell@linaro.org
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


