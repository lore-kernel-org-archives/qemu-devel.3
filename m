Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 280F0CD484A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 14:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slr83-0004Do-Lb; Wed, 04 Sep 2024 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7y-0003mI-HT
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:59 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slr7s-0005GR-UM
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 10:36:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-374c4d4f219so2497826f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725460611; x=1726065411; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gBdilirGQOnDNskTHwPE5qEPDs4oOuNzRzRg1LZf9JI=;
 b=Ti2OGmBSZ1rDMdvtgbJoocqXwMeKxKPJ0c0C9o0NMQ6MeteK7yMsQG47vF07vdEklG
 3OdHLwJh4VyfEUbD0+LDccIdUjVDeqiQf4JaqlBtJqmBOa0ubDcQH2lrlektOFFjj5p7
 QZ7bIDkBwHw4JBCdsAY84mXzUQQa/3cqRHQp6KRSm1d8R5JDcB13B4iBbq1jDWlMMgfU
 RPj80nSpI6z9XAOUkGi+T/5zMry8HExx2ktHZy46O+fbDxOvzIZLcUqhGxIiNgbEz443
 dvWg0FrPG55z3DFrfn0JJTGl7pCT62onua2FBGOkPzJEq0Ym7UNK8L1mw5fHUoODzLSh
 YD9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725460611; x=1726065411;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gBdilirGQOnDNskTHwPE5qEPDs4oOuNzRzRg1LZf9JI=;
 b=oIOdFzpaip72373CTEb4Gb3wytOU7ltjbL6xv1mm45+okxdBxYkrQJsMwnB0lfqXVi
 DN6F60g/U/kXFSMCQ7sx023AIGsxxARdHuiukbsAdwxvDZm2YBvE/gQD0JyYCq8eo7Re
 atabrtDUkunDS821l6wII9ghDFd5i7YHPf7iF5xcbP69SSud1lujpsJikaYscD3GAneE
 CPcTScLOULAHKHaW6DNKpyw6eRjgWK24QGh5rRzguG6SorYc+yM9hnpjrnCGPk6yke1E
 8EhxyyeQH/TB6x8YtM/z9kn/nXozKvYVS7/0tLZgXyYDWnYtRxgl+RM7nVp7qM9tFaHu
 fTDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMkDzW/WxKWNkHuopD9xqLVC/M3/kVw3T0kA08vaMjF4Jbmn6c7mzwmwswuIpNc3RmnaS5GM7wTfcE@nongnu.org
X-Gm-Message-State: AOJu0YxFxoWm9LHRVJB9LlSZSxcvIOdOBdOOp1LERJdIeOqYdsh3BNOm
 OHZN5kR9FtXha4dLqL27iBd5lwdgegCUrYas/53kSQVly9vxLTGnQmCRG+2FnqGOfNB3piQODNT
 KYYc=
X-Google-Smtp-Source: AGHT+IGCFYCx9cMu4EjDrV9I4VINMbpUw/UV86V0OIJxmx48E6EsNYMOtexhZo5JAqZxxvQ+rFO4uw==
X-Received: by 2002:a05:6000:dcb:b0:374:c1bd:f7c0 with SMTP id
 ffacd0b85a97d-374ecc8f4a4mr5335448f8f.22.1725460610956; 
 Wed, 04 Sep 2024 07:36:50 -0700 (PDT)
Received: from localhost.localdomain (56.red-95-127-44.staticip.rima-tde.net.
 [95.127.44.56]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df7c5bsm205825805e9.23.2024.09.04.07.36.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 04 Sep 2024 07:36:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 04/15] linux-user: Remove support for CRIS target
Date: Wed,  4 Sep 2024 16:35:52 +0200
Message-ID: <20240904143603.52934-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240904143603.52934-1-philmd@linaro.org>
References: <20240904143603.52934-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

As per the deprecation notice in commit c7bbef4023:

  The CRIS architecture was pulled from Linux in 4.17 and
  the compiler is no longer packaged in any distro making
  it harder to run the `check-tcg` tests. Unless we can
  improve the testing situation there is a chance the code
  will bitrot without anyone noticing.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/user/main.rst                   |   4 -
 configs/targets/cris-linux-user.mak  |   1 -
 include/user/abitypes.h              |   7 -
 linux-user/cris/sockbits.h           |   1 -
 linux-user/cris/syscall_nr.h         | 367 ---------------------------
 linux-user/cris/target_cpu.h         |  45 ----
 linux-user/cris/target_elf.h         |  14 -
 linux-user/cris/target_errno_defs.h  |   7 -
 linux-user/cris/target_fcntl.h       |  11 -
 linux-user/cris/target_mman.h        |  13 -
 linux-user/cris/target_prctl.h       |   1 -
 linux-user/cris/target_proc.h        |   1 -
 linux-user/cris/target_resource.h    |   1 -
 linux-user/cris/target_signal.h      |   9 -
 linux-user/cris/target_structs.h     |   1 -
 linux-user/cris/target_syscall.h     |  46 ----
 linux-user/cris/termbits.h           | 225 ----------------
 linux-user/syscall_defs.h            |   7 +-
 linux-user/cris/cpu_loop.c           |  95 -------
 linux-user/cris/signal.c             | 194 --------------
 linux-user/elfload.c                 |  15 --
 linux-user/syscall.c                 |  10 +-
 .gitlab-ci.d/crossbuild-template.yml |   2 +-
 23 files changed, 5 insertions(+), 1072 deletions(-)
 delete mode 100644 configs/targets/cris-linux-user.mak
 delete mode 100644 linux-user/cris/sockbits.h
 delete mode 100644 linux-user/cris/syscall_nr.h
 delete mode 100644 linux-user/cris/target_cpu.h
 delete mode 100644 linux-user/cris/target_elf.h
 delete mode 100644 linux-user/cris/target_errno_defs.h
 delete mode 100644 linux-user/cris/target_fcntl.h
 delete mode 100644 linux-user/cris/target_mman.h
 delete mode 100644 linux-user/cris/target_prctl.h
 delete mode 100644 linux-user/cris/target_proc.h
 delete mode 100644 linux-user/cris/target_resource.h
 delete mode 100644 linux-user/cris/target_signal.h
 delete mode 100644 linux-user/cris/target_structs.h
 delete mode 100644 linux-user/cris/target_syscall.h
 delete mode 100644 linux-user/cris/termbits.h
 delete mode 100644 linux-user/cris/cpu_loop.c
 delete mode 100644 linux-user/cris/signal.c

diff --git a/docs/user/main.rst b/docs/user/main.rst
index e04bc2cb86..7a126ee809 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -130,10 +130,6 @@ Other binaries
 
    The binary format is detected automatically.
 
--  user mode (Cris)
-
-   * ``qemu-cris`` TODO.
-
 -  user mode (i386)
 
    * ``qemu-i386`` TODO.
diff --git a/configs/targets/cris-linux-user.mak b/configs/targets/cris-linux-user.mak
deleted file mode 100644
index e483c42066..0000000000
--- a/configs/targets/cris-linux-user.mak
+++ /dev/null
@@ -1 +0,0 @@
-TARGET_ARCH=cris
diff --git a/include/user/abitypes.h b/include/user/abitypes.h
index 5c9a955631..7528124b62 100644
--- a/include/user/abitypes.h
+++ b/include/user/abitypes.h
@@ -21,13 +21,6 @@
 #define ABI_LLONG_ALIGNMENT 2
 #endif
 
-#ifdef TARGET_CRIS
-#define ABI_SHORT_ALIGNMENT 1
-#define ABI_INT_ALIGNMENT 1
-#define ABI_LONG_ALIGNMENT 1
-#define ABI_LLONG_ALIGNMENT 1
-#endif
-
 #if (defined(TARGET_I386) && !defined(TARGET_X86_64)) \
     || defined(TARGET_SH4) \
     || defined(TARGET_OPENRISC) \
diff --git a/linux-user/cris/sockbits.h b/linux-user/cris/sockbits.h
deleted file mode 100644
index 0e4c8f012d..0000000000
--- a/linux-user/cris/sockbits.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../generic/sockbits.h"
diff --git a/linux-user/cris/syscall_nr.h b/linux-user/cris/syscall_nr.h
deleted file mode 100644
index 4b6cf65c42..0000000000
--- a/linux-user/cris/syscall_nr.h
+++ /dev/null
@@ -1,367 +0,0 @@
-/*
- * This file contains the system call numbers, and stub macros for libc.
- */
-
-#ifndef LINUX_USER_CRIS_SYSCALL_NR_H
-#define LINUX_USER_CRIS_SYSCALL_NR_H
-
-#define TARGET_NR_restart_syscall      0
-#define TARGET_NR_exit		  1
-#define TARGET_NR_fork		  2
-#define TARGET_NR_read		  3
-#define TARGET_NR_write		  4
-#define TARGET_NR_open		  5
-#define TARGET_NR_close		  6
-#define TARGET_NR_waitpid		  7
-#define TARGET_NR_creat		  8
-#define TARGET_NR_link		  9
-#define TARGET_NR_unlink		 10
-#define TARGET_NR_execve		 11
-#define TARGET_NR_chdir		 12
-#define TARGET_NR_time		 13
-#define TARGET_NR_mknod		 14
-#define TARGET_NR_chmod		 15
-#define TARGET_NR_lchown		 16
-#define TARGET_NR_break		 17
-#define TARGET_NR_oldstat		 18
-#define TARGET_NR_lseek		 19
-#define TARGET_NR_getpid		 20
-#define TARGET_NR_mount		 21
-#define TARGET_NR_umount		 22
-#define TARGET_NR_setuid		 23
-#define TARGET_NR_getuid		 24
-#define TARGET_NR_stime		 25
-#define TARGET_NR_ptrace		 26
-#define TARGET_NR_alarm		 27
-#define TARGET_NR_oldfstat		 28
-#define TARGET_NR_pause		 29
-#define TARGET_NR_utime		 30
-#define TARGET_NR_stty		 31
-#define TARGET_NR_gtty		 32
-#define TARGET_NR_access		 33
-#define TARGET_NR_nice		 34
-#define TARGET_NR_ftime		 35
-#define TARGET_NR_sync		 36
-#define TARGET_NR_kill		 37
-#define TARGET_NR_rename		 38
-#define TARGET_NR_mkdir		 39
-#define TARGET_NR_rmdir		 40
-#define TARGET_NR_dup		 41
-#define TARGET_NR_pipe		 42
-#define TARGET_NR_times		 43
-#define TARGET_NR_prof		 44
-#define TARGET_NR_brk		 45
-#define TARGET_NR_setgid		 46
-#define TARGET_NR_getgid		 47
-#define TARGET_NR_signal		 48
-#define TARGET_NR_geteuid		 49
-#define TARGET_NR_getegid		 50
-#define TARGET_NR_acct		 51
-#define TARGET_NR_umount2		 52
-#define TARGET_NR_lock		 53
-#define TARGET_NR_ioctl		 54
-#define TARGET_NR_fcntl		 55
-#define TARGET_NR_mpx		 56
-#define TARGET_NR_setpgid		 57
-#define TARGET_NR_ulimit		 58
-#define TARGET_NR_oldolduname	 59
-#define TARGET_NR_umask		 60
-#define TARGET_NR_chroot		 61
-#define TARGET_NR_ustat		 62
-#define TARGET_NR_dup2		 63
-#define TARGET_NR_getppid		 64
-#define TARGET_NR_getpgrp		 65
-#define TARGET_NR_setsid		 66
-#define TARGET_NR_sigaction		 67
-#define TARGET_NR_sgetmask		 68
-#define TARGET_NR_ssetmask		 69
-#define TARGET_NR_setreuid		 70
-#define TARGET_NR_setregid		 71
-#define TARGET_NR_sigsuspend		 72
-#define TARGET_NR_sigpending		 73
-#define TARGET_NR_sethostname	 74
-#define TARGET_NR_setrlimit		 75
-#define TARGET_NR_getrlimit		 76
-#define TARGET_NR_getrusage		 77
-#define TARGET_NR_gettimeofday	 78
-#define TARGET_NR_settimeofday	 79
-#define TARGET_NR_getgroups		 80
-#define TARGET_NR_setgroups		 81
-#define TARGET_NR_select		 82
-#define TARGET_NR_symlink		 83
-#define TARGET_NR_oldlstat		 84
-#define TARGET_NR_readlink		 85
-#define TARGET_NR_uselib		 86
-#define TARGET_NR_swapon		 87
-#define TARGET_NR_reboot		 88
-#define TARGET_NR_readdir		 89
-#define TARGET_NR_mmap		 90
-#define TARGET_NR_munmap		 91
-#define TARGET_NR_truncate		 92
-#define TARGET_NR_ftruncate		 93
-#define TARGET_NR_fchmod		 94
-#define TARGET_NR_fchown		 95
-#define TARGET_NR_getpriority	 96
-#define TARGET_NR_setpriority	 97
-#define TARGET_NR_profil		 98
-#define TARGET_NR_statfs		 99
-#define TARGET_NR_fstatfs		100
-#define TARGET_NR_ioperm		101
-#define TARGET_NR_socketcall		102
-#define TARGET_NR_syslog		103
-#define TARGET_NR_setitimer		104
-#define TARGET_NR_getitimer		105
-#define TARGET_NR_stat		106
-#define TARGET_NR_lstat		107
-#define TARGET_NR_fstat		108
-#define TARGET_NR_olduname		109
-#define TARGET_NR_iopl		110
-#define TARGET_NR_vhangup		111
-#define TARGET_NR_idle		112
-#define TARGET_NR_vm86		113
-#define TARGET_NR_wait4		114
-#define TARGET_NR_swapoff		115
-#define TARGET_NR_sysinfo		116
-#define TARGET_NR_ipc		117
-#define TARGET_NR_fsync		118
-#define TARGET_NR_sigreturn		119
-#define TARGET_NR_clone		120
-#define TARGET_NR_setdomainname	121
-#define TARGET_NR_uname		122
-#define TARGET_NR_modify_ldt		123
-#define TARGET_NR_adjtimex		124
-#define TARGET_NR_mprotect		125
-#define TARGET_NR_sigprocmask	126
-#define TARGET_NR_create_module	127
-#define TARGET_NR_init_module	128
-#define TARGET_NR_delete_module	129
-#define TARGET_NR_get_kernel_syms	130
-#define TARGET_NR_quotactl		131
-#define TARGET_NR_getpgid		132
-#define TARGET_NR_fchdir		133
-#define TARGET_NR_bdflush		134
-#define TARGET_NR_sysfs		135
-#define TARGET_NR_personality	136
-#define TARGET_NR_afs_syscall	137 /* Syscall for Andrew File System */
-#define TARGET_NR_setfsuid		138
-#define TARGET_NR_setfsgid		139
-#define TARGET_NR__llseek		140
-#define TARGET_NR_getdents		141
-#define TARGET_NR__newselect		142
-#define TARGET_NR_flock		143
-#define TARGET_NR_msync		144
-#define TARGET_NR_readv		145
-#define TARGET_NR_writev		146
-#define TARGET_NR_getsid		147
-#define TARGET_NR_fdatasync		148
-#define TARGET_NR__sysctl		149
-#define TARGET_NR_mlock		150
-#define TARGET_NR_munlock		151
-#define TARGET_NR_mlockall		152
-#define TARGET_NR_munlockall		153
-#define TARGET_NR_sched_setparam		154
-#define TARGET_NR_sched_getparam		155
-#define TARGET_NR_sched_setscheduler		156
-#define TARGET_NR_sched_getscheduler		157
-#define TARGET_NR_sched_yield		158
-#define TARGET_NR_sched_get_priority_max	159
-#define TARGET_NR_sched_get_priority_min	160
-#define TARGET_NR_sched_rr_get_interval	161
-#define TARGET_NR_nanosleep		162
-#define TARGET_NR_mremap		163
-#define TARGET_NR_setresuid		164
-#define TARGET_NR_getresuid		165
-
-#define TARGET_NR_query_module	167
-#define TARGET_NR_poll		168
-#define TARGET_NR_nfsservctl		169
-#define TARGET_NR_setresgid		170
-#define TARGET_NR_getresgid		171
-#define TARGET_NR_prctl              172
-#define TARGET_NR_rt_sigreturn	173
-#define TARGET_NR_rt_sigaction	174
-#define TARGET_NR_rt_sigprocmask	175
-#define TARGET_NR_rt_sigpending	176
-#define TARGET_NR_rt_sigtimedwait	177
-#define TARGET_NR_rt_sigqueueinfo	178
-#define TARGET_NR_rt_sigsuspend	179
-#define TARGET_NR_pread64		180
-#define TARGET_NR_pwrite64		181
-#define TARGET_NR_chown		182
-#define TARGET_NR_getcwd		183
-#define TARGET_NR_capget		184
-#define TARGET_NR_capset		185
-#define TARGET_NR_sigaltstack	186
-#define TARGET_NR_sendfile		187
-#define TARGET_NR_getpmsg		188	/* some people actually want streams */
-#define TARGET_NR_putpmsg		189	/* some people actually want streams */
-#define TARGET_NR_vfork		190
-#define TARGET_NR_ugetrlimit		191	/* SuS compliant getrlimit */
-#define TARGET_NR_mmap2		192
-#define TARGET_NR_truncate64		193
-#define TARGET_NR_ftruncate64	194
-#define TARGET_NR_stat64		195
-#define TARGET_NR_lstat64		196
-#define TARGET_NR_fstat64		197
-#define TARGET_NR_lchown32		198
-#define TARGET_NR_getuid32		199
-#define TARGET_NR_getgid32		200
-#define TARGET_NR_geteuid32		201
-#define TARGET_NR_getegid32		202
-#define TARGET_NR_setreuid32		203
-#define TARGET_NR_setregid32		204
-#define TARGET_NR_getgroups32	205
-#define TARGET_NR_setgroups32	206
-#define TARGET_NR_fchown32		207
-#define TARGET_NR_setresuid32	208
-#define TARGET_NR_getresuid32	209
-#define TARGET_NR_setresgid32	210
-#define TARGET_NR_getresgid32	211
-#define TARGET_NR_chown32		212
-#define TARGET_NR_setuid32		213
-#define TARGET_NR_setgid32		214
-#define TARGET_NR_setfsuid32		215
-#define TARGET_NR_setfsgid32		216
-#define TARGET_NR_pivot_root		217
-#define TARGET_NR_mincore		218
-#define TARGET_NR_madvise		219
-#define TARGET_NR_getdents64		220
-#define TARGET_NR_fcntl64		221
-/* 223 is unused */
-#define TARGET_NR_gettid             224
-#define TARGET_NR_readahead          225
-#define TARGET_NR_setxattr		226
-#define TARGET_NR_lsetxattr		227
-#define TARGET_NR_fsetxattr		228
-#define TARGET_NR_getxattr		229
-#define TARGET_NR_lgetxattr		230
-#define TARGET_NR_fgetxattr		231
-#define TARGET_NR_listxattr		232
-#define TARGET_NR_llistxattr		233
-#define TARGET_NR_flistxattr		234
-#define TARGET_NR_removexattr	235
-#define TARGET_NR_lremovexattr	236
-#define TARGET_NR_fremovexattr	237
-#define TARGET_NR_tkill		238
-#define TARGET_NR_sendfile64		239
-#define TARGET_NR_futex		240
-#define TARGET_NR_sched_setaffinity	241
-#define TARGET_NR_sched_getaffinity	242
-#define TARGET_NR_set_thread_area	243
-#define TARGET_NR_get_thread_area	244
-#define TARGET_NR_io_setup		245
-#define TARGET_NR_io_destroy		246
-#define TARGET_NR_io_getevents	247
-#define TARGET_NR_io_submit		248
-#define TARGET_NR_io_cancel		249
-#define TARGET_NR_fadvise64		250
-#define TARGET_NR_exit_group		252
-#define TARGET_NR_lookup_dcookie	253
-#define TARGET_NR_epoll_create	254
-#define TARGET_NR_epoll_ctl		255
-#define TARGET_NR_epoll_wait		256
-#define TARGET_NR_remap_file_pages	257
-#define TARGET_NR_set_tid_address	258
-#define TARGET_NR_timer_create	259
-#define TARGET_NR_timer_settime	(TARGET_NR_timer_create+1)
-#define TARGET_NR_timer_gettime	(TARGET_NR_timer_create+2)
-#define TARGET_NR_timer_getoverrun	(TARGET_NR_timer_create+3)
-#define TARGET_NR_timer_delete	(TARGET_NR_timer_create+4)
-#define TARGET_NR_clock_settime	(TARGET_NR_timer_create+5)
-#define TARGET_NR_clock_gettime	(TARGET_NR_timer_create+6)
-#define TARGET_NR_clock_getres	(TARGET_NR_timer_create+7)
-#define TARGET_NR_clock_nanosleep	(TARGET_NR_timer_create+8)
-#define TARGET_NR_statfs64		268
-#define TARGET_NR_fstatfs64		269
-#define TARGET_NR_tgkill		270
-#define TARGET_NR_utimes		271
-#define TARGET_NR_fadvise64_64	272
-#define TARGET_NR_vserver		273
-#define TARGET_NR_mbind		274
-#define TARGET_NR_get_mempolicy	275
-#define TARGET_NR_set_mempolicy	276
-#define TARGET_NR_mq_open 		277
-#define TARGET_NR_mq_unlink		(TARGET_NR_mq_open+1)
-#define TARGET_NR_mq_timedsend	(TARGET_NR_mq_open+2)
-#define TARGET_NR_mq_timedreceive	(TARGET_NR_mq_open+3)
-#define TARGET_NR_mq_notify		(TARGET_NR_mq_open+4)
-#define TARGET_NR_mq_getsetattr	(TARGET_NR_mq_open+5)
-#define TARGET_NR_kexec_load		283
-#define TARGET_NR_waitid		284
-/* #define TARGET_NR_sys_setaltroot	285 */
-#define TARGET_NR_add_key		286
-#define TARGET_NR_request_key	287
-#define TARGET_NR_keyctl		288
-#define TARGET_NR_ioprio_set         289
-#define TARGET_NR_ioprio_get         290
-#define TARGET_NR_inotify_init       291
-#define TARGET_NR_inotify_add_watch  292
-#define TARGET_NR_inotify_rm_watch   293
-#define TARGET_NR_migrate_pages      294
-#define TARGET_NR_openat             295
-#define TARGET_NR_mkdirat            296
-#define TARGET_NR_mknodat            297
-#define TARGET_NR_fchownat           298
-#define TARGET_NR_futimesat          299
-#define TARGET_NR_fstatat64          300
-#define TARGET_NR_unlinkat           301
-#define TARGET_NR_renameat           302
-#define TARGET_NR_linkat             303
-#define TARGET_NR_symlinkat          304
-#define TARGET_NR_readlinkat         305
-#define TARGET_NR_fchmodat           306
-#define TARGET_NR_faccessat          307
-#define TARGET_NR_pselect6           308
-#define TARGET_NR_ppoll              309
-#define TARGET_NR_unshare            310
-#define TARGET_NR_set_robust_list    311
-#define TARGET_NR_get_robust_list    312
-#define TARGET_NR_splice             313
-#define TARGET_NR_sync_file_range    314
-#define TARGET_NR_tee                315
-#define TARGET_NR_vmsplice           316
-#define TARGET_NR_move_pages         317
-#define TARGET_NR_getcpu             318
-#define TARGET_NR_epoll_pwait        319
-#define TARGET_NR_utimensat          320
-#define TARGET_NR_signalfd           321
-#define TARGET_NR_timerfd_create     322
-#define TARGET_NR_eventfd            323
-#define TARGET_NR_fallocate          324
-#define TARGET_NR_timerfd_settime    325
-#define TARGET_NR_timerfd_gettime    326
-#define TARGET_NR_signalfd4          327
-#define TARGET_NR_eventfd2           328
-#define TARGET_NR_epoll_create1      329
-#define TARGET_NR_dup3               330
-#define TARGET_NR_pipe2              331
-#define TARGET_NR_inotify_init1      332
-#define TARGET_NR_preadv             333
-#define TARGET_NR_pwritev            334
-#define TARGET_NR_setns              335
-#define TARGET_NR_name_to_handle_at  336
-#define TARGET_NR_open_by_handle_at  337
-#define TARGET_NR_rt_tgsigqueueinfo  338
-#define TARGET_NR_perf_event_open    339
-#define TARGET_NR_recvmmsg           340
-#define TARGET_NR_accept4            341
-#define TARGET_NR_fanotify_init      342
-#define TARGET_NR_fanotify_mark      343
-#define TARGET_NR_prlimit64          344
-#define TARGET_NR_clock_adjtime      345
-#define TARGET_NR_syncfs             346
-#define TARGET_NR_sendmmsg           347
-#define TARGET_NR_process_vm_readv   348
-#define TARGET_NR_process_vm_writev  349
-#define TARGET_NR_kcmp               350
-#define TARGET_NR_finit_module       351
-#define TARGET_NR_sched_setattr      352
-#define TARGET_NR_sched_getattr      353
-#define TARGET_NR_renameat2          354
-#define TARGET_NR_seccomp            355
-#define TARGET_NR_getrandom          356
-#define TARGET_NR_memfd_create       357
-#define TARGET_NR_bpf                358
-#define TARGET_NR_execveat           359
-
-#endif
diff --git a/linux-user/cris/target_cpu.h b/linux-user/cris/target_cpu.h
deleted file mode 100644
index 7f6cade7b6..0000000000
--- a/linux-user/cris/target_cpu.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * CRIS specific CPU ABI and functions for linux-user
- *
- * Copyright (c) 2007 AXIS Communications AB
- * Written by Edgar E. Iglesias
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2.1 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-#ifndef CRIS_TARGET_CPU_H
-#define CRIS_TARGET_CPU_H
-
-static inline void cpu_clone_regs_child(CPUCRISState *env, target_ulong newsp,
-                                        unsigned flags)
-{
-    if (newsp) {
-        env->regs[14] = newsp;
-    }
-    env->regs[10] = 0;
-}
-
-static inline void cpu_clone_regs_parent(CPUCRISState *env, unsigned flags)
-{
-}
-
-static inline void cpu_set_tls(CPUCRISState *env, target_ulong newtls)
-{
-    env->pregs[PR_PID] = (env->pregs[PR_PID] & 0xff) | newtls;
-}
-
-static inline abi_ulong get_sp_from_cpustate(CPUCRISState *state)
-{
-    return state->regs[14];
-}
-#endif
diff --git a/linux-user/cris/target_elf.h b/linux-user/cris/target_elf.h
deleted file mode 100644
index 99eb4ec704..0000000000
--- a/linux-user/cris/target_elf.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation, or (at your option) any
- * later version. See the COPYING file in the top-level directory.
- */
-
-#ifndef CRIS_TARGET_ELF_H
-#define CRIS_TARGET_ELF_H
-static inline const char *cpu_get_model(uint32_t eflags)
-{
-    return "any";
-}
-#endif
diff --git a/linux-user/cris/target_errno_defs.h b/linux-user/cris/target_errno_defs.h
deleted file mode 100644
index 1cf43b17a5..0000000000
--- a/linux-user/cris/target_errno_defs.h
+++ /dev/null
@@ -1,7 +0,0 @@
-#ifndef CRIS_TARGET_ERRNO_DEFS_H
-#define CRIS_TARGET_ERRNO_DEFS_H
-
-/* Target uses generic errno */
-#include "../generic/target_errno_defs.h"
-
-#endif
diff --git a/linux-user/cris/target_fcntl.h b/linux-user/cris/target_fcntl.h
deleted file mode 100644
index df0aceea34..0000000000
--- a/linux-user/cris/target_fcntl.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/*
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation, or (at your option) any
- * later version. See the COPYING file in the top-level directory.
- */
-
-#ifndef CRIS_TARGET_FCNTL_H
-#define CRIS_TARGET_FCNTL_H
-#include "../generic/fcntl.h"
-#endif
diff --git a/linux-user/cris/target_mman.h b/linux-user/cris/target_mman.h
deleted file mode 100644
index 9ace8ac292..0000000000
--- a/linux-user/cris/target_mman.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * arch/cris/include/asm/processor.h:
- * TASK_UNMAPPED_BASE      (PAGE_ALIGN(TASK_SIZE / 3))
- *
- * arch/cris/include/arch-v32/arch/processor.h
- * TASK_SIZE               0xb0000000
- */
-#define TASK_UNMAPPED_BASE TARGET_PAGE_ALIGN(0xb0000000 / 3)
-
-/* arch/cris/include/uapi/asm/elf.h */
-#define ELF_ET_DYN_BASE    (TASK_UNMAPPED_BASE * 2)
-
-#include "../generic/target_mman.h"
diff --git a/linux-user/cris/target_prctl.h b/linux-user/cris/target_prctl.h
deleted file mode 100644
index eb53b31ad5..0000000000
--- a/linux-user/cris/target_prctl.h
+++ /dev/null
@@ -1 +0,0 @@
-/* No special prctl support required. */
diff --git a/linux-user/cris/target_proc.h b/linux-user/cris/target_proc.h
deleted file mode 100644
index 43fe29ca72..0000000000
--- a/linux-user/cris/target_proc.h
+++ /dev/null
@@ -1 +0,0 @@
-/* No target-specific /proc support */
diff --git a/linux-user/cris/target_resource.h b/linux-user/cris/target_resource.h
deleted file mode 100644
index 227259594c..0000000000
--- a/linux-user/cris/target_resource.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../generic/target_resource.h"
diff --git a/linux-user/cris/target_signal.h b/linux-user/cris/target_signal.h
deleted file mode 100644
index ab0653fcdc..0000000000
--- a/linux-user/cris/target_signal.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef CRIS_TARGET_SIGNAL_H
-#define CRIS_TARGET_SIGNAL_H
-
-#include "../generic/signal.h"
-
-#define TARGET_ARCH_HAS_SETUP_FRAME
-#define TARGET_ARCH_HAS_SIGTRAMP_PAGE 1
-
-#endif /* CRIS_TARGET_SIGNAL_H */
diff --git a/linux-user/cris/target_structs.h b/linux-user/cris/target_structs.h
deleted file mode 100644
index 3a06f373c3..0000000000
--- a/linux-user/cris/target_structs.h
+++ /dev/null
@@ -1 +0,0 @@
-#include "../generic/target_structs.h"
diff --git a/linux-user/cris/target_syscall.h b/linux-user/cris/target_syscall.h
deleted file mode 100644
index 0b5ebf1f02..0000000000
--- a/linux-user/cris/target_syscall.h
+++ /dev/null
@@ -1,46 +0,0 @@
-#ifndef CRIS_TARGET_SYSCALL_H
-#define CRIS_TARGET_SYSCALL_H
-
-#define UNAME_MACHINE "cris"
-#define UNAME_MINIMUM_RELEASE "2.6.32"
-
-/* pt_regs not only specifies the format in the user-struct during
- * ptrace but is also the frame format used in the kernel prologue/epilogues
- * themselves
- */
-
-struct target_pt_regs {
-        unsigned long orig_r10;
-        /* pushed by movem r13, [sp] in SAVE_ALL. */
-        unsigned long r0;
-        unsigned long r1;
-        unsigned long r2;
-        unsigned long r3;
-        unsigned long r4;
-        unsigned long r5;
-        unsigned long r6;
-        unsigned long r7;
-        unsigned long r8;
-        unsigned long r9;
-        unsigned long r10;
-        unsigned long r11;
-        unsigned long r12;
-        unsigned long r13;
-        unsigned long acr;
-        unsigned long srs;
-        unsigned long mof;
-        unsigned long spc;
-        unsigned long ccs;
-        unsigned long srp;
-        unsigned long erp; /* This is actually the debugged process's PC */
-        /* For debugging purposes; saved only when needed. */
-        unsigned long exs;
-        unsigned long eda;
-};
-
-#define TARGET_CLONE_BACKWARDS2
-#define TARGET_MCL_CURRENT 1
-#define TARGET_MCL_FUTURE  2
-#define TARGET_MCL_ONFAULT 4
-
-#endif
diff --git a/linux-user/cris/termbits.h b/linux-user/cris/termbits.h
deleted file mode 100644
index 0c8d8fc051..0000000000
--- a/linux-user/cris/termbits.h
+++ /dev/null
@@ -1,225 +0,0 @@
-/* from asm/termbits.h */
-
-#ifndef LINUX_USER_CRIS_TERMBITS_H
-#define LINUX_USER_CRIS_TERMBITS_H
-
-#define TARGET_NCCS 19
-
-typedef unsigned char   target_cc_t;        /* cc_t */
-typedef unsigned int    target_speed_t;     /* speed_t */
-typedef unsigned int    target_tcflag_t;    /* tcflag_t */
-
-struct target_termios {
-    target_tcflag_t c_iflag;               /* input mode flags */
-    target_tcflag_t c_oflag;               /* output mode flags */
-    target_tcflag_t c_cflag;               /* control mode flags */
-    target_tcflag_t c_lflag;               /* local mode flags */
-    target_cc_t c_line;                    /* line discipline */
-    target_cc_t c_cc[TARGET_NCCS];         /* control characters */
-};
-
-/* c_iflag bits */
-#define TARGET_IGNBRK  0000001
-#define TARGET_BRKINT  0000002
-#define TARGET_IGNPAR  0000004
-#define TARGET_PARMRK  0000010
-#define TARGET_INPCK   0000020
-#define TARGET_ISTRIP  0000040
-#define TARGET_INLCR   0000100
-#define TARGET_IGNCR   0000200
-#define TARGET_ICRNL   0000400
-#define TARGET_IUCLC   0001000
-#define TARGET_IXON    0002000
-#define TARGET_IXANY   0004000
-#define TARGET_IXOFF   0010000
-#define TARGET_IMAXBEL 0020000
-#define TARGET_IUTF8   0040000
-
-/* c_oflag bits */
-#define TARGET_OPOST   0000001
-#define TARGET_OLCUC   0000002
-#define TARGET_ONLCR   0000004
-#define TARGET_OCRNL   0000010
-#define TARGET_ONOCR   0000020
-#define TARGET_ONLRET  0000040
-#define TARGET_OFILL   0000100
-#define TARGET_OFDEL   0000200
-#define TARGET_NLDLY   0000400
-#define   TARGET_NL0   0000000
-#define   TARGET_NL1   0000400
-#define TARGET_CRDLY   0003000
-#define   TARGET_CR0   0000000
-#define   TARGET_CR1   0001000
-#define   TARGET_CR2   0002000
-#define   TARGET_CR3   0003000
-#define TARGET_TABDLY  0014000
-#define   TARGET_TAB0  0000000
-#define   TARGET_TAB1  0004000
-#define   TARGET_TAB2  0010000
-#define   TARGET_TAB3  0014000
-#define   TARGET_XTABS 0014000
-#define TARGET_BSDLY   0020000
-#define   TARGET_BS0   0000000
-#define   TARGET_BS1   0020000
-#define TARGET_VTDLY   0040000
-#define   TARGET_VT0   0000000
-#define   TARGET_VT1   0040000
-#define TARGET_FFDLY   0100000
-#define   TARGET_FF0   0000000
-#define   TARGET_FF1   0100000
-
-/* c_cflag bit meaning */
-#define TARGET_CBAUD   0010017
-#define  TARGET_B0     0000000         /* hang up */
-#define  TARGET_B50    0000001
-#define  TARGET_B75    0000002
-#define  TARGET_B110   0000003
-#define  TARGET_B134   0000004
-#define  TARGET_B150   0000005
-#define  TARGET_B200   0000006
-#define  TARGET_B300   0000007
-#define  TARGET_B600   0000010
-#define  TARGET_B1200  0000011
-#define  TARGET_B1800  0000012
-#define  TARGET_B2400  0000013
-#define  TARGET_B4800  0000014
-#define  TARGET_B9600  0000015
-#define  TARGET_B19200 0000016
-#define  TARGET_B38400 0000017
-#define TARGET_EXTA B19200
-#define TARGET_EXTB B38400
-#define TARGET_CSIZE   0000060
-#define   TARGET_CS5   0000000
-#define   TARGET_CS6   0000020
-#define   TARGET_CS7   0000040
-#define   TARGET_CS8   0000060
-#define TARGET_CSTOPB  0000100
-#define TARGET_CREAD   0000200
-#define TARGET_PARENB  0000400
-#define TARGET_PARODD  0001000
-#define TARGET_HUPCL   0002000
-#define TARGET_CLOCAL  0004000
-#define TARGET_CBAUDEX 0010000
-#define  TARGET_B57600  0010001
-#define  TARGET_B115200 0010002
-#define  TARGET_B230400 0010003
-#define  TARGET_B460800 0010004
-#define TARGET_CIBAUD    002003600000  /* input baud rate (not used) */
-#define TARGET_CRTSCTS   020000000000          /* flow control */
-
-/* c_lflag bits */
-#define TARGET_ISIG    0000001
-#define TARGET_ICANON  0000002
-#define TARGET_XCASE   0000004
-#define TARGET_ECHO    0000010
-#define TARGET_ECHOE   0000020
-#define TARGET_ECHOK   0000040
-#define TARGET_ECHONL  0000100
-#define TARGET_NOFLSH  0000200
-#define TARGET_TOSTOP  0000400
-#define TARGET_ECHOCTL 0001000
-#define TARGET_ECHOPRT 0002000
-#define TARGET_ECHOKE  0004000
-#define TARGET_FLUSHO  0010000
-#define TARGET_PENDIN  0040000
-#define TARGET_IEXTEN  0100000
-#define TARGET_EXTPROC 0200000
-
-/* c_cc character offsets */
-#define TARGET_VINTR	0
-#define TARGET_VQUIT	1
-#define TARGET_VERASE	2
-#define TARGET_VKILL	3
-#define TARGET_VEOF	4
-#define TARGET_VTIME	5
-#define TARGET_VMIN	6
-#define TARGET_VSWTC	7
-#define TARGET_VSTART	8
-#define TARGET_VSTOP	9
-#define TARGET_VSUSP	10
-#define TARGET_VEOL	11
-#define TARGET_VREPRINT	12
-#define TARGET_VDISCARD	13
-#define TARGET_VWERASE	14
-#define TARGET_VLNEXT	15
-#define TARGET_VEOL2	16
-
-/* ioctls */
-
-#define TARGET_TCGETS		0x5401
-#define TARGET_TCSETS		0x5402
-#define TARGET_TCSETSW		0x5403
-#define TARGET_TCSETSF		0x5404
-#define TARGET_TCGETA		0x5405
-#define TARGET_TCSETA		0x5406
-#define TARGET_TCSETAW		0x5407
-#define TARGET_TCSETAF		0x5408
-#define TARGET_TCSBRK		0x5409
-#define TARGET_TCXONC		0x540A
-#define TARGET_TCFLSH		0x540B
-
-#define TARGET_TIOCEXCL	0x540C
-#define TARGET_TIOCNXCL	0x540D
-#define TARGET_TIOCSCTTY	0x540E
-#define TARGET_TIOCGPGRP	0x540F
-#define TARGET_TIOCSPGRP	0x5410
-#define TARGET_TIOCOUTQ	0x5411
-#define TARGET_TIOCSTI		0x5412
-#define TARGET_TIOCGWINSZ	0x5413
-#define TARGET_TIOCSWINSZ	0x5414
-#define TARGET_TIOCMGET	0x5415
-#define TARGET_TIOCMBIS	0x5416
-#define TARGET_TIOCMBIC	0x5417
-#define TARGET_TIOCMSET	0x5418
-#define TARGET_TIOCGSOFTCAR	0x5419
-#define TARGET_TIOCSSOFTCAR	0x541A
-#define TARGET_FIONREAD	0x541B
-#define TARGET_TIOCINQ		TARGET_FIONREAD
-#define TARGET_TIOCLINUX	0x541C
-#define TARGET_TIOCCONS	0x541D
-#define TARGET_TIOCGSERIAL	0x541E
-#define TARGET_TIOCSSERIAL	0x541F
-#define TARGET_TIOCPKT		0x5420
-#define TARGET_FIONBIO		0x5421
-#define TARGET_TIOCNOTTY	0x5422
-#define TARGET_TIOCSETD	0x5423
-#define TARGET_TIOCGETD	0x5424
-#define TARGET_TCSBRKP		0x5425	/* Needed for POSIX tcsendbreak() */
-#define TARGET_TIOCTTYGSTRUCT	0x5426  /* For debugging only */
-#define TARGET_TIOCSBRK	0x5427  /* BSD compatibility */
-#define TARGET_TIOCCBRK	0x5428  /* BSD compatibility */
-#define TARGET_TIOCGSID	0x5429  /* Return the session ID of FD */
-#define TARGET_TIOCGPTN	TARGET_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
-#define TARGET_TIOCSPTLCK	TARGET_IOW('T',0x31, int)  /* Lock/unlock Pty */
-#define TARGET_TIOCGPTPEER      TARGET_IO('T', 0x41) /* Safely open the slave */
-
-#define TARGET_FIONCLEX	0x5450  /* these numbers need to be adjusted. */
-#define TARGET_FIOCLEX		0x5451
-#define TARGET_FIOASYNC	0x5452
-#define TARGET_TIOCSERCONFIG	0x5453
-#define TARGET_TIOCSERGWILD	0x5454
-#define TARGET_TIOCSERSWILD	0x5455
-#define TARGET_TIOCGLCKTRMIOS	0x5456
-#define TARGET_TIOCSLCKTRMIOS	0x5457
-#define TARGET_TIOCSERGSTRUCT	0x5458 /* For debugging only */
-#define TARGET_TIOCSERGETLSR   0x5459 /* Get line status register */
-#define TARGET_TIOCSERGETMULTI 0x545A /* Get multiport config  */
-#define TARGET_TIOCSERSETMULTI 0x545B /* Set multiport config */
-
-#define TARGET_TIOCMIWAIT	0x545C	/* wait for a change on serial input line(s) */
-#define TARGET_TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
-#define TARGET_TIOCGHAYESESP   0x545E  /* Get Hayes ESP configuration */
-#define TARGET_TIOCSHAYESESP   0x545F  /* Set Hayes ESP configuration */
-
-/* Used for packet mode */
-#define TARGET_TIOCPKT_DATA		 0
-#define TARGET_TIOCPKT_FLUSHREAD	 1
-#define TARGET_TIOCPKT_FLUSHWRITE	 2
-#define TARGET_TIOCPKT_STOP		 4
-#define TARGET_TIOCPKT_START		 8
-#define TARGET_TIOCPKT_NOSTOP		16
-#define TARGET_TIOCPKT_DOSTOP		32
-
-#define TARGET_TIOCSER_TEMT    0x01	/* Transmitter physically empty */
-
-#endif
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index a00b617cae..8ed53904ed 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -62,7 +62,7 @@
 #if (defined(TARGET_I386) && defined(TARGET_ABI32))                     \
     || (defined(TARGET_ARM) && defined(TARGET_ABI32))                   \
     || (defined(TARGET_SPARC) && defined(TARGET_ABI32))                 \
-    || defined(TARGET_M68K) || defined(TARGET_SH4) || defined(TARGET_CRIS)
+    || defined(TARGET_M68K) || defined(TARGET_SH4)
 /* 16 bit uid wrappers emulation */
 #define USE_UID16
 #define target_id uint16_t
@@ -71,7 +71,7 @@
 #endif
 
 #if defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_SH4)  \
-    || defined(TARGET_M68K) || defined(TARGET_CRIS)                     \
+    || defined(TARGET_M68K)                                             \
     || defined(TARGET_S390X) || defined(TARGET_OPENRISC)                \
     || defined(TARGET_RISCV)                                            \
     || defined(TARGET_XTENSA) || defined(TARGET_LOONGARCH64)
@@ -1234,8 +1234,7 @@ struct target_winsize {
 #include "target_mman.h"
 
 #if (defined(TARGET_I386) && defined(TARGET_ABI32))     \
-    || (defined(TARGET_ARM) && defined(TARGET_ABI32))   \
-    || defined(TARGET_CRIS)
+    || (defined(TARGET_ARM) && defined(TARGET_ABI32))
 #define TARGET_STAT_HAVE_NSEC
 struct target_stat {
     abi_ushort st_dev;
diff --git a/linux-user/cris/cpu_loop.c b/linux-user/cris/cpu_loop.c
deleted file mode 100644
index 04c9086b6d..0000000000
--- a/linux-user/cris/cpu_loop.c
+++ /dev/null
@@ -1,95 +0,0 @@
-/*
- *  qemu user cpu loop
- *
- *  Copyright (c) 2003-2008 Fabrice Bellard
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "qemu.h"
-#include "user-internals.h"
-#include "cpu_loop-common.h"
-#include "signal-common.h"
-
-void cpu_loop(CPUCRISState *env)
-{
-    CPUState *cs = env_cpu(env);
-    int trapnr, ret;
-
-    while (1) {
-        cpu_exec_start(cs);
-        trapnr = cpu_exec(cs);
-        cpu_exec_end(cs);
-        process_queued_cpu_work(cs);
-
-        switch (trapnr) {
-        case EXCP_INTERRUPT:
-            /* just indicate that signals should be handled asap */
-            break;
-        case EXCP_BREAK:
-            ret = do_syscall(env, 
-                             env->regs[9], 
-                             env->regs[10], 
-                             env->regs[11], 
-                             env->regs[12], 
-                             env->regs[13], 
-                             env->pregs[7], 
-                             env->pregs[11],
-                             0, 0);
-            if (ret == -QEMU_ERESTARTSYS) {
-                env->pc -= 2;
-            } else if (ret != -QEMU_ESIGRETURN) {
-                env->regs[10] = ret;
-            }
-            break;
-        case EXCP_DEBUG:
-            force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
-            break;
-        case EXCP_ATOMIC:
-            cpu_exec_step_atomic(cs);
-            break;
-        default:
-            fprintf(stderr, "Unhandled trap: 0x%x\n", trapnr);
-            cpu_dump_state(cs, stderr, 0);
-            exit(EXIT_FAILURE);
-        }
-        process_pending_signals (env);
-    }
-}
-
-void target_cpu_copy_regs(CPUArchState *env, struct target_pt_regs *regs)
-{
-    CPUState *cpu = env_cpu(env);
-    TaskState *ts = get_task_state(cpu);
-    struct image_info *info = ts->info;
-
-    env->regs[0] = regs->r0;
-    env->regs[1] = regs->r1;
-    env->regs[2] = regs->r2;
-    env->regs[3] = regs->r3;
-    env->regs[4] = regs->r4;
-    env->regs[5] = regs->r5;
-    env->regs[6] = regs->r6;
-    env->regs[7] = regs->r7;
-    env->regs[8] = regs->r8;
-    env->regs[9] = regs->r9;
-    env->regs[10] = regs->r10;
-    env->regs[11] = regs->r11;
-    env->regs[12] = regs->r12;
-    env->regs[13] = regs->r13;
-    env->regs[14] = info->start_stack;
-    env->regs[15] = regs->acr;
-    env->pc = regs->erp;
-}
diff --git a/linux-user/cris/signal.c b/linux-user/cris/signal.c
deleted file mode 100644
index 10948bcf30..0000000000
--- a/linux-user/cris/signal.c
+++ /dev/null
@@ -1,194 +0,0 @@
-/*
- *  Emulation of Linux signals
- *
- *  Copyright (c) 2003 Fabrice Bellard
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-#include "qemu/osdep.h"
-#include "qemu.h"
-#include "user-internals.h"
-#include "signal-common.h"
-#include "linux-user/trace.h"
-
-struct target_sigcontext {
-    struct target_pt_regs regs;  /* needs to be first */
-    uint32_t oldmask;
-    uint32_t usp;    /* usp before stacking this gunk on it */
-};
-
-/* Signal frames. */
-struct target_signal_frame {
-    struct target_sigcontext sc;
-    uint32_t extramask[TARGET_NSIG_WORDS - 1];
-    uint16_t retcode[4];      /* Trampoline code. */
-};
-
-static void setup_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
-{
-    __put_user(env->regs[0], &sc->regs.r0);
-    __put_user(env->regs[1], &sc->regs.r1);
-    __put_user(env->regs[2], &sc->regs.r2);
-    __put_user(env->regs[3], &sc->regs.r3);
-    __put_user(env->regs[4], &sc->regs.r4);
-    __put_user(env->regs[5], &sc->regs.r5);
-    __put_user(env->regs[6], &sc->regs.r6);
-    __put_user(env->regs[7], &sc->regs.r7);
-    __put_user(env->regs[8], &sc->regs.r8);
-    __put_user(env->regs[9], &sc->regs.r9);
-    __put_user(env->regs[10], &sc->regs.r10);
-    __put_user(env->regs[11], &sc->regs.r11);
-    __put_user(env->regs[12], &sc->regs.r12);
-    __put_user(env->regs[13], &sc->regs.r13);
-    __put_user(env->regs[14], &sc->usp);
-    __put_user(env->regs[15], &sc->regs.acr);
-    __put_user(env->pregs[PR_MOF], &sc->regs.mof);
-    __put_user(env->pregs[PR_SRP], &sc->regs.srp);
-    __put_user(env->pc, &sc->regs.erp);
-}
-
-static void restore_sigcontext(struct target_sigcontext *sc, CPUCRISState *env)
-{
-    __get_user(env->regs[0], &sc->regs.r0);
-    __get_user(env->regs[1], &sc->regs.r1);
-    __get_user(env->regs[2], &sc->regs.r2);
-    __get_user(env->regs[3], &sc->regs.r3);
-    __get_user(env->regs[4], &sc->regs.r4);
-    __get_user(env->regs[5], &sc->regs.r5);
-    __get_user(env->regs[6], &sc->regs.r6);
-    __get_user(env->regs[7], &sc->regs.r7);
-    __get_user(env->regs[8], &sc->regs.r8);
-    __get_user(env->regs[9], &sc->regs.r9);
-    __get_user(env->regs[10], &sc->regs.r10);
-    __get_user(env->regs[11], &sc->regs.r11);
-    __get_user(env->regs[12], &sc->regs.r12);
-    __get_user(env->regs[13], &sc->regs.r13);
-    __get_user(env->regs[14], &sc->usp);
-    __get_user(env->regs[15], &sc->regs.acr);
-    __get_user(env->pregs[PR_MOF], &sc->regs.mof);
-    __get_user(env->pregs[PR_SRP], &sc->regs.srp);
-    __get_user(env->pc, &sc->regs.erp);
-}
-
-static abi_ulong get_sigframe(CPUCRISState *env, int framesize)
-{
-    abi_ulong sp;
-    /* Align the stack downwards to 4.  */
-    sp = (env->regs[R_SP] & ~3);
-    return sp - framesize;
-}
-
-static void setup_sigreturn(uint16_t *retcode)
-{
-    /* This is movu.w __NR_sigreturn, r9; break 13; */
-    __put_user(0x9c5f, retcode + 0);
-    __put_user(TARGET_NR_sigreturn, retcode + 1);
-    __put_user(0xe93d, retcode + 2);
-}
-
-void setup_frame(int sig, struct target_sigaction *ka,
-                 target_sigset_t *set, CPUCRISState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    int i;
-
-    frame_addr = get_sigframe(env, sizeof *frame);
-    trace_user_setup_frame(env, frame_addr);
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 0))
-        goto badframe;
-
-    /*
-     * The CRIS signal return trampoline. A real linux/CRIS kernel doesn't
-     * use this trampoline anymore but it sets it up for GDB.
-     */
-    setup_sigreturn(frame->retcode);
-
-    /* Save the mask.  */
-    __put_user(set->sig[0], &frame->sc.oldmask);
-
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __put_user(set->sig[i], &frame->extramask[i - 1]);
-    }
-
-    setup_sigcontext(&frame->sc, env);
-
-    /* Move the stack and setup the arguments for the handler.  */
-    env->regs[R_SP] = frame_addr;
-    env->regs[10] = sig;
-    env->pc = (unsigned long) ka->_sa_handler;
-    /* Link SRP so the guest returns through the trampoline.  */
-    env->pregs[PR_SRP] = default_sigreturn;
-
-    unlock_user_struct(frame, frame_addr, 1);
-    return;
-badframe:
-    force_sigsegv(sig);
-}
-
-void setup_rt_frame(int sig, struct target_sigaction *ka,
-                    target_siginfo_t *info,
-                     target_sigset_t *set, CPUCRISState *env)
-{
-    qemu_log_mask(LOG_UNIMP, "setup_rt_frame: not implemented\n");
-}
-
-long do_sigreturn(CPUCRISState *env)
-{
-    struct target_signal_frame *frame;
-    abi_ulong frame_addr;
-    target_sigset_t target_set;
-    sigset_t set;
-    int i;
-
-    frame_addr = env->regs[R_SP];
-    trace_user_do_sigreturn(env, frame_addr);
-    /* Make sure the guest isn't playing games.  */
-    if (!lock_user_struct(VERIFY_WRITE, frame, frame_addr, 1)) {
-        goto badframe;
-    }
-
-    /* Restore blocked signals */
-    __get_user(target_set.sig[0], &frame->sc.oldmask);
-    for(i = 1; i < TARGET_NSIG_WORDS; i++) {
-        __get_user(target_set.sig[i], &frame->extramask[i - 1]);
-    }
-    target_to_host_sigset_internal(&set, &target_set);
-    set_sigmask(&set);
-
-    restore_sigcontext(&frame->sc, env);
-    unlock_user_struct(frame, frame_addr, 0);
-    return -QEMU_ESIGRETURN;
-badframe:
-    force_sig(TARGET_SIGSEGV);
-    return -QEMU_ESIGRETURN;
-}
-
-long do_rt_sigreturn(CPUCRISState *env)
-{
-    trace_user_do_rt_sigreturn(env, 0);
-    qemu_log_mask(LOG_UNIMP, "do_rt_sigreturn: not implemented\n");
-    return -TARGET_ENOSYS;
-}
-
-void setup_sigtramp(abi_ulong sigtramp_page)
-{
-    uint16_t *tramp = lock_user(VERIFY_WRITE, sigtramp_page, 6, 0);
-    assert(tramp != NULL);
-
-    default_sigreturn = sigtramp_page;
-    setup_sigreturn(tramp);
-
-    unlock_user(tramp, sigtramp_page, 6);
-}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b27dd01734..0678c9d506 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1647,21 +1647,6 @@ static uint32_t get_elf_hwcap(void)
 
 #endif
 
-#ifdef TARGET_CRIS
-
-#define ELF_CLASS ELFCLASS32
-#define ELF_ARCH  EM_CRIS
-
-static inline void init_thread(struct target_pt_regs *regs,
-                               struct image_info *infop)
-{
-    regs->erp = infop->entry;
-}
-
-#define ELF_EXEC_PAGESIZE        8192
-
-#endif
-
 #ifdef TARGET_M68K
 
 #define ELF_CLASS       ELFCLASS32
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 9d5415674d..b693aeff5b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -10484,7 +10484,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
     case TARGET_NR_mmap:
 #if (defined(TARGET_I386) && defined(TARGET_ABI32)) || \
     (defined(TARGET_ARM) && defined(TARGET_ABI32)) || \
-    defined(TARGET_M68K) || defined(TARGET_CRIS) || defined(TARGET_MICROBLAZE) \
+    defined(TARGET_M68K) || defined(TARGET_MICROBLAZE) \
     || defined(TARGET_S390X)
         {
             abi_ulong *v;
@@ -12638,14 +12638,6 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 #if defined(TARGET_MIPS)
       cpu_env->active_tc.CP0_UserLocal = arg1;
       return 0;
-#elif defined(TARGET_CRIS)
-      if (arg1 & 0xff)
-          ret = -TARGET_EINVAL;
-      else {
-          cpu_env->pregs[PR_PID] = arg1;
-          ret = 0;
-      }
-      return ret;
 #elif defined(TARGET_I386) && defined(TARGET_ABI32)
       return do_set_thread_area(cpu_env, arg1);
 #elif defined(TARGET_M68K)
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 53051ec793..18ec5b6253 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -73,7 +73,7 @@
     - cd build
     - ../configure --enable-werror --disable-docs $QEMU_CONFIGURE_OPTS
         --disable-system --target-list-exclude="aarch64_be-linux-user
-          alpha-linux-user cris-linux-user m68k-linux-user microblazeel-linux-user
+          alpha-linux-user m68k-linux-user microblazeel-linux-user
           or1k-linux-user ppc-linux-user sparc-linux-user
           xtensa-linux-user $CROSS_SKIP_TARGETS"
     - make -j$(expr $(nproc) + 1) all check-build $MAKE_CHECK_ARGS
-- 
2.45.2


