Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246A2CD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:17:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuOG-0000fH-Df; Tue, 12 May 2026 17:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuO9-0000BK-Ts; Tue, 12 May 2026 17:11:39 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuO8-0004Th-7y; Tue, 12 May 2026 17:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=M6mOKWnj2BDxXSkSMiqlrYyDKPcn9+kmgMq7O1jtvS4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=b2pNZTomPiPzsfiw9lU5tisXyxGMAUup6tThKPmGZ0XCR2srluzRuwL+qY2GaOj6I
 H2X6Nq7KG2HgZaSH6UyCAMyvke200s9sb/EaHHUZ3Y8hI2P1ms7KFkO0kPmBn7GKMI
 l97bT3hHfAJx5MGdAwpXeVfEI9J//yGcpKCJpluXUi/EuMAnbv5QTmFiNXCVIuj8JM
 LPDncU4XFhlWfOwmr5iCBdxyixudjlsYAFRVmInHydKFYy426/TpMAdnkkifzFUekX
 zxlTM7MIFgyfuOrFv8KQd62XbQCCbXdqPlAefzr1TsVQOG/8sfQ6S6VpDyMIk23+WQ
 hURFZcbTZY76Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6EB671AA375;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7BB0F3ABCE5;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sun Haoyu <shyliuli@aosc.io>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 056/117] linux-user: Make openat2() use -L for
 absolute paths
Date: Tue, 12 May 2026 23:53:58 +0300
Message-ID: <20260512205503.361097-56-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Sun Haoyu <shyliuli@aosc.io>

openat2() ignored the -L prefix and opened host files directly.
For example, openat2("/tmp/file") opened /tmp/file on the host, not
QEMU_LD_PREFIX/tmp/file like openat() does.

Fix this by using path() to rewrite absolute paths. Skip this
when RESOLVE_BENEATH or RESOLVE_IN_ROOT is set:
- RESOLVE_BENEATH rejects absolute paths anyway
- RESOLVE_IN_ROOT resolves relative to dirfd

Now openat() and openat2() work in the same way.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/3341

Signed-off-by: Sun Haoyu <shyliuli@aosc.io>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260317053827.25051-1-shyliuli@aosc.io
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit fa6dfcc373c244a767be04d236e0cdd075b80e69)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5441ae6cb5..0261f2fc5c 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8861,7 +8861,16 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
     if (fd > -2) {
         ret = get_errno(fd);
     } else {
-        ret = get_errno(safe_openat2(dirfd, pathname, &how,
+        const char *host_pathname = pathname;
+        if (pathname[0] == '/' &&
+            !(how.resolve & (RESOLVE_IN_ROOT | RESOLVE_BENEATH))) {
+            /*
+             * RESOLVE_BENEATH rejects absolute paths; RESOLVE_IN_ROOT
+             * resolves them relative to dirfd.
+             */
+            host_pathname = path(pathname);
+        }
+        ret = get_errno(safe_openat2(dirfd, host_pathname, &how,
                                      sizeof(struct open_how_ver0)));
     }
 
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index cd9ff709b8..a2470856be 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2773,7 +2773,12 @@ struct target_open_how_ver0 {
 #ifndef RESOLVE_NO_SYMLINKS
 #define RESOLVE_NO_SYMLINKS     0x04
 #endif
-
+#ifndef RESOLVE_BENEATH
+#define RESOLVE_BENEATH         0x08
+#endif
+#ifndef RESOLVE_IN_ROOT
+#define RESOLVE_IN_ROOT         0x10
+#endif
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
-- 
2.47.3


