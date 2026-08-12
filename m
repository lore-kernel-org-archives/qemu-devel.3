Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE04C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8my-0004pg-F2; Wed, 12 Aug 2026 09:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jp-0002jl-Jx; Wed, 12 Aug 2026 09:11:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8jn-0006Er-RB; Wed, 12 Aug 2026 09:11:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=r7+A58AQn7ruh09AxJNbpuTbEaXrxbN/NDXhwpn61vg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OQjR5Lry0A1Xp2iTJu7BrXlm/imvj+ZO7e6SRU8s/dnNRz85Br7SOzNw6UKLvQhgv
 6L9z+KSWCocC+BmtNAh2FZsp/GehIlh4ABa0WH6ZIUoHlKW3mqjWKZtH5QugUH/aUx
 X8PpU0Zq7+4N5918vgHQORc6eVlmZV6fo3fT+Xw1ngemzN6pIgIfITTL5aOZcxNjCC
 g0ZRioHTVcKpIplb58dZWTCtnR6LUmSce9OSvL9nfti70VEcPDbUBF2Rk4snp6jLiS
 DveAh+V0oSOd4n5pr9CHGervMuuVsdLfg+nvxSPUkhz2sRHItt3IFQrOd8sgPDXcQW
 5fuN2Aqe+CiGA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9D3C51CA4D5;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D21F6409BB8;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id B0E4D2F940; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 086/102] iotests: run the test pool with the 'fork'
 start method
Date: Wed, 12 Aug 2026 16:02:01 +0300
Message-ID: <20260812130233.621965-86-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

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
Message-ID: <20260715103451.1930909-2-den@openvz.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 43e4791d99ab11c4bd12efaec061b3a43c8cde1c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 14cc8492f9f..859443f8cb2 100644
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
2.47.3


