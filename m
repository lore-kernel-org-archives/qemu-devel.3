Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ACF6C0219B
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:02:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgL9a-0006nW-Ly; Fri, 07 Feb 2025 05:00:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9X-0006mW-O0; Fri, 07 Feb 2025 05:00:03 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tgL9V-0001qf-Io; Fri, 07 Feb 2025 05:00:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 14FF1E7346;
 Fri, 07 Feb 2025 12:59:18 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7E42D1B09CA;
 Fri,  7 Feb 2025 12:59:59 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 78D1A52D75; Fri, 07 Feb 2025 12:59:59 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 42/49] stub: Fix build failure with --enable-user
 --disable-system --enable-tools
Date: Fri,  7 Feb 2025 12:59:44 +0300
Message-Id: <20250207095956.2238705-1-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250207102656@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Zhao Liu <zhao1.liu@intel.com>

Configuring "--enable-user --disable-system --enable-tools" causes the
build failure with the following information:

/usr/bin/ld: libhwcore.a.p/hw_core_qdev.c.o: in function `device_finalize':
/qemu/build/../hw/core/qdev.c:688: undefined reference to `qapi_event_send_device_deleted'
collect2: error: ld returned 1 exit status

To fix the above issue, add qdev.c stub when build with `have_tools`.

With this fix, QEMU could be successfully built in the following cases:
 --enable-user --disable-system --enable-tools
 --enable-user --disable-system --disable-tools
 --enable-user --disable-system

Cc: qemu-stable@nongnu.org
Fixes: 388b849fb6c3 ("stubs: avoid duplicate symbols in libqemuutil.a")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2766
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121154318.214680-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 8113dbbcdaee05f319a7e48272416d918cb2b04a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/stubs/meson.build b/stubs/meson.build
index e91614a874..a8b3aeb564 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -57,8 +57,8 @@ if have_user
   stub_ss.add(files('cpu-synchronize-state.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
-  # they are not built at all for --disable-system --disable-tools builds.
-  if not (have_system or have_tools)
+  # they are not built at all for --disable-system builds.
+  if not have_system
     stub_ss.add(files('qdev.c'))
   endif
 endif
-- 
2.39.5


