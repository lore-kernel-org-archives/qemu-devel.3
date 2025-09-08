Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10960CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 19:10:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvh9v-0006Ky-Jd; Mon, 08 Sep 2025 15:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9u-0006Gx-65
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:04:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uvh9Y-0007u1-TK
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 15:04:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757358224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4cXiUx1NSS253XfDgfMgVAMOW1SkWQ61spfOO0h1sRQ=;
 b=VL8O70oj6mEsk8609XTr66L31L1sj31mvYV0e7vacdtcvMrmcpIi0Y/WBS5Xs0nevrjYnZ
 wrhXe60HP9KukN1HI8g9HceMPfxngHB+WQxr8N+zfL5/Wb6Ve8A19K3EWJF1KfEaW+13kE
 Ja+2NPThxKJ7IqUCxKIKmK36NIgzDAk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-w2TTEH5kOPWzAWOJuHI_7w-1; Mon,
 08 Sep 2025 15:03:42 -0400
X-MC-Unique: w2TTEH5kOPWzAWOJuHI_7w-1
X-Mimecast-MFC-AGG-ID: w2TTEH5kOPWzAWOJuHI_7w_1757358222
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E82D11800294; Mon,  8 Sep 2025 19:03:41 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.36])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70AC31955F24; Mon,  8 Sep 2025 19:03:39 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v3 06/19] python: backport 'Use @asynciocontextmanager'
Date: Mon,  8 Sep 2025 15:03:05 -0400
Message-ID: <20250908190318.3331728-7-jsnow@redhat.com>
In-Reply-To: <20250908190318.3331728-1-jsnow@redhat.com>
References: <20250908190318.3331728-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This removes a non-idiomatic use of a "coroutine callback" in favor of
something a bit more standardized.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@commit 97f7ffa3be17a50544b52767d14b6fd478c07b9e
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/protocol.py | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 208bdec5c89..958aeca08ac 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -15,6 +15,7 @@
 
 import asyncio
 from asyncio import StreamReader, StreamWriter
+from contextlib import asynccontextmanager
 from enum import Enum
 from functools import wraps
 import logging
@@ -22,6 +23,7 @@
 from ssl import SSLContext
 from typing import (
     Any,
+    AsyncGenerator,
     Awaitable,
     Callable,
     Generic,
@@ -337,9 +339,8 @@ async def start_server(self, address: SocketAddrT,
             This exception will wrap a more concrete one. In most cases,
             the wrapped exception will be `OSError`.
         """
-        await self._session_guard(
-            self._do_start_server(address, ssl),
-            'Failed to establish connection')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_start_server(address, ssl)
         assert self.runstate == Runstate.CONNECTING
 
     @upper_half
@@ -362,12 +363,10 @@ async def accept(self) -> None:
         """
         if self._accepted is None:
             raise QMPError("Cannot call accept() before start_server().")
-        await self._session_guard(
-            self._do_accept(),
-            'Failed to establish connection')
-        await self._session_guard(
-            self._establish_session(),
-            'Failed to establish session')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_accept()
+        async with self._session_guard('Failed to establish session'):
+            await self._establish_session()
         assert self.runstate == Runstate.RUNNING
 
     @upper_half
@@ -392,12 +391,10 @@ async def connect(self, address: Union[SocketAddrT, socket.socket],
             protocol-level failure occurs while establishing a new
             session, the wrapped error may also be an `QMPError`.
         """
-        await self._session_guard(
-            self._do_connect(address, ssl),
-            'Failed to establish connection')
-        await self._session_guard(
-            self._establish_session(),
-            'Failed to establish session')
+        async with self._session_guard('Failed to establish connection'):
+            await self._do_connect(address, ssl)
+        async with self._session_guard('Failed to establish session'):
+            await self._establish_session()
         assert self.runstate == Runstate.RUNNING
 
     @upper_half
@@ -418,7 +415,8 @@ async def disconnect(self) -> None:
     # Section: Session machinery
     # --------------------------
 
-    async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
+    @asynccontextmanager
+    async def _session_guard(self, emsg: str) -> AsyncGenerator[None, None]:
         """
         Async guard function used to roll back to `IDLE` on any error.
 
@@ -435,10 +433,9 @@ async def _session_guard(self, coro: Awaitable[None], emsg: str) -> None:
         :raise ConnectError:
             When any other error is encountered in the guarded block.
         """
-        # Note: After Python 3.6 support is removed, this should be an
-        # @asynccontextmanager instead of accepting a callback.
         try:
-            await coro
+            # Caller's code runs here.
+            yield
         except BaseException as err:
             self.logger.error("%s: %s", emsg, exception_summary(err))
             self.logger.debug("%s:\n%s\n", emsg, pretty_traceback())
-- 
2.50.1


