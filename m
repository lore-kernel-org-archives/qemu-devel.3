Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EA3C5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThj-0005ne-Oj; Tue, 18 Aug 2026 19:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThh-0005e7-SX
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:49 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThe-0005L4-Sq
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:49 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-495b27007d0so383718b6e.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097526; x=1787702326;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JJ7lZQiWgQ297FIda9/iIZxdLWWnVxz/oXcAsyVeWMU=;
 b=cnYyERBI+2NvSUkQnb9+THvhSvX2uQ4G4CL7iBdsEpq+NS/cktxMI93sdiWj8lKSRK
 U16tJK4xSTB0MXG9GiAGdF2dX720zEjPYdwLRtA15GUoGQ2SwkPHrgl+Tf0opaMX1Wgx
 bPoirEguhI+9Cst9BHeZoXO1JbaWCj9lEls3S8WgZxcSLwQg6wLt7CmwebBocMzM3RLM
 oxPRFo3QYLLtz5figDdmBO3QmdtzgGX29qEoI3DOgJISOphFILxZGpg8yNmCoqFMC8gp
 0AqGifhYuV8oFvK+LEK3OUa0kBeVU2iQHSbZmlx74cVFPjGg3KItnC+TLF0vNlfHIW0S
 gXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097526; x=1787702326;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JJ7lZQiWgQ297FIda9/iIZxdLWWnVxz/oXcAsyVeWMU=;
 b=eWrGE8eVMYGlpNczvfwl5VyTwrmI3vDdBLDiNqRA7aJrXZxT6tig8ADa5Ooz/9C0c9
 3Gl3J6SS4wDkbtiRVWDg5Nuby+v3uy26ICU1R4iprXzYS7oN4kB8IDz6F954UK/q7Y9K
 uP/Xwx9w3cpkUPz3qRCK9EudQ3jprUuDN80Ym9Lh/7KUhCJO3lMJPo0MM7pHlCumHANa
 UZH2nhPBvxaqZSCouUtfdolKNTZPWswwkv+ddV1gD4x1Cjqz50oylTrwtcvL6V7stcsR
 CVDLbxauVU4rtjxJfJaBQ5HIuPPPO29EebZF7mc3a1EL3C/HBluwBhMT311M4FyOAFZP
 fpNA==
X-Gm-Message-State: AOJu0YxjfnweGscsxC8bZpEETgOw19puqNvCNBGqimW1R7gWet5nThhg
 wkLNYDYXBo+oXR3jBSx8aaiGly339iVjYe9SMgJ8iBvJQj/Isx1qMmtEnQfCPPXDw0c=
X-Gm-Gg: AR+sD138BWSgsEPAD2nUZYmlIv2/Svh6hx+yBrb00LVOBKDkBiSzMgtdvPyZbvoeBkE
 jFj/Hm6aYQOMWvlBCTLuz5ssEmte5bKs/kld7ta6b+MUj2YrErmH50gQwaGMjfSeOKHgdtvpUjg
 e0HUs+wncLy7OAELF+K7WOKyYhp5YwTpF8mPACXjm2bRvYJue6eok0m4txI9Zo/ZpnvVpfec4qv
 hDeMBk/inax0mQ/K7ngEgpiBh8Ojitl3Vl+GkGDym2utyoF7jeypXFjFtskEfxHm4PbALaOhBCX
 ERRO/ArtnkNb7knz+24aNDvEy3NAXH4dJqzj4PC20ARxkTlmavgzxFVMWFd6Jnx00jSneGlehlS
 gX+1PeKLH5JyjbDHQKyHMN83mIlcspawkAP7zbh4DEpVNJ6J8bDJ1/+k/Epq16/ypRUBPO7bP1Z
 QqVSFzg7cumfkMYuCLrSZHJn2C7zdkaeEId2rUAnr9pHr6LoO2oaR4hnuzEA==
X-Received: by 2002:a05:6808:14c3:b0:4a4:88ab:126f with SMTP id
 5614622812f47-4b2bcc22492mr316307b6e.21.1787097525578; 
 Tue, 18 Aug 2026 16:58:45 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:44 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:31 -0600
Subject: [PATCH v4 38/40] bsd-user: Add scheduler, cpuset, kmod, and misc
 syscall dispatch
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-38-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Kyle Evans <kevans@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=21220; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=vkgsrOokvMjouYq9sezU8+xmgEG6sjF6PgIvnbgZANo=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFbY9k+il7pTTQ/458NnZwtBi/WXvJvAQ9jG
 84K/AfSsxyJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxWxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQB+9Q/8Cij258IlPbAWz5CO3Y4KuI+jJC/myfS
 CZkaFZM8gbLXaVJWl3I93VL9xzWnkqBU7I2SJJuR1gHKssa8m7n6rJiDaZzTEfZulkk/kZ91Wuz
 Iy596o0aB/CttWghXFgOYHt6nEa75pLTCDUVI3Ob855MAcSsOG3gGgS4CNeEPk8ZJ8HyvxBNIdI
 CP69PpqosCjPU/9mw0vBQ6fL96MdmI7HcsPSayanWS3jNkiNraeZDJa+AK+aq70xIO9TOErMUGM
 QtbHLHqV0c94Rh3AE6Qy5JYsY455m/wmnh2OjmyCaCnb5cSLJ0O06Oj9/16EB0L3QAkZ+zAGfva
 t33PRBGUOdPyPy5gKw3u01CEH48rwJQAQPzsMtWDWTm5Gu4MIS63BhYpJXSuq/sCdcoQqySftBS
 IIp79GsrC+Yv9B9+F4E494nLqIWV6ijaP0j3dndV9PIx7tlkUl7zM8GWg8ufQXPOAL9zT5ggNwp
 o6w6WddMA2Zh8kViCLjVII3ghjPBmCVO7x2gKTnNFAKw+/2VvGZDemZi2ehiZgf173Nzt7+3Ivg
 L0utLcQ4o1CG0bwAzOt8NGNIHqvw1jMXlAwNBLveeSm381i0QKdjwrn5KVpZuUFWp+ShE+W91he
 iTOA1Vqp8r8y9g/fGfB23mE6q2AUF2E/jEtHGC6SZ+xCaUINRgjo=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
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
2.55.0


