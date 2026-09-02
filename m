Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82662C61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1gHL-0002PX-ID; Wed, 02 Sep 2026 04:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x1gHK-0002OT-1Y
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1x1gHI-0003u2-9h
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 04:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788337502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XLuwEcoYlZMRIp51yDsHxNP7hpRb1BmADwZOEKjwdQE=;
 b=Bd7KCmvqFPoQ+WdLfuumCVq6MGWGE276eh8LGDlwOFAnmnixixMmLjz+DHIo4EQ22zPe+m
 jTOM606uWvLXrBYvRmFaOYZZ6qinFwGGjIe3QHRxH8LyWQ7MEcrczgywz2E/7njtVZPBuN
 Qvz8x7c6nwOI0EPJQ19pBfBdWR4cJLk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-1yiaXhGCPVCpfkuwQVroQw-1; Wed, 02 Sept 2026 04:25:01 -0400
X-MC-Unique: 1yiaXhGCPVCpfkuwQVroQw-1
X-Mimecast-MFC-AGG-ID: 1yiaXhGCPVCpfkuwQVroQw_1788337501
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-836c9f68dcbso14227677b3.0
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 01:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788337501; cv=none;
 d=google.com; s=arc-20260327;
 b=ChU1uIiuIePZCTO1nr3uHelXtpZbYLFF4Gi9/XdiSqgomtIllVKe4MoPn9HV1oTugt
 ux0e8g9BTw/tfp1RE8jpc6yHFSmaQWVFGGY3myogKhc3y+N66EFU9v+1Fxg1hlglcblQ
 3fsM9JCrXjwH7AA8b0Y/WJko+HziqydmHlIpjhE8LrTU45FG8IS2KPaiwi9hH9w3TJjR
 CzbXTGT1/i1oNCBdKHwfzBdsW/YlaPlS+qt5AovXIITLj78voqkt1CpLAdVenuOXrB1e
 cJN9Om7Q+/50aKMacHhd6cUaaRoZhijyNIStg0pvbZ9Oj2bfwJVd2w396bx6kQl3ksiK
 BPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=XLuwEcoYlZMRIp51yDsHxNP7hpRb1BmADwZOEKjwdQE=;
 fh=/uQsA1nztRly18whC4qXbdXOIbYQRCHEZ2f6z0YuUOc=;
 b=dfgqUI0Vc1EYx755g23tsaMu/RoxzzCxbhgDxFyp91tj9LVuZAclDpcyH5DuSA2AMU
 wpt5msyy5/nSj8VinB5lA6DVW1Fj2JHtpjOwnGma7D/2kWmbeEnhouDsm5diN2onJEUN
 HvR3ZNzx3urGNlREFcnfKodNWVLz8ghCeByN+xYmsGjGJYIB/MA26nyRtBCGrfGM4n/X
 Dy+Th2rAPpMzS5+Vrm6KAZ2jr1hlhmpRe6yCOcxBTysHZ402wnqoAsPzhStAZIfW0S7d
 z06kxOLC8zEs7V+UxmuX3skVG7adMca/1jFSiY0afOKdhybhyGXIxzwL4U0HKM/e6boi
 MDRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788337501; x=1788942301; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XLuwEcoYlZMRIp51yDsHxNP7hpRb1BmADwZOEKjwdQE=;
 b=a3ogLWZ11UfM/xtQADRzJ84eQlHkDQwB2UeMbuS65khwdRIYTcNGSfCxIyFCcAPc+A
 pdVvZSU6coXEBQrTSpbCIQdXAZkaCPnW3n2zW266zxLgHuc3q3upFNGTncn8l7IVSaC5
 RPkCctbOxiNOlOBM5d4Vq+XWvary7UL6HMMBJWOShNKvDH1Ncrqcyi7F8RW0apDlIDNj
 NRVpZQb9EmhwETVpaJ/IRKeN7hvYydwrYJu3H/+rwIdBh4262TzV8bRRUQ0QQz/tYDfK
 hcTU3xBiBJlM1wcvatMFdM3uc2xeMYlU5BXVIRnZsddSO/C7hg5OEdBNRzSdZrIWkT6U
 YlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337501; x=1788942301;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XLuwEcoYlZMRIp51yDsHxNP7hpRb1BmADwZOEKjwdQE=;
 b=J10DA1oCQgvYmThU0L8oGZOjzrTe0sPZdwT0MXI0n0gb31cCGoqwUnVLIBSO/n0nXU
 zbY/W+Dg8ENVuNxC/J4PT5pjgSfXynlKn+7eoofIqm0J0wn0+mKbMAaHunuJTJf2PXY6
 Ho4CutSDfESXMdXNxAOid10s4jQ+KM2AM33LQiYXup/mqbpb6cguVkjxBeCVmSXsK/Mg
 BMkUTyonAuKNfd0+IMDbFPnmENE//QwRWmPCH7ft3ko5YfXzCVjhfZJ3BiwNPBVgAMZI
 tfDqeLBjNzcw3YIxmXup6bv16Vb72QMzj0TQOKW9fD2qx6Q0hTSD6olGHEuVmbJwEKbA
 qv9w==
X-Gm-Message-State: AFuF++m+Qvy7D3omefUcgXp/I+zXW0JlMrUBSeSraNzVXMd4Hi8/wZRC
 KMkoul3ViqgksZDsNwNh72smomz4btKjbbFER7NoGRSEmysTtCfxMIQNNKONE+xzBfBAb9+xVjD
 2R7BtFeN4Dpju8+N1z8ffHx5QGTivyCM+2wHPjjniQ7adWTZ0v8D/1wv5pCMoCtBMoG1B06P3RT
 WB7u/hdmLWgURz5opV/C8vhE5MsaXJaC4=
X-Gm-Gg: AYBFou35nKnyzpGRBV34elbecPM2EuGO0POEXNMEUBKyp9k8MWmYcE/AcoKvTN4mERk
 YsVp9j6ofk+bkPybYUhcoWeyAhXXkb0qBG/gywfbafSIycFh+SPtLz/q/TktBYstrLWnitfQjJb
 r7qePLiN75R/91wqMiekdhW3B/IefI6HssK8ECrLBWdVR1RQqFdyYOR8/H9XqzuXYbzDl7bPkjN
 6/pPAuH4XUsCZDxUULqVbva1PDFueIHN3MUjnJxW4R/cGFV07L+N+cWsIg=
X-Received: by 2002:a05:690c:85:b0:81e:abe2:e01b with SMTP id
 00721157ae682-86c54546feamr14084897b3.26.1788337500637; 
 Wed, 02 Sep 2026 01:25:00 -0700 (PDT)
X-Received: by 2002:a05:690c:85:b0:81e:abe2:e01b with SMTP id
 00721157ae682-86c54546feamr14084257b3.26.1788337499500; Wed, 02 Sep 2026
 01:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
 <20260817-vhost-user-isolated-memory-v2-5-948aae960abb@gmail.com>
 <CAJaqyWcO3bSakzykPr-p=eBrqntNaTdUuvZdo2-B_DVxrt6wjw@mail.gmail.com>
 <CA+spn3pSp6ZEnF+Y7_ukirg570QX8Nwa71fPEw=02h3_k3r6jw@mail.gmail.com>
In-Reply-To: <CA+spn3pSp6ZEnF+Y7_ukirg570QX8Nwa71fPEw=02h3_k3r6jw@mail.gmail.com>
From: Eugenio Perez Martin <eperezma@redhat.com>
Date: Wed, 2 Sep 2026 10:24:21 +0200
X-Gm-Features: AcwNN1VFs3JiV82m8NsHxkJ5WoGL26ISmwsJoyVHQSjMN_WVexonJK0rZLR1tLI
Message-ID: <CAJaqyWfeMEznFZvJwNXVD=01=u7Mk-4qJZ1LChPGFgUh3TrOqA@mail.gmail.com>
Subject: Re: [PATCH RFC v2 05/13] hw/virtio/vhost-shadow-virtqueue: specified
 vring placement
To: Connor Kite <connorkite@gmail.com>
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
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Sep 1, 2026 at 9:10=E2=80=AFPM Connor Kite <connorkite@gmail.com> w=
rote:
>
> On Fri, Aug 28, 2026 at 5:16=E2=80=AFAM Eugenio Perez Martin
> <eperezma@redhat.com> wrote:
> >
> > On Tue, Aug 18, 2026 at 7:12=E2=80=AFAM Connor Kite <connorkite@gmail.c=
om> wrote:
> > >
> > > By default svq vrings are placed in an anonymous memory map. As svqs
> > > will be leveraged to enable memory isolation in vhost-user, it is use=
ful
> > > to be able to place the vrings in a shared isolation memory region.
> > >
> > > Adds the option to specify vring placement by providing a vring base
> > > address before starting the svq.
> > >
> > > Signed-off-by: Connor Kite <connorkite@gmail.com>
> > > ---
> > >  hw/virtio/vhost-shadow-virtqueue.c | 69 ++++++++++++++++++++++++++++=
++++------
> > >  hw/virtio/vhost-shadow-virtqueue.h |  8 ++++-
> > >  2 files changed, 66 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-sha=
dow-virtqueue.c
> > > index 496e7e58a3..f54a61439a 100644
> > > --- a/hw/virtio/vhost-shadow-virtqueue.c
> > > +++ b/hw/virtio/vhost-shadow-virtqueue.c
> > > @@ -812,6 +812,13 @@ size_t vhost_svq_device_area_size(const VhostSha=
dowVirtqueue *svq)
> > >      return ROUND_UP(used_size, qemu_real_host_page_size());
> > >  }
> > >
> > > +size_t vhost_svq_vring_total_size(VirtIODevice *vdev, VirtQueue *vq)
> > > +{
> > > +    VhostShadowVirtqueue svq;
> > > +    svq.vring.num =3D virtio_queue_get_num(vdev, virtio_get_queue_in=
dex(vq));
> > > +    return vhost_svq_driver_area_size(&svq) + vhost_svq_device_area_=
size(&svq);
> > > +}
> > > +
> > >  /**
> > >   * Set a new file descriptor for the guest to kick the SVQ and notif=
y for avail
> > >   *
> > > @@ -842,6 +849,19 @@ void vhost_svq_set_svq_kick_fd(VhostShadowVirtqu=
eue *svq, int svq_kick_fd)
> > >      }
> > >  }
> > >
> > > +/**
> > > + * Set vring base address if using fixed locations
> > > + *
> > > + * @svq: Shadow Virtqueue
> > > + * @addr: Points to new base address
> > > + */
> > > +
> > > + void vhost_svq_set_base_addr(VhostShadowVirtqueue *svq, void *addr)
> > > + {
> > > +    svq->base_addr =3D addr;
> > > + }
> > > +
> >
> > Would it work to keep that allocation detail in SVQ, instead of
> > letting it leak outside? Something like a flag to allocate the areas
> > with mmap or qemu_memfd_alloc, instead of the base_addr itself.
> >
>
> For the purposes of the isolation mode as it currently stands, I'm not
> sure the allocation can be entirely hidden without adding significant
> complexity.  The vrings need to be allocated in a region that gets
> sent to the vhost-user backend.  If
> VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS isn't negotiated, then we
> are limited to 8 regions in total, so it is beneficial to be able to
> allocate them all in the same region, and in fact, the vrings are
> currently tacked onto the beginning of one of the bounce buffer
> regions so that they don't count against the limit.
>

Ok I see. Would it work if those details are encapsulated in a new
struct, perhaps named SVQDeviceMemory, which all ShadowVirtQueue from
a given device uses to allocate all memory together? It could use that
explanation as a comment too.

I'm very bad at naming things so feel free to rename it :).

> Having said that, a longer term desire would be to update the
> isolation region implementation such that it is no longer organized as
> a 1:1 copy of guest memory in terms of size and number of subregions.
> We would then need an allocator when copying guest buffers into the
> shared region, but it would be much less wasteful, and we could
> guarantee that only 1 region need be sent to the backend for the
> bounce buffers.  At that point, the vrings could be mapped into their
> own region.  There would need to be some mechanism to ensure they all
> get mapped into the same region, but I think those implementation
> details could be kept within SVQ.
>

That would be great, and the work on optimizing SVQ indirect
descriptors could use it too.


