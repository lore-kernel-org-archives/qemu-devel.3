Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37746CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 17:54:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyZq7-0007vc-34; Tue, 16 Sep 2025 13:51:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZq2-0007sI-QL
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uyZq1-0008IT-89
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 13:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758045092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8HPx8AIoqtsK7ATFwUJ2fgwq1B5r57znnKSlwQlNCyg=;
 b=Pb8jlAiqtNJB7RejsAD6QcNS5cj/CFUYiWt8fftThIM/OVeiBadNz8LdtiG9cSUByAP4IO
 kgAppNTKclCGDNQTt8iHqCnF5RI3FuTyb8E5M8dyK+lj2u2ZRmJ5B2I48ve0cg8e1W3tGo
 z4vCsvHoDaO+Hm6jY5rtH2160ZJ8IT0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-6_TGt06SOdGJNct8u16_Nw-1; Tue,
 16 Sep 2025 13:51:29 -0400
X-MC-Unique: 6_TGt06SOdGJNct8u16_Nw-1
X-Mimecast-MFC-AGG-ID: 6_TGt06SOdGJNct8u16_Nw_1758045088
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0813C1800372; Tue, 16 Sep 2025 17:51:28 +0000 (UTC)
Received: from localhost (unknown [10.2.17.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75EF918003FC; Tue, 16 Sep 2025 17:51:27 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 8/8] tracetool-test: allow to run in parallel
Date: Tue, 16 Sep 2025 13:51:08 -0400
Message-ID: <20250916175108.139627-9-stefanha@redhat.com>
In-Reply-To: <20250916175108.139627-1-stefanha@redhat.com>
References: <20250916175108.139627-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Create a temporary build subdirectory, to avoid conflicting with other
running tests. This fixes "meson test" with tracetool-test which is
parallel default.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20250916081638.764020-9-berrange@redhat.com
Message-ID: <20250908114652.1880366-1-marcandre.lureau@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 tests/tracetool/tracetool-test.py | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index a420597fc4..65430fdedc 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -6,6 +6,7 @@
 from shutil import copyfile
 from subprocess import check_call
 import sys
+import tempfile
 
 
 def get_formats(backend):
@@ -99,7 +100,8 @@ def test_tracetool(tracetool, backend, source_dir, build_dir):
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


