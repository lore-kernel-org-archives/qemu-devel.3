Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BECFC54E71
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmfr5-0006v7-Nt; Tue, 19 Mar 2024 16:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfr3-0006ue-Ku
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:14:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmfr1-0006ME-M9
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 16:14:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710879273;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF4RMbUm4t87SXmkcLtBo3KXqDfJAcRX1SzHsZiLv9k=;
 b=FPjPoMDO2SD0a5NCOYC9mp79rXSVwOWXnSTpOKjCEd8YEZOvVpV8q6kC8aWuz2UuvFwkyX
 aMM8a+uSZ8HytmWcn5+mtM5TqWex2Yp/yLEz3fdHH8FeQAXLd5+7gnXadHbepmFyLrnCLD
 YReoxftdq2lTrtv+jDBdHfqqG9U7idc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-izDYrgw6PyqJyYiZFvs0QA-1; Tue,
 19 Mar 2024 16:14:31 -0400
X-MC-Unique: izDYrgw6PyqJyYiZFvs0QA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 85803299E768
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 20:14:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33873C20;
 Tue, 19 Mar 2024 20:14:29 +0000 (UTC)
Date: Tue, 19 Mar 2024 20:14:12 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Sanjay Rao <srao@redhat.com>, Boaz Ben Shabat <bbenshab@redhat.com>,
 Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH] coroutine: cap per-thread local pool size
Message-ID: <ZfnyFOKI3uEXJ0xB@redhat.com>
References: <20240318183429.1039340-1-stefanha@redhat.com>
 <ZfmWhDaG5mN-GCeO@redhat.com> <ZfnDTkh5CCHX1WFK@redhat.com>
 <ZfnHIv9W-tVoF4Bm@redhat.com> <ZfnOSKk4C6e4VSUX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfnOSKk4C6e4VSUX@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 19, 2024 at 06:41:28PM +0100, Kevin Wolf wrote:
> Am 19.03.2024 um 18:10 hat Daniel P. Berrangé geschrieben:
> > On Tue, Mar 19, 2024 at 05:54:38PM +0100, Kevin Wolf wrote:
> > > Am 19.03.2024 um 14:43 hat Daniel P. Berrangé geschrieben:
> > > > On Mon, Mar 18, 2024 at 02:34:29PM -0400, Stefan Hajnoczi wrote:
> > > > > The coroutine pool implementation can hit the Linux vm.max_map_count
> > > > > limit, causing QEMU to abort with "failed to allocate memory for stack"
> > > > > or "failed to set up stack guard page" during coroutine creation.
> > > > > 
> > > > > This happens because per-thread pools can grow to tens of thousands of
> > > > > coroutines. Each coroutine causes 2 virtual memory areas to be created.
> > > > 
> > > > This sounds quite alarming. What usage scenario is justified in
> > > > creating so many coroutines?
> > > 
> > > Basically we try to allow pooling coroutines for as many requests as
> > > there can be in flight at the same time. That is, adding a virtio-blk
> > > device increases the maximum pool size by num_queues * queue_size. If
> > > you have a guest with many CPUs, the default num_queues is relatively
> > > large (the bug referenced by Stefan had 64), and queue_size is 256 by
> > > default. That's 16k potential requests in flight per disk.
> > 
> > If we have more than 1 virtio-blk device, does that scale up the max
> > coroutines too ?
> > 
> > eg would 32 virtio-blks devices imply 16k * 32 -> 512k potential
> > requests/coroutines ?
> 
> Yes. This is the number of request descriptors that fit in the
> virtqueues, and if you add another device with additional virtqueues,
> then obviously that increases the number of theoretically possible
> parallel requests.
> 
> The limits of what you can actually achieve in practice might be lower
> because I/O might complete faster than the time we need to process all
> of the queued requests, depending on how many vcpus are trying to
> "compete" with how many iothreads. Of course, the practical limits in
> five years might be different from today.
> 
> > > > IIUC, coroutine stack size is 1 MB, and so tens of thousands of
> > > > coroutines implies 10's of GB of memory just on stacks alone.
> > > 
> > > That's only virtual memory, though. Not sure how much of it is actually
> > > used in practice.
> > 
> > True, by default Linux wouldn't care too much about virtual memory,
> > Only if 'vm.overcommit_memory' is changed from its default, such
> > that Linux applies an overcommit ratio on RAM, then total virtual
> > memory would be relevant.
> 
> That's a good point and one that I don't have a good answer for, short
> of just replacing the whole QEMU block layer with rsd and switching to
> stackless coroutines/futures this way.
> 
> > > > > Eventually vm.max_map_count is reached and memory-related syscalls fail.
> > > > 
> > > > On my system max_map_count is 1048576, quite alot higher than
> > > > 10's of 1000's. Hitting that would imply ~500,000 coroutines and
> > > > ~500 GB of stacks !
> > > 
> > > Did you change the configuration some time in the past, or is this just
> > > a newer default? I get 65530, and that's the same default number I've
> > > seen in the bug reports.
> > 
> > It turns out it is a Fedora change, rather than a kernel change:
> > 
> >   https://fedoraproject.org/wiki/Changes/IncreaseVmMaxMapCount
> 
> Good to know, thanks.
> 
> > > > > diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
> > > > > index 5fd2dbaf8b..2790959eaf 100644
> > > > > --- a/util/qemu-coroutine.c
> > > > > +++ b/util/qemu-coroutine.c
> > > > 
> > > > > +static unsigned int get_global_pool_hard_max_size(void)
> > > > > +{
> > > > > +#ifdef __linux__
> > > > > +    g_autofree char *contents = NULL;
> > > > > +    int max_map_count;
> > > > > +
> > > > > +    /*
> > > > > +     * Linux processes can have up to max_map_count virtual memory areas
> > > > > +     * (VMAs). mmap(2), mprotect(2), etc fail with ENOMEM beyond this limit. We
> > > > > +     * must limit the coroutine pool to a safe size to avoid running out of
> > > > > +     * VMAs.
> > > > > +     */
> > > > > +    if (g_file_get_contents("/proc/sys/vm/max_map_count", &contents, NULL,
> > > > > +                            NULL) &&
> > > > > +        qemu_strtoi(contents, NULL, 10, &max_map_count) == 0) {
> > > > > +        /*
> > > > > +         * This is a conservative upper bound that avoids exceeding
> > > > > +         * max_map_count. Leave half for non-coroutine users like library
> > > > > +         * dependencies, vhost-user, etc. Each coroutine takes up 2 VMAs so
> > > > > +         * halve the amount again.
> > > > > +         */
> > > > > +        return max_map_count / 4;
> > > > 
> > > > That's 256,000 coroutines, which still sounds incredibly large
> > > > to me.
> > > 
> > > The whole purpose of the limitation is that you won't ever get -ENOMEM
> > > back, which will likely crash your VM. Even if this hard limit is high,
> > > that doesn't mean that it's fully used. Your setting of 1048576 probably
> > > means that you would never have hit the crash anyway.
> > > 
> > > Even the benchmarks that used to hit the problem don't even get close to
> > > this hard limit any more because the actual number of coroutines stays
> > > much smaller after applying this patch.
> > 
> > I'm more thinking about what's the worst case behaviour that a
> > malicious guest can inflict on QEMU, and cause unexpectedly high
> > memory usage in the host.
> > 
> > ENOMEM is bad for a friendy VM, but there's also the risk to the host
> > from a unfriendly VM exploiting the high limits
> 
> But from a QEMU perspective, what is the difference between a friendly
> high-performance VM that exhausts the available bandwidth to do its job
> as good and fast as possible, and a malicious VM that does that same
> just to waste host resources? I don't think QEMU can decide this, they
> look the same.
> 
> If you want a VM not to send 16k requests in parallel, you can configure
> its disk to expose less queues or a smaller queue size. The values I
> mentioned above are only defaults that allow friendly VMs to perform
> well out of the box, nothing prevents you from changing them to restrict
> the amount of resources a VM can use.

Reducing queues is a no-win scenario, as it limits the performance of
a single disk when used in isolation, in order to cap the worst case
when all disks are used concurrently :-( It would be nice to allow a
single disk to burst to a high level, and only limit coroutines if
many disks are all trying to concurrently burst to a high level.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


