Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EF7FCC9CE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzqir-0002oW-P1; Tue, 10 Mar 2026 02:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzqig-0002na-Pp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:37:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzqie-00044R-00
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 02:37:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773124646;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uRkPtJH+4L7/jwms3qZYaP7ya0qDaVT8c/2w5DbpmcA=;
 b=hkvkyuIdApaFvsZY3HQ3oX6DXjEio/7VT4ZOnxqlwhGPxKilLtoEP+4nY2kPLhEu4l8F+W
 kK+d7JeIlZE2aIphWnof3O5JP8StOXuB380m9C4kzeC8Q+absL+oC0+a1sKwXQYf6DE7W0
 4V1c9xH4PEu1/H5jT6lhBronooEA3b0=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-mIM2iZXFNxWrr4VQ9573zw-1; Tue, 10 Mar 2026 02:37:24 -0400
X-MC-Unique: mIM2iZXFNxWrr4VQ9573zw-1
X-Mimecast-MFC-AGG-ID: mIM2iZXFNxWrr4VQ9573zw_1773124644
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-64c9ebd16e0so22394803d50.0
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 23:37:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773124644; cv=none;
 d=google.com; s=arc-20240605;
 b=PxfZUj8Vn6taXUEM1wihl28Fq3GkraYRcqHWsWAojusy+YSegPcAmrLrwaDxWOr3ZT
 DtcpQBfsUIT8OHnfMG0bz87bdbDz5mDoZqrVpV5eapPz96/8mzOsHq1nU9v4qOT3X6us
 2Fcm9/Oh0TUNR9ZtCzRuo57AjDAuuItMZ/rWLmzbqZzLPsAUhrc/NqAeTprYsJQP5ycD
 dSYiNdFRs2FIN4vMViIglOi70GumH6dTzUcx7ArLMc/KlM8CgBjIUKxcV9JTrxJfc4Cs
 u9qR87uY5xpI/tQN2Iei1LqIUtIpia0f2HrIqmIyrEwdeOs5NfOQJS85YtTGFN8rlXaW
 6/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uRkPtJH+4L7/jwms3qZYaP7ya0qDaVT8c/2w5DbpmcA=;
 fh=srKTuQ1zrFvCk697vtO4h473zqLsuvDuubo1BzKDh1s=;
 b=CmltmDOLtiMORV5q1g7JUcXE5MByplhUSBUlA0yXfiknOUGC0pVyZ7oZ9nk8UBHKcX
 vslR6R0ufvyBXYokXkbBSCGBuHLN8keC7uLs8gPg60zWum4rlfL+p6RJ7tLx48UJMaIx
 j4j2GgDyMbYNWZwE6A5FnyP2fjMzb7Ff8fa6aAnX872B994EaN2mlVGfShgW/3LJp7qe
 DZt7E2WO1YlrAR6P5YQAluednJ+Xy7rxHfTdE+S4RMfZllpVLLyQIt7koAPtifubi6F6
 Ql4vYkgAglzanT7SLM5fTeAS8/Z8Vsb0ht2K8q4ejsb9nFf3K5d7LSj8gL5zLq+lyPPf
 2HHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773124644; x=1773729444; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uRkPtJH+4L7/jwms3qZYaP7ya0qDaVT8c/2w5DbpmcA=;
 b=mXo+LAaDSOQhpYFCcg6UUmdrMH655E3Y7KmL7JjxCf8jg0WbyPbvnGSQRntvb7N00o
 +CbAJKFKXQPMzJqOSMIg2dxzEye/ZgFFdI1SwGncK276RtCyAdeGkERL12wsw9hzO2pH
 ZWlxI15ig5X3F1McQXLcz+YY/0+r3FjLYJMcDcKlY+75VOTzmbg/kSFwLF2l0GqqVa8/
 HU8L6IiIzge1JrKD9K1Nb3zK0WB0GkxIj8dbeQFN0yiPvg2tjUWEbmHNEtbeMdcceUCO
 16nahINR2syh8nh09clTXthSO34NLcF2LUORM/XePaVU1PdqrkQvqCXIQb/LTnXEPyYv
 gWhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773124644; x=1773729444;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uRkPtJH+4L7/jwms3qZYaP7ya0qDaVT8c/2w5DbpmcA=;
 b=W4qVfxaYfb+v2PxNtRdKlzT523uiTXsCa5l9scR6aFJFGppiaC1RFmMx94h5gSY+cc
 O3LmG2/alFZ/XmqRMHJIur6tjqnkExpqh0zkVdLPJSbVXgIl4z3u9ki3lpGKyTFHAl6l
 7S8lHnrWzSvdC03DNxIEJGMHeksy+BFI1n/fQfuOohEBDkOnWLbEatd2nxkpuDu8hl0p
 s8MTCo6wlS9HYqwwzv9l0k7P6y6rf+vDVj2jR+XlSz9ID3Yt/mG2fbWoXWJ53UPJO41/
 5gv/sX1d+o5qpOmBddK1HOjLv1TJpSMZHIsPqRwa1gX84TYBIEtIkEj3qru7E7cyX3wS
 npbg==
X-Gm-Message-State: AOJu0YwfOfhDDtF99WHNFoEKvAInWLzpGJdVvbIr4MxYq/1nrHZ46D+V
 KQJkR3clfJLYHCcFPJ2oKamAV8+mDG7vO+bHKiV+dPOLVMhhp6Zq6LvjHejRsTlYiRuCUj2WIx+
 y0POqD7/t9tnjB92BEOpANiqRN0xE0ydVw/OK/1FEpiGbgiGscTuJYGtUqLZg6BhCSR7UZyDpEu
 ojtc5uM3Fu2aPiA9gESSWjPeQDcVqgWks=
X-Gm-Gg: ATEYQzwcwHYW8cEC5DUZOU2K4ezPxvoWPLpqOpWtFYPklBVBJujiqEFx8sGB26XKu06
 x0o8k+GNa6PhhjjODV/MfncCH7AMS4pdmRMOpnElH+FxLoXopE62ji1X/zx6SbUBAIOHJ9cRWMz
 4+aqFIn/qXkBZ/Y0AO2Mr2QLD3HOdPQMO9MRfFxeX11b6HFSNXabuFVSIfYbVsfyrH76C3I6tih
 tue9A==
X-Received: by 2002:a05:690e:130c:b0:64a:d1bd:8c66 with SMTP id
 956f58d0204a3-64d141641cbmr13838959d50.29.1773124644011; 
 Mon, 09 Mar 2026 23:37:24 -0700 (PDT)
X-Received: by 2002:a05:690e:130c:b0:64a:d1bd:8c66 with SMTP id
 956f58d0204a3-64d141641cbmr13838950d50.29.1773124643642; Mon, 09 Mar 2026
 23:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-6-eperezma@redhat.com>
 <CACGkMEsCDDSV1m9-2cz3SGEh=MB0viA6h5a9vF5BCHPEhadfUQ@mail.gmail.com>
 <CAJaqyWdPbU3HXxsc-e4+K_CBPtnYZzbW8vrQJYK-nSUu35LtWg@mail.gmail.com>
 <CACGkMEscrowNUuZyeCiae-Oww5gkoyfQ+-mK0B2FSvKJFAUX=Q@mail.gmail.com>
In-Reply-To: <CACGkMEscrowNUuZyeCiae-Oww5gkoyfQ+-mK0B2FSvKJFAUX=Q@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Tue, 10 Mar 2026 07:36:46 +0100
X-Gm-Features: AaiRm52fFZ03CcYNlsE7dEnXd4bmp1Zdhun_FhVitfx64KiKio4mqSUNcbzXqhQ
Message-ID: <CAJaqyWdp6QfXnBG1bh9pRgmf-znK_30t0Tbfs9yNHkKbz-ViDA@mail.gmail.com>
Subject: Re: [PATCH 5/7] vhost: factor out the detach buf logic in SVQ
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
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 10, 2026 at 4:04=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Mar 9, 2026 at 5:43=E2=80=AFPM Eugenio Perez Martin <eperezma@red=
hat.com> wrote:
> >
> > On Mon, Mar 9, 2026 at 9:57=E2=80=AFAM Jason Wang <jasowang@redhat.com>=
 wrote:
> > >
> > > On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@r=
edhat.com> wrote:
> > > >
> > > > This code path is modified to handle in order devices.  Abstract he=
re so
> > > > we can generalize on the caller.
> > > >
> > > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > > ---
> > > >  hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
> > > >  1 file changed, 16 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-s=
hadow-virtqueue.c
> > > > index e7e3c9155cd0..2d8fc82cc06f 100644
> > > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > > @@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(=
const VhostShadowVirtqueue *svq,
> > > >      return i;
> > > >  }
> > > >
> > > > +G_GNUC_WARN_UNUSED_RESULT
> > > > +static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue=
 *svq,
> > > > +                                              uint16_t id)
> > > > +{
> > > > +    uint16_t num =3D svq->desc_state[id].ndescs;
> > > > +    uint16_t last_used_chain =3D vhost_svq_last_desc_of_chain(svq,=
 num, id);
> > > > +
> > > > +    svq->desc_state[last_used_chain].next =3D svq->free_head;
> > > > +    svq->free_head =3D id;
> > > > +
> > > > +    return g_steal_pointer(&svq->desc_state[id].elem);
> > > > +}
> > > > +
> > > >  G_GNUC_WARN_UNUSED_RESULT
> > > >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *s=
vq,
> > > >                                             uint32_t *len)
> > > >  {
> > > > -    uint16_t last_used, last_used_chain, num;
> > > > +    uint16_t last_used;
> > > >
> > > >      if (!vhost_svq_more_used(svq)) {
> > > >          return NULL;
> > > > @@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(Vho=
stShadowVirtqueue *svq,
> > > >          return NULL;
> > > >      }
> > > >
> > > > -    num =3D svq->desc_state[last_used].ndescs;
> > > > +    svq->num_free +=3D svq->desc_state[last_used].ndescs;
> > > >      svq->desc_state[last_used].ndescs =3D 0;
> > >
> > > Any reason we don't factor those two lines?
> > >
> >
> > They are common for split and split_in_order case.
>
> Exactly, so why not factoring out them as well? Or you mean
> vhost_svq_detach_buf is only for in-order (then we probably need to
> rename).
>

This is the relevant code after applying the series:
static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *svq,
                                              uint16_t id)
{
    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
        return vhost_svq_detach_buf_split_in_order(svq, id);
    } else {
        return vhost_svq_detach_buf_split(svq, id);
    }
}

G_GNUC_WARN_UNUSED_RESULT
static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
                                           uint32_t *len)
{
    uint16_t last_used;

    if (!vhost_svq_more_used(svq)) {
        return NULL;
    }

    /* Only get used array entries after they have been exposed by dev */
    smp_rmb();

    if (virtio_vdev_has_feature(svq->vdev, VIRTIO_F_IN_ORDER)) {
        int32_t r;
        r =3D vhost_svq_get_last_used_split_in_order(svq, len);
        if (r < 0) {
            return NULL;
        }

        last_used =3D r;
    } else {
        last_used =3D vhost_svq_get_last_used_split(svq, len);
    }

    if (unlikely(last_used >=3D svq->vring.num)) {
        qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is used",
                      svq->vdev->name, last_used);
        return NULL;
    }

    if (unlikely(!svq->desc_state[last_used].ndescs)) {
        qemu_log_mask(LOG_GUEST_ERROR,
            "Device %s says index %u is used, but it was not available",
            svq->vdev->name, last_used);
        return NULL;
    }

    svq->num_free +=3D svq->desc_state[last_used].ndescs;
    svq->desc_state[last_used].ndescs =3D 0;
    return vhost_svq_detach_buf(svq, last_used);
}
---

Whether the code is in vhost_svq_detach_buf or vhost_svq_get_buf it's
abstracted from the in order or the out of order version.

The code is in vhost_svq_get_buf because the long term plan is to make
vhost_svq_detach_buf similar to your VIRTQUEUE_CALL macro in the Linux
kernel=E2=80=94a dispatcher based on the acked features. But I'm willing to
move it to vhost_svq_detach_buf in this series if you prefer.

Do you want a V2 with the two lines of code moved to vhost_svq_detach_buf?

Thanks!


