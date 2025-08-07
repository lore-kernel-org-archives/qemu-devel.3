Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA0FC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 16:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk3XS-0007TL-B7; Thu, 07 Aug 2025 12:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk3XC-0007KV-1k
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 12:32:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uk3X5-00072a-Ct
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 12:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754584316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eJRvsKVuPLBGHn3/lXEqVtL/AwjXn28oKLZ5EWB1biA=;
 b=O9z8dDZI9hXKJinBtSK7OniMRfg17xguEdMesShrLj1AAKeJsnBy8OF+sCOS8PHeEWMz5O
 5z0lP/tuKW8q/ka8GeG+l1NpINOknT9Eh43//gADRMlt8hVNN1vOrFDnp7XApoGFI9K+4W
 viu20nQcmJcN4KmtnVIajy+MrjB7s6k=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-K5o7Oxa8Mn6TW28QQxUzqQ-1; Thu, 07 Aug 2025 12:31:54 -0400
X-MC-Unique: K5o7Oxa8Mn6TW28QQxUzqQ-1
X-Mimecast-MFC-AGG-ID: K5o7Oxa8Mn6TW28QQxUzqQ_1754584314
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71b70ee9d3cso18289327b3.1
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 09:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754584314; x=1755189114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJRvsKVuPLBGHn3/lXEqVtL/AwjXn28oKLZ5EWB1biA=;
 b=dCuSOmv+tEQAtGGiyZRiCwgdcbV8V1y54bLkYf/UkDmxauEutdlC6tPnzANK7sZGVs
 C6cHlhqyL7JMKUjB/BU6qaafcFqndvjsqbeVgUg+M0KYdE/11oL/rOj1gPijAh+ur3Cz
 +fzNplZWEvxEDpOkijY/k0HftZsVgSDUprSl6mK6eSgNcCbXOh3WYGjYpNHY28ZWTcIv
 cnArMHuj7hrzE5AJMsRsrBDCiXxFR0PDjn/a5WUe9E3mRohZeyCw6BBCIYQ/bVP96fXu
 naKl7fa3CYr0eLpHsmL2cFkwzNAdoKJwb+KZikmlYJCcHq/Ybi88cfwTn+MS1au6Ao+W
 DLgw==
X-Gm-Message-State: AOJu0Ywh/5XvZxZSQWHNcOx9Zg/nVEj/Esf7VF+erOysLy4CUIYTovJt
 zPwRslb0rFYYIS3RZ+Pzrx0WALRueKxR38lnwVNHJMIVp6dFV9kM+0/vfHBUEsCsl6D2omuFkJh
 s3ZYCCSrzq5buAXsGV0umA9rLoxAZuesvMG+aDMr2DTs7HnYrS82ICIsz
X-Gm-Gg: ASbGncutb6M1lJcwKYL5dorS0bCkwijEeuMAJ3yXyB9iP2ustDAguP13/ropDIEIk9Y
 dDp7fyniHyrCQIAVqzW1q20u7JmSftyHLdIZZlNg4287zuSXYOqFpvwi3we/XnD6EQs9yJgMIFF
 j9QrPkbcHeZjOsPscEWGCKGKFHGU3CcL927GSb8wHHo1bAZkLtaCfF944ljRp3+tLGnUGAgq1RL
 BH5dRBYtfvS1AT2mpuJFse/HZn+OkNS30Je9pwOpVRM8WxiIg/NcJfTZ9MiZ25dLpWsX/jNTgYf
 u4Jcn9dVjW/Pojv7cojUZDTv5JPfux8c
X-Received: by 2002:a05:690c:d92:b0:719:a34b:5e50 with SMTP id
 00721157ae682-71bee433343mr6058497b3.21.1754584314024; 
 Thu, 07 Aug 2025 09:31:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC07pL6pkFowgexzwwiJTQsFey1OIgeI73S5dic5WWSrZbHitgXMTCkKTD/wNrSZKAZMDotQ==
X-Received: by 2002:a05:690c:d92:b0:719:a34b:5e50 with SMTP id
 00721157ae682-71bee433343mr6057897b3.21.1754584313499; 
 Thu, 07 Aug 2025 09:31:53 -0700 (PDT)
Received: from x1.local ([174.89.135.171]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-71b5a3fa654sm46719407b3.34.2025.08.07.09.31.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Aug 2025 09:31:52 -0700 (PDT)
Date: Thu, 7 Aug 2025 12:31:39 -0400
From: Peter Xu <peterx@redhat.com>
To: Jonah Palmer <jonah.palmer@oracle.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, eblake@redhat.com,
 armbru@redhat.com, jasowang@redhat.com, mst@redhat.com,
 si-wei.liu@oracle.com, eperezma@redhat.com, boris.ostrovsky@oracle.com
Subject: Re: [RFC 5/6] virtio,virtio-net: skip consistency check in
 virtio_load for iterative migration
Message-ID: <aJTU641465aGKWRU@x1.local>
References: <20250722124127.2497406-1-jonah.palmer@oracle.com>
 <20250722124127.2497406-6-jonah.palmer@oracle.com>
 <aJOCiUPp0dckmgAn@x1.local>
 <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e276607-cd86-4a1d-99f3-47dd2f0f3bc0@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Aug 07, 2025 at 10:18:38AM -0400, Jonah Palmer wrote:
> 
> 
> On 8/6/25 12:27 PM, Peter Xu wrote:
> > On Tue, Jul 22, 2025 at 12:41:26PM +0000, Jonah Palmer wrote:
> > > Iterative live migration for virtio-net sends an initial
> > > VMStateDescription while the source is still active. Because data
> > > continues to flow for virtio-net, the guest's avail index continues to
> > > increment after last_avail_idx had already been sent. This causes the
> > > destination to often see something like this from virtio_error():
> > > 
> > > VQ 0 size 0x100 Guest index 0x0 inconsistent with Host index 0xc: delta 0xfff4
> > 
> > This is pretty much understanable, as vmstate_save() / vmstate_load() are,
> > IMHO, not designed to be used while VM is running.
> > 
> > To me, it's still illegal (per previous patch) to use vmstate_save_state()
> > while VM is running, in a save_setup() phase.
> 
> Yea I understand where you're coming from. It just seemed too good to pass
> up on as a way to send and receive the entire state of a device.
> 
> I felt that if I were to implement something similar for iterative migration
> only that I'd, more or less, be duplicating a lot of already existing code
> or vmstate logic.
> 
> > 
> > Some very high level questions from migration POV:
> > 
> > - Have we figured out why the downtime can be shrinked just by sending the
> >    vmstate twice?
> > 
> >    If we suspect it's memory got preheated, have we tried other ways to
> >    simply heat the memory up on dest side?  For example, some form of
> >    mlock[all]()?  IMHO it's pretty important we figure out the root of why
> >    such optimization came from.
> > 
> >    I do remember we have downtime issue with number of max_vqueues that may
> >    cause post_load() to be slow, I wonder there're other ways to improve it
> >    instead of vmstate_save(), especially in setup phase.
> > 
> 
> Yea I believe that the downtime shrinks on the second vmstate_load_state due
> to preheated memory. But I'd like to stress that it's not my intention to
> resend the entire vmstate again during the stop-and-copy phase if iterative
> migration was used. A future iteration of this series will eventually
> include a more efficient approach to update the destination with any deltas
> since the vmstate was sent during the iterative portion (instead of just
> resending the entire vmstate again).
> 
> And yea there is an inefficiency regarding walking through VIRTIO_QUEUE_MAX
> (1024) VQs (twice with PCI) that I mentioned here in another comment: https://lore.kernel.org/qemu-devel/0f5b804d-3852-4159-b151-308a57f1ec74@oracle.com/
> 
> This might be better handled in a separate series though rather than as part
> of this one.

One thing to mention is I recall some other developer was trying to
optimize device load from memory side:

https://lore.kernel.org/all/20230317081904.24389-1-xuchuangxclwt@bytedance.com/

So maybe there're more than one way of doing this, and I'm not sure which
way is better, or both.

> 
> > - Normally devices need iterative phase because:
> > 
> >    (a) the device may contain huge amount of data to transfer
> > 
> >        E.g. RAM and VFIO are good examples and fall into this category.
> > 
> >    (b) the device states are "iterable" from concept
> > 
> >        RAM is definitely true.  VFIO somehow mimiced that even though it was
> >        a streamed binary protocol..
> > 
> >    What's the answer for virtio-net here?  How large is the device state?
> >    Is this relevant to vDPA and real hardware (so virtio-net can look
> >    similar to VFIO at some point)?
> 
> 
> The main motivation behind implementing iterative migration for virtio-net
> is really to improve the guest visible downtime seen when migrating a vDPA
> device.
> 
> That is, by implementing iterative migration for virtio-net, we can see the
> state of the device early on and get a head start on work that's currently
> being done during the stop-and-copy phase. If we do this work before the
> stop-and-copy phase, we can further decrease the time spent in this window.
> 
> This would include work such as sending down the CVQ commands for queue-pair
> creation (even more beneficial for multiqueue), RSS, filters, etc.
> 
> I'm hoping to show this more explicitly in the next version of this RFC
> series that I'm working on now.

OK, thanks for the context. I can wait and read the new version.

In all cases, please be noted that since migration thread does not take
BQL, it means either the setup or iterable phase may happen concurrently
with any of the vCPU threads.  I think it means maybe it's not wise to try
to iterate everything: please be ready to see e.g. 64bits MMIO register
being partially updated when dumping it to the wire, for example.

Do you have a rough estimation of the size of the device states to migrate?

Thanks,

-- 
Peter Xu


