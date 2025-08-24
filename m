Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860F5CA0EFC
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 10:25:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uq7tk-00026j-ID; Sun, 24 Aug 2025 06:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uq7tg-00026T-2E
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 06:24:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1uq7tc-00072y-Mz
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 06:24:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6FB701499A7
 for <qemu-devel@nongnu.org>; Sun, 24 Aug 2025 13:23:47 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CE0602677DF;
 Sun, 24 Aug 2025 13:24:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH] scripts/qemu-binfmt-conf.sh: remove --credential option
Date: Sun, 24 Aug 2025 13:24:08 +0300
Message-ID: <20250824102408.2066036-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

qemu-user has never been designed to run in suid/sgid context,
to handle a suid/sgid binary which should run with elevated
privileges.  Our qemu-binfmt-conf script made it too easy to
hit this trap for the users.  Remove this ability.

If an experienced user wants to set up such an environment,
there's a simpe way to modify the resulting config to include
the necessary flags, but qemu itself should not support this
mode until we can provide a minimal security guarantee/support.

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 scripts/qemu-binfmt-conf.sh | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 5fd462b1d1..c4a1fe7685 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -183,7 +183,7 @@ qemu_normalize() {
 usage() {
     cat <<EOF
 Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
-                           [--help][--credential yes|no][--exportdir PATH]
+                           [--help][--exportdir PATH]
                            [--persistent yes|no][--qemu-suffix SUFFIX]
                            [--preserve-argv0 yes|no]
 
@@ -200,8 +200,6 @@ Usage: qemu-binfmt-conf.sh [--qemu-path PATH][--debian][--systemd CPU]
                         file for all known cpus
        --exportdir:     define where to write configuration files
                         (default: $SYSTEMDDIR or $DEBIANDIR)
-       --credential:    if yes, credential and security tokens are
-                        calculated according to the binary to interpret
        --persistent:    if yes, the interpreter is loaded when binfmt is
                         configured and remains in memory. All future uses
                         are cloned from the open file.
@@ -275,9 +273,6 @@ qemu_check_systemd() {
 
 qemu_generate_register() {
     flags=""
-    if [ "$CREDENTIAL" = "yes" ] ; then
-        flags="OC"
-    fi
     if [ "$PERSISTENT" = "yes" ] ; then
         flags="${flags}F"
     fi
@@ -304,7 +299,7 @@ package qemu-$cpu
 interpreter $qemu
 magic $magic
 mask $mask
-credentials $CREDENTIAL
+credentials no
 preserve $PRESERVE_ARG0
 fix_binary $PERSISTENT
 EOF
@@ -359,13 +354,12 @@ SYSTEMDDIR="/etc/binfmt.d"
 DEBIANDIR="/usr/share/binfmts"
 
 QEMU_PATH=/usr/local/bin
-CREDENTIAL=no
 PERSISTENT=no
 PRESERVE_ARG0=no
 QEMU_SUFFIX=""
 IGNORE_FAMILY=no
 
-_longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential:,\
+_longopts="debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,\
 persistent:,preserve-argv0:,ignore-family:"
 options=$(getopt -o ds:Q:S:e:hc:p:g:F:i: -l ${_longopts} -- "$@")
 eval set -- "$options"
@@ -415,10 +409,6 @@ while true ; do
         usage
         exit 1
         ;;
-    -c|--credential)
-        shift
-        CREDENTIAL="$1"
-        ;;
     -p|--persistent)
         shift
         PERSISTENT="$1"
-- 
2.47.2


