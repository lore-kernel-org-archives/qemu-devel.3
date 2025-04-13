Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8125C369AE
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Apr 2025 11:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3vBD-00014S-CV; Sun, 13 Apr 2025 07:07:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3vAx-00013R-C7; Sun, 13 Apr 2025 07:07:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1u3vAu-00008l-4V; Sun, 13 Apr 2025 07:06:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C646E116997;
 Sun, 13 Apr 2025 14:05:02 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3F4981EEDF9;
 Sun, 13 Apr 2025 14:06:43 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2B5EF5851D; Sun, 13 Apr 2025 14:06:43 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Arthur Sengileyev <arthur.sengileyev@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/2] Fix objdump output parser in "nsis.py"
Date: Sun, 13 Apr 2025 14:06:43 +0300
Message-Id: <20250413110643.2438368-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250413110643.2438368-1-mjt@tls.msk.ru>
References: <20250413110643.2438368-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Arthur Sengileyev <arthur.sengileyev@gmail.com>

In msys2 distribution objdump from gcc is using single tab character
prefix, but objdump from clang is using 4 white space characters instead.
The script will not identify any dll dependencies for a QEMU build
generated with clang. This in turn will fail the build, because there
will be no files inside dlldir and no setup file will be created.
Instead of checking for whitespace in prefix use lstrip to accommodate
for differences in outputs.

Signed-off-by: Arthur Sengileyev <arthur.sengileyev@gmail.com>
Reviewed-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/nsis.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index af4e064819..8f469634eb 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -23,7 +23,7 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
     output = subprocess.check_output(["objdump", "-p", exe_or_dll], text=True)
     output = output.split("\n")
     for line in output:
-        if not line.startswith("\tDLL Name: "):
+        if not line.lstrip().startswith("DLL Name: "):
             continue
 
         dep = line.split("DLL Name: ")[1].strip()
-- 
2.39.5


