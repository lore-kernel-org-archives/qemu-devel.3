Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C02ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 16:49:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Rua-00005l-La; Sun, 05 Oct 2025 12:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RuV-0008WU-IF; Sun, 05 Oct 2025 12:48:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5RuT-00071e-2j; Sun, 05 Oct 2025 12:48:35 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3676415AA29;
 Sun, 05 Oct 2025 19:48:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 065B22996E7;
 Sun,  5 Oct 2025 19:48:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 62/81] net/passt: Fix build failure due to missing GIO
 dependency
Date: Sun,  5 Oct 2025 19:47:42 +0300
Message-ID: <20251005164822.442861-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20251005194607@cover.tls.msk.ru>
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

From: Laurent Vivier <lvivier@redhat.com>

The passt networking backend uses functions from the GIO library,
such as g_subprocess_launcher_new(), to manage its daemon process.
So, building with passt enabled requires GIO to be available.

If we enable passt and disable gio the build fails during linkage with
undefined reference errors:

  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:250: undefined reference to `g_subprocess_launcher_new'
  /usr/bin/ld: net/passt.c:251: undefined reference to `g_subprocess_launcher_take_fd'
  /usr/bin/ld: net/passt.c:253: undefined reference to `g_subprocess_launcher_spawnv'
  /usr/bin/ld: net/passt.c:256: undefined reference to `g_object_unref'
  /usr/bin/ld: net/passt.c:263: undefined reference to `g_subprocess_wait'
  /usr/bin/ld: net/passt.c:268: undefined reference to `g_subprocess_get_if_exited'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `glib_autoptr_clear_GSubprocess':
  /usr/include/glib-2.0/gio/gio-autocleanups.h:132: undefined reference to `g_object_unref'
  /usr/bin/ld: libsystem.a.p/net_passt.c.o: in function `net_passt_start_daemon':
  net/passt.c:269: undefined reference to `g_subprocess_get_exit_status'

Fix this by adding an explicit weson dependency on GIO for the passt
option.
The existing dependency on linux is kept because passt is only available
on this OS.

Cc: qemu-stable@nongnu.org
Fixes: 854ee02b222 ("net: Add passt network backend")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3121
Reported-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 4ccca2cc05a2d904d1e25365accf3bcbe553c8b0)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/meson.build b/meson.build
index 50c774a195..b7db736bbf 100644
--- a/meson.build
+++ b/meson.build
@@ -1287,6 +1287,7 @@ endif
 
 enable_passt = get_option('passt') \
   .require(host_os == 'linux', error_message: 'passt is supported only on Linux') \
+  .require(gio.found(), error_message: 'passt requires gio') \
   .allowed()
 
 vde = not_found
-- 
2.47.3


