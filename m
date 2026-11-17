Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EAC606A32F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eClNJ7ng
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTMpB-0006cL-Ot; Tue, 17 Nov 2026 12:18:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMp0-0006W1-EQ
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xTMox-0006Yq-2V
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 12:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794935894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=saELs0qUN8zavZ/+gDE1WLNTY2lbQEdwwqFdlFAYCck=;
 b=eClNJ7ngAo+KrpMjyiMxx4H9tUTL23YX5fOyqMuVcRajKqVeAk6ZnGpD8VdUV/a20aaGNp
 Y0GRPRBlEhdfFjYTQxLHMD1cxWyBwt9EQAoQ9gXQ1asRpyeOjbjSAoe5YhLASlIq0Pa9DA
 mY5JscRQaA9V9Au0uJaX+kbjtzmV7b4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-RiMtc5JWNmqypsNMuwPDCg-1; Tue,
 17 Nov 2026 12:18:13 -0500
X-MC-Unique: RiMtc5JWNmqypsNMuwPDCg-1
X-Mimecast-MFC-AGG-ID: RiMtc5JWNmqypsNMuwPDCg_1794935892
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F32D119560BB; Tue, 17 Nov 2026 17:18:11 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A21A6195B3C5; Tue, 17 Nov 2026 17:18:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 4/8] iotests: fix false positive on running-outside-venv warning
Date: Tue, 17 Nov 2026 18:17:54 +0100
Message-ID: <20261117171758.237462-5-kwolf@redhat.com>
In-Reply-To: <20261117171758.237462-1-kwolf@redhat.com>
References: <20261117171758.237462-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: John Snow <jsnow@redhat.com>

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
Message-ID: <20261007183338.1899422-1-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.56.1


