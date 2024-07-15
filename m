Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19481C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 17:34:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTPZl-0004hO-UB; Mon, 15 Jul 2024 13:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTPZk-0004aK-9i
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:33:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sTPZh-0002cq-FE
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 13:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721064800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z5l1q3T81yzOz2V0G9sVAkuZQRl7Lg8KfOv5S6cElYk=;
 b=c3a6Quun9CSgmSieSCUTF6x+VgugQuTX1H+fjoKEVvg0q+AQyUB020pD0HxAopoHthl9kv
 PDAVEuBW4rqDNjd3Bm5cdQDzbI7ayUvJcMqgSoyvJSlY0MfQgoRMDvspqs15hpyhG3vkL5
 2qkXUgicIJxhiPFzKnmqwV9qs983awQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-U_il8DzCNdC-q9KbsIx0KA-1; Mon,
 15 Jul 2024 13:33:15 -0400
X-MC-Unique: U_il8DzCNdC-q9KbsIx0KA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6052D1955D4A; Mon, 15 Jul 2024 17:33:12 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.65.127])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FDF71955D44; Mon, 15 Jul 2024 17:33:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Leonardo Bras <leobras@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Cleber Rosa <crosa@redhat.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 qemu-s390x@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Michael Roth <michael.roth@amd.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Andrew Jeffery <andrew@aj.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL 3/6] iotests: Change imports for Python 3.13
Date: Mon, 15 Jul 2024 13:32:38 -0400
Message-ID: <20240715173241.572048-4-jsnow@redhat.com>
In-Reply-To: <20240715173241.572048-1-jsnow@redhat.com>
References: <20240715173241.572048-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

Python 3.13 isn't out yet, but it's in beta and Fedora is ramping up to
make it the default system interpreter for Fedora 41.

They moved our cheese for where ContextManager lives; add a conditional
to locate it while we support both pre-3.9 and 3.13+.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-id: 20240626232230.408004-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py    | 7 ++++++-
 tests/qemu-iotests/testrunner.py | 9 ++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 588f30a4f14..96d69e56963 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -25,7 +25,12 @@
 import random
 import subprocess
 import glob
-from typing import List, Dict, Any, Optional, ContextManager
+from typing import List, Dict, Any, Optional
+
+if sys.version_info >= (3, 9):
+    from contextlib import AbstractContextManager as ContextManager
+else:
+    from typing import ContextManager
 
 DEF_GDB_OPTIONS = 'localhost:12345'
 
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 7b322272e92..2e236c8fa39 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -27,11 +27,14 @@
 import shutil
 import sys
 from multiprocessing import Pool
-from typing import List, Optional, Any, Sequence, Dict, \
-        ContextManager
-
+from typing import List, Optional, Any, Sequence, Dict
 from testenv import TestEnv
 
+if sys.version_info >= (3, 9):
+    from contextlib import AbstractContextManager as ContextManager
+else:
+    from typing import ContextManager
+
 
 def silent_unlink(path: Path) -> None:
     try:
-- 
2.45.0


