Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4688DC531F8
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmvrV-0006aK-EJ; Thu, 23 Jul 2026 12:01:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmvrJ-0006Ni-SI
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wmvrG-0006om-FY
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 12:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784822471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0JRemlS41+9KXLA3WnK0nzBLgkObM084kzCwYu9I5kA=;
 b=badIsUQgCrTYxZCHuTU7vaI9IQG8UbSkhzIkL7ThkqJzc+r+DliZlOgoZJIBgSEBmuY+AC
 McTBDnlwu98QSwQaMkaEyghFwrrgKEy0Q4A3IbHyW4AtzQEY8zUfb3t361Nd0W+o8koew0
 TAEduJSFR2C6ck+s2ntIU5SVZMDGja0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Ky5KoZlePKSlxdKnfePC5Q-1; Thu, 23 Jul 2026 12:01:09 -0400
X-MC-Unique: Ky5KoZlePKSlxdKnfePC5Q-1
X-Mimecast-MFC-AGG-ID: Ky5KoZlePKSlxdKnfePC5Q_1784822469
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49554715277so8687555e9.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 09:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784822469; x=1785427269; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0JRemlS41+9KXLA3WnK0nzBLgkObM084kzCwYu9I5kA=;
 b=ZQevVxhSft17v01odNB/JZITvz5tevkqtPToUtNBzN3BDQSZPZq7hCD+rHOEOlgUKD
 iJGZYtcMyL9of5q5K3fqPEhVP2KDa1Rg2/HuNfTMvMavw7xS7AnOpi/onpXIuV8kQigm
 lxyHNMgb03Aj+UOZok0tRQLbKot3nW5y5MQkvcnAI+szo3OG92WmxEjiI+nirg++h3NM
 qjjwAAT+VISqm1b+ZN1ckik4PQrQJZj3kE/ja0fHfW8DqevT2BidhGg/0/a8rmNwiirj
 QQWvGDV/gkkclz+wutaDSRfPTipKwTu0WvMZj5jCOvgspkNVvoacII+DO85SDs5wjuNx
 5K0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784822469; x=1785427269;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0JRemlS41+9KXLA3WnK0nzBLgkObM084kzCwYu9I5kA=;
 b=COZUi3MAdA0d4D7pQI8z3OFMEjQEsQEyKSCilJ2TYvRxiuXZeW+D1Yy0SR94NbUrkk
 ccEL6ngLRyahkaqKDvRTJL5LYYWqcAYww/l3C4Q+kEEJbmkXrUuarvAUzRyprcd1KodS
 wToTq3CYtkIBwfoR1KM1O0k8yt4Qx+Cp0VxK4/Bhwplf+1xcm63WAayikN3isDknMQCO
 Tep+SToE1lVMag7beyM9MPPBGYxulOK8YgTiXtXSrho6lj4365L7tm1FjlPRhhcNvBP/
 Tj8bBQU8dhOjb+/Vhp9g5AxIhnMDBqj7PZqvY2EGj3Fn+XqZ4TEUodDjwTqoKz/QNw0I
 ly3A==
X-Gm-Message-State: AOJu0Yy1jx3efjyswV9rZPIZFwLJK46NqAqXfVEkNA0rdloux3XRDnAg
 Sgg7qqNrYfAlbinZaqiqe4xQ4VsyKb9xx4EYob7cMhLwQi7Nra/GJDY/cpOVYzh50g6Bp8Ho+nt
 YaMaUjiI9b0Tw11ZOFLQpzNOOOgUfFLrcVF9dR+IE5VkSOiS+qNDKP9bV
X-Gm-Gg: AR+sD10PqDgZHMNaUbWHKj8f7rVB4QSIBCyxQrIcpP5HayuwWxEKMIS/CVXYxp6XOtj
 VDqROluAWQLNHRWTwXshZ24t3uKYUe5kTiwPJfFmgTxpbDRHY/fZ0VoaCv34vdv6rAcJGq4RDTj
 s03DFiwqnwVVYeblqjA2Ao8qi+bBUNivrgR5HQGpWruBaBvri2ghmNiFX+HIA/8NKNdfCdePaPm
 xsuTduugCIo+xo7W1W9KjjfmO8uViBGMxLMsRjvQcVIlJ0ovJyt+7nYd5/SU0ilx7fZuKoubU9Y
 8Cjthpmlu5NskoZZBeHrVJxo+ynbxt5KOEmEWgmy7f+6Hvw8F0hhQQXmVBCLP24ugetUDVKaP6O
 RaEMpPlRIg1tS5H3rU21gGw==
X-Received: by 2002:a05:600c:350c:b0:493:ece1:86b9 with SMTP id
 5b1f17b1804b1-49573cc1222mr42940055e9.8.1784822468551; 
 Thu, 23 Jul 2026 09:01:08 -0700 (PDT)
X-Received: by 2002:a05:600c:350c:b0:493:ece1:86b9 with SMTP id
 5b1f17b1804b1-49573cc1222mr42939405e9.8.1784822467851; 
 Thu, 23 Jul 2026 09:01:07 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afb9b29sm2827715e9.14.2026.07.23.09.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 09:01:07 -0700 (PDT)
Date: Thu, 23 Jul 2026 12:01:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH] virtio-iommu: fix OOM due to unbounded call_rcu
Message-ID: <20260723115707-mutt-send-email-mst@kernel.org>
References: <eb46ab360dbe28c29cfa78812a7440dcb7444d59.1784807826.git.mst@redhat.com>
 <587f8a83-7d2e-4683-8992-380b494dcdd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <587f8a83-7d2e-4683-8992-380b494dcdd0@redhat.com>
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 23, 2026 at 05:42:02PM +0200, Eric Auger wrote:
> Hi Michael,
> 
> On 7/23/26 1:58 PM, Michael S. Tsirkin wrote:
> > Currently, within virtio-iommu, handle_command processes the command vq
> > without any limits on the number of entries processed.
> > This can easily and repeatedly enable/disable multiple memory regions.
> > Within the memory code, this causes an accumulation of an
> > unbounded number of RCU-deferred FlatViews - each of these
> > is supposed to be freed with call_rcu, but that never happens
> > because the main thread never returns to the main loop.
> >
> > Given FlatView is big, it's easy to have this balloon out to multiple
> > Gigabytes of memory.
> >
> > Limit the loop defer any remaining work to a timer.
> >
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3930
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  include/hw/virtio/virtio-iommu.h |  1 +
> >  hw/virtio/virtio-iommu.c         | 29 +++++++++++++++++++++++++++++
> >  3 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/hw/virtio/virtio-iommu.h b/include/hw/virtio/virtio-iommu.h
> > index 3b86050f2c..1f265540ad 100644
> > --- a/include/hw/virtio/virtio-iommu.h
> > +++ b/include/hw/virtio/virtio-iommu.h
> > @@ -65,6 +65,7 @@ struct VirtIOIOMMU {
> >      GTree *domains;
> >      QemuRecMutex mutex;
> >      GTree *endpoints;
> > +    QEMUTimer *cmd_timer;
> >      bool boot_bypass;
> >      Notifier machine_done;
> >      bool granule_frozen;
> > diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
> > index 08f7e8b783..533bd5073f 100644
> > --- a/hw/virtio/virtio-iommu.c
> > +++ b/hw/virtio/virtio-iommu.c
> > @@ -993,6 +993,18 @@ static int virtio_iommu_handle_probe(VirtIOIOMMU *s,
> >      return ret ? ret : virtio_iommu_probe(s, &req, buf);
> >  }
> >  
> > +static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq);
> > +
> > +static void virtio_iommu_handle_command_timer(void *opaque)
> > +{
> > +    VirtIOIOMMU *s = opaque;
> > +    VirtIODevice *vdev = VIRTIO_DEVICE(s);
> > +
> > +    if (virtio_device_started(vdev, vdev->status) && !vdev->broken) {
> > +        virtio_iommu_handle_command(vdev, s->req_vq);
> So what does happen in terms of scheduling. Can't this run concurrently
> with the usual direct virtio_iommu_handle_command() path? 

BQL prevents that.


> > +    }
> > +}
> > +
> >  static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >  {
> >      VirtIOIOMMU *s = VIRTIO_IOMMU(vdev);
> > @@ -1003,10 +1015,17 @@ static void virtio_iommu_handle_command(VirtIODevice *vdev, VirtQueue *vq)
> >      struct iovec *iov;
> >      void *buf = NULL;
> >      size_t sz;
> > +    unsigned int batch = 0;
> >  
> >      for (;;) {
> >          size_t output_size = sizeof(tail);
> >  
> > +        if (++batch > virtio_queue_get_num(vdev, virtio_get_queue_index(vq))) {
> how did you chose that condition? is it always safe wrt oom situation?

It's kinda random, but the idea is that queue size already gives us
a point on the memory/speed curve.

There's nothing that is "safe wrt oom" in all configs - qemu makes
no promises and even a single allocation can in theory push you
into oom if memory is tight.

But what this prevents is unbounded memory allocations which will trigger
oom at some point for sure.



> > +            timer_mod(s->cmd_timer,
> > +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
> > +            break;
> > +        }
> > +
> >          elem = virtqueue_pop(vq, sizeof(VirtQueueElement));
> >          if (!elem) {
> >              return;
> > @@ -1416,6 +1435,8 @@ static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
> >      s->req_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE,
> >                               virtio_iommu_handle_command);
> >      s->event_vq = virtio_add_queue(vdev, VIOMMU_DEFAULT_QUEUE_SIZE, NULL);
> > +    s->cmd_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL_RT,
> > +                                virtio_iommu_handle_command_timer, s);
> >  
> >      /*
> >       * config.bypass is needed to get initial address space early, such as
> > @@ -1498,6 +1519,7 @@ static void virtio_iommu_device_unrealize(DeviceState *dev)
> >  
> >      qemu_rec_mutex_destroy(&s->mutex);
> >  
> > +    timer_free(s->cmd_timer);
> >      virtio_delete_queue(s->req_vq);
> >      virtio_delete_queue(s->event_vq);
> >      virtio_cleanup(vdev);
> > @@ -1509,6 +1531,8 @@ static void virtio_iommu_device_reset_exit(Object *obj, ResetType type)
> >  
> >      trace_virtio_iommu_device_reset_exit();
> >  
> > +    timer_del(s->cmd_timer);
> > +
> >      if (s->domains) {
> >          g_tree_destroy(s->domains);
> >      }
> > @@ -1628,6 +1652,11 @@ static int iommu_post_load(void *opaque, int version_id)
> >       * still correct.
> >       */
> >      virtio_iommu_switch_address_space_all(s);
> > +
> > +    if (virtio_device_started(VIRTIO_DEVICE(s), VIRTIO_DEVICE(s)->status)) {
> > +        timer_mod(s->cmd_timer,
> > +                  qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL_RT) + 1);
> > +    }
> >      return 0;
> >  }
> >  
> Thanks
> 
> Eric


