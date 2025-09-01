Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC34CA1002
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 20:28:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utB7v-0004Hb-BL; Mon, 01 Sep 2025 16:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7s-0004H8-Ld
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1utB7r-00008U-25
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 16:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756758458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Se0q5+uT6KWiejFo7/IaGRao5fvt636my4wPKmetJz0=;
 b=KvGxIfCeVcEN1dVbSnAWOpYVXNh5Wx4o6Pcmj0PDe85ZM4HmpSSJo+jfjc4qsDLZaO+73F
 gqsQlxjxjUSkR3L7Q5O3zFAhqWZkmKI93JRCs6jeiZf3zMhkpozy+Oy7yGHwv6S5TNTJ5J
 ew/KHf1ku+obBP6awQsaf1zm11Weoj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-Z9gLCwudODqDvUw21qrhJA-1; Mon,
 01 Sep 2025 16:27:37 -0400
X-MC-Unique: Z9gLCwudODqDvUw21qrhJA-1
X-Mimecast-MFC-AGG-ID: Z9gLCwudODqDvUw21qrhJA_1756758456
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2ABF0180035F; Mon,  1 Sep 2025 20:27:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.85])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6C76319560B4; Mon,  1 Sep 2025 20:27:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PATCH 12/19] python: backport '*really* remove get_event_loop'
Date: Mon,  1 Sep 2025 16:26:54 -0400
Message-ID: <20250901202702.2971212-13-jsnow@redhat.com>
In-Reply-To: <20250901202702.2971212-1-jsnow@redhat.com>
References: <20250901202702.2971212-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A prior commit, aa1ff990, switched away from using get_event_loop *by
default*, but this is not good enough to avoid deprecation warnings as
`asyncio.get_event_loop_policy().get_event_loop()` is *also*
deprecated. Replace this mechanism with explicit calls to
asyncio.get_new_loop() and revise the cleanup mechanisms in __del__ to
match.

Reported-by: Richard W.M. Jones <rjones@redhat.com>
Reported-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit 21ce2ee4f2df87efe84a27b9c5112487f4670622
Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/qemu/qmp/legacy.py  | 47 +++++++++++++++++++++++++++-----------
 python/qemu/qmp/qmp_tui.py | 10 ++++++--
 2 files changed, 42 insertions(+), 15 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 735d42971e9..775b1fdd3b3 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -86,13 +86,15 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
+        self._created_loop = False
 
         try:
             self._aloop = asyncio.get_running_loop()
         except RuntimeError:
-            # No running loop; since this is a sync shim likely to be
-            # used in fully sync programs, create one if neccessary.
-            self._aloop = asyncio.get_event_loop_policy().get_event_loop()
+            # No running loop; since this is a sync shim likely to be used
+            # in sync programs without any event loop at all, create one.
+            self._aloop = asyncio.new_event_loop()
+            self._created_loop = True
 
         self._address = address
         self._timeout: Optional[float] = None
@@ -313,17 +315,36 @@ def send_fd_scm(self, fd: int) -> None:
         self._qmp.send_fd_scm(fd)
 
     def __del__(self) -> None:
-        if self._qmp.runstate == Runstate.IDLE:
-            return
+        if self._qmp.runstate != Runstate.IDLE:
+            self._qmp.logger.warning(
+                "QEMUMonitorProtocol object garbage collected without a prior "
+                "call to close()"
+            )
 
         if not self._aloop.is_running():
-            self.close()
-        else:
-            # Garbage collection ran while the event loop was running.
-            # Nothing we can do about it now, but if we don't raise our
-            # own error, the user will be treated to a lot of traceback
-            # they might not understand.
+            if self._qmp.runstate != Runstate.IDLE:
+                # If the user neglected to close the QMP session and we
+                # are not currently running in an asyncio context, we
+                # have the opportunity to close the QMP session. If we
+                # do not do this, the error messages presented over
+                # dangling async resources may not make any sense to the
+                # user.
+                self.close()
+
+            # If we created our own loop (and we are not running inside
+            # of it), we must close it to avoid warnings and error
+            # messages upon program exit.
+            if self._created_loop:
+                self._aloop.close()
+
+        if self._qmp.runstate != Runstate.IDLE:
+            # If QMP is still not quiesced, it means that the garbage
+            # collector ran from a context within the event loop and we
+            # are simply too late to take any corrective action. Raise
+            # our own error to give meaningful feedback to the user in
+            # order to prevent pages of asyncio stacktrace jargon.
             raise QMPError(
-                "QEMUMonitorProtocol.close()"
-                " was not called before object was garbage collected"
+                "QEMUMonitorProtocol.close() was not called before object was "
+                "garbage collected, and could not be closed due to GC running "
+                "in the event loop"
             )
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 12bdc17c99e..d5526338f22 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -161,6 +161,7 @@ def __init__(self, address: Union[str, Tuple[str, int]], num_retries: int,
         self.retry_delay = retry_delay if retry_delay else 2
         self.retry: bool = False
         self.exiting: bool = False
+        self._created_loop = False
         super().__init__()
 
     def add_to_history(self, msg: str, level: Optional[str] = None) -> None:
@@ -391,8 +392,9 @@ def run(self, debug: bool = False) -> None:
         try:
             self.aloop = asyncio.get_running_loop()
         except RuntimeError:
-            # No running asyncio event loop. Create one if necessary.
-            self.aloop = asyncio.get_event_loop_policy().get_event_loop()
+            # No running asyncio event loop. Create one.
+            self.aloop = asyncio.new_event_loop()
+            self._created_loop = True
 
         self.aloop.set_debug(debug)
 
@@ -416,6 +418,10 @@ def run(self, debug: bool = False) -> None:
             logging.error('%s\n%s\n', str(err), pretty_traceback())
             raise err
 
+    def __del__(self) -> None:
+        if self._created_loop and self.aloop:
+            self.aloop.close()
+
 
 class StatusBar(urwid.Text):
     """
-- 
2.50.1


