Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5EFC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 23:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6G9r-0007Y6-7V; Mon, 14 Sep 2026 19:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x6G9o-0007Xy-UE
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:32:16 -0400
Received: from mxb.tachyum.com ([66.160.133.171])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mmorrell@tachyum.com>)
 id 1x6G9n-00025E-Be
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 19:32:16 -0400
Received: from mxb.tachyum.com (localhost.localdomain [127.0.0.1])
 by mxb.tachyum.com (Proxmox) with ESMTP id 98E428260C;
 Mon, 14 Sep 2026 16:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tachyum.com; h=
 cc:cc:content-transfer-encoding:date:from:from:message-id
 :mime-version:reply-to:subject:subject:to:to; s=dkim; bh=Kee1mXk
 IZKNGQPoODxsF5c/W0UksbmrWj49O2TW8cWg=; b=TVotqu5Lz99+WXgrHXQAobb
 afujl+SDjTQqH/tTvDaU7dRwGub4qAmgyV2jsRsp5MEbjpXP/YdCIx5/+PpOFMBg
 vn2TkSE26WPsYbojvwh2KbvB8NRLYir4y/WAsR9n05Vzm4bcF5KBbOBDh65kVxdh
 ZUtoDbC/lJ9ENbttPVnG/mgcP9xG/oLAQtN42aqaAMI3SNsLoBW2jeneBksqvzFI
 JueHsKn6NxvA6BFDhQxcdLqmiit40cp+JUnc9nT5ghw786+DHzgf2Hghnyjczi/b
 cz9bwjnnSnbZgcaSSy/Hz5gbwyQe+eNUpNOAlQF/V1c043ok0r57TQes0B37w1g=
 =
From: Michael Morrell <mmorrell@tachyum.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Morrell <mmorrell@tachyum.com>
Subject: [PATCH v2] linux-user: implement mlock2(2) syscall
Date: Mon, 14 Sep 2026 16:32:04 -0700
Message-ID: <20260914233204.314810-1-mmorrell@tachyum.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.160.133.171; envelope-from=mmorrell@tachyum.com;
 helo=mxb.tachyum.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
2.43.0



