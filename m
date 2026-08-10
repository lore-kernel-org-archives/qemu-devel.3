Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A118C5AC82
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtL1z-0005cL-O2; Mon, 10 Aug 2026 04:06:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtL1y-0005c9-Kg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:06:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wtL1v-0001K2-Qt
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 04:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786349201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QvOi2w/PQu+Z3+EHQwR0YGGhD4fb9KE/jJh6PYDBZxY=;
 b=HzvDzXw9ee+d3nZoD6KM+lTgcKnqxCx9XDaq1+sZ3eoLe2FhhdLfKnO9A5avdJ3k/qvvhR
 M2ocmBl7yOwyM8aLlTObG66pYPKqeCOOpvzpaTd01a7PqEqu/K1quEVUVsjie41Xyol92k
 LP1KBVUTrcuhk3nh1vP8ESdLWFXOnaM=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-LklGQzCkPoyI35hGfhZexw-1; Mon, 10 Aug 2026 04:06:40 -0400
X-MC-Unique: LklGQzCkPoyI35hGfhZexw-1
X-Mimecast-MFC-AGG-ID: LklGQzCkPoyI35hGfhZexw_1786349199
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0199faafso19385221cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 01:06:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786349199; cv=none;
 d=google.com; s=arc-20260327;
 b=c4sYKWUSxoj2kfRvFLW/6g/HjmvUDtzMH9Sa9rW1q4+bXweVOBRUpm3dK3hzFW3abE
 5EOY/Pm7pNgEIUG8ZQya01dAVdBcNh9ZGKllffaQGeI612ZeLNUyOOD1nZ55UAUxp5Qx
 VvutUSwD93THWpbMinkfXOxEaj90WkUWuyZtFDK0AiWE4+5cv8z9y/ooLJI5hBvSXAeg
 7houMVNy+2+Y/GHrJe6TPJqJmctNS5VmN26PFAlKb4hmAOf+rP/XHEd5VG+Sry/MERIQ
 4K8+cjudOhdpYb0DjdpxEfDMuR0QdhBpsomoijlR5GxsURxY0RdQQ6QkZCqdXFOMTBtL
 Zh7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QvOi2w/PQu+Z3+EHQwR0YGGhD4fb9KE/jJh6PYDBZxY=;
 fh=cOMwAxeKLzDJhiPnuBRlE38QOpa6YhnUA+tSqDMkqpI=;
 b=NUoiHlvBxF1MWDhmaoeZAS0efWjl/eHRLj3IR9pef/VjaRxNQPYanMtLQtCDoIWy4y
 5Qp9eXxH5adiFU0Ma6D4nwY9InyBepqxoRQemPsE9WGLSmglkzIZw+QMMWxlEY3X7j7+
 uUmCQsG0UjFv1oAvtkp/PBrVlmvn+CVj8iSCUPYfUBz8juOC9ff+DxoGIr+khkBFqRro
 W9IOZze3HB7HsuQTIc3vw4/G8qyQREbX25Snlmx89RP8r905zoTm1ySUELtqJ7RYuRqL
 Vz9Q429MyLUpRZYAjJ6wFdxAlWWq/qUe4VHSdy/ONx+BOnphLHifUuBbHzUNnPrGf4Uj
 M4ow==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786349199; x=1786953999; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QvOi2w/PQu+Z3+EHQwR0YGGhD4fb9KE/jJh6PYDBZxY=;
 b=d5EVErMaAHOI9FBS8pc5bOmPfdY/4raGWlmZEUbd+R/fq3iudJ9L+OHZExhHnpoeNN
 gPp6luMSNP04AQjo/X5WNoUFOoTsqAWEz9jf95DhY5wwFXnyvvkeXFlSwooMkCWf7SuV
 8flv4UwdwfmBX/Ujjn9seCpFEmB0/l9sFf9gu395fNkdzoFZbtlvGw+XeZSidLZyEmDB
 ic6X426k6AyACn4YOmhWA9qGHuhWPiBcuiChoDWtz3pTxxzsvdvAauE4jwzHHZWL9gvF
 syK6vvcgbdTmef29SZ4qm4/CIVXY+YTNjqiMVkWbAB78wyqq6jKUFdL4XRyc+KF/MJCQ
 Caxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786349199; x=1786953999;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QvOi2w/PQu+Z3+EHQwR0YGGhD4fb9KE/jJh6PYDBZxY=;
 b=GatrqixBYblVUrYzOf3san76foIhcExbGkosZc/64ZEb0F7yPoslaf6EZFGWKmu+CN
 ZwtbPpdJSNxoqEAVtiQbxVN6boC8WhvzV8dBkmLrOn3aAxX8fdqQmEGe7enDNl0ED25a
 SqdvmSCM0DvNVvJe2lQORreK1G0azgP8j4vqLIU/Aqk1+Solzesy62VVm63U+IDvzECa
 HxrRG0FCFfBoI0OFKHfUvNysdYtNaywregKFJ9acgouLAZ5kyLlF1VwarxiCCbaHVxS/
 a9EdAJ9dbEzckgOU2gJmBup0s6nGZGP6Dh4JpnTeGAG+jea2DEQDc/4tXYYs6A3kmF0V
 TK4g==
X-Gm-Message-State: AOJu0YwIJ7/Krg4pja2kbtaorY4yOXOz08p8TYx5nI8BNrmVEHsWkuRt
 fCW6d/f+YYpTcX3oS+PyKv0AzLFObMV3ubCdXYQgos5Lqq8QI+YviQvMsuyNpkvPnrkIVfVlzdF
 FioE7+LFZti3FSD27hfu1X1zyhWLPv2IuIyGbPXONLmO7qZJjKPp/6ckbEaXeSjgZ2yjSuvm4w+
 DdeI1mCojo4C82A4WtXWVVgQhgOyENTm4=
X-Gm-Gg: AR+sD13fVvIOj5ENpqmmgvHplFrRZSjuRbWi/LYBt2HebiXey+n2iHVHHtaZlnbg52g
 +VN82Yh7ljgZ6kcyeKllTfn387N93debf8RbbJ61hhvpfXEmj3z3dBULPsQvDr/fIzr8xvdkXvI
 KdG+vD06in3lxI4gDX/EKyI9ZWjHPWjDF0kudIXkupR9uZRN0blNjH7WGqAII=
X-Received: by 2002:a05:622a:14e:b0:51b:fde4:cd4f with SMTP id
 d75a77b69052e-52ce6183c7emr428559581cf.30.1786349199270; 
 Mon, 10 Aug 2026 01:06:39 -0700 (PDT)
X-Received: by 2002:a05:622a:14e:b0:51b:fde4:cd4f with SMTP id
 d75a77b69052e-52ce6183c7emr428559001cf.30.1786349198739; Mon, 10 Aug 2026
 01:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
 <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
 <alYdwKHMWoVcay_B@redhat.com>
 <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
In-Reply-To: <CAF2ANE06ah2B37BmL=WQfJYutt1zGP7sPkOWZ+=+-dLdLqZ_MA@mail.gmail.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Mon, 10 Aug 2026 11:06:27 +0300
X-Gm-Features: AUfX_mzs0tEagI7Zw7siFgv-jo390LHgXjgA3_2VIYX4xDS2UlNubuP6SQ7m5OA
Message-ID: <CAPMcbCp0vNA5RwR2W9C7-JYUyd-9QWdSKtLERsSW6mEr1nx9YQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: Valentino Paulon <valentino.paulon88@gmail.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, yvugenfi@redhat.com, 
 michael.roth@amd.com
Content-Type: multipart/alternative; boundary="0000000000006f9fc60658acd591"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000006f9fc60658acd591
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Valentino,

Sorry for the long delay.
I have a question for you

On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon <
valentino.paulon88@gmail.com> wrote:

> > > So, you propose to call seteuid/setegid before any I/O operation?
> >
> > Yes, specifically for the SSH commands, because they're unusual in
> > that we're doing stuff on behalf of an unprivileged user.
>
> +1 on the euid/egid direction -- as the reporter that's the outcome I
> was hoping for. It confines every step (read, mkdir, create, rename,
> chown) to what the target user could already do himself, which removes
> the whole TOCTOU class instead of chasing one instance of it.
>
> A few implementation details that tend to bite with this pattern, in
> case they save a round-trip:
>
> - drop the supplementary groups too, not just egid: initgroups() (or
> setgroups() with the user's list) while still root, otherwise the
> agent's effective access won't match the user's in either direction
>

Technically, there is no limitation to running QGA in unprivileged mode.
Normally, it is a system daemon, but this is not mandatory.
In this case, we can not call initgroups because the caller must
have CAP_SETGID.
We can call initgroups only when QGA runs as root. What do you think?


> -- e.g. group-writable paths under the home.
> - keep the real uid at 0 and change euid/egid only, so it stays
> reversible; setegid() before seteuid() on the way down, restore in
> reverse.
> - effective ids are process-wide, so this assumes the SSH command is
> not doing its I/O from more than one thread concurrently -- worth a
> quick check against the agent's dispatch model.
>

No issue there. All QGA commands are synchronous.


>
> The passwd lookup already runs before any of this, so it can stay
> outside the dropped region.
>
> Happy to re-run my PoC against the reworked version once it's ready and
> confirm the window is closed.
>
> Regards,
> Valentino Paulon
>


Best Regards,
Kostiantyn Kostiuk.


>
> On Tue, Jul 14, 2026 02:30 PM, "Daniel P. Berrang=C3=A9" <berrange@redhat=
.com>
> wrote:
>
>> On Tue, Jul 14, 2026 at 02:28:35PM +0300, Kostiantyn Kostiuk wrote:
>> > On Tue, Jul 14, 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berra=
nge@redhat.com
>> >
>> > wrote:
>> >
>> > > On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrote:
>> > > > Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
>> > > > SSH key for an existing local user, the agent (running as root)
>> decides
>> > > > whether to create the user's .ssh directory with a symlink-followi=
ng
>> > > > directory test, and then writes and chowns the authorized_keys fil=
e.
>> > > > A local unprivileged user who owns their home directory can
>> pre-stage
>> > > > their .ssh directory (or the authorized_keys file) as a symbolic
>> link
>> > > > so that, when the host or operator triggers a key add for that use=
r,
>> > > > the root agent follows the link and transfers ownership of an
>> arbitrary
>> > > > root-owned file or directory to the unprivileged user, who can the=
n
>> > > rewrite
>> > > > it to obtain root
>> > > >
>> > > > Fixes: CVE-2026-12080
>> > > > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
>> > > >
>> > > > Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
>> > > > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
>> > > > ---
>> > > >  qga/commands-posix-ssh.c | 53
>> ++++++++++++++++++++++++++++++++++------
>> > > >  1 file changed, 45 insertions(+), 8 deletions(-)
>> > > >
>> > > > diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
>> > > > index 661972e34e..4e717d8ae8 100644
>> > > > --- a/qga/commands-posix-ssh.c
>> > > > +++ b/qga/commands-posix-ssh.c
>> > > > @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct
>> passwd
>> > > *p,
>> > > >          return false;
>> > > >      }
>> > > >
>> > > > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
>> > > > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
>> > > >          error_setg_errno(errp, errno,
>> > > >                           "failed to set ownership of directory
>> '%s'",
>> > > >                           path);
>> > > > @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv key=
s,
>> > > >          return false;
>> > > >      }
>> > > >
>> > > > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
>> > > > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
>> > > >          error_setg_errno(errp, errno,
>> > > >                           "failed to set ownership of directory
>> '%s'",
>> > > >                           path);
>> > > > @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char
>> > > *username, strList *keys,
>> > > >      g_auto(GStrv) authkeys =3D NULL;
>> > > >      strList *k;
>> > > >      size_t nkeys, nauthkeys;
>> > > > +    int fd;
>> > > >
>> > > >      reset =3D has_reset && reset;
>> > > >
>> > > > @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char
>> > > *username, strList *keys,
>> > > >      ssh_path =3D g_build_filename(p->pw_dir, ".ssh", NULL);
>> > > >      authkeys_path =3D g_build_filename(ssh_path, "authorized_keys=
",
>> NULL);
>> > > >
>> > > > +    fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
>> > > > +    if (fd =3D=3D -1) {
>> > > > +        if (errno !=3D ENOENT) {
>> > > > +            error_setg_errno(errp, errno, "failed to open directo=
ry
>> > > '%s'", ssh_path);
>> > > > +            return;
>> > > > +        }
>> > > > +    }
>> > >
>> > > IIUC, you're trying to protect against the possbility that
>> /home/fred/.ssh
>> > > is
>> > > a symlink to some other privileged directory.
>> > >
>> > > >      if (!reset) {
>> > > >          authkeys =3D read_authkeys(authkeys_path, NULL);
>> > > >      }
>> > > >      if (authkeys =3D=3D NULL) {
>> > > > -        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
>> > > > -            !mkdir_for_user(ssh_path, p, 0700, errp)) {
>> > > > +        if (fd =3D=3D -1 && !mkdir_for_user(ssh_path, p, 0700, er=
rp)) {
>> > > >              return;
>> > > >          }
>> > > >      }
>> > > > +    if (fd >=3D 0) {
>> > > > +        close(fd);
>> > > > +    }
>> > >
>> > > Does holding open an FD on a directory prevent that directory being
>> > > altered ?  Even if it prevents it being deleted, surely there's stil=
l
>> > > a race where the dir could be renamed, andd .ssh turned back into a
>> > > symlink ?
>> > >
>> >
>> > Yes, you are right; race is possible
>> >
>> >
>> > >
>> > > Rather than do these checks and switch chown->lchown, I wonder if we
>> > > are better off having the agent simply change its effective UID/GID
>> > > while it updates the SSH key files ? That way the agent would be
>> > > confined just like the user would be and we don't need to implement
>> > > special cases, nor would we have to think about race conditions.
>> > >
>> > >
>> > So, you propose to call seteuid/setegid before any I/O operation?
>>
>> Yes, specifically for the SSH commands, because they're unusual in
>> that we're doing stuff on behalf of an unprivileged user.
>>
>>
>> With regards,
>> Daniel
>> --
>> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :=
|
>> |: https://libvirt.org          ~~          https://entangle-photo.org :=
|
>> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :=
|
>>
>>

--0000000000006f9fc60658acd591
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>Hi=C2=A0Valentino,</div><div><br></d=
iv><div>Sorry for=C2=A0the long delay.</div>I have a question for you</div>=
<br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=
=3D"gmail_attr">On Tue, Jul 14, 2026 at 7:10=E2=80=AFPM Valentino Paulon &l=
t;<a href=3D"mailto:valentino.paulon88@gmail.com">valentino.paulon88@gmail.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D"auto">&gt; &gt; So, y=
ou propose to call seteuid/setegid before any I/O operation?<br>&gt;<br>&gt=
; Yes, specifically for the SSH commands, because they&#39;re unusual in<br=
>&gt; that we&#39;re doing stuff on behalf of an unprivileged user.<br><br>=
+1 on the euid/egid direction -- as the reporter that&#39;s the outcome I<b=
r>was hoping for. It confines every step (read, mkdir, create, rename,<br>c=
hown) to what the target user could already do himself, which removes<br>th=
e whole TOCTOU class instead of chasing one instance of it.<br><br>A few im=
plementation details that tend to bite with this pattern, in<br>case they s=
ave a round-trip:<br><br>  - drop the supplementary groups too, not just eg=
id: initgroups() (or<br>    setgroups() with the user&#39;s list) while sti=
ll root, otherwise the<br>    agent&#39;s effective access won&#39;t match =
the user&#39;s in either direction<br></div></div></div></div></blockquote>=
<div><br></div><div>Technically, there is no limitation to running QGA in u=
nprivileged mode.</div><div>Normally, <span class=3D"Asgive ng" style=3D"bo=
rder-style:none;background:none">it is</span> a system daemon, but this is =
not mandatory.</div><div>In this case, we can not call=C2=A0initgroups beca=
use the caller must have=C2=A0CAP_SETGID.</div><div>We can call=C2=A0initgr=
oups only when QGA runs as root. What do you think?=C2=A0</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><di=
v dir=3D"ltr"><div><div dir=3D"auto">    -- e.g. group-writable paths under=
 the home.<br>  - keep the real uid at 0 and change euid/egid only, so it s=
tays<br>    reversible; setegid() before seteuid() on the way down, restore=
 in<br>    reverse.<br>  - effective ids are process-wide, so this assumes =
the SSH command is<br>    not doing its I/O from more than one thread concu=
rrently -- worth a<br>    quick check against the agent&#39;s dispatch mode=
l.<br></div></div></div></div></blockquote><div><br></div><div>No issue the=
re. All QGA commands are synchronous.=C2=A0</div><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">=
<div><div dir=3D"auto"><br>The passwd lookup already runs before any of thi=
s, so it can stay<br>outside the dropped region.<br><br>Happy to re-run my =
PoC against the reworked version once it&#39;s ready and<br>confirm the win=
dow is closed.<br><br>Regards,<br>Valentino Paulon<br></div></div></div></d=
iv></blockquote><div><br></div><div><div><br></div><div><div dir=3D"ltr" cl=
ass=3D"gmail_signature"><div dir=3D"ltr"><div>Best Regards,</div><div>Kosti=
antyn Kostiuk.</div></div></div></div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr"><div><div dir=3D=
"auto"></div></div></div><br><div class=3D"gmail_extra"><div>On Tue, Jul 14=
, 2026 02:30 PM, &quot;Daniel P. Berrang=C3=A9&quot; &lt;<a href=3D"mailto:=
berrange@redhat.com" target=3D"_blank">berrange@redhat.com</a>&gt; wrote:<b=
r><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">On Tue, Jul 14, 2026 at=
 02:28:35PM +0300, Kostiantyn Kostiuk wrote:<br>
&gt; On Tue, Jul 14, 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a=
 href=3D"mailto:berrange@redhat.com" target=3D"_blank">berrange@redhat.com<=
/a>&gt;<br>
&gt; wrote:<br>
&gt; <br>
&gt; &gt; On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrot=
e:<br>
&gt; &gt; &gt; Before this commit, when qmp_guest_ssh_add_authorized_keys a=
dds an<br>
&gt; &gt; &gt; SSH key for an existing local user, the agent (running as ro=
ot) decides<br>
&gt; &gt; &gt; whether to create the user&#39;s .ssh directory with a symli=
nk-following<br>
&gt; &gt; &gt; directory test, and then writes and chowns the authorized_ke=
ys file.<br>
&gt; &gt; &gt; A local unprivileged user who owns their home directory can =
pre-stage<br>
&gt; &gt; &gt; their .ssh directory (or the authorized_keys file) as a symb=
olic link<br>
&gt; &gt; &gt; so that, when the host or operator triggers a key add for th=
at user,<br>
&gt; &gt; &gt; the root agent follows the link and transfers ownership of a=
n arbitrary<br>
&gt; &gt; &gt; root-owned file or directory to the unprivileged user, who c=
an then<br>
&gt; &gt; rewrite<br>
&gt; &gt; &gt; it to obtain root<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Fixes: CVE-2026-12080<br>
&gt; &gt; &gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/wor=
k_items/3929" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-=
project/qemu/-/work_items/3929</a><br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Reported-by: Valentino Paulon &lt;<a href=3D"mailto:valentin=
o.paulon88@gmail.com" target=3D"_blank">valentino.paulon88@gmail.com</a>&gt=
;<br>
&gt; &gt; &gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; &gt; &gt; ---<br>
&gt; &gt; &gt;=C2=A0 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++=
++++++++++------<br>
&gt; &gt; &gt;=C2=A0 1 file changed, 45 insertions(+), 8 deletions(-)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-s=
sh.c<br>
&gt; &gt; &gt; index 661972e34e..4e717d8ae8 100644<br>
&gt; &gt; &gt; --- a/qga/commands-posix-ssh.c<br>
&gt; &gt; &gt; +++ b/qga/commands-posix-ssh.c<br>
&gt; &gt; &gt; @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const str=
uct passwd<br>
&gt; &gt; *p,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, err=
no,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of dire=
ctory &#39;%s&#39;&quot;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; &gt; &gt; @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GSt=
rv keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =
=3D=3D -1) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, err=
no,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of dire=
ctory &#39;%s&#39;&quot;,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; &gt; &gt; @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const =
char<br>
&gt; &gt; *username, strList *keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 strList *k;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 size_t nkeys, nauthkeys;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 int fd;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 reset =3D has_reset &amp;&amp; reset;<br=
>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(cons=
t char<br>
&gt; &gt; *username, strList *keys,<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 ssh_path =3D g_build_filename(p-&gt;pw_d=
ir, &quot;.ssh&quot;, NULL);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 authkeys_path =3D g_build_filename(ssh_p=
ath, &quot;authorized_keys&quot;, NULL);<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLO=
W);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(=
errp, errno, &quot;failed to open directory<br>
&gt; &gt; &#39;%s&#39;&quot;, ssh_path);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; IIUC, you&#39;re trying to protect against the possbility that /h=
ome/fred/.ssh<br>
&gt; &gt; is<br>
&gt; &gt; a symlink to some other privileged directory.<br>
&gt; &gt;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (!reset) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys=
(authkeys_path, NULL);<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 if (authkeys =3D=3D NULL) {<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_test(ssh_path, G_FI=
LE_TEST_IS_DIR) &amp;&amp;<br>
&gt; &gt; &gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !mkdir_for_user(s=
sh_path, p, 0700, errp)) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1 &amp;&amp; !mk=
dir_for_user(ssh_path, p, 0700, errp)) {<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 if (fd &gt;=3D 0) {<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; &gt; &gt; +=C2=A0 =C2=A0 }<br>
&gt; &gt;<br>
&gt; &gt; Does holding open an FD on a directory prevent that directory bei=
ng<br>
&gt; &gt; altered ?=C2=A0 Even if it prevents it being deleted, surely ther=
e&#39;s still<br>
&gt; &gt; a race where the dir could be renamed, andd .ssh turned back into=
 a<br>
&gt; &gt; symlink ?<br>
&gt; &gt;<br>
&gt; <br>
&gt; Yes, you are right; race is possible<br>
&gt; <br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Rather than do these checks and switch chown-&gt;lchown, I wonder=
 if we<br>
&gt; &gt; are better off having the agent simply change its effective UID/G=
ID<br>
&gt; &gt; while it updates the SSH key files ? That way the agent would be<=
br>
&gt; &gt; confined just like the user would be and we don&#39;t need to imp=
lement<br>
&gt; &gt; special cases, nor would we have to think about race conditions.<=
br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; So, you propose to call seteuid/setegid before any I/O operation?<br>
<br>
Yes, specifically for the SSH commands, because they&#39;re unusual in<br>
that we&#39;re doing stuff on behalf of an unprivileged user.<br>
<br>
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
</blockquote></div></div></div>
</blockquote></div></div>

--0000000000006f9fc60658acd591--


