Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA6F6FCC9AD
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 03:07:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vznRa-000659-7y; Mon, 09 Mar 2026 23:07:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznRZ-00064o-6o
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:07:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1vznRX-0008DO-IC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 23:07:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773112054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wkwoTKSndKX8U5yRKi01LZXi44nHwK/CPu/et4Fn7g=;
 b=VtMye5wXIkZIOiLa08nYapI/zgNkl7bXuApOhl3qo0Tre88JMwfgUywM3kv38qF5z6ggWo
 7y8X7jRj5lJ7hA0/X7QjSgdUsztfv28RDUTKg9VNr1zVCcOLHhD2qFXIryfB7VkDxMC3nt
 BLtcJ1pTZdNUTDHUuY00kwjQLiCT1E4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Jd_ouis_NdiWVMO8CQMT_g-1; Mon, 09 Mar 2026 23:07:33 -0400
X-MC-Unique: Jd_ouis_NdiWVMO8CQMT_g-1
X-Mimecast-MFC-AGG-ID: Jd_ouis_NdiWVMO8CQMT_g_1773112052
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2ae3f446ccfso90595255ad.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 20:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773112052; cv=none;
 d=google.com; s=arc-20240605;
 b=Xe/QKqDFkcPJ1LbqVOfmQl+H4CILn3WHAWaHkKvJ11rDSuEWB7XcmAsjSugWpx+5OR
 9NFaAR9TLPNUCDW6dayRZdMnm0Y7yiIkD/Xkmske+uqOxu0f+eDWuTwefI1p/fDNwok/
 SzK0ZkCKPP6NclNOnpkA1dLmQ72DY3jWElhia4TP7bI8q1zzBgE17rc24tlq6c4ODyYc
 gRvs47IAZzGIQFadL+aT8Yp3v91xydY9J9OJhLgnQnWglHIil29HaE6HLkU7U+nGOqnN
 ReN5UpwWIxxhzQ5ZqJWRNQg8/tHB5/XmUsxHsOsAatZ69nYHxzCVJNuTUPCd6902mOTM
 9aRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=8wkwoTKSndKX8U5yRKi01LZXi44nHwK/CPu/et4Fn7g=;
 fh=J6Nx4+n9/xs2TuP7xOZabsmzlILe8CADtPfZHwO+qFM=;
 b=HRkjkCpuN40dQHD3uzMiUrSKTP28q01tnsXGvibZiSLwy8G8cGXMBK/QDu2zXmeX0r
 wI+78v3YrZSIcYmk2qoeJ9R+BXH0Y9jRcUqWVAkTe94FIY15D64qfe28nRGhc1FJNYti
 LAJ5ucZ8wrTBWa6PDtm5g8pon+DlPAAPmx/eNFhreqE3cVzHz1ni1iUYGvRKR5Ku71o+
 2ZLJuoj37rtS1sZ3JprS13uVvWMZGJzmQCYBsRjADmUMmdWd1/H9Gbf5UVKvyy5xg2aV
 Whi9i76Gvo6vQAu6AqSrKdFKeVrYyA/jF3kLXj5Pn/T8EE6MZAudivOlUyHxxVhuzXDN
 Jncw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773112052; x=1773716852; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wkwoTKSndKX8U5yRKi01LZXi44nHwK/CPu/et4Fn7g=;
 b=OT5nDxHjcKuaNfiOvSmg/mkq8u1KNhUHDWpTob+MRnkE+cKihPf1FCKR6TsWQvKAmh
 pGmnkEE6yU/xkLXY8QHGeCYIrNaIBktts0Myx5G776MEMO5PXIK4Lt83aZsoagdm1nby
 OnmA2Qi5OKAGdK24giuMjUMaqQCrm+QU9SomGOGcLL0nnyJR5wjnWXSzVsas84vNaA/m
 JzHZt/HIGFeNsrPyQLgqi7x8/UkAXug30jq5fAUDngiCjUdAQFWpKISGsnpviX/xktE4
 jQ9R0n2l9zHg+F6Ns3/Y+auc6+RRBM80PaW9wdATlpVXBMLRrKr2uGA2IJwck1CeD6oC
 e47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773112052; x=1773716852;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8wkwoTKSndKX8U5yRKi01LZXi44nHwK/CPu/et4Fn7g=;
 b=cERW7hbgEhk7S5aiAscUYuXdn3gVef+URg/vOK9NJPffmWTR+poJFozowrDT2B2Uku
 9bUGMrKJT/Vi43PtFe52ZnZdelx4W+61sc5QCA3YeTidMRH524cNAbAjD5pAS23ZfoRP
 k8f1uz7yVpFlC7cLviZRVO77KKNK4VOq6lBzvVRY/f5pydGw8D5pl9BCn0dAOvmtm25z
 KFgFEj0tKXvd1mASB9JM68I/XM9IpDhzeeRqtH5gk8RXMEsfXIkAy4MH36rFy68uVGui
 +nTr8SQ9dMxEWAZGY2G/ncVu9+h4yIDtJv0rBcATeoakdHPjU+xmhTVdo+YaLBMX0Fcw
 8rTg==
X-Gm-Message-State: AOJu0YzedKs6EYEAxF54vy6/RGCrzHlnTP/YvhX41JZavxc6NTpxty3L
 StWp5gP3WFY4zUcY1C4M5KMvAlyrA2z/qM8sGVd/6qsxxCDvDtKQJUToylHRCm2XscP5RTp2CgF
 hhR8UW4d+R+G/Hp9BTmt30+mv576ZiYDa16ShC4/9+4bT1usvRCl26BioVftI6RrecC4CAisfFY
 rCLiCT6TST99I31fz5UgFfY6QZEPNDtFs=
X-Gm-Gg: ATEYQzxjnZx37OITf6c90bGPnFAwNKITNXmAgM6SK8UfmkohU2LgA1BKNP1L4oFPpxa
 Wq4JpCdVySM4aNsXGTmFAqpr95dcgjdrWjxPX8CQ3VwUVB3yOlRJ0umxXi+sFiSYfSSDwwiKIFw
 FLj+Nk+Z9lwmMqiMh38mfBIfVDEUOf92afRlcqNJyP06clwsLZEVRAdgzE0IqSjF8SLuDDB9fL+
 gvSwMCt
X-Received: by 2002:a17:902:da8a:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2ae82388a53mr117900275ad.17.1773112052115; 
 Mon, 09 Mar 2026 20:07:32 -0700 (PDT)
X-Received: by 2002:a17:902:da8a:b0:2ae:450c:951e with SMTP id
 d9443c01a7336-2ae82388a53mr117900055ad.17.1773112051681; Mon, 09 Mar 2026
 20:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-5-eperezma@redhat.com>
 <CACGkMEukuUcCuTUpYEG5bdWD9dnJDWh2w50vsdhEbF2E=rNsvA@mail.gmail.com>
 <CAJaqyWcTav8BWcRio+w4LYsTtAJSvJBJdeLoTdDBYAmh_2jjLg@mail.gmail.com>
In-Reply-To: <CAJaqyWcTav8BWcRio+w4LYsTtAJSvJBJdeLoTdDBYAmh_2jjLg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Mar 2026 11:07:20 +0800
X-Gm-Features: AaiRm53Fs7zIFnvq4jxpGm_s_pQrwBqcgOR9PjyOj4Oldj7LG8Gt4WGRuuoWVNU
Message-ID: <CACGkMEvOgofeyK-dis2s-=AnGmR5D7fETh5-_oyXOye-8CtWGw@mail.gmail.com>
Subject: Re: [PATCH 4/7] vhost: factor out the get of last used desc in SVQ
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>,
 Jonah Palmer <jonah.palmer@oracle.com>, mst <mst@redhat.com>, 
 Lei Yang <leiyang@redhat.com>, Koushik Dutta <kdutta@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Maxime Coquelin <mcoqueli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
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

On Mon, Mar 9, 2026 at 5:42=E2=80=AFPM Eugenio Perez Martin <eperezma@redha=
t.com> wrote:
>
> On Mon, Mar 9, 2026 at 9:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
> >
> > On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@red=
hat.com> wrote:
> > >
> > > This code path is modified to handle in order devices.  Abstract here=
 so
> > > we can generalize on the caller.
> > >
> > > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 45 +++++++++++++++++++---------=
--
> > >  1 file changed, 29 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> > > index 7adacd4f542a..e7e3c9155cd0 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -444,6 +444,25 @@ static void vhost_svq_disable_notification(Vhost=
ShadowVirtqueue *svq)
> > >      }
> > >  }
> > >
> > > +/*
> > > + * Gets the next buffer id and moves forward the used idx, so the ne=
xt time
> > > + * SVQ calls this function will get the next one.
> > > + *
> > > + * @svq: Shadow VirtQueue
> > > + * @len: Consumed length by the device.
> > > + *
> > > + * Return the next descriptor consumed by the device.
> > > + */
> > > +static uint16_t vhost_svq_get_last_used_split(VhostShadowVirtqueue *=
svq,
> > > +                                              uint32_t *len)
> > > +{
> > > +    const vring_used_t *used =3D svq->vring.used;
> > > +    uint16_t last_used =3D svq->last_used_idx++ & (svq->vring.num - =
1);
> >
> > I think it's better
> >
> > either rename the function name for advanting last_used_idx or let the
> > caller to advance the last_used_idx.
> >
>
> You dropped the list, is there any reason for that?

Acciedentailly, I'm sorry for that. Adding them back.

>
> Sure it makes sense. What about virtqueue_update_last_used_idx? Or
> virtqueue_bump_last_used_idx?

I prefer to allow the caller to advance used idx, or we can listen to other=
s.

>
> > > +
> > > +    *len =3D le32_to_cpu(used->ring[last_used].len);
> > > +    return le32_to_cpu(used->ring[last_used].id);
> > > +}
> > > +
> > >  static uint16_t vhost_svq_last_desc_of_chain(const VhostShadowVirtqu=
eue *svq,
> > >                                               uint16_t num, uint16_t =
i)
> > >  {
> > > @@ -458,8 +477,6 @@ G_GNUC_WARN_UNUSED_RESULT
> > >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq=
,
> > >                                             uint32_t *len)
> > >  {
> > > -    const vring_used_t *used =3D svq->vring.used;
> > > -    vring_used_elem_t used_elem;
> > >      uint16_t last_used, last_used_chain, num;
> > >
> > >      if (!vhost_svq_more_used(svq)) {
> > > @@ -468,33 +485,29 @@ static VirtQueueElement *vhost_svq_get_buf(Vhos=
tShadowVirtqueue *svq,
> > >
> > >      /* Only get used array entries after they have been exposed by d=
ev */
> > >      smp_rmb();
> > > -    last_used =3D svq->last_used_idx & (svq->vring.num - 1);
> > > -    used_elem.id =3D le32_to_cpu(used->ring[last_used].id);
> > > -    used_elem.len =3D le32_to_cpu(used->ring[last_used].len);
> > > +    last_used =3D vhost_svq_get_last_used_split(svq, len);
> > >
> > > -    svq->last_used_idx++;
> > > -    if (unlikely(used_elem.id >=3D svq->vring.num)) {
> > > +    if (unlikely(last_used >=3D svq->vring.num)) {
> > >          qemu_log_mask(LOG_GUEST_ERROR, "Device %s says index %u is u=
sed",
> > > -                      svq->vdev->name, used_elem.id);
> > > +                      svq->vdev->name, last_used);
> > >          return NULL;
> > >      }
> > >
> > > -    if (unlikely(!svq->desc_state[used_elem.id].ndescs)) {
> > > +    if (unlikely(!svq->desc_state[last_used].ndescs)) {
> > >          qemu_log_mask(LOG_GUEST_ERROR,
> > >              "Device %s says index %u is used, but it was not availab=
le",
> > > -            svq->vdev->name, used_elem.id);
> > > +            svq->vdev->name, last_used);
> > >          return NULL;
> > >      }
> > >
> > > -    num =3D svq->desc_state[used_elem.id].ndescs;
> > > -    svq->desc_state[used_elem.id].ndescs =3D 0;
> > > -    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, used_=
elem.id);
> > > +    num =3D svq->desc_state[last_used].ndescs;
> > > +    svq->desc_state[last_used].ndescs =3D 0;
> > > +    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, last_=
used);
> > >      svq->desc_state[last_used_chain].next =3D svq->free_head;
> > > -    svq->free_head =3D used_elem.id;
> > > +    svq->free_head =3D last_used;
> > >      svq->num_free +=3D num;
> > >
> > > -    *len =3D used_elem.len;
> > > -    return g_steal_pointer(&svq->desc_state[used_elem.id].elem);
> > > +    return g_steal_pointer(&svq->desc_state[last_used].elem);
> > >  }
> > >
> > >  /**
> > > --
> > > 2.53.0
> > >
> >
> > Thanks
> >
>


