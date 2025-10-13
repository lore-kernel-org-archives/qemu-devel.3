Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCACCCD183
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 21:51:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8QRT-0008Dd-8u; Mon, 13 Oct 2025 17:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8QRS-0008DJ-1F
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:50:54 -0400
Received: from mail-il1-x130.google.com ([2607:f8b0:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8QRQ-0002m0-2x
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 17:50:53 -0400
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-4259247208aso33584825ab.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 14:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760392250; x=1760997050; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1SaNmvCnu8Bb+xhQFI7bSoz0hEHs5gE9VVDtjJJWBgI=;
 b=XMPrlUuvr3/SbXCNewMwZEsaOTCQR77RUJwfNyJWQViFUvI+Zm9oThG91ie3k49oyj
 FQfZ0K/5PxdWRjBB28BMDpRL2rrMAjMEWLy13kWys1cFdQeEQParkncABxb7xp9VWt36
 ywCJmJLmb6P46B6MS/SI3MhIhpqTVK6huGrqvdv3kYfn/dkpnci41oWbOIhSjoey1Uvy
 2dpqkVf5c6vQq9mRqEUxwq2+Bky6ebJu9ySxEAEeSRECXwEsds6LZofY/zfRugHhk557
 +69Xbjq0qt+xDRKI1+dNyz7L8RN3IcCVVCNv5hPQIupUsdW89WWtxCTJ3MGH8QIdYfyp
 WM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760392250; x=1760997050;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SaNmvCnu8Bb+xhQFI7bSoz0hEHs5gE9VVDtjJJWBgI=;
 b=Yd7s3fAVzudyYI5TKPtKxu6zjr64OUQniKSoKGb7ND9ogqw6vOgA9zRp4mrQbetD7D
 5upIH3Efp1ryO+i/YAuH0OEhvw4342e7dXNwm2pkKEvJHC3IkvH1/V0tpb3WIshKSjHF
 vFMTPuqo5aYwpPPi117vBapK2g1uYJDPnxohiO7z0wwx5JTUnYU8oG92tpZDBIKP1lRV
 o4GXv7/XkIHHwLZI9/UT/er/psh5p855KHMfwF4I/Ri8uYj+M2YL2vKj/njh7C0LPLpS
 A+SrAtiQ+VP1OgcfypRGq5SoG6mViXPrcfCZYGRPxhp9w/BPKmFcwHaAlYn3frx5Hc2B
 vm5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3WfxeJkDSjN14AwL6U7kkz5srjPqmVf/9HfYhhqjACWcZfy+bTuM7Hp/gi9+YUorSGxxW8LvwdUMD@nongnu.org
X-Gm-Message-State: AOJu0YzUoTGn46YFCHE1FcBaZsnIKwS+OuNBnRc6J6f5AwbclgYM90YB
 XJu2sGx6Vh9Gpnhyu+O+R5isvMAu2pyJRMDUvGw7UTGQ3EBxrZOyNKnY8oiC/ZcW1oUTPjRg7+T
 91zF9r+nslCDWPW6Uc8MG4HV3moCipoI=
X-Gm-Gg: ASbGncufs0uukzjtR0QQz4QhCJ6AwW/DffI+Wd++DP2EZz2Gx0wvC5dG9R1bJZ0JDMI
 wYUuqM64NEnPdKocMOwhoqncBUQIr6ivEzKLFVAkBIteqExPzZZi4/b/hUwW3zMtIIE/cZystZl
 Q9yzZpl9Ey1hm/7xlss9jGvPHzqP5aXWjl1a7SHsSKaOrzCQfmTk7eMBCLjyh5bcFCbqnohSnHo
 jydQgS53YSnLLcH3/2zpS6Vml0EHKO3L1Ba
X-Google-Smtp-Source: AGHT+IHvK7lwP+aZ75N5F+O9QheIwJdBXSL+0eTbJqdwtaTOZkfyJY7UsroTc9G+wkJY11UX4HY0uBy/R1r3s4vR1IM=
X-Received: by 2002:a05:6e02:1a09:b0:42f:9501:69e with SMTP id
 e9e14a558f8ab-42f95010904mr176189795ab.20.1760392250511; Mon, 13 Oct 2025
 14:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-32-vsementsov@yandex-team.ru>
 <CAFubqFsL4O=zEbmCEQ9KtBYVOsFjf6tuaur+oU9=1+hRDrPtNw@mail.gmail.com>
 <800c806a-c44c-4c4b-827b-acd9eb4a0e53@yandex-team.ru>
 <CAFubqFv7M4tD14PaWWDg1+K70NLL+jN-Qjxkv=dFAQ9inOULmg@mail.gmail.com>
 <335e1969-f1ab-45b1-8d38-221f09cea8bf@yandex-team.ru>
In-Reply-To: <335e1969-f1ab-45b1-8d38-221f09cea8bf@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 17:50:39 -0400
X-Gm-Features: AS18NWCWF4rIowGOi2IWopHVZdLQ_jHSZ5PJQIQ_J0NUVgVGQ-PrmbNwrUKmF5w
Message-ID: <CAFubqFuMkmr-p3N1hkD0gc2A8=yBx2_KqZb_9JUA0jBqt4Az_Q@mail.gmail.com>
Subject: Re: [PATCH 31/33] vhost-user-blk: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::130;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Oct 10, 2025 at 2:27=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 10.10.25 02:43, Raphael Norwitz wrote:
> > On Thu, Oct 9, 2025 at 5:14=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> On 09.10.25 22:09, Raphael Norwitz wrote:
> >>> A small question here but will review more thoroughly pending feedbac=
k
> >>> on my overall comments.
> >>>
> >>
> >> I really hope you didn't spent much time on these 28-31 patches :/
> >>
> >
> > I spent much more time on the cleanups :)
> >
> >>> On Wed, Aug 13, 2025 at 12:53=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> >>> <vsementsov@yandex-team.ru> wrote:
> >>>>
> >>
> >> [..]
> >>
> >>>> --- a/migration/options.c
> >>>> +++ b/migration/options.c
> >>>> @@ -269,6 +269,13 @@ bool migrate_local_char_socket(void)
> >>>>        return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET=
];
> >>>>    }
> >>>>
> >>>> +bool migrate_local_vhost_user_blk(void)
> >>>> +{
> >>>> +    MigrationState *s =3D migrate_get_current();
> >>>> +
> >>>
> >>> Where was MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK added/defined?
> >>
> >> It is generated by QAPI code generator.
> >>
> >> Exactly, it's defined by 'local-vhost-user-blk' member inside 'Migrati=
onCapability':
> >>
> >> { 'enum': 'MigrationCapability',
> >>     'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
> >>
> >>              ...
> >>
> >>              { 'name': 'local-vhost-user-blk', 'features': [ 'unstable=
' ] } ] }
> >>
> >>
> >> and after build, the generated code is in build/qapi/qapi-types-migrat=
ion.h, as a enum:
> >>
> >> typedef enum MigrationCapability {
> >>       MIGRATION_CAPABILITY_XBZRLE,
> >>
> >>       ,,,
> >>
> >>       MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK,
> >>       MIGRATION_CAPABILITY__MAX,
> >> } MigrationCapability;
> >>
> >>
> >> In v2, I'll follow the interface of virtio-net series, look at
> >>
> >> https://patchew.org/QEMU/20250923100110.70862-1-vsementsov@yandex-team=
.ru/20250923100110.70862-17-vsementsov@yandex-team.ru/
> >>
> >> so, it would be migration parameter instead of capability, like
> >>
> >>       QMP migrate-set-parameters {... backend-transfer =3D ["vhost-use=
r-blk"] }
> >>
> >> and to enable both vhost-user-blk and virtio-net-tap together:
> >>
> >>       QMP migrate-set-parameters {... backend-transfer =3D ["vhost-use=
r-blk", "virtio-net-tap"] }
> >>
> >
> > Why do we need two separate migration parameters for vhost-user-blk
> > and virtio-net-tap? Why not have a single parameter for virtio local
> > migrations and, if it is set, all backends types which support local
> > migration can advertise and take advantage of it?
>
> As I describe in the commit message https://patchew.org/QEMU/202509231001=
10.70862-1-vsementsov@yandex-team.ru/20250923100110.70862-17-vsementsov@yan=
dex-team.ru/ :
>
>
> Why not simple boolean? To simplify migration to further versions,
> when more devices will support backend-transfer migration.
>
> Alternatively, we may add per-device option to disable backend-transfer
> migration, but still:
>
> 1. It's more comfortable to set same capabilities/parameters on both
> source and target QEMU, than care about each device.
>
> 2. To not break the design, that machine-type + device options +
> migration capabilities and parameters are fully define the resulting
> migration stream. We'll break this if add in future more
> backend-transfer support in devices under same backend-transfer=3Dtrue
> parameter.

ACK on needing a separate migration parameter. Thanks for the references.

I would suggest having the incoming_backend field in the struct
vhost_user (or maybe even in struct vhost_dev if the tap device
migration is similar enough) rather than in struct VHostUserBlk, so
that device-specific code can be kept as similar as possible.

>
>
> >
> >>>
> >>>
> >>>> +    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BL=
K];
> >>>> +}
> >>>> +
> >>
> >> [..]
> >>
> >>
> >> --
> >> Best regards,
> >> Vladimir
>
>
> --
> Best regards,
> Vladimir

