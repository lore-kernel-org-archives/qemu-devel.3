Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A8CCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXP9-0003ZK-2n; Mon, 08 Jun 2026 06:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXP7-0003Z7-JR
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:40:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXP5-0007BF-K3
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:40:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780915222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=tSGNKthISl69yVf+Qb3ZrKmPUfg0XzVPQojQvjtQPi0=;
 b=O56H0IlnluPQ+6Hh+nqnUUSv/nifAnhjpJ4/wLuJ5d3KlDxUZRW74w8s4DcPOXKicQuY7p
 MDZEpNEgDz30tE93y9aHyxJ3HnFcsbPv2vEhEl2I4LLbt7eRmEAYbyk8SIzlo4ieS/CZ9o
 mXgZJ6JKxJQP+TE3IfEejpji06Q8I0o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-Xg2CV7XdPcCORuKnFj17Mw-1; Mon,
 08 Jun 2026 06:40:19 -0400
X-MC-Unique: Xg2CV7XdPcCORuKnFj17Mw-1
X-Mimecast-MFC-AGG-ID: Xg2CV7XdPcCORuKnFj17Mw_1780915217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AE03180064A; Mon,  8 Jun 2026 10:40:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73C7019560A2; Mon,  8 Jun 2026 10:40:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1040121E6A01; Mon, 08 Jun 2026 12:40:14 +0200 (CEST)
Resent-To: ashish.kalra@amd.com, michael.roth@amd.com, pankaj.gupta@amd.com,
 ackerleytng@google.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 david@kernel.org, chao.p.peng@linux.intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:40:14 +0200
Resent-Message-ID: <87v7btiacx.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Markus Armbruster <armbru@redhat.com>,  <qemu-devel@nongnu.org>,
 <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,  <berrange@redhat.com>,
 <pankaj.gupta@amd.com>,  <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>,  <chao.p.peng@linux.intel.com>,
 <david@kernel.org>,  <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 02/12] hostmem: Introduce dedicated memory backend
 for guest_memfd
In-Reply-To: <ge6uyrbigeoym74thogtolbe3e3jgya7hsibzrrqum6nevusys@ixh7rwe7lzsx>
 (Michael Roth's message of "Wed, 3 Jun 2026 01:19:32 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-3-michael.roth@amd.com>
 <871pep73o6.fsf@pond.sub.org>
 <ge6uyrbigeoym74thogtolbe3e3jgya7hsibzrrqum6nevusys@ixh7rwe7lzsx>
Date: Mon, 08 Jun 2026 10:20:22 +0200
Message-ID: <87v7btl9yx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_LTC_HUSH=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

Michael Roth <michael.roth@amd.com> writes:

> On Tue, Jun 02, 2026 at 10:22:01AM +0200, Markus Armbruster wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>> 
>> > In the initial implementation of guest_memfd in the linux kernel, it
>> > was not possible to map memory into userspace for direct access; instead
>> > the memory provided by the memory backend would be used for cases where
>> > a confidential VM wants to access normal/unprotected/unencrypted memory
>> > that can be used for shared memory use cases, and for access to private
>> > memory a guest_memfd could be associated with the same memslot. A memory
>> > 'private' attribute set via KVM_SET_MEMORY_ATTRIBUTES could then be used
>> > to have KVM route to the approprate backing memory.
>> >
>> > In that model, it didn't make sense to introduce a specific backend for
>> > guest_memfd, since there was always a generally need to have a separate
>> 
>> a general need?
>
> Much nicer :)
>
>> 
>> > backend type to handle shared memory access/allocation. Instead, QEMU
>> > configures the guest_memfd support for the associated memslots
>> > internally for cases where it is running a confidential VM.
>> >
>> > However, with recent changes in guest_memfd kernel support, it is now
>> > possible to mmap() a guest_memfd FD into userspace and use it for shared
>> > memory, as well as continue to use the same physical pages for the same
>> > GPA ranges after they are converted to private ("in-place conversion").
>> >
>> > To enable the use of this mmap()-able/guest_memfd-provided memory to be
>> > used for normal/shared memory instead of just for private memory,
>> > introduce a dedicated guest_memfd memory backend that can be used both
>> > for confidential VMs that wish to make use of in-place conversion, as
>> > well as for non-confidential VMs that just want to make use of
>> > guest_memfd for normal memory (which can be useful both for testing as
>> > well as a stepping stone to things like software-protected VMs where the
>> > host can be trusted to provided some additional degree of isolation for
>> > the VM independently of hardware support).
>> >
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index dd45ac1087..502fafeb15 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -661,7 +661,8 @@
>> >  # @share: if false, the memory is private to QEMU; if true, it is
>> >  #     shared (default false for backends memory-backend-file and
>> >  #     memory-backend-ram, true for backends memory-backend-epc,
>> > -#     memory-backend-memfd, and memory-backend-shm)
>> > +#     memory-backend-memfd, memory-backend-shm, and
>> > +#     memory-backend-guest-memfd)
>> >  #
>> >  # @reserve: if true, reserve swap space (or huge pages) if applicable
>> >  #     (default: true) (since 6.1)
>> > @@ -780,6 +781,18 @@
>> >              '*seal': 'bool' },
>> >    'if': 'CONFIG_LINUX' }
>> >  
>> > +##
>> > +# @MemoryBackendGuestMemfdProperties:
>> > +#
>> > +# Properties for memory-backend-guest-memfd objects.
>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'struct': 'MemoryBackendGuestMemfdProperties',
>> > +  'base': 'MemoryBackendProperties',
>> > +  'data': {},
>> > +  'if': 'CONFIG_LINUX' }
>> > +
>> 
>> Identical to MemoryBackendProperties so far.
>> 
>> >  ##
>> >  # @MemoryBackendShmProperties:
>> >  #
>> > @@ -1234,6 +1247,8 @@
>> >      'memory-backend-file',
>> >      { 'name': 'memory-backend-memfd',
>> >        'if': 'CONFIG_LINUX' },
>> > +    { 'name': 'memory-backend-guest-memfd',
>> > +      'if': 'CONFIG_LINUX' },
>> >      'memory-backend-ram',
>> >      { 'name': 'memory-backend-shm',
>> >        'if': 'CONFIG_POSIX' },
>> > @@ -1312,6 +1327,8 @@
>> >        'memory-backend-file':        'MemoryBackendFileProperties',
>> >        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>> >                                        'if': 'CONFIG_LINUX' },
>> > +      'memory-backend-guest-memfd': { 'type': 'MemoryBackendGuestMemfdProperties',
>> > +                                      'if': 'CONFIG_LINUX' },
>> 
>> You could use MemoryBackendProperties here, and drop
>> MemoryBackendGuestMemfdProperties, similar to how memory-backend-ram
>> is done.
>
> That's true. I think I was anticipating it being warranted at some point, but
> that doesn't need to happen here.
>
>> 
>> >        'memory-backend-ram':         'MemoryBackendProperties',
>> >        'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
>> >                                        'if': 'CONFIG_POSIX' },
>> 
>> Should we provide guidance on when to use which memory backend?  The
>> commit message provides some clues...
>
> Were you thinking from a schema perspective, or something more
> user-facing?

The QAPI schema doc comments become the QEMU QMP Reference Manual, which
I believe is the first stop for "how do I use this?"

Sometimes, a full answer just doesn't fit there comfortably.  So we put
it elsewhere, and point to it from the QMP Reference.

> Either way, docs/system/confidential-guest-support.rst could definitely
> use some sprucing up as part of this series, so I can cover this aspect
> there as well.
>
>> 
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 96ae41f787..3c754c149f 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -5858,6 +5858,11 @@ SRST
>> >          off will cause a failure during allocation because it is not supported
>> >          by this backend.
>> >  
>> > +    ``-object memory-backend-guest-memfd,id=id,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
>> > +        Creates an anonymous memory file backend object that has similar
>> > +        semantics to memfd, but is also usable as private memory when
>> > +        running as a confidential VM. (Linux only)
>> 
>> There is no object type "memfd".  Do you mean "memory-backend-memfd"?
>
> Yes, will update.
>
>> 
>> If yes, that one has additional properties @hugetlb, @hugetlbsize, and
>> @seal.  Why are they not needed for memory-backend-guest-memfd?
>
> ATM, hugetlb is not enabled for guest_memfd in the kernel. It's likely the
> same set of options will apply, but there are also efforts to do things like
> plumb DAX memory through guest_memfd for confidential VMs where maybe we end
> up needing to be a bit more flexible/creative... not sure, but it seemed
> like a good idea to give ourselves a clean slate since the support isn't
> there yet anyway.

I gather these properties cannot work today.  I agree we shouldn't add
them until they do.

> For seal, I'm not aware of any plan to support that for guest_memfd, so
> it seems like unecessary baggage to pull in.

Likewise.

> Thanks,
>
> Mike
>
>> 
>> > +
>> >      ``-object iommufd,id=id[,fd=fd]``
>> >          Creates an iommufd backend which allows control of DMA mapping
>> >          through the ``/dev/iommu`` device.
>> 


