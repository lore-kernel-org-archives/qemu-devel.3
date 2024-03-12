Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10342C54E58
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 18:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk71E-0003Xa-3z; Tue, 12 Mar 2024 14:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk710-0003N2-4r
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rk70x-0000cR-7b
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 14:38:17 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-413e613316cso2016935e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710268694; x=1710873494; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GSQdrQ1n3f4UDvq+g8f2/lXlL51/iuaHiFWXMRnbpHk=;
 b=yWuGgLDH0SG/GSl56ftf3mrv1jLw4be21RNZYFnEX/v5FaOnAalPe2Wdt5FY7B11KW
 LiDkV6j3pxZ2Te6Je1lH43F8d9jkfDI1Z63D5Z8HWw3UocL0Uk3SQZkd7umOjBl6rLYX
 8XRkmOHvrJA/NYy3hLiw+QxS1NbugtREW4l7+3D5KDh8sFKts6sw17q7ZKWWy4yvlCxP
 IX+ePkzBUNZ3dl5PxLftRU3xRrEDD7FciIUpHBvlwmslJtvXw6z1pye2Uuetsi3HeimY
 91EUKw4UFHPheWTbgZWscHmaOGSQJ4fqg8BFabYIR7ex5LTDE3GUDtvMpmEdXAEqkEdr
 FX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710268694; x=1710873494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GSQdrQ1n3f4UDvq+g8f2/lXlL51/iuaHiFWXMRnbpHk=;
 b=Ug4pAfyFWQ/dvgKkn1GZVnHY4rrw6mA3sL4gUyQMrKGF7VfBgIbXOEpGiSgz9Y55Yb
 XseWqE8VxWv36TIkS8g5VrPzRjbVy0S+RX4P0oSqksE8/eayKbsGTy01cYW0fCyBKbVZ
 Jrqlc8vVh1WpN+wGEfy6oNHSkZ04vURAnk169kgtveFeGBv7uFbBRR44KEGDbwyg0j8h
 za9ul227IyZbpNoIrVqfhJTC1PTdGtNxYrSSY7esbdeYfhBtQvctyrVRTqB9+8fsEm6C
 QUNV3gMLQ5lKaTfUi00pNOdKYzG4+ZIgt8DmIghzihJ7mn01Km03a9RXhse6oGFl4oF1
 mjUA==
X-Gm-Message-State: AOJu0YyH1dLB/n7OJG3LQNsXSThKD/vU5rp5GI22b9zsvugbjA+m7V+0
 IajuR0feHoHCP3kEFHyu8k/jfNq7FFou9U3UjEpevVbuGZjiKXxSoWJ97NjNCUg11dqO1aYQexd
 p
X-Google-Smtp-Source: AGHT+IEx/YWUcmrMNb9rhAM5dFAhJDEne/9R9nXJVNkeukLfQHkOvmqyHlxWIYtBvuJkHMfyyTzPlg==
X-Received: by 2002:a05:600c:458d:b0:413:2779:8e29 with SMTP id
 r13-20020a05600c458d00b0041327798e29mr5515991wmo.19.1710268693958; 
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a05600c471100b00412ee8e2f2asm19836337wmo.9.2024.03.12.11.38.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 11:38:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/7] tests/unit/test-throttle: Avoid unintended integer
 division
Date: Tue, 12 Mar 2024 18:38:09 +0000
Message-Id: <20240312183810.557768-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312183810.557768-1-peter.maydell@linaro.org>
References: <20240312183810.557768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

In test_compute_wait() we do
 double units = bkt.max / 10;
which does an integer division and then assigns it to a double variable,
and similarly later on in the expression for an assertion.

Use 10.0 so that we do a floating point division and calculate the
exact value, rather than doing an integer division.

Spotted by Coverity.

Resolves: Coverity CID 1432564
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/unit/test-throttle.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/unit/test-throttle.c b/tests/unit/test-throttle.c
index 2146cfacd36..24032a02667 100644
--- a/tests/unit/test-throttle.c
+++ b/tests/unit/test-throttle.c
@@ -127,13 +127,13 @@ static void test_compute_wait(void)
     bkt.avg = 10;
     bkt.max = 200;
     for (i = 0; i < 22; i++) {
-        double units = bkt.max / 10;
+        double units = bkt.max / 10.0;
         bkt.level += units;
         bkt.burst_level += units;
         throttle_leak_bucket(&bkt, NANOSECONDS_PER_SECOND / 10);
         wait = throttle_compute_wait(&bkt);
         g_assert(double_cmp(bkt.burst_level, 0));
-        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10));
+        g_assert(double_cmp(bkt.level, (i + 1) * (bkt.max - bkt.avg) / 10.0));
         /* We can do bursts for the 2 seconds we have configured in
          * burst_length. We have 100 extra milliseconds of burst
          * because bkt.level has been leaking during this time.
-- 
2.34.1


