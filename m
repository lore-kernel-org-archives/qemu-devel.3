Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5E2CA100B
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 05:17:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utfpA-0008N1-CD; Wed, 03 Sep 2025 01:14:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfn2-0006L0-Ey
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utfmz-0006i9-85
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 01:12:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756876327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nO2aYUg1ahQ3Mq+J7zWco6tMP/5HUaKkGg+NPQtmCCc=;
 b=Z2Ev30wy4EaQBBCv4+LgtGpUxMkb5DFvT22RDoRBf3JQ6N0oZc46Y+Q4tRciTZpxiCya8X
 NhQNTm9OWunQn+qc3ZJ2Nd2qPNWQL+T1/tu3sgGMHVI5acnwD4hnY/gbKd1mO2UHkJiSCz
 vzkE92TaezodCj0Stmh8oOXxaabxKZc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-3SoUXclmNNqLCAj2OV1EWw-1; Wed,
 03 Sep 2025 01:12:05 -0400
X-MC-Unique: 3SoUXclmNNqLCAj2OV1EWw-1
X-Mimecast-MFC-AGG-ID: 3SoUXclmNNqLCAj2OV1EWw_1756876325
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0B46180048E; Wed,  3 Sep 2025 05:12:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC67719560A2; Wed,  3 Sep 2025 05:12:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH v2 14/18] iotests: drop compat for old version context manager
Date: Wed,  3 Sep 2025 01:11:20 -0400
Message-ID: <20250903051125.3020805-15-jsnow@redhat.com>
In-Reply-To: <20250903051125.3020805-1-jsnow@redhat.com>
References: <20250903051125.3020805-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

Our minimum python is now 3.9, so back compat with prior
python versions is no longer required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py    | 7 ++-----
 tests/qemu-iotests/testrunner.py | 9 ++-------
 2 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 6326e46b7b1..29caaa8a349 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -22,15 +22,12 @@
 from pathlib import Path
 import shutil
 import collections
+import contextlib
 import random
 import subprocess
 import glob
 from typing import List, Dict, Any, Optional
 
-if sys.version_info >= (3, 9):
-    from contextlib import AbstractContextManager as ContextManager
-else:
-    from typing import ContextManager
 
 DEF_GDB_OPTIONS = 'localhost:12345'
 
@@ -58,7 +55,7 @@ def get_default_machine(qemu_prog: str) -> str:
     return default_machine
 
 
-class TestEnv(ContextManager['TestEnv']):
+class TestEnv(contextlib.AbstractContextManager['TestEnv']):
     """
     Manage system environment for running tests
 
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 2e236c8fa39..14cc8492f9f 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -30,11 +30,6 @@
 from typing import List, Optional, Any, Sequence, Dict
 from testenv import TestEnv
 
-if sys.version_info >= (3, 9):
-    from contextlib import AbstractContextManager as ContextManager
-else:
-    from typing import ContextManager
-
 
 def silent_unlink(path: Path) -> None:
     try:
@@ -57,7 +52,7 @@ def file_diff(file1: str, file2: str) -> List[str]:
         return res
 
 
-class LastElapsedTime(ContextManager['LastElapsedTime']):
+class LastElapsedTime(contextlib.AbstractContextManager['LastElapsedTime']):
     """ Cache for elapsed time for tests, to show it during new test run
 
     It is safe to use get() at any time.  To use update(), you must either
@@ -112,7 +107,7 @@ def __init__(self, status: str, description: str = '',
         self.interrupted = interrupted
 
 
-class TestRunner(ContextManager['TestRunner']):
+class TestRunner(contextlib.AbstractContextManager['TestRunner']):
     shared_self = None
 
     @staticmethod
-- 
2.50.1


