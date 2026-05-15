Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D89BCD4851
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxW-00021I-3Y; Fri, 15 May 2026 17:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxU-0001v7-EY
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:36 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxS-00032n-9A
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:36 -0400
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7dbca22dbfeso156259a34.1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880033; x=1779484833;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=M1JQVOiuc+A4ksNToUTMbfJYQEFXRR5y86p07JOscgc=;
 b=Z6pwwVObwQFHMnkJXCv9yaEsFb2E9tMy7oiIYMvMiSrQDCFyHyaXuJvJcstB7pMVdG
 Yd8goKLotV4Dup9WNeTXkucwnn9UAj71qVPV3kvrJCJrzIUG4iYFyElqHbTKvoWqQ2uW
 viuiG0TLWBognyExc4lfWG7YKHVEbB1J81ZqJXyC/4bLoevzmQCS3wj/fTKrTIxatjQu
 3lcOF6O4zUKQ0+76N0nkT9/PJlejbHfJ8MAdgKJZDOD05DyBfXOn8yVq6UQ/LM+8jlpM
 GeRs4DdlUxFpxMcuW9Lh6wmdkux+tYMUsDF6SjEjWQT+itVoihptASmrKeUhM/1SkFls
 //5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880033; x=1779484833;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=M1JQVOiuc+A4ksNToUTMbfJYQEFXRR5y86p07JOscgc=;
 b=ZyUHlZsg73KHY1iiykiF/O/GhJkr0U8PRwm+MlXg54Dw01PCFttrzOfoQXmfOpn8rI
 SpscqJf/VflU18lpCsjt8aKuMwRAaPuL2ftP9p4BIKeUp5/fFzKsC1cFBtG0Asssdb+X
 UoB9geL4WCWSlHN2v9oygIibnY9mm4BMmOyN5kNfdZPpOJ+AJIsuFx+4EtBK6vHaGLIu
 /QCzvWZ8MbcZNblacNnfRALZN3chrLT10PEyIiAlSVUrIPtflDvckeSDMar/FoqXoHxW
 JweoOPTN3wWghaHmOYTxzNGwqy6SN4n3GJAltPq3mEUTAeaF/mQSEIjenccqJy/t87wr
 iLFg==
X-Gm-Message-State: AOJu0YwyrbWlGu+gBR05Djt5CT3tJkZy0+0nz8ggKIEIZlF873QqVNzC
 eOrBsAiTNQkqbuikOKwmPR6Qqg5Dh9+9rJ/8IcnqmclTaqfDzC7F+KfsWnelycR9CzI1ZMjXzDH
 zyzPhpiA=
X-Gm-Gg: Acq92OHi0ZULsqjpUHiMxOgVYynPvq34SK8L7Yrrrh8CePktSNb9MQDZgsyY8WwZy+1
 CrHvDWuc9kNtoV++TFQm/9Q/sdpPyihnxA+rw8e79RQDK0kD8uab/BRrKqHjJwf8CY2UpEWyL7c
 vuugZ7Qd8rrtL55petdWsl7xnD2JEdnUJ7JGxxLUeDUPspjiiKG50PIfX5d3y2XAz0xSc5pN4Z4
 nwBehB+LQOrCMayayX7yAv8AQe38dWls5GaW+dxOurCUvDaZ4yjsb/WEYHSHewUxPc2kI4tExGg
 RRuljGi20SfU/c48rv/9cOzsoh4WDNVVN6qFIrTpx3O/3QUzpIvp6w38j0nEPNpNgxhvXriBgOl
 KhvV40LU2AKeUmGFwnT+dWgKRSPrfVZkTMqgrmTDSIZIswnkwWxFKiqtOpveVsRGa0B2r5aO5Ur
 W/Ara8NzaIMhmEpqYl74Qv
X-Received: by 2002:a05:6830:82e7:b0:7de:4fc6:a588 with SMTP id
 46e09a7af769-7e4fa0477ebmr3839760a34.23.1778880033274; 
 Fri, 15 May 2026 14:20:33 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:32 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:29 -0600
Subject: [PATCH 30/66] bsd-user: Add os-extattr.h with file and fd extattr
 functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-30-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6734; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=Mm8GHafCndpbMfsQZNiUocUTnedWT7NJI/bDY50K/R0=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43ks1dMqyj97dJlx9/0Zg8sCYqiMnoH6Nn1V
 Xlh6TW2JwmJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 AOxHEADkP3wkejv9LK7Ur8sSw4j0pPr3S/Bq1Kp6dRN7fHGUmeeev/JV29AXNLWykHpAkKZM530
 oMv2A+xlVe+nX4H1efPpr5yCXtvfwxAzIrT/FjOzclLXdVoKwrDNiy2ueKmlbSX/4uaCzQ8f88s
 rnmU8nGk3COUlMTuBQYo13Y5lU55/Y/4WUaJrwnOgrgsiB5tkKFYtsHkkVj2UTvjKy5Euq+HbCx
 PPxGUki6CN0BPXZ142OES1hfIIbAvjJImcizYT5G8EsPKRO4uktpGBlNpI10zZsBMcmXdAsDFbR
 WPU7n3rJ1UZfsp/EatZdRmG2Sw+be3SV9KdOgodps0pin/umS0RbCEJPrKDhwPfqt+3TsgYsPcZ
 mAvnn+OYui+/EhJag+zcmsVXIlqVFGu5g/1iKxzAACPDNFaz1zS/sexVwm3TiZbBPuhrGeBEHFx
 6C5LfOtlVLJu9PATcbqtq/vyaQvsQJe3NsgNYRPo2dYJ96ZfZ++gkNd738jRBdnRNh7VFG/asLG
 cDkwe1NqZREoGhG/8S9Lze4NCGmw7ykvnWX1mLXIY+oCIe3eBbwEGOHZmihBo+VWrz5JzHkI4Fm
 sHM1wTvXLzLG2Z4Qihnmm6RdhTAcsAIYPpx38Wtcs79yGd3yVoU4Uxj9c67o9s9B3/bFd/YJn8t
 TzojA8KC7qCyv6Q==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::331;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x331.google.com
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

Add the first part of extended attribute support: extattrctl,
extattr_set_file, extattr_get_file, extattr_delete_file,
extattr_set_fd, extattr_get_fd, and extattr_delete_fd.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
new file mode 100644
index 0000000000..f1dfa344cf
--- /dev/null
+++ b/bsd-user/freebsd/os-extattr.h
@@ -0,0 +1,208 @@
+/*
+ * FreeBSD extended attributes and ACL system call support
+ *
+ * Copyright (c) 2013 Stacey D. Son
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include <sys/extattr.h>
+#include <sys/acl.h>
+
+/* extattrctl() */
+static inline abi_long do_freebsd_extattrctl(abi_ulong arg1, abi_ulong arg2,
+                                             abi_ulong arg3, abi_ulong arg4,
+                                             abi_ulong arg5)
+{
+    abi_long ret;
+    void *p, *a, *f;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    f = lock_user_string(arg3);
+    if (f == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg5);
+    if (a == NULL) {
+        unlock_user(f, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattrctl(path(p), arg2, f, arg4, a));
+    unlock_user(a, arg5, 0);
+    unlock_user(f, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_file(2) */
+static inline abi_long do_freebsd_extattr_set_file(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_get_file(2) */
+static inline abi_long do_freebsd_extattr_get_file(abi_ulong arg1,
+                                                   abi_long arg2,
+                                                   abi_ulong arg3,
+                                                   abi_ulong arg4,
+                                                   abi_ulong arg5)
+{
+    abi_long ret;
+    void *p, *a, *d;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            unlock_user(p, arg1, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_file(path(p), arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_file(path(p), arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_delete_file(2) */
+static inline abi_long do_freebsd_extattr_delete_file(abi_ulong arg1,
+                                                      abi_long arg2,
+                                                      abi_ulong arg3)
+{
+    abi_long ret;
+    void *p, *a;
+
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        unlock_user(p, arg1, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_file(path(p), arg2, a));
+    unlock_user(a, arg3, 0);
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* extattr_set_fd(2) */
+static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
+                                                 abi_ulong arg3, abi_ulong arg4,
+                                                 abi_ulong arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    d = lock_user(VERIFY_READ, arg4, arg5, 1);
+    if (d == NULL) {
+        unlock_user(a, arg3, 0);
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
+    unlock_user(d, arg4, arg5);
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_get_fd(2) */
+static inline abi_long do_freebsd_extattr_get_fd(abi_long arg1, abi_long arg2,
+                                                 abi_ulong arg3, abi_ulong arg4,
+                                                 abi_ulong arg5)
+{
+    abi_long ret;
+    void *a, *d;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+
+    if (arg4 && arg5 > 0) {
+        d = lock_user(VERIFY_WRITE, arg4, arg5, 0);
+        if (d == NULL) {
+            unlock_user(a, arg3, 0);
+            return -TARGET_EFAULT;
+        }
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, d, arg5));
+        unlock_user(d, arg4, arg5);
+    } else {
+        ret = get_errno(extattr_get_fd(arg1, arg2, a, NULL, arg5));
+    }
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+/* extattr_delete_fd(2) */
+static inline abi_long do_freebsd_extattr_delete_fd(abi_long arg1,
+                                                    abi_long arg2,
+                                                    abi_ulong arg3)
+{
+    abi_long ret;
+    void *a;
+
+    a = lock_user_string(arg3);
+    if (a == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(extattr_delete_fd(arg1, arg2, a));
+    unlock_user(a, arg3, 0);
+
+    return ret;
+}
+
+
+#endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.52.0


