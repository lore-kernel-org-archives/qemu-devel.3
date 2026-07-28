Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0F77C54F4D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wollV-0008FL-2a; Tue, 28 Jul 2026 13:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolks-0007j2-3e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkn-0005wM-30
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hn8ZmU8mxfV80D0R63QhkEMJWUTrELUGjVR7JjEoJyk=;
 b=TdWiWJL5wlGa0AwR0WX0M4jGho8I7V7QIoXx6fbB1AfpWeYE2nzxPGmE64RKvkeJhL/WMz
 1pvofbMzOazwRZL0acgLiWHeiNNhhMGb8lFkibmwl5ZZrhSM1e8oGUqMvv0E0TI5b0tD2/
 cGIfQxMLZ/dCBiQmIWPuvh9PeTDShYc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-2BNl9h55OiWLF570oh4-8A-1; Tue,
 28 Jul 2026 13:38:02 -0400
X-MC-Unique: 2BNl9h55OiWLF570oh4-8A-1
X-Mimecast-MFC-AGG-ID: 2BNl9h55OiWLF570oh4-8A_1785260281
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98EF4180034A; Tue, 28 Jul 2026 17:38:01 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 194361956043; Tue, 28 Jul 2026 17:37:59 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 09/17] iotests: run the test pool with the 'fork' start method
Date: Tue, 28 Jul 2026 19:37:31 +0200
Message-ID: <20260728173739.352078-10-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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
---
 tests/qemu-iotests/testrunner.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index dbe2dddc32e..cc36867719d 100644
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
2.55.0


