Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8B3EC3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 06:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUKQC-00039D-At; Thu, 18 Jul 2024 02:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUKQ8-000367-68
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 02:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUKQ4-0004Mo-3q
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 02:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721283311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEVVQJSTY9HCtSlr1Q/xug+Em8nngDWrelzkU8eS0Bs=;
 b=NXxTiifHtBTWbAwe5KrKl3UAuA7Rhs6GqW5QAsHUxsexSTsON/De6rFK7Z09cH1Z9NAA2/
 eCFlYoKZZDGa07ms84OS7bqQzSbMFUmcmBV/dtAFEY+uz2ZKw/sm4gjkx+dO8TNcviJpzb
 GOmCmuO/DA9MaUuSSGFM7GqfR1pJRBM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-rXTqjqB4Op-Y_rEaULqDvw-1; Thu,
 18 Jul 2024 02:15:05 -0400
X-MC-Unique: rXTqjqB4Op-Y_rEaULqDvw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E7561955D52; Thu, 18 Jul 2024 06:15:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A354D19560AA; Thu, 18 Jul 2024 06:15:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A85E21E668A; Thu, 18 Jul 2024 08:15:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,  eblake@redhat.com,
 armbru@redhat.com,  peter.maydell@linaro.org,  berrange@redhat.com,
 Paulo Neves <ptsneves@gmail.com>
Subject: Re: [PATCH v3] chardev: add path option for pty backend
In-Reply-To: <20240605185050.1678102-1-tavip@google.com> (Octavian Purdila's
 message of "Wed, 5 Jun 2024 11:50:50 -0700")
References: <20240605185050.1678102-1-tavip@google.com>
Date: Thu, 18 Jul 2024 08:15:01 +0200
Message-ID: <87r0br8bve.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Looks like this one fell through the cracks.

Octavian Purdila <tavip@google.com> writes:

> Add path option to the pty char backend which will create a symbolic
> link to the given path that points to the allocated PTY.
>
> This avoids having to make QMP or HMP monitor queries to find out what
> the new PTY device path is.

QMP commands chardev-add and chardev-change return the information you
want:

    # @pty: name of the slave pseudoterminal device, present if and only
    #     if a chardev of type 'pty' was created

So does HMP command chardev-add.  HMP chardev apparently doesn't, but
that could be fixed.

So, the use case is basically the command line, right?

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
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
> Changes since v2:
>
>  * remove NULL path check, g_strdup() allows NULL inputs=20=20
>
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
> chardev/char-pty.c | 33 +++++++++++++++++++++++++++++++++
>  chardev/char.c     |  5 +++++
>  qapi/char.json     |  4 ++--
>  qemu-options.hx    | 24 ++++++++++++++++++------
>  4 files changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/chardev/char-pty.c b/chardev/char-pty.c
> index cc2f7617fe..5c6172ddba 100644
> --- a/chardev/char-pty.c
> +++ b/chardev/char-pty.c
> @@ -29,6 +29,7 @@
>  #include "qemu/sockets.h"
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
> +#include "qemu/option.h"
>  #include "qemu/qemu-print.h"
>=20=20
>  #include "chardev/char-io.h"
> @@ -41,6 +42,7 @@ struct PtyChardev {
>=20=20
>      int connected;
>      GSource *timer_src;
> +    char *symlink_path;
>  };
>  typedef struct PtyChardev PtyChardev;
>=20=20
> @@ -204,6 +206,12 @@ static void char_pty_finalize(Object *obj)
>      Chardev *chr =3D CHARDEV(obj);
>      PtyChardev *s =3D PTY_CHARDEV(obj);
>=20=20
> +    /* unlink symlink */
> +    if (s->symlink_path) {
> +        unlink(s->symlink_path);
> +        g_free(s->symlink_path);
> +    }

Runs when the chardev object is finalized.

Doesn't run when QEMU crashes.  Stale symlink left behind then.  Can't
see how you could avoid that at reasonable cost.  Troublesome all the
same.

> +
>      pty_chr_state(chr, 0);
>      object_unref(OBJECT(s->ioc));
>      pty_chr_timer_cancel(s);
> @@ -330,6 +338,7 @@ static void char_pty_open(Chardev *chr,
>      int master_fd, slave_fd;
>      char pty_name[PATH_MAX];
>      char *name;
> +    char *symlink_path =3D backend->u.pty.data->device;
>=20=20
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
> +    dev->device =3D g_strdup(path);

Put a pin into this line.

>  }
>=20=20
>  static void char_pty_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc =3D CHARDEV_CLASS(oc);
>=20=20
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
   { 'struct': 'ChardevHostdev',
     'data': { 'device': 'str' },
     'base': 'ChardevCommon' }
> @@ -650,7 +650,7 @@
>              'pipe': 'ChardevHostdevWrapper',
>              'socket': 'ChardevSocketWrapper',
>              'udp': 'ChardevUdpWrapper',
> -            'pty': 'ChardevCommonWrapper',
> +            'pty': 'ChardevHostdevWrapper',

This adds member @device.

The fact that @device is since 9.1 remains undocumented.

In HMP and CLI, the new option is called "path".

In QMP, it's called "device".  Not only is this inconsistent (see the
pin above), it's misleading: it's not a device name, it's the name of a
symbolic link pointing to a slave PTY device file.

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
>=20=20
>      ``path`` specifies the name of the serial device to open.
>=20=20
> -``-chardev pty,id=3Did``
> -    Create a new pseudo-terminal on the host and connect to it. ``pty``
> -    does not take any options.
> +``-chardev pty,id=3Did[,path=3Dpath]``
> +    Create a new pseudo-terminal on the host and connect to it.
>=20=20
>      ``pty`` is not available on Windows hosts.
>=20=20
> +    If ``path`` is specified, QEMU will create a symbolic link at
> +    that location which points to the new PTY device.
> +
> +    This avoids having to make QMP or HMP monitor queries to find out
> +    what the new PTY device path is.
> +
> +
>  ``-chardev stdio,id=3Did[,signal=3Don|off]``
>      Connect to standard input and standard output of the QEMU process.
>=20=20
> @@ -4171,8 +4177,14 @@ SRST
>=20=20
>              vc:80Cx24C
>=20=20
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
>=20=20
>      ``none``
>          No device is allocated. Note that for machine types which

Sure we want to extend the old-style syntax?  I vaguely recall we
already have certain configuration knobs that are unavailable there.


The feature feels rather doubtful to me, to be honest.


