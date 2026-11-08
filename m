Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1884606A31C
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Nov 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8zXAoOO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPyfp-0003Am-2C; Sun, 08 Nov 2026 03:54:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfg-00038r-Mn
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:40 -0500
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfe-0000wA-LW
 for qemu-devel@nongnu.org; Sun, 08 Nov 2026 03:54:40 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E0434487B;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BBF1F00904;
 Sun,  8 Nov 2026 08:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794128075;
 bh=AofEisHPa71V7e+1AJxK9WPx+5r7ivjgynVnO8nhMr8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b8zXAoOO6ZjTYRzNtfAXs/j6H9KwCMFJ0rwJLihz+zUqrhxo+MX1tfROLAkqSdeQz
 k3FPYSK5c1MDpi6PRUnyJNo5oi7pfx8pk3aHczs+zwXPHf6m3FniR8xGUh8lfL+ZMv
 rSb+N5zGEr89q4LMS22t6Dd8TI1axrsfQUbVqE6gLo6KLVMe69rPfPgaNWEDn4H6B3
 4CtVMQlV1K46EsHqSWM+qt7uRhdc0aKaxP+9wJHmxkW4f33tZyNVmWSAxhoZZjmaPP
 xlbhsdCuMxGaGszkkgUVTBvau2OwFLByciGGnslkMlPmwrZuN+2VvGchutEGabUs7q
 3Ji33JNHs500w==
Received: from mchehab by mail.kernel.org with local (Exim 4.100.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1xPyfZ-00000005Ujm-27Io; Sun, 08 Nov 2026 09:54:33 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Michael S Tsirkin <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-devel@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 13/13] scripts/ghes_inject: improve the retry attempt logic
Date: Sun,  8 Nov 2026 09:54:26 +0100
Message-ID: <c63cff02c016f1869ce5065225be3c1f1c1ed8a5.1794127710.git.mchehab+huawei@kernel.org>
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

Only retries if the cause of the error is:

{"error": {
  "class": "GenericError",
  "desc": "OSPM does not acknowledge previous error, so can not record CPER for current error anymore"
  }
}

As this is a transitory state.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/qmp_helper.py | 49 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 23 deletions(-)

diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
index ef3e46ee3fc6..158489e4cee6 100755
--- a/scripts/qmp_helper.py
+++ b/scripts/qmp_helper.py
@@ -343,41 +343,44 @@ def send_cmd(self, command, args=None, may_open=False, return_error=True,
 
         # Try up to attempts
         for i in range(0, attempts):
+            if i > 0:
+                print(f"Error inject attempt {i}/{attempts} failed. Retrying...")
+                sleep(0.1)
+
             try:
                 obj = self.qmp_monitor.cmd_obj(msg)
-
-                if obj and "return" in obj and not obj["return"]:
-                    break
+                if not obj:
+                    print(f"Command: {command}")
+                    print(f"Failed to create a QMP object.")
+                    return None
 
             except Exception as e:                     # pylint: disable=W0718
                 print(f"Command: {command}")
                 print(f"Failed to inject error: {e}.")
-                obj = None
+                return None
 
-            if attempts > 1:
-                print(f"Error inject attempt {i + 1}/{attempts} failed.")
+            error = obj.get("error")
+            if isinstance(error, dict):
+                desc = error.get("desc", "unknown error")
+                if return_error:
+                    print(f"Command: {msg}")
+                    print(f'{error["class"]}: {desc}')
 
-            if i + 1 < attempts:
-                sleep(0.1)
+                if not "acknowledge previous" in desc:
+                    break
 
-        if not obj:
-            return None
+                continue
 
-        if "return" in obj:
-            if isinstance(obj.get("return"), dict):
-                if obj["return"]:
-                    return obj["return"]
-                return "OK"
+            if "return" in obj:
+                if isinstance(obj.get("return"), dict):
+                    if obj["return"]:
+                        return obj["return"]
+                    return "OK"
 
-            return obj["return"]
+                return obj["return"]
 
-        if isinstance(obj.get("error"), dict):
-            error = obj["error"]
-            if return_error:
-                print(f"Command: {msg}")
-                print(f'{error["class"]}: {error["desc"]}')
-        else:
-            print(json.dumps(obj))
+            else:
+                print(json.dumps(obj))
 
         return None
 
-- 
2.56.0


