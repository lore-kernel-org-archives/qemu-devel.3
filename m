Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9186FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 08:58:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxk4i-0000BG-SZ; Fri, 19 Apr 2024 04:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxk4h-0000As-JW
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:58:27 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxk4f-0000x7-Tc
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 04:58:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4196c62bb41so1601195e9.0
 for <qemu-devel@nongnu.org>; Fri, 19 Apr 2024 01:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713517103; x=1714121903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BKGnDSSkETE4kYg5rHuJqJW6r4gB+zCGK3fj66YrvhQ=;
 b=Zy0bHAt22Nu1nhFzRatLyZ2oYj+YCp5g4KF+C425E+gBoCsSK+Fb/CXd0VhVKu+o8r
 5+q1PWTzT/YwYZaEGkQyBawsv1wha6FrRY05lLLlX3SiRTixULUacQpOYk+z76bnmaRd
 HO76lGn/wBnFj6MuH9PsfQS8ZoTRQn05EniegjssdymCuoG+QCWDV8bBSYbFw4TSiruB
 yoSVxm8Vn0grrIlmQbq3nuO10ae0wcFRwxvMon6nxzmA9adzwX6FhodRNfofxNCdZOO1
 5DR+UzNoxoRDpEwIiaw9WswMBc17wQT9czO2V4lGwX1g96tUuMBpUADAyg+xdHl4tG7I
 Wisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713517103; x=1714121903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BKGnDSSkETE4kYg5rHuJqJW6r4gB+zCGK3fj66YrvhQ=;
 b=QBUXYC07/VfsAwDgkVACdZOSG7M/JaUqBEpaE0c8tc2YnpRMoJUQLHsTfGWpyqj17O
 JZoSkmBxsGfj4oByQTEC/HtEjAlACokO6k3y3lILgnpPd6pIkc6Q900dFsAskfogpAz/
 3r05Xq9zUy8i+e16X/f+/S5RiSqJMCtVXdwHaEIEwDIIDBMaSrCkc/niIFExJzmOHrFb
 roA02h+LM8aNQA01fyr5EnM3GJQ+e1qGscvHteh7F5yWFkRF0sqtxGS3GSjVWW6g4EJ2
 VvasmYN0Et/WqoUuh7GmgTOMVq05AwqzoCuTycOIT7Q4wf+UPA/MGDUBE3genRILxbQ+
 8gJA==
X-Gm-Message-State: AOJu0Yx8pXfZnSV/KC18+UPKcdByTW3T+9g3zjEVyZBartUDsY+XoguS
 B4p+gjOZ7z3T/XrUNMnvfXioXMGTz3p9Tfc+wUN5/ngHSIXzw2vKLoWs3vGZyGEE8nCLjVM1Gg1
 L/W4=
X-Google-Smtp-Source: AGHT+IHE5qTGHzxoM7dYmmCZgebYbEQvbGkNhwpoq5tXeR6JCDeLitZDsRb5RPq+Lx3epFiMpg1GiQ==
X-Received: by 2002:a05:600c:154f:b0:417:fbc2:caf8 with SMTP id
 f15-20020a05600c154f00b00417fbc2caf8mr965221wmg.23.1713517103161; 
 Fri, 19 Apr 2024 01:58:23 -0700 (PDT)
Received: from localhost.localdomain ([176.176.143.233])
 by smtp.gmail.com with ESMTPSA id
 f7-20020a05600c154700b004190d7126c0sm1248827wmg.38.2024.04.19.01.58.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 19 Apr 2024 01:58:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] tests/unit: Remove debug statements in test-nested-aio-poll.c
Date: Fri, 19 Apr 2024 10:58:19 +0200
Message-ID: <20240419085819.47606-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We are running this test since almost a year; it is
safe to remove its debug statements, which clutter
CI jobs output:

  ▶  88/100 /nested-aio-poll                      OK
  io_read 0x16bb26158
  io_poll_true 0x16bb26158
  > io_poll_ready
  io_read 0x16bb26164
  < io_poll_ready
  io_poll_true 0x16bb26158
  io_poll_false 0x16bb26164
  > io_poll_ready
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_poll_false 0x16bb26164
  io_read 0x16bb26164
  < io_poll_ready
  88/100 qemu:unit / test-nested-aio-poll        OK

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tests/unit/test-nested-aio-poll.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tests/unit/test-nested-aio-poll.c b/tests/unit/test-nested-aio-poll.c
index db33742af3..d8fd92c43b 100644
--- a/tests/unit/test-nested-aio-poll.c
+++ b/tests/unit/test-nested-aio-poll.c
@@ -30,19 +30,16 @@ typedef struct {
 
 static void io_read(EventNotifier *notifier)
 {
-    fprintf(stderr, "%s %p\n", __func__, notifier);
     event_notifier_test_and_clear(notifier);
 }
 
 static bool io_poll_true(void *opaque)
 {
-    fprintf(stderr, "%s %p\n", __func__, opaque);
     return true;
 }
 
 static bool io_poll_false(void *opaque)
 {
-    fprintf(stderr, "%s %p\n", __func__, opaque);
     return false;
 }
 
@@ -50,8 +47,6 @@ static void io_poll_ready(EventNotifier *notifier)
 {
     TestData *td = container_of(notifier, TestData, poll_notifier);
 
-    fprintf(stderr, "> %s\n", __func__);
-
     g_assert(!td->nested);
     td->nested = true;
 
@@ -62,8 +57,6 @@ static void io_poll_ready(EventNotifier *notifier)
     g_assert(aio_poll(td->ctx, true));
 
     td->nested = false;
-
-    fprintf(stderr, "< %s\n", __func__);
 }
 
 /* dummy_notifier never triggers */
-- 
2.41.0


