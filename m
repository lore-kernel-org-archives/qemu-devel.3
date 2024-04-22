Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD93DC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:23:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryrlG-0001Yk-Js; Mon, 22 Apr 2024 07:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryrl9-0001Ww-2p
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:22:56 -0400
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryrl5-00075E-0g
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:22:53 -0400
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51ab4ee9df8so3871681e87.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713784968; x=1714389768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcGB7AVbotcMxmI4ZLawBRUBeDiwK/Ghj12lwMkTPi8=;
 b=NVwW5k++2tvXMc4ku6oLxea1FqVPDMzjlSBJKPyTJ5lIh6hya4tzDR8yS9OC6cdyEL
 io+4BjmEkysN02+PYwvbPe92V0VTwiTmeh9Zp6qj0J820UfdBA3d+Kb65uA3QNFLZEpb
 tb1SSinOYOnPYtWnOlHuhBD6P292eexbxio0AqK9mHfBrPs+5fPvxh/k6POqPtHG0LD5
 JSBBuxhq0kjjwwFjc+zTm9UZUTAqbiOZVGK2rXFO2sS93uKflUSgluCL3s3xWdDLf006
 aadWWXHXr5gT0AOk9dVhi6CYM1qlrBzeLiBRtjeP4aZutb/h5dBZVetIrD7uDwcs+yFq
 6JXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713784968; x=1714389768;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcGB7AVbotcMxmI4ZLawBRUBeDiwK/Ghj12lwMkTPi8=;
 b=xNBCD4AQvfX/fumUwfmwQzUsAYo244H+9QaOFgV4mV2lhaTIjHtDuis+Qz+QhJ3opC
 0FxXGndRWikgWZaTpMRM0ZkTH0YwKR1k6EBfqOTBl8lHpzB9VN+AnEUPWWrVtt/L2EKd
 FM8cIrTKYE+y6I09ki7BzFtTmLtn7ynPEqnNmzpYX9Czmvd4UprcpzG2YFiyX3pd7IjS
 sywr2CEHfdRhYtaNRSwiGX+YPI/W74XgKDz0koyaxaeoC0hbYSUHWmOliM3y9KbI2ZOg
 R0RNXlPIlM2E7ehee72QjYXLaIjV+Bhj9b8I0VPxQF8eq5Smb5ED8Kl+y3bhMJ5kY4FY
 w7SQ==
X-Gm-Message-State: AOJu0YxVZwW9K66Nbi+xSInLuD6/f5ryIMRWpGzIDxbTCWjm2umFADcN
 E+u8CASFDONS3HUSfarIqS+wPdxTuPaBVKakdl2wZipGEM3e9vHlMxAhjg6MuYcZ4nFmcbyNedV
 /
X-Google-Smtp-Source: AGHT+IFFI27TJaHZXHu0GwORSa4xa5Jd+mYvKWqp+VGWcjf8pG9NrTAFMxNwiVi+HpxEWekM6+O4XQ==
X-Received: by 2002:a05:6512:908:b0:516:9fe6:bc91 with SMTP id
 e8-20020a056512090800b005169fe6bc91mr5418100lft.25.1713784968077; 
 Mon, 22 Apr 2024 04:22:48 -0700 (PDT)
Received: from m1.home (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 o14-20020a05600c510e00b00419f572671dsm7983172wms.20.2024.04.22.04.22.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 22 Apr 2024 04:22:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2] tests/unit: Remove debug statements in
 test-nested-aio-poll.c
Date: Mon, 22 Apr 2024 13:22:46 +0200
Message-ID: <20240422112246.83812-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We have been running this test for almost a year; it
is safe to remove its debug statements, which clutter
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


