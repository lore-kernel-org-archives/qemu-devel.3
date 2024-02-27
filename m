Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE70C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexb5-0001BF-A5; Tue, 27 Feb 2024 08:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexal-0000td-1i
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:56 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaV-0002wp-6a
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:53 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33dc3fe739aso1659126f8f.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040818; x=1709645618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=URdpfz0CO1A4wAw58jRhSAJIVlq3ECKNAIVic8uADcU=;
 b=yqGTCIyFFruH+iqUDCfbWYcHMORnHYlCEm9M03A3ibRkopKul51bb9wHOOf+WXtUwY
 Q4fiLcRPw+XJPlHiKhqfqXoAo05D4FeUElMVrMH9ydyiVrxIL9Tw6JZT3UfgNmn2jfgk
 5CSuaTcCs8MIEz8Mu7mdYEFp+o0lOs+4jckwEm7HNjsH8ZgpPm6vKrPNaMIIq9ThDUDg
 2mKdzP8V6GIOMaWZ8WZwR1kjT5yGu2kJv51K5M4Tmol63XXzS4hl6Gds6dR5S8MLDJwC
 9WunZtPpWzstWY8WxZXH6sG5RrarhaJnvJ+ce/8iuz/RwgwnRcSNwtMZuz7wpIH0PViP
 Ns2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040818; x=1709645618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URdpfz0CO1A4wAw58jRhSAJIVlq3ECKNAIVic8uADcU=;
 b=QcWJ3y09t+vFnnoWfFVyb+y10FkhAYpsF0X9i7KdfZtSjAm4tlfJ8kXEmqeP3bEgbd
 JVmyZYb9rOfT3yilbeVS1qLPx7e6twxg5kSxUA3at15mR1AdoAcBaWYerNtB++WtmxC8
 c5Y1DS1P3uH6nxDX5A3YCCc0WX4ycg5tqK6oRqvzVujqyB2najnIyBjZW3FXYUbeV+km
 WyYZY/bVNS/vBHE4xrJcJ0Cjb0Sz0H8zajHMLZvg+C+PevyQqeK5G6HvPdTFyoUDZ/3X
 EmI57tT2EIn11Atk8s1jL2ejr3grvxawspeXoWklyaiFRL7FBWHG5joQHJP6toUOrLZO
 M7iQ==
X-Gm-Message-State: AOJu0YwlH+ZvoU8r3n2EJh3B0aqwlNJ7TmmLLC7DiqHNTkCDUuUm78yz
 MabqcGlloUKgQFVFn7Gm+IsJLdnkAtUnAO10WcZu8GAbKkJmfz7XiRmcbkRhjEDBP49CGl9rNf4
 c
X-Google-Smtp-Source: AGHT+IGjWVu9QQmd2Mrg99drVv7zGvTCjInG76pkr7tR3TdPbDGeklH5xcgYyOmwh0Zl6t4znrw6og==
X-Received: by 2002:a5d:4b8f:0:b0:33d:d7be:5852 with SMTP id
 b15-20020a5d4b8f000000b0033dd7be5852mr5179217wrt.2.1709040817829; 
 Tue, 27 Feb 2024 05:33:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:37 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 42/45] tests/qtest/bcm2828-mailbox: Add mailbox property tests.
 Part 3
Date: Tue, 27 Feb 2024 13:33:11 +0000
Message-Id: <20240227133314.1721857-43-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1.999, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-id: 20240226000259.2752893-39-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mbox-property-test.c | 211 +++++++++++++++++++++++
 1 file changed, 211 insertions(+)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index 63f1f577f17..0a71b756dcf 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -362,6 +362,193 @@ DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT) {
     tag->request.value.height = 600;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_TEST_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_TEST_DEPTH) {
+    tag->request.value.bpp = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 16);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_DEPTH) {
+    g_assert_cmpint(tag->response.value.bpp, ==, 24);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_DEPTH) {
+    tag->request.value.bpp = 24;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_TEST_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_TEST_PIXEL_ORDER) {
+    tag->request.value.pixel_order = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_PIXEL_ORDER) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_RGB);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_PIXEL_ORDER, BGR) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_PIXEL_ORDER, BGR) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_PIXEL_ORDER, RGB) {
+    g_assert_cmphex(tag->response.value.pixel_order, ==, PIXEL_ORDER_BGR);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_PIXEL_ORDER, RGB) {
+    tag->request.value.pixel_order = PIXEL_ORDER_BGR;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_TEST_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_TEST_ALPHA_MODE) {
+    tag->request.value.alpha_mode = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_ALPHA_MODE) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, ENABLED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_ENABLED);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_ALPHA_MODE, ENABLED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_ENABLED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, REVERSED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_REVERSED);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_ALPHA_MODE, REVERSED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_REVERSED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, IGNORED) {
+    g_assert_cmphex(tag->response.value.alpha_mode, ==, ALPHA_MODE_IGNORED);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_ALPHA_MODE, IGNORED) {
+    tag->request.value.alpha_mode = ALPHA_MODE_IGNORED;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_PITCH) {
+    g_assert_cmpint(tag->response.value.pitch, ==, 1280);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_TEST_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, DUMMY_VALUE);
+    g_assert_cmpint(tag->response.value.y, ==, DUMMY_VALUE);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_TEST_VIRTUAL_OFFSET) {
+    tag->request.value.x = DUMMY_VALUE;
+    tag->request.value.y = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_VIRTUAL_OFFSET) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _0_) {
+    g_assert_cmpint(tag->response.value.x, ==, 0);
+    g_assert_cmpint(tag->response.value.y, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _0_) {
+    tag->request.value.x = 0;
+    tag->request.value.y = 0;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _42_) {
+    g_assert_cmpint(tag->response.value.x, ==, 42);
+    g_assert_cmpint(tag->response.value.y, ==, 42);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _42_) {
+    tag->request.value.x = 42;
+    tag->request.value.y = 42;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_TEST_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_TEST_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_OVERSCAN) {
+    g_assert_cmpint(tag->response.value.top, ==, 0);
+    g_assert_cmpint(tag->response.value.bottom, ==, 0);
+    g_assert_cmpint(tag->response.value.left, ==, 0);
+    g_assert_cmpint(tag->response.value.right, ==, 0);
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_OVERSCAN) {
+    tag->request.value.top = DUMMY_VALUE;
+    tag->request.value.bottom = DUMMY_VALUE;
+    tag->request.value.left = DUMMY_VALUE;
+    tag->request.value.right = DUMMY_VALUE;
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_DMA_CHANNELS) {
+    g_assert_cmphex(tag->response.value.mask, ==, GPIO_MASK);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_COMMAND_LINE) {
+    /* No special checks are needed for this test case */
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_GET_NUM_DISPLAYS) {
+    g_assert_cmpint(tag->response.value.num_displays, ==, 1);
+}
+
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(FRAMEBUFFER_SET_PITCH) {
+    /* No special checks are needed for this test case */
+}
+DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_PITCH) {
+    tag->request.value.pitch = DUMMY_VALUE;
+}
+
 /*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
@@ -396,6 +583,30 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_VIRTUAL_WIDTH_HEIGHT);
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_VIRTUAL_WIDTH_HEIGHT, INITIAL);
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_DEPTH);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_DEPTH);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_DEPTH);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_PIXEL_ORDER);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_PIXEL_ORDER, BGR);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_PIXEL_ORDER, RGB);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_ALPHA_MODE);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, ENABLED);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, REVERSED);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_ALPHA_MODE, IGNORED);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_PITCH);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_VIRTUAL_OFFSET);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _0_);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_VIRTUAL_OFFSET, _42_);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_TEST_OVERSCAN);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_OVERSCAN);
+    QTEST_ADD_TEST_CASE(GET_DMA_CHANNELS);
+    QTEST_ADD_TEST_CASE(GET_COMMAND_LINE);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_NUM_DISPLAYS);
+    QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_PITCH);
 
     return g_test_run();
 }
-- 
2.34.1


