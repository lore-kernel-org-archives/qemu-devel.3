Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C793606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 20:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=dIG9qH6m
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xU8SI-0001im-3C; Thu, 19 Nov 2026 15:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pobrn@protonmail.com>)
 id 1xU7ZJ-0001Ig-PJ
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:13:13 -0500
Received: from mail-08.mail-europe.com ([57.129.93.249])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pobrn@protonmail.com>)
 id 1xU7ZI-0000v7-2k
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 14:13:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1795115577; x=1795374777;
 bh=RmGXA9QjuDRHR47UR9iZSi2k5lxcbolX27KxaFTUShw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=dIG9qH6mBa5YMzENJ7A24ag0Tg4GGHjniaMTlnrljZVPSe/xGi/Y/gEbNWpXXzCBz
 tAuNy76/nScPzz6wGmT0WD+ahu1MgoY1K17piQOmyayeCjn4Wqz2tALKdVfOb3EIu9
 oIkZ/8tQF5mzxnrp00aa4WrFwiTKsySPDalog+BKR5xhKPtMPaaKAVywCBi9SG8pRv
 tibFZgj8rPfef2tJrotWSfj3VIB1mUYfIGRqTxozsOgz1JClocq4LYM2k17X9PuPx4
 Fs0QfqQzYRnAkMFFKFdRpORsDPF3yMGW75Hmk/IAmpo7q/Q9dPTNFvm/1zETUnxgNt
 HBQYVAPEf++bQ==
Date: Thu, 19 Nov 2026 19:12:53 +0000
To: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
From: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc: qemu-stable@nongnu.org
Subject: [RFC PATCH v1] linux-user: do not emulate PI futexes given endianness
 mismatch
Message-ID: <20261119191247.391446-1-pobrn@protonmail.com>
Feedback-ID: 20568564:user:proton
X-Pm-Message-ID: 88e942f7f8f7e6e7ca0a2963c2040c7c8317b72c
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=57.129.93.249; envelope-from=pobrn@protonmail.com;
 helo=mail-08.mail-europe.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 19 Nov 2026 15:09:58 -0500
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
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

For PI futexes, the futex word is expected to contain the thread id in nati=
ve
byte order. And failing to emulate that leads to issues as e.g. glibc does
not expect `ESRCH` to be returned from a `FUTEX_LOCK_PI` operation.

If the mutex is set to be "robust", then this is detected as unrecoverable
failure and glibc aborts (since a robust mutex should've been unlocked by
the kernel when the owner dies):

  Fatal glibc error: pthread_mutex_lock.c:450 (__pthread_mutex_lock_full): =
assertion failed: e !=3D ESRCH || !robust
  qemu: uncaught target signal 6 (Aborted) - core dumped
  Aborted (core dumped)

Since `FUTEX_LOCK_PI{,2}` cannot be easily emulated when the host and targe=
t
endianness differs, do not handle them, and return `ENOSYS`. This allows
e.g. glibc to detect that they do not work and handle things accordingly.

Link: https://gitlab.com/qemu-project/qemu/-/work_items/4911
Cc: qemu-stable@nongnu.org
Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 linux-user/syscall.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 2fc61b3eab..c5fbd30e28 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8243,6 +8243,7 @@ static int do_futex(CPUState *cpu, bool time64, targe=
t_ulong uaddr,
     case FUTEX_WAIT_BITSET:
         val =3D tswap32(val);
         break;
+#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
     case FUTEX_WAIT_REQUEUE_PI:
         val =3D tswap32(val);
         haddr2 =3D g2h(cpu, uaddr2);
@@ -8250,10 +8251,11 @@ static int do_futex(CPUState *cpu, bool time64, tar=
get_ulong uaddr,
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
         timeout =3D 0;
         break;
     case FUTEX_FD:
@@ -8261,7 +8263,9 @@ static int do_futex(CPUState *cpu, bool time64, targe=
t_ulong uaddr,
         timeout =3D 0;
         break;
     case FUTEX_CMP_REQUEUE:
+#if HOST_BIG_ENDIAN =3D=3D TARGET_BIG_ENDIAN
     case FUTEX_CMP_REQUEUE_PI:
+#endif
         val3 =3D tswap32(val3);
         /* fall through */
     case FUTEX_REQUEUE:
--=20
2.56.1



