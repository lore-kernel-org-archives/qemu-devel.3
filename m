Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD31C27C44
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 09:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE42i-00044s-Hh; Mon, 03 Jun 2024 05:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE42e-00042s-Fb
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE42Y-00025R-Mg
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 05:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717407099;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZrWU+rGlHqUPDn8dQXFhiQ/34khVjybFaEnr8hkQwIY=;
 b=RNRyv9dIYGGzhsayJP7jdYyAnjM+cVyJp8e1QQZCKLnTU/AwbP7KImG2IFWpVw3cG2u+Nc
 0LVrreYo01N4PkTM83sxhRXZXGGKZAbhMU8qiCIHxTtgUEiQI+bi9I3TBQkx3L4AtsLaM2
 BvE4hCEU4Kvm3WakVCMUErtWqgodSgE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-d331w6tbOv2KfT26ubuR4Q-1; Mon, 03 Jun 2024 05:31:33 -0400
X-MC-Unique: d331w6tbOv2KfT26ubuR4Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4F8B185A783;
 Mon,  3 Jun 2024 09:31:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 876FB402EB0;
 Mon,  3 Jun 2024 09:31:31 +0000 (UTC)
Date: Mon, 3 Jun 2024 10:31:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, eblake@redhat.com,
 armbru@redhat.com, Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH] chardev: add path option for pty backend
Message-ID: <Zl2NcQiihnKl87Bb@redhat.com>
References: <20240531175153.2716309-1-tavip@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531175153.2716309-1-tavip@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, May 31, 2024 at 10:51:53AM -0700, Octavian Purdila wrote:
> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
> 
> Based on patch from Paulo Neves:
> 
> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail.com/
> 
> Tested with the following invocations that the link is created and
> removed when qemu stops:
> 
>   qemu-system-x86_64 -nodefaults -mon chardev=compat_monitor \
>   -chardev pty,path=test,id=compat_monitor0
> 
>   qemu-system-x86_64 -nodefaults -monitor pty:test
> 
> Also tested that when a link path is not passed invocations still work, e.g.:
> 
>   qemu-system-x86_64 -monitor pty
> 
> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> Signed-off-by: Octavian Purdila <tavip@google.com>

When creating a new version of someone else's previous patch, you
generally should keep the original Signed-off-by, then add 1 or 2
lines explaining what further changes you made, then add your own
Signed-off-by.


> ---
>  chardev/char-pty.c | 34 ++++++++++++++++++++++++++++++++++
>  chardev/char.c     |  5 +++++
>  qapi/char.json     |  4 ++--
>  qemu-options.hx    | 14 ++++++++++----
>  4 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cc2f7617fe..7cd5d34851 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -29,6 +29,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "qemu/option.h"
>  #include "qemu/qemu-print.h"
>  
>  #include "chardev/char-io.h"
> @@ -41,6 +42,7 @@ struct PtyChardev {
>  
>      int connected;
>      GSource *timer_src;
> +    char *symlink_path;
>  };
>  typedef struct PtyChardev PtyChardev;
>  
> @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>      Chardev *chr = CHARDEV(obj);
>      PtyChardev *s = PTY_CHARDEV(obj);
>  
> +    /* unlink symlink */
> +    if (s->symlink_path) {
> +        unlink(s->symlink_path);
> +        g_free(s->symlink_path);
> +    }
> +
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
>      pty_chr_timer_cancel(s);
> @@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
>      int master_fd, slave_fd;
>      char pty_name[PATH_MAX];
>      char *name;
> +    char *symlink_path = backend->u.pty.data->device;
>  
>      master_fd = qemu_openpty_raw(&slave_fd, pty_name);
>      if (master_fd < 0) {
> @@ -354,12 +363,37 @@ static void char_pty_open(Chardev *chr,
>      g_free(name);
>      s->timer_src = NULL;
>      *be_opened = false;
> +
> +    /* create symbolic link */
> +    if (symlink_path) {
> +        int res = symlink(pty_name, symlink_path);
> +
> +        if (res != 0) {
> +            error_setg_errno(errp, errno, "Failed to create PTY symlink");
> +            close(master_fd);
> +        } else {
> +            s->symlink_path = g_strdup(symlink_path);
> +        }
> +    }
> +}
> +
> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> +                           Error **errp)
> +{
> +    const char *path = qemu_opt_get(opts, "path");
> +    ChardevHostdev *dev;
> +
> +    backend->type = CHARDEV_BACKEND_KIND_PTY;
> +    dev = backend->u.pty.data = g_new0(ChardevHostdev, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
> +    dev->device = path ? g_strdup(path) : NULL;
>  }
>  
>  static void char_pty_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc = CHARDEV_CLASS(oc);
>  
> +    cc->parse = char_pty_parse;
>      cc->open = char_pty_open;
>      cc->chr_write = char_pty_chr_write;
>      cc->chr_update_read_handler = pty_chr_update_read_handler;
> diff --git a/chardev/char.c b/chardev/char.c
> index 3c43fb1278..404c6b8a4f 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, const char *filename,
>          qemu_opt_set(opts, "path", p, &error_abort);
>          return opts;
>      }
> +    if (strstart(filename, "pty:", &p)) {
> +        qemu_opt_set(opts, "backend", "pty", &error_abort);
> +        qemu_opt_set(opts, "path", p, &error_abort);
> +        return opts;
> +    }
>      if (strstart(filename, "tcp:", &p) ||
>          strstart(filename, "telnet:", &p) ||
>          strstart(filename, "tn3270:", &p) ||
> diff --git a/qapi/char.json b/qapi/char.json
> index 777dde55d9..4c74bfc437 100644
> --- a/qapi/char.json
> +++ b/qapi/char.json
> @@ -509,7 +509,7 @@
>  ##
>  # @ChardevHostdevWrapper:
>  #
> -# @data: Configuration info for device and pipe chardevs
> +# @data: Configuration info for device, pty and pipe chardevs
>  #
>  # Since: 1.4
>  ##
> @@ -650,7 +650,7 @@
>              'pipe': 'ChardevHostdevWrapper',
>              'socket': 'ChardevSocketWrapper',
>              'udp': 'ChardevUdpWrapper',
> -            'pty': 'ChardevCommonWrapper',
> +            'pty': 'ChardevHostdevWrapper',
>              'null': 'ChardevCommonWrapper',
>              'mux': 'ChardevMuxWrapper',
>              'msmouse': 'ChardevCommonWrapper',
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 8ca7f34ef0..5eec194242 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev console,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev serial,id=id,path=path[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>  #else
> -    "-chardev pty,id=id[,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
> +    "-chardev pty,id=id[,path=path][,mux=on|off][,logfile=PATH][,logappend=on|off]\n"
>      "-chardev stdio,id=id[,mux=on|off][,signal=on|off][,logfile=PATH][,logappend=on|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
> @@ -3808,12 +3808,16 @@ The available backends are:
>  
>      ``path`` specifies the name of the serial device to open.
>  
> -``-chardev pty,id=id``
> +``-chardev pty,id=id[,path=path]``
>      Create a new pseudo-terminal on the host and connect to it. ``pty``
>      does not take any options.
>  
>      ``pty`` is not available on Windows hosts.
>  
> +    ``path`` specifies the symbolic link path to be created that
> +    points to the pty device.
> +
> +
>  ``-chardev stdio,id=id[,signal=on|off]``
>      Connect to standard input and standard output of the QEMU process.
>  
> @@ -4171,8 +4175,10 @@ SRST
>  
>              vc:80Cx24C
>  
> -    ``pty``
> -        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
> +    ``pty[:path]``
> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
> +        Optionally a path can be given to create a symbolic link to
> +        the allocated PTY.
>  
>      ``none``
>          No device is allocated. Note that for machine types which
> -- 
> 2.45.1.288.g0e0cd299f1-goog
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


