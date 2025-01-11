Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94EBBE7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 21:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWjPh-0007PF-L6; Sat, 11 Jan 2025 16:53:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1tWjPf-0007OY-F1; Sat, 11 Jan 2025 16:52:59 -0500
Received: from mail.weilnetz.de ([37.120.169.71]
 helo=mail.v2201612906741603.powersrv.de)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefan@weilnetz.de>)
 id 1tWjPd-00032n-Nk; Sat, 11 Jan 2025 16:52:59 -0500
Received: from qemu.weilnetz.de (qemu.weilnetz.de [188.68.58.204])
 by mail.v2201612906741603.powersrv.de (Postfix) with ESMTP id 6C79DDA07BC;
 Sat, 11 Jan 2025 22:52:53 +0100 (CET)
Authentication-Results: mail.v2201612906741603.powersrv.de; dkim=none;
 dmarc=fail reason="No valid SPF, No valid DKIM" header.from=weilnetz.de
 (policy=none); 
 spf=softfail (mail.v2201612906741603.powersrv.de: 188.68.58.204 is neither
 permitted nor denied by domain of stefan@weilnetz.de)
 smtp.mailfrom=stefan@weilnetz.de
Received: by qemu.weilnetz.de (Postfix, from userid 1000)
 id 31906460023; Sat, 11 Jan 2025 22:52:53 +0100 (CET)
To: Bin Meng <bin.meng@windriver.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Subject: [PATCH] scripts/nsis.py: Run dependency check for each DLL file only
 once
Date: Sat, 11 Jan 2025 22:52:44 +0100
Message-Id: <20250111215244.1680931-1-sw@weilnetz.de>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 6C79DDA07BC
X-Spamd-Bar: ++
X-Spamd-Result: default: False [2.60 / 12.00]; VIOLATED_DIRECT_SPF(3.50)[];
 BAYES_HAM(-3.00)[99.99%]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 FORGED_SENDER(0.30)[sw@weilnetz.de,stefan@weilnetz.de];
 ONCE_RECEIVED(0.20)[];
 DMARC_POLICY_SOFTFAIL(0.10)[weilnetz.de : No valid SPF, No valid
 DKIM,quarantine,sampled_out]; MIME_GOOD(-0.10)[text/plain];
 RCVD_NO_TLS_LAST(0.10)[]; RCVD_COUNT_ONE(0.00)[1];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:197540, ipnet:188.68.56.0/22, country:DE];
 R_DKIM_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_NEQ_ENVFROM(0.00)[sw@weilnetz.de,stefan@weilnetz.de];
 R_SPF_SOFTFAIL(0.00)[~all]; ARC_NA(0.00)[]
X-Rspamd-Server: v2201612906741603
Received-SPF: pass client-ip=37.120.169.71; envelope-from=stefan@weilnetz.de;
 helo=mail.v2201612906741603.powersrv.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Stefan Weil <sw@weilnetz.de>
From:  Stefan Weil via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Each DLL should only be checked once for dependencies, but
several hundred (781 in my test) unneeded checks were done.

Now the script is significantly faster (16 s in my build).

Signed-off-by: Stefan Weil <sw@weilnetz.de>
---
 scripts/nsis.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/nsis.py b/scripts/nsis.py
index d0914c88a7..d0ac61f6ab 100644
--- a/scripts/nsis.py
+++ b/scripts/nsis.py
@@ -37,10 +37,10 @@ def find_deps(exe_or_dll, search_path, analyzed_deps):
 
         analyzed_deps.add(dep)
         # locate the dll dependencies recursively
-        rdeps = find_deps(dll, search_path, analyzed_deps)
+        analyzed_deps, rdeps = find_deps(dll, search_path, analyzed_deps)
         deps.extend(rdeps)
 
-    return deps
+    return analyzed_deps, deps
 
 def main():
     parser = argparse.ArgumentParser(description="QEMU NSIS build helper.")
@@ -92,18 +92,18 @@ def main():
         dlldir = os.path.join(destdir + prefix, "dll")
         os.mkdir(dlldir)
 
+        analyzed_deps = set()
         for exe in glob.glob(os.path.join(destdir + prefix, "*.exe")):
             signcode(exe)
 
             # find all dll dependencies
-            deps = set(find_deps(exe, search_path, set()))
+            analyzed_deps, deps = find_deps(exe, search_path, analyzed_deps)
+            deps = set(deps)
             deps.remove(exe)
 
             # copy all dlls to the DLLDIR
             for dep in deps:
                 dllfile = os.path.join(dlldir, os.path.basename(dep))
-                if (os.path.exists(dllfile)):
-                    continue
                 print("Copying '%s' to '%s'" % (dep, dllfile))
                 shutil.copy(dep, dllfile)
 
-- 
2.45.2


