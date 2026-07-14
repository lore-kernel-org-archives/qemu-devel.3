Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45A7C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbJm-0000Fn-4b; Tue, 14 Jul 2026 07:28:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wjbJl-0000EN-Cb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1wjbJi-0001r0-6Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:28:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784028529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zq1YlIcwPcezeJeKBCGfa66RI0wbifSTN2mxhiBFAp0=;
 b=Klqj/KvY1EKOaicxQY2YntaHH7ygHgQWzOidrLwuMwSN12+5cVg9yWPps7ZqW0Y1cv2As0
 Lkusnnaxw3mDPlGiPuOIq2QOoQItzRzeiYl7BlYGwqeaSM78V7onyH840IMM3Wj8dePwQX
 IizlWKWLi28GZ+PXRWAvc4fda49G4ds=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-cZEyYkE5OlW6e8C3yLdHsA-1; Tue, 14 Jul 2026 07:28:47 -0400
X-MC-Unique: cZEyYkE5OlW6e8C3yLdHsA-1
X-Mimecast-MFC-AGG-ID: cZEyYkE5OlW6e8C3yLdHsA_1784028527
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso16132216d6.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 04:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784028527; cv=none;
 d=google.com; s=arc-20260327;
 b=gbwuOOI8nbPGTAYlsF6nlzOdeTEMus41Gv5/3aH3mWDdK1Tp1yiqhlbH0dmY+S1riZ
 VOqFQwJTqNF0XmRK1qpx10gMT4yMcWB/Z8c9Grq9EIkRanZVO5VL7plRK0cRlg0nclay
 5xdwKtoWDXfTdvs5IE/tY6HaREWIUDC9/9DHyyt+6WQGaX/LZxDlFNhTUmERKlMvhaNr
 AiyGi7gYgcEgINcCwijYinnTYoMGzFBVEZYx2cQMKqHtnKBunWaWWBXeztHku8znz0F8
 /QayyfGkg8WQ3QCDL3Ajo6z2ioeTUcxxzAHfIo4Az3GMHvaQ2O9u/DxPn3ShuYmmeK0Q
 eERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zq1YlIcwPcezeJeKBCGfa66RI0wbifSTN2mxhiBFAp0=;
 fh=3MpwbqtIM6Ez7383cjVY1jPdbZOAHnCdj+TQBkBKW4U=;
 b=AQDH86EOGI1ZTcS+5/N/JDpw74UXdl4lJjq0Am153vsHWDeRRnYhkrtFhcYIk5k2mb
 SQiSHMI10t40Nv5g361mMXBnOpmSPsZQ5Vnqg7100XPxD2X81L4Oe0mD7nLZ3L4B1KBi
 G2iJ00sB9Rtiq1vWeexdBHAW7vFSpYskgq/X838M8WIVYSQJAnIM1ujuzf/nuUYas9pu
 deFypsEbQdPjuy3av5KLvd05pPLP0B0XoihbjWtVOr/3Yd/HDk5Ufn0X9w9QKcV8uo5H
 dvPmiRDjK5Vqh56tVIqZxSbx+1vd5843wNRemGBMMDobu05bVK6nKOCHLY6RuwcXfJVt
 4zsQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784028527; x=1784633327; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zq1YlIcwPcezeJeKBCGfa66RI0wbifSTN2mxhiBFAp0=;
 b=Oig+YPvRwrW7zX8L5ro5RZJoWYLOgWv5VWnefTn7LP9q7AGJtIQrRSbkm8EtesMWri
 eICVBjnyXIdOLLtbMyGPzb6v1bDWEbD+o3g49tmvYzA3+S9EwbvRqrW/mOh8ktPRbJ3w
 5FXB7XEW8kJUDSxcNDU+CLfx5v6dT1OPebgLjKCUT9ntHc0BExZFUbzXDqi7Tg38oTrr
 46z3gH+i3I1XJWfXnE2k+VZhlMrVd7sEV3BWDTOta0oRLoJm/nNsUKBe56XPB8DCjrDe
 jzMWLA3pY9C1nYDUL+peZtPQ/czD8G0f6aKUnwrj22TRYdlBFy7mA9YStTuzmpQl/HiN
 m8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784028527; x=1784633327;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=zq1YlIcwPcezeJeKBCGfa66RI0wbifSTN2mxhiBFAp0=;
 b=D2s+oCnSMSAaGiVZA10wvWIyiU45xuKx4KHDnxJrwW3qHJS5ewzpTPRWLt7ej2YwsQ
 TzVHquEQKwBqyeaIgYQ7ezPjGyfQ40Ca503C8hUfM8vX8lMGtSG85kEaiM9QqzPVOJzB
 EqCAieUeC9F3d7tUiULF/kQ66p/c3p2/PLeorLSFdQoHQ0zrXtJxKWBRMYjH8NpuBuJs
 AiqPFoW1p9qEcDo+poLyLpVzs3yqk2A/lEDYJy3Bk3Oa9QIC5a+wM6vX1hs6sU2Ki5wG
 EOPRz2zFHhWNsohyUwzFB1Ys9QUTL0GFIyNxNq0sG24xWhkC6pILyqkwXz+aRAqHPIp3
 iRKw==
X-Gm-Message-State: AOJu0Yyqy994n/VJf1SyNLKYHau8TgX/KNgrBU6secamoD3jMefRNC2Z
 BFF7Q9sDvaX4PXo7Ub/W0TpT7pXvtn4Hs9OcrW4JPqHoQf1m8MHr88jdHp0GGMFx3M7wV/QHsQZ
 V0dxQQTGxDSvePF4jQnVUuqsk6qOkEXfLQzuK1r1Poqe4v9pG6Ug4eyTsDwZc1zOpVoXhdX43xu
 z7O+hFtFKZZITLVqvDGG3pjbSxNouG6Q4=
X-Gm-Gg: AfdE7cmc+ybuheP9gdIcQsk2NK3V5a/owgZTkMUtDU/GICuSdhXX9jqNSENaxRU3f+G
 pbw3qvUhYlmMVNOA868NxF7yBJOJgUx8Lb/+lvbokKP7GLwQmAUVj9yrVzOsIoQNC/PxIcaroR8
 ts/FBf5p4cZLm2UbQzStDlutcuSn1F3BV5yWy4+UwRh14LdGvzpIhYnFCPyP4DPwN0iCq3Ag==
X-Received: by 2002:a05:6214:b69:b0:8f3:13e4:739d with SMTP id
 6a1803df08f44-903ff7633e4mr162764206d6.7.1784028526907; 
 Tue, 14 Jul 2026 04:28:46 -0700 (PDT)
X-Received: by 2002:a05:6214:b69:b0:8f3:13e4:739d with SMTP id
 6a1803df08f44-903ff7633e4mr162763946d6.7.1784028526445; Tue, 14 Jul 2026
 04:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260709105707.91209-1-kkostiuk@redhat.com>
 <alYRTj0_B-HA3t_Y@redhat.com>
In-Reply-To: <alYRTj0_B-HA3t_Y@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 14 Jul 2026 14:28:35 +0300
X-Gm-Features: AUfX_myTE4VMxItBqFmL7a37uIbZckkYAmb1RyRrEibt8GWYt110RGn3ty_OoCY
Message-ID: <CAPMcbCpHZPMRMFas8FOjNZtohozc96M7pcdce5Xnpur-ThwJQQ@mail.gmail.com>
Subject: Re: [PATCH] qga: Do not follow symlink in guest-ssh-* commands
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Valentino Paulon <valentino.paulon88@gmail.com>, 
 Yan Vugenfirer <yvugenfi@redhat.com>, Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="000000000000969bd306569082fd"
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=kkostiuk@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

--000000000000969bd306569082fd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Thu, Jul 09, 2026 at 01:57:07PM +0300, Kostiantyn Kostiuk wrote:
> > Before this commit, when qmp_guest_ssh_add_authorized_keys adds an
> > SSH key for an existing local user, the agent (running as root) decides
> > whether to create the user's .ssh directory with a symlink-following
> > directory test, and then writes and chowns the authorized_keys file.
> > A local unprivileged user who owns their home directory can pre-stage
> > their .ssh directory (or the authorized_keys file) as a symbolic link
> > so that, when the host or operator triggers a key add for that user,
> > the root agent follows the link and transfers ownership of an arbitrary
> > root-owned file or directory to the unprivileged user, who can then
> rewrite
> > it to obtain root
> >
> > Fixes: CVE-2026-12080
> > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/3929
> >
> > Reported-by: Valentino Paulon <valentino.paulon88@gmail.com>
> > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > ---
> >  qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++------
> >  1 file changed, 45 insertions(+), 8 deletions(-)
> >
> > diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> > index 661972e34e..4e717d8ae8 100644
> > --- a/qga/commands-posix-ssh.c
> > +++ b/qga/commands-posix-ssh.c
> > @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct passwd
> *p,
> >          return false;
> >      }
> >
> > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> >          error_setg_errno(errp, errno,
> >                           "failed to set ownership of directory '%s'",
> >                           path);
> > @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv keys,
> >          return false;
> >      }
> >
> > -    if (chown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> > +    if (lchown(path, p->pw_uid, p->pw_gid) =3D=3D -1) {
> >          error_setg_errno(errp, errno,
> >                           "failed to set ownership of directory '%s'",
> >                           path);
> > @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char
> *username, strList *keys,
> >      g_auto(GStrv) authkeys =3D NULL;
> >      strList *k;
> >      size_t nkeys, nauthkeys;
> > +    int fd;
> >
> >      reset =3D has_reset && reset;
> >
> > @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char
> *username, strList *keys,
> >      ssh_path =3D g_build_filename(p->pw_dir, ".ssh", NULL);
> >      authkeys_path =3D g_build_filename(ssh_path, "authorized_keys", NU=
LL);
> >
> > +    fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> > +    if (fd =3D=3D -1) {
> > +        if (errno !=3D ENOENT) {
> > +            error_setg_errno(errp, errno, "failed to open directory
> '%s'", ssh_path);
> > +            return;
> > +        }
> > +    }
>
> IIUC, you're trying to protect against the possbility that /home/fred/.ss=
h
> is
> a symlink to some other privileged directory.
>
> >      if (!reset) {
> >          authkeys =3D read_authkeys(authkeys_path, NULL);
> >      }
> >      if (authkeys =3D=3D NULL) {
> > -        if (!g_file_test(ssh_path, G_FILE_TEST_IS_DIR) &&
> > -            !mkdir_for_user(ssh_path, p, 0700, errp)) {
> > +        if (fd =3D=3D -1 && !mkdir_for_user(ssh_path, p, 0700, errp)) =
{
> >              return;
> >          }
> >      }
> > +    if (fd >=3D 0) {
> > +        close(fd);
> > +    }
>
> Does holding open an FD on a directory prevent that directory being
> altered ?  Even if it prevents it being deleted, surely there's still
> a race where the dir could be renamed, andd .ssh turned back into a
> symlink ?
>

Yes, you are right; race is possible


>
> Rather than do these checks and switch chown->lchown, I wonder if we
> are better off having the agent simply change its effective UID/GID
> while it updates the SSH key files ? That way the agent would be
> confined just like the user would be and we don't need to implement
> special cases, nor would we have to think about race conditions.
>
>
So, you propose to call seteuid/setegid before any I/O operation?

Best Regards,
Kostiantyn Kostiuk.



> >
> >      nauthkeys =3D authkeys ? g_strv_length(authkeys) : 0;
> >      authkeys =3D g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(c=
har
> *));
> > @@ -167,11 +178,13 @@ qmp_guest_ssh_remove_authorized_keys(const char
> *username, strList *keys,
> >                                       Error **errp)
> >  {
> >      g_autofree struct passwd *p =3D NULL;
> > +    g_autofree char *ssh_path =3D NULL;
> >      g_autofree char *authkeys_path =3D NULL;
> >      g_autofree GStrv new_keys =3D NULL; /* do not own the strings */
> >      g_auto(GStrv) authkeys =3D NULL;
> >      GStrv a;
> >      size_t nkeys =3D 0;
> > +    int fd;
> >
> >      if (!check_openssh_pub_keys(keys, NULL, errp)) {
> >          return;
> > @@ -182,8 +195,19 @@ qmp_guest_ssh_remove_authorized_keys(const char
> *username, strList *keys,
> >          return;
> >      }
> >
> > -    authkeys_path =3D g_build_filename(p->pw_dir, ".ssh",
> > -                                     "authorized_keys", NULL);
> > +    ssh_path =3D g_build_filename(p->pw_dir, ".ssh", NULL);
> > +    authkeys_path =3D g_build_filename(ssh_path, "authorized_keys", NU=
LL);
> > +
> > +    fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> > +    if (fd =3D=3D -1) {
> > +        if (errno !=3D ENOENT) {
> > +            error_setg_errno(errp, errno, "failed to open directory
> '%s'", ssh_path);
> > +            return;
> > +        }
> > +    } else {
> > +        close(fd);
> > +    }
> > +
> >      if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS)) {
> >          return;
> >      }
> > @@ -215,18 +239,31 @@ GuestAuthorizedKeys *
> >  qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
> >  {
> >      g_autofree struct passwd *p =3D NULL;
> > +    g_autofree char *ssh_path =3D NULL;
> >      g_autofree char *authkeys_path =3D NULL;
> >      g_auto(GStrv) authkeys =3D NULL;
> >      g_autoptr(GuestAuthorizedKeys) ret =3D NULL;
> >      int i;
> > +    int fd;
> >
> >      p =3D get_passwd_entry(username, errp);
> >      if (p =3D=3D NULL) {
> >          return NULL;
> >      }
> >
> > -    authkeys_path =3D g_build_filename(p->pw_dir, ".ssh",
> > -                                     "authorized_keys", NULL);
> > +    ssh_path =3D g_build_filename(p->pw_dir, ".ssh", NULL);
> > +    authkeys_path =3D g_build_filename(ssh_path, "authorized_keys", NU=
LL);
> > +
> > +    fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);
> > +    if (fd =3D=3D -1) {
> > +        if (errno !=3D ENOENT) {
> > +            error_setg_errno(errp, errno, "failed to open directory
> '%s'", ssh_path);
> > +            return NULL;
> > +        }
> > +    } else {
> > +        close(fd);
> > +    }
> > +
> >      authkeys =3D read_authkeys(authkeys_path, errp);
> >      if (authkeys =3D=3D NULL) {
> >          return NULL;
> > --
> > 2.53.0
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

--000000000000969bd306569082fd
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jul 14,=
 2026 at 1:37=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berr=
ange@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">On Thu, Jul 09, 2026 at 01:57:07PM +030=
0, Kostiantyn Kostiuk wrote:<br>
&gt; Before this commit, when qmp_guest_ssh_add_authorized_keys adds an<br>
&gt; SSH key for an existing local user, the agent (running as root) decide=
s<br>
&gt; whether to create the user&#39;s .ssh directory with a symlink-followi=
ng<br>
&gt; directory test, and then writes and chowns the authorized_keys file.<b=
r>
&gt; A local unprivileged user who owns their home directory can pre-stage<=
br>
&gt; their .ssh directory (or the authorized_keys file) as a symbolic link<=
br>
&gt; so that, when the host or operator triggers a key add for that user,<b=
r>
&gt; the root agent follows the link and transfers ownership of an arbitrar=
y<br>
&gt; root-owned file or directory to the unprivileged user, who can then re=
write<br>
&gt; it to obtain root<br>
&gt; <br>
&gt; Fixes: CVE-2026-12080<br>
&gt; Fixes: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_items/39=
29" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/qe=
mu/-/work_items/3929</a><br>
&gt; <br>
&gt; Reported-by: Valentino Paulon &lt;<a href=3D"mailto:valentino.paulon88=
@gmail.com" target=3D"_blank">valentino.paulon88@gmail.com</a>&gt;<br>
&gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkostiuk@redha=
t.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qga/commands-posix-ssh.c | 53 ++++++++++++++++++++++++++++++++++=
------<br>
&gt;=C2=A0 1 file changed, 45 insertions(+), 8 deletions(-)<br>
&gt; <br>
&gt; diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c<br>
&gt; index 661972e34e..4e717d8ae8 100644<br>
&gt; --- a/qga/commands-posix-ssh.c<br>
&gt; +++ b/qga/commands-posix-ssh.c<br>
&gt; @@ -66,7 +66,7 @@ mkdir_for_user(const char *path, const struct passwd=
 *p,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =3D=3D -1) =
{<br>
&gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =3D=3D -1)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of directory &#39;=
%s&#39;&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; @@ -96,7 +96,7 @@ write_authkeys(const char *path, const GStrv keys,<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 if (chown(path, p-&gt;pw_uid, p-&gt;pw_gid) =3D=3D -1) =
{<br>
&gt; +=C2=A0 =C2=A0 if (lchown(path, p-&gt;pw_uid, p-&gt;pw_gid) =3D=3D -1)=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errno,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;failed to set ownership of directory &#39;=
%s&#39;&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0path);<br>
&gt; @@ -123,6 +123,7 @@ qmp_guest_ssh_add_authorized_keys(const char *user=
name, strList *keys,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 strList *k;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size_t nkeys, nauthkeys;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 reset =3D has_reset &amp;&amp; reset;<br>
&gt;=C2=A0 <br>
&gt; @@ -138,15 +139,25 @@ qmp_guest_ssh_add_authorized_keys(const char *us=
ername, strList *keys,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 ssh_path =3D g_build_filename(p-&gt;pw_dir, &quot;=
.ssh&quot;, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 authkeys_path =3D g_build_filename(ssh_path, &quot=
;authorized_keys&quot;, NULL);<br>
&gt;=C2=A0 <br>
&gt; +=C2=A0 =C2=A0 fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);<br>
&gt; +=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errn=
o, &quot;failed to open directory &#39;%s&#39;&quot;, ssh_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
IIUC, you&#39;re trying to protect against the possbility that /home/fred/.=
ssh is<br>
a symlink to some other privileged directory.<br>
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!reset) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys(authkeys_=
path, NULL);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (authkeys =3D=3D NULL) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!g_file_test(ssh_path, G_FILE_TEST_IS=
_DIR) &amp;&amp;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !mkdir_for_user(ssh_path, p=
, 0700, errp)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd =3D=3D -1 &amp;&amp; !mkdir_for_us=
er(ssh_path, p, 0700, errp)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (fd &gt;=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
<br>
Does holding open an FD on a directory prevent that directory being<br>
altered ?=C2=A0 Even if it prevents it being deleted, surely there&#39;s st=
ill<br>
a race where the dir could be renamed, andd .ssh turned back into a<br>
symlink ?<br></blockquote><div><br></div><div>Yes, you are right; race is p=
ossible</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">
<br>
Rather than do these checks and switch chown-&gt;lchown, I wonder if we<br>
are better off having the agent simply change its effective UID/GID<br>
while it updates the SSH key files ? That way the agent would be<br>
confined just like the user would be and we don&#39;t need to implement<br>
special cases, nor would we have to think about race conditions.<br>
<br></blockquote><div><br></div><div>So, you propose <span class=3D"Asgive =
ng" style=3D"border-style:none;background:none">to call=C2=A0seteuid/setegi=
d</span> before any I/O operation?=C2=A0</div><div><div><br clear=3D"all"><=
/div><div><div dir=3D"ltr" class=3D"gmail_signature"><div dir=3D"ltr"><div>=
Best Regards,</div><div>Kostiantyn Kostiuk.</div></div></div></div><br></di=
v><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 nauthkeys =3D authkeys ? g_strv_length(authkeys) :=
 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 authkeys =3D g_realloc_n(authkeys, nauthkeys + nke=
ys + 1, sizeof(char *));<br>
&gt; @@ -167,11 +178,13 @@ qmp_guest_ssh_remove_authorized_keys(const char =
*username, strList *keys,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error =
**errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autofree struct passwd *p =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *ssh_path =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autofree char *authkeys_path =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autofree GStrv new_keys =3D NULL; /* do not own =
the strings */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 GStrv a;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 size_t nkeys =3D 0;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!check_openssh_pub_keys(keys, NULL, errp)) {<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; @@ -182,8 +195,19 @@ qmp_guest_ssh_remove_authorized_keys(const char *=
username, strList *keys,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(p-&gt;pw_dir, &quot;=
.ssh&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;author=
ized_keys&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 ssh_path =3D g_build_filename(p-&gt;pw_dir, &quot;.ssh&=
quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(ssh_path, &quot;auth=
orized_keys&quot;, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);<br>
&gt; +=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errn=
o, &quot;failed to open directory &#39;%s&#39;&quot;, ssh_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (!g_file_test(authkeys_path, G_FILE_TEST_EXISTS=
)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt; @@ -215,18 +239,31 @@ GuestAuthorizedKeys *<br>
&gt;=C2=A0 qmp_guest_ssh_get_authorized_keys(const char *username, Error **=
errp)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autofree struct passwd *p =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 g_autofree char *ssh_path =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autofree char *authkeys_path =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 g_autoptr(GuestAuthorizedKeys) ret =3D NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 int fd;<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 =C2=A0 =C2=A0 p =3D get_passwd_entry(username, errp);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 if (p =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 <br>
&gt; -=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(p-&gt;pw_dir, &quot;=
.ssh&quot;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;author=
ized_keys&quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 ssh_path =3D g_build_filename(p-&gt;pw_dir, &quot;.ssh&=
quot;, NULL);<br>
&gt; +=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(ssh_path, &quot;auth=
orized_keys&quot;, NULL);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 fd =3D open(ssh_path, O_DIRECTORY | O_NOFOLLOW);<br>
&gt; +=C2=A0 =C2=A0 if (fd =3D=3D -1) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (errno !=3D ENOENT) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_errno(errp, errn=
o, &quot;failed to open directory &#39;%s&#39;&quot;, ssh_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 close(fd);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys(authkeys_path, errp);<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 if (authkeys =3D=3D NULL) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
&gt; -- <br>
&gt; 2.53.0<br>
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
</blockquote></div></div>

--000000000000969bd306569082fd--


