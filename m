Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C58EF36E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzTyJ-0002dN-NH; Mon, 09 Mar 2026 02:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzTyE-0002Wr-5S
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:20:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzTyA-0007bs-Uy
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773037197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZUcTOee5fCmnpYRg75B8u8kmQQGCOdT0nvAj+9ht668=;
 b=Qwk8hhCK3fWVVccYSncSnJEgMjDsdkDHb6IFZG7ktAHQzK3qA9GFari+98FLxbb1FNaQyv
 Z+ZfQytLw+Ex94DEd9aOXXsKVv70Zs6Y+JKNATXv5RhalsylJG5JflDcd5/b1HeLC2wZgR
 mnFNHSfWb3QpDZKpMOPIT8UdrMyaWzw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-WxInvOUzO8W9wVDYbXJJ3A-1; Mon, 09 Mar 2026 02:19:54 -0400
X-MC-Unique: WxInvOUzO8W9wVDYbXJJ3A-1
X-Mimecast-MFC-AGG-ID: WxInvOUzO8W9wVDYbXJJ3A_1773037194
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-79868381229so240255857b3.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:19:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773037194; cv=none;
 d=google.com; s=arc-20240605;
 b=ezov4jf2FQmVVv5xAxVQaYva27mRE1u2yrX4dd2kPz8ZUG3tRwwkGahcMt1Tr0qUUp
 sAOqqYK+95/Yo56Ut8OTL7ImgYWfFJ0mOSP/SrVR+SEJBzW0dRdyeWqO4dnXHovyIVkX
 b03t+T2gshnYKmOnWjMZmyb8E9rVx/6PKSw6dxlm8LiQFDC8khycTFeQUMCKXt5G2FUN
 MdkKJXGVSXt7NlJmdYQ3pQtW2Bn6b8ZITLau6Xj/MhnNmRW4s24jKFa2swBYIlwB0eGI
 a0NE1mH/qjDvtTrzVU/Ms1M1wi7wt4OZ8QVvNxok/wct4scAFbmx7UOL+e9dmLfPPo9j
 MebQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZUcTOee5fCmnpYRg75B8u8kmQQGCOdT0nvAj+9ht668=;
 fh=srKTuQ1zrFvCk697vtO4h473zqLsuvDuubo1BzKDh1s=;
 b=GiBhQWQEIYe6Vq4Akn589k3AE5NaD1mWldTjD9C4Vs04lhbjno7rKDN20VMHacEhiB
 srP8ejWfqi0Suwca3fAqssn0EmPWtxZUxDxFBKGOWXspGoPFQP3LeWV7H05muHJzuxf6
 CU7is5dx1SpzoXVhsVlvq8pkwFwY2uAqX5xErZfRgcmGh0AcUCVH5i1iUMJHcO2uwqo8
 lrkGL6OEGD3UgVfX5m3UG1cODiwMfEIAoZxi8Cj2naC4osU9omLKVy/7mYBgM/i+NxNK
 YtQNONby8oNAI5/OaArm0OrUMEpBr6758VqTvCPAgVKOewaonUyPxWKthw0yUFmFmkK+
 +Msw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773037194; x=1773641994; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZUcTOee5fCmnpYRg75B8u8kmQQGCOdT0nvAj+9ht668=;
 b=KaB1oIq3N65gpAKP3iNMheAKKi+jDLUBnTzpeqXI01WwvnC/hcwsFSSJ51P+H+11wM
 k+iYht1KEt0CHE+/wLDbYF20Jgc6B1CiiM2H+LOwS7DNNAKHHPwKSIZ0YNy35vKmGoQi
 fvPKSDbh4X/hIsZjSBbaD8onaFHYbPzEry9MEqNtucEPLQuQMPcE96GaxakDAnq6CZFe
 DMKpE9/+u4+K39ph2xohRS7oCSdIIRljmS7R26Ic6o3mYcBkpGlpZFYWsMHy/a7H7JBn
 ubZOmPMeE7sASqA2zDa1vX6A+p9POUPan6vrVth2bDa4HRZO+6zB2NR/9tvvlGRUOK+v
 xlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773037194; x=1773641994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZUcTOee5fCmnpYRg75B8u8kmQQGCOdT0nvAj+9ht668=;
 b=DV7IXWy+20q5JsKfaVl8F9/9oWgmErerLlyX5OtR6VXDVl9/E4CZEQ611+C0SpxY0a
 0iBZiGq5bst8CHefO6nmMOMRExkgijCdAyq45kl0qZb/L6A5KMXRrowNkgHb0od2aUgd
 YLZYYMMfPRws50UABSWPH3nca466GRIYS79ttQnGPPghpbjOgiMQhX/AJFLNPoe2mIiI
 xAAY2Qb8vZrKYz3inDJr8YvP+PKmE0XDfCXkx4YjtwDsaZ/+03qOqmgeDfbmnAqt7rJw
 XWRTSqOfdDuLPPsYdSctYUYQtWGX1HcirHv+duhwFxLJLAYy94324eLKTmkQYUxAcwvM
 GaJg==
X-Gm-Message-State: AOJu0YyxN/2UZlBGkwdypS7tg8DMq2TM02gpIktAeH6fhrlibFM14VJj
 rkfsPbuoYiLrkiIjJetjIojSQqYkdG9Kqxx5L6Bp7BNKOYcOfFiiBSYEVaubncVdbz8lQ4gAHwJ
 Opxj1TD0RUgLyXe7syJhlnCOEkyDV7+tY67cMaugTsgnRZwiBjycUVkq181gEa0Uur3ckN/v32o
 5wZPRqwsC/RkDhXCoxdJgKIn6/kXaFunY=
X-Gm-Gg: ATEYQzwSe6t1Zc0DY/yMqVwF+zlgNljBvZvek39TrR8ktZtBhZH0mwG7lrxKJ40jPiK
 +b0b5nqAQqaqoMMwQJ3gEcy+WlreawAkF+x7tGZz36MP2xkwQAxVxtR6HnQnGPXyUPcVYIu0L3p
 /1L7r6KSTTPzXJQMC7R9zWkEawBXBwObgm5BUEXtra3KSbHAxIENn0KCsKUR2fBy6A3KcEUl5vm
 6V4pQ==
X-Received: by 2002:a05:690e:1389:b0:649:6053:15de with SMTP id
 956f58d0204a3-64d0715a066mr13532373d50.27.1773037193851; 
 Sun, 08 Mar 2026 23:19:53 -0700 (PDT)
X-Received: by 2002:a05:690e:1389:b0:649:6053:15de with SMTP id
 956f58d0204a3-64d0715a066mr13532355d50.27.1773037193463; Sun, 08 Mar 2026
 23:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-2-eperezma@redhat.com>
 <CACGkMEu5BGgdstpEVw8eH+wmXhi+nFdHRW2bXk7enZtxbAdsBQ@mail.gmail.com>
 <CAJaqyWfADYQHjszX+DGoW1Cah--619_pVztmfV6ctTN6-0-Q5g@mail.gmail.com>
 <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
In-Reply-To: <CACGkMEt09WkCgJmbrdmyDYdB8HUH=Y-DrwNChJGrfH2afua8QA@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Mar 2026 07:19:17 +0100
X-Gm-Features: AaiRm51jTBnDesVIZwuFeEtcxtqVF-9enb6j2VkHf2IuxNOAUXU-byAIPSgZl10
Message-ID: <CAJaqyWfOdMkeXEfHKadN2zrXmxNytC+uzFmf8pF7Ldrr6i0o6w@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Mar 9, 2026 at 4:17=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Fri, Mar 6, 2026 at 2:23=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Fri, Mar 6, 2026 at 4:26=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Mar 5, 2026 at 1:35=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > > >
> > > > As the while steps < max_steps is already one less than the vq size=
, the
> > > > right maximum max_steps variable is queue length, not the maximum
> > > > possible remainder of % vq->vring.num.
> > > >
> > > > Fixes: b44135daa37 ("virtio: virtqueue_ordered_fill - VIRTIO_F_IN_O=
RDER support")
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > > Personally I'd just remove max_steps and let it be vq->vring.num, b=
ut
> > > > let's make the minimal changes for now.
> > > > ---
> > > >  hw/virtio/virtio.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > > > index e9d553295257..17f171551892 100644
> > > > --- a/hw/virtio/virtio.c
> > > > +++ b/hw/virtio/virtio.c
> > > > @@ -980,7 +980,7 @@ static void virtqueue_ordered_fill(VirtQueue *v=
q, const VirtQueueElement *elem,
> > > >       * We shouldn't need to increase 'i' by more than or equal to
> > > >       * the distance between used_idx and last_avail_idx (max_steps=
).
> > > >       */
> > > > -    max_steps =3D (vq->last_avail_idx - vq->used_idx) % vq->vring.=
num;
> > > > +    max_steps =3D MIN(vq->last_avail_idx - vq->used_idx, vq->vring=
.num);
> > > >
> > > >      /* Search for element in vq->used_elems */
> > > >      while (steps < max_steps) {
> > >
> > > Not directly related but I found that the virtqueue_ordered_fill() an=
d
> > > virtqueue_ordered_flush() can "emulate" an in-order device even if it
> > > isn't one. I'm not sure this is good for the device that can benefit
> > > from out of order completion like block devices.
> > >
> >
> > I guess the benefit is significantly reduced if the device cannot use
> > more than one descriptor in the same used entry.
> >
> > > It seems the correct approach is to let the device decide whether it
> > > can operate in order, not the virtio core (as vhost-kernel did).
> > >
> >
> > I agree with this.
> >
> > Currently, `in_order` is off by default but we could enable it by
> > default per-device.
>
> After further thought, there's another reason. For example, for a
> networking device, virtio-net should know nothing about the networking
> backend (though some tricks exist in the code). So it can't know if
> the backend can handle OOO or not. Starting with this seems to be
> fine.
>

Well, if the backend exposes in_order, I'd assume it works better if
the feature is acknowledged. I was talking just about the emulated
device.

I kind of agree with what you say for virtio-net+kernel tap or
vhost-kernel case, but we're already assuming that the virtio-net
backend works in order in Live Migration anyway. With worse
consecuences that less performance. To be coherent with your mention
here, we should support out of order descriptors in live migration.
Not saying that it is urgent, just pointing it out.


