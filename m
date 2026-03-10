Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DE5FCC9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 03:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vznTn-0006xA-U3; Mon, 09 Mar 2026 23:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznTl-0006vE-1d
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:09:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznTj-0008Jq-G4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:09:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773112190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=96cpjxMhVI1uJGBrabIXVqr665B5wCj7hpYdD9l29nk=;
 b=XWRnF6YWlN2ZDCvjYEQffrXfwPFkLQCapbul1GpYprqdEhrYjwaJST/AhVZSUskmxaoEQw
 v84fQJgAYDHt/DE68S5/8Nw6gbFGFy9gOWLw3mRQ3c3wU1sWilv1p1DouD8p9ItWhZHmkN
 JfZ4zIEzOVjrXzl9mddX3vPOa+FkQ0s=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-xF93g377NCCq7pOi3C-97w-1; Mon, 09 Mar 2026 23:09:49 -0400
X-MC-Unique: xF93g377NCCq7pOi3C-97w-1
X-Mimecast-MFC-AGG-ID: xF93g377NCCq7pOi3C-97w_1773112188
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c737ced4036so3384335a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 20:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773112188; cv=none;
 d=google.com; s=arc-20240605;
 b=YsD+Be2Kfb5b7cFcF3T8DMQ6i5lZDMA1/bG4uB2zOdS3ZUcc+J5Wu9RcLvqa2RB3nj
 FDOnxzY9ou/HvLkUe/sHZG3Dry3R0vyuoqbVbKFkmOnGqdZc3iZdrU0Fi3RgxDSHBHQj
 seMMJvvr9YiGdwjckj2V+nsff/sNKR42EHvddTx0BbKlVexig6nEgeAKKsKhuX87k/70
 Cd+j9vD8qHdxqquGacizmZcX6QZcTl/Uk6ItzZ9icppYbXtOD6UMDk89XBIiLWhhzvK5
 qZ3Pcal7U7oXcY4x0G2ub74SwSw1065B7OPpdu2myigvaObgIyG+MFO91eEpQ1xKg8+v
 zHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=96cpjxMhVI1uJGBrabIXVqr665B5wCj7hpYdD9l29nk=;
 fh=CCzwMatiZjClffqXfYCT0E4TCmw+jdyoA/vgnnKOdRs=;
 b=D1CETyIfDlPWT6gG9BxkDmttpvfsmKcVILht2/1OzcUhIJyvz5rijrdTY6ntRbg346
 F4n2fYK3ih1rGskh3E9C17s1ePlin084xmpKJULkogLl1prL8TZ9IiFE9GDYq+c5e90C
 6elSy1nN52G5l4ne3J8LQkeLXtJBvJ4i3M0ZL6MnYfxXkMgWEfoVvLcOVuKosqfSLoGp
 874RYCvCjZA25ggRbMj89fo7+ZSD6w9mkMcMKUHpSoFXVJp4yk3Ykv2MEO6q1yHeIvAZ
 tQIqf9ExrsTotrEQk6F9+Kegx+lea7mikTzpYulRdlVIQdNtCAVFX6YRV1LroKdz7FCF
 RnoA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773112188; x=1773716988; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=96cpjxMhVI1uJGBrabIXVqr665B5wCj7hpYdD9l29nk=;
 b=Havy5/9+/6N16I5XF4V0pFUqdD4KwwFVjOVsOkRwX+Wd5XRqdhA1N7euMEIg0htgW8
 lEHT01dEWd1QahkfxROZDxTz7sf7SjSch3dFgNbMFLUH2IJF1w2WlSwc6bGU+wlfUOrd
 6JfAy/VLkqgT92quvV2nyKmtYqRqrtQvqL+A/XbYAoMOLWHkVToxkRhilq5gRYwFLCOK
 /dTP2PlG6fa/4IqXd6Pa37RHVcnLKo5Bf3vHaQ0B7pnH+Lnt6TkV/cR7jfLOfcb2zQy+
 qAavQzWJi6kabJtAzMJkVeZZiMTHYcdDmgc+66pMnZaLnemTAAt9d4qFgcAIcC8x2A3W
 EsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773112188; x=1773716988;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=96cpjxMhVI1uJGBrabIXVqr665B5wCj7hpYdD9l29nk=;
 b=YeUFFDlLBwncpk6c3Tqx0/Ju6Lp0o/fqqx5ClM3/zFrC/gdcLGjT7lxIG8xp+UApAX
 Y6KfrChnKMoKMdzy7L7e4zcrnyTYpe0B7R6rTnDevLEDph9XZig08JcLX+rZ2QlqyR/O
 35KnGH7uIx4Am07pJD+8Ei1G29QW/ppU33D+sVcWLZszal/XE2S5A/TEbU8T+d4IeWnc
 OSvDBqs6efh8TUJlj+BfOpimkLRiWalStaT7Mmyl2sdLS9fEcJJdcQJie0ADXedEPsWU
 6lLX8Qxi3stF1NYJTXD2rc/HprAWZazz9mbieqGIiOcVQSco2EZ6QPo4/gKg5Y54Hzy0
 J37g==
X-Gm-Message-State: AOJu0YzCo1NgdpUTqoLIhNQQMKkkza8f3YEAwF3bG1vqNjw3tJG27M06
 4me5rhjytOHOZ47Qt6Xo53XXOhXFQIMvU+RBff4QXn7srgtmqKQh2VBX3Telsiz5drhuNvCpIcQ
 Z9puftKt+EGZjOjC2/76xm2e06Y94by3YJdtt/XNCFLQmT8eUlWZdaR1WBL4PSwxRV8OaYs8aCm
 kgeCeqBFQgaMZUcHzp60V2VBmuroIiBs4=
X-Gm-Gg: ATEYQzxuf2/eEw08j96D3lm7bymjSHAygyjf8gRri3G6dkKWgs5CHxinF7JOAdjRKZ5
 QdspK2yvYzZKmIxlfGR+g33nnTcBBCESF5exycTFq2ur0XxDBtzKOj9U8a6ZoRhbiHeJZUjIyLS
 6gBjc3oqFcP2TABrThoUAtGaeB2U5Mb0aWicw7koVxXO/Sbiq4QGr2SaLqCdfggGiOJk5ELX0/d
 wQYIg17
X-Received: by 2002:a05:6a00:1397:b0:827:4bca:f1a2 with SMTP id
 d2e1a72fcca58-829a2d81a8dmr10874371b3a.10.1773112188456; 
 Mon, 09 Mar 2026 20:09:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:1397:b0:827:4bca:f1a2 with SMTP id
 d2e1a72fcca58-829a2d81a8dmr10874352b3a.10.1773112188019; Mon, 09 Mar 2026
 20:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
 <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
 <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
 <CAJaqyWfOdMkeXEfHKadN2zrXmxNytC+uzFmf8pF7Ldrr6i0o6w@mail.gmail.com>
In-Reply-To: <CAJaqyWfOdMkeXEfHKadN2zrXmxNytC+uzFmf8pF7Ldrr6i0o6w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:09:36 +0800
X-Gm-Features: AaiRm50p6I1KqIOTgUDUZdt-fPgyL4yUM-nABRJZp61QI44aWlxfupOyxuQ5v4Q
Message-ID: <CACGkMEv2-pfUwMi0_b_FO0-FTLn7t3RDBvpYBPBT9+CdsSDY2A@mail.gmail.com>
Subject: Re: [PATCH 1/7] virtio: Allow to fill a whole virtqueue in order
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Mar 9, 2026 at 2:19=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 9, 2026 at 4:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Fri, Mar 6, 2026 at 2:23=E2=80=AFPM Eugenio Perez Martin <eperezma@r=
edhat.com> wrote:
> > >
> > > On Fri, Mar 6, 2026 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.co=
m> wrote:
> > > >
> > > > On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma=
@redhat.com> wrote:
> > > > >
> > > > > As the while steps < max_steps is already one less than the vq si=
ze, the
> > > > > right maximum max_steps variable is queue length, not the maximum
> > > > > possible remainder of % vq->vring.num.
> > > > >
> > > > > Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN=
_ORDER support")
> > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > ---
> > > > > Personally I'd just remove max_steps and let it be vq->vring.num,=
 but
> > > > > let's make the minimal changes for now.
> > > > > ---
> > > > >  hw/virtio/virtio.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > index e9d553295257..17f171551892 100644
> > > > > --- a/hw/virtio/virtio.c
> > > > > +++ b/hw/virtio/virtio.c
> > > > > @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue =
*vq, const VirtQueueElement *elem,
> > > > >       * We shouldn't need to increase 'i' by more than or equal t=
o
> > > > >       * the distance between used_idx and last_avail_idx (max_ste=
ps).
> > > > >       */
> > > > > -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vrin=
g.num;
> > > > > +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->vri=
ng.num);
> > > > >
> > > > >      /* Search for element in vq->used_elems */
> > > > >      while (steps < max_steps) {
> > > >
> > > > Not directly related but I found that the virtqueue_ordered_fill() =
and
> > > > virtqueue_ordered_flush() can "emulate" an in-order device even if =
it
> > > > isn't one. I'm not sure this is good for the device that can benefi=
t
> > > > from out of order completion like block devices.
> > > >
> > >
> > > I guess the benefit is significantly reduced if the device cannot use
> > > more than one descriptor in the same used entry.
> > >
> > > > It seems the correct approach is to let the device decide whether i=
t
> > > > can operate in order, not the virtio core (as vhost-kernel did).
> > > >
> > >
> > > I agree with this.
> > >
> > > Currently, `in_order` is off by default but we could enable it by
> > > default per-device.
> >
> > After further thought, there's another reason. For example, for a
> > networking device, virtio-net should know nothing about the networking
> > backend (though some tricks exist in the code). So it can't know if
> > the backend can handle OOO or not. Starting with this seems to be
> > fine.
> >
>
> Well, if the backend exposes in_order, I'd assume it works better if
> the feature is acknowledged. I was talking just about the emulated
> device.
>
> I kind of agree with what you say for virtio-net+kernel tap or
> vhost-kernel case, but we're already assuming that the virtio-net
> backend works in order in Live Migration anyway.

Could you point the code that has this asumption?

> With worse
> consecuences that less performance. To be coherent with your mention
> here, we should support out of order descriptors in live migration.
> Not saying that it is urgent, just pointing it out.
>

Thanks


