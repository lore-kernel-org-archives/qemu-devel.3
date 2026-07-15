Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBB7DC44507
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 10:35:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjwxE-00040N-Pf; Wed, 15 Jul 2026 06:35:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx8-0003yR-U2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:58 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wjwx6-0000ub-Oh
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 06:34:58 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so2984515f8f.0
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 03:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1784111695; x=1784716495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4cRW8LA+ifE8jwJkw5DO8GQ7H+a9bag/mL6iGsS1QoE=;
 b=pc2EiUBaV4JXLX7Zf06yu1MevofNigD+HtV7rHgjgvs6xENqq/WMNo9Cak73HqTu43
 EupawYUqTZPaGzwblTtSSvTa+wXB7SEdUWRbPum7HqexNXk5NwwJ45g3eiPXlgfGxLYD
 CtJEkfVSXvzuKNNm+7d6KzU9VbaeOne8DKkhQOkpefyr50vfOPyv7NbjbnRleE4PZICN
 a+eybLJCs1crKKmLhe1aqkSt0fX6fDGMn0aOrdelBRunigC5a29AylJ9dXx628uAoL1n
 W0EpC42Y7X9v9/pV+1GFC4/crBOhRIai6NmXqRiYkg5tSUVnOkgTwoMortyz+RPBzkUd
 JUuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784111695; x=1784716495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4cRW8LA+ifE8jwJkw5DO8GQ7H+a9bag/mL6iGsS1QoE=;
 b=mcQ2vofwJ2lvDwBKTFISvvPJaYeOc0IdlE7Z5FQsqmZMXCrYzdt6irFnotME3AQw8J
 a86ppUSXpP/nRRw1OCuYasIuumqqi/A1nRagphNwshq/le8VUy5TZPXD493pbvsLSj/D
 dHtfL7hmAKJeffgSwpkkx1rqf4pGWzGuoJ/JBjJysM1x4LqGz3JKpOKkkircLLl/mCJv
 wMsVRYFbU2AdIy8QW5R+/rZpFhaQi2QekRfvo7oTufGyPc8+P7XuegWqjY6pGwGrADZR
 6nHViAy26a8FKRVLUWN8PiV7fDsviNf8/1GJ77n6xqfXWRIPbVQJC89O2o1C9MJPUOCt
 InlQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBAKTh1n1xntoBlvhYDLQBQePUj+DHtXhjhRHqpmz3BthSriPaJ4YTr/aGkMuBt8c9+6t1RCyo1wPX@nongnu.org
X-Gm-Message-State: AOJu0YyqT6AX6CufiwkjKcILVHQTRnNoaD9Sz8zX2re9BaAdDJBzWpe/
 gGiXFQ/suWmJhGi5z/XPCImdZde5hH9td+Hz24lzfMlygI+nhwS+65i/cC7J7Y3xW+c=
X-Gm-Gg: AfdE7cl5quyj8NIVugvH9nqJNd4CebcR+EQBKuKdjpIgiBGx4YEPH+ZWCT1wn+vx7NI
 sLCpLCpwKW66/xOP/UJF6CNsGt54+uXzinDdTbKkxwv5XYxoOYyLOMqi8JgxNXzZGduMLqX4qOw
 WRVJ1SGuNwdJIIqxPJd1R07uUxGIL4WnLGTC0hIDo4tzMTbH+Dqqss5nhz9bamSCWBHbuJ5J4oN
 b+qNYTU0AyW51BFBIhwpI+KOVguS1hPNqgsPKSbnCe9BCLWajWOLokfbwb3F9lRik0mDmzqyyjR
 6BLYKbuHygWu5bo0W58qsxAXiZQSt/c9y4L/0KPYWwPyInHebnQDlvMqqDf7UoHs0XPCaav6XrA
 iW53y8ptNFDSRtBF7f+iabiJS3nxVWQXrfskGQy24J+0zH6uzUhqAu5FvNWarwyjtvkpp7UyhId
 x2Bg==
X-Received: by 2002:a05:600c:46ce:b0:493:b811:e549 with SMTP id
 5b1f17b1804b1-4951830a532mr84273895e9.29.1784111694831; 
 Wed, 15 Jul 2026 03:34:54 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:c44f:405f:37a5:5992])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a974csm17292644f8f.18.2026.07.15.03.34.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 03:34:54 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v2 1/3] iotests: run the test pool with the 'fork' start method
Date: Wed, 15 Jul 2026 12:34:49 +0200
Message-ID: <20260715103451.1930909-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715103451.1930909-1-den@openvz.org>
References: <20260715103451.1930909-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=den@openvz.org; helo=mail-wr1-x434.google.com
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
 tests/qemu-iotests/testrunner.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index dbe2dddc32..cc36867719 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -26,7 +26,7 @@
 import json
 import shutil
 import sys
-from multiprocessing import Pool
+from multiprocessing import get_context
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


