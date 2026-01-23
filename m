Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4851ED74ED0
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:36:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHKB-0007Pr-21; Fri, 23 Jan 2026 08:35:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK9-0007P6-Kl
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:41 -0500
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK7-0004bj-W6
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:35:41 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D6DCD60130;
 Fri, 23 Jan 2026 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A770C4CEF1;
 Fri, 23 Jan 2026 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769175338;
 bh=643xKLsq2X7KOI3w05ra+sdLFRG1gzNEXoNPGWF0L68=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QW/qKwIEJCwU/4yqLO+jVfoCA2E50RvZaV9XkD2al/7y/MTbb49PdEUz1Lq/MJm7T
 NrlTPvSBNCy7TaYS7gmydijg1EGJfrXO76MonT5Gf9L8W8ZNmx38GQG0chH6wzH5xn
 a45gMOzQXURISCOSmz13Flz+GZmdoeeo4Aaj4HlOxv12cBG4zidqnuKQhHFsZqVAOd
 Jrx2x4MSsdHWl8NDZBxJ9xoEjvfymD6Hz7fa9HOyqQAHtcAyTK2RBqQf05sZCaY3Fr
 60I7FW0FT/oOcCSCp4skzk7ZN0ThZ9DzZDqSc/gyPQ2tdtHJ5n4zTWxSoZAy9gPyuF
 ve7xguu1Vtu3g==
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vjHK4-000000063JZ-2Np5; Fri, 23 Jan 2026 14:35:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PATCH v2 01/13] scripts/qmp_helper: add a return code to send_cper
Date: Fri, 23 Jan 2026 14:35:15 +0100
Message-ID: <dff9055ea3a786065e1a6b395492ba53032449e7.1769175069.git.mchehab+huawei@kernel.org>
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

When used inside a loop, it is useful to have a return code to indicate
whether a send cper command succedded or not.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 scripts/qmp_helper.py | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index c1e7e0fd80ce..249a8c7187d1 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -531,7 +531,11 @@ def __init__(self, host, port, debug=False):
     # Socket QMP send command
     #
     def send_cper_raw(self, cper_data):
-        """Send a raw CPER data to QEMU though QMP TCP socket"""
+        """
+        Send a raw CPER data to QEMU though QMP TCP socket.
+
+        Return True on success, False otherwise.
+        """
 
         data = b64encode(bytes(cper_data)).decode('ascii')
 
@@ -543,9 +547,16 @@ def send_cper_raw(self, cper_data):
 
         if self.send_cmd("inject-ghes-v2-error", cmd_arg):
             print("Error injected.")
+            return True
+
+        return False
 
     def send_cper(self, notif_type, payload):
-        """Send commands to QEMU though QMP TCP socket"""
+        """
+        Send commands to QEMU though QMP TCP socket.
+
+        Return True on success, False otherwise.
+        """
 
         # Fill CPER record header
 
@@ -599,8 +610,7 @@ def send_cper(self, notif_type, payload):
 
             util.dump_bytearray("Payload", payload)
 
-        self.send_cper_raw(cper_data)
-
+        return self.send_cper_raw(cper_data)
 
     def search_qom(self, path, prop, regex):
         """
-- 
2.52.0


