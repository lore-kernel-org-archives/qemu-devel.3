Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5279CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v41dq-000329-GL; Wed, 01 Oct 2025 14:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v41do-00031J-At
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:33:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v41dX-0006eJ-No
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759343583;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=kzzfXjhpaXwlEADslD1u2inZLpN3dz0uj/2dQbIV82g=;
 b=JmBb++Dk81KyICAmyaGbJf6KQ4jRmxeAyFDxFN0lMAnlR4NNPGY/s/JGsHgM4Hsr+DvOh0
 8e9NXdvp6hSB7Ssc8rSmTw5s5114P5o23O9b3RcC12sx1rfWj6x3IykZi0/UB+yBJwwsH3
 uPSSt/KEaGjETaDES5m10BkVzkB2foo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-34kOLq5lPTGeL8Oa0bAYHQ-1; Wed,
 01 Oct 2025 14:33:01 -0400
X-MC-Unique: 34kOLq5lPTGeL8Oa0bAYHQ-1
X-Mimecast-MFC-AGG-ID: 34kOLq5lPTGeL8Oa0bAYHQ_1759343581
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC34E1956055
 for <qemu-devel@nongnu.org>; Wed,  1 Oct 2025 18:33:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.187])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4D0230003BA; Wed,  1 Oct 2025 18:32:59 +0000 (UTC)
Date: Wed, 1 Oct 2025 19:32:56 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH WIP] Implement -run-with exit-with-parent=on
Message-ID: <aN1z2C__6M8E7I8L@redhat.com>
References: <20251001174118.2756134-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251001174118.2756134-1-rjones@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 01, 2025 at 06:40:56PM +0100, Richard W.M. Jones wrote:
> Libguestfs wants to use qemu to run a captive appliance.  When the
> program linked to libguestfs exits, we want qemu to be cleaned up.
> Libguestfs goes to great lengths to do this at the moment: it either
> forks a separate process to ensure clean-up is done, or it asks
> libvirt to clean up the qemu process.  However this is complicated and
> not totally reliable.
> 
> On Linux, FreeBSD and macOS, there are mechanisms to ensure a signal
> or message is delivered to a process when its parent process goes
> away.  The qemu test suite even uses this mechanism on Linux (see
> PR_SET_PDEATHSIG in tests/qtest/libqtest.c).
> 
> In nbdkit we have long had the concept of running nbdkit captively,
> and we have the nbdkit --exit-with-parent flag to help
> (https://libguestfs.org/nbdkit-captive.1.html#EXIT-WITH-PARENT)
> 
> This commit adds the same mechanism that the qemu test suite uses, and
> that nbdkit has long implemented, to allow this feature to be used by
> all qemu users.  The syntax is:
> 
>   qemu -run-with exit-with-parent=on [...]
> 
> This is not a feature that most typical users of qemu (for running
> general purpose, long-lived VMs) should use, so it defaults to off.
> 
> The exit-with-parent.[ch] files are copied from nbdkit, where they
> have a 3-clause BSD license which is compatible with qemu:
> 
> https://gitlab.com/nbdkit/nbdkit/-/tree/master/common/utils?ref_type=heads
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> ---
>  include/qemu/exit-with-parent.h |  49 +++++++++
>  qemu-options.hx                 |  13 ++-
>  system/exit-with-parent.c       | 171 ++++++++++++++++++++++++++++++++
>  system/meson.build              |   1 +
>  system/vl.c                     |  13 +++
>  5 files changed, 245 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/exit-with-parent.h b/include/qemu/exit-with-parent.h
> new file mode 100644
> index 0000000000..e907ccb5c9
> --- /dev/null
> +++ b/include/qemu/exit-with-parent.h
> @@ -0,0 +1,49 @@
> +/*
> + * SPDX-License-Identifier: BSD-3-Clause
> + * nbdkit

This 'nbdkit' line can be dropped  presumably, unless you want
to refer back to the original source ? Same question for the .c

> + * Copyright Red Hat
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + * * Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * * Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * * Neither the name of Red Hat nor the names of its contributors may be
> + * used to endorse or promote products derived from this software without
> + * specific prior written permission.
> + *
> + * THIS SOFTWARE IS PROVIDED BY RED HAT AND CONTRIBUTORS ''AS IS'' AND
> + * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
> + * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
> + * PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL RED HAT OR
> + * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
> + * USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
> + * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
> + * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
> + * OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
> + * SUCH DAMAGE.
> + */

IIUC, from the nbdkit history exit-with-parent.{ch} only ever
had 3 contributors, all from Red Hat. So if Red Hat is exclusive
copyright holder, I think you're be justified in removing the
license boilerplate here & below, as a representative of RH.

> +
> +#ifndef NBDKIT_EXIT_WITH_PARENT_H
> +#define NBDKIT_EXIT_WITH_PARENT_H
> +
> +#include <stdbool.h>

This is redundant in QEMU since it is guaranteed by osdep.h

> +
> +/* Test if the feature is available on the platform. */
> +extern bool can_exit_with_parent(void);
> +
> +/*
> + * --exit-with-parent: kill the current process if the parent exits.
> + * This may return -1 on error.
> + */
> +extern int set_exit_with_parent(void);
> +
> +#endif /* NBDKIT_EXIT_WITH_PARENT_H */

> diff --git a/system/exit-with-parent.c b/system/exit-with-parent.c
> new file mode 100644
> index 0000000000..fa97b586f0
> --- /dev/null
> +++ b/system/exit-with-parent.c
> @@ -0,0 +1,171 @@
> +
> +/*
> + * Implement the --exit-with-parent feature on operating systems which
> + * support it.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/exit-with-parent.h"
> +
> +#ifdef CONFIG_LINUX
> +#include <sys/prctl.h>
> +#endif
> +
> +#ifdef __FreeBSD__
> +#include <sys/procctl.h>
> +#endif
> +
> +#if defined(CONFIG_LINUX) && defined(PR_SET_PDEATHSIG)
> +
> +/* For Linux >= 2.1.57. */

I don't think we need the PR_SET_PDEATHSIG check
since the oldest Linux platform QEMU targets will
always be newer than 2.1.57 and so can assume to
have PR_SET_PDEATHSIG defined.

> +
> +int
> +set_exit_with_parent(void)
> +{
> +    return prctl(PR_SET_PDEATHSIG, SIGTERM);
> +}
> +
> +bool
> +can_exit_with_parent(void)
> +{
> +    return true;
> +}
> +
> +#elif defined(__FreeBSD__) && defined(PROC_PDEATHSIG_CTL)
> +
> +/* For FreeBSD >= 11.2 */

Also don't need the PROC_PDEATHSIG_CTL check either,
since with current FreeBSD being 14.0, the oldest
QEMU targets is now 13.0

> +
> +#include <sys/procctl.h>
> +
> +int
> +set_exit_with_parent(void)
> +{
> +    const int sig = SIGTERM;
> +    return procctl(P_PID, 0, PROC_PDEATHSIG_CTL, (void *) &sig);
> +}
> +
> +bool
> +can_exit_with_parent(void)
> +{
> +    return true;
> +}
> +
> +#elif defined(__APPLE__)
> +
> +/* For macOS. */
> +
> +#include <unistd.h>
> +#include <errno.h>

These two are guaranteed by osdep.h

> +#include <sys/event.h>
> +#include <pthread.h>

Use  "qemu/thread.h" instead

> +
> +static void *
> +exit_with_parent_loop(void *vp)
> +{
> +    const pid_t ppid = getppid();
> +    int fd;
> +    struct kevent kev, res[1];
> +    int r;
> +
> +    /* Register the kevent to wait for ppid to exit. */
> +    fd = kqueue();
> +    if (fd == -1) {
> +        error_report("exit_with_parent_loop: kqueue: %m");
> +        return NULL;
> +    }
> +    EV_SET(&kev, ppid, EVFILT_PROC, EV_ADD | EV_ENABLE, NOTE_EXIT, 0, NULL);
> +    if (kevent(fd, &kev, 1, NULL, 0, NULL) == -1) {
> +        error_report("exit_with_parent_loop: kevent: %m");
> +        close(fd);
> +        return NULL;
> +    }
> +
> +    /* Wait for the kevent to happen. */
> +    r = kevent(fd, 0, 0, res, 1, NULL);
> +    if (r == 1 && res[0].ident == ppid) {
> +        /* Shut down the whole process when the parent dies. */
> +        exit(0);
> +    }
> +
> +    return NULL;
> +}
> +
> +int
> +set_exit_with_parent(void)
> +{
> +    int r;
> +    pthread_attr_t attrs;
> +    pthread_t exit_with_parent_thread;
> +
> +    /*
> +     * We have to block waiting for kevent, so that requires that we
> +     * start a background thread.
> +     */
> +    pthread_attr_init(&attrs);
> +    pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +    r = pthread_create(&exit_with_parent_thread, NULL,
> +                       exit_with_parent_loop, NULL);


  QemuThread exit_with_parent_thread;
  qemu_thread_create(&exit_with_parent_thread,
                     "exit-parent",
                     exit_with_parent_loop,
                     QEMU_THREAD_DETACHED);

mostly just so we get the thread name set.

> +    if (r != 0) {
> +        errno = r;
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
> +bool
> +can_exit_with_parent(void)
> +{
> +    return true;
> +}
> +
> +#else /* any platform that doesn't support this function */
> +
> +#include <stdlib.h>

Can be assumed with osdep.h

> +
> +int
> +set_exit_with_parent(void)
> +{
> +    abort();
 
Slightly better to use g_assert_not_reached()

> +}
> +
> +bool
> +can_exit_with_parent(void)
> +{
> +    return false;
> +}
> +
> +#endif

> diff --git a/system/vl.c b/system/vl.c
> index 00f3694725..47b6e60b94 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -53,6 +53,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/accel.h"
>  #include "qemu/async-teardown.h"
> +#include "qemu/exit-with-parent.h"
>  #include "hw/usb.h"
>  #include "hw/isa/isa.h"
>  #include "hw/scsi/scsi.h"
> @@ -783,6 +784,10 @@ static QemuOptsList qemu_run_with_opts = {
>              .name = "chroot",
>              .type = QEMU_OPT_STRING,
>          },
> +        {
> +            .name = "exit-with-parent",
> +            .type = QEMU_OPT_BOOL,
> +        },
>          {
>              .name = "user",
>              .type = QEMU_OPT_STRING,
> @@ -3690,6 +3695,14 @@ void qemu_init(int argc, char **argv)
>                  if (str) {
>                      os_set_chroot(str);
>                  }
> +                if (qemu_opt_get_bool(opts, "exit-with-parent", false)) {
> +                    if (!can_exit_with_parent()) {
> +                        error_report("exit-with-parent is not available"
> +                                     " on this platform");
> +                        exit(1);
> +                    }
> +                    set_exit_with_parent();
> +                }
>                  str = qemu_opt_get(opts, "user");
>                  if (str) {
>                      if (!os_set_runas(str)) {

Broadly looks good to me.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


