Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A03C9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 07:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAjJ4-0001Mh-Eb; Sun, 27 Sep 2026 03:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHf-0008W3-Rd; Sun, 27 Sep 2026 03:26:52 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAjHe-0005P8-9T; Sun, 27 Sep 2026 03:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790494004; bh=ypQX5MOKyWsP/BHUAYVNeKD6LMu8cG4KoINOsRdECH0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ooigIeINwMUfhrEp5jW39eyyOMSj4DUI0MWWS7M3i7t3xjnGIjbNymlueCuPyCQ4P
 blSfdIIJ4ck3G2QktQRCYMQt5gnJNrsh3Dnq6dRR4J3M10umEflil31j922n4NXiIj
 fj1d2EzfXCrVZCS9c20dj3ut8dAsFAqGZdop2xezu6LA8jFf/VznCvk4HBAgjS7FMZ
 6pC4jcmYMhKtLx4nBDRMM9wShC860B7WT+eqaj6wzuO7SHpCd+xbsjC3WgKAZjeknI
 E1nAgJsf6Iek11oGCKirxQl38COX8kTlZasLtDWusNARUSzHUezX17gG6u5rRomdXR
 7nRhef/FZU5sA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B9FBD1D8AB7;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A4308432049;
 Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5C53E5E61D; Sun, 27 Sep 2026 10:26:44 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Morrell <mmorrell@tachyum.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.14 v2 53/72] linux-user: implement mlock2(2) syscall
Date: Sun, 27 Sep 2026 10:25:45 +0300
Message-ID: <20260927072622.93656-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
References: <qemu-stable-10.0.14-20260927020824@cover.tls.msk.ru>
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

From: Michael Morrell <mmorrell@tachyum.com>

TARGET_NR_mlock2 is defined for every target's syscall table (it has
been available on all Linux architectures since it was added in
kernel 4.4), and linux-user/strace.list already has an entry for it,
but linux-user/syscall.c has no case handler for it. A guest mlock2()
call therefore falls through to the default case and gets -ENOSYS
instead of being emulated, on every target.

mlock2() differs from mlock() only by a third `flags` argument
(MLOCK_ONFAULT). Add TARGET_MLOCK_ONFAULT and a case that validates
the flags argument and forwards to the host mlock2(), mirroring the
existing TARGET_NR_mlock case immediately above it.

Signed-off-by: Michael Morrell <mmorrell@tachyum.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 30fa3eb41f85e114765e8476dc9a32a890b2e78f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 5e742f55b82..111f97bd5eb 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10941,6 +10941,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_mlock:
         return get_errno(mlock(g2h(cpu, arg1), arg2));
 #endif
+#ifdef TARGET_NR_mlock2
+    case TARGET_NR_mlock2:
+        if (arg3 & ~TARGET_MLOCK_ONFAULT) {
+            return -TARGET_EINVAL;
+        }
+        return get_errno(mlock2(g2h(cpu, arg1), arg2,
+                                 (arg3 & TARGET_MLOCK_ONFAULT) ?
+                                 MLOCK_ONFAULT : 0));
+#endif
 #ifdef TARGET_NR_munlock
     case TARGET_NR_munlock:
         return get_errno(munlock(g2h(cpu, arg1), arg2));
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 4d610490c98..4150e191577 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2792,6 +2792,10 @@ struct target_mount_attr_ver0 {
 #ifndef RESOLVE_IN_ROOT
 #define RESOLVE_IN_ROOT         0x10
 #endif
+
+/* flags for mlock2() */
+#define TARGET_MLOCK_ONFAULT    0x01
+
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
     defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) || \
-- 
2.47.3


