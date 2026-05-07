Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C6BCD3436
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoPW-00063z-Uf; Wed, 06 May 2026 22:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPV-00063l-Di
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:21 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoPT-0007bY-SG
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:24:21 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-691de293326so189611eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778120658; x=1778725458;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXEfs1TaESiD4JHlvL5ysOYZtnmF0KSz463zLYe2his=;
 b=XMSExbMgcyVy1ozWAWmWi7pIFJ7vG7HjhW6JwsLxUFnnsOkoFmcZT1jBNvnIUtRQDb
 yEYZfGkWVZlivxRq9IhAtRmfi+5XyPsKP/CeDAhlo5QPc0O6gDmsbmk5VxV0v2Y05El7
 gkv9e1/SI8Wf2qVDVTWH/YE92KN2xKT2/J7y8M82+ZnOhMMrIn4rcpSO/kEi5+OAV5zG
 w2S9EE4tY/N/xTD95RgDmsmcraYy59SdpTEutB82uYeBdArCsYRBASRst61l8FntH4TU
 dgoCMFMvQMBUeYOkjGqqPbRFnThdGT0X3ZTidj9E2v/P2I9CGVvLX9XsGzNtSIJp/TVr
 SPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778120658; x=1778725458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vXEfs1TaESiD4JHlvL5ysOYZtnmF0KSz463zLYe2his=;
 b=n3kyl4f788t0HKEARwzwdU6BqIfcS9uwblLFBrPIodefiPz83JlI3V1SR9YvHjxtEe
 vgSEFkNlGwAV5blETy5/dmjlnDkKCZIvGBNdQgfrfOFbGGntn2gBPwtasxi035UoCWL2
 BBt6rbOy4jP/ThkBp3DrQSjGk3OCvJ/kJBQyB7rY2gfboGy/zb+xlcIkvF/hN6ch3y31
 46l4p7CXBpx7grUAi5FLXkaIceqhnEnSCG/DMIosbfj12vr51gfH5/2vXxjHtB5aF2w3
 b8hYhTHQNrEeJmjOjq6TcF2vhwTlHYoHQnioKtEip8+uP+p+/UjNuB8X/9vjRMQw9MCl
 ck/Q==
X-Gm-Message-State: AOJu0YwVxnK9u17nJ5Rim/61MyQq4H6vYkrICzBSO+2keDtyZ/UYNIZG
 EqFdDQfrfWmB5vgCGp51ga/cWtA+oERr6uSrj6EbDirKPHtO5K+PD+IKH1REO58VE2Ny1ilFqKr
 ucz0xb8M=
X-Gm-Gg: AeBDieuSOg6xh6+SnwMHOqL+GaI1GE+yopduYpHQQF5PTize63UgSup0qCIATT1adzt
 S3jwEBk/tBDsLe37JoKDkIm6EsxRC+7qF0cs88nSJz+/YiMXcz8rM/CJ3dDKViBuB6eFnj7pf7d
 k78/MZcqJyj0vZ/Sf7GdDIS5DR8Bz2uFPQR5ty0oNXlDmZusZK8kJMGZEaQJLm1F4fNZVEp4c3G
 pROBsS4XT+zh0c7SY4yBPVFOMxbgjts0cdI3iEbenrXJhSFKTBi3nlvOgdK0+l7ERTU2VFS8U4o
 BE/M3rjWNOPldGaUHjQ8JKIED8A7x8V0thBkqwFvo6AJI08RMYLsouYJmnBhC4HCXdsWvESbUDC
 JgdoC9yBZfNvrELWFteNncBTwI7kf2QTzOhHfUaPs37wZHLc12uGY8smTFTsgsGI79APiUd9mvd
 Ti5JHAsoVJthAwCwB2leuI0KWkCnpxmRg=
X-Received: by 2002:a05:6820:1f11:b0:687:d51c:e637 with SMTP id
 006d021491bc7-69998c8feacmr3450441eaf.7.1778120658407; 
 Wed, 06 May 2026 19:24:18 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-696896e72c4sm11088118eaf.9.2026.05.06.19.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:24:17 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 03/25] bsd-user: Delete sbrk and sstk system calls.
Date: Wed,  6 May 2026 20:21:57 -0600
Message-ID: <20260507022219.44171-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022219.44171-1-imp@bsdimp.com>
References: <20260507022219.44171-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::c30;
 envelope-from=imp@bsdimp.com; helo=mail-oo1-xc30.google.com
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
 bsd-user/bsd-mem.h            | 13 -------------
 bsd-user/freebsd/os-syscall.c |  8 --------
 bsd-user/freebsd/strace.list  |  4 ++++
 3 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index 8c0b0b6919..9d7b60d3c3 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -428,17 +428,4 @@ static inline abi_long do_bsd_vadvise(void)
     /* See sys_ovadvise() in vm_unix.c */
     return -TARGET_EINVAL;
 }
-
-static inline abi_long do_bsd_sbrk(void)
-{
-    /* see sys_sbrk() in vm_mmap.c */
-    return -TARGET_EOPNOTSUPP;
-}
-
-static inline abi_long do_bsd_sstk(void)
-{
-    /* see sys_sstk() in vm_mmap.c */
-    return -TARGET_EOPNOTSUPP;
-}
-
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


