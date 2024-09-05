Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A72F5CD5BDF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 16:56:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smFm6-0007vB-Qb; Thu, 05 Sep 2024 12:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm3-0007q3-I3
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:55:59 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smFm1-00055K-SI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 12:55:59 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bbdf7f860so8683835e9.3
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 09:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725555356; x=1726160156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wAtNArR9zOSaOvNZbf13ag6ySe0y5WueK3TgAb9/DZ4=;
 b=YV89FRseITk7VUKmUFwzNHtbsGtxQ2sQqJhEFpj3hCuVrbMO3aVIQYnpltdCG2UuZG
 3fdfI0QE1briH9yN9hTqRyLQw+o5kVPiZ5w4xehI6aeRxizSnoAEvj90lRZYllBEA/e8
 bFfV+c7Gw6KYUnVGB7R/hacs/ghfnsWz6neFPHhu5M14Gl5ZCmvlKNAyF5MuvsY5hj+Y
 MBS/PJY/sDZw/JhEN9Aq5wqxvpnAxywAdrGXC9W6Nu9REwq4ZT/O8C/LdHZ2GBHS95S4
 yHjJaog8+U9kDtPphi72M6oh+ZlAg/BfWcHDhPUGqS4Bx81+R567y6E38ZXwH/6fKP9T
 Tt3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725555356; x=1726160156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wAtNArR9zOSaOvNZbf13ag6ySe0y5WueK3TgAb9/DZ4=;
 b=VSB4ZfskY2ZFAD0i5rQpIOJB44f+T+2eKIcchmnl3SGa+KQPI5uvQ4D6qtL9KmDZsA
 iDA5RSi3nsQ6St7PObXCp417cgVxJf1djE1MUYOBYlh/Z84gg7p8U+kQmUJQMGYifeT+
 Fzo8KNz0euTzwWobC2YBvfFTKYO4O6aakIxNYl79momlFE7p6wNmlve3jUziO91RI3kv
 yOYjnwCBagFBgFobFPLQ4CiY/mJSiFBiUc5IRK3/CJMhryxTc2iDKd+NOT6HKKmNLTis
 L5oY/6LHIA/9YwOJAEzzeLN+xv5rT7kil3/SpWD13P6S6dX3kMS984ohpTVc9POmcYh+
 OcPg==
X-Gm-Message-State: AOJu0YxY4dJo1H9+owLyX9XvMLCFZmFhck+AMCa4/Wqw1DNP4w/luBIZ
 uHPctJfF/QvgVfA/k4ArN9bqYarhJ5BtKMiSoC/ldTJpHxuvac8P0YYmqOZZara9ALGDoSO9F3q
 v
X-Google-Smtp-Source: AGHT+IGAUBiKxfeO8XOfhAHqckj9nH2rCl29pMTApWdg+eVmU09FSAd9IQNfcuiNoxSR4dhxDO4Ysg==
X-Received: by 2002:a05:600c:4ece:b0:426:6b85:bafb with SMTP id
 5b1f17b1804b1-42bb01bfc60mr184341295e9.20.1725555356239; 
 Thu, 05 Sep 2024 09:55:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bbd1eee1bsm206914925e9.9.2024.09.05.09.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 09:55:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/2] tests/qtest: Add missing qtest_quit() to stm32 tests
Date: Thu,  5 Sep 2024 17:55:53 +0100
Message-Id: <20240905165554.320577-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905165554.320577-1-peter.maydell@linaro.org>
References: <20240905165554.320577-1-peter.maydell@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

In the dm163-test and stm32l4x5_usart-test, a couple of subtests are
missing the qtest_quit() call.  The effect of this is that on hosts
other than Linux and FreeBSD the test will timeout after executing
all the tests:

242/845 qemu:qtest+qtest-arm / qtest-arm/dm163-test                               TIMEOUT         60.04s   3 subtests passed
100/845 qemu:qtest+qtest-arm / qtest-arm/stm32l4x5_usart-test                     TIMEOUT        600.02s   5 subtests passed

This happens because the qemu-system-arm binary which the test
starts does not exit, and because it shares the stdout with the
test binary, the overall meson test harness thinks the test is
still running. On Linux and FreeBSD we have an extra safety net
set up in qtest_spawn_qemu() which kills off any QEMU binary that
ends up without a parent. This is intended for the case where
QEMU crashed and didn't respond to a SIGTERM or polite request
to quit, but it also sidestepped the problem in this case.
However, OpenBSD doesn't have a PDEATHSIG equivalent, so we
see the timeouts when running a 'make vm-build-openbsd' run.

Add the missing qtest_quit() calls.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Many thanks to Dan Berrangé for diagnosing the cause of this hang...
Dan also suggested on IRC that we should support g_autoptr for
the QTestState, so you don't need to manually qtest_quit(). But
for the immediate fix, I just add the missing calls.
---
 tests/qtest/dm163-test.c           | 2 ++
 tests/qtest/stm32l4x5_usart-test.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qtest/dm163-test.c b/tests/qtest/dm163-test.c
index 3161c9208d8..4c8e654af29 100644
--- a/tests/qtest/dm163-test.c
+++ b/tests/qtest/dm163-test.c
@@ -182,6 +182,8 @@ static void test_dm163_gpio_connection(void)
     g_assert_false(qtest_get_irq(qts, LAT_B));
     g_assert_false(qtest_get_irq(qts, SELBK));
     g_assert_false(qtest_get_irq(qts, RST_B));
+
+    qtest_quit(qts);
 }
 
 int main(int argc, char **argv)
diff --git a/tests/qtest/stm32l4x5_usart-test.c b/tests/qtest/stm32l4x5_usart-test.c
index 89025182331..c175ff3064f 100644
--- a/tests/qtest/stm32l4x5_usart-test.c
+++ b/tests/qtest/stm32l4x5_usart-test.c
@@ -202,6 +202,8 @@ static void test_write_read(void)
     qtest_writel(qts, USART1_BASE_ADDR + A_TDR, 0xFFFFFFFF);
     const uint32_t tdr = qtest_readl(qts, USART1_BASE_ADDR + A_TDR);
     g_assert_cmpuint(tdr, ==, 0x000001FF);
+
+    qtest_quit(qts);
 }
 
 static void test_receive_char(void)
-- 
2.34.1


