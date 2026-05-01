Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884D6CD13DA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 03:09:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIeFv-0004CW-Ne; Thu, 30 Apr 2026 23:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFu-0004CJ-B2
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:30 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wIeFs-0008UF-Mq
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 23:09:30 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7de4ed0593fso987102a34.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1777604967; x=1778209767;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lUbDl4QgIbmOuxVLNZcdjXvd3ED4AO2j72fBIWJqpD4=;
 b=0eMfVzCaB2vAlKj7HTsZGlfdg9+qBbGHqrI/GAzELErAIuvZdqZNP3NhOhv3qrIhv3
 lGv8vAv3HFV4X78O+2GWwTCRgrdAnbzwcTuK2kdAMUIIfKoHSZZST+JovI2+qbvHQf8H
 UGt6M2UlNXQOG4+GuwPLkxWFDFmqYZR182MPBnX8aTUELF2J6Q07l33aifThysLRQWf0
 e0/ai3jeE9z7jASekpPRILPK1qcI2BUtDrhS8cUsrmGGKOjhkbW9Fw1W7ueazoHONqCO
 isgWBQGBMYyNJ5TY3dA7zadpacoJ+m1I/6OtDspeYVuvuCJV76NZnXzwKiU4A64vO/mK
 +H5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777604967; x=1778209767;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lUbDl4QgIbmOuxVLNZcdjXvd3ED4AO2j72fBIWJqpD4=;
 b=gq92j+DCP+Tw5KnBgg0SLCJ/RaM/hjXeNbJlA+2Ym0u5rsTvr+8nGmaYgamta7Ey7c
 FPjhrv8Mg5efRV69RDNaAi8gXQaAPPamOqSWcJPxFlre2NgdphzvvMtZVbxQK4WJnT0B
 dMRBFDgHyVYo2FjXa98ZsQNHx2N6d8Z6xv6qCr7ATczzPxNsMjMZ8/zz2o0N7brrRgWa
 CFCPOsx0wQyqIVjEkV4hdpDjZvZmNM5H/rYeZwWuoqdTlTOjqtQnQkliHCZ/zQuGGJBL
 hcz29nB3pxFbQFPh+ANL8lYwQoDmpMvn6jzjEWJElOOvjDFguflmtVjatucKbnSPzrUH
 vShQ==
X-Gm-Message-State: AOJu0YzcAStcfzWsP7qSh3mZoNUCBDdbfhAo6kQkNg7jqJfiF3qAHX4y
 zy0Sii3oIUBZ2ISdzMUfzmtacwT8xakCrZ3QyHnS6IZGKNNcBBkXygrz4r1Q0CuAyEXtcV9NapH
 ehkRPRug=
X-Gm-Gg: AeBDievz0oDPKXEZP7IxNWCsVInhE15t4IsQJoCy8PU0AorwJaRR+7tYUreF8F1/CI+
 6x4ysXlPwU0kvT0iDu2nxxK6Xim7KycXVYb5ewm8Z/R+1JfsOfQAIxkeKiOdroTMkwJHOGr66K5
 gjQZU2/QZHJ3Gd+FPNS2B7PaGLp5cCILZjHcyGq8MA9D+S6iQWacp6oMHZiDSGM9iE4Ap1pk1UE
 P5TqvGdAl2SKEjlxZtEIlXZuQ6RjzYibXssuJh4qPQHjo4ixndnR/oGUSRsx4ZYv9h45eCndyA5
 YueNCTodphht+Cz73B5bAay/NzApw8CL4h72SJYMHu3c9Va11H8orpPDViLk5SrxRp+vfin10Y0
 iWqweyZ5HsjfaWukSsFvMD6m+UqFEnUzHA8insexFOc/BYp8grJs7PsdooqPprzAx9fK02j+pjK
 5CgoE0/HZtmycgqQHHeti9
X-Received: by 2002:a05:6830:668c:b0:7dc:db04:d30b with SMTP id
 46e09a7af769-7deba0c379bmr3185339a34.9.1777604967358; 
 Thu, 30 Apr 2026 20:09:27 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deca278d0bsm1238476a34.0.2026.04.30.20.09.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 20:09:26 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Thu, 30 Apr 2026 21:07:37 -0600
Subject: [PATCH v4 2/4] bsd-user: Delete sbrk and sstk system calls.
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-syscall-nr-v4-2-80f512079a16@bsdimp.com>
References: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
In-Reply-To: <20260430-syscall-nr-v4-0-80f512079a16@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3103; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=s1cNkl7oaOVINYGeXHehc9QlFbfyzLUyBMhD1vHNmOA=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp9BkEQwkd8eIodphfajPLYsE8/mlktfqwU4ecq
 qeE3B17yFSJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCafQZBAAKCRBsHNEofbAR
 ABP5EACqw24qmbV71RAgXIYgodVVn4tdIQQ4H4NxDBN56dQYPVedkDxZqTK/3NoLi2FJ2RFjA9p
 T6e1IcKKdROnFLUhtGD3hZAccGpZu24P+qstKgDmXl5nVowpt1yUhCnYUMo6td22MW53TBnPpBw
 dbLC96hWxdH6Diegnd3Rzugfn6PLJQe+s2KykxKganRQgJFDcoMIW+n/oHT9cR4aGdkNoC+Nvbe
 P1wesWn+JsUoNIa+za6k+3cSxL8xWNmQXobDGYpvM6Qza1lxlrOP+7sBTTB6XYZaNNOMxfLdW/w
 5tuzq1E9oJ2d8nla+CyUSKK2qZpp/KBAHtEdcy3DaiGnXfHZMOCbB1osU0V2VxvLKU1Ikwi5Rrt
 bd7nCX5k2nsDtAgf9kjYfWeU/0QM4ILIpVw4Y6j/faiGuxi2EeFs3SDXFfDXyY2yUB1O9O3+ZDt
 QtlGSwAKeQxMWMxWfwCJZD4UoeFs1w5CZdbRCa7HoqyBNJVUUQR6LUrs/AmHqdGv7MKx0yh0Pu8
 Njz1pvWm31Tnr4qd9asSnXrCHBp8UCQf5jst8zTL+9Cn9xz4FiAC2Z4kJxalg4Blos1O0OcYgC9
 7kZc7VK2wfEceEh0W6DBunxSXsihsurhkr0LCIgJNTAWiwWDpN0S3QO4krIRCCftHkut7tXC3DB
 cUIdFLi1qB+HjBA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::32e;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32e.google.com
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

sbrk and sstk were an experimental system call introduced in 4.2BSD, but
with an blank implementation. They remained in subsequent 4BSD releases
doing nothing (with 4.3-Reno and later returning not supported). FreeBSD
1.x imported this. They were removed in 2023. Remove them from here
because no real, non-contrived program on FreeBSD ever had them.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 2 ++
 bsd-user/freebsd/os-syscall.c | 8 --------
 bsd-user/freebsd/strace.list  | 4 ++++
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index a118e57260..a20b703053 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -440,6 +440,7 @@ static inline abi_long do_bsd_vadvise(void)
     return -TARGET_EINVAL;
 }
 
+#ifdef TARGET_FREEBSD_NR_sbrk
 static inline abi_long do_bsd_sbrk(void)
 {
     /* see sys_sbrk() in vm_mmap.c */
@@ -451,5 +452,6 @@ static inline abi_long do_bsd_sstk(void)
     /* see sys_sstk() in vm_mmap.c */
     return -TARGET_EOPNOTSUPP;
 }
+#endif
 
 #endif /* BSD_USER_BSD_MEM_H */
diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
index 85e5db19a3..ca819fc530 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -918,14 +918,6 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_vadvise();
         break;
 
-    case TARGET_FREEBSD_NR_sbrk:
-        ret = do_bsd_sbrk();
-        break;
-
-    case TARGET_FREEBSD_NR_sstk:
-        ret = do_bsd_sstk();
-        break;
-
         /*
          * Misc
          */
diff --git a/bsd-user/freebsd/strace.list b/bsd-user/freebsd/strace.list
index 275d2dbe27..d7f61f480e 100644
--- a/bsd-user/freebsd/strace.list
+++ b/bsd-user/freebsd/strace.list
@@ -194,7 +194,9 @@
 { TARGET_FREEBSD_NR_rfork, "rfork", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_rmdir, "rmdir", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_rtprio_thread, "rtprio_thread", "%s(%d, %d, %p)", NULL, NULL },
+#ifdef TARGET_FREEBSD_NR_sbrk
 { TARGET_FREEBSD_NR_sbrk, "sbrk", NULL, NULL, NULL },
+#endif
 { TARGET_FREEBSD_NR_sched_get_priority_max, "sched_get_priority_max", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_sched_get_priority_min, "sched_get_priority_min", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_sched_yield, "sched_yield", NULL, NULL, NULL },
@@ -234,7 +236,9 @@
 { TARGET_FREEBSD_NR_sigsuspend, "sigsuspend", NULL, NULL, NULL },
 { TARGET_FREEBSD_NR_socket, "socket", "%s(%d,%d,%d)", NULL, NULL },
 { TARGET_FREEBSD_NR_socketpair, "socketpair", NULL, NULL, NULL },
+#ifdef TARGET_FREEBSD_NR_sstk
 { TARGET_FREEBSD_NR_sstk, "sstk", NULL, NULL, NULL },
+#endif
 { TARGET_FREEBSD_NR_freebsd11_stat, "freebsd11_stat", "%s(\"%s\",%p)", NULL, NULL },
 { TARGET_FREEBSD_NR_freebsd11_statfs, "freebsd11_statfs", "%s(\"%s\",%p)", NULL, NULL },
 { TARGET_FREEBSD_NR_symlink, "symlink", "%s(\"%s\",\"%s\")", NULL, NULL },

-- 
2.52.0


