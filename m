Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F01C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 09:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTIAV-0002hq-5G; Fri, 26 Jan 2024 04:06:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTIAT-0002hD-ND
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 04:06:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rTIAR-0001qB-Oh
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 04:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706259990;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4dm0Y7AskbXp7Pr+5mjM9EPLZvW8hdYjXGcpYOAE3tY=;
 b=c7IOedAoXYHsL9DnIWyKJRvczwZvA1yY5FuS8DOXoEg4oZTsRmkqLoQ6P/df6KXnvOykdd
 fAqIugsEu7yofV0zwUm5oVb7qJTk9ggHIoZvRuuY+AqXSNwIkuip7NZsqwtIsZABdk8vEH
 0W3IfkQg4Zj+Ht8cw16aeFwap1yUp3o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-qDVhs12pOlGCF2d326KkdQ-1; Fri,
 26 Jan 2024 04:06:26 -0500
X-MC-Unique: qDVhs12pOlGCF2d326KkdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DF0C285F994;
 Fri, 26 Jan 2024 09:06:26 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D848400D288;
 Fri, 26 Jan 2024 09:06:25 +0000 (UTC)
Date: Fri, 26 Jan 2024 09:06:22 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: [PATCH trivial 1/2] close_all_open_fd(): move to oslib-posix.c
Message-ID: <ZbN2DhQ4GeKc-aaX@redhat.com>
References: <cover.1706221377.git.mjt@tls.msk.ru>
 <94fcee0d7595865b3a6fab744982ad47715e5faf.1706221377.git.mjt@tls.msk.ru>
 <ffc002d5-f648-43b8-b938-011a4a92cf5e@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ffc002d5-f648-43b8-b938-011a4a92cf5e@vivier.eu>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Jan 26, 2024 at 08:44:13AM +0100, Laurent Vivier wrote:
> Le 25/01/2024 à 23:29, Michael Tokarev a écrit :
> > Initially in async-teardown.c, but the same construct is used
> > elsewhere too.
> > 
> > Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> > ---
> >   include/sysemu/os-posix.h |  1 +
> >   system/async-teardown.c   | 37 +------------------------------------
> >   util/oslib-posix.c        | 36 ++++++++++++++++++++++++++++++++++++
> >   3 files changed, 38 insertions(+), 36 deletions(-)
> > 
> > diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
> > index dff32ae185..4c91d03f44 100644
> > --- a/include/sysemu/os-posix.h
> > +++ b/include/sysemu/os-posix.h
> > @@ -53,6 +53,7 @@ bool os_set_runas(const char *user_id);
> >   void os_set_chroot(const char *path);
> >   void os_setup_post(void);
> >   int os_mlock(void);
> > +void os_close_all_open_fd(int minfd);
> >   /**
> >    * qemu_alloc_stack:
> > diff --git a/system/async-teardown.c b/system/async-teardown.c
> > index 396963c091..41d3d94935 100644
> > --- a/system/async-teardown.c
> > +++ b/system/async-teardown.c
> > @@ -26,40 +26,6 @@
> >   static pid_t the_ppid;
> > -/*
> > - * Close all open file descriptors.
> > - */
> > -static void close_all_open_fd(void)
> > -{
> > -    struct dirent *de;
> > -    int fd, dfd;
> > -    DIR *dir;
> > -
> > -#ifdef CONFIG_CLOSE_RANGE
> > -    int r = close_range(0, ~0U, 0);
> > -    if (!r) {
> > -        /* Success, no need to try other ways. */
> > -        return;
> > -    }
> > -#endif
> > -
> > -    dir = opendir("/proc/self/fd");
> > -    if (!dir) {
> > -        /* If /proc is not mounted, there is nothing that can be done. */
> > -        return;
> > -    }
> > -    /* Avoid closing the directory. */
> > -    dfd = dirfd(dir);
> > -
> > -    for (de = readdir(dir); de; de = readdir(dir)) {
> > -        fd = atoi(de->d_name);
> > -        if (fd != dfd) {
> > -            close(fd);
> > -        }
> > -    }
> > -    closedir(dir);
> > -}
> > -
> >   static void hup_handler(int signal)
> >   {
> >       /* Check every second if this process has been reparented. */
> > @@ -85,9 +51,8 @@ static int async_teardown_fn(void *arg)
> >       /*
> >        * Close all file descriptors that might have been inherited from the
> >        * main qemu process when doing clone, needed to make libvirt happy.
> > -     * Not using close_range for increased compatibility with older kernels.
> >        */
> > -    close_all_open_fd();
> > +    os_close_all_open_fd(0);
> >       /* Set up a handler for SIGHUP and unblock SIGHUP. */
> >       sigaction(SIGHUP, &sa, NULL);
> > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > index 7c297003b9..09d0ce4da6 100644
> > --- a/util/oslib-posix.c
> > +++ b/util/oslib-posix.c
> > @@ -27,6 +27,7 @@
> >    */
> >   #include "qemu/osdep.h"
> > +#include <dirent.h>
> >   #include <termios.h>
> >   #include <glib/gprintf.h>
> > @@ -106,6 +107,41 @@ int qemu_get_thread_id(void)
> >   #endif
> >   }
> > +/*
> > + * Close all open file descriptors starting with minfd and up.
> > + * Not using close_range for increased compatibility with older kernels.
> > + */
> > +void os_close_all_open_fd(int minfd)
> > +{
> > +    struct dirent *de;
> > +    int fd, dfd;
> > +    DIR *dir;
> > +
> > +#ifdef CONFIG_CLOSE_RANGE
> > +    int r = close_range(minfd, ~0U, 0);
> > +    if (!r) {
> > +        /* Success, no need to try other ways. */
> > +        return;
> > +    }
> > +#endif
> > +
> > +    dir = opendir("/proc/self/fd");
> > +    if (!dir) {
> > +        /* If /proc is not mounted, there is nothing that can be done. */
> > +        return;
> > +    }
> > +    /* Avoid closing the directory. */
> > +    dfd = dirfd(dir);
> > +
> > +    for (de = readdir(dir); de; de = readdir(dir)) {
> > +        fd = atoi(de->d_name);
> > +        if (fd >= minfd && fd != dfd) {
> > +            close(fd);
> > +        }
> > +    }
> > +    closedir(dir);
> > +}
> 
> I think the way using sysconf(_SC_OPEN_MAX) is more portable, simpler and
> cleaner than the one using /proc/self/fd.

A fallback that uses _SC_OPEN_MAX is good for portability, but it is
should not be considered a replacement for iterating over /proc/self/fd,
rather an additional fallback for non-Linux, or when /proc is not mounted.
It is not uncommon for _SC_OPEN_MAX to be *exceedingly* high

  $ podman run -it quay.io/centos/centos:stream9
  [root@4a440d62935c /]# ulimit -n
  524288

Iterating over 1/2 a million FDs is a serious performance penalty that
we don't want to have, so _SC_OPEN_MAX should always be the last resort.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


