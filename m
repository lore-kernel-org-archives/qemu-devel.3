Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A55C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 17:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfjfx-0004MB-4H; Wed, 05 Feb 2025 12:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfjfv-0004M2-W0
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:59:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfjft-0004RJ-6f
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 12:58:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738778335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=75ymu4jpHyhbMjYieQ84OtAI2riBguf24EUxH7ex6f0=;
 b=chmPWbH4xrrJL32o1gynda8BUzLJxFqwgHvsgdk15TFTH2s+aCXOY0WtvWZE20d9emRaNr
 QMRDr1/wSu8hRrk9vjaPCDdmVmq5tpUNiIhF8pnI7xxqQcbSnvcBQelFIymH82m1d/3U1u
 r6dv02CNWa2SHIpOOOMQEXfinWryxwI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-Y9bdR767MRGNgE2YipWXWw-1; Wed, 05 Feb 2025 12:58:53 -0500
X-MC-Unique: Y9bdR767MRGNgE2YipWXWw-1
X-Mimecast-MFC-AGG-ID: Y9bdR767MRGNgE2YipWXWw
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-46790c5b1a5so1953081cf.2
 for <qemu-devel@nongnu.org>; Wed, 05 Feb 2025 09:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738778332; x=1739383132;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=75ymu4jpHyhbMjYieQ84OtAI2riBguf24EUxH7ex6f0=;
 b=hO1MYTEYIsWu6u35SzlhwQhVohxNBsA0Okv9UA7jUkCA6Go6tKCPJDNTltICKrE4C9
 9gd/VhHIBwDPDRjw5SLyfi3q1d3OLLxljBkPdAyab3qFlZsRRzbF5Quk0GhaaR1Yr9Gq
 q54JR/vPWtvz6e0UTFZHpILOGer0UYZtpx2InRsdZo1KjZxyG9RiWCz3QPOzIx3bJ7S2
 vKG9RzuTYgR+gjJ9zKBUGxiM1ycQMp7BwFGkZyczEdheR4YB6+pmFe7C4hgoQGNSqM57
 pCseW3oG4BFryEhcaMcKL5himAMgR+MOibdtjEtmLr2wEuR7YWeMOooc8N+rk/A0iQRh
 29PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJojLLv0WLlDT+etqUlpkwnCcX3FKRnoCP/X/G9b7rL3hPLmozffL8fhzOoF6dHJZ154hjvk1NoJLw@nongnu.org
X-Gm-Message-State: AOJu0YwNhubGhpwv5vA9HOHqTNqjSzj6T88/dB4K8+eUqAUoo4g9VDBk
 VEEef2DUuqpwZ1qivSNbjGMOcW4fUON9WIH0AUVquJmE86kfevS4VaR3D1hWIwksI/T836Imcub
 shA2yD7EZwn8NX3r/1Y7vaEIgf/7luV4HvIMNbOK0kVG83mTZxU0T
X-Gm-Gg: ASbGncv6uGv8OmIa3/eHw2cvuRvptrhwwz6906+GCjEQEC6Xot9Z09TBEpbGk9gKluJ
 RQ7Ys4Hm7oORMPcmM5Fa1gOwHPsn+XQRg67W4k52+wc80yJkGwjnwJJBVTRTcoa0/oS3Zh82Rid
 iZV413SKevceMMeauC/S7+awaiEPme+8yHGv0ii0WZs/z5tV9plWmOniiAbf4Rh9nUskG7HCMVn
 JWbp3Luyi2hGcSqLj/XBF0+3M/TJxRKj9GBNPfOTuLfIPR8ZbMGTq0sVLa4OTVIfdJIqnCuf63Q
 /k9Ivlkd1S8rSHJt6/uGSr5VB264hJ4OWAJPckszXJO6S6pk
X-Received: by 2002:a05:622a:1807:b0:46c:728c:8862 with SMTP id
 d75a77b69052e-4702818fd7emr59106591cf.31.1738778332337; 
 Wed, 05 Feb 2025 09:58:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFcIRONPDeQ5coySu66etH/d204OSqB2SxF+etusBpuMM7ScONAqVPqWWOCnhA69AY81yo2/w==
X-Received: by 2002:a05:622a:1807:b0:46c:728c:8862 with SMTP id
 d75a77b69052e-4702818fd7emr59106171cf.31.1738778332012; 
 Wed, 05 Feb 2025 09:58:52 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fdf0c62d4sm72570071cf.17.2025.02.05.09.58.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 09:58:51 -0800 (PST)
Date: Wed, 5 Feb 2025 12:58:48 -0500
From: Peter Xu <peterx@redhat.com>
To: William Roche <william.roche@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org, mtosatti@redhat.com, imammedo@redhat.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
Subject: Re: [PATCH v7 6/6] hostmem: Handle remapping of RAM
Message-ID: <Z6Om2CiOEnbKzNEk@x1.local>
References: <20250201095726.3768796-1-william.roche@oracle.com>
 <20250201095726.3768796-7-william.roche@oracle.com>
 <7a899f00-833e-4472-abc5-b2b9173eb133@redhat.com>
 <Z6JVQYDXI2h8Krph@x1.local>
 <a6f08213-e4a3-41af-9625-a88417a9d527@redhat.com>
 <Z6J1hFuAvpA78Ram@x1.local>
 <a3d7a8cc-aad8-4d98-a5ba-79fad20b9df6@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a3d7a8cc-aad8-4d98-a5ba-79fad20b9df6@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Feb 05, 2025 at 05:27:50PM +0100, William Roche wrote:
> On 2/4/25 21:16, Peter Xu wrote:
> > On Tue, Feb 04, 2025 at 07:55:52PM +0100, David Hildenbrand wrote:
> > > Ah, and now I remember where these 3 patches originate from: virtio-mem
> > > handling.
> > > 
> > > For virtio-mem I want to register also a remap handler, for example, to
> > > perform the custom preallocation handling.
> > > 
> > > So there will be at least two instances getting notified (memory backend,
> > > virtio-mem), and the per-ramblock one would have only allowed to trigger one
> > > (at least with a simple callback as we have today for ->resize).
> > 
> > I see, we can put something into commit log with such on decisions, then
> > we'll remember.
> > 
> > Said that, this still sounds like a per-ramblock thing, so instead of one
> > hook function we can also have per-ramblock notifier lists.
> > 
> > But I agree the perf issue isn't some immediate concern, so I'll leave that
> > to you and William.  If so I think we should discuss that in the commit log
> > too, so we decide to not care about perf until necessary (or we just make
> > it per-ramblock..).
> > 
> > Thanks,
> > 
> 
> 
> I agree that we could split this fix in 2 parts: The one fixing the
> hugetlbfs (ignoring the preallocation setting for the moment), and the
> notification mechanism as a second set of patches.
> 
> The first part would be the 3 first patches (including a corrected version
> of patch 2)  and the second part could be an adaptation of the next 3
> patches, with their notification implementation dealing with merging, dump
> *and* preallocation setup.
> 
> 
> But I'd be happy to help with the implementation of this 2nd aspect too:
> 
> In order to apply settings like preallocation to a RAMBLock we need to find
> its associated HostMemoryBackend (where we have the 'prealloc' flag).
> To do so, we record a RAMBlockNotifier in the HostMemoryBackend struct, so
> that the notification triggered by the remap action:
>    ram_block_notify_remap(block->host, offset, page_size);
> will go through the list of notifiers ram_list.ramblock_notifiers to run the
> not NULL ram_block_remapped entries on all of them.
> 
> For each of them, we know the associated HostMemoryBackend (as it contains
> the RAMBlockNotifier), and we verify which one corresponds to the host
> address given, so that we can apply the appropriate settings.
> 
> IIUC, my proposal (with David's code) currently has a per-HostMemoryBackend
> notification.
> 
> Now if I want to implement a per-RAMBlock notification, would you suggest to
> consider that the 'mr' attibute of a RAMBlock always points to a
> HostMemoryBackend.mr, so that we could get the HostMemoryBackend associated
> to the block from a
>     container_of(block->mr, HostMemoryBackend, mr) ?
> 
> If this is valid, than we could apply the appropriate settings from there,
> but can't we have RAMBlocks not pointing to a HostMemoryBackend.mr ?

Yes, QEMU definitely has ramblocks that are not backed by memory backends.
However each memory backend must have its ramblock.

IIUC what we need to do is let host_memory_backend_memory_complete()
register a per-ramblock notifier on top of its ramblock, which can be
referenced by backend->mr.ramblock.

> 
> 
> I'm probably confused about what you are referring to.
> So how would you suggest that I make the notification per-ramblock ?
> Thanks in advance for your feedback.
> 
> 
> I'll send a corrected version of the first 3 patches, unless you want to go
> with the current version of the patches 4/6, 5/6 and 6/6, so that we can
> deal with preallocation.

I don't feel strongly, but I can explain how the per-ramblock can be done.

One thing interesting I found is we actually have such notifier list
already in ramblocks.. see:

struct RAMBlock {
    ...
    QLIST_HEAD(, RAMBlockNotifier) ramblock_notifiers;
    ...
}

I guess that's some leftover from the global ramblock notifier.. e.g. I
tried remove that line and qemu compiles all fine.

Then instead of removing it, we could make that the per-ramblock list.

One way to do this is:

  - Patch 1: refactor current code, let RAMBlock.resized() to be a notifier
    instead of a fn() pointer passed over from
    memory_region_init_resizeable_ram().  It means we can remove
    RAMBlock.resized() but make fw_cfg_resized() becomes a notifier, taking
    RAM_BLOCK_RESIZED event instead.

  - Patch 2: introduce another RAM_BLOCK_REMAPPED event, then host backends
    (probably, host_memory_backend_memory_complete() after alloc() done so
    that the ramblock will always be available..) can register a notifier
    only looking for REMAPPED.

Then in the future virtio-mem can register similarly to specific ramblock
on REMAPPED only.

Thanks,

-- 
Peter Xu


