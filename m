Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0477ECD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:03:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIe9I-0001G5-Nv; Thu, 30 Apr 2026 23:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe9H-0001Fx-Mk
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:39 -0400
Received: from mail-oa1-x2f.google.com ([2001:4860:4864:20::2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIe9E-0005YC-I0
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:02:39 -0400
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-41708f6c3feso1033560fac.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604555; x=1778209355;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FtXI8XidpXd+wsTnsE67djjYxwevyUBoRXDVIaasqZk=;
 b=l4kND8bLuQH2x1EDeYZ46cYQ/cU/lmvvnoiiDgEuNT3FlthVAaqFjMAKW+64PXofhz
 SPEpLJJ6jVJ9E1z2s9BAuDxe8hF9oMnCM/bVAC78pzQ5W8vqB/HUN6vnkq1SUMB0nveF
 hQxisFk+QiSse1Rwht7+g7B2rBqasuEh0AYxT5e43ik5bqsDUQcL3KWSgjbSjXfLQIgx
 oBqUIzA3HRFFaNfnOb/MLlbhRnR+2GzUVuw+Kyl4iPz0nuNIc+H/x9bPImvs5Wak+BAc
 U0jPR5LF14DQ0ZmMLnNYF/Vq65suot95ETlXz2zwUrDiBvSlelGkTh8g22L/HAPRNofp
 bQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604555; x=1778209355;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FtXI8XidpXd+wsTnsE67djjYxwevyUBoRXDVIaasqZk=;
 b=d6IXRKY9cNB1gyuVkncvdUNL8T2Sejjbrd97PD22qhByAQfyU09cjNi9V3obAf1HoL
 4dCakUT/CWYJxGqi5dwvjpRM6ichD3VrofguomCFcV7yrCXxM+insQN8Jr2IVRwaI+Sn
 ljE0xsf3KPqA52XB78rWLOQTmL4LyXJ+HhazZrTLVn5DouPHjOjdNs0rSKkLABE7hbRj
 bPykV8AQxmoUY36w2bgMdrq9t53S78tr7CT/pk1Qwrqw4TvNyShW4AsPMb8xdOONRuup
 puShOK61RNjIKq52oWdk4MBflY1vDFOCaBuBJV99uzVtCn+XvPSuXfRs/EWCkIBU7ZcZ
 HYmQ==
X-Gm-Message-State: AOJu0Yxo547KVdH4rEsnfgiLW91qcqep/uQRLgUdOCF2i+8byEyC3P7d
 HjaaGJfNaAKlmSxER0d0LZvWxiQ1mZHe/rY/qYbwHwRhCdTBPry6Mzl4+1O4+6vUS4o=
X-Gm-Gg: AeBDiev5wELVhMh2jNjRSUHGHmQIaaVl4A0NLeW9Tt8Re8FmWpk/gFMtkfum/4MUseq
 USOA1Ve5Z9u2jnGG7+fixgV4wSubM2FV7yDUnyEmlOp7zoi+LxedGj9PzH/vrqXBu6WR8YqBYTt
 sLM6PqJwXUYYcdiI1AzHS/zOoi/4CcGG+c7HRQd81pQjCbxhisE0opkStSVJwjFenBKv26h+JQC
 mNYR+h2M2VpFsA1fUWLdFeWU84NZeho9ZtGZnw1FRJeJiRvJ+4UTXMsaCrChvnCVHOriXrCeOIv
 lf3MfHa+Wbggz0WbSB/7syWBz7YRkU7s1vdemZbd9Xq6/fSS3Qyb6iJ7rimm7BpKCH0pCXPRfad
 d7z6FGytUaL1r/HzC+J3JbZHPdCtaji/gcrrfdIMsjiZPkBytDNKLKb3+nJKg2MvJPqcgkunkPF
 XRM7doQeupS8Vp0Ai/cGdB
X-Received: by 2002:a05:6870:a550:b0:42f:d5c1:dcc4 with SMTP id
 586e51a60fabf-43434007e2cmr3422404fac.26.1777604554610; 
 Thu, 30 Apr 2026 20:02:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43454cbc3c7sm1550875fac.12.2026.04.30.20.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:02:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 20:59:33 -0600
Subject: [PATCH v3 4/4] bsd-user: Switch to generated syscall_nr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-syscall-nr-v3-4-4b1b2445e28f@bsdimp.com>
References: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v3-0-4b1b2445e28f@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=27257; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=+YwW2552jI8duSfMS9ZsB83yImbkJG2213GKDm2xXIA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BdiNpEjipLPOM0X5xvghkVCPPSVS7zEiwUu9
 eJV9lHnYc6JAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQXYgAKCRBsHNEofbAR
 AFXPD/9dvO0c4tGG2ZxrqZ+k3YMk1cxMwvY6Br1UKQnXT4dp/z8OqohwAOyTET7O1uPyWvylws6
 T6ylGptub6w1EJWx2lT7fUvlZtc3TXqxXmvqLcdH9z9BLCMoT4HTL1wSntYZqhercLOWWiToyMC
 tYRXdZh85j0qxh3ZTAwgkqKybwvCbNgu7iNYIoMJEJlL9TXZwN5eZwxqxo4Enx4Ok2bn/1waHcZ
 BeLi9rOSDyNBdHlCpyjflIJpi4Il7gvJHatj7mKVK8cx69VuoCGaNs1F4EmLEn33mSoo0BoPp2D
 MVcys+Re1GaFHWp+TGKHqP6o/tfPaNEsuMWBEAL4qqmyTYqwmIstw8Snz7Ryt2OOpGj4QgJv5sU
 oj8KG4avTXGSesOG/5eb+4BpF4WJ9jnTutncO7LA9eGdh/f0PdyYN+snS/fc8PIGKMBmbFjBp4b
 sRUmmgPSVteVPUqku1LfBunBDEhScGLn0eGArtaAOuGQJm7yBH2+59Qq7UR6GMjHW57+QNczK0E
 V5JhFZsGfx0CMFpFBrMxtjXDwvKHQ7YnS/Fn5L7uALM0Hr66vV7nuV0InGW3+oxoYE8IOrrtWTv
 CTgnaYFx9AtztcUHnOGmTpjw2MgHjaN8Rs/jRikqckSpQ/6dh2PbQ/3NIs+Stv24EvQBYS8reoe
 DiEr9jYAKrOls4w==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2f;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2f.google.com
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

Now that this will build and work, remove the old syscall_nr.h and
switch the include over to the generated file in syscall_defs.h.

To do this, I had to delete the old, wrong definition of time_t for
FreeBSD on amd64 since it stumbled over the fact that TARGET_i386 is
defined for both 32-bit and 64-bit builds (the new os-syscall.h had the
rigth definition). Rather than modify this file twice to fix it, rolled
the fix into using os-syscall.h since it's still easy enough to review.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/syscall_nr.h | 515 ------------------------------------------
 bsd-user/syscall_defs.h       |  18 +-
 2 files changed, 1 insertion(+), 532 deletions(-)

diff --git a/bsd-user/freebsd/syscall_nr.h b/bsd-user/freebsd/syscall_nr.h
deleted file mode 100644
index 7f73a6d0f1..0000000000
--- a/bsd-user/freebsd/syscall_nr.h
+++ /dev/null
@@ -1,515 +0,0 @@
-/*
- * System call numbers.
- *
- * DO NOT EDIT-- this file is automatically @generated.
- * $FreeBSD$
- */
-
-#define TARGET_FREEBSD_NR_syscall       0
-#define TARGET_FREEBSD_NR_exit  1
-#define TARGET_FREEBSD_NR_fork  2
-#define TARGET_FREEBSD_NR_read  3
-#define TARGET_FREEBSD_NR_write 4
-#define TARGET_FREEBSD_NR_open  5
-#define TARGET_FREEBSD_NR_close 6
-#define TARGET_FREEBSD_NR_wait4 7
-                                /* 8 is old creat */
-#define TARGET_FREEBSD_NR_link  9
-#define TARGET_FREEBSD_NR_unlink        10
-                                /* 11 is obsolete execv */
-#define TARGET_FREEBSD_NR_chdir 12
-#define TARGET_FREEBSD_NR_fchdir        13
-#define TARGET_FREEBSD_NR_freebsd11_mknod       14
-#define TARGET_FREEBSD_NR_chmod 15
-#define TARGET_FREEBSD_NR_chown 16
-#define TARGET_FREEBSD_NR_break 17
-                                /* 18 is freebsd4 getfsstat */
-                                /* 19 is old lseek */
-#define TARGET_FREEBSD_NR_getpid        20
-#define TARGET_FREEBSD_NR_mount 21
-#define TARGET_FREEBSD_NR_unmount       22
-#define TARGET_FREEBSD_NR_setuid        23
-#define TARGET_FREEBSD_NR_getuid        24
-#define TARGET_FREEBSD_NR_geteuid       25
-#define TARGET_FREEBSD_NR_ptrace        26
-#define TARGET_FREEBSD_NR_recvmsg       27
-#define TARGET_FREEBSD_NR_sendmsg       28
-#define TARGET_FREEBSD_NR_recvfrom      29
-#define TARGET_FREEBSD_NR_accept        30
-#define TARGET_FREEBSD_NR_getpeername   31
-#define TARGET_FREEBSD_NR_getsockname   32
-#define TARGET_FREEBSD_NR_access        33
-#define TARGET_FREEBSD_NR_chflags       34
-#define TARGET_FREEBSD_NR_fchflags      35
-#define TARGET_FREEBSD_NR_sync  36
-#define TARGET_FREEBSD_NR_kill  37
-                                /* 38 is old stat */
-#define TARGET_FREEBSD_NR_getppid       39
-                                /* 40 is old lstat */
-#define TARGET_FREEBSD_NR_dup   41
-#define TARGET_FREEBSD_NR_freebsd10_pipe        42
-#define TARGET_FREEBSD_NR_getegid       43
-#define TARGET_FREEBSD_NR_profil        44
-#define TARGET_FREEBSD_NR_ktrace        45
-                                /* 46 is old sigaction */
-#define TARGET_FREEBSD_NR_getgid        47
-                                /* 48 is old sigprocmask */
-#define TARGET_FREEBSD_NR_getlogin      49
-#define TARGET_FREEBSD_NR_setlogin      50
-#define TARGET_FREEBSD_NR_acct  51
-                                /* 52 is old sigpending */
-#define TARGET_FREEBSD_NR_sigaltstack   53
-#define TARGET_FREEBSD_NR_ioctl 54
-#define TARGET_FREEBSD_NR_reboot        55
-#define TARGET_FREEBSD_NR_revoke        56
-#define TARGET_FREEBSD_NR_symlink       57
-#define TARGET_FREEBSD_NR_readlink      58
-#define TARGET_FREEBSD_NR_execve        59
-#define TARGET_FREEBSD_NR_umask 60
-#define TARGET_FREEBSD_NR_chroot        61
-                                /* 62 is old fstat */
-                                /* 63 is old getkerninfo */
-                                /* 64 is old getpagesize */
-#define TARGET_FREEBSD_NR_msync 65
-#define TARGET_FREEBSD_NR_vfork 66
-                                /* 67 is obsolete vread */
-                                /* 68 is obsolete vwrite */
-#define TARGET_FREEBSD_NR_sbrk  69
-#define TARGET_FREEBSD_NR_sstk  70
-                                /* 71 is old mmap */
-#define TARGET_FREEBSD_NR_freebsd11_vadvise     72
-#define TARGET_FREEBSD_NR_munmap        73
-#define TARGET_FREEBSD_NR_mprotect      74
-#define TARGET_FREEBSD_NR_madvise       75
-                                /* 76 is obsolete vhangup */
-                                /* 77 is obsolete vlimit */
-#define TARGET_FREEBSD_NR_mincore       78
-#define TARGET_FREEBSD_NR_getgroups     79
-#define TARGET_FREEBSD_NR_setgroups     80
-#define TARGET_FREEBSD_NR_getpgrp       81
-#define TARGET_FREEBSD_NR_setpgid       82
-#define TARGET_FREEBSD_NR_setitimer     83
-                                /* 84 is old wait */
-#define TARGET_FREEBSD_NR_swapon        85
-#define TARGET_FREEBSD_NR_getitimer     86
-                                /* 87 is old gethostname */
-                                /* 88 is old sethostname */
-#define TARGET_FREEBSD_NR_getdtablesize 89
-#define TARGET_FREEBSD_NR_dup2  90
-#define TARGET_FREEBSD_NR_fcntl 92
-#define TARGET_FREEBSD_NR_select        93
-#define TARGET_FREEBSD_NR_fsync 95
-#define TARGET_FREEBSD_NR_setpriority   96
-#define TARGET_FREEBSD_NR_socket        97
-#define TARGET_FREEBSD_NR_connect       98
-                                /* 99 is old accept */
-#define TARGET_FREEBSD_NR_getpriority   100
-                                /* 101 is old send */
-                                /* 102 is old recv */
-                                /* 103 is old sigreturn */
-#define TARGET_FREEBSD_NR_bind  104
-#define TARGET_FREEBSD_NR_setsockopt    105
-#define TARGET_FREEBSD_NR_listen        106
-                                /* 107 is obsolete vtimes */
-                                /* 108 is old sigvec */
-                                /* 109 is old sigblock */
-                                /* 110 is old sigsetmask */
-                                /* 111 is old sigsuspend */
-                                /* 112 is old sigstack */
-                                /* 113 is old recvmsg */
-                                /* 114 is old sendmsg */
-                                /* 115 is obsolete vtrace */
-#define TARGET_FREEBSD_NR_gettimeofday  116
-#define TARGET_FREEBSD_NR_getrusage     117
-#define TARGET_FREEBSD_NR_getsockopt    118
-#define TARGET_FREEBSD_NR_readv 120
-#define TARGET_FREEBSD_NR_writev        121
-#define TARGET_FREEBSD_NR_settimeofday  122
-#define TARGET_FREEBSD_NR_fchown        123
-#define TARGET_FREEBSD_NR_fchmod        124
-                                /* 125 is old recvfrom */
-#define TARGET_FREEBSD_NR_setreuid      126
-#define TARGET_FREEBSD_NR_setregid      127
-#define TARGET_FREEBSD_NR_rename        128
-                                /* 129 is old truncate */
-                                /* 130 is old ftruncate */
-#define TARGET_FREEBSD_NR_flock 131
-#define TARGET_FREEBSD_NR_mkfifo        132
-#define TARGET_FREEBSD_NR_sendto        133
-#define TARGET_FREEBSD_NR_shutdown      134
-#define TARGET_FREEBSD_NR_socketpair    135
-#define TARGET_FREEBSD_NR_mkdir 136
-#define TARGET_FREEBSD_NR_rmdir 137
-#define TARGET_FREEBSD_NR_utimes        138
-                                /* 139 is obsolete 4.2 sigreturn */
-#define TARGET_FREEBSD_NR_adjtime       140
-                                /* 141 is old getpeername */
-                                /* 142 is old gethostid */
-                                /* 143 is old sethostid */
-                                /* 144 is old getrlimit */
-                                /* 145 is old setrlimit */
-                                /* 146 is old killpg */
-#define TARGET_FREEBSD_NR_setsid        147
-#define TARGET_FREEBSD_NR_quotactl      148
-                                /* 149 is old quota */
-                                /* 150 is old getsockname */
-#define TARGET_FREEBSD_NR_nlm_syscall   154
-#define TARGET_FREEBSD_NR_nfssvc        155
-                                /* 156 is old getdirentries */
-                                /* 157 is freebsd4 statfs */
-                                /* 158 is freebsd4 fstatfs */
-#define TARGET_FREEBSD_NR_lgetfh        160
-#define TARGET_FREEBSD_NR_getfh 161
-                                /* 162 is freebsd4 getdomainname */
-                                /* 163 is freebsd4 setdomainname */
-                                /* 164 is freebsd4 uname */
-#define TARGET_FREEBSD_NR_sysarch       165
-#define TARGET_FREEBSD_NR_rtprio        166
-#define TARGET_FREEBSD_NR_semsys        169
-#define TARGET_FREEBSD_NR_msgsys        170
-#define TARGET_FREEBSD_NR_shmsys        171
-                                /* 173 is freebsd6 pread */
-                                /* 174 is freebsd6 pwrite */
-#define TARGET_FREEBSD_NR_setfib        175
-#define TARGET_FREEBSD_NR_ntp_adjtime   176
-#define TARGET_FREEBSD_NR_setgid        181
-#define TARGET_FREEBSD_NR_setegid       182
-#define TARGET_FREEBSD_NR_seteuid       183
-                                /* 184 is obsolete lfs_bmapv */
-                                /* 185 is obsolete lfs_markv */
-                                /* 186 is obsolete lfs_segclean */
-                                /* 187 is obsolete lfs_segwait */
-#define TARGET_FREEBSD_NR_freebsd11_stat        188
-#define TARGET_FREEBSD_NR_freebsd11_fstat       189
-#define TARGET_FREEBSD_NR_freebsd11_lstat       190
-#define TARGET_FREEBSD_NR_pathconf      191
-#define TARGET_FREEBSD_NR_fpathconf     192
-#define TARGET_FREEBSD_NR_getrlimit     194
-#define TARGET_FREEBSD_NR_setrlimit     195
-#define TARGET_FREEBSD_NR_freebsd11_getdirentries       196
-                                /* 197 is freebsd6 mmap */
-#define TARGET_FREEBSD_NR___syscall     198
-                                /* 199 is freebsd6 lseek */
-                                /* 200 is freebsd6 truncate */
-                                /* 201 is freebsd6 ftruncate */
-#define TARGET_FREEBSD_NR___sysctl      202
-#define TARGET_FREEBSD_NR_mlock 203
-#define TARGET_FREEBSD_NR_munlock       204
-#define TARGET_FREEBSD_NR_undelete      205
-#define TARGET_FREEBSD_NR_futimes       206
-#define TARGET_FREEBSD_NR_getpgid       207
-#define TARGET_FREEBSD_NR_poll  209
-#define TARGET_FREEBSD_NR_freebsd7___semctl     220
-#define TARGET_FREEBSD_NR_semget        221
-#define TARGET_FREEBSD_NR_semop 222
-                                /* 223 is obsolete semconfig */
-#define TARGET_FREEBSD_NR_freebsd7_msgctl       224
-#define TARGET_FREEBSD_NR_msgget        225
-#define TARGET_FREEBSD_NR_msgsnd        226
-#define TARGET_FREEBSD_NR_msgrcv        227
-#define TARGET_FREEBSD_NR_shmat 228
-#define TARGET_FREEBSD_NR_freebsd7_shmctl       229
-#define TARGET_FREEBSD_NR_shmdt 230
-#define TARGET_FREEBSD_NR_shmget        231
-#define TARGET_FREEBSD_NR_clock_gettime 232
-#define TARGET_FREEBSD_NR_clock_settime 233
-#define TARGET_FREEBSD_NR_clock_getres  234
-#define TARGET_FREEBSD_NR_ktimer_create 235
-#define TARGET_FREEBSD_NR_ktimer_delete 236
-#define TARGET_FREEBSD_NR_ktimer_settime        237
-#define TARGET_FREEBSD_NR_ktimer_gettime        238
-#define TARGET_FREEBSD_NR_ktimer_getoverrun     239
-#define TARGET_FREEBSD_NR_nanosleep     240
-#define TARGET_FREEBSD_NR_ffclock_getcounter    241
-#define TARGET_FREEBSD_NR_ffclock_setestimate   242
-#define TARGET_FREEBSD_NR_ffclock_getestimate   243
-#define TARGET_FREEBSD_NR_clock_nanosleep       244
-#define TARGET_FREEBSD_NR_clock_getcpuclockid2  247
-#define TARGET_FREEBSD_NR_ntp_gettime   248
-#define TARGET_FREEBSD_NR_minherit      250
-#define TARGET_FREEBSD_NR_rfork 251
-                                /* 252 is obsolete openbsd_poll */
-#define TARGET_FREEBSD_NR_issetugid     253
-#define TARGET_FREEBSD_NR_lchown        254
-#define TARGET_FREEBSD_NR_aio_read      255
-#define TARGET_FREEBSD_NR_aio_write     256
-#define TARGET_FREEBSD_NR_lio_listio    257
-#define TARGET_FREEBSD_NR_freebsd11_getdents    272
-#define TARGET_FREEBSD_NR_lchmod        274
-                                /* 275 is obsolete netbsd_lchown */
-#define TARGET_FREEBSD_NR_lutimes       276
-                                /* 277 is obsolete netbsd_msync */
-#define TARGET_FREEBSD_NR_freebsd11_nstat       278
-#define TARGET_FREEBSD_NR_freebsd11_nfstat      279
-#define TARGET_FREEBSD_NR_freebsd11_nlstat      280
-#define TARGET_FREEBSD_NR_preadv        289
-#define TARGET_FREEBSD_NR_pwritev       290
-                                /* 297 is freebsd4 fhstatfs */
-#define TARGET_FREEBSD_NR_fhopen        298
-#define TARGET_FREEBSD_NR_freebsd11_fhstat      299
-#define TARGET_FREEBSD_NR_modnext       300
-#define TARGET_FREEBSD_NR_modstat       301
-#define TARGET_FREEBSD_NR_modfnext      302
-#define TARGET_FREEBSD_NR_modfind       303
-#define TARGET_FREEBSD_NR_kldload       304
-#define TARGET_FREEBSD_NR_kldunload     305
-#define TARGET_FREEBSD_NR_kldfind       306
-#define TARGET_FREEBSD_NR_kldnext       307
-#define TARGET_FREEBSD_NR_kldstat       308
-#define TARGET_FREEBSD_NR_kldfirstmod   309
-#define TARGET_FREEBSD_NR_getsid        310
-#define TARGET_FREEBSD_NR_setresuid     311
-#define TARGET_FREEBSD_NR_setresgid     312
-                                /* 313 is obsolete signanosleep */
-#define TARGET_FREEBSD_NR_aio_return    314
-#define TARGET_FREEBSD_NR_aio_suspend   315
-#define TARGET_FREEBSD_NR_aio_cancel    316
-#define TARGET_FREEBSD_NR_aio_error     317
-                                /* 318 is freebsd6 aio_read */
-                                /* 319 is freebsd6 aio_write */
-                                /* 320 is freebsd6 lio_listio */
-#define TARGET_FREEBSD_NR_yield 321
-                                /* 322 is obsolete thr_sleep */
-                                /* 323 is obsolete thr_wakeup */
-#define TARGET_FREEBSD_NR_mlockall      324
-#define TARGET_FREEBSD_NR_munlockall    325
-#define TARGET_FREEBSD_NR___getcwd      326
-#define TARGET_FREEBSD_NR_sched_setparam        327
-#define TARGET_FREEBSD_NR_sched_getparam        328
-#define TARGET_FREEBSD_NR_sched_setscheduler    329
-#define TARGET_FREEBSD_NR_sched_getscheduler    330
-#define TARGET_FREEBSD_NR_sched_yield   331
-#define TARGET_FREEBSD_NR_sched_get_priority_max        332
-#define TARGET_FREEBSD_NR_sched_get_priority_min        333
-#define TARGET_FREEBSD_NR_sched_rr_get_interval 334
-#define TARGET_FREEBSD_NR_utrace        335
-                                /* 336 is freebsd4 sendfile */
-#define TARGET_FREEBSD_NR_kldsym        337
-#define TARGET_FREEBSD_NR_jail  338
-#define TARGET_FREEBSD_NR_nnpfs_syscall 339
-#define TARGET_FREEBSD_NR_sigprocmask   340
-#define TARGET_FREEBSD_NR_sigsuspend    341
-                                /* 342 is freebsd4 sigaction */
-#define TARGET_FREEBSD_NR_sigpending    343
-                                /* 344 is freebsd4 sigreturn */
-#define TARGET_FREEBSD_NR_sigtimedwait  345
-#define TARGET_FREEBSD_NR_sigwaitinfo   346
-#define TARGET_FREEBSD_NR___acl_get_file        347
-#define TARGET_FREEBSD_NR___acl_set_file        348
-#define TARGET_FREEBSD_NR___acl_get_fd  349
-#define TARGET_FREEBSD_NR___acl_set_fd  350
-#define TARGET_FREEBSD_NR___acl_delete_file     351
-#define TARGET_FREEBSD_NR___acl_delete_fd       352
-#define TARGET_FREEBSD_NR___acl_aclcheck_file   353
-#define TARGET_FREEBSD_NR___acl_aclcheck_fd     354
-#define TARGET_FREEBSD_NR_extattrctl    355
-#define TARGET_FREEBSD_NR_extattr_set_file      356
-#define TARGET_FREEBSD_NR_extattr_get_file      357
-#define TARGET_FREEBSD_NR_extattr_delete_file   358
-#define TARGET_FREEBSD_NR_aio_waitcomplete      359
-#define TARGET_FREEBSD_NR_getresuid     360
-#define TARGET_FREEBSD_NR_getresgid     361
-#define TARGET_FREEBSD_NR_kqueue        362
-#define TARGET_FREEBSD_NR_freebsd11_kevent      363
-                                /* 364 is obsolete __cap_get_proc */
-                                /* 365 is obsolete __cap_set_proc */
-                                /* 366 is obsolete __cap_get_fd */
-                                /* 367 is obsolete __cap_get_file */
-                                /* 368 is obsolete __cap_set_fd */
-                                /* 369 is obsolete __cap_set_file */
-#define TARGET_FREEBSD_NR_extattr_set_fd        371
-#define TARGET_FREEBSD_NR_extattr_get_fd        372
-#define TARGET_FREEBSD_NR_extattr_delete_fd     373
-#define TARGET_FREEBSD_NR___setugid     374
-                                /* 375 is obsolete nfsclnt */
-#define TARGET_FREEBSD_NR_eaccess       376
-#define TARGET_FREEBSD_NR_afs3_syscall  377
-#define TARGET_FREEBSD_NR_nmount        378
-                                /* 379 is obsolete kse_exit */
-                                /* 380 is obsolete kse_wakeup */
-                                /* 381 is obsolete kse_create */
-                                /* 382 is obsolete kse_thr_interrupt */
-                                /* 383 is obsolete kse_release */
-#define TARGET_FREEBSD_NR___mac_get_proc        384
-#define TARGET_FREEBSD_NR___mac_set_proc        385
-#define TARGET_FREEBSD_NR___mac_get_fd  386
-#define TARGET_FREEBSD_NR___mac_get_file        387
-#define TARGET_FREEBSD_NR___mac_set_fd  388
-#define TARGET_FREEBSD_NR___mac_set_file        389
-#define TARGET_FREEBSD_NR_kenv  390
-#define TARGET_FREEBSD_NR_lchflags      391
-#define TARGET_FREEBSD_NR_uuidgen       392
-#define TARGET_FREEBSD_NR_sendfile      393
-#define TARGET_FREEBSD_NR_mac_syscall   394
-#define TARGET_FREEBSD_NR_freebsd11_getfsstat   395
-#define TARGET_FREEBSD_NR_freebsd11_statfs      396
-#define TARGET_FREEBSD_NR_freebsd11_fstatfs     397
-#define TARGET_FREEBSD_NR_freebsd11_fhstatfs    398
-#define TARGET_FREEBSD_NR_ksem_close    400
-#define TARGET_FREEBSD_NR_ksem_post     401
-#define TARGET_FREEBSD_NR_ksem_wait     402
-#define TARGET_FREEBSD_NR_ksem_trywait  403
-#define TARGET_FREEBSD_NR_ksem_init     404
-#define TARGET_FREEBSD_NR_ksem_open     405
-#define TARGET_FREEBSD_NR_ksem_unlink   406
-#define TARGET_FREEBSD_NR_ksem_getvalue 407
-#define TARGET_FREEBSD_NR_ksem_destroy  408
-#define TARGET_FREEBSD_NR___mac_get_pid 409
-#define TARGET_FREEBSD_NR___mac_get_link        410
-#define TARGET_FREEBSD_NR___mac_set_link        411
-#define TARGET_FREEBSD_NR_extattr_set_link      412
-#define TARGET_FREEBSD_NR_extattr_get_link      413
-#define TARGET_FREEBSD_NR_extattr_delete_link   414
-#define TARGET_FREEBSD_NR___mac_execve  415
-#define TARGET_FREEBSD_NR_sigaction     416
-#define TARGET_FREEBSD_NR_sigreturn     417
-#define TARGET_FREEBSD_NR_getcontext    421
-#define TARGET_FREEBSD_NR_setcontext    422
-#define TARGET_FREEBSD_NR_swapcontext   423
-#define TARGET_FREEBSD_NR_swapoff       424
-#define TARGET_FREEBSD_NR___acl_get_link        425
-#define TARGET_FREEBSD_NR___acl_set_link        426
-#define TARGET_FREEBSD_NR___acl_delete_link     427
-#define TARGET_FREEBSD_NR___acl_aclcheck_link   428
-#define TARGET_FREEBSD_NR_sigwait       429
-#define TARGET_FREEBSD_NR_thr_create    430
-#define TARGET_FREEBSD_NR_thr_exit      431
-#define TARGET_FREEBSD_NR_thr_self      432
-#define TARGET_FREEBSD_NR_thr_kill      433
-#define TARGET_FREEBSD_NR_jail_attach   436
-#define TARGET_FREEBSD_NR_extattr_list_fd       437
-#define TARGET_FREEBSD_NR_extattr_list_file     438
-#define TARGET_FREEBSD_NR_extattr_list_link     439
-                                /* 440 is obsolete kse_switchin */
-#define TARGET_FREEBSD_NR_ksem_timedwait        441
-#define TARGET_FREEBSD_NR_thr_suspend   442
-#define TARGET_FREEBSD_NR_thr_wake      443
-#define TARGET_FREEBSD_NR_kldunloadf    444
-#define TARGET_FREEBSD_NR_audit 445
-#define TARGET_FREEBSD_NR_auditon       446
-#define TARGET_FREEBSD_NR_getauid       447
-#define TARGET_FREEBSD_NR_setauid       448
-#define TARGET_FREEBSD_NR_getaudit      449
-#define TARGET_FREEBSD_NR_setaudit      450
-#define TARGET_FREEBSD_NR_getaudit_addr 451
-#define TARGET_FREEBSD_NR_setaudit_addr 452
-#define TARGET_FREEBSD_NR_auditctl      453
-#define TARGET_FREEBSD_NR__umtx_op      454
-#define TARGET_FREEBSD_NR_thr_new       455
-#define TARGET_FREEBSD_NR_sigqueue      456
-#define TARGET_FREEBSD_NR_kmq_open      457
-#define TARGET_FREEBSD_NR_kmq_setattr   458
-#define TARGET_FREEBSD_NR_kmq_timedreceive      459
-#define TARGET_FREEBSD_NR_kmq_timedsend 460
-#define TARGET_FREEBSD_NR_kmq_notify    461
-#define TARGET_FREEBSD_NR_kmq_unlink    462
-#define TARGET_FREEBSD_NR_abort2        463
-#define TARGET_FREEBSD_NR_thr_set_name  464
-#define TARGET_FREEBSD_NR_aio_fsync     465
-#define TARGET_FREEBSD_NR_rtprio_thread 466
-#define TARGET_FREEBSD_NR_sctp_peeloff  471
-#define TARGET_FREEBSD_NR_sctp_generic_sendmsg  472
-#define TARGET_FREEBSD_NR_sctp_generic_sendmsg_iov      473
-#define TARGET_FREEBSD_NR_sctp_generic_recvmsg  474
-#define TARGET_FREEBSD_NR_pread 475
-#define TARGET_FREEBSD_NR_pwrite        476
-#define TARGET_FREEBSD_NR_mmap  477
-#define TARGET_FREEBSD_NR_lseek 478
-#define TARGET_FREEBSD_NR_truncate      479
-#define TARGET_FREEBSD_NR_ftruncate     480
-#define TARGET_FREEBSD_NR_thr_kill2     481
-#define TARGET_FREEBSD_NR_freebsd12_shm_open    482
-#define TARGET_FREEBSD_NR_shm_unlink    483
-#define TARGET_FREEBSD_NR_cpuset        484
-#define TARGET_FREEBSD_NR_cpuset_setid  485
-#define TARGET_FREEBSD_NR_cpuset_getid  486
-#define TARGET_FREEBSD_NR_cpuset_getaffinity    487
-#define TARGET_FREEBSD_NR_cpuset_setaffinity    488
-#define TARGET_FREEBSD_NR_faccessat     489
-#define TARGET_FREEBSD_NR_fchmodat      490
-#define TARGET_FREEBSD_NR_fchownat      491
-#define TARGET_FREEBSD_NR_fexecve       492
-#define TARGET_FREEBSD_NR_freebsd11_fstatat     493
-#define TARGET_FREEBSD_NR_futimesat     494
-#define TARGET_FREEBSD_NR_linkat        495
-#define TARGET_FREEBSD_NR_mkdirat       496
-#define TARGET_FREEBSD_NR_mkfifoat      497
-#define TARGET_FREEBSD_NR_freebsd11_mknodat     498
-#define TARGET_FREEBSD_NR_openat        499
-#define TARGET_FREEBSD_NR_readlinkat    500
-#define TARGET_FREEBSD_NR_renameat      501
-#define TARGET_FREEBSD_NR_symlinkat     502
-#define TARGET_FREEBSD_NR_unlinkat      503
-#define TARGET_FREEBSD_NR_posix_openpt  504
-#define TARGET_FREEBSD_NR_gssd_syscall  505
-#define TARGET_FREEBSD_NR_jail_get      506
-#define TARGET_FREEBSD_NR_jail_set      507
-#define TARGET_FREEBSD_NR_jail_remove   508
-#define TARGET_FREEBSD_NR_freebsd12_closefrom   509
-#define TARGET_FREEBSD_NR___semctl      510
-#define TARGET_FREEBSD_NR_msgctl        511
-#define TARGET_FREEBSD_NR_shmctl        512
-#define TARGET_FREEBSD_NR_lpathconf     513
-                                /* 514 is obsolete cap_new */
-#define TARGET_FREEBSD_NR___cap_rights_get      515
-#define TARGET_FREEBSD_NR_cap_enter     516
-#define TARGET_FREEBSD_NR_cap_getmode   517
-#define TARGET_FREEBSD_NR_pdfork        518
-#define TARGET_FREEBSD_NR_pdkill        519
-#define TARGET_FREEBSD_NR_pdgetpid      520
-#define TARGET_FREEBSD_NR_pselect       522
-#define TARGET_FREEBSD_NR_getloginclass 523
-#define TARGET_FREEBSD_NR_setloginclass 524
-#define TARGET_FREEBSD_NR_rctl_get_racct        525
-#define TARGET_FREEBSD_NR_rctl_get_rules        526
-#define TARGET_FREEBSD_NR_rctl_get_limits       527
-#define TARGET_FREEBSD_NR_rctl_add_rule 528
-#define TARGET_FREEBSD_NR_rctl_remove_rule      529
-#define TARGET_FREEBSD_NR_posix_fallocate       530
-#define TARGET_FREEBSD_NR_posix_fadvise 531
-#define TARGET_FREEBSD_NR_wait6 532
-#define TARGET_FREEBSD_NR_cap_rights_limit      533
-#define TARGET_FREEBSD_NR_cap_ioctls_limit      534
-#define TARGET_FREEBSD_NR_cap_ioctls_get        535
-#define TARGET_FREEBSD_NR_cap_fcntls_limit      536
-#define TARGET_FREEBSD_NR_cap_fcntls_get        537
-#define TARGET_FREEBSD_NR_bindat        538
-#define TARGET_FREEBSD_NR_connectat     539
-#define TARGET_FREEBSD_NR_chflagsat     540
-#define TARGET_FREEBSD_NR_accept4       541
-#define TARGET_FREEBSD_NR_pipe2 542
-#define TARGET_FREEBSD_NR_aio_mlock     543
-#define TARGET_FREEBSD_NR_procctl       544
-#define TARGET_FREEBSD_NR_ppoll 545
-#define TARGET_FREEBSD_NR_futimens      546
-#define TARGET_FREEBSD_NR_utimensat     547
-                                /* 548 is obsolete numa_getaffinity */
-                                /* 549 is obsolete numa_setaffinity */
-#define TARGET_FREEBSD_NR_fdatasync     550
-#define TARGET_FREEBSD_NR_fstat 551
-#define TARGET_FREEBSD_NR_fstatat       552
-#define TARGET_FREEBSD_NR_fhstat        553
-#define TARGET_FREEBSD_NR_getdirentries 554
-#define TARGET_FREEBSD_NR_statfs        555
-#define TARGET_FREEBSD_NR_fstatfs       556
-#define TARGET_FREEBSD_NR_getfsstat     557
-#define TARGET_FREEBSD_NR_fhstatfs      558
-#define TARGET_FREEBSD_NR_mknodat       559
-#define TARGET_FREEBSD_NR_kevent        560
-#define TARGET_FREEBSD_NR_cpuset_getdomain      561
-#define TARGET_FREEBSD_NR_cpuset_setdomain      562
-#define TARGET_FREEBSD_NR_getrandom     563
-#define TARGET_FREEBSD_NR_getfhat       564
-#define TARGET_FREEBSD_NR_fhlink        565
-#define TARGET_FREEBSD_NR_fhlinkat      566
-#define TARGET_FREEBSD_NR_fhreadlink    567
-#define TARGET_FREEBSD_NR_funlinkat     568
-#define TARGET_FREEBSD_NR_copy_file_range       569
-#define TARGET_FREEBSD_NR___sysctlbyname        570
-#define TARGET_FREEBSD_NR_shm_open2     571
-#define TARGET_FREEBSD_NR_shm_rename    572
-#define TARGET_FREEBSD_NR_sigfastblock  573
-#define TARGET_FREEBSD_NR___realpathat  574
-#define TARGET_FREEBSD_NR_close_range   575
-#define TARGET_FREEBSD_NR_rpctls_syscall        576
-#define TARGET_FREEBSD_NR_MAXSYSCALL    577
diff --git a/bsd-user/syscall_defs.h b/bsd-user/syscall_defs.h
index 4dbd90c2f1..30b0270faa 100644
--- a/bsd-user/syscall_defs.h
+++ b/bsd-user/syscall_defs.h
@@ -25,29 +25,13 @@
 
 #include "errno_defs.h"
 
-#include "freebsd/syscall_nr.h"
+#include "os-syscalls.h"
 
 /*
  * machine/_types.h
  * or x86/_types.h
  */
 
-/*
- * time_t seems to be very inconsistly defined for the different *BSD's...
- *
- * FreeBSD uses a 64bits time_t except on i386
- * so we have to add a special case here.
- *
- * On NetBSD time_t is always defined as an int64_t.  On OpenBSD time_t
- * is always defined as an int.
- *
- */
-#if (!defined(TARGET_I386))
-typedef int64_t target_time_t;
-#else
-typedef int32_t target_time_t;
-#endif
-
 struct target_iovec {
     abi_long iov_base;   /* Starting address */
     abi_long iov_len;   /* Number of bytes */

-- 
2.52.0


