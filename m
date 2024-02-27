Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBA2DC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexax-00015D-66; Tue, 27 Feb 2024 08:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexab-0000pn-Gx
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:47 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaW-0002xU-19
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:45 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33de6da5565so805178f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040818; x=1709645618; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8Orf4noRBf1WSFwEsX9mdSuLU4p1Ut9DO1XoPiOsZMY=;
 b=rI92CFmO3lBrpU3uaKGE0jOGvQCvYQeoIuqkN3AGvaX7weaUoAiy9BrRoRI4qReFAq
 3+SjpySL2cfY3gqG54wenF1CCmXxZ5qwstAtT+bUExBmk7b2tDxPRIA1V4OoP7+Wr/3a
 NJGx36nBaeM7TU776+M9woSdvdMD9+Ec6HoJ5WdE8AT6DLbnzEo+ZZARsK8CxkiITrtB
 P/F7hNZzBvZmW0LaVjce3at7WY8c0kKKP3Tr6TrHgREIqRojH6ixAd1+OOrybifjq9mb
 XfxYDRmk7LGka3QfQT9Ps2d5lmsy5dEY2QV19CSeYsT4ImaqOGru78++WScjVE6h4pt8
 /IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040818; x=1709645618;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8Orf4noRBf1WSFwEsX9mdSuLU4p1Ut9DO1XoPiOsZMY=;
 b=ek1Wa2sK16nfw2AL7Drr5g1Lsa6ELANMYQB66Gc1wGxLC4eOoT6D3xkr+M/map5y/R
 YxQNUz/YiQQGW1no7Hn1ltHrKrvHhMu9gdqpo86wfdBuKsibPiTZwm5TYf1DqGXZDiHy
 oErVE+xqvN2cqVjrypVN+R455Tgsz/QwurJDRlpsI3XmsGfHXQUaeM6av4FY+0zDZH/Z
 7o2uGGvVIOCdKo9t+1tNnjNhniXuQMbTl846ChW58Ntuv3tScjD83PcSraEsVD8/5eRY
 gS91OYLeAjVELBeQA5O9zM6Xy3pO3CuvuR8v6ruGyHNLzLldJHe/V1ZcN+Xj6buVzavW
 KjnQ==
X-Gm-Message-State: AOJu0YzS7wICs5BAuHn7VyMMz17803ERB5hEV+BZemBZo6aN+g7IIjfs
 ltpTYfzvp8607XGgKepFkFH0ES+Poz2hOlUR/ijJPnTWKMnu4zoK63vk9Bzgc+OJATF8ktDPAsb
 n
X-Google-Smtp-Source: AGHT+IFlfY+bv44Bq5pucm2sOY1uo0nXTWC5OO6osSo1TAgyB8ojyZW37NPQxH0niBNtBqZjNLU7QA==
X-Received: by 2002:adf:fc01:0:b0:33d:a185:17ed with SMTP id
 i1-20020adffc01000000b0033da18517edmr6166815wrr.56.1709040818730; 
 Tue, 27 Feb 2024 05:33:38 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:38 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/45] tests/qtest/bcm2828-mailbox: Append added properties to
 mailbox test
Date: Tue, 27 Feb 2024 13:33:13 +0000
Message-Id: <20240227133314.1721857-45-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Sergey Kambalin <serg.oker@gmail.com>

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
Message-id: 20240226000259.2752893-41-sergey.kambalin@auriga.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/bcm2838-mbox-property-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index 0a71b756dcf..ca368afed34 100644
--- a/tests/qtest/bcm2838-mbox-property-test.c
+++ b/tests/qtest/bcm2838-mbox-property-test.c
@@ -270,6 +270,12 @@ DECLARE_TEST_CASE_SETUP(GET_MIN_CLOCK_RATE, ANY) {
     tag->request.value.clock_id = CLOCK_ID_UNDEFINED;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_CLOCKS) {
+    g_assert_cmphex(tag->response.value.root_clock, ==, CLOCK_ID_ROOT);
+    g_assert_cmphex(tag->response.value.arm_clock, ==, CLOCK_ID_ARM);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(GET_TEMPERATURE) {
     g_assert_cmphex(tag->response.value.temperature_id, ==, TEMPERATURE_ID_SOC);
@@ -536,6 +542,11 @@ DECLARE_TEST_CASE(GET_COMMAND_LINE) {
     /* No special checks are needed for this test case */
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(GET_THROTTLED) {
+    g_assert_cmpint(tag->response.value.throttled, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 DECLARE_TEST_CASE(FRAMEBUFFER_GET_NUM_DISPLAYS) {
     g_assert_cmpint(tag->response.value.num_displays, ==, 1);
@@ -549,6 +560,11 @@ DECLARE_TEST_CASE_SETUP(FRAMEBUFFER_SET_PITCH) {
     tag->request.value.pitch = DUMMY_VALUE;
 }
 
+/*----------------------------------------------------------------------------*/
+DECLARE_TEST_CASE(VCHIQ_INIT) {
+    g_assert_cmpint(tag->response.value.zero, ==, 0);
+}
+
 /*----------------------------------------------------------------------------*/
 int main(int argc, char **argv)
 {
@@ -572,6 +588,7 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MAX_CLOCK_RATE, ANY);
     QTEST_ADD_TEST_CASE(GET_MIN_CLOCK_RATE, ANY);
+    QTEST_ADD_TEST_CASE(GET_CLOCKS);
     QTEST_ADD_TEST_CASE(GET_TEMPERATURE);
     QTEST_ADD_TEST_CASE(GET_MAX_TEMPERATURE);
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_ALLOCATE);
@@ -607,6 +624,8 @@ int main(int argc, char **argv)
     QTEST_ADD_TEST_CASE(GET_COMMAND_LINE);
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_GET_NUM_DISPLAYS);
     QTEST_ADD_TEST_CASE(FRAMEBUFFER_SET_PITCH);
+    QTEST_ADD_TEST_CASE(GET_THROTTLED);
+    QTEST_ADD_TEST_CASE(VCHIQ_INIT);
 
     return g_test_run();
 }
-- 
2.34.1


