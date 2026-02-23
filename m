Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C02FEC111D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 18:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuagu-00021m-Rv; Mon, 23 Feb 2026 13:29:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuagt-00021J-LD
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vuags-0001lh-3O
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 13:29:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771871393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BB6k1Yuqh8r2auHo9z9gtPD3srjd7Bdv67UXTNWqvGQ=;
 b=aDknOLnNYvw+37y4uQrTF+4+a1+QYyrtMkcm92PFSYdpIcQXmoc5+eLR4U+Qi/FeFe/BHZ
 wNUYVneen3udnxO9QssJv4RJDkcW8Lo5xkcwe4oIG4DjT3cLmaqKFxSVe1WmsEQ6ii54Z/
 9vZ43rXwEvBAUZakVNR5sormo+OTtko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-443-a6T_Ik11O0qhxlCTVm4ftA-1; Mon,
 23 Feb 2026 13:29:50 -0500
X-MC-Unique: a6T_Ik11O0qhxlCTVm4ftA-1
X-Mimecast-MFC-AGG-ID: a6T_Ik11O0qhxlCTVm4ftA_1771871388
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59B261956072; Mon, 23 Feb 2026 18:29:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.212])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 108C4195419A; Mon, 23 Feb 2026 18:29:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Warner Losh <imp@bsdimp.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Michael Roth <michael.roth@amd.com>, Fabiano Rosas <farosas@suse.de>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 07/19] iotests: tolerate being run outside of pyvenv
Date: Mon, 23 Feb 2026 13:28:49 -0500
Message-ID: <20260223182902.739189-8-jsnow@redhat.com>
In-Reply-To: <20260223182902.739189-1-jsnow@redhat.com>
References: <20260223182902.739189-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Modify the iotests environment preparation so that it can detect when it
is being run outside of the configure-time virtual environment and give
a warning to the user, suggesting the use of the meson run script
instead.

As a bonus, since the test executor itself does not actually rely on
anything in the configure-time venv in and of itself, it is possible to
just modify the python executable it uses for launching tests to be the
correct, configured venv that has access to qemu.qmp and other test
dependencies.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260218213416.674483-9-jsnow@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 29caaa8a349..c357e6ebf50 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -20,6 +20,7 @@
 import sys
 import tempfile
 from pathlib import Path
+import shlex
 import shutil
 import collections
 import contextlib
@@ -140,7 +141,29 @@ def init_binaries(self) -> None:
              PYTHON (for bash tests)
              QEMU_PROG, QEMU_IMG_PROG, QEMU_IO_PROG, QEMU_NBD_PROG, QSD_PROG
         """
-        self.python = sys.executable
+        self.python = str(Path(sys.executable).absolute())
+
+        # QEMU configure-time venv python executable
+        venv_python = Path(
+            os.path.join(self.build_root, "pyvenv", "bin", "python3")
+        ).absolute()
+
+        if self.python != str(venv_python):
+            runpath = os.path.join(self.build_root, "run")
+            cmd = ' '.join(shlex.quote(x) for x in sys.argv)
+            print(
+                "\n\033[93m\033[1mWARNING\033[0m: "
+                "iotests is being run from outside of the configure-time "
+                "python virtual environment\n\n"
+                f"current python: {self.python}\n"
+                f"pyvenv python:  {venv_python}\n\n"
+                "Individual python tests will be executed inside the pyvenv,\n"
+                "but the test runner will continue to run outside.\n\n"
+                "\033[1mPlease use the meson run script:\033[0m\n"
+                f"\t{runpath} {cmd}\n",
+                file=sys.stderr
+            )
+            self.python = str(venv_python)
 
         def root(*names: str) -> str:
             return os.path.join(self.build_root, *names)
-- 
2.53.0


