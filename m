Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2AAC44508
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:23:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cD-0002ZY-TK; Fri, 10 Jul 2026 02:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wi4cB-0002Uz-EH
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wi4c9-0004pc-8y
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783664491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7qSFo1JOVHuTytrstdvC4wRRrtZOew8tCUJ7g4qCuLs=;
 b=arhMO7WvDrnuvuGP3ndzuda/wPZLwK+ISnxZ9hFr/Aq3XLqP3+XISiuKH7WIBUFRfA/0AK
 +/BV/mgAFQkNg+JwVxtMAX//RDfZOXUhjsATgI1bAx52zWRSrPWpIZBia9bU9UghHzs6Sc
 2ctHThl7sxRNMEiiJ5C5rQMqk0htMFU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-4CSh3TueNouB3ieFQJGFFw-1; Fri, 10 Jul 2026 02:21:28 -0400
X-MC-Unique: 4CSh3TueNouB3ieFQJGFFw-1
X-Mimecast-MFC-AGG-ID: 4CSh3TueNouB3ieFQJGFFw_1783664488
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso6261611cf.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783664488; x=1784269288; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qSFo1JOVHuTytrstdvC4wRRrtZOew8tCUJ7g4qCuLs=;
 b=YP+a1AJsM5TucnQSMdbtPzz+joDXJogxu3GfUj+lZndasO2sdIgfol5VKkr2MpUGYT
 SfypV9Oz3mzociIqbQAqEbnglLOClve+P0kDX5M8Z9zx79TaslS9raQGIMzwoqDjoxyR
 N5ZiQru8uu2XT7T8ZSYgvWLz/en/cVxRKQ6CujDzzFMGNPhKmQOLzp+F4w8bkO+UPXzK
 HoPu457y8uJLzLtHBsqsc1AUJviOtuMako+iTHv/Z5r1K/e3WbFXO4fcARKjc1Peozly
 HQaBEYeZvxsqmGkIJhxeX8Wa84Z6Gww4pFheAJ8/g7F0nuiXnSd1xMPoRDJ6e46xR4J9
 BOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664488; x=1784269288;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7qSFo1JOVHuTytrstdvC4wRRrtZOew8tCUJ7g4qCuLs=;
 b=H0ozpktORAWb7dk9MSL/0IV0QRlyCr2mEzWQ6C1UfpaQcOiGNkFKiaNZSxeZoemtwl
 pnp7N2QXUI2DYnWH5gRmGwlnNRhZPTvBqQdLWtl5efo55l0AHOod+fqwwY39mqhDkkn/
 X+C09Hxi/8EA2xNhGD4wt8W5tdVcGAozfxyKD9K/5vs4MGH/eODjdJ9dbv1ZO40d4p4d
 dZCJionaVzYsNuscM6SuPc851AmSf+pq05Wdtp3KVaThQY+XKkNO6+upJuAm2NutvwQi
 /1uyJYADZ/G7kBRA39mOrRFbkCX9SPf2xEJR5LpU0WT9YyIV2XRpdxxCzJIvSbjADWOn
 XMTg==
X-Gm-Message-State: AOJu0YyDsDhqerxJVSHa6IVvFFI7mX0kuLrvNOGyVdl2pgSxeqHaViBr
 sE1P4uyC4ryAFiHptt1WFDYgVaLSccY2WmWgtwP1wTwnT5aUDtgpw9pfN1UueO6IyVC/LR0S9nq
 +79xDAYqDwuL6JS2mQ4y6PhfafVKWp4xM2DK3crjOp2Eq8EHV0JgIDsnQKmY9aTCfJkI=
X-Gm-Gg: AfdE7cmL/BCas2KQ2D1t7lBVg/grjYz7Ksvk71pD25Rc5F/ebIYmnjpHKE00E8XLQEU
 U42F7caTllYVQfnYJ7sGnh++1VF+d1mHnFgJyIOi4Pt4xoBNZa0cPnTVxHdd3qnFor0he+gJsPb
 i8oRUArbtdA7j5qjT0r0sxY6uXJ184kqCHPIJWPNZ8FfUZdeYDyXA55RosfnYvMNxZ5rZ4aSLff
 2DyqQXIYaC2+5gYqW6hTWjIj5YCKmvaaKIiYWYC+ng3uuqKLwO3pIqipfhfMXTHyO3+0mxBx+/8
 Vepbi16rjMmb1Uum5+unfO64LxWDROcqHdrksCNX6FEqNMC9bS+IkdMzC6EivzNCjtwx16NOe41
 mweQ=
X-Received: by 2002:ac8:574b:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-51c8b2e2401mr115691661cf.24.1783664487563; 
 Thu, 09 Jul 2026 23:21:27 -0700 (PDT)
X-Received: by 2002:ac8:574b:0:b0:51c:1005:d096 with SMTP id
 d75a77b69052e-51c8b2e2401mr115691441cf.24.1783664487003; 
 Thu, 09 Jul 2026 23:21:27 -0700 (PDT)
Received: from redhat.com ([186.247.38.126]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caab6e326sm9934811cf.6.2026.07.09.23.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:26 -0700 (PDT)
Date: Fri, 10 Jul 2026 02:21:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: m'te'a physical <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: validate split queue head count before popping
Message-ID: <20260710022025-mutt-send-email-mst@kernel.org>
References: <20260709100529.41267-1-physicalmtea@gmail.com>
 <20260709084105-mutt-send-email-mst@kernel.org>
 <CAJwVaM+LE9BdOU=cMx0P7GmSuBpVEBQYANHxr0DsuB_UhhUCuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJwVaM+LE9BdOU=cMx0P7GmSuBpVEBQYANHxr0DsuB_UhhUCuw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 10, 2026 at 09:34:54AM +0800, m'te'a physical wrote:
> I think virtio_queue_empty_rcu() is no longer needed after this change.
> 
> For this caller, the pieces it covered are either already handled elsewhere or
> kept explicitly in the split pop path.
> 
> The disabled-device check is already done by virtqueue_pop() before it calls
> virtqueue_split_pop().
> 
> The empty-queue check is covered by virtqueue_num_heads(): rc == 0 is the
> normal empty case, and rc < 0 is the invalid avail index distance case that
> this
> patch wants to reject.
> 
> The read barrier is also covered by virtqueue_num_heads(), since it does
> smp_rmb() when it returns a positive head count, before the caller reads the
> avail ring entry with virtqueue_get_head().
> 
> The only old check that I think should stay explicit in virtqueue_split_pop()
> is
> !vq->vring.avail. virtqueue_num_heads() does not check that, and the old
> behavior for an unconfigured split queue was to treat it as empty. So v2 keeps
> that guard and replaces the rest of virtio_queue_empty_rcu() with
> virtqueue_num_heads():

Yea this is our hacky way to check the mr cache is valid.


>     RCU_READ_LOCK_GUARD();
>     if (unlikely(!vq->vring.avail)) {
>         goto done;
>     }
> 
>     rc = virtqueue_num_heads(vq, vq->last_avail_idx);
>     if (rc <= 0) {
>         goto done;
>     }
> 
> With that, virtio_queue_empty_rcu() has no remaining users and can be removed.
> 
> If this looks right, I can send a v2 patch with this change.
> 
> Michael S. Tsirkin <mst@redhat.com> 于2026年7月9日周四 20:43写道：
> 
>     On Thu, Jul 09, 2026 at 06:05:29PM +0800, Jia Jia wrote:
>     > virtqueue_split_pop() reads the next split avail ring entry after
>     > virtio_queue_empty_rcu() reports work. Call virtqueue_num_heads() before
>     > consuming that entry, so an avail index distance larger than the queue
>     > size is rejected.
>     >
>     > virtqueue_num_heads() also keeps the read barrier needed before the avail
>     > ring entry is read.
>     >
>     > This prevents an invalid split queue state from being expanded into
>     > repeated device command processing.
>     >
>     > Link: https://gitlab.com/qemu-project/qemu/-/issues/3930
>     > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
>     > ---
>     > Tested with qemu-system-x86_64 11.0.50, built from origin/master
>     > f893c46c3931 plus this patch, configured with:
>     >   --target-list=x86_64-softmmu --enable-kvm --disable-tcg
>     >
>     > The original virtio-iommu live-vring qtest reproducer used for the
>     > report completed successfully on the patched build without host OOM,
>     > confirming that this reproducer is fixed by the patch.
>     >
>     >  hw/virtio/virtio.c | 8 +++++---
>     >  1 file changed, 5 insertions(+), 3 deletions(-)
>     >
>     > diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
>     > index f4d86a3655..252bff8641 100644
>     > --- a/hw/virtio/virtio.c
>     > +++ b/hw/virtio/virtio.c
>     > @@ -1751,9 +1751,11 @@ static void *virtqueue_split_pop(VirtQueue *vq,
>     size_t sz)
>     >      if (virtio_queue_empty_rcu(vq)) {
>     >          goto done;
>     >      }
>     > -    /* Needed after virtio_queue_empty(), see comment in
>     > -     * virtqueue_num_heads(). */
>     > -    smp_rmb();
>     > +
>     > +    rc = virtqueue_num_heads(vq, vq->last_avail_idx);
>     > +    if (rc <= 0) {
>     > +        goto done;
>     > +    }
> 
> 
>     Do we still need virtio_queue_empty_rcu then? Why?
> 
>     >      /* When we start there are none of either input nor output. */
>     >      out_num = in_num = elem_entries = 0;
>     > --
>     > 2.34.1
> 
> 


