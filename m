Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 208DEC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhFm-0003yf-8J; Tue, 15 Jul 2025 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubggq-0003Zb-8f
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubggn-0006Wm-6P
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5JPC+kbOWzUd5lzM486OiMcy9RbtJKSJFRN42oWXHNo=;
 b=AVt8YFiMO0INQRy/CU+gdEbMXodmo7GZYBARt/OuPD7hCxdiF7zrSRqJIXWFyBKCa/ICft
 d3MOFt+DAQiLcxA1yZk+BYteKZGfk688z02M744PlNIgrAsAhcclyUJdBbztVvWzrGq/1b
 iJb0b+ca9wrxzHRQ1NeVbFSNUMX1Ud8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-ual90419OAS7DsHsRexILw-1; Tue,
 15 Jul 2025 10:31:14 -0400
X-MC-Unique: ual90419OAS7DsHsRexILw-1
X-Mimecast-MFC-AGG-ID: ual90419OAS7DsHsRexILw_1752589873
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C1D419560B6; Tue, 15 Jul 2025 14:31:13 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BB5118002B1; Tue, 15 Jul 2025 14:31:04 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/14] python: drop 'wait_closed' back compat helper
Date: Tue, 15 Jul 2025 15:30:13 +0100
Message-ID: <20250715143023.1851000-5-berrange@redhat.com>
In-Reply-To: <20250715143023.1851000-1-berrange@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Our minimum python is now 3.9, so back compat with python
3.6 is no longer required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/protocol.py |  3 +--
 python/qemu/qmp/util.py     | 29 -----------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 9a7ada4a1e..deb6b20d29 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -41,7 +41,6 @@
     flush,
     pretty_traceback,
     upper_half,
-    wait_closed,
 )
 
 
@@ -830,7 +829,7 @@ async def _bh_close_stream(self, error_pathway: bool = False) -> None:
 
         self.logger.debug("Waiting for StreamWriter to close ...")
         try:
-            await wait_closed(self._writer)
+            await self._writer.wait_closed()
         except Exception:  # pylint: disable=broad-except
             # It's hard to tell if the Stream is already closed or
             # not. Even if one of the tasks has failed, it may have
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index 39fc341f2f..b5e9750576 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -104,35 +104,6 @@ def create_task(coro: Coroutine[Any, Any, T],
     return asyncio.ensure_future(coro, loop=loop)
 
 
-async def wait_closed(writer: asyncio.StreamWriter) -> None:
-    """
-    Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
-
-    :param writer: The `asyncio.StreamWriter` to wait on.
-    """
-    if sys.version_info >= (3, 7):
-        await writer.wait_closed()
-        return
-
-    # Python 3.6
-    transport = writer.transport
-    assert isinstance(transport, asyncio.WriteTransport)
-
-    while not transport.is_closing():
-        await asyncio.sleep(0)
-
-    # This is an ugly workaround, but it's the best I can come up with.
-    sock = transport.get_extra_info('socket')
-
-    if sock is None:
-        # Our transport doesn't have a socket? ...
-        # Nothing we can reasonably do.
-        return
-
-    while sock.fileno() != -1:
-        await asyncio.sleep(0)
-
-
 def asyncio_run(coro: Coroutine[Any, Any, T], *, debug: bool = False) -> T:
     """
     Python 3.6-compatible `asyncio.run` wrapper.
-- 
2.49.0


