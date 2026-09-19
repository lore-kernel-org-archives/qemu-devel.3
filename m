Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 108C1C982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 16:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7yGp-0004mX-Kb; Sat, 19 Sep 2026 12:50:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFw-0003vL-63
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:45 -0400
Received: from mail-oo2-x0d.google.com ([2607:f8b0:4864:31::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1x7yFu-0008Qm-8c
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 12:49:39 -0400
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6bcc0c495efso965663eaf.3
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2026 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1789836576; x=1790441376;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NrpL46Nay44SFqEpTz9O0LUdm+A+DGPsy/qGZpi6vus=;
 b=iYyInU1uyxjT58KqDmXI8jvl5jN1DmckxrP7Vs6HSL+JzbJ/W/ly5vcHSmgUjvxHhc
 GRR5wm7NlMnEFUvdxmPZWrNYGW0gQLCfb7cF2+RHSTn2dTIAj9BihSCIetmbB/YkCaaw
 cWiA/Al2b0O94twQ2Zn6sGOqWQe2dSZSiOEBh1QPcuvP7Z+hnD78CoKkHaUtaf0IddJY
 mu2YvlAtrhCmhGJojWePn8OjKkpsk5gMcF+fleTPXrxJdKCj9aCRINNx4bgo1w9ah+gT
 55bAW8sfsWvy8Eu3kWl4LWKy3/mExNFqv4fvEmciMFFgpzjosWIrxMTpWyAV3CzBGy6u
 rkEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789836576; x=1790441376;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NrpL46Nay44SFqEpTz9O0LUdm+A+DGPsy/qGZpi6vus=;
 b=11EFlMxiMqk+ah7d+5GxsxoXXHAPY+k/HDuiX0yD968Qv/g4gsB4lfcskZ4Q73nv/n
 L/Q/GTg19KfE1xrsMHKK8JNfPy5T1nVegbxyKAfSraC0jXFo/gua8fqYdBIdHc9qFG2H
 fqtt09ud3jvVqxajMUhR1ySgEkVPVthLpyzrWrJAXt71gmsjkQ1EUrYFXW9N/SsM+is6
 jaOHGYKOBCo9e48hldLJaIIx9mfN/eQd1ALyfKTcq72Iti9hPJIXsWR6/47KWTsFXGPx
 txwAJHgsqWHihoMk7mptjnZdA0sItx0+dXdmLq/EJynXUnTfnEqcCKJ5cEjYRakMo3IT
 OhKQ==
X-Gm-Message-State: AFuF++nsJAe11R5HVYcKoijTPVV8zJ3XIeL+wPa1NeeZuWW8VkFgUbPc
 DjAUkKfNGlZeKPQtVZHZj+ND211sl4cEm5rx/kp7XJmomuuD2OaelNa6Z/owkJTN2o9u6i85xFo
 ICQyJJzc=
X-Gm-Gg: AYBFou3jPMdXALdCLoVJPVoYA+6xsF521Oe9mKEQDk1tlUo6ls4tuJcygOoePHYlf6q
 bzk0Nw7gsGmsHqYk4bbrlYDE0KIgmzpiOFCyNZrYjR2c3OU+dUG7aodnpdpCBtqI4W6L9PCkhI1
 UJJb08MxUKU9F1nR/Fx/gHIPeLbbYq42zhMExLqc46PU3zcXUStmh4x2lwhWyfcZxV5D2LTTH1K
 2883Ihv6DOWKitI/DH1c3vSY5yqAjuSudjztTKIIhaAiI8lDtFZhNOPwsG4yxi9lSyqKAL1EmrZ
 dBLwZcj2WWMWxwCsb5+zBJk1KI7u6SZ+5prx4Q7b0WFf4KXTOXi3KEKhECwEQ/68LBiIYhEDDNy
 FmNdNFUcJUaGwT9b9cREU7PCEM5SGLlK23+08Je9nWLRgMf0t6WQ+n/cC3GF600MQkH8YvTsNyd
 ZY33eTSvqvRCoBqq77MhwFkjQQ2XhW1fZ/5jijQkOVgrQAWB8IorwQMRq/vw==
X-Received: by 2002:a05:6820:f06:b0:6b7:8415:d77d with SMTP id
 006d021491bc7-6ca9c058dfbmr4589336eaf.40.1789836576559; 
 Sat, 19 Sep 2026 09:49:36 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6cd35712c0csm3281927eaf.11.2026.09.19.09.49.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Sep 2026 09:49:35 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Stacey Son <sson@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 35/41] bsd-user: Add ACL system call shims to os-extattr.h
Date: Sat, 19 Sep 2026 10:48:03 -0600
Message-ID: <20260919164810.70151-36-imp@bsdimp.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260919164810.70151-1-imp@bsdimp.com>
References: <20260919164810.70151-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:31::d; envelope-from=imp@bsdimp.com;
 helo=mail-oo2-x0d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, SPF_HELO_NONE=0.001,
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

Complete os-extattr.h with ACL operations: __acl_aclcheck_fd,
__acl_aclcheck_file, __acl_aclcheck_link, __acl_delete_fd,
__acl_delete_file, __acl_delete_link, __acl_get_fd, __acl_get_file,
__acl_get_link, __acl_set_fd, __acl_set_file, and __acl_set_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 289 +++++++++++++++++++++++++++++++++-
 1 file changed, 285 insertions(+), 4 deletions(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 90f0c64c93..b6fe9051f1 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -65,7 +65,7 @@ static inline abi_long do_freebsd_extattr_set_file(abi_long arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_file(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -151,7 +151,7 @@ static inline abi_long do_freebsd_extattr_set_fd(abi_long arg1, abi_long arg2,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_fd(arg1, arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
 
     return ret;
@@ -267,7 +267,7 @@ static inline abi_long do_freebsd_extattr_set_link(abi_long arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -376,5 +376,286 @@ static inline abi_long do_freebsd_extattr_list_link(
  *  Access Control Lists
  */
 
+/* __acl_aclcheck_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_fd(abi_long arg1, abi_long arg2,
+                                                   abi_long arg3)
+{
+    abi_long ret;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_fd(arg1, type, &host_acl));
+    }
+
+    return ret;
+}
+
+/* __acl_aclcheck_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_file(abi_long arg1,
+                                                     abi_long arg2,
+                                                     abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_file(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* __acl_aclcheck_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_link(abi_long arg1,
+                                                     abi_long arg2,
+                                                     abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_link(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_delete_fd(int filedes, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_fd(abi_long arg1, abi_long arg2)
+{
+    abi_long ret;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    return get_errno(__acl_delete_fd(arg1, type));
+}
+
+/* int __acl_delete_file(const char *path, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_file(abi_long arg1,
+                                                   abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_delete_file(path(p), type));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_delete_link(const char *path, acl_type_t type); */
+static inline abi_long do_freebsd__acl_delete_link(abi_long arg1,
+                                                   abi_long arg2)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_delete_link(path(p), type));
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_get_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_fd(abi_long arg1, abi_long arg2,
+                                              abi_long arg3)
+{
+    abi_long ret;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
 
-#endif /* FREEBSD_OS_EXTATTR_H */
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = get_errno(__acl_get_fd(arg1, type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+
+    return ret;
+}
+
+/* __acl_get_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_file(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_get_file(path(p), type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_get_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_link(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    memset(&host_acl, 0, sizeof(struct acl));
+    host_acl.acl_maxcnt = ACL_MAX_ENTRIES;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = get_errno(__acl_get_link(path(p), type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_set_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_fd(abi_long arg1, abi_long arg2,
+                                              abi_long arg3)
+{
+    abi_long ret;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_fd(arg1, type, &host_acl));
+    }
+
+    return ret;
+}
+
+/* int __acl_set_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_file(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_file(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* int __acl_set_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_set_link(abi_long arg1, abi_long arg2,
+                                                abi_long arg3)
+{
+    abi_long ret;
+    void *p;
+    acl_type_t type;
+    struct acl host_acl;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    if (is_error(ret)) {
+        return ret;
+    }
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_set_link(path(p), type, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
-- 
2.55.0


