Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77429C25B74
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 05:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEN4s-0002vX-KV; Tue, 04 Jun 2024 01:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEN4m-0002tE-0A
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1sEN4j-00034d-QF
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 01:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717480272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GILllscAJ6Vqb4I1oSls69zTzuawY9x8r9Xvacwt5zg=;
 b=BWZAwK7omXraOKSQL3kIyfbOccEkEvSNF8zBSHxUYaQ/5Jr8OWQM5Cue9jnlYyX7qdJ7g7
 dPZZ2gOsJ048HONYjFyfGFwKQIw8R02VAhxu9ZLL6vkUtPlVWy3qj+/KCmd3Kkh4c3mD5T
 D/E45nYieDESWUBQJHBL4G1GIo2sfmo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-0iaqk6Q0NuGQHDVM995XeQ-1; Tue, 04 Jun 2024 01:51:11 -0400
X-MC-Unique: 0iaqk6Q0NuGQHDVM995XeQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-57a58d70e71so769048a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 22:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717480270; x=1718085070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GILllscAJ6Vqb4I1oSls69zTzuawY9x8r9Xvacwt5zg=;
 b=Amt+8UMBaWRC9Q8GCce9pUsYqYpVAxEC1dg4yvP2Cian0fAIR5MehLuHzVx0sN5ziG
 H20p7QzqyNX3B4bkBQsC6G0wfacRhfu3d56bv2tngneCVr3VLbtEyiHJzx/lH6ssvqOK
 y/Q9vHGSUD3x+QCR5eKfB1SnKJAoYYoPHS6iQTh7ZPKHfJ49EQLmQbCnKYgsnkEUXzVL
 zWpBatebBd20jQ9TBCRFtlKWT/bwz8I0Sdc0UgSezuOJW1Sf6zqUIOfJVl87uc3Mweub
 TfkXnEXZaufvn+vJiEgs0mV23pTrOqodD1gLnxSMH08Ag8HVMM3QN8BtI9rLRW5lH2P0
 qCpQ==
X-Gm-Message-State: AOJu0Yx2/tLG7ko9H2m5fwjW+PkMGRi1f4ktzQDVyDTF8Ri3V7vhTS0c
 K4Pqwd08LHXTDLXmNArPkV+xEXyBfnJlJ2EHiJGOk6EZEvCL61APINufieJ32MldmjdYpBmeJrd
 NC5foPWpnyX4x2aahWF/Q5pWqpMRxHYvC99lGuX94mWSdEpMH1TuCJeOdaILZSv/tPeH8kX4QMV
 TNw1AU/Chnyi0h+JKOtBEs1dJJzPc=
X-Received: by 2002:a50:9f62:0:b0:578:695d:d78f with SMTP id
 4fb4d7f45d1cf-57a3637700dmr7271264a12.15.1717480270003; 
 Mon, 03 Jun 2024 22:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW6WCRmjtXyRm2f8CGOH2hMd6UjTwtQnMfSdPLWFc4w0w7+uJ+X7A+OD6dZDVAlc2uM2vYKu+qYW9MAoPsJdY=
X-Received: by 2002:a50:9f62:0:b0:578:695d:d78f with SMTP id
 4fb4d7f45d1cf-57a3637700dmr7271255a12.15.1717480269639; Mon, 03 Jun 2024
 22:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240603212228.3878836-1-tavip@google.com>
In-Reply-To: <20240603212228.3878836-1-tavip@google.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 4 Jun 2024 09:50:57 +0400
Message-ID: <CAMxuvaw=PXk-5yuBwPLS4WUygwbXz1qOJTwrA_EEhNJJuoMGsg@mail.gmail.com>
Subject: Re: [PATCH v2] chardev: add path option for pty backend
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, armbru@redhat.com, 
 peter.maydell@linaro.org, berrange@redhat.com, 
 Paulo Neves <ptsneves@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 4, 2024 at 1:22=E2=80=AFAM Octavian Purdila <tavip@google.com> =
wrote:
>
> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
>
> This avoids having to make QMP or HMP monitor queries to find out what
> the new PTY device path is.
>
> Based on patch from Paulo Neves:
>
> https://patchew.org/QEMU/1548509635-15776-1-git-send-email-ptsneves@gmail=
.com/
>
> Tested with the following invocations that the link is created and
> removed when qemu stops:
>
>   qemu-system-x86_64 -nodefaults -mon chardev=3Dcompat_monitor \
>   -chardev pty,path=3Dtest,id=3Dcompat_monitor0
>
>   qemu-system-x86_64 -nodefaults -monitor pty:test
>
> Also tested that when a link path is not passed invocations still work, e=
.g.:
>
>   qemu-system-x86_64 -monitor pty
>
> Co-authored-by: Paulo Neves <ptsneves@gmail.com>
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> [OP: rebase and address original patch review comments]
> Signed-off-by: Octavian Purdila <tavip@google.com>
> ---
> Changes since v1:
>
>  * Keep the original Signed-off-by from Paulo and add one line
>     description with further changes
>
>  * Update commit message with justification for why the new
>     functionality is useful
>
>  * Don't close master_fd when symlink creation fails to avoid double
>     close
>
>  * Update documentation for clarity
>
>  chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
>  chardev/char.c     |  5 +++++
>  qapi/char.json     |  4 ++--
>  qemu-options.hx    | 24 ++++++++++++++++++------
>  4 files changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cc2f7617fe..b5a4eb59fc 100644
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
>      Chardev *chr =3D CHARDEV(obj);
>      PtyChardev *s =3D PTY_CHARDEV(obj);
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
> +    char *symlink_path =3D backend->u.pty.data->device;
>
>      master_fd =3D qemu_openpty_raw(&slave_fd, pty_name);
>      if (master_fd < 0) {
> @@ -354,12 +363,36 @@ static void char_pty_open(Chardev *chr,
>      g_free(name);
>      s->timer_src =3D NULL;
>      *be_opened =3D false;
> +
> +    /* create symbolic link */
> +    if (symlink_path) {
> +        int res =3D symlink(pty_name, symlink_path);
> +
> +        if (res !=3D 0) {
> +            error_setg_errno(errp, errno, "Failed to create PTY symlink"=
);
> +        } else {
> +            s->symlink_path =3D g_strdup(symlink_path);
> +        }
> +    }
> +}
> +
> +static void char_pty_parse(QemuOpts *opts, ChardevBackend *backend,
> +                           Error **errp)
> +{
> +    const char *path =3D qemu_opt_get(opts, "path");
> +    ChardevHostdev *dev;
> +
> +    backend->type =3D CHARDEV_BACKEND_KIND_PTY;
> +    dev =3D backend->u.pty.data =3D g_new0(ChardevHostdev, 1);
> +    qemu_chr_parse_common(opts, qapi_ChardevHostdev_base(dev));
> +    dev->device =3D path ? g_strdup(path) : NULL;

minor nit, g_strdup(NULL) returns NULL. Get rid of "?:" if you send a v3.

>  }
>
>  static void char_pty_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>
> +    cc->parse =3D char_pty_parse;
>      cc->open =3D char_pty_open;
>      cc->chr_write =3D char_pty_chr_write;
>      cc->chr_update_read_handler =3D pty_chr_update_read_handler;
> diff --git a/chardev/char.c b/chardev/char.c
> index 3c43fb1278..404c6b8a4f 100644
> --- a/chardev/char.c
> +++ b/chardev/char.c
> @@ -428,6 +428,11 @@ QemuOpts *qemu_chr_parse_compat(const char *label, c=
onst char *filename,
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
> index 8ca7f34ef0..94ffb1a605 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -3569,7 +3569,7 @@ DEF("chardev", HAS_ARG, QEMU_OPTION_chardev,
>      "-chardev console,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=
=3Don|off]\n"
>      "-chardev serial,id=3Did,path=3Dpath[,mux=3Don|off][,logfile=3DPATH]=
[,logappend=3Don|off]\n"
>  #else
> -    "-chardev pty,id=3Did[,mux=3Don|off][,logfile=3DPATH][,logappend=3Do=
n|off]\n"
> +    "-chardev pty,id=3Did[,path=3Dpath][,mux=3Don|off][,logfile=3DPATH][=
,logappend=3Don|off]\n"
>      "-chardev stdio,id=3Did[,mux=3Don|off][,signal=3Don|off][,logfile=3D=
PATH][,logappend=3Don|off]\n"
>  #endif
>  #ifdef CONFIG_BRLAPI
> @@ -3808,12 +3808,18 @@ The available backends are:
>
>      ``path`` specifies the name of the serial device to open.
>
> -``-chardev pty,id=3Did``
> -    Create a new pseudo-terminal on the host and connect to it. ``pty``
> -    does not take any options.
> +``-chardev pty,id=3Did[,path=3Dpath]``
> +    Create a new pseudo-terminal on the host and connect to it.
>
>      ``pty`` is not available on Windows hosts.
>
> +    If ``path`` is specified, QEMU will create a symbolic link at
> +    that location which points to the new PTY device.
> +
> +    This avoids having to make QMP or HMP monitor queries to find out
> +    what the new PTY device path is.
> +
> +
>  ``-chardev stdio,id=3Did[,signal=3Don|off]``
>      Connect to standard input and standard output of the QEMU process.
>
> @@ -4171,8 +4177,14 @@ SRST
>
>              vc:80Cx24C
>
> -    ``pty``
> -        [Linux only] Pseudo TTY (a new PTY is automatically allocated)
> +    ``pty[:path]``
> +        [Linux only] Pseudo TTY (a new PTY is automatically allocated).
> +
> +        If ``path`` is specified, QEMU will create a symbolic link at
> +        that location which points to the new PTY device.
> +
> +        This avoids having to make QMP or HMP monitor queries to find
> +        out what the new PTY device path is.
>
>      ``none``
>          No device is allocated. Note that for machine types which
> --
> 2.45.1.288.g0e0cd299f1-goog
>


