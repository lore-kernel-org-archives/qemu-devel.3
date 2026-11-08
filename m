Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA213606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QCTUwcyS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyft-0003BQ-Pe; Sun, 08 Nov 2026 03:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyff-00038O-Sw
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:40 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfc-0000vY-JP
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:39 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2742443BBE;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066311F008A3;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=dmVa1860X/7ajspCqh1w6fAF4yPYQKt73v9KQI6jTlY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QCTUwcySwQV09daQU8gJX6cYhZmL0IkydoYONdv0of+vQT6CJb7RzujtEyi3yrFIr
 gtkC0Smgw6UclXQfO7ksce/e0oBJ/EbKCZKhahLBNopaAImvlC8igpKkFQkZ3xAlkD
 G8fQmucsR+/1PtO6KG2ZQN8tYA7Z8nI82QpCld9zQU9HrbS5X49TbTNFWo9Z5vPffh
 egIoPDL23uMyPjk7Kdrqx6ywfKCsx+L+DxPDOd2M288vZrY6fpxAdE6NVnZz4ixAjA
 cmhMoYM5XW8SbxzXxp6l4t2GtugKq56iZKSW+cwM27aH0ixMikOib6E8bsmR5cbMg/
 uNv3kyaEizXxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Uit-19G7; Sun, 08 Nov 2026 09:54:33 +0100
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
Subject: [PATCH 04/13] scripts/qmp_helper: make send_cper() more generic
Date: Sun,  8 Nov 2026 09:54:17 +0100
Message-ID: <c7d0bb25fce98f0924b632dd3116c83d55b10408.1794127710.git.mchehab+huawei@kernel.org>
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

Allow the caller to set GEDE, GEBS and raw data. This can be
useful if one wants to replicate a CPER with the same parameters
as the original one.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 69 ++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index 7190c988558a..7d9f955bc57f 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -546,22 +546,11 @@ def send_cper_raw(self, cper_data):
 
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
@@ -574,7 +563,13 @@ def send_cper(self, notif_type, payload):
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
@@ -588,6 +583,52 @@ def send_cper(self, notif_type, payload):
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
2.56.0


