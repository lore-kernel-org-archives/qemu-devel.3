Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F93CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 11:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaLS-000790-8K; Mon, 08 Sep 2025 07:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uvaLG-00075n-37
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uvaL1-0006aV-JR
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 07:47:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757332020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KIDNWsM6hHP6HSStH79NPK2ve3ptbYufXYhWzCfNzdA=;
 b=bTqwquklAeoX8J0aMdbfKmXGitILMrfbHV5NSH+VXZiixyaYY1DHQ2Cjffm59lH1ABQ8u/
 bfoltXDzLYrVAhG9PJ74uKowgI4e2cTSy3rL0hFrgq2JWMXbBOJ2hJFGH1hWkP2hJL/wRB
 /2079apX9DDimRd0PuQlc87tyFNMChs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ieGNE09wOrC4ZYNd2ETT2g-1; Mon,
 08 Sep 2025 07:46:59 -0400
X-MC-Unique: ieGNE09wOrC4ZYNd2ETT2g-1
X-Mimecast-MFC-AGG-ID: ieGNE09wOrC4ZYNd2ETT2g_1757332018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD54B1800577; Mon,  8 Sep 2025 11:46:57 +0000 (UTC)
Received: from localhost (unknown [10.45.242.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F0BC1955F24; Mon,  8 Sep 2025 11:46:55 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, stefanha@redhat.com, pbonzini@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] tracetool-test: allow to run in parallel
Date: Mon,  8 Sep 2025 15:46:51 +0400
Message-ID: <20250908114652.1880366-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Create a temporary build subdirectory, to avoid conflicting with other
running tests. This fixes "meson test" with tracetool-test which is
parallel default.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/tracetool/tracetool-test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index d317e04789..786083ad7f 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -6,6 +6,7 @@
 from shutil import copyfile
 from subprocess import check_call
 import sys
+import tempfile
 
 
 def get_formats(backend):
@@ -101,7 +102,8 @@ def test_tracetool(tracetool, backend, source_dir, build_dir):
         print("syntax: {argv0} TRACE-TOOL BACKEND SRC-DIR BUILD-DIR", file=sys.stderr)
         sys.exit(1)
 
-    fail = test_tracetool(sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4])
-    if fail:
-        sys.exit(1)
+    with tempfile.TemporaryDirectory(prefix=sys.argv[4]) as tmpdir:
+        fail = test_tracetool(sys.argv[1], sys.argv[2], sys.argv[3], tmpdir)
+        if fail:
+            sys.exit(1)
     sys.exit(0)
-- 
2.51.0


