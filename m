Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B3BC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDqu-0002T7-P8; Fri, 10 Jul 2026 12:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqo-0002Rq-PA
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wiDqm-0006aX-H9
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:13:18 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so27531875e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1783699994; x=1784304794; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b9+WW0WzzDwWC4+VBlNwLNOZ/ug0yqYomOfZpjSFUvA=;
 b=ZPmFWsj8Gn5dPKlawT2nfuAw8SXvecTUt09grOEW1mB9bKp8fIfvpArIECTtc1tclT
 reo83fSOO5+LulzC3iQq4UeIN1gf5MWS46ZPpC6tg14grVKDfewU/LoBGSXy3CAACA89
 kNecFlOUFj9fIPcoec7iiQNLMSOQKEe4UZiFu7acK8Xzyw/1qusscBH/tIiLBvBadzIP
 OAKOOptQ+i9Und6h2l9sfl/EK97RQ1vtxtBCXkDctUSFHapijqAaQT4sac64HqTvEVw3
 qeTcC8t/fJrAXt8n+kvXl2+NMQoBsWC9gY+fIAxT9ejtj2UDOZb/1BtK/adbe4K+9aeD
 aqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699994; x=1784304794;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=b9+WW0WzzDwWC4+VBlNwLNOZ/ug0yqYomOfZpjSFUvA=;
 b=l9vXrOdcVG0ygcCoQ7GEXRxJkR9Tk+fncxWxeJh8KWywzMIB3ITaLcdOOENAleL0xi
 EJX+uLvMeQs9YhnLwgRvEVeO+OUw/pvFO7nIFvqBEUxSoAWYHl17tJMBOlArojCEQ6Th
 R7eBf4riyehrWv+STk4dqPgv0jZBApEZ+SDro/EInzLMJOsCNrqcT7PC4ndXGAap3yFK
 t8xvcglqKBnleos/CjSHbA3/pO29zcpKqNgSHSspX5QzDOViU1tzsBQtLb1x3Gjafibe
 fbWwkzeFu5JYceDrSXj4sH5I+nUClR5P0xK9vwq3xqZ+i7YBa03ajZXZcx/1e7XhMOfM
 8BYg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro0Q53sc6poEseHxEcoE9ASZ1oR1WzCzuUBBW7upVZcmJxp2vRTSw98ZRiq4JEw05bCAz/8S2WBQIqB@nongnu.org
X-Gm-Message-State: AOJu0Yx4F4+cKQuBcYU6moRAUgrJN2aWJ9ivTIxgV+nN/0Mwub56gbYs
 s6/+6pUJB+UN0M3usAdMbV5yjJ4QF3YpncpZttFYvM3QqBGjztCkLRQNrv1fphqINk8=
X-Gm-Gg: AfdE7ckmZ3xP5b70g+D4GJYwEmoxVoQ8+drXcOC8UjhrmjZzgxd56I/pWQwiFeFAaoB
 vyKmqR5wPO3Hc3uZnV3Uz0li7eqOaWeF9WiwXGJBKbyUiFwsHIpM64jZ+AV3QoEaShDJ4FjcP/6
 RtC+kd8IlZ9H9zd94cDzhCAjAVka+EwExerYjGIdtCN8puyhFwzCVe87u5Qt4SALJOA5yGdKgU2
 gibcyvrH39Lg4RpVNJxuO3xI69s0515KYRVkpv4kfxWXacWGgsBb7vRO1IxsVCWWDBGYrpdy3Q5
 xKUV038Rev6BVOkbjK0U+jsi4hEJmB3EB1Wb0NP0hDHTCRPM/h0OCL3h6SjUGdEMMoXKw6wwRUe
 0gpOvuz03kZRw6IYkjmLGMIz7M2BzafRotJ6qQYONGI1StGGhyxV1e93Zmqm7r9BQg2rGz/FLWe
 Bp/w==
X-Received: by 2002:a05:600d:f:b0:493:f6c1:7aac with SMTP id
 5b1f17b1804b1-493f6c17b53mr21530615e9.12.1783699994454; 
 Fri, 10 Jul 2026 09:13:14 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:5926:51ec:1f64:b9b3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f214d2sm59944836f8f.33.2026.07.10.09.13.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 09:13:14 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 1/3] iotests: run the test pool with the 'fork' start method
Date: Fri, 10 Jul 2026 18:13:07 +0200
Message-ID: <20260710161309.1104712-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710161309.1104712-1-den@openvz.org>
References: <20260710161309.1104712-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=den@openvz.org; helo=mail-wm1-x32e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

run_tests_pool() shares the runner via the class attribute
TestRunner.shared_self, relying on worker processes to inherit it.
That only works with the 'fork' start method. Python 3.14 switched
the Linux default to 'forkserver', so workers see shared_self as
None and parallel runs abort with:

  assert runner is not None
  AssertionError

Only reproduces with Python 3.14+ and 'check -jN' (N > 1); meson
runs one test per process and never calls run_tests_pool(), so CI
is unaffected.

Request get_context('fork') explicitly; it is available on all
supported Python versions and a no-op before 3.14.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
---
 tests/qemu-iotests/testrunner.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index dbe2dddc32..5b2664d9f3 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -26,7 +26,7 @@
 import json
 import shutil
 import sys
-from multiprocessing import Pool
+from multiprocessing import Pool, get_context
 from typing import List, Optional, Any, Sequence, Dict
 from testenv import TestEnv
 
@@ -125,7 +125,7 @@ def run_tests_pool(self, tests: List[str],
         assert TestRunner.shared_self is None
         TestRunner.shared_self = self
 
-        with Pool(jobs) as p:
+        with get_context('fork').Pool(jobs) as p:
             results = p.starmap(self.proc_run_test,
                                 zip(tests, [test_field_width] * len(tests)))
 
-- 
2.53.0


