Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E261ACA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 18:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEWSe-0007kX-H3; Wed, 07 Oct 2026 14:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWSd-0007hA-4f
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xEWSb-00019l-MB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 14:33:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791398028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=dJl8z0OAO1vDWwngd6Jofhg9Ot++YbpxRVk0J56SA/g=;
 b=d6pYKx6esqqwUDCqLeJmFJ20vd/ORMnyXrvVfv9kz+W6U2s7xEVD9EAYa/WnRR8OlA3KjI
 fJcBUwFErSm35d7WQnHVbpdUhNvk5VxnULcafyQw1V++fJ3ZbhTYCQel4UDWxedPdZQgtN
 SVCVxAdZ/AaiCYCDLi+UsF0EHmHcVBc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-lcuSpnY6Mpu-iqVYzPcxOw-1; Wed,
 07 Oct 2026 14:33:44 -0400
X-MC-Unique: lcuSpnY6Mpu-iqVYzPcxOw-1
X-Mimecast-MFC-AGG-ID: lcuSpnY6Mpu-iqVYzPcxOw_1791398023
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 837201955E90; Wed,  7 Oct 2026 18:33:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.72])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7D00D30001BE; Wed,  7 Oct 2026 18:33:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] iotests: fix false positive on running-outside-venv warning
Date: Wed,  7 Oct 2026 14:33:38 -0400
Message-ID: <20261007183338.1899422-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Currently, iotests checks to see if you are running with the "correct"
python interpreter by checking string equivalence between your current
python and the configure-time venv python.

Depending on exactly *how* you launch or configure your python,
however, this warning may produce false positives because it treats
"python" as different from "python3" as different from
e.g. "python3.12", even though they are all actually the same exact
interpreter.

This patch fixes this by comparing only the parent directories; we
will now be happy with any interpreter so long as it is located within
build/pyvenv/bin/.

Note that we cannot fix this by resolving symlinks, as python venv
binaries are often (but not always) just symlinks to /usr/bin/<etc>,
and full resolution would produce even more false negatives.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/testenv.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 86bcdf7cfad..53c9b5d1968 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -86,7 +86,7 @@ def prepare_subprocess(self, args: List[str]) -> Dict[str, str]:
         with open(args[0], encoding="utf-8") as f:
             try:
                 if f.readline().rstrip() == '#!/usr/bin/env python3':
-                    args.insert(0, self.python)
+                    args.insert(0, str(self.python))
             except UnicodeDecodeError:  # binary test? for future.
                 pass
 
@@ -141,14 +141,14 @@ def init_binaries(self) -> None:
              PYTHON (for bash tests)
              QEMU_PROG, QEMU_IMG_PROG, QEMU_IO_PROG, QEMU_NBD_PROG, QSD_PROG
         """
-        self.python = str(Path(sys.executable).absolute())
+        self.python = Path(sys.executable).absolute()
 
         # QEMU configure-time venv python executable
         venv_python = Path(
             os.path.join(self.build_root, "pyvenv", "bin", "python3")
         ).absolute()
 
-        if self.python != str(venv_python):
+        if str(self.python.parent) != str(venv_python.parent):
             runpath = os.path.join(self.build_root, "run")
             cmd = ' '.join(shlex.quote(x) for x in sys.argv)
             print(
@@ -163,7 +163,7 @@ def init_binaries(self) -> None:
                 f"\t{runpath} {cmd}\n",
                 file=sys.stderr
             )
-            self.python = str(venv_python)
+            self.python = venv_python
 
         def root(*names: str) -> str:
             return os.path.join(self.build_root, *names)
-- 
2.55.0


