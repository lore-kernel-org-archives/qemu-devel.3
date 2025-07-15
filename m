Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B405FC83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdFx-0001tC-Hu; Tue, 15 Jul 2025 06:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ubdFu-0001rL-JW
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1ubdFr-000108-Q9
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 06:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752576680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F3pUEAKHBTm51ScYwWZq6IWDUG0QpF+3akRoei7RYdw=;
 b=Fc2FbPxZR7LeSv6kI/4o7V4sxjy/u9OET6YQ9j9NKCLxnVNzdhpKNiqwQYz99e+b30reF3
 8XgxCFXbfMZe5KJko1JMdbFHj4VMGFRC2Juqqee0sx1pUxEhQjEKd1+/3bwuCC0iCABWr7
 wBmRQFiKyAv1xTiazfGzqIXswk5XdEU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-gCJSC9EEPA2zAUB83h7vlw-1; Tue,
 15 Jul 2025 06:51:18 -0400
X-MC-Unique: gCJSC9EEPA2zAUB83h7vlw-1
X-Mimecast-MFC-AGG-ID: gCJSC9EEPA2zAUB83h7vlw_1752576677
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CFCD18002EC
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 10:51:17 +0000 (UTC)
Received: from cash.home.annexia.org (unknown [10.44.32.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65FA0180045B; Tue, 15 Jul 2025 10:51:15 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
To: jsnow@redhat.com
Cc: crosa@redhat.com, qemu-devel@nongnu.org, berrange@redhat.com,
 mhroncok@redhat.com
Subject: [PATCH] python: Replace asyncio.get_event_loop for Python 3.14
Date: Tue, 15 Jul 2025 11:51:10 +0100
Message-ID: <20250715105113.623604-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=rjones@redhat.com;
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

In Python 3.14, no asyncio event loop gets generated automatically.
Instead create one when we need it.  This should work with Python 3.13
as well.  This is a mechanical change as suggested here:

https://bugzilla.redhat.com/show_bug.cgi?id=2375004#c4

See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
Thanks: Miro Hrončok
Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 python/qemu/qmp/legacy.py  | 5 ++++-
 python/qemu/qmp/qmp_tui.py | 5 ++++-
 python/qemu/qmp/util.py    | 5 ++++-
 python/tests/protocol.py   | 5 ++++-
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 22a2b5616e..e11d05afbd 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -86,7 +86,10 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-        self._aloop = asyncio.get_event_loop()
+        try:
+            self._aloop = asyncio.get_event_loop()
+        except RuntimeError:
+            self._aloop = asyncio.new_event_loop()
         self._address = address
         self._timeout: Optional[float] = None
 
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 2d9ebbd20b..84c5da4e66 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -377,7 +377,10 @@ def run(self, debug: bool = False) -> None:
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
 
-        self.aloop = asyncio.get_event_loop()
+        try:
+            self.aloop = asyncio.get_event_loop()
+        except RuntimeError:
+            self.aloop = asyncio.new_event_loop()
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index ca6225e9cd..8f9f849a5f 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -160,7 +160,10 @@ def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
         return asyncio.run(coro, debug=debug)
 
     # Python 3.6
-    loop = asyncio.get_event_loop()
+    try:
+        loop = asyncio.get_event_loop()
+    except RuntimeError:
+        loop = asyncio.new_event_loop()
     loop.set_debug(debug)
     ret = loop.run_until_complete(coro)
     loop.close()
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index 56c4d441f9..aa7c0e4397 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -228,7 +228,10 @@ def async_test(async_test_method):
         Decorator; adds SetUp and TearDown to async tests.
         """
         async def _wrapper(self, *args, **kwargs):
-            loop = asyncio.get_event_loop()
+            try:
+                loop = asyncio.get_event_loop()
+            except RuntimeError:
+                loop = asyncio.new_event_loop()
             loop.set_debug(True)
 
             await self._asyncSetUp()
-- 
2.50.1


