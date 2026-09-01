Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D6FC624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:11:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Trt-0008WA-CH; Tue, 01 Sep 2026 15:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1x1Trp-0008VW-5j
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:09:58 -0400
Received: from mail-qt1-x82e.google.com ([2607:f8b0:4864:20::82e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1x1Trn-0004Qa-J9
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:09:56 -0400
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-517dc520840so1415901cf.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 12:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788289794; cv=none;
 d=google.com; s=arc-20260327;
 b=l/QHvDDdLSz3/7THiKoVaSRctmpG36BR/++mbbu0bemG6Z62NRh8Yql4RWYIWh0MAX
 Fw2z2stXW9USeWOwIC6ArgOV6l0RvHVsCn3E4hrxXff222rBBL9zQTpuFYX+/mIRxMbb
 A4n/G6t033pKMQXiMSJD/n3OO19nbgH2PClN92yIL+iXB8xvPpnkVVlJbROuQAk69z5s
 N4w/puGwbX1a8ODUPpwhDdnE+Hka9ggYj7ss46BO4GJLdeWZrv3nbTPXSCd6FPZAgYob
 J8Iz9v48Ibm3d654Q3a23xrM7rgLRaZax1FPFQwzb9eBFi95U6WEAQzZOVzYOJj/2kVX
 PrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LzrY3kQLyl1dbjndSKm2x24o7tAe9NeimDIm782FwvM=;
 fh=IbDIADSBmbZ3w+f1dYc7m/52zEuUum72SMMs1IAUQzc=;
 b=TYw0B3nIV923XpSWFfwav61ejXmp14WxqqU0Ua644CUsXuE++KYsS/VQeNDtwpLqls
 XEUQUZZZyD8613pe4k1AXhEJsOgaktqf3AxP24j91i4FbiNeo/oM67Mxndu0aa7Dxzqf
 ggGe0uQwsmvSU9zgSgEDgfXOBhUx/BSeWAfVGCaL30CImD41IeK9qstQzKceyBNhKKKR
 nZzq+T708XIdAOD1WSkM3youopE3V7CEs/JVOslzCZZpmVrHroH8LtloS4yUEkAzy0Tw
 PtrIL+qHgTga6vhYGp0KFDDgTYmJcnLM9qjRl3dEAV7Z/ddI1s7IPzYBHcT6+sTjDMlR
 2P0A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788289794; x=1788894594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=LzrY3kQLyl1dbjndSKm2x24o7tAe9NeimDIm782FwvM=;
 b=RnRl06KzhUVz9hetPIDTcxz6KXc6L0BYoll7jqKSs64vRKoCiSXFf+yY/HzinmHppQ
 o9LoLxAe9zYlVqmU/F5bjK/jzKyqgjHm4kt8UxaY1ZTswTdPd2oeWK0J4p+uXHUfKVba
 2qQc8Iw1KlkYK5xaCsB0JEvjHzqMDnZP5RtQBiwVC14CfNxB+WV7ynV+YlSuK3HfG732
 c4p9zOCm042RmEAmXppZVdSQs9ENHlkl5asl8aaK08SgM9gRAAyQjfJz/rG8pFFhtKBD
 ywkSyeIi2Sw5Lq40uyZ+nmQTcV5lJzEtMaWQapf441ELPoRtwL119LYGoKNgxhjhYS4a
 hpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788289794; x=1788894594;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LzrY3kQLyl1dbjndSKm2x24o7tAe9NeimDIm782FwvM=;
 b=sDfabA0GMC7eaWbPcJwP/3aI/T+v40gaQK1TDJHuz58YalZtJDszU1riSwbjMuHTS1
 /rrgIU/a5fUvxtw53oi7qmI45pRVV+IzmJF9NKPt1lqfYvC4akvBvMOhid7zAvTc7tkl
 SH7y/G07sewaQHzC2WXOuiGCOfvnak/bpG7EOjVJgiE6FYFdUhZELLt2jzhCYSqUDRDm
 xWkY8ykMevfMlQ38olT+z7umpgCBWRmjKdGhlIJHee7tpfAQ0p55qChpWKWWFhM3FjWe
 Q3T9nOL6lkvqXAysVP3po4UbOkSvcSCXk7JfPp7L1L6Hx2UOhVef7RlnpTS/v7CjjX2s
 7EBQ==
X-Gm-Message-State: AFuF++loqyfWyBiKDSQ18vu4ehSUi7Qwd82/uSZharnlKb2aelzB52c+
 T6vZxDQPlFd5DB33NGncg6edK2LTJmyyqkzhHLe0MYY6n4AninBeRNhKEd9jBRxYNolOR8kqqN2
 JQ7ihVBUi4KNDp/klBF4jeMa5hhd6RWQ=
X-Gm-Gg: AR+sD11dplRSYvqLV6GjyYuTkX9H/Q9G5W2VDYusIlLCTEb/mqLzdEH5YgLOCj6aR/w
 YhevAuFAvKURMVFHV/I8qcVD7WVRmFI0ri2jQtJKefxS/YXClUHiVD/DgUKSJGRCbCUDLLobLa2
 rJ7JkdQKQ7m6H+S4liMPyJoysyhDgL2SZV2dvpYX6pug95gmxLWaZ69GWpfHp73kGbZgsS40QiO
 3uVYxhSBwXpSJAR0z3X03NLlsXb5Hvvmp3a+NtcwwKNGogAw3vm6uC5tScx9fM1vKOWBj2N3BSh
 j8CMgpsJf43AWEajSf1MLPzmreY9AWZ7bN3dTTd7qiVb8qLovB8WOfI9AM26fpNxA7pYzhq6EMa
 l+3+iwig1TUehug==
X-Received: by 2002:ac8:5702:0:b0:52d:cf85:aeea with SMTP id
 d75a77b69052e-530342b8cddmr5193391cf.24.1788289793744; Tue, 01 Sep 2026
 12:09:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
 <CAJaqyWcO3bSakzykPr-p=eBrqntNaTdUuvZdo2-B_DVxrt6wjw@mail.gmail.com>
In-Reply-To: <CAJaqyWcO3bSakzykPr-p=eBrqntNaTdUuvZdo2-B_DVxrt6wjw@mail.gmail.com>
From: Connor Kite <connorkite@gmail.com>
Date: Tue, 1 Sep 2026 12:09:42 -0700
X-Gm-Features: AcwNN1XNCKTlqjQGZhm19tCi0YpaqKL7VfH06S3TiO1xT5RaoJw_SlMzUkJivoE
Message-ID: <CA+spn3pSp6ZEnF+Y7_ukirg570QX8Nwa71fPEw=02h3_k3r6jw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/13] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Raphael Norwitz <rnorwitz@nvidia.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, 
 Peter Xu <peterx@redhat.com>, Alyssa Ross <hi@alyssa.is>, 
 Demi Marie Obenour <demiobenour@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82e;
 envelope-from=connorkite@gmail.com; helo=mail-qt1-x82e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 28, 2026 at 5:16=E2=80=AFAM Eugenio Perez Martin
<eperezma@redhat.com> wrote:
>
> On Tue, Aug 18, 2026 at 7:12=E2=80=AFAM Connor Kite <connorkite@gmail.com=
> wrote:
> >
> > By default svq vrings are placed in an anonymous memory map. As svqs
> > will be leveraged to enable memory isolation in vhost-user, it is usefu=
l
> > to be able to place the vrings in a shared isolation memory region.
> >
> > Adds the option to specify vring placement by providing a vring base
> > address before starting the svq.
> >
> > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > ---
> >  hw/virtio/vhost-shadow-virtqueue.c | 69 ++++++++++++++++++++++++++++++=
++------
> >  hw/virtio/vhost-shadow-virtqueue.h |  8 ++++-
> >  2 files changed, 66 insertions(+), 11 deletions(-)
> >
> > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shado=
w-virtqueue.c
> > index 496e7e58a3..f54a61439a 100644
> > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > @@ -812,6 +812,13 @@ size_t vhost_svq_device_area_size(const VhostShado=
wVirtqueue *svq)
> >      return ROUND_UP(used_size, qemu_real_host_page_size());
> >  }
> >
> > +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq)
> > +{
> > +    VhostShadowVirtqueue svq;
> > +    svq.vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_inde=
x(vq));
> > +    return vhost_svq_driver_area_size(&svq) + vhost_svq_device_area_si=
ze(&svq);
> > +}
> > +
> >  /**
> >   * Set a new file descriptor for the guest to kick the SVQ and notify =
for avail
> >   *
> > @@ -842,6 +849,19 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqueu=
e *svq, int svq_kick_fd)
> >      }
> >  }
> >
> > +/**
> > + * Set vring base address if using fixed locations
> > + *
> > + * @svq: Shadow Virtqueue
> > + * @addr: Points to new base address
> > + */
> > +
> > + void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr)
> > + {
> > +    svq->base_addr =3D addr;
> > + }
> > +
>
> Would it work to keep that allocation detail in SVQ, instead of
> letting it leak outside? Something like a flag to allocate the areas
> with mmap or qemu_memfd_alloc, instead of the base_addr itself.
>

For the purposes of the isolation mode as it currently stands, I'm not
sure the allocation can be entirely hidden without adding significant
complexity.  The vrings need to be allocated in a region that gets
sent to the vhost-user backend.  If
VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS isn't negotiated, then we
are limited to 8 regions in total, so it is beneficial to be able to
allocate them all in the same region, and in fact, the vrings are
currently tacked onto the beginning of one of the bounce buffer
regions so that they don't count against the limit.

Having said that, a longer term desire would be to update the
isolation region implementation such that it is no longer organized as
a 1:1 copy of guest memory in terms of size and number of subregions.
We would then need an allocator when copying guest buffers into the
shared region, but it would be much less wasteful, and we could
guarantee that only 1 region need be sent to the backend for the
bounce buffers.  At that point, the vrings could be mapped into their
own region.  There would need to be some mechanism to ensure they all
get mapped into the same region, but I think those implementation
details could be kept within SVQ.

Thanks!
Connor

