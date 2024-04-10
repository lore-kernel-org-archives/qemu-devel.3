Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C35D3CD11C2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 05:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruQYx-0001yk-Hb; Wed, 10 Apr 2024 01:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruQYu-0001yQ-AR
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:31:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1ruQYr-0007Rp-PO
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 01:31:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712727112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nt3CidV3gatvPPl3Rfi5s/Onsgb/OnUB6e1aJkS0R1c=;
 b=UElR4uI15Xigoc8A2HHOxHX7sX27FcmrFPch2OpVklMHBTWXflU23ZrxWMlNy6uWbJ0k4b
 iPCnNoxvet9mvr0FpWJo2OxeGWW7S7gm4Zev7FJn1nzJ23mqZBEIj/0YG8mIZsSrQKN/P/
 x8xDsVAhHqKZD8GV4OP2v2ivEd/+3Kw=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-fVsCZwQsM22MGMrvpBinuQ-1; Wed, 10 Apr 2024 01:31:51 -0400
X-MC-Unique: fVsCZwQsM22MGMrvpBinuQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-dcc0bcf9256so7941721276.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 22:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712727110; x=1713331910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nt3CidV3gatvPPl3Rfi5s/Onsgb/OnUB6e1aJkS0R1c=;
 b=ER3q0R2HUH2BoiJOKI4Z2Xb82R8NY+ctcsjRX6dJf0nYcOV3IbqWhe6VEieGxL3lFz
 41zJXodAZJvX5FJLmvindTsc2UyMkGNij0Iv4xpj9kIVHJinspOzi+WRtrhq1pW/V6gA
 /zvPRxZhfSyMgcdhKbwtkis3ive18J/GvfHWe79GIyR/1Sspx/GxTZT/Iq9tndOGBPE4
 A2K3ePT+MTs5IQsstZZoQJ/RAQPzNqWnicldIS864cA94twxgB6KRbHufhlEMPRXtC82
 PuN+xhzkHzgQXut2ZtQI8NOb2wG1cd0cfDtNGTXAeXNx2dpieRE+GpyFxxlAPEyf1Be/
 7R4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEv8Ey2+wS/IquQ2ohKCVudGVhdOwC9Q0YI0xwG0jppLUJ+XRkx/yJRKA3+op4lszhV9yytHLyqDqfCsePjLM/j3xkNz8=
X-Gm-Message-State: AOJu0YyACvoPSQ70eTIm3uq825uqS0Z8qEF4OrsgITvooQU1yT/iA34o
 oOYrra2+wJnOQs4Op9mfZrz4uBkBiDVv6EWErJPN/c93qGOqC8sLYE6w5mC1w3BhITGWUGEpSWM
 hD+nPv9Zjg4r4+uSdnp4xdY73Acc0JDzcz3KkGdY4fGx7P/jzGNdbqONPBdf1opfPh+rhwib8fK
 OZggvxx7Ulk9vZeZf8UGIsNAaryLo=
X-Received: by 2002:a25:ae45:0:b0:dd0:467:2e48 with SMTP id
 g5-20020a25ae45000000b00dd004672e48mr1768274ybe.40.1712727110435; 
 Tue, 09 Apr 2024 22:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbkansYxJkCZ07jq3xAXum7ULLbR6sH0yVlNshDh8XiBSeGrNVeoDAcaxFzgcz6+GyCX1nu7m/9pDPJyOeKEg=
X-Received: by 2002:a25:ae45:0:b0:dd0:467:2e48 with SMTP id
 g5-20020a25ae45000000b00dd004672e48mr1768269ybe.40.1712727110119; Tue, 09 Apr
 2024 22:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1712647890.git.mst@redhat.com>
 <2d9a31b3c27311eca1682cb2c076d7a300441960.1712647890.git.mst@redhat.com>
 <dd05e66b-1437-4293-b8b6-76b717e70c07@tls.msk.ru>
In-Reply-To: <dd05e66b-1437-4293-b8b6-76b717e70c07@tls.msk.ru>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 10 Apr 2024 07:31:14 +0200
Message-ID: <CAJaqyWc-yEa7NKE1-nE9TS0A_-iqXDdoawGaibMLn5ZMUXBrcA@mail.gmail.com>
Subject: Re: [PULL 4/7] hw/virtio: Fix packed virtqueue flush used_idx
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Wafer <wafer@jaguarmicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 9, 2024 at 7:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 09.04.2024 10:32, Michael S. Tsirkin wrote:
> > From: Wafer <wafer@jaguarmicro.com>
> >
> > In the event of writing many chains of descriptors, the device must
> > write just the id of the last buffer in the descriptor chain, skip
> > forward the number of descriptors in the chain, and then repeat the
> > operations for the rest of chains.
> >
> > Current QEMU code writes all the buffer ids consecutively, and then
> > skips all the buffers altogether. This is a bug, and can be reproduced
> > with a VirtIONet device with _F_MRG_RXBUB and without
> > _F_INDIRECT_DESC:
> >
> > If a virtio-net device has the VIRTIO_NET_F_MRG_RXBUF feature
> > but not the VIRTIO_RING_F_INDIRECT_DESC feature,
> > 'VirtIONetQueue->rx_vq' will use the merge feature
> > to store data in multiple 'elems'.
> > The 'num_buffers' in the virtio header indicates how many elements are =
merged.
> > If the value of 'num_buffers' is greater than 1,
> > all the merged elements will be filled into the descriptor ring.
> > The 'idx' of the elements should be the value of 'vq->used_idx' plus 'n=
descs'.
> >
> > Fixes: 86044b24e8 ("virtio: basic packed virtqueue support")
> > Acked-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> > Signed-off-by: Wafer <wafer@jaguarmicro.com>
> > Message-Id: <20240407015451.5228-2-wafer@jaguarmicro.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   hw/virtio/virtio.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
>
> Is this a -stable material?
>

Hi Michael,

Yes it is. It should be easy to backport but let me know if you need any he=
lp.

Thanks!

> Thanks,
>
> /mjt
>
> > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> > index d229755eae..c5bedca848 100644
> > --- a/hw/virtio/virtio.c
> > +++ b/hw/virtio/virtio.c
> > @@ -957,12 +957,20 @@ static void virtqueue_packed_flush(VirtQueue *vq,=
 unsigned int count)
> >           return;
> >       }
> >
> > +    /*
> > +     * For indirect element's 'ndescs' is 1.
> > +     * For all other elemment's 'ndescs' is the
> > +     * number of descriptors chained by NEXT (as set in virtqueue_pack=
ed_pop).
> > +     * So When the 'elem' be filled into the descriptor ring,
> > +     * The 'idx' of this 'elem' shall be
> > +     * the value of 'vq->used_idx' plus the 'ndescs'.
> > +     */
> > +    ndescs +=3D vq->used_elems[0].ndescs;
> >       for (i =3D 1; i < count; i++) {
> > -        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], i, false);
> > +        virtqueue_packed_fill_desc(vq, &vq->used_elems[i], ndescs, fal=
se);
> >           ndescs +=3D vq->used_elems[i].ndescs;
> >       }
> >       virtqueue_packed_fill_desc(vq, &vq->used_elems[0], 0, true);
> > -    ndescs +=3D vq->used_elems[0].ndescs;
> >
> >       vq->inuse -=3D ndescs;
> >       vq->used_idx +=3D ndescs;
>


