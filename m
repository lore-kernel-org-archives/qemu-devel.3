Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB216D0E6CE
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNs1N-0006M9-AW; Tue, 25 Nov 2025 07:19:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNs1L-0006I5-45
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:19:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vNs1H-0006pl-LZ
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764073182;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=nmYFA46Qv6gwhbeTc8uHwQFFBV96IpXct+CQ6wORWkU=;
 b=dVYHQj/R10kr0ymu3sjl/JK8Da73xFhjJtyfTX/JAX1qq1WA2XxPl7rQSdiaPzVZE8vKSj
 OqINpGupvbBPQZ8TZ0wbv86dvgM6hgsA8qx5fTBPAOVp2+Ma0+TGgQyFoHrxuc0aMU63BC
 zTxE6qCao0sWuAq7pp1Ju15RzfTnPos=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-q40IaTRhPHeiTKNarilixQ-1; Tue,
 25 Nov 2025 07:19:38 -0500
X-MC-Unique: q40IaTRhPHeiTKNarilixQ-1
X-Mimecast-MFC-AGG-ID: q40IaTRhPHeiTKNarilixQ_1764073177
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F62F1800673; Tue, 25 Nov 2025 12:19:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAC42180047F; Tue, 25 Nov 2025 12:19:34 +0000 (UTC)
Date: Tue, 25 Nov 2025 12:19:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Moritz Haase <Moritz.Haase@bmw.de>
Cc: qemu-devel@nongnu.org, petrosagg@resin.io, nghiant2710@gmail.com,
 forumi0721@gmail.com, laurent@vivier.eu
Subject: Re: [PATCH] linux-user: add option to intercept execve() syscalls
Message-ID: <aSWe0_oaclL83ovL@redhat.com>
References: <20251125103859.1449760-1-Moritz.Haase@bmw.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251125103859.1449760-1-Moritz.Haase@bmw.de>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Nov 25, 2025 at 11:38:59AM +0100, Moritz Haase wrote:
> In order for one to use QEMU user mode emulation under a chroot, it is
> required to use binfmt_misc. This can be avoided by QEMU never doing a raw
> execve() to the host system, which is especially useful in environments
> where binfmt_misc can't be used.
> 
> Introduce a new option, -execve, that uses the current QEMU interpreter to
> intercept execve(). In addition, execve mode can also be en- and disabled
> using the 'QEMU_EXECVE' env var.
> 
> qemu_execve() will prepend the interpreter path, similar to what binfmt_misc
> would do, and then pass the modified execve() to the host.
> 
> It is necessary to parse hashbang scripts in that function otherwise the
> kernel will try to run the interpreter of a script without QEMU and get an
> invalid exec format error.
> 
> Note that a previous incarnation of this patch was submitted a few years ago
> (see [0]) by Petros Angelatos as the original author who confirmed that it's
> OK to resubmit it.

Did this patch code directly evolve from Petros' patch linked at [0], or
was the latter merely inspiration and this a fresh implementation ?

If the former, best practice is to keep Petros's  Signed-off-by, and add
a short 1-2 line note of key changes, and then add your own Signed-off-by
eg something like


  Signed-off-by: Petros Angelatos <petrosagg@resin.io>
  [MH:  changed a, y and z]
  Signed-off-by: Moritz Haase <Moritz.Haase@bmw.de>

> 
> CC: petrosagg@resin.io
> CC: nghiant2710@gmail.com
> CC: forumi0721@gmail.com
> CC: laurent@vivier.eu
> 
> Signed-off-by: Moritz Haase <Moritz.Haase@bmw.de>
> 
> ---
> 
> We've been using this feature internally for at least five years by now.
> Prior to submission, the code was updated to (hopefully) conform to the
> current QEMU coding style.
> 
> I'd be happy to add test cases for this feature, but I'd need some pointers
> given that I'm a first-time contributor. Thanks!
> 
> [0]: https://patchwork.kernel.org/project/qemu-devel/patch/1453091602-21843-1-git-send-email-petrosagg@gmail.com/
> ---
>  linux-user/linuxload.c      | 119 ++++++++++++++++++++++++++++++++++--
>  linux-user/loader.h         |   1 +
>  linux-user/main.c           |  54 ++++++++++++++++
>  linux-user/syscall.c        |  94 ++++++++++++++++++++++++----
>  linux-user/user-internals.h |   1 +
>  5 files changed, 252 insertions(+), 17 deletions(-)
> 
> diff --git a/linux-user/linuxload.c b/linux-user/linuxload.c
> index 85d700953e..eb1fdf3f85 100644
> --- a/linux-user/linuxload.c
> +++ b/linux-user/linuxload.c
> @@ -138,15 +138,124 @@ abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
>      return sp;
>  }
>  
> +int load_script_file(const char *filename, struct linux_binprm *bprm)
> +{
> +    int retval, fd;
> +    char *i_arg = NULL, *i_name = NULL;
> +    char **new_argv;
> +    char *cp;
> +    char buf[BPRM_BUF_SIZE];
> +
> +    /* Check if it is a script */
> +    fd = open(filename, O_RDONLY);
> +    if (fd == -1) {
> +        return fd;
> +    }
> +
> +    retval = read(fd, buf, BPRM_BUF_SIZE);
> +    if (retval == -1) {
> +        close(fd);
> +        return retval;
> +    }
> +
> +     /* if we have less than 2 bytes, we can guess it is not executable */
> +    if (retval < 2) {
> +        close(fd);
> +        return -ENOEXEC;
> +    }
> +
> +    close(fd);
> +    /*
> +     * adapted from the kernel
> +     * https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/binfmt_script.c
> +     */
> +    if ((buf[0] == '#') && (buf[1] == '!')) {
> +        buf[BPRM_BUF_SIZE - 1] = '\0';
> +        cp = strchr(buf, '\n');
> +        if (cp == NULL) {
> +            cp = buf + BPRM_BUF_SIZE - 1;
> +        }
> +        *cp = '\0';
> +        while (cp > buf) {
> +            cp--;
> +            if ((*cp == ' ') || (*cp == '\t')) {
> +                *cp = '\0';
> +            } else {
> +                break;
> +            }
> +        }
> +        for (cp = buf + 2; (*cp == ' ') || (*cp == '\t'); cp++) {
> +            /* nothing */ ;
> +        }
> +        if (*cp == '\0') {
> +            return -ENOEXEC; /* No interpreter name found */
> +        }
> +        i_name = cp;
> +        i_arg = NULL;
> +        for ( ; *cp && (*cp != ' ') && (*cp != '\t'); cp++) {
> +            /* nothing */ ;
> +        }
> +        while ((*cp == ' ') || (*cp == '\t')) {
> +            *cp++ = '\0';
> +        }
> +
> +        new_argv = NULL;
> +        if (*cp) {
> +            i_arg = cp;
> +        }
> +
> +        if (i_arg) {
> +            new_argv = g_alloca(sizeof(void *));
> +            new_argv[0] = i_arg;

FYI, use of g_alloca() is no longer permitted in QEMU code.

I thought we blocked that with -Walloca, but it seems we do not.
We ought to fix that gap.

> +        }
> +        bprm->argv = new_argv;
> +        bprm->filename = i_name;
> +    } else {
> +        return 1;
> +    }
> +    return 0;
> +}
> +
>  int loader_exec(int fdexec, const char *filename, char **argv, char **envp,
>                  struct image_info *infop, struct linux_binprm *bprm)
>  {
> -    int retval;
> +    int retval, fd, offset = 1, argc = count(argv);
> +    char **new_argv;
> +
> +    retval = load_script_file(filename, bprm);
> +    if (retval == 0) {
> +        if (bprm->argv != NULL) {
> +            offset = 2;
> +        }
> +        new_argv = g_alloca((argc + offset + 1) * sizeof(void *));
> +
> +        new_argv[0] = (char *)filename;
> +        if (bprm->argv != NULL) {
> +            new_argv[1] = bprm->argv[0];
> +        }
> +        /* Copy the original arguments with offset */
> +        for (int i = 0; i < argc; i++) {
> +            new_argv[i + offset] = argv[i];
> +        }
> +        new_argv[argc + offset] = NULL;
> +
> +        bprm->argc = count(new_argv);
> +        bprm->argv = new_argv;
> +        fd = open(bprm->filename, O_RDONLY);
> +        if (fd < 0) {
> +            printf("Error while loading %s: %s\n",
> +                bprm->filename,
> +                strerror(errno));
> +            _exit(EXIT_FAILURE);
> +        }
> +        bprm->src.fd = fd;
> +    } else {
> +        bprm->filename = (char *)filename;
> +        bprm->argc = count(argv);
> +        bprm->argv = argv;
> +        bprm->src.fd = fdexec;

If load_script_file()  failed to open or read the filename, is
it correct to continue executing with this fallback ?  Is there
a scenario where QEMU would be unable to open/read, but it be
none the less possible for it to work int his fallback ?

> +    }
>  
> -    bprm->src.fd = fdexec;
> -    bprm->filename = (char *)filename;
> -    bprm->argc = count(argv);
> -    bprm->argv = argv;
>      bprm->envc = count(envp);
>      bprm->envp = envp;
>  

> @@ -367,6 +368,56 @@ static void handle_arg_guest_base(const char *arg)
>      have_guest_base = true;
>  }
>  
> +static void handle_arg_execve(const char *arg)
> +{
> +    const char *execfn;
> +    char buf[PATH_MAX];
> +    char *ret;
> +    int len;
> +
> +    /*
> +     * Since the 'execve' command line option has no argument ('has_arg' is
> +     * 'false'), this function will always receive NULL for 'arg' during
> +     * argument parsing. If 'arg' is non-NULL, we are being called during env
> +     * var handling, because QEMU_EXECVE is set.
> +     */
> +    if (arg != NULL) {
> +        /*
> +         * If the env var is set, check whether its value is '0'. In this case,
> +         * we don't want to enable 'execve' mode and thus bail out. Please note
> +         * that an empty value will NOT disable 'execve' mode.
> +         */
> +        if (!strcmp(arg, "0")) {
> +            return;
> +        }
> +    }
> +
> +    /* try getauxval() */
> +    execfn = (const char *)qemu_getauxval(AT_EXECFN);
> +
> +    if (execfn != 0) {
> +        ret = realpath(execfn, buf);
> +
> +        if (ret != NULL) {
> +            qemu_execve_path = g_strdup(buf);
> +            return;
> +        }
> +    }
> +
> +    /* try /proc/self/exe */
> +    len = readlink("/proc/self/exe", buf, sizeof(buf) - 1);
> +
> +    if (len != -1) {
> +        buf[len] = '\0';
> +        qemu_execve_path = g_strdup(buf);
> +        return;
> +    }
> +
> +    fprintf(stderr, "qemu_execve: unable to determine interpreter's path\n");
> +    exit(EXIT_FAILURE);
> +}
> +
> +
>  static void handle_arg_reserved_va(const char *arg)
>  {
>      char *p;
> @@ -497,6 +548,9 @@ static const struct qemu_argument arg_table[] = {
>       "uname",      "set qemu uname release string to 'uname'"},
>      {"B",          "QEMU_GUEST_BASE",  true,  handle_arg_guest_base,
>       "address",    "set guest_base address to 'address'"},
> +    {"execve",     "QEMU_EXECVE",      false, handle_arg_execve,
> +     "",           "use this interpreter when a process calls execve() "
> +     "(disabled if env var is '0', enabled for all other values / when empty)"},
>      {"R",          "QEMU_RESERVED_VA", true,  handle_arg_reserved_va,
>       "size",       "reserve 'size' bytes for guest virtual address space"},
>      {"t",          "QEMU_RTSIG_MAP",   true,  handle_arg_rtsig_map,
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 2060e561a2..bf9e084975 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -127,6 +127,7 @@
>  #include <libdrm/drm.h>
>  #include <libdrm/i915_drm.h>
>  #endif
> +#include <linux/binfmts.h>
>  #include "linux_loop.h"
>  #include "uname.h"
>  
> @@ -8726,6 +8727,86 @@ ssize_t do_guest_readlink(const char *pathname, char *buf, size_t bufsiz)
>      return ret;
>  }
>  
> +static int qemu_execve(const char *filename, char *argv[],
> +                       char *envp[])
> +{
> +    char **new_argv;
> +    const char *new_filename;
> +    int argc, ret, i, offset = 3;
> +    struct linux_binprm *bprm;
> +
> +    /* normal execve case */
> +    if (qemu_execve_path == NULL || *qemu_execve_path == 0) {
> +        new_filename = filename;
> +        new_argv = argv;
> +    } else {
> +        new_filename = qemu_execve_path;
> +
> +        for (argc = 0; argv[argc] != NULL; argc++) {
> +            /* nothing */ ;
> +        }
> +
> +        bprm = g_alloca(sizeof(struct linux_binprm));
> +        ret = load_script_file(filename, bprm);
> +
> +        if (ret < 0) {
> +            if (ret == -1) {
> +                return get_errno(ret);
> +            } else {
> +                return -host_to_target_errno(ENOEXEC);
> +            }
> +        }
> +
> +        if (ret == 0) {
> +            if (bprm->argv != NULL) {
> +                offset = 5;
> +            } else {
> +                offset = 4;
> +            }
> +        }
> +
> +        /* Need to store execve argument */
> +        offset++;
> +
> +        new_argv = g_alloca((argc + offset + 1) * sizeof(void *));
> +
> +        /* Copy the original arguments with offset */
> +        for (i = 0; i < argc; i++) {
> +            new_argv[i + offset] = argv[i];
> +        }
> +
> +        new_argv[0] = g_strdup(qemu_execve_path);
> +        new_argv[1] = g_strdup("-execve"); /* Add execve argument */
> +        new_argv[2] = g_strdup("-0");
> +        new_argv[offset] = g_strdup(filename);
> +        new_argv[argc + offset] = NULL;
> +
> +        if (ret == 0) {
> +            new_argv[3] = bprm->filename;
> +            new_argv[4] = bprm->filename;
> +
> +            if (bprm->argv != NULL) {
> +                new_argv[5] = bprm->argv[0];
> +            }
> +        } else {
> +            new_argv[3] = argv[0];
> +        }
> +    }
> +
> +    /*
> +     * Although execve() is not an interruptible syscall it is
> +     * a special case where we must use the safe_syscall wrapper:
> +     * if we allow a signal to happen before we make the host
> +     * syscall then we will 'lose' it, because at the point of
> +     * execve the process leaves QEMU's control. So we use the
> +     * safe syscall wrapper to ensure that we either take the
> +     * signal as a guest signal, or else it does not happen
> +     * before the execve completes and makes it the other
> +     * program's problem.
> +     */
> +    return safe_execve(new_filename, new_argv, envp);
> +}


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


