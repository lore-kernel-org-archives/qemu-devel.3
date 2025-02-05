Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B645C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfodO-0004OW-7Z; Wed, 05 Feb 2025 18:16:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfodJ-00047j-JZ
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfodH-0006dM-ST
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:16:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6dUMEjpaEojRHmw1zhCPih5WRmh1AZiaK1PMPnsNsm4=;
 b=ReixSoxyU7+CaRYvQTaJULtxslViP1yhWoIk6IYJOVFTqIGN9Zyl38wdeUi2Ci2XNhX902
 1TGITALUWm9D59ldlm+M8wb749eqxrfvclr12QasjCmy1b0YM66EBYvrs8BNpECbU7vsxp
 th7SBgIbONqk7yKit/t0R3MJgkve0XU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-hMp7g_RWNXKOHiVdTvErkA-1; Wed,
 05 Feb 2025 18:16:31 -0500
X-MC-Unique: hMp7g_RWNXKOHiVdTvErkA-1
X-Mimecast-MFC-AGG-ID: hMp7g_RWNXKOHiVdTvErkA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F0091956088; Wed,  5 Feb 2025 23:16:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 782DE1800570; Wed,  5 Feb 2025 23:16:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 41/42] qapi: resolve filenames in info structures
Date: Wed,  5 Feb 2025 18:12:07 -0500
Message-ID: <20250205231208.1480762-42-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Resolve symbolic filenames (i.e. build/../tests/qapi-schema)
to fully specified absolute paths in QAPI info structures.

Normalizing filenames in this way makes trimming common path prefixes
for test output more consistent. It's also used for the intermediate
output representation for the new transmogrifier.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py         | 3 ++-
 tests/qapi-schema/test-qapi.py | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c92bbc908e7..76fac70c477 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -17,6 +17,7 @@
 from collections import OrderedDict
 import enum
 import os
+from pathlib import Path
 import re
 from typing import (
     TYPE_CHECKING,
@@ -100,7 +101,7 @@ def __init__(self,
         self.src = ''
 
         # Lexer state (see `accept` for details):
-        self.info = QAPISourceInfo(self._fname, incl_info)
+        self.info = QAPISourceInfo(str(Path(self._fname).resolve()), incl_info)
         self.tok: Union[None, str] = None
         self.pos = 0
         self.cursor = 0
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index bca924309be..27324d53850 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -15,6 +15,7 @@
 import argparse
 import difflib
 import os
+from pathlib import Path
 import sys
 from io import StringIO
 
@@ -216,6 +217,7 @@ def main(argv):
         (dir_name, base_name) = os.path.split(t)
         dir_name = dir_name or args.dir
         test_name = os.path.splitext(base_name)[0]
+        dir_name = str(Path(dir_name).resolve())
         status |= test_and_diff(test_name, dir_name, args.update)
 
     sys.exit(status)
-- 
2.48.1


