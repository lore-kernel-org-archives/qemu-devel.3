Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87235EB106E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 15:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzyno-0007hi-OE; Tue, 10 Mar 2026 11:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyni-0007H9-Fl
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vzyng-0000TV-2o
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 11:15:14 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-485392de558so14165295e9.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773155710; x=1773760510; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ym63ilovpE3fs1+AVhjYRXUzfWQaS0KSd4iVsrOzsEY=;
 b=XCexwV5/K+UoVxECz5gKu3t+zKQi1/KA1BGeX45ZfNqA7xSbaW9C6tAXtf9pJ6ky56
 imP0n1MzsMF4oJKXCZyTztBpijDdSOTsbP0gd/CynbWVuLpb+wAibcX5TKGfwob7vdQk
 gyUaS0dILGNZO5JffcHd8Xvsv/TKpS++wTwO01cDI9smqtHOQUTHMiRpEkMQwrxyF3mb
 yeaLG8+wukskRDtTw8PrPQQJPKYvwRjUCb+mkEznj0lNnVJwE0huUFxWeAOsY6mgCcxK
 7MSVOjC51ddCoO6Rtk7V3AZI/z1l4YANQIE+p43q8IT/mJj0GNcC2/vFgZpwr7uI2lF5
 Y42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155710; x=1773760510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ym63ilovpE3fs1+AVhjYRXUzfWQaS0KSd4iVsrOzsEY=;
 b=M7tjWVQqKGg+tpxNp2B7GtRsnY+U+aZg79/3tl0FZXD1xUBlUm4wWXNnSNmm1PQS9p
 VH2txUMDDRBzfHm8HggULag7chQTSvnXh1qJ5tJj9fjRF0vSNfS3J0PonAmQ9dvnX2Vn
 Wmbhct3SL/x5zkxL+oYq4aE9PjiT+qJN2XCVW8IC8y1r/TaX1srBKKyvJjxXjODrQ39V
 2bQ233ePl02i/ZTw1I+bHJuvuExXZuVmLiJITzHfWJdWq3yCerHucaxVGwVCtp+pPxi9
 K5bkgPGaw4UTSdVgXn0atphHjvocCQ8rK1ysR1ZyrWunQ/1OdApXGrmWJCQeFUnJp1R8
 gm2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf9Bt5qnLKbJLYXPzzSoURPfutPCEpNupSJfiIaIGQrB3ehWjDnamx3HSaelLwVo/9xi5WzJEXpEpw@nongnu.org
X-Gm-Message-State: AOJu0YwLfBtbmS1cF94/XvB5Ia+C5yYCqP8agajbKuEqMuP04iFY7Edc
 B1TkCD+rn6ggQPf+c+Bym9nh5/hB+9eUql1uQ8UQ1HczZeoxplecmm9eTA+pQX0zLsc=
X-Gm-Gg: ATEYQzz62J0pm1waW5kQhwhnL0c3M5wsV+yoMiwa8jyldfhRQ0rIXj1DfB3WXH0C7BV
 +kV6Qc40c77L5C41Bb6L4P2jbRfUT6xB2Rc+0yJgGhruhA6n0JRmw9wWCH7cNuwBkxvWqtCSxBw
 +y28dPM12bLP4miof8exIfuHEyn+gdociD7YJpiPUZT3qYIgZweQXQd+ZEM6lEoXM2tmm8hpV7Y
 WLmstxIQZvxIkCc0+iN6DqnGJs6smGSsn2RPFeMopnU+awGfNFNYzDIr3XCz2s7De9Dir+HXk5m
 7tOgZ+mfR3U3JxFjNxyw3S4pYepyjQXM9jOCxtKpkvWKBDt3qFtCjiVoihaDo5BA0y5Gx7F1Y5+
 i05JRxwq18XM4cz+RR322HXwWJ9ZxYj2X12tbU21s6VLoiNh0pS3DS7+28HkVZkCKr0kgd/OG00
 FYE/jetFsnWxhrYWIm0iJ1M4hftFcPcdTOrsrTrubHCKcXvVwcDb2Mqk1iNFgFPMCDA2pfIvDey
 XF1FEIapbiTEFKxGGnW4/oNOV1NUWue+RKnQmCeQw==
X-Received: by 2002:a05:600c:4e94:b0:485:3fc6:c0f3 with SMTP id
 5b1f17b1804b1-4853fc6c35fmr101139245e9.0.1773155710416; 
 Tue, 10 Mar 2026 08:15:10 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853588758fsm127303185e9.4.2026.03.10.08.15.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 08:15:09 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 1/2] tests/qtest/ast2700-sgpio-test: Use g_strdup_printf()
 instead of char arrays
Date: Tue, 10 Mar 2026 15:15:06 +0000
Message-ID: <20260310151507.2973843-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310151507.2973843-1-peter.maydell@linaro.org>
References: <20260310151507.2973843-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

../tests/qtest/ast2700-sgpio-test.c: In function ‘test_output_pins’:
../tests/qtest/ast2700-sgpio-test.c:27:33: error: ‘sprintf’ may write a
terminating nul past the end of the destination
[-Werror=format-overflow=]

../tests/qtest/ast2700-sgpio-test.c: In function ‘test_irq_level_high’:
../tests/qtest/ast2700-sgpio-test.c:85:33: error: ‘sprintf’ may write a
terminating nul past the end of the destination
[-Werror=format-overflow=]

These can't actually happen because of the limited size of the values
being substituted in.  However rather than require readers to check
whether the arrays really have been declared large enough, we prefer
to use g_strdup_printf() for this kind of string work.

Reported-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/ast2700-sgpio-test.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tests/qtest/ast2700-sgpio-test.c b/tests/qtest/ast2700-sgpio-test.c
index 56c54cca9b..529408ca8f 100644
--- a/tests/qtest/ast2700-sgpio-test.c
+++ b/tests/qtest/ast2700-sgpio-test.c
@@ -18,14 +18,14 @@
 static void test_output_pins(const char *machine, const uint32_t base, int idx)
 {
     QTestState *s = qtest_init(machine);
-    char name[16];
-    char qom_path[64];
     uint32_t offset = 0;
     uint32_t value = 0;
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
         /* Odd index is output port */
-        sprintf(name, "sgpio%03d", i * 2 + 1);
-        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        g_autofree const char *name = g_strdup_printf("sgpio%03d", i * 2 + 1);
+        g_autofree const char *qom_path
+            = g_strdup_printf("/machine/soc/sgpio[%d]", idx);
+
         offset = base + (R_SGPIO_0_CONTROL + i) * 4;
         /* set serial output */
         qtest_writel(s, offset, 0x00000001);
@@ -45,14 +45,14 @@ static void test_output_pins(const char *machine, const uint32_t base, int idx)
 static void test_input_pins(const char *machine, const uint32_t base, int idx)
 {
     QTestState *s = qtest_init(machine);
-    char name[16];
-    char qom_path[64];
     uint32_t offset = 0;
     uint32_t value = 0;
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
         /* Even index is input port */
-        sprintf(name, "sgpio%03d", i * 2);
-        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        g_autofree const char *name = g_strdup_printf("sgpio%03d", i * 2);
+        g_autofree const char *qom_path
+            = g_strdup_printf("/machine/soc/sgpio[%d]", idx);
+
         offset = base + (R_SGPIO_0_CONTROL + i) * 4;
         /* set serial input */
         qtest_qom_set_bool(s, qom_path, name, true);
@@ -73,8 +73,6 @@ static void test_irq_level_high(const char *machine,
                                 const uint32_t base, int idx)
 {
     QTestState *s = qtest_init(machine);
-    char name[16];
-    char qom_path[64];
     uint32_t ctrl_offset = 0;
     uint32_t int_offset = 0;
     uint32_t int_reg_idx = 0;
@@ -82,8 +80,10 @@ static void test_irq_level_high(const char *machine,
     uint32_t value = 0;
     for (int i = 0; i < ASPEED_SGPIO_MAX_PIN_PAIR; i++) {
         /* Even index is input port */
-        sprintf(name, "sgpio%03d", i * 2);
-        sprintf(qom_path, "/machine/soc/sgpio[%d]", idx);
+        g_autofree const char *name = g_strdup_printf("sgpio%03d", i * 2);
+        g_autofree const char *qom_path =
+            g_strdup_printf("/machine/soc/sgpio[%d]", idx);
+
         int_reg_idx = i / 32;
         int_bit_idx = i % 32;
         int_offset = base + (R_SGPIO_INT_STATUS_0 + int_reg_idx) * 4;
-- 
2.43.0


