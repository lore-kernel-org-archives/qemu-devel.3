Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EC3FC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhFh-0003pZ-WE; Tue, 15 Jul 2025 11:07:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubggh-0003Wm-D3
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubgge-0006Vn-Ot
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752589875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uaEabOSXUahWV4PiOgoybPYT27qnbN4CDQSPyTIrjg=;
 b=Rb0R3P/GDUL7XOSD5hDWcsyUlqEEzAY/44E3ccYXCadA3y8LuJLakln39Jtp/Ds4c8GPLP
 KCJugtwR1SnGIw8CeU62qcO1n7PVxyMRvqgMBzWX2+P3un0nnJjVe75X3zTdDiVElVprdo
 AIcF4V5oCgu9IvbAm8p9ePEUa+Jyr1E=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-kAN5Qq7EMWWx49prYtkJjA-1; Tue,
 15 Jul 2025 10:31:09 -0400
X-MC-Unique: kAN5Qq7EMWWx49prYtkJjA-1
X-Mimecast-MFC-AGG-ID: kAN5Qq7EMWWx49prYtkJjA_1752589864
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54861195608F; Tue, 15 Jul 2025 14:31:04 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.173])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82D8F18002B1; Tue, 15 Jul 2025 14:31:00 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 03/14] python: drop 'is_closing' back compat helper
Date: Tue, 15 Jul 2025 15:30:12 +0100
Message-ID: <20250715143023.1851000-4-berrange@redhat.com>
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

Our minimum python is now 3.9, so back compat with python
3.6 is no longer required.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/protocol.py |  3 +--
 python/qemu/qmp/util.py     | 16 ----------------
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index a4ffdfad51..9a7ada4a1e 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -39,7 +39,6 @@
     create_task,
     exception_summary,
     flush,
-    is_closing,
     pretty_traceback,
     upper_half,
     wait_closed,
@@ -825,7 +824,7 @@ async def _bh_close_stream(self, error_pathway: bool = False) -> None:
         if not self._writer:
             return
 
-        if not is_closing(self._writer):
+        if not self._writer.is_closing():
             self.logger.debug("Closing StreamWriter.")
             self._writer.close()
 
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index ca6225e9cd..39fc341f2f 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -104,22 +104,6 @@ def create_task(coro: Coroutine[Any, Any, T],
     return asyncio.ensure_future(coro, loop=loop)
 
 
-def is_closing(writer: asyncio.StreamWriter) -> bool:
-    """
-    Python 3.6-compatible `asyncio.StreamWriter.is_closing` wrapper.
-
-    :param writer: The `asyncio.StreamWriter` object.
-    :return: `True` if the writer is closing, or closed.
-    """
-    if sys.version_info >= (3, 7):
-        return writer.is_closing()
-
-    # Python 3.6:
-    transport = writer.transport
-    assert isinstance(transport, asyncio.WriteTransport)
-    return transport.is_closing()
-
-
 async def wait_closed(writer: asyncio.StreamWriter) -> None:
     """
     Python 3.6-compatible `asyncio.StreamWriter.wait_closed` wrapper.
-- 
2.49.0


