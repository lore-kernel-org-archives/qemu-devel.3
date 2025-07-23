Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113A0C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 17:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uedLN-00049W-DR; Wed, 23 Jul 2025 13:33:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uebpB-0002B6-3O
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 11:56:09 -0400
Received: from mail-qk1-x732.google.com ([2607:f8b0:4864:20::732])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <markjdb@gmail.com>) id 1uebp6-0006BH-TB
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 11:56:08 -0400
Received: by mail-qk1-x732.google.com with SMTP id
 af79cd13be357-7de159778d4so5280685a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 08:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286162; x=1753890962; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:from:to:cc:subject:date:message-id:reply-to;
 bh=47TKKbxsCCoCF9lyNl1H6xE8CiDY2c0kJhWrkrUvpM4=;
 b=YujjNLCx5l/oFuPkhitU+NR6YlwrV6bjUNKpF25YUiX9sytfcqDvyCJUFT7zj7wRUL
 xn0T7vs+GZN4ZtjK/cva2JIX/gPlfeD52XUO1CipwbMgp+9jnPwVXiATosNSi0ZF6ZB9
 nz9LqdPt9zkqJ1eEXcXq2/GtvtiezJ/iu5Eed5kocg80SRNBf5Efm+fbtPwuqGBkXNZy
 0tEJwGcdbefGg1UA58vBY98dJPp9fM+f/FU5R5jBzxi59wSLv4UGvomLThI5LFldHe4i
 UCPeHHJJCQFpcUxrVW5nS+oiMROw++/6YbEbdLFVNkEzJkGPNuP7mzzHvIF5cv+yWFe3
 MCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286162; x=1753890962;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :sender:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=47TKKbxsCCoCF9lyNl1H6xE8CiDY2c0kJhWrkrUvpM4=;
 b=Fk5cfTbO855xWniC98SRq/Nb80osD0zk/3gZW5jQtpz+/jhCZPqdoC8+C6DfJdCw3E
 ssOVfEKOPHS9caeKADj4/51GhoHOpy+rfhFLG8HI0kEo5p49Lqt2/1kRmP++rpEgdZxv
 QfwXIs0TupzJofVdbxNUECGvBd9hF2EHAP0iv5fmzsCsHEz0guzIuTmS6S9fPT14axit
 Qm148Yru55+EO1nQYT3zX1OptzNHNNbItLqn5NnwwkJOkxSzlVYIr3Vv2QMORBqtDVG+
 P3EGBUo+ouYxQhXjU9NZiimyxXOSuhjccqdcO92sUPlZdw6KEKZtbHwsKWIg86iL4CXf
 7m1g==
X-Gm-Message-State: AOJu0Yy9T22gvHMYEcUKCiouV33OsJdzOSC5LtDBanAagsVjP4kPY10Q
 zeYWs/JxKr6/ferSlPlt/fcOl0/D+YLXh/kgSTgUKiDfup8PnJCKcstfT+xsGMLsjl4=
X-Gm-Gg: ASbGnctVFQG+hU78W7ux/m4na0rYZDsQjqjWysr5/pI85yeApox0GN+Nh9l2zA0mOJ5
 vQdNlxDcpGxjSEFWmRdktsvwzBGDIWme0T5eOj2SbyIgx3tQpwMSiAYOJ3PELnltOBBck0lJlGF
 GxZ73iWMn3WVZl4NpQLIlsdU2lCw8lbDMP4qXaf7NKOeWPKmm8m3FQAdp/R1YCF1SK3EUbMtT0U
 5uruzdGiFxyqAP/IJntoL0WOX53mXbZNdq1LkNPVjBryhrqMwoagmi2znWCJ+QgdiU8blX9+I/u
 ebAZ/WpHBvlAD07dr7/QnuViTq0P4hEOyJys8ijsVi4nMvLJ1h4w7JTQHlqMUtYEiE1+/meZD3F
 XdnAWFUNkEaNrHkzhqIYq538OyhRr0YX04HbV
X-Google-Smtp-Source: AGHT+IEHqzn2QKI6/Z+wD2jWQxWZHINI7DgYnwl9GWiuJZodgxEu3HpqlnNiyIXJpE+QYMBTr65g6w==
X-Received: by 2002:a05:620a:4d12:b0:7e3:685e:4160 with SMTP id
 af79cd13be357-7e62a1bde76mr308959685a.59.1753286161571; 
 Wed, 23 Jul 2025 08:56:01 -0700 (PDT)
Received: from nuc (192-0-220-237.cpe.teksavvy.com. [192.0.220.237])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356c767dfsm680283885a.83.2025.07.23.08.56.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:56:01 -0700 (PDT)
Date: Wed, 23 Jul 2025 11:55:58 -0400
From: Mark Johnston <markj@freebsd.org>
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: [PATCH] 9pfs: Add FreeBSD support
Message-ID: <aIEGDjMex-DG-pmr@nuc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=2607:f8b0:4864:20::732;
 envelope-from=markjdb@gmail.com; helo=mail-qk1-x732.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.158,
 HK_RANDOM_ENVFROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 23 Jul 2025 13:32:36 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This is largely derived from existing Darwin support.  FreeBSD
apparently has better support for *at() system calls so doesn't require
workarounds for a missing mknodat().  The implementation has a couple of
warts however:
- The extattr(2) system calls don't support anything akin to
  XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
- Attribute names cannot begin with "user." on ZFS, so the prefix is
  trimmed off.  FreeBSD's extattr system calls sport an extra
  "namespace" identifier, and attributes created by the 9pfs backend
  live in the universal user namespace, so this seems innocent enough.

The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
filesystems.

Signed-off-by: Mark Johnston <markj@FreeBSD.org>
---
 fsdev/file-op-9p.h        |   6 +-
 fsdev/meson.build         |   2 +-
 hw/9pfs/9p-synth.c        |   2 +-
 hw/9pfs/9p-util-freebsd.c | 124 ++++++++++++++++++++++++++++++++++++++
 hw/9pfs/9p-util.h         |  19 ++++--
 hw/9pfs/9p.c              |  16 ++++-
 hw/9pfs/meson.build       |   2 +
 include/qemu/xattr.h      |   6 +-
 meson.build               |   8 +--
 9 files changed, 170 insertions(+), 15 deletions(-)
 create mode 100644 hw/9pfs/9p-util-freebsd.c

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b9dae8c84c..b85c9934de 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -21,9 +21,11 @@
 
 #ifdef CONFIG_LINUX
 # include <sys/vfs.h>
-#endif
-#ifdef CONFIG_DARWIN
+#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
 # include <sys/param.h>
+# ifdef CONFIG_FREEBSD
+#  undef MACHINE /* work around some unfortunate namespace pollution */
+# endif
 # include <sys/mount.h>
 #endif
 
diff --git a/fsdev/meson.build b/fsdev/meson.build
index c751d8cb62..95fe816604 100644
--- a/fsdev/meson.build
+++ b/fsdev/meson.build
@@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
   '9p-marshal.c',
   'qemu-fsdev.c',
 ), if_false: files('qemu-fsdev-dummy.c'))
-if host_os in ['linux', 'darwin']
+if host_os in ['linux', 'darwin', 'freebsd']
   system_ss.add_all(fsdev_ss)
 endif
diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 9cd1884224..b3743f6169 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -451,7 +451,7 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
     stbuf->f_bsize = 512;
     stbuf->f_blocks = 0;
     stbuf->f_files = synth_node_count;
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
     stbuf->f_namelen = NAME_MAX;
 #endif
     return 0;
diff --git a/hw/9pfs/9p-util-freebsd.c b/hw/9pfs/9p-util-freebsd.c
new file mode 100644
index 0000000000..e649f79d4b
--- /dev/null
+++ b/hw/9pfs/9p-util-freebsd.c
@@ -0,0 +1,124 @@
+/*
+ * 9p utilities (FreeBSD Implementation)
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+/*
+ * Not so fast! You might want to read the 9p developer docs first:
+ * https://wiki.qemu.org/Documentation/9p
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/xattr.h"
+#include "9p-util.h"
+
+static const char *mangle_xattr_name(const char *name)
+{
+    /*
+     * ZFS forbits attributes in the user namespace starting with "user.".
+     */
+    if (strncmp(name, "user.", 5) == 0) {
+        return name + 5;
+    }
+    return name;
+}
+
+ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
+{
+    name = mangle_xattr_name(name);
+    return extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
+}
+
+ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                             void *value, size_t size)
+{
+    ssize_t ret;
+    int fd;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    name = mangle_xattr_name(name);
+    ret = extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
+                              char *list, size_t size)
+{
+    ssize_t ret;
+    int fd;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    ret = extattr_list_fd(fd, EXTATTR_NAMESPACE_USER, list, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
+                                const char *name)
+{
+    int fd, ret;
+
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    name = mangle_xattr_name(name);
+    ret = extattr_delete_fd(fd, EXTATTR_NAMESPACE_USER, name);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
+                         void *value, size_t size, int flags)
+{
+    ssize_t ret;
+    int fd;
+
+    name = mangle_xattr_name(name);
+    if (flags == (XATTR_CREATE | XATTR_REPLACE)) {
+        errno = EINVAL;
+        return -1;
+    }
+    fd = openat_file(dirfd, filename,
+                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
+    if (fd == -1) {
+        return -1;
+    }
+    if (flags & (XATTR_CREATE | XATTR_REPLACE)) {
+        ret = extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, NULL, 0);
+        if (ret == -1 && errno != ENOATTR) {
+            close_preserve_errno(fd);
+            return -1;
+        }
+        if (ret >= 0 && (flags & XATTR_CREATE)) {
+            errno = EEXIST;
+            close_preserve_errno(fd);
+            return -1;
+        }
+        if (ret == -1 && (flags & XATTR_REPLACE)) {
+            errno = ENOATTR;
+            close_preserve_errno(fd);
+            return -1;
+        }
+    }
+    ret = extattr_set_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
+    close_preserve_errno(fd);
+    return ret;
+}
+
+int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
+{
+    return mknodat(dirfd, filename, mode, dev);
+}
diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
index a1924fe3f0..7315b32591 100644
--- a/hw/9pfs/9p-util.h
+++ b/hw/9pfs/9p-util.h
@@ -21,6 +21,14 @@
 #define O_PATH_9P_UTIL 0
 #endif
 
+#ifdef CONFIG_FREEBSD
+/*
+ * FreeBSD does not have these flags, so we can only emulate them (racily).
+ */
+#define XATTR_CREATE    0x1
+#define XATTR_REPLACE   0x2
+#endif
+
 #if !defined(CONFIG_LINUX)
 
 /*
@@ -64,9 +72,9 @@ static inline uint64_t host_dev_to_dotl_dev(dev_t dev)
 static inline int errno_to_dotl(int err) {
 #if defined(CONFIG_LINUX)
     /* nothing to translate (Linux -> Linux) */
-#elif defined(CONFIG_DARWIN)
+#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
     /*
-     * translation mandatory for macOS hosts
+     * translation mandatory for non-Linux hosts
      *
      * FIXME: Only most important errnos translated here yet, this should be
      * extended to as many errnos being translated as possible in future.
@@ -155,13 +163,13 @@ static inline int openat_file(int dirfd, const char *name, int flags,
 {
     int fd, serrno, ret;
 
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
 again:
 #endif
     fd = qemu_openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
                      mode);
     if (fd == -1) {
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
         if (errno == EPERM && (flags & O_NOATIME)) {
             /*
              * The client passed O_NOATIME but we lack permissions to honor it.
@@ -202,6 +210,9 @@ again:
     return fd;
 }
 
+#ifdef CONFIG_FREEBSD
+ssize_t fgetxattr(int dirfd, const char *name, void *value, size_t size);
+#endif
 ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
                              void *value, size_t size);
 int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index acfa7db4e1..bc4a016ee3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -136,8 +136,10 @@ static int dotl_to_open_flags(int flags)
         { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
         { P9_DOTL_DSYNC, O_DSYNC },
         { P9_DOTL_FASYNC, FASYNC },
-#ifndef CONFIG_DARWIN
+#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
         { P9_DOTL_NOATIME, O_NOATIME },
+#endif
+#ifndef CONFIG_DARWIN
         /*
          *  On Darwin, we could map to F_NOCACHE, which is
          *  similar, but doesn't quite have the same
@@ -3658,7 +3660,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
     f_bavail = stbuf->f_bavail / bsize_factor;
     f_files  = stbuf->f_files;
     f_ffree  = stbuf->f_ffree;
-#ifdef CONFIG_DARWIN
+#if defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
     fsid_val = (unsigned int)stbuf->f_fsid.val[0] |
                (unsigned long long)stbuf->f_fsid.val[1] << 32;
     f_namelen = NAME_MAX;
@@ -4050,6 +4052,16 @@ out_nofid:
  * Linux guests.
  */
 #define P9_XATTR_SIZE_MAX 65536
+#elif defined(CONFIG_FREEBSD)
+/*
+ * FreeBSD similarly doesn't define a maximum xattr size, the limit is
+ * filesystem dependent.  On UFS filesystems it's 2 times the filesystem block
+ * size, typically 32KB.  On ZFS it depends on the value of the xattr property;
+ * with the default value there is no limit, and with xattr=sa it is 64KB.
+ *
+ * So, a limit of 64k seems reasonable here too.
+ */
+#define P9_XATTR_SIZE_MAX 65536
 #else
 #error Missing definition for P9_XATTR_SIZE_MAX for this host system
 #endif
diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
index d35d4f44ff..7f4d6e3a45 100644
--- a/hw/9pfs/meson.build
+++ b/hw/9pfs/meson.build
@@ -15,6 +15,8 @@ fs_ss.add(files(
 ))
 if host_os == 'darwin'
   fs_ss.add(files('9p-util-darwin.c'))
+elif host_os == 'freebsd'
+  fs_ss.add(files('9p-util-freebsd.c'))
 elif host_os == 'linux'
   fs_ss.add(files('9p-util-linux.c'))
 endif
diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
index b08a934acc..224ba1276e 100644
--- a/include/qemu/xattr.h
+++ b/include/qemu/xattr.h
@@ -26,7 +26,11 @@
 #    define ENOATTR ENODATA
 #  endif
 #  ifndef CONFIG_WIN32
-#    include <sys/xattr.h>
+#    ifdef CONFIG_FREEBSD
+#      include <sys/extattr.h>
+#    else
+#      include <sys/xattr.h>
+#    endif
 #  endif
 #endif
 
diff --git a/meson.build b/meson.build
index c2bc3eeedc..4c681bd2e8 100644
--- a/meson.build
+++ b/meson.build
@@ -2382,11 +2382,11 @@ dbus_display = get_option('dbus_display') \
   .allowed()
 
 have_virtfs = get_option('virtfs') \
-    .require(host_os == 'linux' or host_os == 'darwin',
-             error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
-    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
+    .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'freebsd',
+             error_message: 'virtio-9p (virtfs) requires Linux or macOS or FreeBSD') \
+    .require(host_os != 'darwin' or cc.has_function('pthread_fchdir_np'),
              error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
-    .require(host_os == 'darwin' or libattr.found(),
+    .require(host_os != 'linux' or libattr.found(),
              error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
     .disable_auto_if(not have_tools and not have_system) \
     .allowed()
-- 
2.49.0


