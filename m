Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95793CD98CE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 15:51:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY49m-00016N-6Z; Fri, 12 Jun 2026 11:50:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49l-00016E-2L
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:53 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1wY49i-00087T-Gd
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 11:50:52 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 969AC60008;
 Fri, 12 Jun 2026 15:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3AFB1F000E9;
 Fri, 12 Jun 2026 15:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781279449;
 bh=m4IDSyjWcAzO6Xi7rKP9aTp7TUacMkhUAjZNmS+VHtQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=J6LVtuxCkZjs38hy9uChhIfA9qolsVCdbJvrXys5kD5TSEzpwM/oOx3frAAmVM94E
 NNtBVkLNhIZZB6OtVqmZ903ifq+g/b22k64aa5WZWxWVxGxOKvP2zodDiG8zeU8dxd
 OXRUBcZLvg36fAR+VW2yiGjy7D9slm6tGB7t9UZyQaJqB0FRF6VzFH1DOjbwUZk6Eq
 uTTiK5enUzendJe4D+Nmk53vjikVfjdjQOQ6ZlVcSJsKqmrvLqQNu6IWubQ23PzXCm
 dqaxZoQiJxfuGAT5I7kY5fMj8xugAbcOGHz0kKhkVABYfljSQUTBbGc0YqR/594rHM
 wKNng3BACp0rg==
From: Helge Deller <deller@kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>,
	qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>,
 Dominique Martinet <dominique.martinet@atmark-techno.com>
Subject: [PULL 1/4] linux-user: add preadv2/preadv2
Date: Fri, 12 Jun 2026 17:50:40 +0200
Message-ID: <20260612155043.3552-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612155043.3552-1-deller@kernel.org>
References: <20260612155043.3552-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 linux-user/syscall.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 37ede95510..fbe357b7e0 100644
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
@@ -11907,6 +11912,39 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
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
2.54.0


