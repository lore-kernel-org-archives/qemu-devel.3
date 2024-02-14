Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63F3C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 19:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raKfr-0001Zv-5a; Wed, 14 Feb 2024 14:12:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raKfq-0001Zf-3I
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 14:12:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1raKfl-0008S3-8a
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 14:12:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707937912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6NvQWwlmecDLIwRtre2HVnswWswxvKGn4a8J4E3i3MI=;
 b=HERWH60krYKQ8XtZW7izKddHjKFJzTomR+Q/Bd0RXdphi160PY3Ef8h0dujW6h9lwv0O4j
 Pm5dKzLLJT+y6dMSAq2KMG0HFq8avkEP1jqKkKf6pX6DSOP1WdlPsz+XF+NS9802FW/zYP
 MdFX3+yKyib92HPhDSrrXs7ExBW9OAE=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-8w3KwRK-OkiHniRmdYA4Rw-1; Wed, 14 Feb 2024 14:11:51 -0500
X-MC-Unique: 8w3KwRK-OkiHniRmdYA4Rw-1
Received: by mail-yb1-f199.google.com with SMTP id
 3f1490d57ef6-dc647f65573so10797467276.2
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 11:11:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707937910; x=1708542710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6NvQWwlmecDLIwRtre2HVnswWswxvKGn4a8J4E3i3MI=;
 b=OiVZ0kyJLBojW1qY+5UV8IHtsaM96AyG8niZcnVeJSgLjSj7PVbZyqYZUd6FQKzBV2
 ouw+aAjbqv26wTuh6WdcKR8g8W2dS8ho+d/ILBdnhxboFbeRrbQF6qI759zm6HlvscUa
 JhNYVwgfP5nAKT0wXUWRCcDy/TuK4qxLrJTpGgEax74XxYQSrMsIMm8pm7AIcEo1xJ7r
 FTYQgvx/X50H4tsPVUJssSusyq1/AR+J+8Yw9b9XD8Gm4KbHmEyRfT/tcGIbKopEdV46
 1yczO+jWY6d/iAhDolbyNdJDFtjuIruWzKEFrMcisbXrrw+OJg6AAFfqB0PZfM++ogKT
 zZQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwBZJ+vd8qaqgNzLbucuTjCkLzVxLV8uFOkgcxgbYZVXa81P1UdU+7qwJ43NkBbjrpfmEH6QkYWipMnI699gvLBqeJjRA=
X-Gm-Message-State: AOJu0Yzee2NeNWcAdl5oz7CKUeHxcVQ/1bz1H3nhHcbThsdGkH6MsjVO
 6lz5vDGfLgzJwu3I7H+HHh/LJziMQram55OPrDtby1s19bAV3RMx7yWv9g6gdQDrMnmGiKTYl9A
 6Olf6RsTXcqcEsCIuDXCBWfk2RIlIyVSP5eWKW2MFZwWOt6KsHGZNtThgnmR0dXjdkI6WLZJlIr
 qHyoxAwwtcvKrLf64nErbR4UtXHUk=
X-Received: by 2002:a25:bad1:0:b0:dcc:8e7f:dcba with SMTP id
 a17-20020a25bad1000000b00dcc8e7fdcbamr3240494ybk.48.1707937910600; 
 Wed, 14 Feb 2024 11:11:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGluKz6a+/EzeiICDOsWyPiYLBvskDgD/CZB2oux4OQyzLjUDwPo56mD9zuvSHg/RkDlptULYSjQErQhBNjguI=
X-Received: by 2002:a25:bad1:0:b0:dcc:8e7f:dcba with SMTP id
 a17-20020a25bad1000000b00dcc8e7fdcbamr3240478ybk.48.1707937910321; Wed, 14
 Feb 2024 11:11:50 -0800 (PST)
MIME-Version: 1.0
References: <20240201180924.487579-1-eperezma@redhat.com>
 <20240201180924.487579-7-eperezma@redhat.com>
 <9a919f49-cf88-4c72-92ff-f0c18a5593f1@oracle.com>
 <20240213052102-mutt-send-email-mst@kernel.org>
 <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
In-Reply-To: <c45af489-0f0a-4fc7-ad03-4a513f8b338d@oracle.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 14 Feb 2024 20:11:14 +0100
Message-ID: <CAJaqyWdDRqMEwVh6ZcVdnEZoXy-_9B2qk25eYcoVmeeTxgGm8g@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] vdpa: move iova_tree allocation to
 net_vhost_vdpa_init
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>, 
 Parav Pandit <parav@mellanox.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 14, 2024 at 7:29=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
> Hi Michael,
>
> On 2/13/2024 2:22 AM, Michael S. Tsirkin wrote:
> > On Mon, Feb 05, 2024 at 05:10:36PM -0800, Si-Wei Liu wrote:
> >> Hi Eugenio,
> >>
> >> I thought this new code looks good to me and the original issue I saw =
with
> >> x-svq=3Don should be gone. However, after rebase my tree on top of thi=
s,
> >> there's a new failure I found around setting up guest mappings at earl=
y
> >> boot, please see attached the specific QEMU config and corresponding e=
vent
> >> traces. Haven't checked into the detail yet, thinking you would need t=
o be
> >> aware of ahead.
> >>
> >> Regards,
> >> -Siwei
> > Eugenio were you able to reproduce? Siwei did you have time to
> > look into this?
> Didn't get a chance to look into the detail yet in the past week, but
> thought it may have something to do with the (internals of) iova tree
> range allocation and the lookup routine. It started to fall apart at the
> first vhost_vdpa_dma_unmap call showing up in the trace events, where it
> should've gotten IOVA=3D0x2000001000,  but an incorrect IOVA address
> 0x1000 was ended up returning from the iova tree lookup routine.
>
> HVA                    GPA                IOVA
> -------------------------------------------------------------------------=
------------------------------------------------
> Map
> [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 0x80000000=
)
> [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000)
> [0x80001000, 0x2000001000)
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000)
> [0x2000001000, 0x2000021000)
>
> Unmap
> [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) [0x1000,
> 0x20000) ???
>                                      shouldn't it be [0x2000001000,
> 0x2000021000) ???
>

Yes, I'm still not able to reproduce. In particular, I don't know how
how the memory listener adds a region and then release a region with a
different size. I'm talking about these log entries:

1706854838.154394:vhost_vdpa_listener_region_add vdpa: 0x556d45c75140
iova 0x0 llend 0x80000000 vaddr: 0x7f7903e00000 read-only: 0
452:vhost_vdpa_listener_region_del vdpa: 0x556d45c75140 iova 0x0 llend
0x7fffffff

Is it possible for you to also trace the skipped regions? We should
add a debug trace there too...

Thanks!

> PS, I will be taking off from today and for the next two weeks. Will try
> to help out looking more closely after I get back.
>
> -Siwei
> >   Can't merge patches which are known to break things ...
>


