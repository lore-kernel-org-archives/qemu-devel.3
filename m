Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86192F34C63
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 15:35:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCJIU-0006Yz-0E; Mon, 13 Apr 2026 11:33:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHT-0006G9-8R
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:59 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wCJHO-0002xZ-Px
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 11:32:53 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbdcb85067so3900152a34.1
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 08:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1776094369; x=1776699169;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AmvbF5GskSMHDhBS/LrUX5lQkYg+vIg4dPk2lYcDN7E=;
 b=QhQBzMczbI67bxqgjdLRpvC+WWjjDDVnjUGXbmDxlgLaTw4a2lDiYK2ubhecjn+TEy
 LoG5W5BPgb3xFVpU1NFcuU27Y0ZcxzvRP9Do+nSU3vAOwqKRIAEMeee4sEz0buPolsfO
 NX4ZlacYXsGkoPaUcsPi559nLxzgOLb6APgeVD5IDrbpvhjUZv+svNux7r0FMXtvhhhF
 jywv03G2UfILJ88PzeBZDUPXhR02Subg43oJ2H01tAc5BuJ0prJfT+2VUEkdTlnJT92/
 TdTXNTiF0te/TFJOPVqcH6k9b/nFKmFkDCt++X/JEJg1s+N91BXhLTrUpqAgia+xnRBY
 qTxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094369; x=1776699169;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AmvbF5GskSMHDhBS/LrUX5lQkYg+vIg4dPk2lYcDN7E=;
 b=PaarjlUWJeCnnEbtRxtpZHev8GoW4N0/J2D1mb4hK9JJUeCe29S41On92fk8fALIQO
 FgTnv87Qw/4TbYnPh/zH/SyVmwATQIKHPQPc7zSWwvBa8++MHTirYwc1fT6fzhDM2LH8
 LmQh2KR8ky/ePMElwuuP1HSpfMc1AAPUN8U3FuSzNGhlqKrVCFR1wJy62JkUevBI20v9
 MWPr3yRKHacUn4l/0BuJxlny03YHEXlLaUCHVzGovxfa9OazYBSNP/lKTzXOc1hZhem3
 ptzsB05tTDL7xn8iGC68Sbp9SbAcKm6ovHyQgKI2bBeSQDpdndHKvtEukByk4lTJnpph
 Oo7w==
X-Gm-Message-State: AOJu0YwLTs4X7NhR2mQVSX8kUsXcCuRmcPHEk4qJftCNCm2u6UMfc6H5
 OHzucOmfxBKKoZEgIO0KqYF0AQziUqqXt5Zcd7f0CzY2+BZbTVKuliHhbZq3MD1+4SA=
X-Gm-Gg: AeBDietpl9zWwuWRk8eCsS7dsyG5kG4pai2YUHUbsEgE2l+2RvDk4NoLS4Xky3NNeku
 mXn1h9cOeYdlyhRmrogUSByJX9f8LIGAzM1gneItqWRK1lK2+MW23C3bhmMC2VWrJw97j7SVhla
 pFaM7duWNvZesFcvlstbbqqXo4y06nyAVKQtJ3o3hyf+MYwBt4j2u1hwHGWyqmTjzO/ff9JtUcE
 pvKtA8tuLKP/eLYVmFyAn51tYeBe2O1XquqSDJct+eAgwDj9pT9wKtPCw8WAhNRWKCXk1Z5CQ+1
 OpLnf4r26ZG2Ed0lU/qZPmqbSR82vXVn0QklDOzjIseRlT6E/KOR4Zr/YeSfsDHsPaFNvaioZHN
 JQSXgoQZsQsZRptPIxgetCRnngm+PHbhuZptw3Y+cV4CqIhOu2llw7AfK3VJQTXZvLolKdihpnt
 d9ixk28NKgJA==
X-Received: by 2002:a05:6830:449f:b0:7d9:d2b6:1568 with SMTP id
 46e09a7af769-7dc27f116ffmr8308118a34.17.1776094369350; 
 Mon, 13 Apr 2026 08:32:49 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696c463sm8659192a34.23.2026.04.13.08.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:32:48 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 13 Apr 2026 09:31:45 -0600
Subject: [PATCH 3/5] bsd-user: Conditionally use old system calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-syscall-nr-v1-3-f70408d042ea@bsdimp.com>
References: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
In-Reply-To: <20260413-syscall-nr-v1-0-f70408d042ea@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Warner Losh <imp@bsdimp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2934; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=AAA2sEDUfonupSz6GdEDbAccdghK7ix8HdBm9YVzmCs=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBp3QxpkZMKlLgWA+E+uZAnrLKEXIh+/wZbyAaz8
 yutE4ZJo5OJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCad0MaQAKCRBsHNEofbAR
 ACWTD/0Uq7VPpNEjQO0NzEEq+0le8QZA9+O2RDJXZn+MxUPz0Oxu83Kj3Tv9TPcQlY+WsE4epg8
 4ywJS0o2OHEff71tJT6K6KrtilKCKOlS6wTX3EJleehwaYajP9nDUh8HQg2av6A+Y/IecKLa1JX
 rQ058X/rIUfPDKfQXnMkAcr1XC6vu/5LE0xGuyJLszKkCuMEmfQ9rrGQfbEkrc9CSTaJ0BQ5ln7
 QR/zu2pPn6adL/8/2bDyWYYJ88roOwRwc9j351MKkvkPoJQQJZ/lVIy3UNe/N8WUIN9cjp+vFJX
 E6kYShXxnvSr0QMP/H5Ka90DThIVJHx6xlad/Tx0OXOLwloAYF3gNe1XqcpIhLjV3dWzNE0IClJ
 zZaA6Y/my/H62aumcKLKRgrga4NkBRshvKEsAaGdqC4+RWl5x0eEKf83j18yc9EAgnI7guZHilP
 AiMqavuw8utbP0VMTS4sULksrD4nmjJTUORO6uPgJYQRVUEi+COrxp98dwA7BfAYnCQBMt8A+Rr
 uIPMWorwMUbsFwp+r5aFv0pav1bE7xvSBNuXV6q4m0Del9SNF8dfGjcyOIyI7L/7ue/FdPbmQvu
 6PVDk75Y4QUcd7R6cyv89Ug8AoAR/Po+mRL0XyFaex8lh5H067XrXaJjyKBJYl4vit/4wZDksZL
 FuUSoUjaFpnUytw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::329;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x329.google.com
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

sbrk and sstk have been deprecated in FreeBSD for a while now, only
support them if the version of FreeBSD we're compiling on does. They've
returned not supported for a while anyway, so no net change.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/bsd-mem.h            | 2 ++
 bsd-user/freebsd/os-syscall.c | 4 ++++
 bsd-user/freebsd/strace.list  | 4 ++++
 3 files changed, 10 insertions(+)

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
index 85e5db19a3..ff6cbfc481 100644
--- a/bsd-user/freebsd/os-syscall.c
+++ b/bsd-user/freebsd/os-syscall.c
@@ -918,13 +918,17 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
         ret = do_bsd_vadvise();
         break;
 
+#ifdef TARGET_FREEBSD_NR_sbrk
     case TARGET_FREEBSD_NR_sbrk:
         ret = do_bsd_sbrk();
         break;
+#endif
 
+#ifdef TARGET_FREEBSD_NR_sstk
     case TARGET_FREEBSD_NR_sstk:
         ret = do_bsd_sstk();
         break;
+#endif
 
         /*
          * Misc
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


