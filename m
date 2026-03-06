Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7E1F51405
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 06:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyOb9-0001uq-Af; Fri, 06 Mar 2026 01:23:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyOaw-0001tR-LK
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 01:23:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vyOau-00019x-Mi
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 01:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772778206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jn+vS3SPAROBQMnnBoLQUhiM4m5xGr5OXIpxOz0MKd4=;
 b=JEK3XkJ2bE9lfVXcQFOAzelbcyZ9o7DoIPoOvNwatM7RNK0qPsAVgQ6NtUaZKUZn0E3lhv
 I1JOHokfBJgI3ymPDMeAEjEQUdsW+MOTydrU9G8qbmmJsernNpY+vprlR1vLBqqX0bJ/CR
 nnSW3or1Dwh1rguiT3MqFR3sjP4uZdM=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-FHrrmk3FOeSCJJoF1drsXw-1; Fri, 06 Mar 2026 01:23:25 -0500
X-MC-Unique: FHrrmk3FOeSCJJoF1drsXw-1
X-Mimecast-MFC-AGG-ID: FHrrmk3FOeSCJJoF1drsXw_1772778205
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-64ca09f2064so14167602d50.2
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 22:23:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772778205; cv=none;
 d=google.com; s=arc-20240605;
 b=O8JQM7e1cKlsLUoV+eNp7rromfCW9m0ilN0/tZpWXuBCqeJI6OuS7lDoQzylhdube7
 Dbg2MzTxxsTupDB68VR9mChh0++gSusBGiKb/HWM9c1ikvfpSmLv5O5Tq1BBnp+ssooC
 7+c0scchg0KlS7T09S9qCY2Eu9jLe+8pqxJ06Yi/Ko6+nzzSuxZlxV/z9ZjqCW5zeLtA
 LQ35AUpArL6/SMl9/FLTUDk5kfK4MwuHK0rOftzOojoesFlOUVnX33SyMg0qbX1HcPdc
 9O0tTnLZqEDneYIRYD4AjPGN2Gcs0x8mC9GfxCA6tjbOIF7lw7dwgeMASLGBPZ9Xs0I7
 lACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jn+vS3SPAROBQMnnBoLQUhiM4m5xGr5OXIpxOz0MKd4=;
 fh=srKTuQ1zrFvCk697vtO4h473zqLsuvDuubo1BzKDh1s=;
 b=JnMlwNp/rfx4GgLfw3hv3PEss5rLpINy4iFo7nuYo4JzklSd7B9echrxYvs2qyrbsz
 Vrrp1JOF5v896Ex3xWOvaF8Cwi6r+y8qrLV8fXwKevYPfMC/J8KK0frEigIz/mQyCOsr
 2iVKVhIP5lBkiRj/VvB5p0eCxqDtsVWOZZQ3QfWg63YuhW3mnQ5ufRQUTDE5hbHR/ZlO
 TQvTTBKiWGIuoQZ2MDN3yYpuL9PbEutOefOmibsAhrBk9ywTBY+wiX1qHgLMuMCKpADz
 3Buv5F6qrdD9wAWcVcQR9/8pUtEDIBm/q1SSvIBnpHA1NS2r+QpcTy7bnEiILxg5S+kl
 6dmQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772778205; x=1773383005; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jn+vS3SPAROBQMnnBoLQUhiM4m5xGr5OXIpxOz0MKd4=;
 b=RxMc73oIV9lWXpUmtJ70wTIrBBoN0dFBGBaXR6Sn0TrkUnX+WnqiaD4eSxUe+Y5VFh
 UFUu/qWU6gKtGeQ5MbyL+wAHOuOZ9Fs3FDmzd8vGXFhhHob98I9OmRN22S958T4vqT9k
 f3oveG1dLwfzEchuL0KHgf7jji3jNxryMzss4Ew6NIZfdpxkX6zlTMNY9YIbNa2NtXqg
 LmgODBp1gYGEkFrYLZRaEVmJNVK4PNvlY612Ca3Dr8GOAWDiR5O5/qFrXFaPQhgyu2tG
 8zedaLPMgHAwb0kHj782YCdmCwABV2AmP3tVABgeompoRwP0sJFTpDJC6pJcrtr1s7qJ
 lC3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772778205; x=1773383005;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jn+vS3SPAROBQMnnBoLQUhiM4m5xGr5OXIpxOz0MKd4=;
 b=jS8Q9c8nccone3TAZwcoFAl948w7/y/Rcal6nQ+lA2TY0JIh2OhbO2Jnb0hc660HsG
 vQ0dWPAqNNMWnoIhtTYOgMdXkGw9s8PH8UoSVyY89qcG1fNSNRWjKOrrSkzo/ycrgVlu
 YlG8nGdnilEYikKVm8sDd8uBeo5ZRkHUR0XfwCsZD8FK4jreVCRj2mLYi1FZX7FSEeOx
 vd7jAK7pLWD/1DUkYN9wGF9hrCeK49swgI1drXv5NGgLuGbV4WxTKtOKtjQu9eprUbi/
 qZUvurfhzZL5Q5oAre+aNh7rk0MwdLzu7sUCX3RnhC5Nei8Iu2Gl5Ype6xk5/dLgoI0N
 jNJA==
X-Gm-Message-State: AOJu0YxZpade9Lx7uFc42tqdKqt3KJ19uN0WtVTSl1KDpAdqPbZFihMX
 X4819YbLx836XNg0cOrz4qNcbMDauvRjhVPnCkGuRDrrVxkdP/OfVOOArHaEbOpyRprGPIdMjjw
 WP7brb4zCxQw0ouabQmMNEOxZZYjkw9Xr9F1ARlBY2CDQYLRgYB1l/LoThiM5nUEpg+OourzXh0
 2YyQOO5hZl8lzz/xNwtixcYYenab5FOgM=
X-Gm-Gg: ATEYQzwIQSqJ5bN1CutU4VvVmn6ZFg5XTV9yLRl7VlTsrVHvXh0eT+meZPx5CgsLjcD
 uONEkWnqKytzT2tj1fnrTggi0Eh7ERd7xIAX5dwkfk6kmjGS90fjwqZoSvdJs5fF8UpD4ZHU+wA
 0PucgFC2CUZi5XI7fkIUFZR1pYFl7zW4CWDG0w7+p0QpQQqU3Ta0D3WSxoA3fKcsA0SSscj8oFE
 g5i+A==
X-Received: by 2002:a53:b10a:0:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64d1414f131mr996907d50.30.1772778204989; 
 Thu, 05 Mar 2026 22:23:24 -0800 (PST)
X-Received: by 2002:a53:b10a:0:b0:64a:d35e:d356 with SMTP id
 956f58d0204a3-64d1414f131mr996893d50.30.1772778204683; Thu, 05 Mar 2026
 22:23:24 -0800 (PST)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
In-Reply-To: <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Fri, 6 Mar 2026 07:22:48 +0100
X-Gm-Features: AaiRm53Ih6hFvM22ySOkW02Gkq6vLM4nuetQxmAUIN89Xs-7Bt0SY5_tTtlYZp0
Message-ID: <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
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
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Fri, Mar 6, 2026 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > As the while steps < max_steps is already one less than the vq size, th=
e
> > right maximum max_steps variable is queue length, not the maximum
> > possible remainder of % vq->vring.num.
> >
> > Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_ORDER=
 support")
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> > Personally I'd just remove max_steps and let it be vq->vring.num, but
> > let's make the minimal changes for now.
> > ---
> >  hw/virtio/virtio.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index e9d553295257..17f171551892 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue *vq, c=
onst VirtQueueElement *elem,
> >       * We shouldn't need to increase 'i' by more than or equal to
> >       * the distance between used_idx and last_avail_idx (max_steps).
> >       */
> > -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vring.num;
> > +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->vring.num=
);
> >
> >      /* Search for element in vq->used_elems */
> >      while (steps < max_steps) {
>
> Not directly related but I found that the virtqueue_ordered_fill() and
> virtqueue_ordered_flush() can "emulate" an in-order device even if it
> isn't one. I'm not sure this is good for the device that can benefit
> from out of order completion like block devices.
>

I guess the benefit is significantly reduced if the device cannot use
more than one descriptor in the same used entry.

> It seems the correct approach is to let the device decide whether it
> can operate in order, not the virtio core (as vhost-kernel did).
>

I agree with this.

Currently, `in_order` is off by default but we could enable it by
default per-device.


