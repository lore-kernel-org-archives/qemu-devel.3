Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4B3C48BC4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsJN-0004qH-PY; Sun, 18 Feb 2024 20:19:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIh-0003a4-WF; Sun, 18 Feb 2024 20:18:33 -0500
Received: from mail-yw1-x1134.google.com ([2607:f8b0:4864:20::1134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIg-0004M4-H5; Sun, 18 Feb 2024 20:18:31 -0500
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-607d8506099so35491757b3.0; 
 Sun, 18 Feb 2024 17:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305509; x=1708910309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cX3+LXRmwWELj4t09K3/GBoMxg/7S4oDl8r0RhOcBlA=;
 b=ZbZ7nf9B4xwWnwa+E3toSMMToIzNDW7Zjm0QZV7P0LG08rx2K0wnkcSnrTlqHMKAUh
 4L49abep5Ql5ddKMjYO/FGFbSzHktGYaC0a3GGJiq8ma3ly1DTUA4DTng5vd+nTsserT
 O//skogyesMMHprb+8BoUvhVYB9RnU3lMEXSb6VPBEbEGJw2gcDrEI4RsVMSqHarA/J/
 5JoOqb3a9bIrv6eEmzl5p5H9W4vBrXVgaR6pOcjU6ReaucchzPR/T+rJtQonATm1F14Q
 RkSxopMOq7XFr2HH3K+ol2BN6NmwfHMr8rDOLZwsZNGuPfnmffXoQD4RjzAZkmzFc2Nv
 wryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305509; x=1708910309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cX3+LXRmwWELj4t09K3/GBoMxg/7S4oDl8r0RhOcBlA=;
 b=IOqYQ0q+qT5GjDPtA5F0snsjrLnmTDWUNvnb1/IlFily6S64IeIiDwO/8m6r1mcTBb
 m5cgXn6YaGz0tKla1fauuEbvBnTUgzlovzZ0SLczVPuNzXvlJu5h+WGLiof+8iE1Qkah
 ss+k5N8FTVdrJJhQ5z5vMVxtEt0mhs3+o3G83jJHe/+HJp8dIKMm9tiLIuD0rl5t5QoK
 tRiOU1l1v2u0lfa9GlYfI9frrXtlpmw/X2ySUSuCsxLRgx9NmFfSaYkoWRiqj7lr000A
 u5OJ2uzbYttzwCER/CQrn3TUCfwSP5NzyrhKTABEQokEOAhcuD2MePOy4JlZ1s2YAU2i
 dvHQ==
X-Gm-Message-State: AOJu0Yyz+OexnwN7k7PIiTVRUYtntuQqMDweL3UgHSGeXObIPpjq4d4+
 OskCmB1+ivA9CLwmUmd/IzN4Ib7eMZah+R7exPGku+8EPTR375RCnX1lzdkoO84=
X-Google-Smtp-Source: AGHT+IFCNT9ZtKM/3j8KRQNJdTUvmftMY9GEVszrqQcAh8p+40ibDuyOIGAiITd2D7OIcTrjzeHXNA==
X-Received: by 2002:a0d:d817:0:b0:604:ac3b:a38b with SMTP id
 a23-20020a0dd817000000b00604ac3ba38bmr10092291ywe.14.1708305508692; 
 Sun, 18 Feb 2024 17:18:28 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:18:28 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 40/41] Append added properties to mailbox test
Date: Sun, 18 Feb 2024 19:17:38 -0600
Message-Id: <20240219011739.2316619-41-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1134;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x1134.google.com
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


