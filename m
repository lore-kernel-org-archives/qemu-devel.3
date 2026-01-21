Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97980C44507
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viWLJ-0002wp-9Y; Wed, 21 Jan 2026 06:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLF-0002rJ-9o
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:42 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWLA-0007n6-N2
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 06:25:40 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 5A38E600AE;
 Wed, 21 Jan 2026 11:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3796C4AF0B;
 Wed, 21 Jan 2026 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768994724;
 bh=IoP6UNuVlYspWDh1PMyMvKQhO54WgyTdoBbrxGt6IDE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=RaE+MEkZVzzaGHogAv/Z04qA1jYZdEBkMgW1VPiRJAWy2puU3Y4YO+xlzaf0rqw85
 0f+1r3qTFJY1Bt6x8ByBKI/RRHgS+oWA5wScP0YulezofELv+dagOS4AcibSIch9nm
 BmeqLVtUAuTZOWb1g7qP3Oj1fwn2BxxVT2Rz49iGyXlOglDPg1HcSRvYp3zh3ceF9s
 vKH2eFg5Ge2IQ69Ciyo6OzJFFBexqWotuU2GauT0b/Cd75pvsKnZiLyosLvhL5wrcn
 hi9B1OO+IbyuYc7blWwgiA1w1LAhmycTJwzBUNmwQ5yYVDBCmIJ8jTWtQtZk1nJpKO
 uEtrU/jFZTcvQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1viWKx-00000003gJe-0aL4; Wed, 21 Jan 2026 12:25:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 06/13] scripts/qmp_helper: add support for a timeout logic
Date: Wed, 21 Jan 2026 12:25:14 +0100
Message-ID: <2539e524dd467af51f8286bd1b201feaad06c81e.1768993993.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768993993.git.mchehab+huawei@kernel.org>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.087,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We can't inject a new GHES record to the same source before
it has been acked. There is an async mechanism to verify when
the Kernel is ready, which is implemented at QEMU's ghes
driver.

If error inject is too fast, QEMU may return an error. When
such errors occur, implement a retry mechanism, based on a
maximum timeout.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 47 +++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 40059cd105f6..63f3df2d75c3 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -14,6 +14,7 @@
 
 from datetime import datetime
 from os import path as os_path
+from time import sleep
 
 try:
     qemu_dir = os_path.abspath(os_path.dirname(os_path.dirname(__file__)))
@@ -324,7 +325,8 @@ class qmp:
     Opens a connection and send/receive QMP commands.
     """
 
-    def send_cmd(self, command, args=None, may_open=False, return_error=True):
+    def send_cmd(self, command, args=None, may_open=False, return_error=True,
+                 timeout=None):
         """Send a command to QMP, optinally opening a connection"""
 
         if may_open:
@@ -336,12 +338,31 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True):
         if args:
             msg['arguments'] = args
 
-        try:
-            obj = self.qmp_monitor.cmd_obj(msg)
-        # Can we use some other exception class here?
-        except Exception as e:                         # pylint: disable=W0718
-            print(f"Command: {command}")
-            print(f"Failed to inject error: {e}.")
+        if timeout and timeout > 0:
+            attempts = int(timeout * 10)
+        else:
+            attempts = 1
+
+        # Try up to attempts
+        for i in range(0, attempts):
+            try:
+                obj = self.qmp_monitor.cmd_obj(msg)
+
+                if obj and "return" in obj and not obj["return"]:
+                    break
+
+            except Exception as e:                     # pylint: disable=W0718
+                print(f"Command: {command}")
+                print(f"Failed to inject error: {e}.")
+                obj = None
+
+            if attempts > 1:
+                print(f"Error inject attempt {i + 1}/{attempts} failed.")
+
+            if i + 1 < attempts:
+                sleep(0.1)
+
+        if not obj:
             return None
 
         if "return" in obj:
@@ -531,7 +552,7 @@ def __init__(self, host, port, debug=False):
     #
     # Socket QMP send command
     #
-    def send_cper_raw(self, cper_data):
+    def send_cper_raw(self, cper_data, timeout=None):
         """
         Send a raw CPER data to QEMU though QMP TCP socket.
 
@@ -546,11 +567,11 @@ def send_cper_raw(self, cper_data):
 
         self._connect()
 
-        if self.send_cmd("inject-ghes-v2-error", cmd_arg):
+        ret = self.send_cmd("inject-ghes-v2-error", cmd_arg, timeout=timeout)
+        if ret:
             print("Error injected.")
-            return True
 
-        return False
+        return ret
 
     def get_gede(self, notif_type, payload_length):
         """
@@ -597,7 +618,7 @@ def get_gebs(self, payload_length):
         return gebs
 
     def send_cper(self, notif_type, payload,
-                  gede=None, gebs=None, raw_data=None):
+                  gede=None, gebs=None, raw_data=None, timeout=None):
         """
         Send commands to QEMU though QMP TCP socket.
 
@@ -656,7 +677,7 @@ def send_cper(self, notif_type, payload,
 
             util.dump_bytearray("Payload", payload)
 
-        return self.send_cper_raw(cper_data)
+        return self.send_cper_raw(cper_data, timeout=timeout)
 
     def search_qom(self, path, prop, regex):
         """
-- 
2.52.0


