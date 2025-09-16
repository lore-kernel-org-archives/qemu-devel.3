Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A60ECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYUZ-0004AX-J9; Tue, 16 Sep 2025 12:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUV-00048X-59
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUN-0003Ak-I3
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=en7ija7XjpqgIA078WVJd5A3fwg9vIVVPkmPodfipFw=;
 b=NpmN+zWh+UDiDqAX83w2tWvfPoLxZ/nrUuW/fzU1E5EDWW2pS8juz0ej7lhPKtq91/FMpt
 CuuHNHSj7IxW1MFUQgRHh5Y66sdEqALs4Tc1+2Nt/n4CSPS/TEfrz/BGDg6nNDhEZCMFzd
 zsP4TbAgS/I7w26WdOx36GPqbJ1nZQI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-IjUvQAu2Pz-E-hKT6EcakQ-1; Tue,
 16 Sep 2025 12:25:03 -0400
X-MC-Unique: IjUvQAu2Pz-E-hKT6EcakQ-1
X-Mimecast-MFC-AGG-ID: IjUvQAu2Pz-E-hKT6EcakQ_1758039902
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C14419560B6; Tue, 16 Sep 2025 16:25:02 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 529B919560B8; Tue, 16 Sep 2025 16:24:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/19] iotests: drop compat for old version context manager
Date: Tue, 16 Sep 2025 12:24:00 -0400
Message-ID: <20250916162404.9195-16-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
2.51.0


