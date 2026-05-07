Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194E4CD342C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 02:32:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKoWp-0000x4-23; Wed, 06 May 2026 22:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVV-0007T3-Ia
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:34 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wKoVS-0000VD-S0
 for qemu-devel@nongnu.org; Wed, 06 May 2026 22:30:32 -0400
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso320404a34.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 19:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778121022; x=1778725822;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vXEfs1TaESiD4JHlvL5ysOYZtnmF0KSz463zLYe2his=;
 b=CNfSNWwENlujMEJ4CWkkoBqr85aQYpLZ9yJb39XF0RaeS8wOGVYQkR+a30pluy0TP/
 3mcA8pzcoaxl2R7lHqZJ4NeWyVeE3DwQbOJ96wLv6AdXs5HOh94+v/BB9JolW54AsxSk
 C2DKWRTivB0HRqvimNLGzscdulB4sH14jqCRGI4cNG+1HKSv+I1qOE6L6JQLEIYykpUz
 179le083pSLBjTJBmyuRRipjjidyHQuB1IrX6a8dY+p/ZIgVzVs+/LNSImEK8r+PhbV8
 rCXl9avhFsvC+cjBSaxDRpvsW3y/YJ1zXtBttS7BoObxCv8BehPKiuiOJbHqheSX6UDE
 2ZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778121022; x=1778725822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vXEfs1TaESiD4JHlvL5ysOYZtnmF0KSz463zLYe2his=;
 b=bkfaIO1VuQQBv4Mb5reQY3kXCFF0KEA6fKN6qXBk2ACPqaiQSpvgIxgFRJ+UsPe8+O
 8AsQ1DiyiorzFUd9AvSsfypucLrNpmAnr97TTnpnPVCUIHXnG7GPsxqZ8Ye0gVdDZaRZ
 vvfZUzXA+kRWRbq0WRbcadNaOYTSTworeBsM+b3CjHAxF1VOdN3cEQicFztYQgSMgN7l
 gthK0SffKCnSoBmHUm02LiFfm0VOmjjC3HS8xc4o+wsOkVsV3KFLHF5OpOe3LKcjTNys
 CqBcGqUv8Eg8502ccLDm0NTo5JtngkqhQf29NzarctlRCQViQA4k8dF4aqqaPYycWAee
 BAhQ==
X-Gm-Message-State: AOJu0YwGWmd5eqJEoCWJRv1fujoK/2BnFLdV6MYPLgriXbKwTQoyIYX8
 w5wagU0zbSJDHGLwgz7hTP19iHjZwvzyeO5jizZuSoMV5/Z/eFEittT8FA3XOex6lrC3Kwo/rlj
 UtREmCL4=
X-Gm-Gg: AeBDiev1cFWaLu/0MCOjfN1+mBXujQ2PPg6/hxZRt/NLDJ3Mc5obt2lixWrEGml3cZO
 UPYs/CgwV3UgdWRg7GCok/0LhW5GECtGrJ/IJGM5lsn8gN2tkzENj4jfmFL0O7vt11ssv4ckPBY
 ThIk1EH3zjnYg9iHjto6BQqkND+SNk3q3qLFkddbcA+RqsoYVeHBWuDTmf1Oj8g9rtL4j24yDxF
 Z/7qD3cfITHv5KjxldMJyIgTOwYC8nS9yLT7kFad2qm4NNmxmuoJCiQtwAWG+Zmg+IzD54RcNzn
 jguO1dTg5aInELz6+Ay5Cv4IQJtO5w5vlYj741k+CDg+JUBPxeEMRNiJnFwGlF/w7xHu/LyDd9F
 BQp4wIIB51AIEcuwMsm38A9nPKnXNCgxXvQb7eihU+n9yRhYWhd2Hthtgu1ldFR70lcZ7uVmxEH
 K66PN7ohboeWSC9m9QvuDOKfYGT2ds+SM=
X-Received: by 2002:a05:6830:6acc:b0:7dd:9b19:a875 with SMTP id
 46e09a7af769-7e1deea2a08mr3413490a34.2.1778121022236; 
 Wed, 06 May 2026 19:30:22 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ded1915908sm12465247a34.14.2026.05.06.19.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 19:30:21 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 03/25] bsd-user: Delete sbrk and sstk system calls.
Date: Wed,  6 May 2026 20:28:05 -0600
Message-ID: <20260507022827.44499-4-imp@bsdimp.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260507022827.44499-1-imp@bsdimp.com>
References: <20260507022827.44499-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32b;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x32b.google.com
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


