Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AB9FCC9CC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:22:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqTT-0008Sj-04; Tue, 10 Mar 2026 02:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzqTR-0008SN-GG
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzqTM-0001WA-Tt
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773123698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8qOyGQSKOkk0aZ1QutW7TQ5ROu63Bx8vRXXADH64F6I=;
 b=DUYcakrMesu3L8Dv4paGqEOLWwup5Gj7TGEw53O/uMU5lm9p2cly6w5m2iaH/rxECNWFMM
 /+fc/vs3/sHjEEl1guavkNd9Ud0UeWcRw9oePnJ9eWkNW/C6U+ojP7jmD/uV/fnAIdZrEr
 iufc1bipS57XcwbtqqZEWy71TcfE6Q8=
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-lldOQ07YM_qljsn4HNsVPw-1; Tue, 10 Mar 2026 02:21:37 -0400
X-MC-Unique: lldOQ07YM_qljsn4HNsVPw-1
X-Mimecast-MFC-AGG-ID: lldOQ07YM_qljsn4HNsVPw_1773123697
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-644548b1dcfso8587384d50.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 23:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773123697; cv=none;
 d=google.com; s=arc-20240605;
 b=h18QkH8qtG6xVjz6uewvawyUwO6tndFbk3AaoZuVoSRpVA0+wUei4V+cS1alotfxGR
 q6IePZe/trktM+gDIg9Ywz6f8rJovkccsvDwAiUT58pOaI0wMDon+pno+y5VsLYl9ZRO
 UBhZDHfidJsQsVLB/YkMrYJplBwAgiWW3P3UrMxbugSxhJD4xfVIrT997q5aF2+oGAZY
 rNyo7ypYUN7uSjKvLKPvFeWz5r2rS5p/tnkVmgnlGpjuaPvSMybBlENUO5IyEah6ZbYb
 iHpb6XhxtXFdhYPuSXBPth5XEtvlcdsKEfZqC7ls4s06AcPtLmmkmN57ZmZUzTUs+ULs
 DhFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8qOyGQSKOkk0aZ1QutW7TQ5ROu63Bx8vRXXADH64F6I=;
 fh=srKTuQ1zrFvCk697vtO4h473zqLsuvDuubo1BzKDh1s=;
 b=KDZIs9ckcqZaAI9t6xeS7n/V/hPv+nHCQljfuH28DwkgJO1AtpkBvs8Ys2HHc5vw+Q
 36X0FSSW+yYvqjDJSo9uAc86IAkemzfiQ5s/MNduzQeysd9rZ3sn+CajkBCmTHABnKmb
 fDhrCghNQ6j3jnX2YQ6b0VHRVjLjmNarVdFoULVsvZpgfiJPA8x4vxzdNgWZ1EBLxJn5
 V66UcLeGAIa59zcOi5d2nSCQeHlKBn+7E1rXAgfZo3YmhQbKBFQbhpTAxWH1z1n49cJg
 jmPAqogophwb3NTjQXbY37Bm7AOv19cACL+TnqmMczApBPYxb/j8I4jfLUuPQopiUZtQ
 XIwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773123697; x=1773728497; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qOyGQSKOkk0aZ1QutW7TQ5ROu63Bx8vRXXADH64F6I=;
 b=GRLt88vBhURDZ8vJoj7qpD2R0Vp9Bm8FNYCVwVoR+qVjXcmks4Ve8wVReh/VXj/MA+
 mLzZOWTg2tbqitRkhgAmG6XSbeJikc+kDxFcsYijGmSlmnv0itl+jHlVNmQMtWrucfIx
 IYeVWViFLIbQTuHdFNRxInpESJAWLFcIYmdHwf68kHclAMzcyElENCcmNx5yvZW3cana
 RCsvKNTI7tumB7sPy/4mrhNN6VaXMTzX6xJ7HQ4GqYbr1HvOyeF9SGgeXpRMTIqQrYp8
 kqgnodGrdPxYnNl/zWR6mQe0ZEp1aUPZcYd4KUXAtiKXkw4VxvkjQKvOTEP//iZxUfD2
 Cw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773123697; x=1773728497;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8qOyGQSKOkk0aZ1QutW7TQ5ROu63Bx8vRXXADH64F6I=;
 b=n7rXS7u6QcH7byrMyaF2RolUgv8uend1nvvSsWafkXqYA2O1eEgTZ4f+zlcM6i8s0K
 Rhm0zHJW4fLWmS/eWb+Vu0slM2SgzMeV3wOmAVUc6rtGsV4jbUBbI+lx1MUcfuv7lqzb
 rRYDQJfaoouQ9JYJNZBIxdWnJV5a+eiyw9y5lpQA7+tMMYN+DQRLll3A4DHHZB2HeyFh
 cpost+3lUhZgA8YprrY8Td2YcWE/moNXUNuIyHnDQQPGq1Jb9TG9R9qif7hlFkuML5L6
 CU8i8xiVnqEqOQ57k0GZwVSWUyn/ERqIgj2SyrZNj3nN2rJsVLxc3xvO0U5/DKJ6Elnn
 TuNg==
X-Gm-Message-State: AOJu0YyxNqOSd0r15z6j9tI855WOeQu1oaC+U63GikbZq2aEvDioJ9nh
 1mBAGJ9UBydlOnX8mSSnqWXxyuoc8nItevHFtrPeMeyYMWfq/CUagHPUGrUfPgmuRWKQvJAZjre
 eH9+uK965OigvOD0CQ8tpE/Dqkzp04DzJ3NFrNHpNvYdJC2eadBd3HonJ4B6jXqERImtENTTzVC
 SZJoRQWikxwr+YuFR5WJKEfmwMzgGcjh8=
X-Gm-Gg: ATEYQzxo5oq6avSSccgGxxdw8ey9jN7F38s9fbAj8x6Gn20ttu0ZnSi127mBoiahxP5
 /rdC9jXbD7Ze1EDdmfbA8mu64MH2NzouN7wZojG6T53e9r1s0QqzbByFb6PCYs80UFxNuJuvrhS
 KCDg2dCUqFvFlJ8SsUx2ooRLYMc2vjc6VM+4FY/lVC1r3FpbfBcBINODhto/w5LJQKLkn92WJkp
 B6oPw==
X-Received: by 2002:a53:b191:0:b0:64c:b68a:f519 with SMTP id
 956f58d0204a3-64d14397896mr10023312d50.80.1773123697135; 
 Mon, 09 Mar 2026 23:21:37 -0700 (PDT)
X-Received: by 2002:a53:b191:0:b0:64c:b68a:f519 with SMTP id
 956f58d0204a3-64d14397896mr10023302d50.80.1773123696717; Mon, 09 Mar 2026
 23:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
 <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
 <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
 <CAJaqyWfOdMkeXEfHKadN2zrXmxNytC+uzFmf8pF7Ldrr6i0o6w@mail.gmail.com>
 <CACGkMEv2-pfUwMi0_b_FO0-FTLn7t3RDBvpYBPBT9+CdsSDY2A@mail.gmail.com>
In-Reply-To: <CACGkMEv2-pfUwMi0_b_FO0-FTLn7t3RDBvpYBPBT9+CdsSDY2A@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Mar 2026 07:21:00 +0100
X-Gm-Features: AaiRm53Dp7S1gA0ZqCdKUEWeGCS1o_bFeiKxqChGzLQFcpwOxVipGcR_iuBtjvw
Message-ID: <CAJaqyWfC_hjCveqtnhx9cU=EA66oj5amLCGQ8b9Jf3pbzeuwYg@mail.gmail.com>
Subject: Re: [PATCH 1/7] virtio: Allow to fill a whole virtqueue in order
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea DE <dtatulea@nvidia.com>, Jonah Palmer <jonah.palmer@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable@nongnu.org,
 Cindy Lu <lulu@redhat.com>, Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 4:09=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Mar 9, 2026 at 2:19=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Mar 9, 2026 at 4:17=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Fri, Mar 6, 2026 at 2:23=E2=80=AFPM Eugenio Perez Martin <eperezma=
@redhat.com> wrote:
> > > >
> > > > On Fri, Mar 6, 2026 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.=
com> wrote:
> > > > >
> > > > > On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperez=
ma@redhat.com> wrote:
> > > > > >
> > > > > > As the while steps < max_steps is already one less than the vq =
size, the
> > > > > > right maximum max_steps variable is queue length, not the maxim=
um
> > > > > > possible remainder of % vq->vring.num.
> > > > > >
> > > > > > Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_=
IN_ORDER support")
> > > > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > > > ---
> > > > > > Personally I'd just remove max_steps and let it be vq->vring.nu=
m, but
> > > > > > let's make the minimal changes for now.
> > > > > > ---
> > > > > >  hw/virtio/virtio.c | 2 +-
> > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > > > index e9d553295257..17f171551892 100644
> > > > > > --- a/hw/virtio/virtio.c
> > > > > > +++ b/hw/virtio/virtio.c
> > > > > > @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueu=
e *vq, const VirtQueueElement *elem,
> > > > > >       * We shouldn't need to increase 'i' by more than or equal=
 to
> > > > > >       * the distance between used_idx and last_avail_idx (max_s=
teps).
> > > > > >       */
> > > > > > -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vr=
ing.num;
> > > > > > +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->v=
ring.num);
> > > > > >
> > > > > >      /* Search for element in vq->used_elems */
> > > > > >      while (steps < max_steps) {
> > > > >
> > > > > Not directly related but I found that the virtqueue_ordered_fill(=
) and
> > > > > virtqueue_ordered_flush() can "emulate" an in-order device even i=
f it
> > > > > isn't one. I'm not sure this is good for the device that can bene=
fit
> > > > > from out of order completion like block devices.
> > > > >
> > > >
> > > > I guess the benefit is significantly reduced if the device cannot u=
se
> > > > more than one descriptor in the same used entry.
> > > >
> > > > > It seems the correct approach is to let the device decide whether=
 it
> > > > > can operate in order, not the virtio core (as vhost-kernel did).
> > > > >
> > > >
> > > > I agree with this.
> > > >
> > > > Currently, `in_order` is off by default but we could enable it by
> > > > default per-device.
> > >
> > > After further thought, there's another reason. For example, for a
> > > networking device, virtio-net should know nothing about the networkin=
g
> > > backend (though some tricks exist in the code). So it can't know if
> > > the backend can handle OOO or not. Starting with this seems to be
> > > fine.
> > >
> >
> > Well, if the backend exposes in_order, I'd assume it works better if
> > the feature is acknowledged. I was talking just about the emulated
> > device.
> >
> > I kind of agree with what you say for virtio-net+kernel tap or
> > vhost-kernel case, but we're already assuming that the virtio-net
> > backend works in order in Live Migration anyway.
>
> Could you point the code that has this asumption?
>

Actually, the lack of code to migrate the inflight descriptors is the
fact that the migration code of virtio-net assumes the buffers arrive
in order :).

It is easier to reproduce in the packed vq: When used entries override
the avail descriptors, all the overridden entries for available
buffers are lost. But it's easy to reproduce in the split vq too, as
we only migrate indexes.

It does not happen in virtio-blk, where in-flight virtqueue elements
are migrated.

> > With worse
> > consecuences that less performance. To be coherent with your mention
> > here, we should support out of order descriptors in live migration.
> > Not saying that it is urgent, just pointing it out.
> >
>
> Thanks
>


