Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37BCCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 04:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wb9hv-0003hk-5W; Sun, 21 Jun 2026 00:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9hh-0003Es-4h
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:42 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wb9he-0005QS-BD
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 00:22:40 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43cce8288c7so1882308fac.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jun 2026 21:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1782015757; x=1782620557;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LF1bQobYkJrBkuHIRmk4nhGfTKYNQmhfMjM71uVjJpo=;
 b=pc5i3mvA4t5iAXqw6jhPLGPUnCsjYxtNN91KZxPLynhWD+F1NsiNSXHTiRGlI2faBo
 Ehtj4e8KioaoQ3o/3U5tAd1SroZfkPsCYC9pzdbA5ldUAKaSAg1hU1xJhaxsGlqj1TDp
 8b+huCkbTaL+FQcFObvsRWkUq6CPvZYmYEe5bNGC/SEJ/0YyYJfDT8xUxzHDqM7jEXCY
 z4o1VbzIC7q6JVrmtxGvCSbILRFkhDWN5m+4gfEK31EXE4DOLMPvYOQTQ3JwsuXsVl/Y
 eG5matZqjyV2JOuYzh5NKQQqi8jyz4U8wqtJ4nYIXX02glFZkmPBmSStdsZKAXrY+WOa
 JjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782015757; x=1782620557;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LF1bQobYkJrBkuHIRmk4nhGfTKYNQmhfMjM71uVjJpo=;
 b=HHP2joGLPi8BE0snxAuj1Xazo6v+gSNMyDCv3htqZXoLK7mGcDiN3EFI/7pcLCrPEs
 uwMjRV/KI0KhwWM401rbKkDAyNAdSh1VMqg+hAwmGKAa1zn8zJf+ftbzwGYtpIgqEYil
 TFdKwUqdx2YA8kegcdJDEfStaDhK6VIrdkEvBpwiKG7XrcdaieAY4CIXbQDEl4CJWoMq
 YvqguNsYOlfU2j3bnj+wReyyXPhLaSN2nKoTHIDaujls9sFmqYjhDgn0e2KVMZh/bOTy
 bTGl+njYP0TlGSM6D6W97Glrg2NYPptG9oJvOM50YC7nZaHLdByBwkpffG0P/7sURyW9
 8hbg==
X-Gm-Message-State: AOJu0YwnsUYQZuQ2pUZ6LT5YCWR8wH+aA3507lCUOT4Rfz9tlcQgj7tX
 xAxhaHcbL8vyrWZCXR4H+JRNYGhgT8NQVma5+JwV6GGQLMYOVTqUAqHuxK6dDl29syJ7QbdXA+i
 W5vYoVsDshA==
X-Gm-Gg: AfdE7cmPku2zTCj/pOay++Snq1BFWqsKO2GRdudIrWc7v3FG9fVp/ISpOyCjL2MN2+S
 Fet6HccXa4zip8W3Q80PuYXFDFnmUmCqxKCkbkN8QXOQUayy+gbIGBlTc5uGMO/+1TOmmu5PPDm
 voyD0oF4XxtmJUNKUyBhSb58sG4Twb5GnZqv2nMnicqQMmQARdCP5RmdZxiU2MGtrLXEN3N0YzB
 p9lxzUfSmg8MjfGEQm57cap9hR0jW+IdS2VRLADmxkokxp8/LeBpGtMeXaTZdt5cE72KAL/AeVw
 vBV5LIFGP0HygbP6LxOWhUreE00MT58+e7J/iqBw7w3GF/UcT9r1Ahcun/84qJkb+zUBfu8Snrj
 9dOoAmXuYd+9BOX34b88AlFChfVvEE2hLstp2IY1lDmn+VEE7vzvN1GBYNcg83lJ2B3EG+RxXts
 k=
X-Received: by 2002:a05:6820:200e:b0:6a0:c657:163e with SMTP id
 006d021491bc7-6a0d89badc8mr7634560eaf.50.1782015757188; 
 Sat, 20 Jun 2026 21:22:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a0e9f698ccsm2828648eaf.4.2026.06.20.21.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2026 21:22:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Sat, 20 Jun 2026 22:20:25 -0600
Subject: [PATCH v3 38/40] bsd-user: Add scheduler, cpuset, kmod, and misc
 syscall dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-misc-2026q2-v3-38-f6ce23ad8dda@bsdimp.com>
References: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
In-Reply-To: <20260620-misc-2026q2-v3-0-f6ce23ad8dda@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=21160; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=2zQvtn7mcZ2v9dzpXT9ias3aQJ8VKEAI6mnCVE+8Eag=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqN2aBcGu1wC5xnlzccRdQlTsiVKZif0x1J9hVW
 cUjsCh5BzOJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCajdmgQAKCRBsHNEofbAR
 ALinEADb4Ng7Xp+n5E/FFmEzlqy7vxeVdrFOBV/cWnAMwrN+0DCjE2KHaVIqmtrJbTZ7PdYNTWK
 IfcW713plI5bDI5b/O7UpN4jbVrKxIC8K4fUONwWVi9dy8fgYz2hmPMfcuk85tdYNqNoNh6DWB/
 CrXczp8lR+Dv6ZbzM470K07/CTcoyatI3E99gOt97ZfLG0mTY1N9Gya4uiXvsL0FcNAmRwo1AWB
 z1RDtXPAlULD4QYsGMhUjrUBXozSgxzAsQMFxBgJBOeQVBZfEmqR+aAPOvc/SpHV+KwWVNSua9A
 C6GF8o2SNUeNgC7nF8VPypZDdYFudEwspkVHEqKR8oUU9vKF//FtErNlFhFUEnJfbRErU3E1cRp
 PkVR9/Ix3UCHUkoZAx4jg4KFQtxqZqn0oxIhPJanIdLPMp/mAyJTtjYW0wlDA0rCGjNO82rMaiD
 voN4TFE/IorMkFJCS9yJZNWjFotNN7wQsf4VAGXFW4nGUUb+ZAmibbegiP2KvScfmfqfrHj1glT
 qTi0SD+M0JKPzpBeVO99ntgamC5a4jA/sUVWunDFu4utCMquesqiOe72UYbOj7G890PM0KQaNfr
 4XbRghICWT4Qr3W2+r9qww/d5in81X9N2PhURTtfqPZH2uTk5jvPJaSYqqtz9Z7ZYEjambIwa4A
 3XV4XZePey9P+5w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Wire up remaining system calls: sched_setparam, sched_getparam,
sched_setscheduler, sched_getscheduler, sched_get_priority_max,
sched_get_priority_min, sched_rr_get_interval, sched_yield,
cpuset, cpuset_setid, cpuset_getid, cpuset_getaffinity,
cpuset_setaffinity, modfnext, modfind, kldload, kldunload,
kldunloadf, kldfind, kldnext, kldstat, kldfirstmod, kldsym,
posix_fallocate, posix_openpt, getrandom, kenv, cap_rights_limit,
cap_ioctls_limit, cap_fcntls_limit, cap_enter, syscall, and
__syscall.

We also reshuffle a few system calls here to match the blitz branch
which adds some churn, but is the least bad way to deal with the issues.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Kyle Evans <kevans@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-syscall.c | 512 ++++++++++++++++++++++++++----------------
 1 file changed, 323 insertions(+), 189 deletions(-)

diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index a14efd3fd4..7e400c89bc 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -532,6 +532,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_closefrom(arg1);
         break;
 
+    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
+        ret = do_freebsd_close_range(arg1, arg2, arg3);
+        break;
+
     case TARGET_FREEBSD_NR_revoke: /* revoke(2) */
         ret = do_bsd_revoke(arg1);
         break;
@@ -696,6 +700,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_chflags(arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
+        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
+        break;
+
     case TARGET_FREEBSD_NR_lchflags: /* lchflags(2) */
         ret = do_bsd_lchflags(arg1, arg2);
         break;
@@ -740,6 +748,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_poll(arg1, arg2, arg3);
         break;
 
+    case TARGET_FREEBSD_NR_ppoll: /* ppoll(2) */
+        ret = do_freebsd_ppoll(env, arg1, arg2, arg3, arg4);
+        break;
+
     case TARGET_FREEBSD_NR_lseek: /* lseek(2) */
         ret = do_bsd_lseek(env, arg1, arg2, arg3, arg4, arg5);
         break;
@@ -766,14 +778,6 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_swapoff(arg1, arg2);
         break;
 
-    case TARGET_FREEBSD_NR_chflagsat: /* chflagsat(2) */
-        ret = do_bsd_chflagsat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_close_range: /* close_range(2) */
-        ret = do_freebsd_close_range(arg1, arg2, arg3);
-        break;
-
     case TARGET_FREEBSD_NR___realpathat:
         /* __realpathat(2) (XXX no realpathat()) */
         ret = do_freebsd_realpathat(arg1, arg2, arg3, arg4, arg5);
@@ -787,125 +791,12 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd___specialfd(arg1, arg2, arg3);
         break;
 
-        /*
-         * ioctl(2)
-         */
-    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
-        ret = do_bsd_ioctl(arg1, arg2, arg3);
-        break;
-
-        /*
-         * stat system calls
-         */
-    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
-        ret = do_freebsd11_stat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
-        ret = do_freebsd11_lstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
-        ret = do_freebsd11_fstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
-        ret = do_freebsd_fstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
-        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
-        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
-        ret = do_freebsd11_nstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
-        ret = do_freebsd11_nfstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
-        ret = do_freebsd11_nlstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
-        ret = do_freebsd_getfh(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
-        ret = do_freebsd_lgetfh(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
-        ret = do_freebsd_fhopen(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
-        ret = do_freebsd11_fhstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
-        ret = do_freebsd_fhstat(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
-        ret = do_freebsd11_fhstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
-        ret = do_freebsd_fhstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
-        ret = do_freebsd11_statfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
-        ret = do_freebsd_statfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
-        ret = do_freebsd11_fstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
-        ret = do_freebsd_fstatfs(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
-        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
-        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
-        ret = do_freebsd11_getdents(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
-        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
-        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
-        break;
-    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
-        ret = do_freebsd_fcntl(arg1, arg2, arg3);
-        break;
-
         /*
          * Memory management system calls.
          */
     case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
         ret = do_bsd_mmap(env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
-                          arg8);
+           arg8);
         break;
 
     case TARGET_FREEBSD_NR_munmap: /* munmap(2) */
@@ -952,17 +843,13 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_shm_open(arg1, arg2, arg3);
         break;
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
     case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
         ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);
         break;
-#endif
 
-#if defined(__FreeBSD_version) && __FreeBSD_version >= 1300049
     case TARGET_FREEBSD_NR_shm_rename: /* shm_rename(2) */
         ret = do_freebsd_shm_rename(arg1, arg2, arg3);
         break;
-#endif
 
     case TARGET_FREEBSD_NR_shm_unlink: /* shm_unlink(2) */
         ret = do_bsd_shm_unlink(arg1);
@@ -984,68 +871,10 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_bsd_shmdt(arg1);
         break;
 
-        /*
-         * System V Semaphores
-         */
-    case TARGET_FREEBSD_NR_semget: /* semget(2) */
-        ret = do_bsd_semget(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_semop: /* semop(2) */
-        ret = do_bsd_semop(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
-        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
-        break;
-    }
-
-        /*
-         * System V Messages
-         */
-    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
-        ret = do_bsd_msgctl(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
-        ret = do_bsd_msgget(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
-        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
-        break;
-
-    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
-        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
-        break;
-
     case TARGET_FREEBSD_NR_freebsd11_vadvise:
         ret = do_bsd_vadvise();
         break;
 
-        /*
-         * Misc
-         */
-    case TARGET_FREEBSD_NR_break:
-        ret = do_obreak(arg1);
-        break;
-
-    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
-        ret = do_bsd_quotactl(arg1, arg2, arg3);
-        break;
-
-    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
-        ret = do_bsd_reboot(arg1);
-        break;
-
-    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
-        ret = do_bsd_uuidgen(arg1, arg2);
-        break;
-
-    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
-        ret = do_bsd_getdtablesize();
-        break;
-
         /*
          * time related system calls.
          */
@@ -1133,10 +962,6 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_pselect(env, arg1, arg2, arg3, arg4, arg5, arg6);
         break;
 
-    case TARGET_FREEBSD_NR_ppoll: /* ppoll(2) */
-        ret = do_freebsd_ppoll(env, arg1, arg2, arg3, arg4);
-        break;
-
     case TARGET_FREEBSD_NR_kqueue: /* kqueue(2) */
         ret = do_freebsd_kqueue();
         break;
@@ -1350,6 +1175,119 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__umtx_op(arg1, arg2, arg3, arg4, arg5);
         break;
 
+        /*
+         * ioctl(2)
+         */
+    case TARGET_FREEBSD_NR_ioctl: /* ioctl(2) */
+        ret = do_bsd_ioctl(arg1, arg2, arg3);
+        break;
+
+        /*
+         * stat system calls
+         */
+    case TARGET_FREEBSD_NR_freebsd11_stat: /* stat(2) */
+        ret = do_freebsd11_stat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_lstat: /* lstat(2) */
+        ret = do_freebsd11_lstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstat: /* fstat(2) */
+        ret = do_freebsd11_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstat: /* fstat(2) */
+        ret = do_freebsd_fstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatat: /* fstatat(2) */
+        ret = do_freebsd11_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatat: /* fstatat(2) */
+        ret = do_freebsd_fstatat(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nstat: /* undocumented */
+        ret = do_freebsd11_nstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nfstat: /* undocumented */
+        ret = do_freebsd11_nfstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_nlstat: /* undocumented */
+        ret = do_freebsd11_nlstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getfh: /* getfh(2) */
+        ret = do_freebsd_getfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_lgetfh: /* lgetfh(2) */
+        ret = do_freebsd_lgetfh(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhopen: /* fhopen(2) */
+        ret = do_freebsd_fhopen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstat: /* fhstat(2) */
+        ret = do_freebsd11_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstat: /* fhstat(2) */
+        ret = do_freebsd_fhstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd11_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fhstatfs: /* fhstatfs(2) */
+        ret = do_freebsd_fhstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_statfs: /* statfs(2) */
+        ret = do_freebsd11_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_statfs: /* statfs(2) */
+        ret = do_freebsd_statfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd11_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_fstatfs: /* fstatfs(2) */
+        ret = do_freebsd_fstatfs(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd11_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getfsstat: /* getfsstat(2) */
+        ret = do_freebsd_getfsstat(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdents: /* getdents(2) */
+        ret = do_freebsd11_getdents(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_freebsd11_getdirentries: /* getdirentries(2) */
+        ret = do_freebsd11_getdirentries(arg1, arg2, arg3, arg4);
+        break;
+    case TARGET_FREEBSD_NR_fcntl: /* fcntl(2) */
+        ret = do_freebsd_fcntl(arg1, arg2, arg3);
+        break;
+
         /*
          * sys{ctl, arch, call}
          */
@@ -1365,8 +1303,14 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd_sysarch(env, arg1, arg2);
         break;
 
+    case TARGET_FREEBSD_NR_syscall: /* syscall(2) */
+    case TARGET_FREEBSD_NR___syscall: /* __syscall(2) */
+        ret = do_freebsd_syscall(env, arg1 & 0xffff, arg2, arg3, arg4,
+                arg5, arg6, arg7, arg8, 0);
+        break;
+
         /*
-         * extended attributes and ACL system calls
+         * extended attributes system calls
          */
     case TARGET_FREEBSD_NR_extattrctl: /* extattrctl() */
         ret = do_freebsd_extattrctl(arg1, arg2, arg3, arg4, arg5);
@@ -1468,6 +1412,196 @@ static abi_long freebsd_syscall(CPUArchState *env, int num, abi_long arg1,
         ret = do_freebsd__acl_set_link(arg1, arg2, arg3);
         break;
 
+        /*
+         * System V Semaphores
+         */
+    case TARGET_FREEBSD_NR_semget: /* semget(2) */
+        ret = do_bsd_semget(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_semop: /* semop(2) */
+        ret = do_bsd_semop(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR___semctl: { /* __semctl() undocumented */
+        ret = do_bsd___semctl(arg1, arg2, arg3, arg4);
+        break;
+    }
+
+        /*
+         * System V Messages
+         */
+    case TARGET_FREEBSD_NR_msgctl: /* msgctl(2) */
+        ret = do_bsd_msgctl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_msgget: /* msgget(2) */
+        ret = do_bsd_msgget(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_msgsnd: /* msgsnd(2) */
+        ret = do_bsd_msgsnd(arg1, arg2, arg3, arg4);
+        break;
+
+    case TARGET_FREEBSD_NR_msgrcv: /* msgrcv(2) */
+        ret = do_bsd_msgrcv(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+        /*
+         * FreeBSD scheduler control
+         */
+    case TARGET_FREEBSD_NR_sched_setparam: /* sched_setparam(2) */
+        ret = do_freebsd_sched_setparam(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_getparam: /* sched_getparam(2) */
+        ret = do_freebsd_sched_getparam(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_setscheduler: /* sched_setscheduler(2) */
+        ret = do_freebsd_sched_setscheduler(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_getscheduler: /* sched_getscheduler(2) */
+        ret = do_freebsd_sched_getscheduler(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_get_priority_max: /* sched_get_priority_max(2)*/
+        ret = do_bsd_sched_get_priority_max(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_get_priority_min: /* sched_get_priority_min(2)*/
+        ret = do_bsd_sched_get_priority_min(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_rr_get_interval: /* sched_rr_get_interval(2) */
+        ret = do_freebsd_sched_rr_get_interval(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_sched_yield: /* sched_yield(2)*/
+        ret = do_bsd_sched_yield();
+        break;
+
+
+        /*
+         * FreeBSD CPU affinity sets management
+         */
+    case TARGET_FREEBSD_NR_cpuset: /* cpuset(2) */
+        ret = do_freebsd_cpuset(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_setid: /* cpuset_setid(2) */
+        ret = do_freebsd_cpuset_setid(env, arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_getid: /* cpuset_getid(2) */
+        ret = do_freebsd_cpuset_getid(arg1, arg2, arg3, arg4, arg5);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_getaffinity: /* cpuset_getaffinity(2) */
+        ret = do_freebsd_cpuset_getaffinity(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_cpuset_setaffinity: /* cpuset_setaffinity(2) */
+        ret = do_freebsd_cpuset_setaffinity(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+        /*
+         * FreeBSD kernel module
+         */
+    case TARGET_FREEBSD_NR_modfnext: /* modfnext(2) */
+        ret = do_freebsd_modfnext(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_modfind: /* modfind(2) */
+        ret = do_freebsd_modfind(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldload: /* kldload(2) */
+        ret = do_freebsd_kldload(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldunload: /* kldunload(2) */
+        ret = do_freebsd_kldunload(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldunloadf: /* kldunloadf(2) */
+        ret = do_freebsd_kldunloadf(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kldfind: /* kldfind(2) */
+        ret = do_freebsd_kldfind(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldnext: /* kldnext(2) */
+        ret = do_freebsd_kldnext(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldstat: /* kldstat(2) */
+        ret = do_freebsd_kldstat(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_kldfirstmod: /* kldfirstmod(2) */
+        ret = do_freebsd_kldfirstmod(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_kldsym: /* kldsym(2) */
+        ret = do_freebsd_kldsym(arg1, arg2, arg3);
+        break;
+
+        /*
+         * FreeBSD additional posix support
+         */
+    case TARGET_FREEBSD_NR_posix_fallocate: /* posix_fallocate(2) */
+        ret = do_freebsd_posix_fallocate(arg1, arg2, arg3, arg4, arg5, arg6);
+        break;
+
+    case TARGET_FREEBSD_NR_posix_openpt: /* posix_openpt(2) */
+        ret = do_freebsd_posix_openpt(arg1);
+        break;
+
+        /*
+         * Misc
+         */
+    case TARGET_FREEBSD_NR_quotactl: /* quotactl(2) */
+        ret = do_bsd_quotactl(arg1, arg2, arg3);
+        break;
+
+    case TARGET_FREEBSD_NR_reboot: /* reboot(2) */
+        ret = do_bsd_reboot(arg1);
+        break;
+
+    case TARGET_FREEBSD_NR_uuidgen: /* uuidgen(2) */
+        ret = do_bsd_uuidgen(arg1, arg2);
+        break;
+
+    case TARGET_FREEBSD_NR_getdtablesize: /* getdtablesize(2) */
+        ret = do_bsd_getdtablesize();
+        break;
+
+    case TARGET_FREEBSD_NR_break:
+        ret = do_obreak(arg1);
+        break;
+
+#if defined(CONFIG_GETRANDOM)
+    case TARGET_FREEBSD_NR_getrandom:
+        ret = do_freebsd_getrandom(arg1, arg2, arg3);
+        break;
+#endif
+    case TARGET_FREEBSD_NR_kenv:
+        ret = do_freebsd_kenv(arg1, arg2, arg3, arg4);
+        break;
+
+    /* XXX */
+    case TARGET_FREEBSD_NR_cap_rights_limit:
+    case TARGET_FREEBSD_NR_cap_ioctls_limit:
+    case TARGET_FREEBSD_NR_cap_fcntls_limit:
+        ret = -TARGET_EINVAL;
+        break;
+    case TARGET_FREEBSD_NR_cap_enter:
+        ret = 0;
+        break;
+
     default:
         qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
         ret = -TARGET_ENOSYS;

-- 
2.52.0


