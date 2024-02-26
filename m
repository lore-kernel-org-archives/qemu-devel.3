Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FFEC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:07:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOVI-0002Yv-5v; Sun, 25 Feb 2024 19:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTM-0006zr-58; Sun, 25 Feb 2024 19:04:00 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTG-0000b6-C7; Sun, 25 Feb 2024 19:03:54 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-607cd210962so21948227b3.2; 
 Sun, 25 Feb 2024 16:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905828; x=1709510628; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6LPieYvae6Kwvk084Ug9jqeJE8wb+azVsaM2Ww4+ELQ=;
 b=IbmFFmqY2AjXLhcoP5LMegWsYuVZc1yYu3fNdu2Va2iz7XEkIywAuwNMppXUEXU7eq
 KAecNrs9j4+6OjZdMLzAlz9xOXVD2cfemnLH30tXpsHyTgRwC2HIdgAHLIK/mgUImRZu
 L/ysm4CmG29Flw1sbfe4x4STJWgI0eH70sBZqKqagVW0N1vRldtRvYOov2VZojcI8E6F
 nr23hYuKr4lsf7oe+00zCGDidHjYjnlzR8vCpLToxL9TpwoKZxgUV44VoBtNjq2r1tbe
 GWw4jK5ToFwhKCtsM8QXA8VpF9gpajxM5zdsQkoKSUi07Wqv+ztgUmqiVGOZEeLryPY5
 hsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905828; x=1709510628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LPieYvae6Kwvk084Ug9jqeJE8wb+azVsaM2Ww4+ELQ=;
 b=drTj0PJlDE29NtJ1kwvywuFHiaNv/kJl+OGqYagI+t+PKsJalyQUwNzLTmWOqjLP7a
 OB2tmmDHDEVsSFaCBr327gW/m2lbKZnEQfU/hruDKgiHFtN/O4joONmLpMhMlyYP3SmE
 jHg1m2sKqrnllZwYK/OJjnxWAghst/lDSvyVAkzJzgfNVEf9DC9nNeAUtO+cB/4F41tD
 5tVEjkRr0G1B/tCUP9SCtj7mLZRQ06qm0kJzVXgLzqwscmDXdVUiwhsFeD7MPQ070oXJ
 EdJuKjGitQDqFibX3fIEr0Nj8VpMzeweQxOGRB+Y+Pnlx5kX63dwry6bA0Wu/+AhGglK
 mF7A==
X-Gm-Message-State: AOJu0YwBNZ9RMBAYObRccgcfUVKtCxuerBDFo5lg5vGq6u5ssrS2EZxs
 gB24bNrA0HuD4QRe/C5/Iw6RGtEUiTglCDELWG2Hurwsn8iq8jQiArZZHDygoqOG9Q==
X-Google-Smtp-Source: AGHT+IGTEVnhbL9skjw29jYnE2C8INElasWHNR4Y8FuGrf4VRzyvpf40FCZO1eOS2nsLG29OUP2n2g==
X-Received: by 2002:a0d:d905:0:b0:608:b764:9a25 with SMTP id
 b5-20020a0dd905000000b00608b7649a25mr5050903ywe.16.1708905828285; 
 Sun, 25 Feb 2024 16:03:48 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:47 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 38/41] Add mailbox property tests. Part 3
Date: Sun, 25 Feb 2024 18:02:56 -0600
Message-Id: <20240226000259.2752893-39-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 PDS_OTHER_BAD_TLD=2, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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


