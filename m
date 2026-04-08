Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F2210F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYI7-0006hN-8V; Wed, 08 Apr 2026 15:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAYGe-0004B9-C5; Wed, 08 Apr 2026 15:08:49 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wAQdt-0000Pe-2G; Wed, 08 Apr 2026 07:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1775645720; bh=VK78BUyPrfqWz7lIc6GWBwkZlXECduU0RnUqcRxDBR4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Kfeet/mHmCPzKlkcFRIbajEQXfPT/OZG4LGcXApMbAo8cNKDm5C2OwljZjpdlhU0O
 N3LG5uo8/2JnrI+WRjcsx1LQ3m+OeJiRj2YDgZkKx36fYkIpBTVHwTAnOt2oyVZ6we
 Pgn0ZF5mORrwIcDkvUFk8pIguJPAem0c9FNdjFJjYphq0lr3qfQPANfbWQYfucn/RG
 od7ubtfBniR4TJN+fb5/d9OXNfghSIKnwqFphrSw2U8DgpO/X3fpBSV4CuHsha7HY6
 5/aTuvuCIoTozTBuW/N26AvTv7zAVcd+NkwT97rcG3+yxXZCqrzNeoSj2rglf4N/o1
 VAZgB6goZssLw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2442B19C29D;
 Wed, 08 Apr 2026 13:55:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 744B6391677;
 Wed, 08 Apr 2026 13:56:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-trivial@nongnu.org, qemu-stable@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 3/3] util: fix missing aio_wait sym in qemu guest agent only
 build
Date: Wed,  8 Apr 2026 13:55:58 +0300
Message-ID: <20260408105605.172465-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260408105605.172465-1-mjt@tls.msk.ru>
References: <20260408105605.172465-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

Configure QEMU with

 --disable-system --disable-user --disable-tools --enable-guest-agent

and the build with fail with

  FAILED: [code=1] qga/qemu-ga
  ld: libqemuutil.a.p/qapi_qmp-dispatch.c.o: in function `do_qmp_dispatch_bh':
  qapi/qmp-dispatch.c:140:(.text+0x5c): undefined reference to `aio_wait_kick'

This aio_kick() usage was recently introduced in qmp-dispatch.c
without updating the build logic.

Fixes commit fc1a2ec7da531223b3473185dc2584f8a7c6c659
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Cc: qemu-stable@nongnu.org
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 util/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/meson.build b/util/meson.build
index c2d77bf9de..5d3fff0eea 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -79,6 +79,7 @@ endif
 
 if have_block or have_ga
   util_ss.add(files('aiocb.c', 'async.c'))
+  util_ss.add(files('aio-wait.c'))
   util_ss.add(files('base64.c'))
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
@@ -87,7 +88,6 @@ if have_block or have_ga
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-  util_ss.add(files('aio-wait.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
2.47.3


