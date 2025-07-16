Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222CEC83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 02:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubrnS-0006iu-RM; Tue, 15 Jul 2025 22:23:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubrnH-0006dK-2O
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 22:22:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1ubrnF-0004py-4V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 22:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752632568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h6iY9yaJdsS4c51E+1BoV6SyQUppwxElagwYDlf3/uY=;
 b=OuA64ILJbjNDhetoaa6qeqpbOec4LbzJqiSbpHqpkJWRQY8Ww9RcIJkdUPgVgBpVY/v8Sv
 9u1+8mhE+biq3D1fqaFK7UYofxYBqg0x0hupUcVMyDEMHlNeqONQ6XIWBzMaNFnzRog0XY
 5LBFHh9uNp9bEUrnjuwKUZVrSZKyxJI=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-Nn8VQ2FSOuWGzvkGbSibTA-1; Tue, 15 Jul 2025 22:22:46 -0400
X-MC-Unique: Nn8VQ2FSOuWGzvkGbSibTA-1
X-Mimecast-MFC-AGG-ID: Nn8VQ2FSOuWGzvkGbSibTA_1752632565
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b39280167fdso4802247a12.0
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 19:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752632565; x=1753237365;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h6iY9yaJdsS4c51E+1BoV6SyQUppwxElagwYDlf3/uY=;
 b=hjJfXEd7nw1pNuBtTx/1Q1rNCCUHO7z0myYZhTSVxXKu1l8BqXLtlRcyqPQb0ZvzoO
 QzwPi8nOzEeItP2LwljNTeMAIT8JhvC5nal1e52ueWFVZ1s3PQANLQGGbrY0WA6auVjk
 b6zVQSAKok3GBFJRKkPZnsV9urUq8WQ0EgkmIy1diFZozBrWihYgydVJ5qXF/kfZGxfF
 /VCdJQVfKtz2SkR6FLdhqRCmq5IlRFEWvycmKmRXBPUVzEv0ThjWpQEP2YtARpS2n9PZ
 vNX8ayfwFiNJCdP7aSpNEA5cxVAtsvwf+Ga3mUspCAwa/aD8bOtrh+vpfG0a0XQG+216
 /52Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDUnqDhGelH0iwJTK8QM7pfqIeF0BQ4Hyxbh2+mEtG+blw5NIc7920h+z0/M0jryBfSyiAioKkB+kO@nongnu.org
X-Gm-Message-State: AOJu0YwLphMK4qt52kjl0e62fySohiOwFaij2EmaUmhpWub3qYI17qWA
 YVFBX32XmtnPhvWC1lW7ZA6k9LQ+kc2hpqG+1CivtLLT5CVY0i6PxJ5/BeDDbuSC4tHBT1lT0hv
 K8BNGMronIX1b90l90aE3TSvY0XMQTw+0vcNTdcjggYPe+Iv+SZ7N8YwNJTIJxJZXfAyAfhen0c
 uOYViiY6/ba/do5uQmZsl7gyBFvNl1Ees=
X-Gm-Gg: ASbGncuKcljtatwNreSY9oENdvoNZFQOVmqRdCW8y7O86y58pw5JxGFUZbk0SlX0b2A
 Jj0cGVm9PmQuhh/nVwfv+63H1fRSjcmgzRQC+SNHlzfGy2g3JaXurqxY+bOFzx/jq29nG57ketd
 CEQQsycxbBw6CqCnDoNW4=
X-Received: by 2002:a17:90b:2c8f:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31c9e6fbd7dmr1782268a91.13.1752632565111; 
 Tue, 15 Jul 2025 19:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXG5T9osoT0NCtl+O0X8JuZoqmngRO7wy9RcjXZysXQjSYnjuEPZiuaMskHcacQcSvy+6gRRx/Wd36Ts9c+bc=
X-Received: by 2002:a17:90b:2c8f:b0:311:d258:3473 with SMTP id
 98e67ed59e1d1-31c9e6fbd7dmr1782241a91.13.1752632564639; Tue, 15 Jul 2025
 19:22:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250703105508.2380494-1-vsementsov@yandex-team.ru>
 <d7a66374-12d3-4b4b-975f-90202d83cbdf@yandex-team.ru>
 <CACGkMEv8rvoDS3PHKjBQeA4qi35BVZF0__FP04EwEeM3frPUnw@mail.gmail.com>
 <40114688-ffc6-4f33-9928-a383d69c9320@yandex-team.ru>
 <CACGkMEt8cFEc_sv=TLcCARNjAUsQm6p=Hz_ihBy19yKk9DoZjA@mail.gmail.com>
 <0e1f766d-8fc6-4e69-90ae-28e15fd39d4b@yandex-team.ru>
In-Reply-To: <0e1f766d-8fc6-4e69-90ae-28e15fd39d4b@yandex-team.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Jul 2025 10:22:33 +0800
X-Gm-Features: Ac12FXzTkYw2jc7vaW0F09P5BLnMH4XTd-xAVkvMoP5qrWECMF4rRCCdhOedS6U
Message-ID: <CACGkMEsM8RY7H-Egua6gw0OL5owh5FRv3WsBWG_99EDgz42JYw@mail.gmail.com>
Subject: Re: [PATCH] net/tap: drop too small packets
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 15, 2025 at 10:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 14.07.25 05:12, Jason Wang wrote:
> > On Wed, Jul 9, 2025 at 10:43=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> On 07.07.25 06:49, Jason Wang wrote:
> >>> On Thu, Jul 3, 2025 at 10:59=E2=80=AFPM Daniil Tatianin
> >>> <d-tatianin@yandex-team.ru> wrote:
> >>>>
> >>>> On 7/3/25 1:55 PM, Vladimir Sementsov-Ogievskiy wrote:
> >>>>
> >>>>> Theoretically tap_read_packet() may return size less than
> >>>>> s->host_vnet_hdr_len, and next, we'll work with negative size
> >>>>> (in case of !s->using_vnet_hdr). Let's avoid it.
> >>>>>
> >>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team=
.ru>
> >>>>> ---
> >>>>>     net/tap.c | 5 +++++
> >>>>>     1 file changed, 5 insertions(+)
> >>>>>
> >>>>> diff --git a/net/tap.c b/net/tap.c
> >>>>> index ae1c7e39832..20d0dc2eb35 100644
> >>>>> --- a/net/tap.c
> >>>>> +++ b/net/tap.c
> >>>>> @@ -172,6 +172,11 @@ static void tap_send(void *opaque)
> >>>>>                 break;
> >>>>>             }
> >>>>>
> >>>>> +        if (s->host_vnet_hdr_len && size < s->host_vnet_hdr_len) {
> >>
> >> Should it be better to s/</<=3D/ here? To skip size =3D=3D s->host_vne=
t_hdr_len as well?
> >
> > It would be better.
> >
> > Thanks
>
> Could you apply it in your branch? Or I can resend, if it is more conveni=
ent.

Please resend.

Thanks

>
> >
> >>
> >>>>> +            /* Invalid packet */
> >>>>> +            break;
> >>>>> +        }
> >>>>> +
> >>>>>             if (s->host_vnet_hdr_len && !s->using_vnet_hdr) {
> >>>>>                 buf  +=3D s->host_vnet_hdr_len;
> >>>>>                 size -=3D s->host_vnet_hdr_len;
> >>>>
> >>>> Reviewed-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> >>>
> >>> Queued.
> >>>
> >>> Thanks
> >>>
> >>>>
> >>>>
> >>>
> >>
> >> --
> >> Best regards,
> >> Vladimir
> >>
> >
>
> --
> Best regards,
> Vladimir
>


