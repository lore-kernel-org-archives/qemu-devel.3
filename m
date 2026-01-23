Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F94AD74EC5
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKJ-0007Tr-0M; Fri, 23 Jan 2026 08:35:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKH-0007Sn-At
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:49 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKF-0004cy-RM
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:49 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F5D360135;
 Fri, 23 Jan 2026 13:35:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E890BC4CEF1;
 Fri, 23 Jan 2026 13:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175346;
 bh=rKSrF85OxrtAnXi0vbTWc5mB5I2n992k0TGKaluhwVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UJsrezdYIAJazp4E8Lja1sLcL/A93noEiab3saYC2KNk2/Iy9uYGq6CGVXbYdl8wu
 2JM3jt0sauPaFL6firABjRs8QMsStou1fwZI7HsEj1t4TkL7DvORAB/PgELsK4StPF
 ahysdcMw5nJ1zsQtGg70HHCEtGAfK9eglbTLFQxEksVqNdL9wEOfyjvf1EkxTGLd68
 CGsU2hxemzB3e/fl12kJrLq2TFmFcitpeM0DrxNVMJB5GQCQxtg+3fkYrCNFiXoRrf
 WVbmD7+9U5yvFC9R19gfzb3TXSjhdu6W+CWvJKPxjSXjLnDwkhFlxcgLQLxqeFf4VD
 AdgXdbvWQKuxA==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKC-000000063Jt-2soT; Fri, 23 Jan 2026 14:35:45 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 06/13] scripts/qmp_helper: add support for a timeout logic
Date: Fri, 23 Jan 2026 14:35:20 +0100
Message-ID: <3633cf168519ef0ad02c7e493865b0a20257b695.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
index 1587492807fe..d5ffd51f161e 100755
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


