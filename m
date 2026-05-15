Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46FCCD4F3C
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 21:22:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNzxY-00029M-1V; Fri, 15 May 2026 17:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxW-00022k-Fo
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:38 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wNzxU-000334-FQ
 for qemu-devel@nongnu.org; Fri, 15 May 2026 17:20:38 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-484a2090205so821790b6e.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 14:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1778880035; x=1779484835;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LEyrDN/IBIHTJn7j3nP53ANeCHIGq8E/2DXezzuEf0A=;
 b=uOCbLU2GfR1pLgMe4+2CNSDTTqCwEvc8khVLEBw/pcJ+BBXaxdQmQ79Qh9VpihaIEb
 OjLMue0LT2vX9IRtQAxjR54Fjo1m1VRJ/1M43s5+HQB0vDiv84YkM8yUYLJ4C+ZlMt9z
 79U0pbZsyn83Rs2F2UHGd/ORqAixaViHL6B5gngJ9mg72XWh9RohPJo7sf5VDunwRaC+
 lD3Fw2mnbp+5dm7rZMYonzU3sKBD65jZiJs6wjPuxRKvPCSH97qEkHm38gAwpalNmmmK
 d+RNGLBWH4cDO0wqAoO4AxqxxFj5AypT8TRGa65iaYFfMfFdiXpO4AeW5bZ0D3g7G58w
 dN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778880035; x=1779484835;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LEyrDN/IBIHTJn7j3nP53ANeCHIGq8E/2DXezzuEf0A=;
 b=NzKDR5ZJBZbIJzXQTZjZQCvlreNGweyQJRN1J2tDNkhtRUuN/9setYfJ76BKyq6u8I
 QktUmJPouSDuZ/epV95IgaERrksTjqskMnK5jyYaNdo0tOerLWpI0ngfcV3D+yBbvH+J
 z76S7VO2BLGN0LO1TuEV3KAAN0C9woUPY98OeoXEoHsXeENXWTj6CRtWyxmR0cZ2z2gX
 hkj77cWr8uVaVi8z003g89hj0Plgbys7b+PGzB7yirHbL0JdC5JLiljzKxPspHEswPqX
 etAQXkzp30q8rRdhys4s6jVgoNpZz25AuKHNo93RD/LRkvsUpLNklZtTvsLlQDZfLgJ9
 RpIQ==
X-Gm-Message-State: AOJu0YwySjFAEgDNbLGVsbcskhcIUoqBHhHjB7Nx08CmhPd9Filf3X4y
 pbcuURCxnIvGDtIoFVw8r8LmQQym6IU6JFHj4vRoa4ToqTi7TGvwUx+a5aD6m44L+is=
X-Gm-Gg: Acq92OEb/AumuuGuwL6/m3Ylgy/ai+y3sYf4ZlZdYsTu2ZsopJKuSDqdVKY7dh2oEjS
 cGTRVb7BkNdTj0caj5aMfvAz77f6EQOgRTonJjx1TCsMhH7q2Z6Yuef50icRZmsJLIOCdB5fTQF
 5+Z0eszLG1cb4OWwhAJsXCg2PNqqXlBNsXkuodkcj0bV5GE71UU+pwtdwLvk1CT62Soe/UoOIRc
 Cvq+swaY6rLvRXh/7p556cWuuvqJHMJVIA9nUy2Pi/+Jdx+wQi36Ks7TjOJq8aB3aLzESj+imVx
 m/HA8ABPWH/fE90eJhRiYPXRotBP1b6rDx1jT5M/dT87Yd0ef0yO5mGIcviP+Eu0J0Mk3yAwCmd
 Mg4LnDFY22CdiO08Pg9nwbdSjTOcZGHhJxaIwnTY4H6H1JENImbKKcN0jRloB6ZK/7oYhoX5lS/
 zoC238DWKhdw==
X-Received: by 2002:a05:6808:1b22:b0:47b:884:b6de with SMTP id
 5614622812f47-482cb721377mr4993727b6e.1.1778880035393; 
 Fri, 15 May 2026 14:20:35 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b29sm2185612a34.1.2026.05.15.14.20.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 14:20:34 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Fri, 15 May 2026 15:19:31 -0600
Subject: [PATCH 32/66] bsd-user: Add ACL system call shims to os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-misc-2026q2-v1-32-5438ca41b27a@bsdimp.com>
References: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
In-Reply-To: <20260515-misc-2026q2-v1-0-5438ca41b27a@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=8901; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=3EhHpbtiZLtv0+J2hYvv6EauzGt7ru5T+ynrHvxg67Q=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqB43krz3ScwPG9gSb+abwM98gYFaQzHyNy/PCu
 kehch7NE9qJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCageN5AAKCRBsHNEofbAR
 APcKD/9ebZiPTE02qKh6ASZMMHwwMoxtnS4nxK71HQOdSN2E0MIqAQqni90mYufTvO08ctbITzR
 3GTe/UmQWXrLPQJ8SEuabi3LMZaZ9sSc+6QiZr0V/y3Yj8DKt+5GrweoStUMcPKtZCV91q02u9R
 YTAd9MDGXc6MFFpJQlvgiVOkZ8DwwBVB6EkU1NC4lOmCDMXCg21S/jfTc0Ho66En+Dmxdg1wDjJ
 OWNiOKpdcIxunrTLkSGSbOotOB7HkiP+E+MIyd155oXMh3RXjEgR9tHEjXtFTvhvGv4EXRLz2Wi
 w9utJVxLCyo1zl3NNCI0wYGFgWx44x9sxXO2aK2m/xyW7DIFhqbp1qQbrJuYyxBF/eOerwebPiZ
 xMIaKgQx0jdUWlBKt4DXBkvt+v0mzD1u1dr6H1MmMauX8QDLUj5sgCCInZI1HuAc+gi++O6q2C7
 3SMfS8Z2F+l2BYjzy1jXFPICxHGJ6lHGnvYQ5Qq+LnGjNT8fUoBDWPQw6JgAyqiothZ/+cLcaQe
 kTo3/G/ExLFstiTAJz7v6VPpsfwAvMBxc0U+Daq8I5r7E0sPVZlN1Ux1K9NqfSXnhWbgR9HNG9u
 kWlkXyWkDny/JKY908zkk/t7Nl6+nTNZMHbV9zZVyO5NUMgdwUv2uDjIjrmO2/Ltq593gDg61Eq
 KwpPq9i0DizTCnw==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::22e;
 envelope-from=imp@bsdimp.com; helo=mail-oi1-x22e.google.com
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
Signed-off-by: Warner Losh <imp@bsdimp.com>
Assisted-by: Claude Opus 4.6 (1M context)
---
 bsd-user/freebsd/os-extattr.h | 281 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 280 insertions(+), 1 deletion(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 788e40ef30..70446f9a54 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -376,5 +376,284 @@ static inline abi_long do_freebsd_extattr_list_link(
  *  Access Control Lists
  */
 
+/* __acl_aclcheck_fd(int filedes, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_fd(abi_long arg1, abi_long arg2,
+                                                   abi_ulong arg3)
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
+static inline abi_long do_freebsd__acl_aclcheck_file(abi_ulong arg1,
+                                                     abi_long arg2,
+                                                     abi_ulong arg3)
+{
+    abi_long ret;
+    void *p;
+    struct acl host_acl;
+    acl_type_t type;
+
+    ret = t2h_freebsd_acl_type(&type, arg2);
+    p = lock_user_string(arg1);
+    if (p == NULL) {
+        return -TARGET_EFAULT;
+    }
+    ret = t2h_freebsd_acl(&host_acl, arg3);
+    if (!is_error(ret)) {
+        ret = get_errno(__acl_aclcheck_file(path(p) , arg2, &host_acl));
+    }
+    unlock_user(p, arg1, 0);
+
+    return ret;
+}
+
+/* __acl_aclcheck_link(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_aclcheck_link(abi_ulong arg1,
+                                                     abi_long arg2,
+                                                     abi_ulong arg3)
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
+static inline abi_long do_freebsd__acl_delete_file(abi_ulong arg1,
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
+static inline abi_long do_freebsd__acl_delete_link(abi_ulong arg1,
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
+                                              abi_ulong arg3)
+{
+    abi_long ret;
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
+    ret = get_errno(__acl_get_fd(arg1, type, &host_acl));
+    if (!is_error(ret)) {
+        ret = h2t_freebsd_acl(arg3, &host_acl);
+    }
+
+    return ret;
+}
+
+/* __acl_get_file(const char *path, acl_type_t type, struct acl *aclp); */
+static inline abi_long do_freebsd__acl_get_file(abi_ulong arg1, abi_long arg2,
+                                                abi_ulong arg3)
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
+static inline abi_long do_freebsd__acl_get_link(abi_ulong arg1, abi_long arg2,
+                                                abi_ulong arg3)
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
+                                              abi_ulong arg3)
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
+static inline abi_long do_freebsd__acl_set_file(abi_ulong arg1, abi_long arg2,
+                                                abi_ulong arg3)
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
+static inline abi_long do_freebsd__acl_set_link(abi_ulong arg1, abi_long arg2,
+                                                abi_ulong arg3)
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
 
-#endif /* FREEBSD_OS_EXTATTR_H */

-- 
2.52.0


