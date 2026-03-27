Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF26D10F2871
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:34:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Eoc-00053l-UZ; Fri, 27 Mar 2026 17:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6EoX-00053W-UM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w6EoV-000664-CM
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774647234;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAWUZWTcWRaOcd8lNZuhtgtN4JPr77te8yClD7+BvEE=;
 b=bODfEG1Oe8Kv0spAe8Ea0ZpboasRzhTRMteHSHJ3FFnmiijCS4pklK840DMHX25IVChDkJ
 N5z5P40BAI8oGC8LqUn5MIvIwKR9q4so0KmkIL7jxQ9Dhc/hZtfRycTkYWHCiaBRljvgRk
 +EM35+quAIvenKZEYKi3IyE9HjmXlhI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-NWeF7E0sMNWaiVmFU6Adsg-1; Fri, 27 Mar 2026 17:33:53 -0400
X-MC-Unique: NWeF7E0sMNWaiVmFU6Adsg-1
X-Mimecast-MFC-AGG-ID: NWeF7E0sMNWaiVmFU6Adsg_1774647232
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89cda8de681so76813426d6.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:33:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774647232; cv=none;
 d=google.com; s=arc-20240605;
 b=FVpT3eKwPAQO4QZP05KOefoYdz3Ca/LXPvnjKzWQt0AM7HdOrigDDmbsdt/lWunleW
 tK7FfyYZ2WyQPOrKekjeeM3Ep2WgHzFe3zB/zvosP8i3ebcL8u6P7CH9he3CgERUJ//5
 hKMIywSLYQIWgf5c+Cqin0/5OzSxtei/uPcWbHZO2AEN1zdxnPkd6AlP1TMKTIA4FESF
 gnTmyLlLcE4Xts4MSbOnmhroNijzgEhlyPXzuAFpONUKl9MzVu8P+NAY4xXHbsjTVKUG
 PDC6tnsXzJESJR4NOnM17FCk2+sRpuggvTbf3mlY5z0ksMBn7ZLSFRF7B6W8ewcvcgGB
 3xMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=EAWUZWTcWRaOcd8lNZuhtgtN4JPr77te8yClD7+BvEE=;
 fh=gGesB9kIxiG+Xu93xmpFbwivPQ10qv9ZPxXujeYeO5I=;
 b=GaY6A5JZYiOSnDFn5rFqFaUKUctwte4NSEdCQrCRcbuw0UwverCvB9zXcoDOlGoPun
 /Y+emlK/PdBHXMo3iKyq4zr9Rr5mTCQIH/5i3qQRuxz80JefQBQtZyXVH0yvICXI1n2W
 uNZFx1NS4oW06M/PNVAG6kC5geGsMwh5xfvLLtCfoEU0230oWL8Cy7F3nOdlQ3QOqc+W
 lWDJOVulZ/gRfXZETtEXUiLutCLAqv/nGjDEN4YmwJIuJDfeBAhFiHyw2KRvzOaLNIeJ
 OmBRkFzacoB2zkVzX9iXLZlPa+U6/WRyZDH+OlmG1t9xynH9Vw8Qi4YLQ6mZe3hL8Ryb
 6dMg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774647232; x=1775252032; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EAWUZWTcWRaOcd8lNZuhtgtN4JPr77te8yClD7+BvEE=;
 b=aTWt1npMnn15iu0GdLrfZHzLuoOyPJqr75nq4/E0m/aZJ53b6ubn2gJPYHaRnZRsXi
 9AsgdoAsPIcTOETXsJzYEDuv9APD4YUtW8v4glqD6OTYfuuZi4ATQ8LDNnR016zKb14v
 3W7IP3c979F/SPdHmMSwVbSWDjdCWMGk4Kq05zObX5pbb3rXTUJfBgVe2KnVruPrGXzB
 wPafd61iQH2K1W73AsJXpQ+JB54YVU4nHHqRln6gWm5SvMh3pYZDCfOocAaxoNX49TXa
 Tep6Bc7KYr59gdCWUa0ER/hPP8az8TTZvOP/A/juNj53Mnc5VfVSz/RKtBCvLtM5zDKP
 H3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774647232; x=1775252032;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EAWUZWTcWRaOcd8lNZuhtgtN4JPr77te8yClD7+BvEE=;
 b=QNgtsYzv0xyTkz4xpnLJ8TxWqaU0VKNZ9BB3gSDkVKinn1oxy0fl38nMU8zzLm/iq+
 9wJSYiGZZFYquY8ujqiiSB7iQEoaYmV3OLYU9PwVc1E9PvieF44vdksuGJx28qCiKYC8
 wiORij3rfbWQs4oikZd3ODKARsWqxOF+TMZirTrhxlFRUqEno00CU4LlWPEIoHMvZpBR
 qQWrlHvFyuwoWEtbAI9xZo8sayKGxexylY80+Qo0nnKij3XJYqPslaovwygCqv0Wsant
 WiaM2LxcOotnog190BsB3OKelFKN5n+or1FAowDTCYBAd+6AocdSC2bz32mokhxCgfpK
 TjGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxVc3g9fZeuPaVmnVI9CyDHnrI5H05YaWynIuAv54MJTGaiKfWNFJm6Qw9f47jCNGejZ3YFVrig7kN@nongnu.org
X-Gm-Message-State: AOJu0YyHIDSPjt47XdoqDvSM6wTYftgm0qPfsn84DXE6keppJldRWMO6
 XYPqtU1H4mHGuBHkpbfPCao3qH+7ijlwWhp3xnGHm6iTTiiQx90P9iw9cDMo3bpdBgL/Y26eHTS
 943DAsNZdiKn0QGmfkheibewRYY2hTfCSw/sJ8Go4nJ6aMjtGjNGiCL/5+BDWrSqmXoWqmvxh9B
 B+dadTq9wLQcpf7dhDU7gSLswbc/x0IzRuFqklCNGjFA==
X-Gm-Gg: ATEYQzyYArlnzdx5X01HzO3Y0co7xbCJplaC1YE9U2ga42Ll6D/hvsMmwAQfvEBFVxS
 y+rgpJe2PpuOJbmErS6BNEgpZ4PuOzWVE3OhTdZM0CnncRIClhY3nWXBQGIcg3XZo3KEjlAi2rH
 +jtS/0DOVqBIWcrp4Lo7MYMdwhPaLZL6TKsrxLDaQTcYjmKT5iU4NO1u+krn6lI1MVWm6VYhBgY
 w7UfrCa
X-Received: by 2002:a05:6214:62b:b0:89c:ab9c:8847 with SMTP id
 6a1803df08f44-89ce8f0e087mr59561756d6.44.1774647232225; 
 Fri, 27 Mar 2026 14:33:52 -0700 (PDT)
X-Received: by 2002:a05:6214:62b:b0:89c:ab9c:8847 with SMTP id
 6a1803df08f44-89ce8f0e087mr59561286d6.44.1774647231635; Fri, 27 Mar 2026
 14:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260327102515.502822-5-cathy.hu@suse.com>
 <acaVRtE-NPUa5Ujy@redhat.com>
In-Reply-To: <acaVRtE-NPUa5Ujy@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 27 Mar 2026 23:33:40 +0200
X-Gm-Features: AQROBzBex3Y5n-LVx_VE6DXz44WQ-ABtr0mIOqYz_9IsiyctKRbkdyttqrZ4cmc
Message-ID: <CAPMcbCoZUQh+w9kAKb0Zppr_b8B0ZtNk0BjuOJh47TTBoevHeg@mail.gmail.com>
Subject: Re: [PATCH RFC] qga: Add selinux-helper for guest-exec subcommand
 (bsc#1237450)
To: Cathy Hu <cathy.hu@suse.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Cathy Hu <cahu@suse.de>, 
 Fabiano Rosas <fabiano.rosas@suse.com>, KVM Bugs <kvm-bugs@suse.de>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000d7f4b3064e0841d1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--000000000000d7f4b3064e0841d1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I totally agree with Daniel.

We have a lot of questions or feature requests related to exec/files
commands to add allow/deny lists, etc.
There is no good solution and in 2026 this is not looks like a good feature
at all.

Your patch is more like a workaround for Linux-only and doesn't improve
Windows security.

As Daniel already mentioned, in RHEL, we disable all these unconfineable
commands.
Also, SSH over VSock is available for both Linux and Windows.

I think we should start a discussion about marking exec/files commands as
deprecated
and remove it at some point.
Now better communication method exists.

On Fri, Mar 27, 2026 at 4:35=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Fri, Mar 27, 2026 at 11:25:19AM +0100, Cathy Hu wrote:
> > From: Cathy Hu <cahu@suse.de>
> >
> > Problem:
> >
> > ATM the QEMU Guest Agent and SELinux are not working together properly.
> > The fedora (and therefor also the openSUSE) policy confine the
> qemu-guest-agent
> > service in the domain `qemu_ga_t`. That means, qemu-guest-agent
> > is only allowed to do what the policy says.
> >
> > However, the `guest-exec` command allows arbitrary execution
> > of code from a privileged service, which conflicts with the
> > notion of SELinux confinement.
> >
> > ATM, the policy allows only some accesses that are used
> > by other qemu-guest-agent commands.
> > That means, the qemu-guest-agent fails sporadically, depending
> > on what is allowed for other commands.
> > However, `guest-exec` would need to allow everything.
> >
> > see https://bugzilla.suse.com/show_bug.cgi?id=3D1237450
> >
> > Solution:
> >
> > This is not an great solution, but it works like this:
> > We add a "wrapper" which is executed instead of the program
> > that is called via `guest-exec`. The "wrapper" just
> > re-executes the command given by `guest-exec`.
> > This way, on the SELinux policy side we can give that
> > wrapper executable a label on the file system.
> > With that label, we can transition into a more broader
> > unconfined domain _and_ toggle that transition with a
> > SELinux boolean. That would make `guest-exec`
> > consistently allowed to execute or not by policy.
> >
> > This needs a change on the SELinux policy side to
> > accompany this with:
> > https://github.com/fedora-selinux/selinux-policy/pull/3122
> >
> > What other options have been tried unsuccessfully:
> >
> > - Fixing via SELinux policy: It is not possible for
> >   one domain to have different permissions depending on
> >   code path. It is also not possible to toggle the permissive
> >   state via a SELinux boolean, so users would need
> >   to add it via semanage.
> > - Setting the domain of the executed commands directly
> >   to a broader domain with setcon/setexeccon.
> >   The SELinux kernel does not allow to spawn a process
> >   directly with those that has broader privileges than the parent.
> >
> > What other options are there to solve this issue:
> >
> > - Making the qemu-guest-agent unconfined by default
> > - Document the workaround to use semanage to make the domain permissive
> >   if `exec-guest` is needed as works as intended and ignore the problem
>
> IMHO, the 'exec' command should never have been added to the
> QEMU guest agent, for precisely this reason that it makes it
> impractical to put any meaningful security controls around it.
> Likewise the commands which allow arbitrary file read/write.
>
> QEMU guest agent should focus on specific targetted tasks
> with dedicated commands.
>
> NB: in RHEL we disable all those unconfinable commands.
>
>
> If users want to support an ability to have arbitrary command
> execution, then that should be done with SSH over VSock, where
> the guest owner can choose whether to require authentication
> first or not, and use SSH authorized_keys if desired to limit
> what commands can be run for a given recorded key.
>
> These days systemd installs magic to allow SSH'ing directly
> to a guest using VSOCK addresses, and libvirt further
> enhances that to allow SSH'ing to a named VM.
>
>
> We're repeatedly getting patches to add more functionality to
> the "exec" command and they all reflect the fact that what
> users need is a general purpose shell with vastly more
> functionality than the 'exec' command - authentication,
> and authorization being top of the list. IMHO this is not
> something QEMU should be trying to address.
>
> >
> > Signed-off-by: Cathy Hu <cahu@suse.de>
> > ---
> >  qga/commands.c               | 13 +++++++++++++
> >  qga/meson.build              |  7 +++++++
> >  qga/qemu-ga-selinux-helper.c | 17 +++++++++++++++++
> >  3 files changed, 37 insertions(+)
> >  create mode 100644 qga/qemu-ga-selinux-helper.c
> >
> > diff --git a/qga/commands.c b/qga/commands.c
> > index 5f20af25d3..29c092630b 100644
> > --- a/qga/commands.c
> > +++ b/qga/commands.c
> > @@ -30,6 +30,10 @@
> >   */
> >  #define GUEST_FILE_READ_COUNT_MAX (48 * MiB)
> >
> > +#ifdef CONFIG_SELINUX
> > +#define GUEST_EXEC_SELINUX_HELPER CONFIG_QEMU_HELPERDIR
> "/qemu-ga-selinux-helper"
> > +#endif
> > +
> >  /* Note: in some situations, like with the fsfreeze, logging may be
> >   * temporarily disabled. if it is necessary that a command be able
> >   * to log for accounting purposes, check ga_logging_enabled()
> beforehand.
> > @@ -418,6 +422,9 @@ GuestExec *qmp_guest_exec(const char *path,
> >      GuestExecInfo *gei;
> >      char **argv, **envp;
> >      strList arglist;
> > +#ifdef CONFIG_SELINUX
> > +    strList helper_arg;
> > +#endif
> >      gboolean ret;
> >      GError *gerr =3D NULL;
> >      gint in_fd, out_fd, err_fd;
> > @@ -439,7 +446,13 @@ GuestExec *qmp_guest_exec(const char *path,
> >          }
> >      }
> >
> > +#ifdef CONFIG_SELINUX
> > +    helper_arg.value =3D get_relocated_path(GUEST_EXEC_SELINUX_HELPER)=
;
> > +    helper_arg.next =3D &arglist;
> > +    argv =3D guest_exec_get_args(&helper_arg, true);
> > +#else
> >      argv =3D guest_exec_get_args(&arglist, true);
> > +#endif
> >      envp =3D has_env ? guest_exec_get_args(env, false) : NULL;
> >
> >      flags =3D G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REAP_CHILD |
> > diff --git a/qga/meson.build b/qga/meson.build
> > index 89a4a8f713..61f60fba26 100644
> > --- a/qga/meson.build
> > +++ b/qga/meson.build
> > @@ -125,6 +125,13 @@ qga =3D executable('qemu-ga', qga_ss.sources() +
> qga_objs,
> >                   install: true)
> >  all_qga +=3D qga
> >
> > +if selinux.found()
> > +  qga_selinux_helper =3D executable('qemu-ga-selinux-helper',
> files('qemu-ga-selinux-helper.c'),
> > +             install: true,
> > +             install_dir: get_option('libexecdir'))
> > +  all_qga +=3D qga_selinux_helper
> > +endif
> > +
> >  if host_os =3D=3D 'windows'
> >    qemu_ga_msi_arch =3D {
> >      'x86': ['-D', 'Arch=3D32'],
> > diff --git a/qga/qemu-ga-selinux-helper.c b/qga/qemu-ga-selinux-helper.=
c
> > new file mode 100644
> > index 0000000000..a184e74ede
> > --- /dev/null
> > +++ b/qga/qemu-ga-selinux-helper.c
> > @@ -0,0 +1,17 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +#include <stdio.h>
> > +#include <glib.h>
> > +
> > +int main(int argc, char **argv)
> > +{
> > +    if (argc < 2) {
> > +        return EXIT_FAILURE;
> > +    }
> > +
> > +    execvp(argv[1], argv + 1);
> > +
> > +    int err =3D errno;
> > +    fprintf(stderr, "%s: %s\n", argv[1], strerror(err));
> > +
> > +    exit(EXIT_FAILURE);
> > +}
> > --
> > 2.53.0
> >
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>
>
>

--000000000000d7f4b3064e0841d1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I totally=C2=A0agree with Daniel.=C2=A0</div><div><br=
></div><div>We have a lot of questions or feature requests related to exec/=
files commands to add allow/deny lists, etc.</div><div>There is no good sol=
ution and in 2026 this is not looks like a good feature at all.</div><div><=
br></div><div>Your patch is more like a workaround for Linux-only and doesn=
&#39;t improve Windows security.=C2=A0</div><div><br></div><div>As Daniel a=
lready mentioned, in RHEL, we disable all these unconfineable commands.</di=
v><div>Also, SSH over VSock is available=C2=A0for both Linux and Windows.</=
div><div><br></div><div>I think we should start a discussion=C2=A0about mar=
king exec/files commands as deprecated</div><div>and remove it at some poin=
t.=C2=A0</div><div>Now better communication=C2=A0method exists.</div></div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Fri, Mar 27, 2026 at 4:35=E2=80=AFPM Daniel P. Berrang=
=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.com</a>&g=
t; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On Fri=
, Mar 27, 2026 at 11:25:19AM +0100, Cathy Hu wrote:<br>
&gt; From: Cathy Hu &lt;<a href=3D"mailto:cahu@suse.de" target=3D"_blank">c=
ahu@suse.de</a>&gt;<br>
&gt; <br>
&gt; Problem:<br>
&gt; <br>
&gt; ATM the QEMU Guest Agent and SELinux are not working together properly=
.<br>
&gt; The fedora (and therefor also the openSUSE) policy confine the qemu-gu=
est-agent<br>
&gt; service in the domain `qemu_ga_t`. That means, qemu-guest-agent<br>
&gt; is only allowed to do what the policy says.<br>
&gt; <br>
&gt; However, the `guest-exec` command allows arbitrary execution<br>
&gt; of code from a privileged service, which conflicts with the<br>
&gt; notion of SELinux confinement.<br>
&gt; <br>
&gt; ATM, the policy allows only some accesses that are used<br>
&gt; by other qemu-guest-agent commands.<br>
&gt; That means, the qemu-guest-agent fails sporadically, depending<br>
&gt; on what is allowed for other commands.<br>
&gt; However, `guest-exec` would need to allow everything.<br>
&gt; <br>
&gt; see <a href=3D"https://bugzilla.suse.com/show_bug.cgi?id=3D1237450" re=
l=3D"noreferrer" target=3D"_blank">https://bugzilla.suse.com/show_bug.cgi?i=
d=3D1237450</a><br>
&gt; <br>
&gt; Solution:<br>
&gt; <br>
&gt; This is not an great solution, but it works like this:<br>
&gt; We add a &quot;wrapper&quot; which is executed instead of the program<=
br>
&gt; that is called via `guest-exec`. The &quot;wrapper&quot; just<br>
&gt; re-executes the command given by `guest-exec`.<br>
&gt; This way, on the SELinux policy side we can give that<br>
&gt; wrapper executable a label on the file system.<br>
&gt; With that label, we can transition into a more broader<br>
&gt; unconfined domain _and_ toggle that transition with a<br>
&gt; SELinux boolean. That would make `guest-exec`<br>
&gt; consistently allowed to execute or not by policy.<br>
&gt; <br>
&gt; This needs a change on the SELinux policy side to<br>
&gt; accompany this with:<br>
&gt; <a href=3D"https://github.com/fedora-selinux/selinux-policy/pull/3122"=
 rel=3D"noreferrer" target=3D"_blank">https://github.com/fedora-selinux/sel=
inux-policy/pull/3122</a><br>
&gt; <br>
&gt; What other options have been tried unsuccessfully:<br>
&gt; <br>
&gt; - Fixing via SELinux policy: It is not possible for<br>
&gt;=C2=A0 =C2=A0one domain to have different permissions depending on<br>
&gt;=C2=A0 =C2=A0code path. It is also not possible to toggle the permissiv=
e<br>
&gt;=C2=A0 =C2=A0state via a SELinux boolean, so users would need<br>
&gt;=C2=A0 =C2=A0to add it via semanage.<br>
&gt; - Setting the domain of the executed commands directly<br>
&gt;=C2=A0 =C2=A0to a broader domain with setcon/setexeccon.<br>
&gt;=C2=A0 =C2=A0The SELinux kernel does not allow to spawn a process<br>
&gt;=C2=A0 =C2=A0directly with those that has broader privileges than the p=
arent.<br>
&gt; <br>
&gt; What other options are there to solve this issue:<br>
&gt; <br>
&gt; - Making the qemu-guest-agent unconfined by default<br>
&gt; - Document the workaround to use semanage to make the domain permissiv=
e<br>
&gt;=C2=A0 =C2=A0if `exec-guest` is needed as works as intended and ignore =
the problem<br>
<br>
IMHO, the &#39;exec&#39; command should never have been added to the<br>
QEMU guest agent, for precisely this reason that it makes it<br>
impractical to put any meaningful security controls around it.<br>
Likewise the commands which allow arbitrary file read/write.<br>
<br>
QEMU guest agent should focus on specific targetted tasks<br>
with dedicated commands.<br>
<br>
NB: in RHEL we disable all those unconfinable commands.<br>
<br>
<br>
If users want to support an ability to have arbitrary command<br>
execution, then that should be done with SSH over VSock, where<br>
the guest owner can choose whether to require authentication<br>
first or not, and use SSH authorized_keys if desired to limit<br>
what commands can be run for a given recorded key.<br>
<br>
These days systemd installs magic to allow SSH&#39;ing directly<br>
to a guest using VSOCK addresses, and libvirt further<br>
enhances that to allow SSH&#39;ing to a named VM.<br>
<br>
<br>
We&#39;re repeatedly getting patches to add more functionality to<br>
the &quot;exec&quot; command and they all reflect the fact that what<br>
users need is a general purpose shell with vastly more<br>
functionality than the &#39;exec&#39; command - authentication,<br>
and authorization being top of the list. IMHO this is not<br>
something QEMU should be trying to address.<br>
<br>
&gt; <br>
&gt; Signed-off-by: Cathy Hu &lt;<a href=3D"mailto:cahu@suse.de" target=3D"=
_blank">cahu@suse.de</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0| 13 +++++++++++++<br>
&gt;=C2=A0 qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
|=C2=A0 7 +++++++<br>
&gt;=C2=A0 qga/qemu-ga-selinux-helper.c | 17 +++++++++++++++++<br>
&gt;=C2=A0 3 files changed, 37 insertions(+)<br>
&gt;=C2=A0 create mode 100644 qga/qemu-ga-selinux-helper.c<br>
&gt; <br>
&gt; diff --git a/qga/commands.c b/qga/commands.c<br>
&gt; index 5f20af25d3..29c092630b 100644<br>
&gt; --- a/qga/commands.c<br>
&gt; +++ b/qga/commands.c<br>
&gt; @@ -30,6 +30,10 @@<br>
&gt;=C2=A0 =C2=A0*/<br>
&gt;=C2=A0 #define GUEST_FILE_READ_COUNT_MAX (48 * MiB)<br>
&gt;=C2=A0 <br>
&gt; +#ifdef CONFIG_SELINUX<br>
&gt; +#define GUEST_EXEC_SELINUX_HELPER CONFIG_QEMU_HELPERDIR &quot;/qemu-g=
a-selinux-helper&quot;<br>
&gt; +#endif<br>
&gt; +<br>
&gt;=C2=A0 /* Note: in some situations, like with the fsfreeze, logging may=
 be<br>
&gt;=C2=A0 =C2=A0* temporarily disabled. if it is necessary that a command =
be able<br>
&gt;=C2=A0 =C2=A0* to log for accounting purposes, check ga_logging_enabled=
() beforehand.<br>
&gt; @@ -418,6 +422,9 @@ GuestExec *qmp_guest_exec(const char *path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GuestExecInfo *gei;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 char **argv, **envp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 strList arglist;<br>
&gt; +#ifdef CONFIG_SELINUX<br>
&gt; +=C2=A0 =C2=A0 strList helper_arg;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gboolean ret;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GError *gerr =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 gint in_fd, out_fd, err_fd;<br>
&gt; @@ -439,7 +446,13 @@ GuestExec *qmp_guest_exec(const char *path,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; +#ifdef CONFIG_SELINUX<br>
&gt; +=C2=A0 =C2=A0 helper_arg.value =3D get_relocated_path(GUEST_EXEC_SELI=
NUX_HELPER);<br>
&gt; +=C2=A0 =C2=A0 helper_arg.next =3D &amp;arglist;<br>
&gt; +=C2=A0 =C2=A0 argv =3D guest_exec_get_args(&amp;helper_arg, true);<br=
>
&gt; +#else<br>
&gt;=C2=A0 =C2=A0 =C2=A0 argv =3D guest_exec_get_args(&amp;arglist, true);<=
br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 envp =3D has_env ? guest_exec_get_args(env, false)=
 : NULL;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 flags =3D G_SPAWN_SEARCH_PATH | G_SPAWN_DO_NOT_REA=
P_CHILD |<br>
&gt; diff --git a/qga/meson.build b/qga/meson.build<br>
&gt; index 89a4a8f713..61f60fba26 100644<br>
&gt; --- a/qga/meson.build<br>
&gt; +++ b/qga/meson.build<br>
&gt; @@ -125,6 +125,13 @@ qga =3D executable(&#39;qemu-ga&#39;, qga_ss.sour=
ces() + qga_objs,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0in=
stall: true)<br>
&gt;=C2=A0 all_qga +=3D qga<br>
&gt;=C2=A0 <br>
&gt; +if selinux.found()<br>
&gt; +=C2=A0 qga_selinux_helper =3D executable(&#39;qemu-ga-selinux-helper&=
#39;, files(&#39;qemu-ga-selinux-helper.c&#39;),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install: true,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0install_dir: get_opti=
on(&#39;libexecdir&#39;))<br>
&gt; +=C2=A0 all_qga +=3D qga_selinux_helper<br>
&gt; +endif<br>
&gt; +<br>
&gt;=C2=A0 if host_os =3D=3D &#39;windows&#39;<br>
&gt;=C2=A0 =C2=A0 qemu_ga_msi_arch =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &#39;x86&#39;: [&#39;-D&#39;, &#39;Arch=3D32&#39;]=
,<br>
&gt; diff --git a/qga/qemu-ga-selinux-helper.c b/qga/qemu-ga-selinux-helper=
.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000000..a184e74ede<br>
&gt; --- /dev/null<br>
&gt; +++ b/qga/qemu-ga-selinux-helper.c<br>
&gt; @@ -0,0 +1,17 @@<br>
&gt; +/* SPDX-License-Identifier: GPL-2.0-or-later */<br>
&gt; +#include &lt;stdio.h&gt;<br>
&gt; +#include &lt;glib.h&gt;<br>
&gt; +<br>
&gt; +int main(int argc, char **argv)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (argc &lt; 2) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return EXIT_FAILURE;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 execvp(argv[1], argv + 1);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 int err =3D errno;<br>
&gt; +=C2=A0 =C2=A0 fprintf(stderr, &quot;%s: %s\n&quot;, argv[1], strerror=
(err));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 exit(EXIT_FAILURE);<br>
&gt; +}<br>
&gt; -- <br>
&gt; 2.53.0<br>
&gt; <br>
&gt; <br>
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0~~=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 <a href=3D"https://hachyderm.io/@berrange" rel=3D"noreferrer" target=3D=
"_blank">https://hachyderm.io/@berrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer" target=3D"_blank">htt=
ps://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ~~=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"https://entangle-photo.org" rel=3D"noreferrer"=
 target=3D"_blank">https://entangle-photo.org</a> :|<br>
|: <a href=3D"https://pixelfed.art/berrange" rel=3D"noreferrer" target=3D"_=
blank">https://pixelfed.art/berrange</a>=C2=A0 =C2=A0~~=C2=A0 =C2=A0 <a hre=
f=3D"https://fstop138.berrange.com" rel=3D"noreferrer" target=3D"_blank">ht=
tps://fstop138.berrange.com</a> :|<br>
<br>
<br>
</blockquote></div>

--000000000000d7f4b3064e0841d1--


