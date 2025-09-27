Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFA3CAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:12:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qra-0004Mw-VC; Sat, 27 Sep 2025 05:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QrZ-0004Kz-EQ; Sat, 27 Sep 2025 05:05:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2QrJ-0006w2-J3; Sat, 27 Sep 2025 05:05:03 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DD86415855F;
 Sat, 27 Sep 2025 12:03:02 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B9B3529157C;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Delevoryas <peter@pjd.dev>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 10/16] python/machine: Fix AF_UNIX path too long on
 macOS
Date: Sat, 27 Sep 2025 12:02:54 +0300
Message-ID: <20250927090304.2901324-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
References: <qemu-stable-7.2.21-20250927105809@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Peter Delevoryas <peter@pjd.dev>

On macOS, private $TMPDIR's are the default. These $TMPDIR's are
generated from a user's unix UID and UUID [1], which can create a
relatively long path:

    /var/folders/d7/rz20f6hd709c1ty8f6_6y_z40000gn/T/

QEMU's avocado tests create a temporary directory prefixed by
"avo_qemu_sock_", and create QMP sockets within _that_ as well.
The QMP socket is unnecessarily long, because a temporary directory
is created for every QEMUMachine object.

    /avo_qemu_sock_uh3w_dgc/qemu-37331-10bacf110-monitor.sock

The path limit for unix sockets on macOS is 104: [2]

    /*
     * [XSI] Definitions for UNIX IPC domain.
     */
    struct  sockaddr_un {
        unsigned char   sun_len;        /* sockaddr len including null */
        sa_family_t     sun_family;     /* [XSI] AF_UNIX */
        char            sun_path[104];  /* [XSI] path name (gag) */
    };

This results in avocado tests failing on macOS because the QMP unix
socket can't be created, because the path is too long:

    ERROR| Failed to establish connection: OSError: AF_UNIX path too long

This change resolves by reducing the size of the socket directory prefix
and the suffix on the QMP and console socket names.

The result is paths like this:

    pdel@pdel-mbp:/var/folders/d7/rz20f6hd709c1ty8f6_6y_z40000gn/T
    $ tree qemu*
    qemu_df4evjeq
    qemu_jbxel3gy
    qemu_ml9s_gg7
    qemu_oc7h7f3u
    qemu_oqb1yf97
    ├── 10a004050.con
    └── 10a004050.qmp

[1] https://apple.stackexchange.com/questions/353832/why-is-mac-osx-temp-directory-in-weird-path
[2] /Library/Developer/CommandLineTools/SDKs/MacOSX12.3.sdk/usr/include/sys/un.h

Signed-off-by: Peter Delevoryas <peter@pjd.dev>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20230110082930.42129-2-peter@pjd.dev
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit f9922937d173f50fe59fd1b20fadc445fb6b2564)
(Mjt: pick this simple fix for 7.2.x so subsequent changes applies cleanly)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 37191f433b..5df210c810 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -157,7 +157,7 @@ def __init__(self,
         self._wrapper = wrapper
         self._qmp_timer = qmp_timer
 
-        self._name = name or f"qemu-{os.getpid()}-{id(self):02x}"
+        self._name = name or f"{id(self):x}"
         self._temp_dir: Optional[str] = None
         self._base_temp_dir = base_temp_dir
         self._sock_dir = sock_dir
@@ -167,7 +167,7 @@ def __init__(self,
             self._monitor_address = monitor_address
         else:
             self._monitor_address = os.path.join(
-                self.sock_dir, f"{self._name}-monitor.sock"
+                self.sock_dir, f"{self._name}.qmp"
             )
 
         self._console_log_path = console_log
@@ -192,7 +192,7 @@ def __init__(self,
         self._console_set = False
         self._console_device_type: Optional[str] = None
         self._console_address = os.path.join(
-            self.sock_dir, f"{self._name}-console.sock"
+            self.sock_dir, f"{self._name}.con"
         )
         self._console_socket: Optional[socket.socket] = None
         self._remove_files: List[str] = []
diff --git a/tests/avocado/avocado_qemu/__init__.py b/tests/avocado/avocado_qemu/__init__.py
index 910f3ba1ea..25a546842f 100644
--- a/tests/avocado/avocado_qemu/__init__.py
+++ b/tests/avocado/avocado_qemu/__init__.py
@@ -306,7 +306,7 @@ def require_netdev(self, netdevname):
             self.cancel('no support for user networking')
 
     def _new_vm(self, name, *args):
-        self._sd = tempfile.TemporaryDirectory(prefix="avo_qemu_sock_")
+        self._sd = tempfile.TemporaryDirectory(prefix="qemu_")
         vm = QEMUMachine(self.qemu_bin, base_temp_dir=self.workdir,
                          sock_dir=self._sd.name, log_dir=self.logdir)
         self.log.debug('QEMUMachine "%s" created', name)
-- 
2.47.3


