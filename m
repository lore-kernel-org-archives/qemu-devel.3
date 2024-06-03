Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C8FC25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 10:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE4lD-0005ro-Qg; Mon, 03 Jun 2024 06:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4lB-0005rJ-N0
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:17:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sE4l9-0002Aw-MH
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 06:17:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717409866;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=s5DBlwkI2WM3lHwT4+BVJo4ylQjIpB9aT62gUQDTlOg=;
 b=L/f7w4cKXEj6qXwQV9EtYot6gWE4vEFMHpCt6u6xjdy0qRxJNYllWqy96B42UaKSWy4uo+
 s0q3sL+Wwvg4pAKfCMok6OuPfmh5Zer5pgGVU2g1JK/7OTgtKQ9oEOgTT5ms/rixF3MXXg
 lkidRqDionWTMtok63fE2e6EAsQWrsI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-bPBAIcXQPlqOKnP3NDIXoA-1; Mon,
 03 Jun 2024 06:17:43 -0400
X-MC-Unique: bPBAIcXQPlqOKnP3NDIXoA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0A43629AA382;
 Mon,  3 Jun 2024 10:17:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 668C7287A;
 Mon,  3 Jun 2024 10:17:40 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:17:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V1 17/26] machine: memfd-alloc option
Message-ID: <Zl2YQhv97Ez3_FGn@redhat.com>
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-18-git-send-email-steven.sistare@oracle.com>
 <ZlZIoiH5Dj4XBbLO@x1n>
 <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <79a8023d-2e19-4d80-821d-a03818a5372e@oracle.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Wed, May 29, 2024 at 01:31:38PM -0400, Steven Sistare wrote:
> On 5/28/2024 5:12 PM, Peter Xu wrote:
> > On Mon, Apr 29, 2024 at 08:55:26AM -0700, Steve Sistare wrote:
> > > Allocate anonymous memory using memfd_create if the memfd-alloc machine
> > > option is set.
> > > 
> > > Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> > > ---
> > >   hw/core/machine.c   | 22 ++++++++++++++++++++++
> > >   include/hw/boards.h |  1 +
> > >   qemu-options.hx     |  6 ++++++
> > >   system/memory.c     |  9 ++++++---
> > >   system/physmem.c    | 18 +++++++++++++++++-
> > >   system/trace-events |  1 +
> > >   6 files changed, 53 insertions(+), 4 deletions(-)

> > > diff --git a/qemu-options.hx b/qemu-options.hx
> > > index cf61f6b..f0dfda5 100644
> > > --- a/qemu-options.hx
> > > +++ b/qemu-options.hx
> > > @@ -32,6 +32,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
> > >       "                vmport=on|off|auto controls emulation of vmport (default: auto)\n"
> > >       "                dump-guest-core=on|off include guest memory in a core dump (default=on)\n"
> > >       "                mem-merge=on|off controls memory merge support (default: on)\n"
> > > +    "                memfd-alloc=on|off controls allocating anonymous guest RAM using memfd_create (default: off)\n"
> > >       "                aes-key-wrap=on|off controls support for AES key wrapping (default=on)\n"
> > >       "                dea-key-wrap=on|off controls support for DEA key wrapping (default=on)\n"
> > >       "                suppress-vmdesc=on|off disables self-describing migration (default=off)\n"
> > > @@ -79,6 +80,11 @@ SRST
> > >           supported by the host, de-duplicates identical memory pages
> > >           among VMs instances (enabled by default).
> > > +    ``memfd-alloc=on|off``
> > > +        Enables or disables allocation of anonymous guest RAM using
> > > +        memfd_create.  Any associated memory-backend objects are created with
> > > +        share=on.  The memfd-alloc default is off.
> > > +
> > >       ``aes-key-wrap=on|off``
> > >           Enables or disables AES key wrapping support on s390-ccw hosts.
> > >           This feature controls whether AES wrapping keys will be created
> > > diff --git a/system/memory.c b/system/memory.c
> > > index 49f1cb2..ca04a0e 100644
> > > --- a/system/memory.c
> > > +++ b/system/memory.c
> > > @@ -1552,8 +1552,9 @@ bool memory_region_init_ram_nomigrate(MemoryRegion *mr,
> > >                                         uint64_t size,
> > >                                         Error **errp)
> > >   {
> > > +    uint32_t flags = current_machine->memfd_alloc ? RAM_SHARED : 0;
> > 
> > If there's a machine option to "use memfd for allocations", then it's
> > shared mem... Hmm..
> > 
> > It is a bit confusing to me in quite a few levels:
> > 
> >    - Why memory allocation method will be defined by a machine property,
> >      even if we have memory-backend-* which should cover everything?
> 
> Some memory regions are implicitly created, and have no explicit representation
> on the qemu command line.  memfd-alloc affects those.
> 
> More generally, memfd-alloc affects all ramblock allocations that are
> not explicitly represented by memory-backend object.  Thus the simple
> command line "qemu -m 1G" does not explicitly describe an object, so it
> goes through the anonymous allocation path, and is affected by memfd-alloc.
> 
> Internally, create_default_memdev does create a memory-backend object.
> That is what my doc comment above refers to:
>   Any associated memory-backend objects are created with share=on
> 
> An explicit "qemu -object memory-backend-*" is not affected by memfd-alloc.
> 
> The qapi comments in patch "migration: cpr-exec mode" attempt to say all that:
> 
> +#     Memory backend objects must have the share=on attribute, and
> +#     must be mmap'able in the new QEMU process.  For example,
> +#     memory-backend-file is acceptable, but memory-backend-ram is
> +#     not.
> +#
> +#     The VM must be started with the '-machine memfd-alloc=on'
> +#     option.  This causes implicit ram blocks -- those not explicitly
> +#     described by a memory-backend object -- to be allocated by
> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
> +#     RAM when it is specified without a memory-backend object.
> 
> >    - Even if we have such a machine property, why setting "memfd" will
> >      always imply shared?  why not private?  After all it's not called
> >      "memfd-shared-alloc", and we can create private mappings using
> >      e.g. memory-backend-memfd,share=off.
> 
> There is no use case for memfd-alloc with share=off, so no point IMO in
> making the option more verbose.  For cpr, the mapping with all its modifications
> must be visible to new qemu when qemu mmaps it.


So IIUC, cpr doesn't care about the use of 'memfd' as the specific impl,
it only cares that the memory is share=on.

Rather than having a machine type option "memfd-alloc" which is named after
a Linux specific impl detail, how about having a machine type option
"mem-share=on", which just happens to trigger use of memfd internally on
Linux ? That gives us freedom to use non-memfd options if appropriate in
the future.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


