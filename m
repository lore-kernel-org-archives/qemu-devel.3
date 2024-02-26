Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A04CAC47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 00:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reOV0-00024u-LF; Sun, 25 Feb 2024 19:05:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTO-00070B-7T; Sun, 25 Feb 2024 19:04:02 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1reOTM-0000bs-38; Sun, 25 Feb 2024 19:03:57 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-608d490a64aso12593167b3.3; 
 Sun, 25 Feb 2024 16:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708905830; x=1709510630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX3+LXRmwWELj4t09K3/GBoMxg/7S4oDl8r0RhOcBlA=;
 b=NP+GaNrVvyy9EJ4dw0FE+PQfSE7YmPramcZtK3Fd4m9gnTu896ntroaNym5sCGXq3h
 STetKClgX9cdiIhrTJSsAU/jyaUKJM/QijLOdX9zqPhvrgMa7GrGViCc439Jv/m8Xsli
 BoW+q4Vu20KoBf/Oc2CsQ9o35CGU+BW9a6gyHmQ6+uhEM3qtWTV/6Jc0VdyLEQXxwFTq
 8s3LF/Z/EQ0ELpU4CeVI8lKWtbKUPa5PGFZ46QqxyDX0dLcC04UvGdpgueVMVz+BAGMm
 xbApOyOs9V+FGnCnpjpIcF7qa3yupAtnpLe0ds7a+YA2j8+kiUhm2hCp5TAKl/ODndFC
 oh6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708905830; x=1709510630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX3+LXRmwWELj4t09K3/GBoMxg/7S4oDl8r0RhOcBlA=;
 b=mKW4pCt/25lUfnS/SuR+55lvXFPPz7fuFYV3pDQGcojDlznSz1HMvDOzDUFcaNd7JW
 EB86CrddCPOxyY+bK35KDDZ841eg/OglDjeRpZY7CPlWou2adUWOZ3i7HQ2bpW1p7stL
 fZliyu3v0Tf/zmvVsDt2Uw1/KjTBjRO7PSQR7HthQeHpd13AsUseTIP/vgiTdXeJ/+ku
 3Lip36RjFWdFr9WFoVJw9gS/ZMyvvcCEbaRy7Ko+B5Bl7UCzJm6t3veOnpCypx/2Xy1K
 0epsw2Hm4KZX+xaZHLX5uh1/C0v9zoXwHfwnvgNmIOSzuEKqqrfeEeNB+l4Rbc/FwoKA
 pPQw==
X-Gm-Message-State: AOJu0YwKuPlbTqiiYeaKv81tNmrdoHgw8NOb0m8KsglT6EER5wVe81ev
 HCYVAWaZlZKRmr3wAkovB1fdDcLNk7NSHNZ/7vmBAIqUOeEK/vRBeEg7ha+kiEYTvQ==
X-Google-Smtp-Source: AGHT+IFrC11JopO8uOLziWbIutYNvkFej1k6KlQG+ScZCrpHauCvMaEsRmo+JFWvutoB3clIsxA50g==
X-Received: by 2002:a0d:e20d:0:b0:5ff:f176:9fd3 with SMTP id
 l13-20020a0de20d000000b005fff1769fd3mr4643071ywe.4.1708905830611; 
 Sun, 25 Feb 2024 16:03:50 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a818312000000b00607bfa1913csm938171ywf.114.2024.02.25.16.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 16:03:50 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v6 40/41] Append added properties to mailbox test
Date: Sun, 25 Feb 2024 18:02:58 -0600
Message-Id: <20240226000259.2752893-41-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
References: <20240226000259.2752893-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 tests/qtest/bcm2838-mbox-property-test.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/qtest/bcm2838-mbox-property-test.c b/tests/qtest/bcm2838-mbox-property-test.c
index c96a9ba3f3..ff7c347e7c 100644
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


