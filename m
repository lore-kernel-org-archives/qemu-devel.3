Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E139FC9830E
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 10:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAmS5-0006uy-Ui; Sun, 27 Sep 2026 06:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRY-00061r-Cv; Sun, 27 Sep 2026 06:49:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xAmRV-00012V-JP; Sun, 27 Sep 2026 06:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1790506130; bh=dECgW9otecPky/bmaNTo17SD26WayRMcNCVXGgJ5SJ4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ErEDmA+CMjAPN/UYYRjI/Fx5OvYz+qGs8zFfP22iMQWtxqXQulqrSIw84v+uH7l2Y
 W2zHzcojkqG3VaszjYWcBCr/dexAzMD7NH7PREq+BZFDZS0iZ1Cg5T/9IgCrZIA/4o
 VWXZ7wyr44VAl/sSyWhwveurspD0iWZq8gxfzBUYu1HQLkxezIHN8/PS3UQNapbteV
 WvmCOykHEhaNVDkqZ5K3vHI3ei7avHesiJFF4U8TiX57Aie1XRM3J6Dk9IuafKUr6f
 Pb7ZySevEIXZaKXwXKH4cuw50782HUFPHnqIFx4ZeqLXVCizJVFV65P4537bDTbos4
 7MC3iVKckGDeg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8E3411D8B60;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8978D432167;
 Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 5C04A5E778; Sun, 27 Sep 2026 13:48:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Morrell <mmorrell@tachyum.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.2 v2 65/92] linux-user: implement mlock2(2) syscall
Date: Sun, 27 Sep 2026 13:47:41 +0300
Message-ID: <20260927104821.196183-9-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
References: <qemu-stable-11.1.2-20260927121932@cover.tls.msk.ru>
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
index cfa68dfbdb9..9f454502cb6 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -11230,6 +11230,15 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
index e28853c93b0..f5831a6badd 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -2795,6 +2795,10 @@ struct target_mount_attr_ver0 {
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


