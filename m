Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB56CCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 23:44:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v70I6-0001z0-7A; Thu, 09 Oct 2025 19:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v70I4-0001yW-Rv
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 19:43:20 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v70I1-00035Q-7c
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 19:43:20 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-4242bb22132so14913195ab.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 16:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760053395; x=1760658195; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhOg/aalE5mwEsK0fIwhA11A8T+XjeEVqJce3MQllgg=;
 b=Wqn6iQH6vs2CJ+pJDWZrSXCGQzau45CXzT+m/8HmgSW8QuSMJ2cdHT2gyrjOp3R7vE
 pdwWCnRsyzDe5q1b4bLTL4ZKg+YhigvV6EFb4TUfahaAXW2HLKQHP4mPj1nu/1cFd227
 PgF6AEW2GDcMV+k3GUlfXcnFbQQDyI6tb3dZiioNzRMs8v44jX08zSI2rmSAcu0MDCsN
 nXSd0LKnFXn25VcN6M8UtXDcKncqYzCys6d9Uc6A9THrREkerMuqZ5eSrPYo4GtvfsLf
 Mkcp68ftBtp7i9zJSpQY8vF/aCdGWsmpzp1LHk+J59VctJdmJK2n3W8NoeBgczz+9o55
 O1Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760053395; x=1760658195;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VhOg/aalE5mwEsK0fIwhA11A8T+XjeEVqJce3MQllgg=;
 b=YXhQraG+9nVruC1JUlZcjU/71eF8NvXczvHTMZdSL3UtZT1dw76Kc7JeAxWF6Bjza/
 3+4NGpmzEWjKJMDE0AU9Kg03hbaM/oBOIjBLyRXGA2R73HkEUzuD2gMT1XXShD+L3MPo
 kYgKVa8FcVIDf2PCxsnEu2r50d3/vWe7bskPg5G6nPGInR2Enpj9E8znbfyFfrCY0fmy
 MVfu8+C7aRDcolwMLnkqKp7J0Mmd/dOK0f3jpOoHI4xMs+CuPgxITmDZINOPk2z6hpMr
 GKixVcE7xndq0Eeghww5of6u8nlg0Y5x3AHxNgYd+Hq1acOX8bOjyorOSRH7BPruT6ud
 jhKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9sFLacU/fWVsVoth6owNpt3RBdoMLQbqV2ZCDDO+wiYcUqpfdtegTLuDv6IvYLG2Tewh6tv4MWKkM@nongnu.org
X-Gm-Message-State: AOJu0YztviWqfNzmsiC8QBL9B6a14vYfoOAMCKw0OVRqPYK0i9Zlbbpl
 8cvZ+S5L2Yiw35AHlh4n1bbfcxXig/ZCrFH3zlXvugzqJ7kNUKnRzQgl7eGyO3E6UZg6J7e+9yH
 rqWafXSxD2ut3xGlobbFSP86RtZ52bTI=
X-Gm-Gg: ASbGnctnXolnn2ZmvdCPNHr9B7cgpiDf3TYW9PkmL7dIh+LOaMLAsf6LGItXHdZbo1f
 xyphkQDpSh5htklQTp2umh8iW056/3UfHcOXP79Bwe+/zTIEznHJ/bmaF0qeeFXU4sJ7B0vkLrL
 lFHq1/KChzrOs2xVzL/bk3W/OeOl9a8g45DlE+uqgR0l7KIRisGUVYq+wA+T4TdKJ0C7fuERdTS
 xTJzGc0rexrM9H01nN0l9T5drf229mRLTkVc5g4xA==
X-Google-Smtp-Source: AGHT+IF7cCjbnUWn1oBnFob5BwkY0p8WGoghxnfdDypphB0Y+2ClbSISE7Z1qlTr4BECtpTT4P+EomyuCeNZcFaxA0k=
X-Received: by 2002:a05:6e02:1fe3:b0:42f:95af:9594 with SMTP id
 e9e14a558f8ab-42f95af9700mr33042295ab.23.1760053395237; Thu, 09 Oct 2025
 16:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-32-vsementsov@yandex-team.ru>
 <CAFubqFsL4O=zEbmCEQ9KtBYVOsFjf6tuaur+oU9=1+hRDrPtNw@mail.gmail.com>
 <800c806a-c44c-4c4b-827b-acd9eb4a0e53@yandex-team.ru>
In-Reply-To: <800c806a-c44c-4c4b-827b-acd9eb4a0e53@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 19:43:04 -0400
X-Gm-Features: AS18NWDWKiOYGxFXO4zQaZckrqmSlEQuhlvMYK-VCH6_M0WQcWm1HtF50siV_iY
Message-ID: <CAFubqFv7M4tD14PaWWDg1+K70NLL+jN-Qjxkv=dFAQ9inOULmg@mail.gmail.com>
Subject: Re: [PATCH 31/33] vhost-user-blk: support vhost backend migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 9, 2025 at 5:14=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 09.10.25 22:09, Raphael Norwitz wrote:
> > A small question here but will review more thoroughly pending feedback
> > on my overall comments.
> >
>
> I really hope you didn't spent much time on these 28-31 patches :/
>

I spent much more time on the cleanups :)

> > On Wed, Aug 13, 2025 at 12:53=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
>
> [..]
>
> >> --- a/migration/options.c
> >> +++ b/migration/options.c
> >> @@ -269,6 +269,13 @@ bool migrate_local_char_socket(void)
> >>       return s->capabilities[MIGRATION_CAPABILITY_LOCAL_CHAR_SOCKET];
> >>   }
> >>
> >> +bool migrate_local_vhost_user_blk(void)
> >> +{
> >> +    MigrationState *s =3D migrate_get_current();
> >> +
> >
> > Where was MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK added/defined?
>
> It is generated by QAPI code generator.
>
> Exactly, it's defined by 'local-vhost-user-blk' member inside 'MigrationC=
apability':
>
> { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>
>             ...
>
>             { 'name': 'local-vhost-user-blk', 'features': [ 'unstable' ] =
} ] }
>
>
> and after build, the generated code is in build/qapi/qapi-types-migration=
.h, as a enum:
>
> typedef enum MigrationCapability {
>      MIGRATION_CAPABILITY_XBZRLE,
>
>      ,,,
>
>      MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK,
>      MIGRATION_CAPABILITY__MAX,
> } MigrationCapability;
>
>
> In v2, I'll follow the interface of virtio-net series, look at
>
> https://patchew.org/QEMU/20250923100110.70862-1-vsementsov@yandex-team.ru=
/20250923100110.70862-17-vsementsov@yandex-team.ru/
>
> so, it would be migration parameter instead of capability, like
>
>      QMP migrate-set-parameters {... backend-transfer =3D ["vhost-user-bl=
k"] }
>
> and to enable both vhost-user-blk and virtio-net-tap together:
>
>      QMP migrate-set-parameters {... backend-transfer =3D ["vhost-user-bl=
k", "virtio-net-tap"] }
>

Why do we need two separate migration parameters for vhost-user-blk
and virtio-net-tap? Why not have a single parameter for virtio local
migrations and, if it is set, all backends types which support local
migration can advertise and take advantage of it?

> >
> >
> >> +    return s->capabilities[MIGRATION_CAPABILITY_LOCAL_VHOST_USER_BLK]=
;
> >> +}
> >> +
>
> [..]
>
>
> --
> Best regards,
> Vladimir

