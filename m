Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCF8CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuDE-0005AT-Jq; Tue, 12 May 2026 17:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCL-0002jN-2G; Tue, 12 May 2026 16:59:27 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuCI-00059I-16; Tue, 12 May 2026 16:59:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619276; bh=VFlagQokGgpz+0rC+O44k+NQdOhi3YbBOoMVcjIcjZ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DVckJj4c2oMmOMw2BkLYrHPgxwZSPe+cxsuN2m8QE++vZ+Iu2uUqEODlvWCL81M7N
 EqEQmwXW77dcD70FFxTUiLACqFLrcf+9vHV9+drTJef96MsJ1bdrsqw9qzGy8BiQNq
 36pjRgBaD3s9maYOBafALQlMf1vH+/dqPsbIIP+TYv/FBvHPFZnKWNjo43wXs9qsSR
 aOG5OTS6oiiaTBxOTi/r5S5rvGoiyo0fUdrRiLgzZnMle9lYabzmLRlF20cxuhHOqS
 3gzhN/ox9JItZOUu8Qz7Id9hipL9ipn1PE0TkyCMEsV5TUeWK2KwHlSShzqjtC1HFj
 NiF7WFy3pKE8g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4D0141AA2FB;
 Tue, 12 May 2026 23:54:36 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5A2D23ABC6C;
 Tue, 12 May 2026 23:54:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Sun Haoyu <shyliuli@aosc.io>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 047/107] linux-user: Make openat2() use -L for
 absolute paths
Date: Tue, 12 May 2026 23:53:34 +0300
Message-ID: <20260512205437.360850-47-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
index 44675076ca..f2c8037356 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8723,7 +8723,16 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
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
index 5d22759992..b5a2ad3b2d 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2771,7 +2771,12 @@ struct target_open_how_ver0 {
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


