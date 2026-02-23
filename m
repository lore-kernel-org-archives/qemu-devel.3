Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C16CEA4FB2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 11:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuUSV-0004Pj-OM; Mon, 23 Feb 2026 06:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSU-0004P9-A9
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:38 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSR-0004qs-1g
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 06:50:37 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BC358440B7;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97870C116C6;
 Mon, 23 Feb 2026 11:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771847433;
 bh=TFn+oGlXTvEweHwQM+0j7k4x7K62+/n653dih5LjR+c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DvmOp8NM0XxyraCTeUpAY09ySPWLoImGzXFm38SZRv7UXd8cHQqkx2aNnS9aytRoB
 LcdN8t7JRKnOClLn4a4mWgCkYP999t+25f0uGfWdJovbQNddE79Ky1rUi6ne1xznVi
 GeJsAFZi8Nndv9aI70YgGMiUBUkQa1jdhNDrVUDu4QEzqwjNTcQT4Qwi8HKVs3xtnR
 QHeSOR7785MfvwAi/JOhzMa6P0CAp5/YRWEnFKWjFK3KA2vvNl/U0ZnA1SwD2AXjE/
 qyn++yGWIpu8ySZvV/aPV2kes1/lUDSdtXeryeVe5M+H8dUZi58nZ5QlmKAPO02b+r
 me/pJuQlBsJpg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vuUSN-00000007JnZ-3Ptw; Mon, 23 Feb 2026 12:50:31 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v3 01/14] scripts/qmp_helper: add a return code to send_cper
Date: Mon, 23 Feb 2026 12:50:17 +0100
Message-ID: <2aa2c3565ceec788bcf637ce64454b7946e7d20c.1771847176.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771847176.git.mchehab+huawei@kernel.org>
References: <cover.1771847176.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31;
 envelope-from=mchehab+huawei@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

When used inside a loop, it is interesting to have a return
code to indicate weather a send cper command succedded or not.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
2.53.0


