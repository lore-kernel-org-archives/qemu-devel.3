Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE93D31A2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 09:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfx6p-0008Kf-Ni; Wed, 14 Jan 2026 04:24:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfx6l-0008Gb-Vx
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:24:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfx6k-0008Ui-GD
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 04:24:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768382645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=hlg1RHFcYg44mXIsdJENMm2uz7kwheYlHs9QR2DtY80=;
 b=fF3Ck2Yq1C29Dgp14YsMqsnJnotVKxNpIcguWGkQJ5o6QKnZ7xOeXUWWPskjm3EVdKDP1T
 uTK0AP7hyJQbkl00bnfNMbpKRko5Zorcyg5w77v8FECU+5zOm7wzzV5m1OVv7eVYPbS5xU
 g+e4NFiTBG0S5K0idPACFk5pcgTPyf4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-ouUio2loOMKgJpOcXNY3ag-1; Wed,
 14 Jan 2026 04:24:03 -0500
X-MC-Unique: ouUio2loOMKgJpOcXNY3ag-1
X-Mimecast-MFC-AGG-ID: ouUio2loOMKgJpOcXNY3ag_1768382642
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C08E21955DC5; Wed, 14 Jan 2026 09:24:02 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.254])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3CEF91800240; Wed, 14 Jan 2026 09:24:00 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH] tests/tracetool: Honor the Python interpreter that
 "configure" detected
Date: Wed, 14 Jan 2026 10:23:58 +0100
Message-ID: <20260114092358.22961-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

The tracetool tests currently fail if the host installation does not
have a "python3" binary (and you compiled QEMU by selecting a different
one during the "configure" step). This happens because tracetool-test.py
executes scripts/tracetool.py directly, so that this script is run via
its shebang line.
To fix the issue, pass the right Python interpreter to tracetool-test.py
via the PYTHON environment variable and use that to run the tracetool.py
script.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/tracetool/meson.build       | 3 +++
 tests/tracetool/tracetool-test.py | 4 +++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/tracetool/meson.build b/tests/tracetool/meson.build
index 09bbaaa86bf..7ff8ada7b23 100644
--- a/tests/tracetool/meson.build
+++ b/tests/tracetool/meson.build
@@ -15,6 +15,8 @@ backends = [
 
 # The tracetool-test.py program has portability problems on Windows.
 if host_machine.system() != 'windows'
+    test_env = environment()
+    test_env.set('PYTHON', python.full_path())
     foreach backend: backends
         test(backend,
              python,
@@ -23,6 +25,7 @@ if host_machine.system() != 'windows'
                     backend,
                     meson.current_source_dir(),
                     meson.current_build_dir()],
+             env: test_env,
              suite: ['tracetool'])
     endforeach
 endif
diff --git a/tests/tracetool/tracetool-test.py b/tests/tracetool/tracetool-test.py
index 30006a99190..9e62a81d4c3 100755
--- a/tests/tracetool/tracetool-test.py
+++ b/tests/tracetool/tracetool-test.py
@@ -36,7 +36,9 @@ def test_tracetool_one(tracetool, backend, fmt, src_dir, build_dir):
     actual_file = Path(build_dir, rel_filename)
     expect_file = Path(src_dir, rel_filename)
 
-    args = [tracetool, f"--format={fmt}", f"--backends={backend}", "--group=testsuite"]
+    python = os.environ.get("PYTHON", "python3")
+    args = [python, tracetool, f"--format={fmt}", f"--backends={backend}",
+            "--group=testsuite"]
 
     if fmt.find("stap") != -1:
         args += ["--binary=qemu", "--probe-prefix=qemu"]
-- 
2.52.0


