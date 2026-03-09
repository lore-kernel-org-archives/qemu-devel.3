Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10466EFCD71
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 09:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzX9a-0003dD-T3; Mon, 09 Mar 2026 05:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzX9X-0003cP-B5
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1vzX9U-0007xp-JG
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 05:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773049432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=knMHCpJzsKxoXUghOyuD/O900y7IluNeOnvwQLWswLw=;
 b=gIu87SkXzBKifM+Oyc4d0tzo3qbtp/9UtFD5xGPmmF/INgnoMuPjSFuQe7eMecXU/nbROf
 ClNI0B5miwsZtTVU4ezQ/Dq6Urp5iNU/I9Cns83ws+TW5+2bNC7DUCIismYfsidU57WUrI
 lAh50btYiZPdUutFCKoyaI5fl+RGWIo=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-yD32H-2TOBOciztgXqViPw-1; Mon, 09 Mar 2026 05:43:50 -0400
X-MC-Unique: yD32H-2TOBOciztgXqViPw-1
X-Mimecast-MFC-AGG-ID: yD32H-2TOBOciztgXqViPw_1773049430
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-79904eb0d1bso2194087b3.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 02:43:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773049430; cv=none;
 d=google.com; s=arc-20240605;
 b=MUmarmE5iU4CuShLwJd2czrAWNLfFpzBHuWmtFIWzNTSDDwG63cQ1jXms6CstSpy/A
 kDbc+Zzt1A8dpXybcgM6hJ3yIR9ksgxLXbCLnTo7VVPgZAXg4Qcdv4YoZs1+LNY+HeHb
 iOmwh6sYoq8P2dWYXYEiAuOHW7ySuSVvYBmMmPTC/hVCtCdlVpmEMN302lLBrdhcrikL
 YNG9IUNYIzDJSLOFZ0+kq1mFwsmntxLhnT/p1JLzlipv/IfPPCKG7PM5VQCWc44wwovx
 2JXShNxbYqH4QOrr7d4aKUiypucHlv3EKOCycbVNTOBwI2ZqYqHDqboh8DdHWBh4BKY9
 TdFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=knMHCpJzsKxoXUghOyuD/O900y7IluNeOnvwQLWswLw=;
 fh=srKTuQ1zrFvCk697vtO4h473zqLsuvDuubo1BzKDh1s=;
 b=NCkt/CLArdy6EkETIormRLscp+r5M6lpDA0b4ANcYQLuCazHwxL2newPdpsL4YXO2l
 XvnASJDlXG7Ncr9UxLOMgyiguH9J+S4Nfd4CiX5lLkN0I2as/CCJQVINs6UWnz/YGRJr
 PlC/bsplxW2BxR7fBjHExAzpWfge9tH+PrUVatBndR7ME7mgfD1HEnzk6QblpszZBqXx
 y6cdvYoR88xhzvrdOdWsOELw+TbkZJfSNVqlanTLibkNUZFagetd/EPJVf68T9f0bi2m
 NaBuG/OYE55Srg0YM4Cr01dy2T/0uiPeW6yGJ6o2dODinPjDX/wX5i5ulTsOlb+STHd9
 v/Pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773049430; x=1773654230; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=knMHCpJzsKxoXUghOyuD/O900y7IluNeOnvwQLWswLw=;
 b=B/MqBt4re/XeT5z6LW6aAQPUmjw0lOzLhSI6NDJXtRUOqkFOqvOtYGWgYGLLIiaUR+
 u2wX23DuGXdG28q2eS7HhZdMXvriDcxdRJWIk2wgEGFL8MwzmnzwwMLJe3A/SmtmKUbn
 MjcTKiuvoz+Iu0S9BrXYh3P/uPAKvKuL/L2lAARlHtwZ4mRzBao11U0A1TTyiHVy0aYP
 qDP/zdBq9SrgBwwiZCz957jxnDOpZnilQuNNk+EPp/aD4aYuB4OXI8h1IdRX0YMdjIAA
 VUHRZ0PkzxXsJLyCDnSLioWqgJ5MiAEv5BJpSwiFR35oBE15tvJ2zonpuPmcvBsAKNL8
 ME4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773049430; x=1773654230;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=knMHCpJzsKxoXUghOyuD/O900y7IluNeOnvwQLWswLw=;
 b=l2XaYpHXKzG59278nilMhobQwdMECa79ZrzTfvSIFlvp10onKjJPjKTdn58NnputP1
 /FJiRmHJcexYNbx7LEBFtAKN9om+k8pXMqlOmGQWrumvp4PRKuWiiKTpgACSzirimLJd
 xJ+JJvHxoiTug4+5Q0FUGZDLHJUVcZ0TS/tImqOfbqnmdNSStCYnE8Sid9HEwXS3nMnF
 fINWA/qAiUhbP//ybSgYrvSdeyxsBCyKUqJjniHyYf0IbIppX4QA5NqarjDSTm3qt16w
 tndpVWPU5OtkdhVlXXRkYXsWZBejGgxicYTVNRyvqOVzuqJBAkrGww7U9UA2MtxwuOOc
 SuuQ==
X-Gm-Message-State: AOJu0YyU7x195r6ZbRCRa1H+TK4kMiWJWbZvsWwOa0ANyMsZ9Th8WBhh
 Rgf5wvp95nVyA218StEGZIoyFz18FmK38W8+LiB8Ls+flu2AIUcEn7PSl+Rd2m7211cp2fNrQ+s
 1mgDgH7nHSj9CrEwNweAUo23ytGKqiVbmTn/3e9I7ExNU5ms8+CCN6KNp/ohceFKAprfcuguM+s
 f7HbpWgkK8xInoDlcGLGqwLNC3zc4mOJw=
X-Gm-Gg: ATEYQzwWq1yJC2bLke6jbyzPy8oxUUBdJB9aU2r2RSa+2nL0/e3PhZlHmyyjBWik1/K
 8q+kIxgqMehGpCfQRJ6avNQV9q+pYv1ByooXJEZXFv68AoKJtLgRx99PIPTQ7QfPGYLTm1NjaSB
 VuVKkkXQZ9TsOD5Q4FhxccyO3SqSeVBIrGibhtHsbYvYVumtsg/EKgpqVPsibSyU4aWjI9Pxyvc
 WRwsw==
X-Received: by 2002:a05:690e:e17:b0:649:b9f4:c536 with SMTP id
 956f58d0204a3-64d142fedb7mr7226668d50.73.1773049430320; 
 Mon, 09 Mar 2026 02:43:50 -0700 (PDT)
X-Received: by 2002:a05:690e:e17:b0:649:b9f4:c536 with SMTP id
 956f58d0204a3-64d142fedb7mr7226653d50.73.1773049430006; Mon, 09 Mar 2026
 02:43:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260304173535.2702587-1-eperezma@redhat.com>
 <20260304173535.2702587-6-eperezma@redhat.com>
 <CACGkMEsCDDSV1m9-2cz3SGEh=MB0viA6h5a9vF5BCHPEhadfUQ@mail.gmail.com>
In-Reply-To: <CACGkMEsCDDSV1m9-2cz3SGEh=MB0viA6h5a9vF5BCHPEhadfUQ@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Mon, 9 Mar 2026 10:43:13 +0100
X-Gm-Features: AaiRm52vEgNHznDwzVWVegwWsBvw2DSsHrZKW6A5PS-ZSg6P4BjnssmaXBVFF9A
Message-ID: <CAJaqyWdPbU3HXxsc-e4+K_CBPtnYZzbW8vrQJYK-nSUu35LtWg@mail.gmail.com>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
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

On Mon, Mar 9, 2026 at 9:57=E2=80=AFAM Jason Wang <jasowang@redhat.com> wro=
te:
>
> On Thu, Mar 5, 2026 at 1:36=E2=80=AFAM Eugenio P=C3=A9rez <eperezma@redha=
t.com> wrote:
> >
> > This code path is modified to handle in order devices.  Abstract here s=
o
> > we can generalize on the caller.
> >
> > Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > ---
> >  hw/virtio/vhost-shadow-virtqueue.c | 24 ++++++++++++++++--------
> >  1 file changed, 16 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index e7e3c9155cd0..2d8fc82cc06f 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -473,11 +473,24 @@ static uint16_t vhost_svq_last_desc_of_chain(cons=
t VhostShadowVirtqueue *svq,
> >      return i;
> >  }
> >
> > +G_GNUC_WARN_UNUSED_RESULT
> > +static VirtQueueElement *vhost_svq_detach_buf(VhostShadowVirtqueue *sv=
q,
> > +                                              uint16_t id)
> > +{
> > +    uint16_t num =3D svq->desc_state[id].ndescs;
> > +    uint16_t last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num=
, id);
> > +
> > +    svq->desc_state[last_used_chain].next =3D svq->free_head;
> > +    svq->free_head =3D id;
> > +
> > +    return g_steal_pointer(&svq->desc_state[id].elem);
> > +}
> > +
> >  G_GNUC_WARN_UNUSED_RESULT
> >  static VirtQueueElement *vhost_svq_get_buf(VhostShadowVirtqueue *svq,
> >                                             uint32_t *len)
> >  {
> > -    uint16_t last_used, last_used_chain, num;
> > +    uint16_t last_used;
> >
> >      if (!vhost_svq_more_used(svq)) {
> >          return NULL;
> > @@ -500,14 +513,9 @@ static VirtQueueElement *vhost_svq_get_buf(VhostSh=
adowVirtqueue *svq,
> >          return NULL;
> >      }
> >
> > -    num =3D svq->desc_state[last_used].ndescs;
> > +    svq->num_free +=3D svq->desc_state[last_used].ndescs;
> >      svq->desc_state[last_used].ndescs =3D 0;
>
> Any reason we don't factor those two lines?
>

They are common for split and split_in_order case.

> > -    last_used_chain =3D vhost_svq_last_desc_of_chain(svq, num, last_us=
ed);
> > -    svq->desc_state[last_used_chain].next =3D svq->free_head;
> > -    svq->free_head =3D last_used;
> > -    svq->num_free +=3D num;
> > -
> > -    return g_steal_pointer(&svq->desc_state[last_used].elem);
> > +    return vhost_svq_detach_buf(svq, last_used);
> >  }
> >
> >  /**
> > --
> > 2.53.0
> >
>
> Thanks
>


