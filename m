Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F13BECDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:48:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNqH-0007Kr-Bb; Wed, 24 Jun 2026 09:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNqD-00079x-VV; Wed, 24 Jun 2026 09:40:34 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNqB-0001Zs-SO; Wed, 24 Jun 2026 09:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308000; bh=IC8fy+lrNSCIA7DyirnI+qUtNnrwGtlcAjyFid+uikg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=qfur8RRKIpq/fffBhAg4xQCm4ubdqKxD1zQq3cXoZfNNvTqVVO6DTgeup9MkWDSeY
 J5GNODdoQ9q78dHi050icOr9g823Pp3tz4GZDdUQ2Kw9mFLYakYz2BvgnmkLCG28wW
 FWt0PD/yR1UfWfvK4tILeyc0RFmBIJJ/ATRo5n/4x0xsNUtFC9V5RRAakXtldRnn//
 usl2Y4EGpcHE2Tfn7UPJs78HB5tPm76L4ejxIj9dabOFWkeqq6oWeIHVBf/XiQlQrU
 Wf3jbtF6HtJi8aYRSMU8kUnpNSG5BPlJFYlNTaAyntIwn6RISDgGyOBw4U2/G/xoIk
 VuO1CaFZ56Ikw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 61D691BA9FC;
 Wed, 24 Jun 2026 16:33:20 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id F3C433DEA4B;
 Wed, 24 Jun 2026 16:33:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Dominique Martinet <dominique.martinet@atmark-techno.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 074/107] linux-user: add preadv2/preadv2
Date: Wed, 24 Jun 2026 16:31:19 +0300
Message-ID: <20260624133301.403266-74-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dominique Martinet <dominique.martinet@atmark-techno.com>

Some programs apparently use these, like the python test suite.

The flags argument (rwf_t) is an int, with values shared on all arches
and does not need translating.

This was tested manually with the following python script:
```
import os
fd = os.open('test', os.O_RDWR|os.O_CREAT)
os.pwritev(fd, [b'test', b'ok'], 0, os.RWF_HIPRI)
buf = [bytearray(3), bytearray(10)]
os.preadv(fd, buf, 0, os.RWF_HIPRI)
print(buf[0])
print(buf[1])
```

Signed-off-by: Dominique Martinet <dominique.martinet@atmark-techno.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit fb4c08147ba79c552897427a42e3b24b38712786)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 993718973a..11d3b41dff 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -741,6 +741,11 @@ safe_syscall5(ssize_t, preadv, int, fd, const struct iovec *, iov, int, iovcnt,
               unsigned long, pos_l, unsigned long, pos_h)
 safe_syscall5(ssize_t, pwritev, int, fd, const struct iovec *, iov, int, iovcnt,
               unsigned long, pos_l, unsigned long, pos_h)
+safe_syscall6(ssize_t, preadv2, int, fd, const struct iovec *, iov, int, iovcnt,
+              unsigned long, pos_l, unsigned long, pos_h, __kernel_rwf_t, flags)
+safe_syscall6(ssize_t, pwritev2, int, fd, const struct iovec *, iov,
+              int, iovcnt, unsigned long, pos_l, unsigned long, pos_h,
+              __kernel_rwf_t, flags)
 safe_syscall3(int, connect, int, fd, const struct sockaddr *, addr,
               socklen_t, addrlen)
 safe_syscall6(ssize_t, sendto, int, fd, const void *, buf, size_t, len,
@@ -11847,6 +11852,39 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
            }
         }
         return ret;
+#endif
+#if defined(TARGET_NR_preadv2)
+    case TARGET_NR_preadv2:
+        {
+            struct iovec *vec = lock_iovec(VERIFY_WRITE, arg2, arg3, 0);
+            if (vec != NULL) {
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_preadv2(arg1, vec, arg3, low, high, arg6));
+                unlock_iovec(vec, arg2, arg3, 1);
+            } else {
+                ret = -host_to_target_errno(errno);
+           }
+        }
+        return ret;
+#endif
+#if defined(TARGET_NR_pwritev2)
+    case TARGET_NR_pwritev2:
+        {
+            struct iovec *vec = lock_iovec(VERIFY_READ, arg2, arg3, 1);
+            if (vec != NULL) {
+                unsigned long low, high;
+
+                target_to_host_low_high(arg4, arg5, &low, &high);
+                ret = get_errno(safe_pwritev2(arg1, vec, arg3, low, high,
+                                              arg6));
+                unlock_iovec(vec, arg2, arg3, 0);
+            } else {
+                ret = -host_to_target_errno(errno);
+           }
+        }
+        return ret;
 #endif
     case TARGET_NR_getsid:
         return get_errno(getsid(arg1));
-- 
2.47.3


