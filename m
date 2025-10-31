Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8636CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwWC-0002YS-1U; Fri, 31 Oct 2025 17:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwWA-0002Xq-F0
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:18:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwW4-0002Cc-Nz
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:18:42 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso16572125e9.0
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945512; x=1762550312; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zb+lg8rKtYHqXOou6DMojkI7hCEEFWdJALRTKbhb5QU=;
 b=Ux27czvs8RTAWw8tXX62SY2edDnqRM7WfdwB0ersuDEeorxx7wvlnEwF7AsJFZ2dQR
 Fk5O/18DxvfUJdZ2RpYS2mbzP12JKaeRo2xtUoIVvwzKvviRDOzTcir5lOytPWvlDnuS
 DqucseBhItPyUDvXO//UF39m+kpQF39RitIlorgkktvCuTOW5b3SLfZkHOUQMQpYP1ha
 EpyrX0/RGGA/ybyiCBTb+mRFVYry9DGPqONccNHlmeytFm9ZBiyR2buXJpc3W9aUuNBO
 hRKDBvkNH9oPin6Cmzit19apTNlscSsLYQDSJq5AsPKe/3aDzJesW9DqWNLUZOTrk98N
 fKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945512; x=1762550312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zb+lg8rKtYHqXOou6DMojkI7hCEEFWdJALRTKbhb5QU=;
 b=irTv8RxCPIlsuZK9edDj+lU3cF39CrBEWqshYr3cw7TDwspHobabJGTRn8MmzURf4C
 dBV28mnAPXEWHEreA69r5w8Wwvd6GpeABVQP4xE4ZuRHB4Ip033rOAf+rgkfNmJx19mu
 fgDlO5dDW4XadppRpfBPRhiI9Fy65jlQ2I5ERXxY+VQqpPxnF/6VeYY3h7KnBnCXyTV7
 OtVFVlK6zUguS7/SOA7cnZr6eutnFEJvY1OE6uYtWfUVudQ+jJNFTaQEUSmt+v/+WIjb
 vcfm1cUkOyecF2Z3zRcyT9Jfa6nRdlCi2xU4tSkOGXG8kpw0gTwXifCxaDYEwaRijEll
 WNaQ==
X-Gm-Message-State: AOJu0YxDujzUh8dcK93ulS48HfCvUxnkxaLW/jBFRJgMe/b3hJ05ePYN
 OjnZdEEPvBPepAIdgQOn6NsqfgrFM1Kn2Z5olv8rvPMuctipJ8w54nPr8EXK8xdAec11lyU3COP
 Y5IyRG6QDKA==
X-Gm-Gg: ASbGnctbRnlHNaxpuJuk4Nv0RSRYG8MLLfFAh8jDhWzdpiAl9DbfC2B9sGIBBGUDv6c
 9QOy12i92i8aDUdDpUcGB94dukxd9JUiRFCqvd6OSVmpK7jWY/czoTpGMgrGtq2Z30ElGSbXa6n
 VQyPbETkcj6qSkJBbIl+zTs50Xh2LE6q5hkdgEld+pl+99bKiy/y13m3SqRpGJAtQMRsQpHYVqM
 iH6Llw+BTgob2IB9P9QhaLMnZ1all+tF6qnsTcJX2ct0Qugtbej5XcSFvc/5woDqUVnN71WLhTH
 CjkGwr8Ll7si1BreRxwBg2WL453tgqSL5gOs7ZR39ulzcZjfZznPyLdncNJb3Ww2850fJImUpDT
 y3uypuYzNROGuZqTiCBSEX2upEOJJoHElhKdL1qVmHEPjbdrXTN5eMQY8Iz/oELBcxrn4dlY3GK
 DlzyVrKrzrKDfDkAL3BN9OuR8McMJD825j69mwzJ03zUu6uqhWjNKnzCCtMMM=
X-Google-Smtp-Source: AGHT+IFLnhyAA9CkWO0jrp8RSvBDbYJfUG83ahO8p7aSI3guDf1VA/xMFawUJsnM0M3SjIRGjDW4iA==
X-Received: by 2002:a05:600c:3149:b0:477:942:7521 with SMTP id
 5b1f17b1804b1-477307e285dmr49019015e9.14.1761945511933; 
 Fri, 31 Oct 2025 14:18:31 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c383ba6sm14974095e9.10.2025.10.31.14.18.31
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:18:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] timers: properly prefix init_clocks()
Date: Fri, 31 Oct 2025 22:15:15 +0100
Message-ID: <20251031211518.38503-7-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Alex Bennée <alex.bennee@linaro.org>

Otherwise we run the risk of name clashing, for example with
stm32l4x5_usart-test.c should we shuffle the includes.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251030173302.1379174-1-alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/qemu/timer.h              | 5 +++--
 tests/unit/test-aio-multithread.c | 2 +-
 util/main-loop.c                  | 2 +-
 util/qemu-timer.c                 | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 406d7411203..8b561cd6960 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -786,11 +786,12 @@ static inline int64_t qemu_soonest_timeout(int64_t timeout1, int64_t timeout2)
 }
 
 /**
- * initclocks:
+ * qemu_init_clocks:
+ * @notify_cb: optional call-back for timer expiry
  *
  * Initialise the clock & timer infrastructure
  */
-void init_clocks(QEMUTimerListNotifyCB *notify_cb);
+void qemu_init_clocks(QEMUTimerListNotifyCB *notify_cb);
 
 static inline int64_t get_max_clock_jump(void)
 {
diff --git a/tests/unit/test-aio-multithread.c b/tests/unit/test-aio-multithread.c
index 0ead6bf34ad..c24200a7121 100644
--- a/tests/unit/test-aio-multithread.c
+++ b/tests/unit/test-aio-multithread.c
@@ -443,7 +443,7 @@ static void test_multi_mutex_10(void)
 
 int main(int argc, char **argv)
 {
-    init_clocks(NULL);
+    qemu_init_clocks(NULL);
 
     g_test_init(&argc, &argv, NULL);
     g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
diff --git a/util/main-loop.c b/util/main-loop.c
index b8ddda8f5ee..b462598f76e 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -162,7 +162,7 @@ int qemu_init_main_loop(Error **errp)
     int ret;
     GSource *src;
 
-    init_clocks(qemu_timer_notify_cb);
+    qemu_init_clocks(qemu_timer_notify_cb);
 
     ret = qemu_signal_init(errp);
     if (ret) {
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 56f11b6a641..2a6be4c7f95 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -637,7 +637,7 @@ static void qemu_virtual_clock_set_ns(int64_t time)
     return cpus_set_virtual_clock(time);
 }
 
-void init_clocks(QEMUTimerListNotifyCB *notify_cb)
+void qemu_init_clocks(QEMUTimerListNotifyCB *notify_cb)
 {
     QEMUClockType type;
     for (type = 0; type < QEMU_CLOCK_MAX; type++) {
-- 
2.51.0


