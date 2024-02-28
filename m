Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FAAC54E41
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 07:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfEnW-0006aE-PE; Wed, 28 Feb 2024 02:56:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfEnU-0006Za-QV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:56:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfEnQ-0003r9-9z
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 02:56:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709106966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DgMhDI3M6UU/Uhu9LJSXX0T0MQoB3Ph/lit6XoXns0I=;
 b=EuLqJLe72FCSrCAMSCX1MUbOASx2N/dMFr81mTj/eBTqkCSRm37RYwtE/dCK5LDtKXb1RE
 43kxYAw7DA5NkdNaNKcRn38/90Bs/+1QHyZxpydNPqK0OPz8RpbjNWxA6YQkpI6+5vzZ8/
 BlHdHRol/BVblQUIgtjyvRp+cWYUpLc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-656-x5DyO3UnN_CGBuZXVFpezg-1; Wed, 28 Feb 2024 02:56:05 -0500
X-MC-Unique: x5DyO3UnN_CGBuZXVFpezg-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5642bbddd01so2586066a12.0
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 23:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709106964; x=1709711764;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DgMhDI3M6UU/Uhu9LJSXX0T0MQoB3Ph/lit6XoXns0I=;
 b=omo4YswIkX1P5+9aNUXzh7h/aMpwkLIL9jlYyyVpG6I2QsdhDKm5cAcSGWK0xOgjs/
 TQQK+jmEhBpDmGO4MPYPoSfW7MnxKZmG4LxtnlP7icYhbVvz8xpQ/A+zQimUUp5wGh1u
 esO1vzGkhT4U70o1vNQu0VGJvKPOl6jT9YnXSLoJ882F04OFdoRCxRZ0KbxK1nTmr+Sj
 aiy4C8Cvd86wcgp0KZXG8hTxjUHMSzpAoD5/jKay5vowbonbUvtKmtKmLCB61zquGvTF
 +K2ZrDWowQUOEGzgE7HPDCq4Fez5ykjhxjl05sExvhudHPsPbm35AzYqZrw7lO5MEU84
 pYyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVv1VCS5XgL18v5saZKAZYeZHLlF7bcK4xlBI2k9zyEDTZuta/LEepUwO0+ewORw2mkER//ufj7yXwgju0KZ92FADrqnsU=
X-Gm-Message-State: AOJu0YzhOjbEb2h/tuhxQLw05I+JsKx4a29kg8MM5wiqti7ZnGRrKZEE
 THMOQ0yAdDElsNqb6q7y6kgI2MAc0Mg8RW5blYlZ2FcT5nV6nYYbRntgAwzLslVWF7XEMMyzB+F
 0mDKi1KmFWPwLx3+pKIGIKTSBWSLkGvDV73Xd7pkylbtBaJ/ljoY5Og/6HXput3gRDVfLgg3yR5
 cu8DnWhR1Sj41JoSw5Llq3C3QUxu8=
X-Received: by 2002:a05:6402:1a5c:b0:565:874:8534 with SMTP id
 bf28-20020a0564021a5c00b0056508748534mr8512402edb.29.1709106963832; 
 Tue, 27 Feb 2024 23:56:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4rvn+l1fpEqMMyXBsqLh/tmcXgxX8GukGH79o0idiRwhQIGO5bPv7rRkfnO9nCMI6E2LSjKH5n1DB9On9Mng=
X-Received: by 2002:a05:6402:1a5c:b0:565:874:8534 with SMTP id
 bf28-20020a0564021a5c00b0056508748534mr8512387edb.29.1709106963490; Tue, 27
 Feb 2024 23:56:03 -0800 (PST)
MIME-Version: 1.0
References: <20240226165642.807350-1-andrey.drobyshev@virtuozzo.com>
 <20240226165642.807350-2-andrey.drobyshev@virtuozzo.com>
 <CAPMcbCqf_fh67zRvarH2Y3tD-HPY=+O4nDC=6af+TGuMm1yj_Q@mail.gmail.com>
 <51cd548f-856e-402b-96b4-c8cfe1db30ef@virtuozzo.com>
In-Reply-To: <51cd548f-856e-402b-96b4-c8cfe1db30ef@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 28 Feb 2024 11:55:51 +0400
Message-ID: <CAMxuvaxwAqLyk6qF_=EHw0m-UOEcg6jRjVY-6=LdRdpYF16gvg@mail.gmail.com>
Subject: Re: [PATCH 1/7] qga/commands-posix: return fsinfo values directly as
 reported by statvfs
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org,
 michael.roth@amd.com, den@virtuozzo.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Hi

On Tue, Feb 27, 2024 at 4:38=E2=80=AFPM Andrey Drobyshev
<andrey.drobyshev@virtuozzo.com> wrote:
>
>
>
> On 2/26/24 20:50, Konstantin Kostiuk wrote:
> >
> > Best Regards,
> > Konstantin Kostiuk.
> >
> >
> > On Mon, Feb 26, 2024 at 7:02=E2=80=AFPM Andrey Drobyshev
> > <andrey.drobyshev@virtuozzo.com <mailto:andrey.drobyshev@virtuozzo.com>=
>
> > wrote:
> >
> >     Since the commit 25b5ff1a86 ("qga: add mountpoint usage info to
> >     GuestFilesystemInfo") we have 2 values reported in guest-get-fsinfo=
:
> >     used =3D (f_blocks - f_bfree), total =3D (f_blocks - f_bfree + f_ba=
vail).
> >     These calculations might be obscure for the end user and require on=
e to
> >     actually get into QGA source to understand how they're obtained. Le=
t's
> >     just report the values f_blocks, f_bfree, f_bavail (in bytes) from
> >     statvfs() as they are, letting the user decide how to process them
> >     further.
> >
> >     Originally-by: Yuri Pudgorodskiy <yur@virtuozzo.com
> >     <mailto:yur@virtuozzo.com>>
> >     Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com
> >     <mailto:andrey.drobyshev@virtuozzo.com>>
> >     ---
> >      qga/commands-posix.c | 16 +++++++---------
> >      qga/qapi-schema.json | 11 +++++++----
> >      2 files changed, 14 insertions(+), 13 deletions(-)
> >
> >     diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> >     index 26008db497..752ef509d0 100644
> >     --- a/qga/commands-posix.c
> >     +++ b/qga/commands-posix.c
> >     @@ -1554,8 +1554,7 @@ static GuestFilesystemInfo
> >     *build_guest_fsinfo(strua5a0239ce5ct FsMount *mount,
> >                                                     Error **errp)
> >      {
> >          GuestFilesystemInfo *fs =3D g_malloc0(sizeof(*fs));
> >     -    struct statvfs buf;
> >     -    unsigned long used, nonroot_total, fr_size;
> >     +    struct statvfs st;
> >          char *devpath =3D g_strdup_printf("/sys/dev/block/%u:%u",
> >                                          mount->devmajor, mount->devmin=
or);
> >
> >     @@ -1563,15 +1562,14 @@ static GuestFilesystemInfo
> >     *build_guest_fsinfo(struct FsMount *mount,
> >          fs->type =3D g_strdup(mount->devtype);
> >          build_guest_fsinfo_for_device(devpath, fs, errp);
> >
> >     -    if (statvfs(fs->mountpoint, &buf) =3D=3D 0) {
> >     -        fr_size =3D buf.f_frsize;
> >     -        used =3D buf.f_blocks - buf.f_bfree;
> >     -        nonroot_total =3D used + buf.f_bavail;
> >     -        fs->used_bytes =3D used * fr_size;
> >     -        fs->total_bytes =3D nonroot_total * fr_size;
> >     +    if (statvfs(fs->mountpoint, &st) =3D=3D 0) {
> >     +        fs->total_bytes =3D st.f_blocks * st.f_frsize;
> >     +        fs->free_bytes =3D st.f_bfree * st.f_frsize;
> >     +        fs->avail_bytes =3D st.f_bavail * st.f_frsize;
> >
> >              fs->has_total_bytes =3D true;
> >     -        fs->has_used_bytes =3D true;
> >     +        fs->has_free_bytes =3D true;
> >     +        fs->has_avail_bytes =3D true;
> >          }
> >
> >          g_free(devpath);
> >     diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> >     index b8efe31897..1cce3c1df5 100644
> >     --- a/qga/qapi-schema.json
> >     +++ b/qga/qapi-schema.json
> >     @@ -1030,9 +1030,12 @@
> >      #
> >      # @type: file system type string
> >      #
> >     -# @used-bytes: file system used bytes (since 3.0)
> >     +# @total-bytes: total file system size in bytes (since 8.3)
> >      #
> >     -# @total-bytes: non-root file system total bytes (since 3.0)
> >     +# @free-bytes: amount of free space in file system in bytes (since=
 8.3)
> >
> >
> > I don't agree with this as it breaks backward compatibility. If we want
> > to get
> > these changes we should release a new version with both old and new fie=
lds
> > and mark old as deprecated to get a time for everyone who uses this
> > API updates its solutions.
> >
> > A similar thing was with replacing the 'blacklist' command line.
> > https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca00dd42f317dad8=
affd13e5a20bc42 <https://gitlab.com/qemu-project/qemu/-/commit/582a098e6ca0=
0dd42f317dad8affd13e5a20bc42>
> > Currently, we support both 'blacklist' and 'block-rpcs' command line op=
tions
> > but the first one wrote a warning.
> >
>
> I agree that marking the old values as deprecated does make sense.
> Although my original intent with this patch is to make more sense of the
> existing names (e.g. total-bytes to indicate true fs size instead of
> just non-root fs).  If so, we'd eventually have to replace the original
> total-bytes value with the one having new semantics.  Or we could rename
> the existing value to smth like "total-bytes-nonroot".  But either way
> breaks backward compatibility after all.  How would you suggest to
> resolve it?


Why break backward compatibility? Don't break other systems (win32)
when you propose a patch.

QGA API aims to be cross-platform. Any system should be able to report
some kind of meaningful used and total disk space. I don't see much
reason to change that.

If we need Posix-specific values reported by statvfs(), we can have
extra optional struct/fields.

Fwiw, I find it more obscure to report statvfs values :) Perhaps we
should simply document better where those values are coming from,
instead of reporting more system-specific details.


