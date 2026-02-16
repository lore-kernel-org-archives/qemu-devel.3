Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CE70E83838
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:33:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs6Cn-0001SS-Rc; Mon, 16 Feb 2026 16:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6C5-0008CA-Te
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vs6C3-00040I-2t
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:31:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771277506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjdeyrAjANhlscv2cMRZSPPaeWyRzH5DdI+ljAZjH9Q=;
 b=V+yVw+CCFerCv69NAoQwNgnybQMcyJG6va7og9/m48A+xsGNtL5OqM57stvG4YdcCFMcFT
 sH8/4AmX/vBypANR2nUC7PLV2wnC3ThpxNZaLGqcqT5j9F+tCsaqAk46bkAmvqEyklsqV0
 OZ3fKmOnjkgM37syPepEvtaLwL5o/Vc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-vs0GDZk3MQ-9d0MOjeHhfw-1; Mon,
 16 Feb 2026 16:31:43 -0500
X-MC-Unique: vs0GDZk3MQ-9d0MOjeHhfw-1
X-Mimecast-MFC-AGG-ID: vs0GDZk3MQ-9d0MOjeHhfw_1771277500
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A95BD180057E; Mon, 16 Feb 2026 21:31:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.120])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7521B19560A2; Mon, 16 Feb 2026 21:31:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kyle Evans <kevans@freebsd.org>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Yonggang Luo <luoyonggang@gmail.com>, John Snow <jsnow@redhat.com>,
 Warner Losh <imp@bsdimp.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v7 16/19] scripts: nudge users to use 'run' script for scripts
 that import qemu.qmp
Date: Mon, 16 Feb 2026 16:29:48 -0500
Message-ID: <20260216212952.420120-17-jsnow@redhat.com>
In-Reply-To: <20260216212952.420120-1-jsnow@redhat.com>
References: <20260216212952.420120-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that qmp has to be installed and isn't local, we can no longer offer
a simple forwarder for these scripts (nor path hacks) and hope that it
works. Encourage users to use the 'run' script to use these scripts
instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/compare-machine-types.py           |  7 ++-----
 scripts/qmp/qemu-ga-client                 | 13 ++++++-------
 scripts/qmp/qmp-shell                      | 13 ++++++-------
 scripts/qmp/qmp-shell-wrap                 | 13 ++++++-------
 scripts/qmp/qom-fuse                       | 13 ++++++-------
 scripts/qmp/qom-get                        | 13 ++++++-------
 scripts/qmp/qom-list                       | 13 ++++++-------
 scripts/qmp/qom-set                        | 13 ++++++-------
 scripts/qmp/qom-tree                       | 13 ++++++-------
 scripts/qmp_helper.py                      |  9 ++-------
 scripts/render_block_graph.py              | 10 +++++++---
 scripts/simplebench/bench_block_job.py     | 10 +++++++---
 tests/migration-stress/guestperf/engine.py | 15 ++++++++++++---
 13 files changed, 78 insertions(+), 77 deletions(-)

diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index b4f899082a7..83be361f4f6 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -27,19 +27,16 @@
 # along with this program; if not, see <http://www.gnu.org/licenses/>.
 
 import sys
-from os import path
 from argparse import ArgumentParser, RawTextHelpFormatter, Namespace
 import pandas as pd
 from contextlib import ExitStack
 from typing import Optional, List, Dict, Generator, Tuple, Union, Any, Set
 
 try:
-    qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
-    sys.path.append(path.join(qemu_dir, 'python'))
     from qemu.machine import QEMUMachine
 except ModuleNotFoundError as exc:
-    print(f"Module '{exc.name}' not found.")
-    print("Try export PYTHONPATH=top-qemu-dir/python or run from top-qemu-dir")
+    print(f"Module '{exc.name}' not found.", file=sys.stderr)
+    print(f"Try $builddir/run {' '.join(sys.argv)}", file=sys.stderr)
     sys.exit(1)
 
 
diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 56edd0234a6..7ea01b9a11d 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils import qemu_ga_client
-
-
-if __name__ == '__main__':
-    sys.exit(qemu_ga_client.main())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qemu-ga-client [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
index 4a20f97db70..436c4940c26 100755
--- a/scripts/qmp/qmp-shell
+++ b/scripts/qmp/qmp-shell
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import qmp_shell
-
-
-if __name__ == '__main__':
-    qmp_shell.main()
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qmp-shell [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qmp-shell-wrap b/scripts/qmp/qmp-shell-wrap
index 9e94da114f5..f63dadad1ed 100755
--- a/scripts/qmp/qmp-shell-wrap
+++ b/scripts/qmp/qmp-shell-wrap
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import qmp_shell
-
-
-if __name__ == '__main__':
-    qmp_shell.main_wrap()
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qmp-shell-wrap [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qom-fuse b/scripts/qmp/qom-fuse
index d453807b273..7d4724a3710 100755
--- a/scripts/qmp/qom-fuse
+++ b/scripts/qmp/qom-fuse
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils.qom_fuse import QOMFuse
-
-
-if __name__ == '__main__':
-    sys.exit(QOMFuse.entry_point())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qom-fuse [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qom-get b/scripts/qmp/qom-get
index 04ebe052e82..96363539624 100755
--- a/scripts/qmp/qom-get
+++ b/scripts/qmp/qom-get
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils.qom import QOMGet
-
-
-if __name__ == '__main__':
-    sys.exit(QOMGet.entry_point())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qom-get [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qom-list b/scripts/qmp/qom-list
index 853b85a8d3f..e988274d1e7 100755
--- a/scripts/qmp/qom-list
+++ b/scripts/qmp/qom-list
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils.qom import QOMList
-
-
-if __name__ == '__main__':
-    sys.exit(QOMList.entry_point())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qom-list [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qom-set b/scripts/qmp/qom-set
index 06820feec42..c2569afdcd7 100755
--- a/scripts/qmp/qom-set
+++ b/scripts/qmp/qom-set
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils.qom import QOMSet
-
-
-if __name__ == '__main__':
-    sys.exit(QOMSet.entry_point())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qom-set [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp/qom-tree b/scripts/qmp/qom-tree
index 760e172277e..b3cd5ab6f82 100755
--- a/scripts/qmp/qom-tree
+++ b/scripts/qmp/qom-tree
@@ -1,11 +1,10 @@
 #!/usr/bin/env python3
 
-import os
 import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.utils.qom import QOMTree
-
-
-if __name__ == '__main__':
-    sys.exit(QOMTree.entry_point())
+print(
+    "This script has moved; after running configure,"
+    " please use '$builddir/run qom-tree [...]' instead.",
+    file=sys.stderr
+)
+sys.exit(1)
diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index c1e7e0fd80c..521612fb946 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -13,17 +13,12 @@
 import sys
 
 from datetime import datetime
-from os import path as os_path
 
 try:
-    qemu_dir = os_path.abspath(os_path.dirname(os_path.dirname(__file__)))
-    sys.path.append(os_path.join(qemu_dir, 'python'))
-
     from qemu.qmp.legacy import QEMUMonitorProtocol
-
 except ModuleNotFoundError as exc:
-    print(f"Module '{exc.name}' not found.")
-    print("Try export PYTHONPATH=top-qemu-dir/python or run from top-qemu-dir")
+    print(f"Module '{exc.name}' not found.", file=sys.stderr)
+    print(f"Try $builddir/run {' '.join(sys.argv)}", file=sys.stderr)
     sys.exit(1)
 
 from base64 import b64encode
diff --git a/scripts/render_block_graph.py b/scripts/render_block_graph.py
index 3e1a2e3fa71..b9079bbed52 100755
--- a/scripts/render_block_graph.py
+++ b/scripts/render_block_graph.py
@@ -24,9 +24,13 @@
 import json
 from graphviz import Digraph
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', 'python'))
-from qemu.qmp import QMPError
-from qemu.qmp.legacy import QEMUMonitorProtocol
+try:
+    from qemu.qmp import QMPError
+    from qemu.qmp.legacy import QEMUMonitorProtocol
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.", file=sys.stderr)
+    print(f"Try $builddir/run {' '.join(sys.argv)}", file=sys.stderr)
+    sys.exit(1)
 
 
 def perm(arr):
diff --git a/scripts/simplebench/bench_block_job.py b/scripts/simplebench/bench_block_job.py
index e575a3af10e..541a47e586d 100755
--- a/scripts/simplebench/bench_block_job.py
+++ b/scripts/simplebench/bench_block_job.py
@@ -25,9 +25,13 @@
 import socket
 import json
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.machine import QEMUMachine
-from qemu.qmp import ConnectError
+try:
+    from qemu.machine import QEMUMachine
+    from qemu.qmp import ConnectError
+except ModuleNotFoundError as exc:
+    print(f"Module '{exc.name}' not found.", file=sys.stderr)
+    print(f"Try $builddir/run {' '.join(sys.argv)}", file=sys.stderr)
+    sys.exit(1)
 
 
 def bench_block_job(cmd, cmd_args, qemu_args):
diff --git a/tests/migration-stress/guestperf/engine.py b/tests/migration-stress/guestperf/engine.py
index d8462db7653..8d2ed757af3 100644
--- a/tests/migration-stress/guestperf/engine.py
+++ b/tests/migration-stress/guestperf/engine.py
@@ -27,9 +27,18 @@
 from guestperf.report import Report, ReportResult
 from guestperf.timings import TimingRecord, Timings
 
-sys.path.append(os.path.join(os.path.dirname(__file__),
-                             '..', '..', '..', 'python'))
-from qemu.machine import QEMUMachine
+try:
+    from qemu.machine import QEMUMachine
+except ModuleNotFoundError as exc:
+    print(
+        f"Module '{exc.name}' not found.\n"
+        "It should be installed as part of the configure-time "
+        "virtual environment in $builddir/pyvenv.\n"
+        "Try re-running this script as:\n"
+        f"> $builddir/run {' '.join(sys.argv)}",
+        file=sys.stderr
+    )
+    sys.exit(1)
 
 # multifd supported compression algorithms
 MULTIFD_CMP_ALGS = ("zlib", "zstd", "qpl", "uadk")
-- 
2.53.0


