Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D614BC87FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 16:35:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugnI4-00019d-Oi; Tue, 29 Jul 2025 12:35:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ugmyF-00081x-2K
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:14:32 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1ugmxo-00009G-LS
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 12:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=kRNJ9l8abDo+VE95GAHR0oM7PxSnta5uKoO30HRGj/o=; b=t3Ls/MFXM0nYBLU46O9ZZO9XmZ
 ZDijACncG++pegDVDsZsP/7FkXQDDYs95L+/DIr3ohJvipViOM08LMq5ihyTy0KDoYDbnKiIeQz8R
 PLUsCwjkapsQRtoFcY4pS631p8WQ30mdJPEnqECeyvdN1B2V5v8Wasrmj6AfHM2kbLi9S7o/5i36o
 Tzke+8b6zg7kfIhsb4qZl09BtrrbR6hPwtB0wfT6+hko2mvUzmGBIJOxVu4zaX8OReEusPxRQdx5I
 nEKAJRMFESh6mAz1tLTWM+ge0dc6iDkTznYVVffsAjPO26tPqD/cyxayjYyhLhclxxEM3kl365NDD
 bLqzsO66H4G7e+QBjVpi5S08Jdo4PYfNaOzEmo4m1gW7OdXquyNQC7CVGh1JN/FKpyhUxj85L6L31
 /sM0w2qeLOvrOPp3/xZWcHVcWl4vNVPhCVeGLqN4A1e9nUg3ZxLQwyGmncGa+/KOBdzvvWYUGfv/t
 2HkxhwoxmLeic7nFKl/dMZIvDkBOLf7Em6ods3Qo81qVgm8inQfzLpgFmFlIlhUL1aLsnq9m4n+7k
 MvzvFm7s6RJT5O3H/Bu3jKodsE5dDM73CyNefNQIfG+EBWoymdMgHFPU637y9+rTAVp6t0PDAurgA
 Te265MRGnKv+TWmlDkYtqSo4Foclt1rk+M0+d+2QI=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, Mark Johnston <markj@freebsd.org>
Cc: Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Marc=2DAndr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] 9pfs: Add FreeBSD support
Date: Tue, 29 Jul 2025 18:09:35 +0200
Message-ID: <1989897.fkXqvmx5VE@silver>
In-Reply-To: <aIEGDjMex-DG-pmr@nuc>
References: <aIEGDjMex-DG-pmr@nuc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

On Wednesday, July 23, 2025 5:55:58 PM CEST Mark Johnston wrote:
> This is largely derived from existing Darwin support.  FreeBSD
> apparently has better support for *at() system calls so doesn't require
> workarounds for a missing mknodat().  The implementation has a couple of
> warts however:
> - The extattr(2) system calls don't support anything akin to
>   XATTR_CREATE or XATTR_REPLACE, so a racy workaround is implemented.
> - Attribute names cannot begin with "user." on ZFS, so the prefix is
>   trimmed off.  FreeBSD's extattr system calls sport an extra
>   "namespace" identifier, and attributes created by the 9pfs backend
>   live in the universal user namespace, so this seems innocent enough.
> 
> The 9pfs tests were verified to pass on the UFS, ZFS and tmpfs
> filesystems.
> 
> Signed-off-by: Mark Johnston <markj@FreeBSD.org>

Hi Mark,

first off, the problem is I currently don't have a FreeBSD host to test and
won't have the time in near future neither.

So what was your general intention regarding this patch, fire and forget, or
would you be around for issues/patches regarding 9pfs FreeBSD support?

> ---
>  fsdev/file-op-9p.h        |   6 +-
>  fsdev/meson.build         |   2 +-
>  hw/9pfs/9p-synth.c        |   2 +-
>  hw/9pfs/9p-util-freebsd.c | 124 ++++++++++++++++++++++++++++++++++++++
>  hw/9pfs/9p-util.h         |  19 ++++--
>  hw/9pfs/9p.c              |  16 ++++-
>  hw/9pfs/meson.build       |   2 +
>  include/qemu/xattr.h      |   6 +-
>  meson.build               |   8 +--
>  9 files changed, 170 insertions(+), 15 deletions(-)
>  create mode 100644 hw/9pfs/9p-util-freebsd.c
> 
> diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
> index b9dae8c84c..b85c9934de 100644
> --- a/fsdev/file-op-9p.h
> +++ b/fsdev/file-op-9p.h
> @@ -21,9 +21,11 @@
>  
>  #ifdef CONFIG_LINUX
>  # include <sys/vfs.h>
> -#endif
> -#ifdef CONFIG_DARWIN
> +#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
>  # include <sys/param.h>
> +# ifdef CONFIG_FREEBSD
> +#  undef MACHINE /* work around some unfortunate namespace pollution */
> +# endif

Details? :)

>  # include <sys/mount.h>
>  #endif
>  
> diff --git a/fsdev/meson.build b/fsdev/meson.build
> index c751d8cb62..95fe816604 100644
> --- a/fsdev/meson.build
> +++ b/fsdev/meson.build
> @@ -5,6 +5,6 @@ fsdev_ss.add(when: ['CONFIG_FSDEV_9P'], if_true: files(
>    '9p-marshal.c',
>    'qemu-fsdev.c',
>  ), if_false: files('qemu-fsdev-dummy.c'))
> -if host_os in ['linux', 'darwin']
> +if host_os in ['linux', 'darwin', 'freebsd']
>    system_ss.add_all(fsdev_ss)
>  endif
> diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
> index 9cd1884224..b3743f6169 100644
> --- a/hw/9pfs/9p-synth.c
> +++ b/hw/9pfs/9p-synth.c
> @@ -451,7 +451,7 @@ static int synth_statfs(FsContext *s, V9fsPath *fs_path,
>      stbuf->f_bsize = 512;
>      stbuf->f_blocks = 0;
>      stbuf->f_files = synth_node_count;
> -#ifndef CONFIG_DARWIN
> +#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
>      stbuf->f_namelen = NAME_MAX;
>  #endif
>      return 0;
> diff --git a/hw/9pfs/9p-util-freebsd.c b/hw/9pfs/9p-util-freebsd.c
> new file mode 100644
> index 0000000000..e649f79d4b
> --- /dev/null
> +++ b/hw/9pfs/9p-util-freebsd.c
> @@ -0,0 +1,124 @@
> +/*
> + * 9p utilities (FreeBSD Implementation)
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */

I think for new source files in QEMU the policy is to use
SPDX-License-Identifier: ... now?

Is this source file really specific to exactly FreeBSD? From the name it
suggests that potential future support for other BSD flavours would need their
own source file.

> +
> +/*
> + * Not so fast! You might want to read the 9p developer docs first:
> + * https://wiki.qemu.org/Documentation/9p
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/xattr.h"
> +#include "9p-util.h"
> +
> +static const char *mangle_xattr_name(const char *name)
> +{
> +    /*
> +     * ZFS forbits attributes in the user namespace starting with "user.".
> +     */
> +    if (strncmp(name, "user.", 5) == 0) {
> +        return name + 5;
> +    }
> +    return name;
> +}

"ZFS forbids ..."

> +
> +ssize_t fgetxattr(int fd, const char *name, void *value, size_t size)
> +{
> +    name = mangle_xattr_name(name);
> +    return extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
> +}

I assume if "user." prefix isn't accepted, then "system." is neither, right?
Because "system." prefix is used by 9pfs server as well.

Probably the right extattr namespace should be diverted here according to the
prefix being passed.

I see there is a conversion function in FreeBSD for this called
extattr_string_to_namespace(). But given that the only ones supported are
either EXTATTR_NAMESPACE_USER or EXTATTR_NAMESPACE_SYSTEM and since the prefix
has to be extracted from the string by own code anway, I guess a simple
inliner would do as well.

> +
> +ssize_t fgetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> +                             void *value, size_t size)
> +{
> +    ssize_t ret;
> +    int fd;
> +
> +    fd = openat_file(dirfd, filename,
> +                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    name = mangle_xattr_name(name);
> +    ret = extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +ssize_t flistxattrat_nofollow(int dirfd, const char *filename,
> +                              char *list, size_t size)
> +{
> +    ssize_t ret;
> +    int fd;
> +
> +    fd = openat_file(dirfd, filename,
> +                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    ret = extattr_list_fd(fd, EXTATTR_NAMESPACE_USER, list, size);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +ssize_t fremovexattrat_nofollow(int dirfd, const char *filename,
> +                                const char *name)
> +{
> +    int fd, ret;
> +
> +    fd = openat_file(dirfd, filename,
> +                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    name = mangle_xattr_name(name);
> +    ret = extattr_delete_fd(fd, EXTATTR_NAMESPACE_USER, name);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +int fsetxattrat_nofollow(int dirfd, const char *filename, const char *name,
> +                         void *value, size_t size, int flags)
> +{
> +    ssize_t ret;
> +    int fd;
> +
> +    name = mangle_xattr_name(name);
> +    if (flags == (XATTR_CREATE | XATTR_REPLACE)) {
> +        errno = EINVAL;
> +        return -1;
> +    }
> +    fd = openat_file(dirfd, filename,
> +                     O_RDONLY | O_PATH_9P_UTIL | O_NOFOLLOW, 0);
> +    if (fd == -1) {
> +        return -1;
> +    }
> +    if (flags & (XATTR_CREATE | XATTR_REPLACE)) {
> +        ret = extattr_get_fd(fd, EXTATTR_NAMESPACE_USER, name, NULL, 0);
> +        if (ret == -1 && errno != ENOATTR) {
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +        if (ret >= 0 && (flags & XATTR_CREATE)) {
> +            errno = EEXIST;
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +        if (ret == -1 && (flags & XATTR_REPLACE)) {
> +            errno = ENOATTR;
> +            close_preserve_errno(fd);
> +            return -1;
> +        }
> +    }
> +    ret = extattr_set_fd(fd, EXTATTR_NAMESPACE_USER, name, value, size);
> +    close_preserve_errno(fd);
> +    return ret;
> +}
> +
> +int qemu_mknodat(int dirfd, const char *filename, mode_t mode, dev_t dev)
> +{
> +    return mknodat(dirfd, filename, mode, dev);
> +}
> diff --git a/hw/9pfs/9p-util.h b/hw/9pfs/9p-util.h
> index a1924fe3f0..7315b32591 100644
> --- a/hw/9pfs/9p-util.h
> +++ b/hw/9pfs/9p-util.h
> @@ -21,6 +21,14 @@
>  #define O_PATH_9P_UTIL 0
>  #endif
>  
> +#ifdef CONFIG_FREEBSD
> +/*
> + * FreeBSD does not have these flags, so we can only emulate them (racily).
> + */
> +#define XATTR_CREATE    0x1
> +#define XATTR_REPLACE   0x2
> +#endif
> +

What do you mean with "racily" here?

>  #if !defined(CONFIG_LINUX)
>  
>  /*
> @@ -64,9 +72,9 @@ static inline uint64_t host_dev_to_dotl_dev(dev_t dev)
>  static inline int errno_to_dotl(int err) {
>  #if defined(CONFIG_LINUX)
>      /* nothing to translate (Linux -> Linux) */
> -#elif defined(CONFIG_DARWIN)
> +#elif defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
>      /*
> -     * translation mandatory for macOS hosts
> +     * translation mandatory for non-Linux hosts
>       *
>       * FIXME: Only most important errnos translated here yet, this should be
>       * extended to as many errnos being translated as possible in future.
> @@ -155,13 +163,13 @@ static inline int openat_file(int dirfd, const char *name, int flags,
>  {
>      int fd, serrno, ret;
>  
> -#ifndef CONFIG_DARWIN
> +#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
>  again:
>  #endif
>      fd = qemu_openat(dirfd, name, flags | O_NOFOLLOW | O_NOCTTY | O_NONBLOCK,
>                       mode);
>      if (fd == -1) {
> -#ifndef CONFIG_DARWIN
> +#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
>          if (errno == EPERM && (flags & O_NOATIME)) {
>              /*
>               * The client passed O_NOATIME but we lack permissions to honor it.
> @@ -202,6 +210,9 @@ again:
>      return fd;
>  }
>  
> +#ifdef CONFIG_FREEBSD
> +ssize_t fgetxattr(int dirfd, const char *name, void *value, size_t size);
> +#endif
>  ssize_t fgetxattrat_nofollow(int dirfd, const char *path, const char *name,
>                               void *value, size_t size);
>  int fsetxattrat_nofollow(int dirfd, const char *path, const char *name,
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index acfa7db4e1..bc4a016ee3 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -136,8 +136,10 @@ static int dotl_to_open_flags(int flags)
>          { P9_DOTL_NONBLOCK, O_NONBLOCK } ,
>          { P9_DOTL_DSYNC, O_DSYNC },
>          { P9_DOTL_FASYNC, FASYNC },
> -#ifndef CONFIG_DARWIN
> +#if !defined(CONFIG_DARWIN) && !defined(CONFIG_FREEBSD)
>          { P9_DOTL_NOATIME, O_NOATIME },
> +#endif
> +#ifndef CONFIG_DARWIN
>          /*
>           *  On Darwin, we could map to F_NOCACHE, which is
>           *  similar, but doesn't quite have the same
> @@ -3658,7 +3660,7 @@ static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
>      f_bavail = stbuf->f_bavail / bsize_factor;
>      f_files  = stbuf->f_files;
>      f_ffree  = stbuf->f_ffree;
> -#ifdef CONFIG_DARWIN
> +#if defined(CONFIG_DARWIN) || defined(CONFIG_FREEBSD)
>      fsid_val = (unsigned int)stbuf->f_fsid.val[0] |
>                 (unsigned long long)stbuf->f_fsid.val[1] << 32;
>      f_namelen = NAME_MAX;
> @@ -4050,6 +4052,16 @@ out_nofid:
>   * Linux guests.
>   */
>  #define P9_XATTR_SIZE_MAX 65536
> +#elif defined(CONFIG_FREEBSD)
> +/*
> + * FreeBSD similarly doesn't define a maximum xattr size, the limit is
> + * filesystem dependent.  On UFS filesystems it's 2 times the filesystem block
> + * size, typically 32KB.  On ZFS it depends on the value of the xattr property;
> + * with the default value there is no limit, and with xattr=sa it is 64KB.
> + *
> + * So, a limit of 64k seems reasonable here too.
> + */
> +#define P9_XATTR_SIZE_MAX 65536

Yeah, even though the limit with UFS being lower, 64k should be fine. This
macro is just to prevent a guest to shoot down the QEMU process by requesting
a ridiculous large xattr (RAM) buffer that would exceed host's RAM quota for
the process. If the underlying fs supports less, its syscall would still
return an appropriate error which is eventually returned to 9p client.

/Christian

>  #else
>  #error Missing definition for P9_XATTR_SIZE_MAX for this host system
>  #endif
> diff --git a/hw/9pfs/meson.build b/hw/9pfs/meson.build
> index d35d4f44ff..7f4d6e3a45 100644
> --- a/hw/9pfs/meson.build
> +++ b/hw/9pfs/meson.build
> @@ -15,6 +15,8 @@ fs_ss.add(files(
>  ))
>  if host_os == 'darwin'
>    fs_ss.add(files('9p-util-darwin.c'))
> +elif host_os == 'freebsd'
> +  fs_ss.add(files('9p-util-freebsd.c'))
>  elif host_os == 'linux'
>    fs_ss.add(files('9p-util-linux.c'))
>  endif
> diff --git a/include/qemu/xattr.h b/include/qemu/xattr.h
> index b08a934acc..224ba1276e 100644
> --- a/include/qemu/xattr.h
> +++ b/include/qemu/xattr.h
> @@ -26,7 +26,11 @@
>  #    define ENOATTR ENODATA
>  #  endif
>  #  ifndef CONFIG_WIN32
> -#    include <sys/xattr.h>
> +#    ifdef CONFIG_FREEBSD
> +#      include <sys/extattr.h>
> +#    else
> +#      include <sys/xattr.h>
> +#    endif
>  #  endif
>  #endif
>  
> diff --git a/meson.build b/meson.build
> index c2bc3eeedc..4c681bd2e8 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2382,11 +2382,11 @@ dbus_display = get_option('dbus_display') \
>    .allowed()
>  
>  have_virtfs = get_option('virtfs') \
> -    .require(host_os == 'linux' or host_os == 'darwin',
> -             error_message: 'virtio-9p (virtfs) requires Linux or macOS') \
> -    .require(host_os == 'linux' or cc.has_function('pthread_fchdir_np'),
> +    .require(host_os == 'linux' or host_os == 'darwin' or host_os == 'freebsd',
> +             error_message: 'virtio-9p (virtfs) requires Linux or macOS or FreeBSD') \
> +    .require(host_os != 'darwin' or cc.has_function('pthread_fchdir_np'),
>               error_message: 'virtio-9p (virtfs) on macOS requires the presence of pthread_fchdir_np') \
> -    .require(host_os == 'darwin' or libattr.found(),
> +    .require(host_os != 'linux' or libattr.found(),
>               error_message: 'virtio-9p (virtfs) on Linux requires libattr-devel') \
>      .disable_auto_if(not have_tools and not have_system) \
>      .allowed()
> 



