Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C46CAC5B9
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Sep 2025 09:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2Qs8-0004cQ-DT; Sat, 27 Sep 2025 05:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qrx-0004VP-4o; Sat, 27 Sep 2025 05:05:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v2Qrk-0007AB-Py; Sat, 27 Sep 2025 05:05:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 207EA158562;
 Sat, 27 Sep 2025 12:03:03 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F22D229157F;
 Sat, 27 Sep 2025 12:03:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.21 13/16] python/qemu/machine: use socketpair() for QMP
 by default
Date: Sat, 27 Sep 2025 12:02:57 +0300
Message-ID: <20250927090304.2901324-13-mjt@tls.msk.ru>
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

When no monitor address is given, establish the QMP communication through
a socketpair() (API is also supported on Windows since Python 3.5)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20230111080101.969151-4-marcandre.lureau@redhat.com
[Resolved conflicts, fixed typing error. --js]
Signed-off-by: John Snow <jsnow@redhat.com>
(cherry picked from commit bd4c0ef409140bd1be393407c04005ac077d4574)
(Mjt: this fixes quite a few qemu iotests which was probably racing somewhere)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index 5df210c810..b6cb366584 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -158,17 +158,13 @@ def __init__(self,
         self._qmp_timer = qmp_timer
 
         self._name = name or f"{id(self):x}"
+        self._sock_pair: Optional[Tuple[socket.socket, socket.socket]] = None
         self._temp_dir: Optional[str] = None
         self._base_temp_dir = base_temp_dir
         self._sock_dir = sock_dir
         self._log_dir = log_dir
 
-        if monitor_address is not None:
-            self._monitor_address = monitor_address
-        else:
-            self._monitor_address = os.path.join(
-                self.sock_dir, f"{self._name}.qmp"
-            )
+        self._monitor_address = monitor_address
 
         self._console_log_path = console_log
         if self._console_log_path:
@@ -303,7 +299,11 @@ def _base_args(self) -> List[str]:
         args = ['-display', 'none', '-vga', 'none']
 
         if self._qmp_set:
-            if isinstance(self._monitor_address, tuple):
+            if self._sock_pair:
+                fd = self._sock_pair[0].fileno()
+                os.set_inheritable(fd, True)
+                moncdev = f"socket,id=mon,fd={fd}"
+            elif isinstance(self._monitor_address, tuple):
                 moncdev = "socket,id=mon,host={},port={}".format(
                     *self._monitor_address
                 )
@@ -337,10 +337,17 @@ def _pre_launch(self) -> None:
             self._remove_files.append(self._console_address)
 
         if self._qmp_set:
+            monitor_address = None
+            sock = None
+            if self._monitor_address is None:
+                self._sock_pair = socket.socketpair()
+                sock = self._sock_pair[1]
             if isinstance(self._monitor_address, str):
                 self._remove_files.append(self._monitor_address)
+                monitor_address = self._monitor_address
             self._qmp_connection = QEMUMonitorProtocol(
-                self._monitor_address,
+                address=monitor_address,
+                sock=sock,
                 server=True,
                 nickname=self._name
             )
@@ -360,6 +367,8 @@ def _pre_launch(self) -> None:
         ))
 
     def _post_launch(self) -> None:
+        if self._sock_pair:
+            self._sock_pair[0].close()
         if self._qmp_connection:
             self._qmp.accept(self._qmp_timer)
 
-- 
2.47.3


