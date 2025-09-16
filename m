Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A55FCAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYU5-0003li-O6; Tue, 16 Sep 2025 12:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYU3-0003kw-SP
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYU2-0002qm-2R
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UbhN4MNvxan+1Eha8GS/CRtotRwg8YUA6FJ/A0ZxGKE=;
 b=CJnFrgBAUEdfJ+uyE3+Y8H/0WKQ0RoUjTKVZEvKnADTBSX4Du385GvvOWbzMNrVCbNYd04
 GA+KHcmPGHFfffHjUFI5A+GFe9zzyMtgXbOdmdLo8+ZwveLbQJxutGht0TsbAYrQ/jpUWc
 LPYZIYBnTB6Udf98xHSmgUd+dSMq+JI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-124-hH082yWnMH-8V0_UsQDMxw-1; Tue,
 16 Sep 2025 12:24:41 -0400
X-MC-Unique: hH082yWnMH-8V0_UsQDMxw-1
X-Mimecast-MFC-AGG-ID: hH082yWnMH-8V0_UsQDMxw_1758039880
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0C0F18002CD; Tue, 16 Sep 2025 16:24:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A9B2719560B8; Tue, 16 Sep 2025 16:24:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/19] python: backport 'make require() preserve async-ness'
Date: Tue, 16 Sep 2025 12:23:54 -0400
Message-ID: <20250916162404.9195-10-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This is not strictly needed functionality-wise, but doing this allows
sphinx to see which decorated methods are async. Without this, sphinx
misses the "async" classifier on generated docs, which ... for an async
library, isn't great.

It does make an already gnarly function even gnarlier, though.

So, what's going on here?

A synchronous function (like require() before this patch) can return a
coroutine that can be awaited on, for example:

  def some_func():
      return asyncio.task(asyncio.sleep(5))

  async def some_async_func():
      await some_func()

However, this function is not considered to be an "async" function in
the eyes of the abstract syntax tree. Specifically,
some_func.__code__.co_flags will not be set with CO_COROUTINE.

The interpreter uses this flag to know if it's legal to use "await" from
within the body of the function. Since this function is just wrapping
another function, it doesn't matter much for the decorator, but sphinx
uses the stdlib inspect.iscoroutinefunction() to determine when to add
the "async" prefix in generated output. This function uses the presence
of CO_COROUTINE.

So, in order to preserve the "async" flag for docs, the require()
decorator needs to differentiate based on whether it is decorating a
sync or async function and use a different wrapping mechanism
accordingly.

Phew.

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@40aa9699d619849f528032aa456dd061a4afa957
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/protocol.py | 53 ++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 3d5eb553aad..4d8a39f014b 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -18,6 +18,7 @@
 from contextlib import asynccontextmanager
 from enum import Enum
 from functools import wraps
+from inspect import iscoroutinefunction
 import logging
 import socket
 from ssl import SSLContext
@@ -130,6 +131,25 @@ def require(required_state: Runstate) -> Callable[[F], F]:
     :param required_state: The `Runstate` required to invoke this method.
     :raise StateError: When the required `Runstate` is not met.
     """
+    def _check(proto: 'AsyncProtocol[Any]') -> None:
+        name = type(proto).__name__
+        if proto.runstate == required_state:
+            return
+
+        if proto.runstate == Runstate.CONNECTING:
+            emsg = f"{name} is currently connecting."
+        elif proto.runstate == Runstate.DISCONNECTING:
+            emsg = (f"{name} is disconnecting."
+                    " Call disconnect() to return to IDLE state.")
+        elif proto.runstate == Runstate.RUNNING:
+            emsg = f"{name} is already connected and running."
+        elif proto.runstate == Runstate.IDLE:
+            emsg = f"{name} is disconnected and idle."
+        else:
+            assert False
+
+        raise StateError(emsg, proto.runstate, required_state)
+
     def _decorator(func: F) -> F:
         # _decorator is the decorator that is built by calling the
         # require() decorator factory; e.g.:
@@ -140,29 +160,20 @@ def _decorator(func: F) -> F:
         @wraps(func)
         def _wrapper(proto: 'AsyncProtocol[Any]',
                      *args: Any, **kwargs: Any) -> Any:
-            # _wrapper is the function that gets executed prior to the
-            # decorated method.
-
-            name = type(proto).__name__
-
-            if proto.runstate != required_state:
-                if proto.runstate == Runstate.CONNECTING:
-                    emsg = f"{name} is currently connecting."
-                elif proto.runstate == Runstate.DISCONNECTING:
-                    emsg = (f"{name} is disconnecting."
-                            " Call disconnect() to return to IDLE state.")
-                elif proto.runstate == Runstate.RUNNING:
-                    emsg = f"{name} is already connected and running."
-                elif proto.runstate == Runstate.IDLE:
-                    emsg = f"{name} is disconnected and idle."
-                else:
-                    assert False
-                raise StateError(emsg, proto.runstate, required_state)
-            # No StateError, so call the wrapped method.
+            _check(proto)
             return func(proto, *args, **kwargs)
 
-        # Return the decorated method;
-        # Transforming Func to Decorated[Func].
+        @wraps(func)
+        async def _async_wrapper(proto: 'AsyncProtocol[Any]',
+                                 *args: Any, **kwargs: Any) -> Any:
+            _check(proto)
+            return await func(proto, *args, **kwargs)
+
+        # Return the decorated method; F => Decorated[F]
+        # Use an async version when applicable, which
+        # preserves async signature generation in sphinx.
+        if iscoroutinefunction(func):
+            return cast(F, _async_wrapper)
         return cast(F, _wrapper)
 
     # Return the decorator instance from the decorator factory. Phew!
-- 
2.51.0


