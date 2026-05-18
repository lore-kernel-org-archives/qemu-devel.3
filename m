Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AAACD343F
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 21:31:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wP5Vq-0000hS-6v; Mon, 18 May 2026 17:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vk-0000XP-Pb
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:29 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1wP5Vi-0000cD-8Q
 for qemu-devel@nongnu.org; Mon, 18 May 2026 17:28:28 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dd73b7c757so1437674a34.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20251104.gappssmtp.com; s=20251104; t=1779139705; x=1779744505;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=46PeUjItrCiTFLvIk8NnwF5r7lBcB9iBG7KmhEjuYK0=;
 b=XWo1CF/JxEvMTtuhPghaeYzJo7e7B3bTsvfni7i2LUMUy1cgrKeb8pGaFqblJF4i+U
 RFCmpAuPVdOcDwWKbgzvS+cXGW7wBmaFO5xr92ON5Yie7SeitzwgIoKL8QgSFjxTovLC
 Ao371XcK+I3nEjZTc9y5rmwyZu4ssbrGeKW6us81cbfE+XfT/7aVFvVDYopHYnhiqak7
 7Iw4e+Ihz3bc34Zh3w3ldnwVa0n8HR8384rYw+gW862dPYQEjcnCcpWe1PcsIo1lswGy
 V9mpd6rMjaQsuN+PXMlPHD3DVqc7KJUNqL5kOC/74Lp8Yt+N0WRcRwT5OtHqVEjFHCKi
 O0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779139705; x=1779744505;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=46PeUjItrCiTFLvIk8NnwF5r7lBcB9iBG7KmhEjuYK0=;
 b=fd1G6dzeGkjJifPz5AaLKfH13GJ7sehLhTykUs1ix2rBXCBAoJfQol1MZqXvt7rk57
 ewkPFJ/VdXwhu6t4yDGfZs91UQGq8YUrdUg3ckBKwepAqSOnsh5IsqN2Be4xm3Txqd/Q
 /VQcoWkdrWaiHfMzJ3ZVwpWm7p/HrWkFVRmJvgi/7UbQ+lZ4JjVcDb+9Imzyy6VIEyPj
 VEgt/07nL/gj33hCvzXLL0gip1Q/MVcUZM30NjBuo99JsHx5JIJf5+0E23gWW4HXkbg3
 A3aL/t7SfIVc1+P7Hk9rjRCPTWXbBN+/P+V+Rg7NmByoqoOc12UUD0yWG7MRkcNtB+UP
 5Y/g==
X-Gm-Message-State: AOJu0YwJMjFbh5SFOE95rfEY5XESzsM470s8TzGrIx96weR+7dmM522y
 CrY8DzV9uiP+jpEIp/DDVdO+D2cbzVJcNA9bBsxlNzz/VGmU59QE+kQie+GRVg6vG4k=
X-Gm-Gg: Acq92OEBr5bs8fozjt6o79IHxN+spj10ntunBLXIf4lF7voVu9vMI8CBBSOfwRzZKbD
 2Fl3W+h9KsvQD7K2zEfk9ooWoXw6HbH2mlYGXq0FXXGSxqok79zIW6xJ+8TgGOwAh1h6BFNjNPX
 hMvOsSYWsR6VOnpCmPPfHli1aFjYybwO7Pjw3ninFiYaEDggDRzmlafjYosZxpzvrTOkjj2aoPE
 GPRsHtx1jmk9oegPf4nJjXD9Pdat5sW2QONI1ebRHsPJjoZNmXT7bkrQagiscsbA7wtVQLPqAC8
 XIkEfj3kMnKSmxJT32AVsBYzDFxneihQzGlC2M5wEh1uFbTNyDXQx+i5BvR2NUvh3fTx2i5smgV
 bsptvnObt/fh6hv9rk7NHPdEkX2VWnE6IIy4xsLTtw4JtHd6VIlNvOoq6ocIp635n9DDPHUbWMy
 +Wbn125tQbJg==
X-Received: by 2002:a05:6830:4ac1:b0:7dc:dd19:7f69 with SMTP id
 46e09a7af769-7e4f2bd7a56mr11041453a34.17.1779139705115; 
 Mon, 18 May 2026 14:28:25 -0700 (PDT)
Received: from rebo.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b81cc5asm7980358a34.8.2026.05.18.14.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:28:24 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
Date: Mon, 18 May 2026 15:27:50 -0600
Subject: [PATCH v2 32/37] bsd-user: Add ACL system call shims to os-extattr.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-misc-2026q2-v2-32-6c16fe448301@bsdimp.com>
References: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
In-Reply-To: <20260518-misc-2026q2-v2-0-6c16fe448301@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9931; i=imp@bsdimp.com;
 h=from:subject:message-id; bh=cxGOb8uOizVRPPdFfcThc7BXNzJpQX4gEPSZTPwW3gc=;
 b=owEBbQKS/ZANAwAKAWwc0Sh9sBEAAcsmYgBqC4RJCbmGXBibmRp8k9xaGxsyFDTNMj3XUABpy
 WwVx4I6y6aJAjMEAAEKAB0WIQQgNfiUsAqjz3zN4bdsHNEofbARAAUCaguESQAKCRBsHNEofbAR
 APXSD/90wnATv6GJmeZkgAgGazgUDuGF0giIqOyZczOFIi5c5tHvtKS3cKH+FsryQQ0u+7J3/nX
 oNGbpucKFvQ+j5wDhuH+BMTE5MG2TAqsWbdqV/r7APaZ1YbqPix98zhZJQVJsSsmBLXJiwa7lfG
 TPYAbEFEVHEnXRLvuF3FOOmq7hvuwkpL5tzgbPNL7kzSJgFsqXDWXpEYhtd3RdqnjCW2gaHGQgY
 4I/OR7NyVUhxCDOmtE3eFZA3eji9yT49nayjbqrpuALD3aqvHjdZhF/gl/KCQvE/vyghYkfP2rZ
 8NiZL8O0kxDy2GbDbTc1tQCqE247WbvXNpeObPa0p3Ovt/D0m4lp2+wTjlnE/bFmQ2GCLbDVnwj
 akHWdMUl7FbXTVwWI9vBzpJu3HE0rEfK0547NxPMIgnrDpXUxaoy7z/gB/8pAZn+w13mgWQ8sgK
 TnLFHMCCgcNH6RREhW3ga4eeWmSv+FM4Zidw8WUBEvmdaYIIkd3yvfnHEPPkNZRieX2iq7xyvZr
 93vB2pqU8xqE/CeUZJQq4qd56ivJLCc0MxA8BEvsiDmvbykeQnFH+TrJQ6pzRhVJ2tPg0iFGxvJ
 yYfTQ0Dirj8Vu3/TT8gZTEAGM7rVvwqXSsmQuUa5gU65p7MpUUvFieW1mLjsGEx+aAhV8gWneUW
 vD2LEBCIxFNyNTA==
X-Developer-Key: i=imp@bsdimp.com; a=openpgp;
 fpr=2035F894B00AA3CF7CCDE1B76C1CD1287DB01100
Received-SPF: none client-ip=2607:f8b0:4864:20::332;
 envelope-from=imp@bsdimp.com; helo=mail-ot1-x332.google.com
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
 bsd-user/freebsd/os-extattr.h | 290 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 286 insertions(+), 4 deletions(-)

diff --git a/bsd-user/freebsd/os-extattr.h b/bsd-user/freebsd/os-extattr.h
index 788e40ef30..5f5678b380 100644
--- a/bsd-user/freebsd/os-extattr.h
+++ b/bsd-user/freebsd/os-extattr.h
@@ -65,7 +65,7 @@ static inline abi_long do_freebsd_extattr_set_file(abi_ulong arg1,
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
@@ -267,7 +267,7 @@ static inline abi_long do_freebsd_extattr_set_link(abi_ulong arg1,
         return -TARGET_EFAULT;
     }
     ret = get_errno(extattr_set_link(path(p), arg2, a, d, arg5));
-    unlock_user(d, arg4, arg5);
+    unlock_user(d, arg4, 0);
     unlock_user(a, arg3, 0);
     unlock_user(p, arg1, 0);
 
@@ -376,5 +376,287 @@ static inline abi_long do_freebsd_extattr_list_link(
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


