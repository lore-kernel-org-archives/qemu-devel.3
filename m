Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2776DCAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 15:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3yo1-0001YE-Rx; Wed, 01 Oct 2025 11:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ynz-0001XO-Q6
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3ync-0005rs-Qz
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 11:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759332677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fyTJjqpDQ8V/F5wRyKJAI7yvFIVhIBD2uTfdnY8qJqY=;
 b=E0N9Ese5zJv+p34w+WcckUaMJcIqHl+TN5mW2D5GB/QC3o8l7xjQkei5UwnYaBFHL/U0KV
 o8XwwT+bZ5via9jrQgC42IymHqqqEiMXzMCH0eHvTBmsUsaHGn7I77mPdAb7d2G3X/R9J1
 KjUds6hGmpKhkt69EgHjoJlkcjthpOk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-r93Q_J0mOxq0Fq4H-FgT5Q-1; Wed,
 01 Oct 2025 11:31:13 -0400
X-MC-Unique: r93Q_J0mOxq0Fq4H-FgT5Q-1
X-Mimecast-MFC-AGG-ID: r93Q_J0mOxq0Fq4H-FgT5Q_1759332670
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8959F195608E; Wed,  1 Oct 2025 15:31:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 50E5B19560B4; Wed,  1 Oct 2025 15:31:09 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bandan Das <bsd@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <rth@twiddle.net>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Cleber Rosa <crosa@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Michael Roth <michael.roth@amd.com>, Mads Ynddal <mads@ynddal.dk>,
 Alexandre Iooss <erdnaxe@crans.org>, John Snow <jsnow@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 03/16] treewide: remove unnessary "coding" header
Date: Wed,  1 Oct 2025 11:30:46 -0400
Message-ID: <20251001153059.194991-4-stefanha@redhat.com>
In-Reply-To: <20251001153059.194991-1-stefanha@redhat.com>
References: <20251001153059.194991-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

The "-*- coding: utf-8 -*-" header was needed in Python 2,
but in Python 3 UTF-8 is already the default encoding of
source files.

It is even less necessary in .css files that do not have UTF-8
sequences at all.

Suggested-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20250929154938.594389-4-pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/conf.py                                   | 2 --
 docs/sphinx-static/theme_overrides.css         | 3 +--
 scripts/analyse-locks-simpletrace.py           | 1 -
 scripts/modinfo-collect.py                     | 1 -
 scripts/modinfo-generate.py                    | 1 -
 scripts/oss-fuzz/minimize_qtest_trace.py       | 1 -
 scripts/oss-fuzz/output_reproducer.py          | 1 -
 scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py | 1 -
 scripts/probe-gdb-support.py                   | 1 -
 scripts/qapi/error.py                          | 2 --
 scripts/qapi/expr.py                           | 2 --
 scripts/qapi/gen.py                            | 2 --
 scripts/qapi/parser.py                         | 2 --
 scripts/qapi/schema.py                         | 2 --
 scripts/qemu-plugin-symbols.py                 | 1 -
 scripts/qemugdb/tcg.py                         | 2 --
 scripts/qemugdb/timers.py                      | 1 -
 scripts/replay-dump.py                         | 1 -
 scripts/tracetool.py                           | 1 -
 scripts/tracetool/__init__.py                  | 2 --
 scripts/tracetool/backend/__init__.py          | 2 --
 scripts/tracetool/backend/dtrace.py            | 2 --
 scripts/tracetool/backend/ftrace.py            | 2 --
 scripts/tracetool/backend/log.py               | 2 --
 scripts/tracetool/backend/simple.py            | 2 --
 scripts/tracetool/backend/syslog.py            | 2 --
 scripts/tracetool/backend/ust.py               | 2 --
 scripts/tracetool/format/__init__.py           | 2 --
 scripts/tracetool/format/c.py                  | 2 --
 scripts/tracetool/format/d.py                  | 2 --
 scripts/tracetool/format/h.py                  | 2 --
 scripts/tracetool/format/log_stap.py           | 2 --
 scripts/tracetool/format/simpletrace_stap.py   | 2 --
 scripts/tracetool/format/stap.py               | 2 --
 scripts/tracetool/format/ust_events_c.py       | 2 --
 scripts/tracetool/format/ust_events_h.py       | 2 --
 36 files changed, 1 insertion(+), 61 deletions(-)

diff --git a/docs/conf.py b/docs/conf.py
index e09769e5f8..0c9ec74097 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QEMU documentation build configuration file, created by
 # sphinx-quickstart on Thu Jan 31 16:40:14 2019.
 #
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index b225bf706f..f312e9b57e 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -1,5 +1,4 @@
-/* -*- coding: utf-8; mode: css -*-
- *
+/*
  * Sphinx HTML theme customization: read the doc
  * Based on Linux Documentation/sphinx-static/theme_overrides.css
  */
diff --git a/scripts/analyse-locks-simpletrace.py b/scripts/analyse-locks-simpletrace.py
index d650dd7140..bd04cd43c9 100755
--- a/scripts/analyse-locks-simpletrace.py
+++ b/scripts/analyse-locks-simpletrace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Analyse lock events and compute statistics
 #
diff --git a/scripts/modinfo-collect.py b/scripts/modinfo-collect.py
index 48bd92bd61..6ebaea989d 100644
--- a/scripts/modinfo-collect.py
+++ b/scripts/modinfo-collect.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 import os
 import sys
diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index b1538fcced..aaf23544c4 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 import os
 import sys
diff --git a/scripts/oss-fuzz/minimize_qtest_trace.py b/scripts/oss-fuzz/minimize_qtest_trace.py
index d1f3990c16..414a6d91dd 100755
--- a/scripts/oss-fuzz/minimize_qtest_trace.py
+++ b/scripts/oss-fuzz/minimize_qtest_trace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 This takes a crashing qtest trace and tries to remove superfluous operations
diff --git a/scripts/oss-fuzz/output_reproducer.py b/scripts/oss-fuzz/output_reproducer.py
index e8ef76b341..0df96cf958 100755
--- a/scripts/oss-fuzz/output_reproducer.py
+++ b/scripts/oss-fuzz/output_reproducer.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Convert plain qtest traces to C or Bash reproducers
diff --git a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
index b154a25508..8af0d5d9c4 100755
--- a/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
+++ b/scripts/oss-fuzz/reorder_fuzzer_qtest_trace.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Use this to convert qtest log info from a generic fuzzer input into a qtest
diff --git a/scripts/probe-gdb-support.py b/scripts/probe-gdb-support.py
index 6bcadce150..43c7030287 100644
--- a/scripts/probe-gdb-support.py
+++ b/scripts/probe-gdb-support.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# coding: utf-8
 #
 # Probe gdb for supported architectures.
 #
diff --git a/scripts/qapi/error.py b/scripts/qapi/error.py
index e35e4ddb26..f73bc553db 100644
--- a/scripts/qapi/error.py
+++ b/scripts/qapi/error.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # Copyright (c) 2017-2019 Red Hat Inc.
 #
 # Authors:
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cae0a08359..f40b247f8b 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # Copyright IBM, Corp. 2011
 # Copyright (c) 2013-2021 Red Hat Inc.
 #
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index d3c56d45c8..0c9b8db3b0 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI code generation
 #
 # Copyright (c) 2015-2019 Red Hat Inc.
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 2529edf81a..9fbf80a541 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI schema parser
 #
 # Copyright IBM, Corp. 2011
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 3abddea352..8d88b40de2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # QAPI schema internal representation
 #
 # Copyright (c) 2015-2019 Red Hat Inc.
diff --git a/scripts/qemu-plugin-symbols.py b/scripts/qemu-plugin-symbols.py
index e285ebb8f9..69644979c1 100755
--- a/scripts/qemu-plugin-symbols.py
+++ b/scripts/qemu-plugin-symbols.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Extract QEMU Plugin API symbols from a header file
 #
diff --git a/scripts/qemugdb/tcg.py b/scripts/qemugdb/tcg.py
index 16c03c06a9..22529c7277 100644
--- a/scripts/qemugdb/tcg.py
+++ b/scripts/qemugdb/tcg.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-#
 # GDB debugging support, TCG status
 #
 # Copyright 2016 Linaro Ltd
diff --git a/scripts/qemugdb/timers.py b/scripts/qemugdb/timers.py
index 46537b27cf..5714f92cc2 100644
--- a/scripts/qemugdb/timers.py
+++ b/scripts/qemugdb/timers.py
@@ -1,4 +1,3 @@
-# -*- coding: utf-8 -*-
 # GDB debugging support
 #
 # Copyright 2017 Linaro Ltd
diff --git a/scripts/replay-dump.py b/scripts/replay-dump.py
index 4ce7ff51cc..097636570d 100755
--- a/scripts/replay-dump.py
+++ b/scripts/replay-dump.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 #
 # Dump the contents of a recorded execution stream
 #
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 5de9ce96d3..0fdc9cb947 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -1,5 +1,4 @@
 #!/usr/bin/env python3
-# -*- coding: utf-8 -*-
 
 """
 Command-line wrapper for the tracetool machinery.
diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 4ef1dc1fca..9dd8ec27e1 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Machinery for generating tracing-related intermediate files.
 """
diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 6c6344dedd..7040130919 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Backend management.
 
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index e17edc9b9d..4835454193 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 DTrace/SystemTAP backend.
 """
diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
index 5fa30ccc08..e6317ca4bf 100644
--- a/scripts/tracetool/backend/ftrace.py
+++ b/scripts/tracetool/backend/ftrace.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Ftrace built-in backend.
 """
diff --git a/scripts/tracetool/backend/log.py b/scripts/tracetool/backend/log.py
index eb50ceea34..9842522b18 100644
--- a/scripts/tracetool/backend/log.py
+++ b/scripts/tracetool/backend/log.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Stderr built-in backend.
 """
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 7c84c06b20..066e5e9f11 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Simple built-in backend.
 """
diff --git a/scripts/tracetool/backend/syslog.py b/scripts/tracetool/backend/syslog.py
index 3f82e54aab..74af038089 100644
--- a/scripts/tracetool/backend/syslog.py
+++ b/scripts/tracetool/backend/syslog.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Syslog built-in backend.
 """
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index c857516f21..6cc651646d 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 LTTng User Space Tracing backend.
 """
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 042fe7d103..94a37bfce9 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Format management.
 
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index e473fb6c6e..3c4398c237 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.c
 """
diff --git a/scripts/tracetool/format/d.py b/scripts/tracetool/format/d.py
index a5e096e214..684598c183 100644
--- a/scripts/tracetool/format/d.py
+++ b/scripts/tracetool/format/d.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.dtrace (DTrace only).
 """
diff --git a/scripts/tracetool/format/h.py b/scripts/tracetool/format/h.py
index bd9e0ca7f2..2119753be1 100644
--- a/scripts/tracetool/format/h.py
+++ b/scripts/tracetool/format/h.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-tracers.h
 """
diff --git a/scripts/tracetool/format/log_stap.py b/scripts/tracetool/format/log_stap.py
index 5b1bbe907f..02f23bfb8d 100644
--- a/scripts/tracetool/format/log_stap.py
+++ b/scripts/tracetool/format/log_stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file that printfs log messages (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/simpletrace_stap.py b/scripts/tracetool/format/simpletrace_stap.py
index ac39a492d9..3c3584a931 100644
--- a/scripts/tracetool/format/simpletrace_stap.py
+++ b/scripts/tracetool/format/simpletrace_stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file that outputs simpletrace binary traces (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/stap.py b/scripts/tracetool/format/stap.py
index 4d77fbc11a..04c7a35a25 100644
--- a/scripts/tracetool/format/stap.py
+++ b/scripts/tracetool/format/stap.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 Generate .stp file (DTrace with SystemTAP only).
 """
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 569754a304..ea5f0ae99f 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-ust.c
 """
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 2a31fefeca..242c9814fd 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -1,5 +1,3 @@
-# -*- coding: utf-8 -*-
-
 """
 trace/generated-ust-provider.h
 """
-- 
2.51.0


