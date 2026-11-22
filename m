Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0932E606A320
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Nov 2026 16:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G6qv9FZ2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVABk-0001ly-5O; Sun, 22 Nov 2026 11:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVABh-0001i4-MJ
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:13:09 -0500
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1xVABf-0005ZF-HI
 for qemu-devel@nongnu.org; Sun, 22 Nov 2026 11:13:09 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 07911447C1;
 Sun, 22 Nov 2026 16:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B11641F000C6;
 Sun, 22 Nov 2026 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795363984;
 bh=k8vE6O3KQczNeXFcGY1Wdvezv/xAsl4Ectn/43xDpEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G6qv9FZ2OrKxigfBf3qBWPUyOLMuBbwO2agqgc3pO7YWQeDer5u6eVcl5Kn9Pm2+t
 J/IZHj5yhWx0q1I/DQKZMilVVwpsnYNxjJ/A2udzDOPO7Af7lFhxoOSMBik5APaEcO
 Y2RMimnM1RhG26tb1iNj4/n8LaLGBGTwynJ1B7dk13Qd3oYAiExq8yFWY71+ojngeX
 jd32UnonSEUKutejv5Ua2ahi23N5CW9jo5abm0Zwqfqb6/oRB/8yZyY4jfbRBEPWCJ
 NkMloreSiwRfLLDxDI7rDi8+9FewcTrLbN2SisRGCiKvtC3wOTleU3iA7Y5Xna8CqD
 AE7WPVmP08TLg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/1] linux-user: do not emulate PI futexes given endianness
 mismatch
Date: Sun, 22 Nov 2026 17:13:00 +0100
Message-ID: <20261122161300.6165-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261122161300.6165-1-deller@kernel.org>
References: <20261122161300.6165-1-deller@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Barnabás Pőcze <pobrn@protonmail.com>

For PI futexes, the futex word is expected to contain the thread id in native
byte order. And failing to emulate that leads to issues as e.g. glibc does
not expect `ESRCH` to be returned from a `FUTEX_LOCK_PI` operation.

If the mutex is set to be "robust", then this is detected as unrecoverable
failure and glibc aborts (since a robust mutex should've been unlocked by
the kernel when the owner dies):

  Fatal glibc error: pthread_mutex_lock.c:450 (__pthread_mutex_lock_full): assertion failed: e != ESRCH || !robust
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)

Since `FUTEX_LOCK_PI{,2}` cannot be easily emulated when the host and target
endianness differs, do not handle them, and return `ENOSYS`. This allows
e.g. glibc to detect that they do not work and handle things accordingly.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4911
Cc: qemu-stable@nongnu.org
Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Tested-by: Helge Deller <deller@gmx.de> # on 32-bit parisc big endian guest
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 350e69e2d0..d2a6cfb454 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8243,6 +8243,7 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
     case FUTEX_WAIT_BITSET:
         val = tswap32(val);
         break;
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN
     case FUTEX_WAIT_REQUEUE_PI:
         val = tswap32(val);
         haddr2 = g2h(cpu, uaddr2);
@@ -8250,10 +8251,11 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
     case FUTEX_LOCK_PI:
     case FUTEX_LOCK_PI2:
         break;
-    case FUTEX_WAKE:
-    case FUTEX_WAKE_BITSET:
     case FUTEX_TRYLOCK_PI:
     case FUTEX_UNLOCK_PI:
+#endif
+    case FUTEX_WAKE:
+    case FUTEX_WAKE_BITSET:
         timeout = 0;
         break;
     case FUTEX_FD:
@@ -8261,7 +8263,9 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
         timeout = 0;
         break;
     case FUTEX_CMP_REQUEUE:
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN
     case FUTEX_CMP_REQUEUE_PI:
+#endif
         val3 = tswap32(val3);
         /* fall through */
     case FUTEX_REQUEUE:
-- 
2.54.0


