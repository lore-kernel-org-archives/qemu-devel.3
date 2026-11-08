Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EF5606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aW9uXPE9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfp-0003An-CN; Sun, 08 Nov 2026 03:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfh-000393-2A
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:41 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfe-0000wI-QZ
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F2564496E;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5E81F008A6;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=/N4xNXyoUmxr5nKsU/tkQ8X73+Q0bw96PTZ1n78L9QI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aW9uXPE9AtByWbMPfUn7KwBiy5sjivXtIldT9PN5s1X/ktKl3dUOzDIKnIrrlMWrC
 OlX8G4hwWWcckCh81rWVbvc5Wn03a6xxZQlOTS20Y5bAU6IpwWbVJETg/pXe9KwT6L
 2smgB3Eg/43a9JPl7wZOu0dJX0PJiY34KLqFTPyfqDC4DJL34wLs3rGhDcBHskBb0d
 8IErYwNFs7uiLbrgtmC8yh4LoJ1wwmcdMz6G5vMoN90ZC7e24D+lcV1Akz3aaEH71l
 tmllYTdptEOVlFW4rocadIx7I1ivhhJYDN78d+GCeND+lXJG3B+2ZLPZrguC7AHQBC
 vXPHpJkhYnWqQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uix-1Fl1; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH 05/13] scripts/qmp_helper: fix raw_data logic
Date: Sun,  8 Nov 2026 09:54:18 +0100
Message-ID: <770e85f1a7de95a275ea5e0a9f25215036abbac7.1794127710.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794127710.git.mchehab+huawei@kernel.org>
References: <cover.1794127710.git.mchehab+huawei@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

According with UEFI 6.4 spec Table 18.11 Generic Error Status Block:

Raw Data Offset:	Offset in bytes from the beginning of the
			Error Status Block to raw error data.
			The raw data must follow any Generic Error
			Data Entries.

Data Length:		Length in bytes of the generic error data.

So, basically, we have:

        +----------+                 /
        | GEBS     |                 |
        +----------+   /             |
        | GEDE     |   |             |
        | header   |   |             +--> raw data
        +----------+   +--> data     |    offset
        | GEDE     |   |    length   |
        | payload  |   |             |
        +----------+   /             /
        | Raw data |
        +----------+

where:

- raw data offset is relative to the beginning of GEBS;
- data length is only for GEDE header and payload.

The previous code was not calculating it right, as it was
filling it with the size of GEBS and placing raw data before
payload.

This is not a problem with default values, as they set raw data
length to zero, but, at the moment raw data is filled, the
generated CPERs becomes invalid.

Fix the code to calculate the offset according with the specs.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 71 +++++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 22 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 7d9f955bc57f..f44118638c91 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -13,6 +13,8 @@
 import sys
 
 from datetime import datetime
+from os import path as os_path
+from time import sleep
 
 try:
     from qemu.qmp.legacy import QEMUMonitorProtocol
@@ -319,7 +321,8 @@ class qmp:
     Opens a connection and send/receive QMP commands.
     """
 
-    def send_cmd(self, command, args=None, may_open=False, return_error=True):
+    def send_cmd(self, command, args=None, may_open=False, return_error=True,
+                 timeout=None):
         """Send a command to QMP, optinally opening a connection"""
 
         if may_open:
@@ -331,12 +334,31 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True):
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
@@ -406,6 +428,7 @@ def _connect(self):
         "simulated":    util.bit(2),
     }
 
+    GENERIC_ERROR_STATUS_SIZE = 20
     GENERIC_DATA_SIZE = 72
 
     def argparse(parser):
@@ -525,7 +548,7 @@ def __init__(self, host, port, debug=False):
     #
     # Socket QMP send command
     #
-    def send_cper_raw(self, cper_data):
+    def send_cper_raw(self, cper_data, timeout=None):
         """
         Send a raw CPER data to QEMU though QMP TCP socket.
 
@@ -540,13 +563,13 @@ def send_cper_raw(self, cper_data):
 
         self._connect()
 
-        if self.send_cmd("inject-ghes-v2-error", cmd_arg):
+        ret = self.send_cmd("inject-ghes-v2-error", cmd_arg, timeout=timeout)
+        if ret:
             print("Error injected.")
-            return True
 
-        return False
+        return ret
 
-    def get_gede(self, notif_type, cper_length):
+    def get_gede(self, notif_type, payload_length):
         """
         Return a Generic Error Data Entry bytearray
         """
@@ -558,22 +581,27 @@ def get_gede(self, notif_type, cper_length):
         util.data_add(gede, 0x300, 2)
         util.data_add(gede, self.validation_bits, 1)
         util.data_add(gede, self.flags, 1)
-        util.data_add(gede, cper_length, 4)
+        util.data_add(gede, payload_length, 4)
         gede.extend(self.fru_id)
         gede.extend(self.fru_text)
         gede.extend(self.timestamp)
 
         return gede
 
-    def get_gebs(self, data_length):
+    def get_gebs(self, payload_length):
         """
         Return a Generic Error Status Block bytearray
         """
 
+        data_length = payload_length
+        data_length += self.GENERIC_DATA_SIZE
+
         gebs = bytearray()
 
         if self.raw_data:
-            raw_data_offset = len(gebs)
+            raw_data_offset = payload_length
+            raw_data_offset += self.GENERIC_ERROR_STATUS_SIZE
+            raw_data_offset += self.GENERIC_DATA_SIZE
         else:
             raw_data_offset = 0
 
@@ -586,7 +614,7 @@ def get_gebs(self, data_length):
         return gebs
 
     def send_cper(self, notif_type, payload,
-                  gede=None, gebs=None, raw_data=None):
+                  gede=None, gebs=None, raw_data=None, timeout=None):
         """
         Send commands to QEMU though QMP TCP socket.
 
@@ -612,8 +640,7 @@ def send_cper(self, notif_type, payload,
         if raw_data:
             self.raw_data = raw_data
 
-        cper_length = len(payload)
-        data_length = cper_length + len(self.raw_data) + self.GENERIC_DATA_SIZE
+        payload_length = len(payload)
 
         if gede and len(gede) != 72:
             print(f"Invalid Generic Error Data Entry length: {len(gede)}. Ignoring it")
@@ -624,16 +651,16 @@ def send_cper(self, notif_type, payload,
             gebs = None
 
         if not gede:
-            gede = self.get_gede(notif_type, cper_length)
+            gede = self.get_gede(notif_type, payload_length)
 
         if not gebs:
-            gebs = self.get_gebs(data_length)
+            gebs = self.get_gebs(payload_length)
 
         cper_data = bytearray()
         cper_data.extend(gebs)
         cper_data.extend(gede)
-        cper_data.extend(bytearray(self.raw_data))
         cper_data.extend(bytearray(payload))
+        cper_data.extend(bytearray(self.raw_data))
 
         if self.debug:
             print(f"GUID: {notif_type}")
@@ -646,7 +673,7 @@ def send_cper(self, notif_type, payload,
 
             util.dump_bytearray("Payload", payload)
 
-        return self.send_cper_raw(cper_data)
+        return self.send_cper_raw(cper_data, timeout=timeout)
 
     def search_qom(self, path, prop, regex):
         """
-- 
2.56.0


