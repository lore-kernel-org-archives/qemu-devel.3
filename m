Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6EDDF46445
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 10:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w25PR-0001rG-Ih; Mon, 16 Mar 2026 06:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PP-0001ie-SV
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:51 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w25PO-0003gi-3k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 06:42:51 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-485445e80bdso38566435e9.0
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2026 03:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773657768; x=1774262568; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q+xitAlK1s/NviM9Oq68epH9BMAZRVhmQhy3D1hM4gI=;
 b=llifjUQ8LEPd8i0rNZ6OcffcCVSnwQCMOfdr7kwsGc9e/6y0wTV8Wvul3N+1johGoo
 CCzsEPl/BbZF6lPYP+wn30FAVlR7/WSCLZntOC4uUk0ao5e7PQYQdkP+HkVmnSKleK2K
 0zeX46Q+EAFFLPSc32FKxjyyeFWfZOlNItYJq8oDCvYN391qmvw4J69Of5s3+n7LR+d2
 Cs7n2tRS0cCKOva2teJSN1MkCOIUoekWBeFL+1JPrkgvBg//p37brDfz94yY0u+QPwOe
 vYU8DykITpsfDld9sUVj9H+GU7f34vxJnFQMfOJcKGYhGp7I9YCcs5JHphiTJBJdY5ON
 itAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773657768; x=1774262568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q+xitAlK1s/NviM9Oq68epH9BMAZRVhmQhy3D1hM4gI=;
 b=bBnuso3HKDBPZl1FPQOj7GnzpPyCk9khtbKERUo5Z8l9Of6G+POjklairaWJhcHnqg
 egJGTXM2GSLnKQ4W2EoHp/4rLG+TDG5jA5rv6a8Dp0e8nMgHLXo36zeyENcPnXCvs6I4
 TglDuYSNAMFECogXvbNw3xg8+oFHuiWG61VgRh2oA7VBoHxQBGn5LLLwIZj15FIF2lOm
 0z70j+QCUDJnUqu0jNPCCeARzRBorUvMYJPRlzholbntlWd2CaYf+iQbTWAKdD6aO9HR
 S1h6UVIy0ZiJo/lmf9aWO6TSHyZz8TUzFFlrpNB/GU5I+dX5fvzCORa6cyCahZP7eVMC
 uUZQ==
X-Gm-Message-State: AOJu0Yy7djJvB32nskPNB/5uKzL1m/O/3Hs+cmQxPl+zxC0r/+HDjJTx
 MTpa3ZgrxNROTOosiKgCdxoN3QomisCPkrk8b9loKc5ISdaTOuU/aRcX4Up9+hooX9Vju7ts/mV
 ooDWo
X-Gm-Gg: ATEYQzzETdAd+JYj7acJYvbmzpw4FU6NSowccLdz60WX30gfDXH8qp5B4+u4DPok8B6
 F6nTUtsJTYMPkv6Wp7Tsf9QrzkCocfMTPVNIHyPv/np5ASUGME69fYwZCqmUg24RWXKuc1cqEzS
 +6wMm/WG2TWJVQOqWL/Uau5FglQ6dgbiA14+S7gxCuYJIXqs0hVZ65lbKHsTqDVxZN8IfgN+Fj5
 uO3ARjaieuiEGFHUn7jwMH0UnFiKuGMmq9s3/cxAt1bpqStwZCUNjvcUsut32bHUa84tvwyWkFn
 +408GOB0hIS1S5ud+XEEH78ag3C4/ksBMFWDYegwgckrH+Vu1B9xRmYlPbvmsMLSE/FjVDgVvzx
 mUWzYUqiQ4TEk24DKSeWloE3D4ul9CJac17diX3ugLuy82A6DmbJJt3DkJwH/mkLXXwPe/9weKS
 oPHRmMl8m3+GFzO3nl0MPGiMiT+SLbDkrvELGcGL4rcMYul83V18Axn7Oa7+OuzRDnvKwpm4in/
 jfwSp715sA=
X-Received: by 2002:a05:600c:1d0e:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-485566ea474mr226129845e9.11.1773657768176; 
 Mon, 16 Mar 2026 03:42:48 -0700 (PDT)
Received: from lanath.. ([81.2.115.145]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48557a74266sm85519135e9.17.2026.03.16.03.42.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 03:42:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/17] tests/qtest/ast2700-sgpio-test: Use g_strdup_printf()
 instead of char arrays
Date: Mon, 16 Mar 2026 10:42:27 +0000
Message-ID: <20260316104230.836962-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316104230.836962-1-peter.maydell@linaro.org>
References: <20260316104230.836962-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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
Tested-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-id: 20260310151507.2973843-2-peter.maydell@linaro.org
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


