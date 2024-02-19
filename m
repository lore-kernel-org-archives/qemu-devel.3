Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3FBC48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:25:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJc-0005en-J8; Sun, 18 Feb 2024 20:19:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIk-0003c0-FG; Sun, 18 Feb 2024 20:18:35 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIe-0004L7-Pz; Sun, 18 Feb 2024 20:18:34 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6084165494eso664997b3.1; 
 Sun, 18 Feb 2024 17:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305507; x=1708910307; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LPieYvae6Kwvk084Ug9jqeJE8wb+azVsaM2Ww4+ELQ=;
 b=SQN4/9FssZF31fx3SgneeaR6ZOcVdsbV2p6mmNqkkrg/ZbIVdldFqVzA8QGqP7iD72
 7ii4OAcDv/Ldm6lgkSE3wL1Bp/Y56d7yPy1OZcA3FQHQzBqDVU+6QybutuB5xuGUCN8E
 RY0oHOEVn2+I3wuJlTN775Ubie8qrC8sAIDmdvCJpxeiGPE4pasldH+iLQikDf+CaZo3
 epUBsPJj+6P06l+s55VYc4s5LqBkqYMCelt8WjzUX76Z5fFhb9+VzznljLMEUeu52JKG
 VbCUSzdYQ8HNELtntdx0fkgvBcVnoXoM1+bCGYq0sy5CF0k6vaumxjLr2EtOzXRp9+Z4
 Zbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305507; x=1708910307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LPieYvae6Kwvk084Ug9jqeJE8wb+azVsaM2Ww4+ELQ=;
 b=F2W+VtwKqie8HcBwVy31USmwJJzqfTlhi4gkFc7g+Bq5Gkc6FISF9jMfENpAzv75fQ
 51h65lGhEqnwNqxpu3BXi8vrs7vz3jk2eOQAb3L6ew4EW2fdTsc9fFQhScQyZDmY/B+z
 PvQZG6LaBBRpOSxssQLzRe6l5dx0gpc4CD+2M0guPtez0R7/uTYeN/HVXjFnMwroFm+o
 LRbICQ7g3ITu7rNf7CftWqC4hys47HLlfMr9ToQZwGvIYU9dD2lRVAPcJVziKv/6x3Ti
 h0Rac5g1W8b0CnQfUa6V3W8vkXUczwKNt39koHT6MvFKbziqxf3LvZ/ZKpEDEaocV3UQ
 BQ2A==
X-Gm-Message-State: AOJu0YwLwDuekriyY4n0xoqWcqxSXzja4yvgBXK6H+juEjcrtI5zYRTk
 roPc77qd63VuB/JDBXnJtPNAtH2G2pHJQSlgHzing8IDf/8GOyuldG8nn+u21ds=
X-Google-Smtp-Source: AGHT+IHxj1HmA96yc7DnT83wJLqJKY0AcTqj3ZCgJb9BApMSt42mrHdnJBcPjuwg2mys/OYyKYxkKQ==
X-Received: by 2002:a81:71d6:0:b0:604:a75:4274 with SMTP id
 m205-20020a8171d6000000b006040a754274mr10609664ywc.51.1708305506886; 
 Sun, 18 Feb 2024 17:18:26 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:26 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 38/41] Add mailbox property tests. Part 3
Date: Sun, 18 Feb 2024 19:17:36 -0600
Message-Id: <20240219011739.2316619-39-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=1.999, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 213 ++++++++++++++++++++++-
 1 file changed, 212 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index b251d3f552..c96a9ba3f3 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -362,7 +362,194 @@ DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_VIRTUAL_WIDTH_HEIGHT) {
     tag->request.value.height = 600;
 }
 
-//==============================================================================
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
+/*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
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


