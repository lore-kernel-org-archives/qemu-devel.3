Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56B0D2CDFE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 01:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRKhF-0001na-3m; Thu, 04 Dec 2025 20:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRKhD-0001nM-G0
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:33:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vRKhB-0001qL-Ta
 for qemu-devel@nongnu.org; Thu, 04 Dec 2025 20:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764898396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SUefn6wM245tAd5RN7ZZlFE53EQV8jPvnM5kYhqgUhw=;
 b=i65GXx1MmbMT8DiI8fLH5W/eX1ihS/QdBPalTz2/vEmoBV+TZRNb+ZDf1Koyo9fSxSpwby
 j+L77hwfZpSMWOIg02qBxREMYjBQw6rHagOnw4shKPw0p6TU6bgjnJ+HNo6Q2ea3V2S0Nh
 YKmuJ66IgIGtFIzezDgTCFHAXz+z7bY=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-JMIYcnpMOy6hXDP05zXkVw-1; Thu, 04 Dec 2025 20:33:15 -0500
X-MC-Unique: JMIYcnpMOy6hXDP05zXkVw-1
X-Mimecast-MFC-AGG-ID: JMIYcnpMOy6hXDP05zXkVw_1764898394
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-5dfb4950a48so2567807137.0
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 17:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764898394; x=1765503194; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUefn6wM245tAd5RN7ZZlFE53EQV8jPvnM5kYhqgUhw=;
 b=pwmkj6ypqnhk4OjJ1gdwyrjTypQ74J31I6V5IVBuxzWtlfl1kEd4K1zrRaGYzTy77U
 jy4JGwF7d5U4qJVtUSotwj8YTEbjWGu7Rir0Bo7M66axHO+EwkXkqVa+y+/U+KDm2ZTn
 UwZkRlTfRAxjhz9SC5X8M4/lDcr0kOO5R8d9GynP1C3+zG9bqFzTnGtS7iZtiHjK50h2
 CamHsrzoeX6x117We9kFAnfXYG0r7uCXSs8LT2j4nEzQw7mtrpugP3ozI3o9GoIlqTS8
 C7jWl7Z2r9s/cK5JEQQbm5a6dEVLW5GAISWgLrqw6FK0ilnf1mks7s1ll5yvxuBaPoNY
 NJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764898394; x=1765503194;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SUefn6wM245tAd5RN7ZZlFE53EQV8jPvnM5kYhqgUhw=;
 b=N/lQJU7/HI6hqZ2aBRQRLDn5GRBayRc8p6D8ipdumkz2zabzqhZVHCP/U+9G522MGM
 ea53ehPHejOJgpezkyQ6zyhCtS6Tftz8eRJzsFNY0qI2rwI7olF8ttYWJnsKVYzcKCKF
 H/2zba/nR+J/opS/F5G9NkoLfLSrjB5Qjk7vr6KT9NoYo/G533IvhubiFfWgMF98/XNS
 yfMnvLoWDu+kRhhV9v5/Iq2PVLzUFNzPKdagiJR9OAMXHf0rYQsevyn+KgTq5sd4VOiQ
 dYpErkf/t27g7eUcJI2VwBtYA5iYjaxb4ptAtn/uIWIxndoX+MY3cBR1QHyB/mUlhBk+
 8uUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDpeEpYwXUeEC+suXD5bbT3bh0By+V4Ib8oQIbjZJX110IL9abWtbcW13u7Yd0100AuPZfX5nj9Xce@nongnu.org
X-Gm-Message-State: AOJu0Ywce0afbnfUp6QuBqjzQUWX2skPjObRD5rNMWNrpHH+/piQZZK/
 7pUcKDCubVQ+neuTUsnHNvaBZomC9BXwdY4w27QMEWf8jDn4rTznQfCCR160+oyGtnwYEhK4j7z
 bK6mDe4fc9Np+teXpqdUGdG4IAMmt9t3qNDPkR9yfcjC5NO6bzUnP8UqORYgss9y3b55objJ7t1
 bXjDg6hVRG9bHRwgQlHsEP8xDHe/kKuVM=
X-Gm-Gg: ASbGncsI5LMO/xcfVQM8T7IX5O0lifiWj6v4ZjyzLiAJX7KDR1CLIvdoXY7K00USnmA
 rVXp9sDPr5zuE1yExGvWWqVbY95nbF2NAEzGQLMU/rin36UZEqHcpFtc2sK9Ywk7fHLPn153REd
 3pVwSe3PN3XX4wkVnZXcnylCqHlEXI5N8DeUzZQvQz/eD3HxNco4bOBUBYz8PH/l/okw==
X-Received: by 2002:a05:6102:3ed0:b0:5df:c4ec:660e with SMTP id
 ada2fe7eead31-5e48e222728mr3247668137.9.1764898394546; 
 Thu, 04 Dec 2025 17:33:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGBxnQdnKRpi0wqiaEVLFemAF0DMbpxW6BjAeWIt5E3VUDa/BR5xtMnJMs53L1XWmFLeXf5rqp0X3OsaMoQkS4=
X-Received: by 2002:a05:6102:3ed0:b0:5df:c4ec:660e with SMTP id
 ada2fe7eead31-5e48e222728mr3247661137.9.1764898394201; Thu, 04 Dec 2025
 17:33:14 -0800 (PST)
MIME-Version: 1.0
References: <20251204073750.8953-1-wafer@jaguarmicro.com>
 <CACGkMEtsPO+aAk2cMCE75_RjWFGedHdfMr0NmX5hR7MQophJfg@mail.gmail.com>
 <PUZPR06MB471395120934B469F9315B12A2A7A@PUZPR06MB4713.apcprd06.prod.outlook.com>
In-Reply-To: <PUZPR06MB471395120934B469F9315B12A2A7A@PUZPR06MB4713.apcprd06.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 5 Dec 2025 09:33:02 +0800
X-Gm-Features: AQt7F2ofFjlwsLLL2BDz3RV-TTjnKSfz9tTLjemES-N_37qE0_3M-imLHtv4qdc
Message-ID: <CACGkMEvchy+JeF29VuoHHuK2XVfKdXT1_Z-HP6TS7fr8DkSusw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add Split indirect descriptors for SVQ
To: Wafer <wafer@jaguarmicro.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "eperezma@redhat.com" <eperezma@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "leiyang@redhat.com" <leiyang@redhat.com>, 
 "sgarzare@redhat.com" <sgarzare@redhat.com>,
 Angus Chen <angus.chen@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Dec 5, 2025 at 9:30=E2=80=AFAM Wafer <wafer@jaguarmicro.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: 2025=E5=B9=B412=E6=9C=884=E6=97=A5 15:56
> > To: Wafer <wafer@jaguarmicro.com>
> > Cc: mst@redhat.com; eperezma@redhat.com; qemu-devel@nongnu.org;
> > leiyang@redhat.com; sgarzare@redhat.com; Angus Chen
> > <angus.chen@jaguarmicro.com>
> > Subject: Re: [PATCH 0/4] Add Split indirect descriptors for SVQ
> >
> > External Mail: This email originated from OUTSIDE of the organization!
> > Do not click links, open attachments or provide ANY information unless =
you
> > recognize the sender and know the content is safe.
> >
> >
> > On Thu, Dec 4, 2025 at 3:38=E2=80=AFPM Wafer Xie <wafer@jaguarmicro.com=
> wrote:
> > >
> > > This patch series adds support for VIRTIO split indirect descriptors.
> > > The feature is VIRTIO_RING_F_INDIRECT_DESC.
> > >
> > > Eugenio hs submitted a patch: vhost: accept indirect descriptors in
> > > shadow virtqueue
> > > https://lists.nongnu.org/archive/html/qemu-devel/2025-
> > 12/msg00056.html
> > > Therefore, this patch must be applied first.
> >
> > I may miss something but svq can read indirect descriptors even though =
it
> > doesn't use indirect descriptor, that's sufficient for making it claims=
 to
> > support indirect descriptors. That's what Eugenio said in that series.
> >
> > This series could be an optimization on top?
> >
> > Thanks
> >
>
> Thanks for your reply!
> Right, the current svq implementation can read the indirect descriptors p=
rovided by the driver, but it cannot use indirect descriptors when interact=
ing with the backend device.
> However, if a backend device implements indirect descriptors and wants to=
 use QEMU to validate its indirect descriptor support, then QEMU needs to f=
ully support indirect descriptors in this path. This series is intended to =
provide that full support, so that such backend devices can be properly tes=
ted and validated via QEMU.

Great, let's tweak the changelog for the next version like this.

Thanks

>
> > >
> > >
> > > Wafer Xie (4):
> > >   vhost: add data structure of virtio indirect descriptors in SVQ
> > >   vdpa: implement the interfaces alloc/free for indirect desc
> > >   vhost: supported the virtio indirect desc of available ring
> > >   vhost: supported the viriot indriect desc of used ring
> > >
> > >  hw/virtio/vhost-shadow-virtqueue.c | 224
> > > +++++++++++++++++++++++++++--  hw/virtio/vhost-shadow-virtqueue.h
> > |  57 +++++++-
> > >  hw/virtio/vhost-vdpa.c             | 130 ++++++++++++++++-
> > >  3 files changed, 395 insertions(+), 16 deletions(-)
> > >
> > > --
> > > 2.34.1
> > >
>


