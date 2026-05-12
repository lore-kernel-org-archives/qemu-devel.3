Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00918CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuCr-0003Vp-8g; Tue, 12 May 2026 16:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBm-0002Nq-TU; Tue, 12 May 2026 16:58:51 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuBl-0004t4-6w; Tue, 12 May 2026 16:58:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=sHoIBRPTuAcrkSlVDY9jAqJpgsRsIidUwG8UYfWBmdk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RyD0/xAZBgw1Famd9ptljuWIgAJIwS8lVRqehhK4cmEUECG/4SzLcKz+n7nX89Kx2
 VMdw35//fmjvrCSC1vqIYjc+BbjJHEkR+qgIwfr0INIV/HZiJgKe4ADRg2UGAdetpn
 81gjP7KZD4+QEPLvKGhxAfdctZyyVq290f6V61cnDoHs+dXuTn50xJ8ZbXQ6JV5oli
 Fuq8IEf7twDQkRoUBSt2VSGJCiGEbp3lRQojS8Ai7EWpDUySxgwosi27pS8OZngf3w
 MEKSEuc4llCiAMq1R222IIWuAb0Bw1EXb27/LclSmEyevBMLDXRIeo5JX7/VR3T6nL
 XgbE2g0tvOosg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 24DE61AA2F8;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 32E913ABC69;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 044/107] util: fix missing aio_wait sym in qemu guest
 agent only build
Date: Tue, 12 May 2026 23:53:31 +0300
Message-ID: <20260512205437.360850-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 17fbf3e18c3dbc32ec07cfc24853d6654a813e90)
Fixes: a229ea19c7bf "monitor: Fix deadlock in monitor_cleanup" in 10.0.x
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/util/meson.build b/util/meson.build
index 780b5977a8..595d13543c 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -79,6 +79,7 @@ endif
 
 if have_block or have_ga
   util_ss.add(files('aiocb.c', 'async.c'))
+  util_ss.add(files('aio-wait.c'))
   util_ss.add(files('base64.c'))
   util_ss.add(files('main-loop.c'))
   util_ss.add(files('qemu-coroutine.c', 'qemu-coroutine-lock.c', 'qemu-coroutine-io.c'))
@@ -89,7 +90,6 @@ if have_block or have_ga or have_user
   util_ss.add(files('qemu-sockets.c'))
 endif
 if have_block
-  util_ss.add(files('aio-wait.c'))
   util_ss.add(files('buffer.c'))
   util_ss.add(files('bufferiszero.c'))
   util_ss.add(files('hbitmap.c'))
-- 
2.47.3


