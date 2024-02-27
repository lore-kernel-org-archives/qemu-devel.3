Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B13FC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaI-0000jS-HO; Tue, 27 Feb 2024 08:33:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaF-0000hS-9B
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaD-0002qH-IX
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:23 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso33249095e9.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040800; x=1709645600; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oFeKXeW31Su0U94AYEZ3ImMqkHFM46i1mg2K/MGn0p4=;
 b=IKo9Xfbqd6xBBFW2ES10/te3r9MPNLAbDh64E/nD/EynTB9XPfFf4ot4hIFV9AQ7Pi
 z44GH8oIF5A2/A0Thjl2Zh+eULztx5uSocmwO2UqQ/nfw7X9w2RwzuYuLWm0EcjksCf6
 lGxxGf2Raz3EjE4QIkeaOS1x488N8A/zCKRQCQcImnOizMhnhCAI3zHU4jQDN7yYx95u
 W7Fl922jPHtH4nkmsWoOYqkkeWwJUz4aNZ9LRCYb5jV03FwDr2YrEpMmtl4mb65qlKIv
 ota1QrDVzf1brLxDO4hyhNb/3LHAvBqp+1i/y/mzdsEyhmRKKO9cPgGKYFunMWEvt9ZB
 /c8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040800; x=1709645600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oFeKXeW31Su0U94AYEZ3ImMqkHFM46i1mg2K/MGn0p4=;
 b=jAHOJQU/qy0bUAS0g9LFTn8Ac4UrBUCnFF873GLtw7IA6iLwL9lKUrDnoGgKh4TjeA
 9DLUWjhDszca0Bdh7vgA61Iojq7re+AuRfSM8Da+/X97pfzB3ns4DAZ1YPgWVo9rMfYB
 ukup7RPnD9YzVebOWcX6PH4oOC28F6BcErLijikpFr9IpALxHMPtALN9QAKHyPB8EZlM
 CyJ+FMiIkU9v4n72JUtrn3YFPOlKK6jf0SViSSRv9CuYj4HZCzrFZcLon/9LBOSJx2al
 AIx5D7c6pY5y8igE5vTB105/m50cAcQtLSJZKCogZ7ALDXLDXKkJl7EV+LoNzAnT9x4M
 Es1g==
X-Gm-Message-State: AOJu0YxvSr7N93i9ldw3Wvy4x4L5XWc/ALbdoTk/3XFEXI8Q0N/efy6z
 5QwJUkBJrVSk3XzfrdoAHjx3tSZ0otJc82LhJ5PttLVglLbxbIcCjAqGp+Ducd3sCePt9mouPOv
 6
X-Google-Smtp-Source: AGHT+IHwp1FYswkHO/xPjoKizp+HsZ74Qic/xrfzWIcUhovQsO2riALGCDiVZ4AYdnfP8ZR5kjEXOg==
X-Received: by 2002:adf:f3c4:0:b0:33d:5a6f:a856 with SMTP id
 g4-20020adff3c4000000b0033d5a6fa856mr7517558wrp.30.1709040799974; 
 Tue, 27 Feb 2024 05:33:19 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/45] tests/qtest: Check that EXTI fan-in irqs are correctly
 connected
Date: Tue, 27 Feb 2024 13:32:37 +0000
Message-Id: <20240227133314.1721857-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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

From: Inès Varhol <ines.varhol@telecom-paris.fr>

This commit adds a QTest that verifies each input line of a specific
EXTI OR gate can influence the output line.

Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240220184145.106107-3-ines.varhol@telecom-paris.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/stm32l4x5_exti-test.c | 37 +++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tests/qtest/stm32l4x5_exti-test.c b/tests/qtest/stm32l4x5_exti-test.c
index c3900777139..81830be8aea 100644
--- a/tests/qtest/stm32l4x5_exti-test.c
+++ b/tests/qtest/stm32l4x5_exti-test.c
@@ -31,6 +31,7 @@
 
 #define EXTI0_IRQ 6
 #define EXTI1_IRQ 7
+#define EXTI5_9_IRQ 23
 #define EXTI35_IRQ 1
 
 static void enable_nvic_irq(unsigned int n)
@@ -499,6 +500,40 @@ static void test_interrupt(void)
     g_assert_false(check_nvic_pending(EXTI1_IRQ));
 }
 
+static void test_orred_interrupts(void)
+{
+    /*
+     * For lines EXTI5..9 (fanned-in to NVIC irq 23),
+     * test that raising the line pends interrupt
+     * 23 in NVIC.
+     */
+    enable_nvic_irq(EXTI5_9_IRQ);
+    /* Check that there are no interrupts already pending in PR */
+    g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+    /* Check that this specific interrupt isn't pending in NVIC */
+    g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+
+    /* Enable interrupt lines EXTI[5..9] */
+    exti_writel(EXTI_IMR1, (0x1F << 5));
+
+    /* Configure interrupt on rising edge */
+    exti_writel(EXTI_RTSR1, (0x1F << 5));
+
+    /* Raise GPIO line i, check that the interrupt is pending */
+    for (unsigned i = 5; i < 10; i++) {
+        exti_set_irq(i, 1);
+        g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 1 << i);
+        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
+
+        exti_writel(EXTI_PR1, 1 << i);
+        g_assert_cmpuint(exti_readl(EXTI_PR1), ==, 0x00000000);
+        g_assert_true(check_nvic_pending(EXTI5_9_IRQ));
+
+        unpend_nvic_irq(EXTI5_9_IRQ);
+        g_assert_false(check_nvic_pending(EXTI5_9_IRQ));
+    }
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -515,6 +550,8 @@ int main(int argc, char **argv)
     qtest_add_func("stm32l4x5/exti/masked_interrupt", test_masked_interrupt);
     qtest_add_func("stm32l4x5/exti/interrupt", test_interrupt);
     qtest_add_func("stm32l4x5/exti/test_edge_selector", test_edge_selector);
+    qtest_add_func("stm32l4x5/exti/test_orred_interrupts",
+                   test_orred_interrupts);
 
     qtest_start("-machine b-l475e-iot01a");
     ret = g_test_run();
-- 
2.34.1


