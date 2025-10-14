Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF68CCCD187
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 08:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aUY-0006ko-1S; Tue, 14 Oct 2025 04:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUR-0006iH-GR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8aUO-000576-B9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 04:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760430875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QakAHz9DxTuZeY/xZmC23qj9vgF2vkaDcsYOiEuMirk=;
 b=XtoJbAuZ/HO5zk5pxJs7QiUGHdncGTzlkIYDlbRBrufd9TTLWryxEAsWBdg0zHrlxaLw/j
 jV8SJIdFRbYDnGjnRpj4mnnYLtryZi403VCQTYYK0ydqrkpzkRV+UJipshOM1ubktxGFpR
 GfdRC5hInMXpyvzsyAGPn54gI/DLoEs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-ggQy302CONCEflkrasax5Q-1; Tue,
 14 Oct 2025 04:34:33 -0400
X-MC-Unique: ggQy302CONCEflkrasax5Q-1
X-Mimecast-MFC-AGG-ID: ggQy302CONCEflkrasax5Q_1760430872
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6123C18004D4; Tue, 14 Oct 2025 08:34:32 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AAFFD19560A2; Tue, 14 Oct 2025 08:34:30 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/2] tests: Evict stale files in the functional download
 cache after a while
Date: Tue, 14 Oct 2025 10:34:24 +0200
Message-ID: <20251014083424.103202-3-thuth@redhat.com>
In-Reply-To: <20251014083424.103202-1-thuth@redhat.com>
References: <20251014083424.103202-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Thomas Huth <thuth@redhat.com>

The download cache of the functional tests is currently only growing.
But sometimes tests get removed or changed to use different assets,
thus we should clean up the stale old assets after a while when they
are not in use anymore. So add a script that looks at the time stamps
of the assets and removes them if they haven't been touched for more
than half of a year. Since there might also be some assets around that
have been added to the cache before we added the time stamp files,
assume a default time stamp that is close to the creation date of this
patch, so that we don't delete these files too early (so we still have
all assets around in case we have to bisect an issue in the recent past
of QEMU).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                       |  1 +
 scripts/clean_functional_cache.py | 45 +++++++++++++++++++++++++++++++
 tests/Makefile.include            |  1 +
 3 files changed, 47 insertions(+)
 create mode 100755 scripts/clean_functional_cache.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 84cfd85e1fa..4c468d45337 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4398,6 +4398,7 @@ M: Thomas Huth <thuth@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 R: Daniel P. Berrange <berrange@redhat.com>
 F: docs/devel/testing/functional.rst
+F: scripts/clean_functional_cache.py
 F: tests/functional/qemu_test/
 
 Windows Hosted Continuous Integration
diff --git a/scripts/clean_functional_cache.py b/scripts/clean_functional_cache.py
new file mode 100755
index 00000000000..c3370ffbb87
--- /dev/null
+++ b/scripts/clean_functional_cache.py
@@ -0,0 +1,45 @@
+#!/usr/bin/env python3
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+"""Delete stale assets from the download cache of the functional tests"""
+
+import os
+import stat
+import sys
+import time
+from pathlib import Path
+
+
+cache_dir_env = os.getenv('QEMU_TEST_CACHE_DIR')
+if cache_dir_env:
+    cache_dir = Path(cache_dir_env, "download")
+else:
+    cache_dir = Path(Path("~").expanduser(), ".cache", "qemu", "download")
+
+if not cache_dir.exists():
+    print(f"Cache dir {cache_dir} does not exist!", file=sys.stderr)
+    sys.exit(1)
+
+os.chdir(cache_dir)
+
+for file in cache_dir.iterdir():
+    # Only consider the files that use a sha256 as filename:
+    if len(file.name) != 64:
+        continue
+
+    try:
+        timestamp = int(file.with_suffix(".stamp").read_text())
+    except FileNotFoundError:
+        # Assume it's an old file that was already in the cache before we
+        # added the code for evicting stale assets. Use the release date
+        # of QEMU v10.1 as a default timestamp.
+        timestamp = time.mktime((2025, 8, 26, 0, 0, 0, 0, 0, 0))
+
+    age = time.time() - timestamp
+
+    # Delete files older than half of a year (183 days * 24h * 60m * 60s)
+    if age > 15811200:
+        print(f"Removing {cache_dir}/{file.name}.")
+        file.chmod(stat.S_IWRITE)
+        file.unlink()
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e47ef4d45c9..d4dfbf3716d 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -111,6 +111,7 @@ $(FUNCTIONAL_TARGETS): check-venv
 .PHONY: check-functional
 check-functional: check-venv
 	@$(NINJA) precache-functional
+	@$(PYTHON) $(SRC_PATH)/scripts/clean_functional_cache.py
 	@QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func check-func-quick
 
 .PHONY: check-func check-func-quick
-- 
2.51.0


