Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B60EA4FB2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSe-0004So-M7; Mon, 23 Feb 2026 06:50:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSW-0004QD-7E
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:40 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSS-0004qx-Vk
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:39 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E1E5044164;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0181C2BCB2;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=SSFGjo4RyRuGvG2rm8xB9wVYOwkheaOQBxWc2jqVffw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=B0RGMUTvnFKlQ3GRoW2U5SnZuohoaBoEA7hDRkf4aLXcKwFIZ1j9I00WhgEuuo3BZ
 kG9uLLZIsNP2uqrwU2YRClPiWCEDZTtf+W86gpM1Y+24khgptYI51aj7C2k/+qQPq+
 lAU+zf4ZGthG9zkIcV3f3Wv5qSvTNeuCjZTJBhcwa/KIFm9QTlrD8j+0XTogVWj/TR
 RFSCgQUO4ofxnpeug6W0q60+0DmkjHehB6yL22KTX5M2n+QuMZM42Mn+D10C85MqDq
 ZQyw26BV/DUNli9v2groGRy6vlOy/Kb1hDtAGma3kTzuNBNHDd8Ceu/RQd8OUmzUmD
 7cNtuHJhDJ4IQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSN-00000007JoB-40ek; Mon, 23 Feb 2026 12:50:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 05/14] scripts/qmp_helper: fix raw_data logic
Date: Mon, 23 Feb 2026 12:50:21 +0100
Message-ID: <dbfa5c4c60c9f27a3f13ed9de7d510fa99ea536e.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Fix the code to handle it the expected way.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 51c8ad92a39d..40059cd105f6 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -411,6 +411,7 @@ def _connect(self):
         "simulated":    util.bit(2),
     }
 
+    GENERIC_ERROR_STATUS_SIZE = 20
     GENERIC_DATA_SIZE = 72
 
     def argparse(parser):
@@ -551,7 +552,7 @@ def send_cper_raw(self, cper_data):
 
         return False
 
-    def get_gede(self, notif_type, cper_length):
+    def get_gede(self, notif_type, payload_length):
         """
         Return a Generic Error Data Entry bytearray
         """
@@ -563,22 +564,27 @@ def get_gede(self, notif_type, cper_length):
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
 
@@ -617,8 +623,7 @@ def send_cper(self, notif_type, payload,
         if raw_data:
             self.raw_data = raw_data
 
-        cper_length = len(payload)
-        data_length = cper_length + len(self.raw_data) + self.GENERIC_DATA_SIZE
+        payload_length = len(payload)
 
         if gede and len(gede) != 72:
             print(f"Invalid Generic Error Data Entry length: {len(gede)}. Ignoring it")
@@ -629,16 +634,16 @@ def send_cper(self, notif_type, payload,
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
-- 
2.53.0


