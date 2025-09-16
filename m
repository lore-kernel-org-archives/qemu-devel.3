Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF70CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYUF-0003sh-Ll; Tue, 16 Sep 2025 12:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUE-0003rW-FL
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUC-0002vF-Pe
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039895;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KDHIaz7ZhHPs0gClp0m8dinnbAj6EDwtr44MKpwGHIo=;
 b=bzGaL8FGXwa8BQ4M+n+D8ZT4Nw1PcxXzOosT8aKRHiDKS3g3yOKnzLtU4ltIhYnn8nWm5L
 jnk8TPO3HmkFrR760Vwsy6gs8mAWFkgGh+aga2cSRqh5U/AL8lAToL5KNKOoOlunGBTHn+
 D/DpiM9rbM2vGZ/KtPg9Zx1X11P16is=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-81-UF2BOvy-MwCFUdC6tGGDBg-1; Tue,
 16 Sep 2025 12:24:52 -0400
X-MC-Unique: UF2BOvy-MwCFUdC6tGGDBg-1
X-Mimecast-MFC-AGG-ID: UF2BOvy-MwCFUdC6tGGDBg_1758039891
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 845B0195605C; Tue, 16 Sep 2025 16:24:51 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC37A19560BA; Tue, 16 Sep 2025 16:24:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/19] python: backport 'Remove deprecated get_event_loop calls'
Date: Tue, 16 Sep 2025 12:23:57 -0400
Message-ID: <20250916162404.9195-13-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
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

This method was deprecated in 3.12 because it ordinarily should not be
used from coroutines; if there is not a currently running event loop,
this automatically creates a new event loop - which is usually not what
you want from code that would ever run in the bottom half.

In our case, we do want this behavior in two places:

(1) The synchronous shim, for convenience: this allows fully sync
programs to use QEMUMonitorProtocol() without needing to set up an event
loop beforehand. This is intentional to fully box in the async
complexities into the legacy sync shim.

(2) The qmp_tui shell; instead of relying on asyncio.run to create and
run an asyncio program, we need to be able to pass the current asyncio
loop to urwid setup functions. For convenience, again, we create one if
one is not present to simplify the creation of the TUI appliance.

The remaining user of get_event_loop() was in fact one of the erroneous
users that should not have been using this function: if there's no
running event loop inside of a coroutine, you're in big trouble :)

Signed-off-by: John Snow <jsnow@redhat.com>
cherry picked from commit python-qemu-qmp@aa1ff9907603a3033296027e1bd021133df86ef1
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/legacy.py  | 9 ++++++++-
 python/qemu/qmp/qmp_tui.py | 7 ++++++-
 python/tests/protocol.py   | 2 +-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index c8d0a29b56f..735d42971e9 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -86,7 +86,14 @@ def __init__(self,
                 "server argument should be False when passing a socket")
 
         self._qmp = QMPClient(nickname)
-        self._aloop = asyncio.get_event_loop()
+
+        try:
+            self._aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running loop; since this is a sync shim likely to be
+            # used in fully sync programs, create one if neccessary.
+            self._aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self._address = address
         self._timeout: Optional[float] = None
 
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 53ea6c59a71..12bdc17c99e 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -388,7 +388,12 @@ def run(self, debug: bool = False) -> None:
         screen = urwid.raw_display.Screen()
         screen.set_terminal_properties(256)
 
-        self.aloop = asyncio.get_event_loop()
+        try:
+            self.aloop = asyncio.get_running_loop()
+        except RuntimeError:
+            # No running asyncio event loop. Create one if necessary.
+            self.aloop = asyncio.get_event_loop_policy().get_event_loop()
+
         self.aloop.set_debug(debug)
 
         # Gracefully handle SIGTERM and SIGINT signals
diff --git a/python/tests/protocol.py b/python/tests/protocol.py
index c254c77b176..e565802516d 100644
--- a/python/tests/protocol.py
+++ b/python/tests/protocol.py
@@ -227,7 +227,7 @@ def async_test(async_test_method):
         Decorator; adds SetUp and TearDown to async tests.
         """
         async def _wrapper(self, *args, **kwargs):
-            loop = asyncio.get_event_loop()
+            loop = asyncio.get_running_loop()
             loop.set_debug(True)
 
             await self._asyncSetUp()
-- 
2.51.0


