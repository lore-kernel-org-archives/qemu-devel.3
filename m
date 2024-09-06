Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FCCCE7B10
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 13:30:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smZ1h-0003ht-BC; Fri, 06 Sep 2024 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1f-0003et-DV
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:23 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smZ1d-0008NH-Jw
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 09:29:23 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53438aa64a4so2155283e87.3
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 06:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725629359; x=1726234159; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7XRVry1WIYJD1fRST7vCZVz9k3xY9E87VG9DCYoaJ1s=;
 b=dLlkR+F0BAyrjr75eWpp3Qhh6guLGSMWcj3ZMH6xikwANLUtqJbSrOIa36QSleWJ2+
 80Dj9Hb8eSp4d4rImyS5iA5WsrG/7vuZIbEby4AdwDJF9VhPd+nC156nk/iA1OXMz4Ma
 /+GPgEVcIFzBZC9HzX+wAttHIXYJ3sKEgV6KqQ3lDEFVy2bL0r8cbZLyR9xMgtKt5KpP
 A6Omfh2IA6FmP0VxQHn946KEiyOQ6E8lDWlawRH0AkLRBxxJK7Y1kOH0bBM9vngk/ns/
 0ZI2i5Sn6d2SSzsIxL62tbCr2sJUNPq9M/bSMMjF/6ODtNO5rfp63ZFtH7/gq06GcJIg
 TDXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725629359; x=1726234159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7XRVry1WIYJD1fRST7vCZVz9k3xY9E87VG9DCYoaJ1s=;
 b=MBDDmaqDTv3amnjV5zUYu+eVkqLO1cRp1gn/6SKcBZ2Pcy8zhfARofE9Erv0AAqfM9
 s1CJWLKjrjqNoetG0goqbIQ+Kzv+sQgGZvLY77IucrhN+SpbdtP3i4SXHwBwhE6I4JrR
 8o3J+l2FDSAvEgg+X6zIeM4jaOd93FGgoMwzcyb+jMoIW1CXB1JkZ/zWfmocWqXC1d0k
 FSFiTV/DNNcxAlQsufAFYpvVVfSvh9qP9gtZ2m1+MMIea4ZUVmOuePZ4ehrGFfctLcrX
 MXdXezjAcxJ8gtKK3oL9Vyodoxo8lbOdfeOKeIFe0COe9E+QZZh4uvxW1zYYcZeRBG5i
 pvLw==
X-Gm-Message-State: AOJu0YwXivycP0JNVwAgx38+8PCTGA8ucqqltz/yzQZnzBM7nKF145wX
 ff+cdYC2bjCydqInXPSmUycGBwaIikULjiIElugjb3O89V0vG0sOGdu7Lpip77VoKuelidwgV3a
 r
X-Google-Smtp-Source: AGHT+IFrA86kO5+uwDR9uxXOaMfKB6Vtndry3OUwQ37Pz8RBo9BM0l0t7+kNLNxSu3tj8cWedPLung==
X-Received: by 2002:a05:6512:234b:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-536587a6845mr1520480e87.7.1725629358954; 
 Fri, 06 Sep 2024 06:29:18 -0700 (PDT)
Received: from localhost.localdomain ([80.215.236.92])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a62045832sm276070166b.75.2024.09.06.06.29.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 06:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Octavian Purdila <tavip@google.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] tests/unit: Strengthen FIFO8 tests
Date: Fri,  6 Sep 2024 15:29:07 +0200
Message-ID: <20240906132909.78886-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906132909.78886-1-philmd@linaro.org>
References: <20240906132909.78886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

Replace reused bytes { 0x1, 0x2, 0x3, 0x4 } by { 0x9, 0xa, 0xb, 0xc }
to be sure a different value is overwritten.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-fifo.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tests/unit/test-fifo.c b/tests/unit/test-fifo.c
index 1e54cde871..9b3a4940d0 100644
--- a/tests/unit/test-fifo.c
+++ b/tests/unit/test-fifo.c
@@ -22,7 +22,7 @@ static void test_fifo8_pop_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
@@ -65,7 +65,7 @@ static void test_fifo8_peek_bufptr_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa };
     const uint8_t *buf;
     uint32_t count;
 
@@ -112,7 +112,7 @@ static void test_fifo8_pop_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
     uint8_t data_out[4];
     int count;
 
@@ -126,8 +126,8 @@ static void test_fifo8_pop_buf_wrap(void)
     g_assert(count == 4);
     count = fifo8_pop_buf(&fifo, data_out, 4);
     g_assert(count == 4);
-    g_assert(data_out[0] == 0x1 && data_out[1] == 0x2 &&
-             data_out[2] == 0x3 && data_out[3] == 0x4);
+    g_assert(data_out[0] == 0x9 && data_out[1] == 0xa &&
+             data_out[2] == 0xb && data_out[3] == 0xc);
 
     g_assert(fifo8_num_used(&fifo) == 0);
     fifo8_destroy(&fifo);
@@ -157,7 +157,7 @@ static void test_fifo8_peek_buf_wrap(void)
 {
     Fifo8 fifo;
     uint8_t data_in1[] = { 0x1, 0x2, 0x3, 0x4 };
-    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x1, 0x2, 0x3, 0x4 };
+    uint8_t data_in2[] = { 0x5, 0x6, 0x7, 0x8, 0x9, 0xa, 0xb, 0xc };
     uint8_t data_out[4];
     int count;
 
-- 
2.45.2


