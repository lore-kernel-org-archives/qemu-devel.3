Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3074ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfEa-0003BB-T0; Mon, 09 Sep 2024 10:19:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snfEW-0002nz-0s; Mon, 09 Sep 2024 10:19:12 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1snfET-0003eE-Us; Mon, 09 Sep 2024 10:19:11 -0400
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-20551e2f1f8so42726565ad.2; 
 Mon, 09 Sep 2024 07:19:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891548; x=1726496348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S3xLdH77a516X6xS+YFdrm90nSGfRwVn1xXyiCFCOOU=;
 b=PQYzUkbBuGIT7XNBMkO3lUKXMLRXZD/DHfj0BRMtmxINJziNPgsFTTCUNGJWYenpHU
 vx0MGYboZdw4799me2tWBxrLrVQMzK+y+dY4uHLQ90KWa2Mo2EBeEc/gW3B3Prrga3/U
 bhFKIzAj1hp5Ybjj0JcZ0no/+qBN58IdIi+Z6O28byjFSTpq9YD8s6acZe1GJzlASmbW
 79QbfGSW7oPpN0b1QQO3bnMhfnDjWFstSmcOgb1vpEblVW5VQSXDDlLR24924Wzt3/7H
 +zh/h/bFJVdlucFOK0QkCigOjz92vokhf7ZIu1B3kdVT1gfFulAF/qSjlWwxIwfVU0P8
 VDqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtL+Wx9By6Um2a7ZHtV+LifXY8J4Uk+bzHHenQUPY8/mdxAjBmreRLwrk+iaiwZJNj3PPW9AqdT+rDhw==@nongnu.org,
 AJvYcCXKERWA28iF9lPOyxCHgEtGIkIFUB6Pff1ed6JrGV6xsvHmgAd/SORxixNdrt6XAhP/sKSaM/cK27mk@nongnu.org
X-Gm-Message-State: AOJu0YxgglZTkiXDynUz1FuhsYkicSGzK9HnL52IzFTJ+ebqNdOjVjP4
 Dd7UJoUoUyiu4jOJRHhYEMGCDX8kkbJDFHdCjLdhd0vtzbWVTw0d0UBA6g==
X-Google-Smtp-Source: AGHT+IFLjeDHLceItJbgL1PNNw4Ufw4T9c5klq2QWTX9/C9bVDrIixhlXG2zQuapwk/gsMKoEUiv0w==
X-Received: by 2002:a17:902:e74c:b0:207:192f:fb9 with SMTP id
 d9443c01a7336-207192f10c6mr55476225ad.60.1725891547545; 
 Mon, 09 Sep 2024 07:19:07 -0700 (PDT)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com.
 [209.85.215.170]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710e33696sm34461445ad.106.2024.09.09.07.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 07:19:07 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-7da3794b778so389139a12.0; 
 Mon, 09 Sep 2024 07:19:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUJ5xSLzKnuEToSeaKfSxOor4rJZWaCmehcVJ97X25qqLqxAzAUFtIWNOw81ijbToLttDmDIbrBXZ3J@nongnu.org,
 AJvYcCWahPCIomQsElq6TnpLRh/9LP4BtjToQGrFwlNp3pXU0opIrHokmIwnaFGbscBKYqtH9oT1NGOceZR1gw==@nongnu.org
X-Received: by 2002:a17:90a:ce81:b0:2c9:1012:b323 with SMTP id
 98e67ed59e1d1-2dad50cbcf7mr13185160a91.27.1725891547101; Mon, 09 Sep 2024
 07:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20240909015847.40377-1-j@getutm.app>
 <dab54af1-cf9d-401c-a11f-657334b52d5a@daynix.com>
In-Reply-To: <dab54af1-cf9d-401c-a11f-657334b52d5a@daynix.com>
From: Joelle van Dyne <j@getutm.app>
Date: Mon, 9 Sep 2024 07:18:56 -0700
X-Gmail-Original-Message-ID: <CA+E+eSAu1T_juXxyu9VZMmNtbcais3GJX_vomk5MFOLjCCKo3Q@mail.gmail.com>
Message-ID: <CA+E+eSAu1T_juXxyu9VZMmNtbcais3GJX_vomk5MFOLjCCKo3Q@mail.gmail.com>
Subject: Re: [PATCH] block: support locking on change medium
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "open list:Block layer core" <qemu-block@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.214.169; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f169.google.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Sep 9, 2024 at 12:36=E2=80=AFAM Akihiko Odaki <akihiko.odaki@daynix=
.com> wrote:
>
> On 2024/09/09 10:58, Joelle van Dyne wrote:
> > New optional argument for 'blockdev-change-medium' QAPI command to allo=
w
> > the caller to specify if they wish to enable file locking.
> >
> > Signed-off-by: Joelle van Dyne <j@getutm.app>
> > ---
> >   qapi/block.json                | 23 ++++++++++++++++++++++-
> >   block/monitor/block-hmp-cmds.c |  2 +-
> >   block/qapi-sysemu.c            | 22 ++++++++++++++++++++++
> >   ui/cocoa.m                     |  1 +
> >   4 files changed, 46 insertions(+), 2 deletions(-)
> >
> > diff --git a/qapi/block.json b/qapi/block.json
> > index e66666f5c6..35e8e2e191 100644
> > --- a/qapi/block.json
> > +++ b/qapi/block.json
> > @@ -309,6 +309,23 @@
> >   { 'enum': 'BlockdevChangeReadOnlyMode',
> >     'data': ['retain', 'read-only', 'read-write'] }
> >
> > +##
> > +# @BlockdevChangeFileLockingMode:
> > +#
> > +# Specifies the new locking mode of a file image passed to the
> > +# @blockdev-change-medium command.
> > +#
> > +# @auto: Use locking if API is available
> > +#
> > +# @off: Disable file image locking
> > +#
> > +# @on: Enable file image locking
> > +#
> > +# Since: 9.2
> > +##
> > +{ 'enum': 'BlockdevChangeFileLockingMode',
> > +  'data': ['auto', 'off', 'on'] }
>
> You can use OnOffAuto type instead of defining your own.

This can be done. I had thought that defining a new type makes the
argument more explicit about the meaning.

>
> > +
> >   ##
> >   # @blockdev-change-medium:
> >   #
> > @@ -330,6 +347,9 @@
> >   # @read-only-mode: change the read-only mode of the device; defaults
> >   #     to 'retain'
> >   #
> > +# @file-locking-mode: change the locking mode of the file image; defau=
lts
> > +#     to 'auto' (since: 9.2)
> > +#
> >   # @force: if false (the default), an eject request through
> >   #     blockdev-open-tray will be sent to the guest if it has locked
> >   #     the tray (and the tray will not be opened immediately); if true=
,
> > @@ -378,7 +398,8 @@
> >               'filename': 'str',
> >               '*format': 'str',
> >               '*force': 'bool',
> > -            '*read-only-mode': 'BlockdevChangeReadOnlyMode' } }
> > +            '*read-only-mode': 'BlockdevChangeReadOnlyMode',
> > +            '*file-locking-mode': 'BlockdevChangeFileLockingMode' } }
> >
> >   ##
> >   # @DEVICE_TRAY_MOVED:
> > diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-c=
mds.c
> > index bdf2eb50b6..ff64020a80 100644
> > --- a/block/monitor/block-hmp-cmds.c
> > +++ b/block/monitor/block-hmp-cmds.c
> > @@ -1007,5 +1007,5 @@ void hmp_change_medium(Monitor *mon, const char *=
device, const char *target,
> >       }
> >
> >       qmp_blockdev_change_medium(device, NULL, target, arg, true, force=
,
> > -                               !!read_only, read_only_mode, errp);
> > +                               !!read_only, read_only_mode, false, 0, =
errp);
> >   }
> > diff --git a/block/qapi-sysemu.c b/block/qapi-sysemu.c
> > index e4282631d2..8064bdfb3a 100644
> > --- a/block/qapi-sysemu.c
> > +++ b/block/qapi-sysemu.c
> > @@ -311,6 +311,8 @@ void qmp_blockdev_change_medium(const char *device,
> >                                   bool has_force, bool force,
> >                                   bool has_read_only,
> >                                   BlockdevChangeReadOnlyMode read_only,
> > +                                bool has_file_locking_mode,
> > +                                BlockdevChangeFileLockingMode file_loc=
king_mode,
> >                                   Error **errp)
> >   {
> >       BlockBackend *blk;
> > @@ -362,6 +364,26 @@ void qmp_blockdev_change_medium(const char *device=
,
> >           qdict_put_str(options, "driver", format);
> >       }
> >
> > +    if (!has_file_locking_mode) {
> > +        file_locking_mode =3D BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO;
> > +    }
> > +
> > +    switch (file_locking_mode) {
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_AUTO:
> > +        break;
> > +
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_OFF:
> > +        qdict_put_str(options, "file.locking", "off");
> > +        break;
> > +
> > +    case BLOCKDEV_CHANGE_FILE_LOCKING_MODE_ON:
> > +        qdict_put_str(options, "file.locking", "on");
> > +        break;
> > +
> > +    default:
> > +        abort();
> > +    }
> > +
> >       medium_bs =3D bdrv_open(filename, NULL, options, bdrv_flags, errp=
);
> >
> >       if (!medium_bs) {
> > diff --git a/ui/cocoa.m b/ui/cocoa.m
> > index 4c2dd33532..6e73c6e13e 100644
> > --- a/ui/cocoa.m
> > +++ b/ui/cocoa.m
> > @@ -1611,6 +1611,7 @@ - (void)changeDeviceMedia:(id)sender
> >                                          "raw",
> >                                          true, false,
> >                                          false, 0,
> > +                                       false, 0,
>
> This change is irrelevant.

This change is needed otherwise QEMU will not compile.

>
> Regards,
> Akihiko Odaki

