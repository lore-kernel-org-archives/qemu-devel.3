Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AEAAD74ECF
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKD-0007RC-IK; Fri, 23 Jan 2026 08:35:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKB-0007QS-RG
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:43 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHKA-0004cA-79
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:43 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 19AA460010;
 Fri, 23 Jan 2026 13:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5775C4CEF1;
 Fri, 23 Jan 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175340;
 bh=cAn/uow26i6rYfHjiGm3Vhb9DNFN5wMSz3b13l7uzdQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=kvElkiPUnr6+LR3Fb/ljJOGNP6LYTeB6gDV61M4Jw1mb+SBrXPuGJWjSfVsWxvU/0
 tymWzVLjfeb5mvf1KG08VOONtugMqNKb6m8nqaVakmQZM9o5NRJe34V/AAiI63OH/X
 rhQW4ihS+XiMnG7/jtjxD9r4rApfzPI05wO4mL6l56DymMG1rCAJ/kSrUxnqk6HsE4
 0jU8xrWm34VZXNb83yAIKnb5aTlAWaqPWlJq1yNWISCvRO8rN5w+BFIGgL4FOEtdsr
 6mZIQ1+yieqThbz//o/c/zlwZFuFyASOQPl8RHh5OcdYZGsxTM2pVx6AwUAJP82aFX
 3iacmu5K2J/Ag==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK6-000000063Jj-21yc; Fri, 23 Jan 2026 14:35:39 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 04/13] scripts/qmp_helper: make send_cper() more generic
Date: Fri, 23 Jan 2026 14:35:18 +0100
Message-ID: <6fe142b90bea9a8c8be43dc86f7750212be05809.1769175069.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769175069.git.mchehab+huawei@kernel.org>
References: <cover.1769175069.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=mchehab+huawei@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
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

Allow the caller to set GEDE, GEBS and raw data. This can be
useful if one wants to replicate a CPER with the same parameters
as the original one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 69 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index d37fb0ae11cc..ac3abc794c69 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -551,22 +551,11 @@ def send_cper_raw(self, cper_data):
 
         return False
 
-    def send_cper(self, notif_type, payload):
+    def get_gede(self, notif_type, cper_length):
         """
-        Send commands to QEMU though QMP TCP socket.
-
-        Return True on success, False otherwise.
+        Return a Generic Error Data Entry bytearray
         """
 
-        # Fill CPER record header
-
-        # NOTE: bits 4 to 13 of block status contain the number of
-        # data entries in the data section. This is currently unsupported.
-
-        cper_length = len(payload)
-        data_length = cper_length + len(self.raw_data) + self.GENERIC_DATA_SIZE
-
-        #  Generic Error Data Entry
         gede = bytearray()
 
         gede.extend(notif_type.to_bytes())
@@ -579,7 +568,13 @@ def send_cper(self, notif_type, payload):
         gede.extend(self.fru_text)
         gede.extend(self.timestamp)
 
-        # Generic Error Status Block
+        return gede
+
+    def get_gebs(self, data_length):
+        """
+        Return a Generic Error Status Block bytearray
+        """
+
         gebs = bytearray()
 
         if self.raw_data:
@@ -593,6 +588,52 @@ def send_cper(self, notif_type, payload):
         util.data_add(gebs, data_length, 4)
         util.data_add(gebs, self.error_severity, 4)
 
+        return gebs
+
+    def send_cper(self, notif_type, payload,
+                  gede=None, gebs=None, raw_data=None):
+        """
+        Send commands to QEMU though QMP TCP socket.
+
+        Return True on success, False otherwise.
+
+        Arguments:
+            notif_type: Notification type (GUID)
+            payload: bytearray with the payload
+            gede: Generic Error Data Entry. If None, the code will generate
+                  one using the defaults and generic error data arguments
+            gebs: Generic Error Status block. If None, the code will generate
+                  one using the defaults and generic error data arguments
+            raw_data: Raw data to be added after GEBS. If not specified,
+                      the code will generate one if Generic Error Data
+                      --raw-data parameter is specified.
+        """
+
+        # Fill CPER record header
+
+        # NOTE: bits 4 to 13 of block status contain the number of
+        # data entries in the data section. This is currently unsupported.
+
+        if raw_data:
+            self.raw_data = raw_data
+
+        cper_length = len(payload)
+        data_length = cper_length + len(self.raw_data) + self.GENERIC_DATA_SIZE
+
+        if gede and len(gede) != 72:
+            print(f"Invalid Generic Error Data Entry length: {len(gede)}. Ignoring it")
+            gede = None
+
+        if gebs and len(gebs) != 20:
+            print(f"Invalid Generic Error Status Block length: {len(gebs)}. Ignoring it")
+            gebs = None
+
+        if not gede:
+            gede = self.get_gede(notif_type, cper_length)
+
+        if not gebs:
+            gebs = self.get_gebs(data_length)
+
         cper_data = bytearray()
         cper_data.extend(gebs)
         cper_data.extend(gede)
-- 
2.52.0


