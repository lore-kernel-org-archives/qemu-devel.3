Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33452C982D7
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 20:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7fDs-0001Mi-0Z; Fri, 18 Sep 2026 16:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDf-0001L7-27; Fri, 18 Sep 2026 16:30:04 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>)
 id 1x7fDd-0003E9-8f; Fri, 18 Sep 2026 16:30:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5E6436053B;
 Fri, 18 Sep 2026 20:30:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE7D1F000FF;
 Fri, 18 Sep 2026 20:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789763400;
 bh=Df2nNEkPeb+r6J6ucH1JvlVX0AQgSLBybIOjF2SuXKs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B1u88lClFGO8kCubF3hGXJtJ/bsagAhrzTPILbwzVIu7m5Gr0dNwIq2jEMKfdAAmU
 dQzX5FQP1m3a/lJrXMWZ6k2bmx+EuesjeV9KMwfKPbEmSKj5x4xkWRXlxPRjoH820P
 fqTV7HgKLUB1vddiENo5FVUH2Ou4ovSAwF9xMO3ZaGMZRYohvEqjzwnus9dNXmo9+y
 GFV5z8vyPUN7dwJl3t9PS5PDnxCpd1auC9ABH/L0YdhZbKVfd2/5MYbNIg2SUJO5NX
 /jCv3Btiz8R3kTc0yqzIcgocIhHOSa7TR83PZNPN611uL7KrUmfZYmC8pNQnYlu7zB
 dFlDWlvYRdrzw==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, Helge Deller <deller@gmx.de>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chao Liu <chao.liu@processmission.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PULL 3/4] linux-user: implement mlock2(2) syscall
Date: Fri, 18 Sep 2026 22:29:46 +0200
Message-ID: <20260918202947.5322-4-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260918202947.5322-1-deller@kernel.org>
References: <20260918202947.5322-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/syscall.c      | 9 +++++++++
 linux-user/syscall_defs.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index cfa68dfbdb..9f454502cb 100644
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
index e28853c93b..f5831a6bad 100644
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
2.54.0


