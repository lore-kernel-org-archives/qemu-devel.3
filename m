Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F456606A324
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=S8K9nE5D
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp9F-0003hZ-PN; Fri, 27 Nov 2026 01:09:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp9A-00037S-7m; Fri, 27 Nov 2026 01:09:24 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp98-00025F-Am; Fri, 27 Nov 2026 01:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=l5yYPu3Gsgc8pchBDhsQXyE9AXXW2c9CB5FrLb4I1rk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=S8K9nE5D3H888rB2u5RsXqTuUEImLXGrtVQQpvZaNjp68WhBtP2EPw3b9ApeXOTQo
 LIDb0tVO/L07GbvA1w94cv1iC0TLSOa+Alvj5qTBys03tPFF5TxrNZDnNod6rSuE4X
 wesPN8gpBbsp+c7AULU108xEOcSauW5yeV+fGFunwMlC4dta6xobyydgUQ9dclf72m
 qqER6Nz7l6xZOsBnks6awiXLtMp+Sb1VvBsEosSyDRuY/3XSi9r4Iz/k3tsTvqWCKd
 8fZN1FnryejvdPrNvNkXw280rzx8C7JQ2r9i6B6TKLUcVtE6et6HQzhrwPNNGV5r52
 JJp2tbrp/Ml1w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5C6DB1EA374;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 59E3D46999F;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2B857CF336; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 130/152] linux-user: do not emulate PI futexes
 given endianness mismatch
Date: Fri, 27 Nov 2026 08:54:28 +0300
Message-ID: <20261127055709.39630-67-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
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
(cherry picked from commit 31b27c0b645e8c596e69027d714ce075f1374792)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 099d3aea84b..2837835dd26 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8230,6 +8230,7 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
     case FUTEX_WAIT_BITSET:
         val = tswap32(val);
         break;
+#if HOST_BIG_ENDIAN == TARGET_BIG_ENDIAN
     case FUTEX_WAIT_REQUEUE_PI:
         val = tswap32(val);
         haddr2 = g2h(cpu, uaddr2);
@@ -8237,10 +8238,11 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
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
@@ -8248,7 +8250,9 @@ static int do_futex(CPUState *cpu, bool time64, target_ulong uaddr,
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
2.47.3


