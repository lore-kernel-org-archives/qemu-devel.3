Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D72A6C87FD2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 13:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulSkf-0001ak-6F; Mon, 11 Aug 2025 09:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulSkX-0001T2-H4
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:39:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1ulSkO-0006FK-M5
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 09:39:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754919559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FGcKu2tfTvYPWedmC8CfMG94S4hhkTz76fC8GghDQXg=;
 b=LltyeYkUb5WqChDHt/VVrjZd9Vp5lnIotwBAxuVz98abiki6Q/dwbYe5CbmeztpWv0lWiT
 JNNzCRZFTHbk0okOj/wMuLTGVHK4gr//deWuyY2f0WNAF5FqwLRSSGz3pUBsTrK0xj91rn
 wQJYjw8ka/ApvzwZtWMf6EHhJm5lDFw=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-tHA4AJ9_NkaO-rK3db5I7A-1; Mon, 11 Aug 2025 09:39:18 -0400
X-MC-Unique: tHA4AJ9_NkaO-rK3db5I7A-1
X-Mimecast-MFC-AGG-ID: tHA4AJ9_NkaO-rK3db5I7A_1754919557
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-71b6c56ca46so68831737b3.0
 for <qemu-devel@nongnu.org>; Mon, 11 Aug 2025 06:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754919557; x=1755524357;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGcKu2tfTvYPWedmC8CfMG94S4hhkTz76fC8GghDQXg=;
 b=a5X3oRgudjek1lskO/o1G2CgX3Gi/efDQaRMuJy0maKREm2PB1jljWMUN1eBjGPrbP
 YjaM66ORnrb5K+GZ+gPeecQKUYrcugWXw6MZ7dhkMWu61wDVxcGqmAoTIhoKjjTf2ECS
 x07xRuwY82wOcEJCNSkloRLFAMM+uH5v1G2Z5Wm7SgWMxa/Z8OWY4d11O+jQUlDuwkt2
 CoCIplJqst/fPrss+BMu4wZdJsnsUVZPFsyIA4lCoH51A7HJHctb3y+q84dv8dnF+yCs
 157UV28zlhxOY1zBwOIwb9aVaZPT+kuaKaxagMKA2ny3KaxDZqx4L533/DXWqM7cO9d6
 nGBg==
X-Gm-Message-State: AOJu0YwiNvBnLnuhJLVUmdLs9VYd+gyKftt8tS5CxHaJ9DUJQhhRJaYv
 +R4k+GTcMse6H4EUHp3Y/oZMZIgctez3dWmIUEmbIKAsiBhun1/nEJMcywyTnw6Bhb/pcupSzMt
 Fsr4MmYW+xSm6DnVOBwE0bLETORsYwVH03d93GNcKZslhtYp7HhYNVbaD
X-Gm-Gg: ASbGncugR+ZC98WE7WXujvb45kMqmQwNHwlcXMWWls6a6jiHbsimb3ehtmY5rI1E+LD
 mKjG7wDMHy8KZxz3Ps51m6cOch8VPZCx+/s49BsZUZak9Rw7h10sER7qQVmSCzZrsIjAeWMn0Um
 WilfxXMavVEbgxipJuSSDuk3k0b/r3660U8lIN7eZthZA1j53iND/Hhe2YobjIrQtA770RD2pKX
 BA1mJ/weSar0d7QbE58QE/p9dKfvdPwG5+8f0lTnHtyUgBbclyOlgMt6TIKd6FhjF7oZEcBR6Ql
 BnyY2Oh2qeYSxv1ZFo3bYMLfK4vz9wNh
X-Received: by 2002:a05:690c:4a06:b0:71a:2d5f:49b4 with SMTP id
 00721157ae682-71bf0e09bb1mr150156807b3.25.1754919557110; 
 Mon, 11 Aug 2025 06:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF76zzrLQto4tTuVCBUsIqGM5hkloZ0CRCmKQ33zZ6PVE47HEmAJyLnCVNCUZKS/ffcYZ3Qcg==
X-Received: by 2002:a05:690c:4a06:b0:71a:2d5f:49b4 with SMTP id
 00721157ae682-71bf0e09bb1mr150156447b3.25.1754919556658; 
 Mon, 11 Aug 2025 06:39:16 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3f9c3bsm69287147b3.33.2025.08.11.06.39.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 06:39:16 -0700 (PDT)
Date: Mon, 11 Aug 2025 09:39:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJnydjxFzKwVzi7Y@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
 <aJTU641465aGKWRU@x1.local>
 <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cf99747-443e-4a29-a0da-64012548a994@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Aug 11, 2025 at 08:30:19AM -0400, Jonah Palmer wrote:
> 
> 
> On 8/7/25 12:31 PM, Peter Xu wrote:
> > On Thu, Aug 07, 2025 at 10:18:38AM -0400, Jonah Palmer wrote:
> > > 
> > > 
> > > On 8/6/25 12:27 PM, Peter Xu wrote:
> > > > On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
> > > > > Iterative live migration for virtio-net sends an initial
> > > > > VMStateDescription while the source is still active. Because data
> > > > > continues to flow for virtio-net, the guest's avail index continues to
> > > > > increment after last_avail_idx had already been sent. This causes the
> > > > > destination to often see something like this from virtio_error():
> > > > > 
> > > > > VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
> > > > 
> > > > This is pretty much understanable, as vmstate_save() / vmstate_load() are,
> > > > IMHO, not designed to be used while VM is running.
> > > > 
> > > > To me, it's still illegal (per previous patch) to use vmstate_save_state()
> > > > while VM is running, in a save_setup() phase.
> > > 
> > > Yea I understand where you're coming from. It just seemed too good to pass
> > > up on as a way to send and receive the entire state of a device.
> > > 
> > > I felt that if I were to implement something similar for iterative migration
> > > only that I'd, more or less, be duplicating a lot of already existing code
> > > or vmstate logic.
> > > 
> > > > 
> > > > Some very high level questions from migration POV:
> > > > 
> > > > - Have we figured out why the downtime can be shrinked just by sending the
> > > >     vmstate twice?
> > > > 
> > > >     If we suspect it's memory got preheated, have we tried other ways to
> > > >     simply heat the memory up on dest side?  For example, some form of
> > > >     mlock[all]()?  IMHO it's pretty important we figure out the root of why
> > > >     such optimization came from.
> > > > 
> > > >     I do remember we have downtime issue with number of max_vqueues that may
> > > >     cause post_load() to be slow, I wonder there're other ways to improve it
> > > >     instead of vmstate_save(), especially in setup phase.
> > > > 
> > > 
> > > Yea I believe that the downtime shrinks on the second vmstate_load_state due
> > > to preheated memory. But I'd like to stress that it's not my intention to
> > > resend the entire vmstate again during the stop-and-copy phase if iterative
> > > migration was used. A future iteration of this series will eventually
> > > include a more efficient approach to update the destination with any deltas
> > > since the vmstate was sent during the iterative portion (instead of just
> > > resending the entire vmstate again).
> > > 
> > > And yea there is an inefficiency regarding walking through VIRTIO_QUEUE_MAX
> > > (1024) VQs (twice with PCI) that I mentioned here in another comment: https://urldefense.com/v3/__https://lore.kernel.org/qemu-devel/0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjFhL0IUC$
> > > 
> > > This might be better handled in a separate series though rather than as part
> > > of this one.
> > 
> > One thing to mention is I recall some other developer was trying to
> > optimize device load from memory side:
> > 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/__;!!ACWV5N9M2RV99hQ!Oyhh-o4V5gzcWsbmSxAkonhYn3xcLBF50-h-a9-D5MiKgbiHvkaAqdu1VZP5SVmuCk5GQu-sjBifRrAz$
> > 
> > So maybe there're more than one way of doing this, and I'm not sure which
> > way is better, or both.
> > 
> 
> Ack. I'll take a look at this.
> 
> > > 
> > > > - Normally devices need iterative phase because:
> > > > 
> > > >     (a) the device may contain huge amount of data to transfer
> > > > 
> > > >         E.g. RAM and VFIO are good examples and fall into this category.
> > > > 
> > > >     (b) the device states are "iterable" from concept
> > > > 
> > > >         RAM is definitely true.  VFIO somehow mimiced that even though it was
> > > >         a streamed binary protocol..
> > > > 
> > > >     What's the answer for virtio-net here?  How large is the device state?
> > > >     Is this relevant to vDPA and real hardware (so virtio-net can look
> > > >     similar to VFIO at some point)?
> > > 
> > > 
> > > The main motivation behind implementing iterative migration for virtio-net
> > > is really to improve the guest visible downtime seen when migrating a vDPA
> > > device.
> > > 
> > > That is, by implementing iterative migration for virtio-net, we can see the
> > > state of the device early on and get a head start on work that's currently
> > > being done during the stop-and-copy phase. If we do this work before the
> > > stop-and-copy phase, we can further decrease the time spent in this window.
> > > 
> > > This would include work such as sending down the CVQ commands for queue-pair
> > > creation (even more beneficial for multiqueue), RSS, filters, etc.
> > > 
> > > I'm hoping to show this more explicitly in the next version of this RFC
> > > series that I'm working on now.
> > 
> > OK, thanks for the context. I can wait and read the new version.
> > 
> > In all cases, please be noted that since migration thread does not take
> > BQL, it means either the setup or iterable phase may happen concurrently
> > with any of the vCPU threads.  I think it means maybe it's not wise to try
> > to iterate everything: please be ready to see e.g. 64bits MMIO register
> > being partially updated when dumping it to the wire, for example.
> > 
> 
> Gotcha. Some of the iterative hooks though like .save_setup, .load_state,
> etc. do hold the BQL though, right?

load_state() definitely needs the lock.

save_setup(), yes we have bql, but I really wish we don't depend on it, and
I don't know whether it'll keep holding true - AFAIU, the majority of it
really doesn't need the lock..  and I always wanted to see whether I can
remove it.

Normal iterations definitely runs without the lock.

> 
> > Do you have a rough estimation of the size of the device states to migrate?
> > 
> 
> Do you have a method at how I might be able to estimate this? I've been
> trying to get some kind of rough estimation but failing to do so.

Could I ask why you started this "migrate virtio-net in iteration phase"
effort?

I thought it was because there're a lot of data to migrate, and there
should be a way to estimate the minumum.  So is it not the case?

How about vDPA devices?  Do those devices have a lot of data to migrate?

We really need a good enough reason to have a device provide
save_iterate().  If it's only about "preheat some MMIO registers", we
should, IMHO, look at more generic ways first.

Thanks,

-- 
Peter Xu


