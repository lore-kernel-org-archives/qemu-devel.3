Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96889C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 23:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThX-000454-1Q; Tue, 18 Aug 2026 19:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThV-0003rg-J6
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:37 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThT-0005JN-F8
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:37 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-45171f2f608so360867fac.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097514; x=1787702314;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vIRP7vHdDkTJIM07J0XPiTI0WNHgFjIkgYXGcoTOMw=;
 b=wSLfRiA1i6eInvkzH2tLmz04zyT3owpiplLQpq9rb3s2RUlWpRNttqAfIOfxEc8h9I
 L9feMSN2Hu9L+bY7RzWvAduwJ7Xd2vYt/h6J9xdNNuNaqcR74nlpCTG1lqsv+jdBCO6q
 1qLMMbBFQuMXx6karn4jXlS2DyQol0uRDNsf9/vZmma50XZMlTWR/eweamIKMXM+A4r4
 nHoJ20YJcXghri8FxvoeVkOHUTXnF6jewWkM9CA9FA7BBeX2BtdoZH/H3RoEPqhwC5x5
 mJKu880Rfuq7dclOl9+q1kjCXyjkE95TVuv2gF01SuuoZYX14SqjnEi/vLjwpAQQp1tt
 CSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097514; x=1787702314;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+vIRP7vHdDkTJIM07J0XPiTI0WNHgFjIkgYXGcoTOMw=;
 b=m1z2eydpP/9xALBaRnUlDUOD717ei1RFY4+2NF1JXzlYr2D9cQTei8POgNwzWSxLt4
 QhXl0XXih84fKDt2jwdxP4kpPupkWCdhYnwM/JcV/EhtZBOlu3UiNKhmZdrh5feZZhj2
 P+4sd972wIlvVuANbthZsiH9U/jhIOUilibr1UZT1wETgMFYax/caosBYakTsODcJxzS
 TT43ZtvDPHXCuGqL+QPviF6OEiApyuZTZbc1AV4r5pTkSx8/1Zk6QO5XVO4nNx8vqr9x
 6hEv9iSkylHslgkiDW848qpTWjmM2yhK+sBXBFGp684amr0tMEK6YdxPnExlVKnjnp6+
 bIdw==
X-Gm-Message-State: AOJu0YyhsqKJ1rQc+sMyDNViPl59Mv2F1RhDXxjuZagElMLuIpTByhA2
 vAPLJgJfIqRt3hrJElelCggJCYMy8gd5BACmBDIbANmjM53xsKCjkPqo3YDOd7fCcx0=
X-Gm-Gg: AR+sD13gas+4RkH9IxoUoA8qyrtK/XNH/qI1wW9W94vz0SAktevFgE01djURRB1kM8F
 Y5PCSnarbF6IoIsst1X8sF2tlJPScjsuALtr2fnSvG23Czi9lIVX1Vb6wpYEuZCQ5Wpa/svhSJW
 SRJebLJvRLm0ci14NcDUVy2Mz4u+whVUskCVVIscHnqxmR7FFM5qQX+wKyebW12g+HjJc1HfXs0
 tosYXH5UhO5vVZnckdhz6aMdTVleAp7ikGIb8VLrsRN/FHURLvRk1i3u6plGmALNdr2P5Dzn7kt
 3Azaow8HzDocsdRV868UI3VT8kNx4lA4z8kop+qp8kuPdTTZ5gSLi78LHFHKo/LuxU/phZvxU77
 C6xeZJ/uXJYrsORQMJf6Sj/4uUXUMi/ZCoGxvsXX/wGbe3gYE7o9gkkmMdraGltI/2na0nmcA55
 dOTGODyrgtYV0mtlyPcMu2KUh/m7yb2T4mgLQKiYXrqPUVk2o=
X-Received: by 2002:a05:6808:c29c:b0:4a4:adaf:5570 with SMTP id
 5614622812f47-4b2bc88560amr434811b6e.4.1787097514208; 
 Tue, 18 Aug 2026 16:58:34 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:33 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:25 -0600
Subject: [PATCH v4 32/40] bsd-user: Add os-extattr.h with file and fd
 extattr functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-32-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6777; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=9YkJiVvIXG8lckaWBpyWlUTMGtly8iFSggR0diI9Fbo=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFS8s+PADlMRCHh8/KEdxZUvan+msZdgdIou
 ZBlclqENMeJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxUhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQAu6hAAjy3eZf/bwJ92PVYCngrrsrH0p1FgiUT
 DA+zNt+6GANMO/EPjpBrX5EOGZ/S7DSPHwzoeYzgvzAvrCb4bdxHEUdW4S+BFWhOCK5C5TpC830
 LdckOQUI9/Dea/OD59W6ZwJ0A4D+3dITJG6YhEzi+Fwogoa9qiT8z0cVLoaOoR2jHfR2M/nBvTl
 Odyf9sB+JfHUjVJeddIfv6i+Oyaw1w+gVDPT56H8AXfKGwIpA4OXZ/FXO2mrStePbT4JjlvnDFC
 fqqrhysyamHY655cF3cZ7q411tZRCWJmhHgKKQSxfvLm7D9Ji1S4R3cKOd0vPj1vCsSedypjjkS
 LIGn5wPhNu4UWXxposH1tUo0k8hhCcIX2yGgHvjyPZZQedSpAbGnmm4LZ5qyKThdpEb6y1m6w3t
 l3coBY7MDSnggIOOCr3JCfV89ZCLzCZ9ssCnDqRUBMqpXEfUiQVPNZFEfq8qgyKTK1cjQ2txn0d
 Eln52dSS5TCP0erS8DK5zzrRDyNtjJ/SzIwqZQQRslpfVrIbOJkSyT+MiPLJfVVvOCpM0hFBsIx
 /oEIPhLZ/cPTNwY2YUEB1vgYZA70mcf6MuZzAHl2tKomOEWfacHKCQY6+gQgyOjjSVXTQGCrBcN
 6NK4hcf1ssHvIvLDil+5sOq3y8afMrV4DBNwWGZSPNzqITzauz6w=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2001:4860:4864:20::2d;
 envelope-from=imp@bsdimp.com; helo=mail-oa1-x2d.google.com
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
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 208 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 208 insertions(+)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
new file mode 100644
index 0000000000..fb3ef27346
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
+static inline abi_long do_freebsd_extattr_set_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
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
+static inline abi_long do_freebsd_extattr_get_file(abi_long arg1,
+                                                   abi_long arg2,
+                                                   abi_long arg3,
+                                                   abi_long arg4,
+                                                   abi_long arg5)
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
+static inline abi_long do_freebsd_extattr_delete_file(abi_long arg1,
+                                                      abi_long arg2,
+                                                      abi_long arg3)
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
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
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
+                                                 abi_long arg3, abi_long arg4,
+                                                 abi_long arg5)
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
+                                                    abi_long arg3)
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
2.55.0


