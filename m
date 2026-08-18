Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87736C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwThb-0004os-OX; Tue, 18 Aug 2026 19:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThZ-0004Tf-7e
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:41 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wwThX-0005Ju-3d
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 19:58:40 -0400
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4ab70b882c5so352465b6e.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1787097518; x=1787702318;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=InJhhPKRd86QYmRjr765HrYUh1madqHVtCg9pVUqYg4=;
 b=Kj/r6jQx6uAHc9pmvngkIpB0VeASS1NuLF4cIT65ynURw3RbX9BZNLI8UFYb2ofBee
 WuugBM7IZZOeIk5BybN/+eETT2SLEXIOVlwf3phfkxEBhMAqqj/Z/Fi9BOwkPiNkFptp
 qlchhXNsRbO06CnKEyQp5Jle+Fwd0J+j+RmIUbf7n3WCODCrDDig3IoBO9HGznSxQ6hr
 h0lTOLGubZnqhIV2QY9RabAzoGunFHQbZNhwu1YHji4+cLLcmC49Dog7ctnpP0ppPm7O
 VbkRAPzMrgVh0PTnx5GTYaNM2rromcH+lv35IWzsHHj0ohrYHTkPGsmxUMoAbbOVtxYn
 Qviw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097518; x=1787702318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=InJhhPKRd86QYmRjr765HrYUh1madqHVtCg9pVUqYg4=;
 b=rKhyQYXdYNgfRtTO8p0MOFyr6SVBFh1ihV6e7qc+LTJFfJUpN2QUvzOmP23+6ZEiOl
 Ih34E33DGMDXUYizDA3q5lEXAZ0hVuRbTNtgx+It1qaEaL06xgrXudXgLrxqzlptdAmL
 iz1TmMZlRYU382q0+RTZU1j1X14WKn8w0aubAz15fGz3FUClckhvCfrJW6J4ofkaF+9c
 oFk0UHzYzFKY5KztqKoR9gWxv1Dr8MgHXhGwUiD63yBujilHNYfNx25snzqeAnQSsmoy
 V6rDveyaGyznXggDGjPPJo37oGYwVi7Fu6qBuLYWi5zzCmmI0oIICpSQsuPLwkxVkpAb
 NbRA==
X-Gm-Message-State: AOJu0Yylod1wW4D9gVF19nMfYB6Dixy+Tt4Bf1hCSU/jejRknLC9UX4c
 45ehrY+Z9yySrUbIDl+uILmW+0ab4ukEsGfvmmHRnbATlf1VSyPOtxe2WmDlw+9eB1I=
X-Gm-Gg: AR+sD11g/7EoXzG2qyEmBUf4OItkvMsVuL0v3ZgCyVAJAsIKOLnS7VwQz2z5Rkkgmx1
 TCTOP0CuHvgzv9Hpxh1PmUM96nh7r6d+owat2qbk6csR01AHTqxcZbgoiSGl77P1RRbgDRXlOpv
 M/h9I1YZ/iSBC4DuVTlTM5WW+nLz4V2LFO1MfOoAsVXZJpbTvW5jq3N3cUTmaQ2odV3LbLdB33e
 nZJVQf3HBluJJwyGqJVG7ztfFae5E21/gGuKLvVbz9oS1wk0gryivqz3O8bQSGnc7ima6s9fY+/
 Vp+r/ca0mUEa/an1T3NI4xvO9ZDz2qWcxR/ChwEM/qT9VHPFeGI6uNQPssqpz2hYZNTM4YgD1/n
 0HplzyNvOtZsTfroTy5iV+lZB0DbZdgUYhDzGNaos0zI5dw7oXpHxtbc5TTrGprfV4C97xVF7Sy
 gk2cW2kRqvzWKS/kV6v9Qbjqmx1qrgFo5/5PVzp+8wQlMXdck=
X-Received: by 2002:a05:6808:1815:b0:497:da7f:179a with SMTP id
 5614622812f47-4b2bcc2a4c0mr339402b6e.21.1787097517875; 
 Tue, 18 Aug 2026 16:58:37 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b2906a3edesm4835341b6e.0.2026.08.18.16.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 16:58:36 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Tue, 18 Aug 2026 17:56:27 -0600
Subject: [PATCH v4 34/40] bsd-user: Add ACL system call shims to os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-misc-2026q2-v4-34-09bf5647c98e@bsdimp.com>
References: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
In-Reply-To: <20260818-misc-2026q2-v4-0-09bf5647c98e@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9969; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=jDPxly0BKBRFVsK0tRf3hzxwK5WcqRGHTVpfHzD4fNw=;
 b=owEBiQJ2/ZANAwAKAWwc0Sh9sBEAAcsmYgBqhPFVLvik7BLWp4KxO8U6PqTmytPScs9WkZ1DR
 iJsbBuDiniJAk8EAAEKADkWIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaoTxVRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDMACgkQbBzRKH2wEQDFWA//afEu/V6mQ8iyBt0Sg6XtE3DhMWjD+cW
 fpH/PO6SwVwnLI/USINFj6RXNQVOijvhfEaVjFcAZdHZpB46k68uBHFL1Lxwr+1NCr7tCGjmP9u
 lVl3Fofc528bj9ZLwGMaMp/UBxDMLK3EPVp6bJRMx99IAxKReQgNye/yTmz8zPnSMCRLZlN9n53
 KUGU49h+pwYyEkbbPff0faU5iZL0MDlnRK5uuPurNxxRoDZ3/GjSZ8AfsKXlSV+wmpM1PuC85CC
 nR1vCFsUfsPfcWIHWFAXYk8GibxXkp9YaGhK8Eqo0tSm/djcr0zHeG19Wb4haueRPbBxo81oD8b
 MvN4gQnJ5X6F4KnOv6DPNlk93cwxwIYIcSHw16Pmt95kq64oHRHQ4sneq4zgY0VUJPYs4BvM1SU
 dCNFaZrTEZdD3lzb2cEuVeysdTf9gAwVclGCBP74wtXD9vsqbXnGrB28UMYnAeUxinFrs7CibYo
 sosW/SCeDWEfy/i42qEZPTGsPCwPoEakfEKbr+l1p7j6tiq875NG332OyDrOAAG7Uh3QAjYKSpd
 gxiReCzTgQ8TGuiOqgjSogfQ/74+J2+GX+A50YHmX9v+ay8e9IDkmclQ4ctLMlVEnYt4f4vBoqk
 dLSxMcluEXE7EWc0XbKioxMH2gPAw06Zo/4bQASWGLbj+DF+2VOI=
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::233;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x233.google.com
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

Complete os-extattr.h with ACL operations: __acl_aclcheck_fd,
__acl_aclcheck_file, __acl_aclcheck_link, __acl_delete_fd,
__acl_delete_file, __acl_delete_link, __acl_get_fd, __acl_get_file,
__acl_get_link, __acl_set_fd, __acl_set_file, and __acl_set_link.

Signed-off-by: Stacey Son <sson@FreeBSD.org>
Assisted-by: Claude Opus 4.6 (1M context)
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/freebsd/os-extattr.h | 289 +++++++++++++++++++++++++++++++++++++++++-
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


