Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934C5C79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 05:56:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4uFR-0002eR-6c; Fri, 11 Sep 2026 01:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4uFN-0002eG-Ij
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 01:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x4uFK-0000iB-FU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 01:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789106180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sFNqadkEao7FskkAHUTYzdjU5AZaLTQwCEANroFoW1Q=;
 b=N+DDaTemsg79kt6n7/cl2V9Fjr+vIpAb/rIGdmUaxp8qdp89+6z0b5WElfQKKeTWvQwOaC
 zI9mukywZ/bV8W6ICvw6rW0eluBA6FyhRkgVTfk5arCznwsF6Vm3X0LB+/rvBUoB0E7Yad
 JewNRx0kmFzdjRXZ7c1EflAZPMqmcAM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-D5DWvqpfP5aWP9vc4XER1Q-1; Fri,
 11 Sep 2026 01:56:17 -0400
X-MC-Unique: D5DWvqpfP5aWP9vc4XER1Q-1
X-Mimecast-MFC-AGG-ID: D5DWvqpfP5aWP9vc4XER1Q_1789106175
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C5B01954227; Fri, 11 Sep 2026 05:56:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29B1B195608F; Fri, 11 Sep 2026 05:56:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A3CF821E6A04; Fri, 11 Sep 2026 07:56:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <pbonzini@redhat.com>,  <berrange@redhat.com>,
 <pankaj.gupta@amd.com>,  <isaku.yamahata@intel.com>,
 <xiaoyao.li@intel.com>,  <chao.p.peng@linux.intel.com>,
 <david@kernel.org>,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v5 08/12] hostmem: Support fully shared guest memfd to
 back a VM
In-Reply-To: <wli5vbctw6wxsqlxs6e5ojarvxq3xj3xv6ottjfenios2ndxld@etwnuqkbvmzf>
 (Michael Roth's message of "Thu, 10 Sep 2026 17:58:56 -0500")
References: <20260908133151.836685-1-michael.roth@amd.com>
 <20260908133151.836685-9-michael.roth@amd.com>
 <87ecf3rgb3.fsf@pond.sub.org>
 <wli5vbctw6wxsqlxs6e5ojarvxq3xj3xv6ottjfenios2ndxld@etwnuqkbvmzf>
Date: Fri, 11 Sep 2026 07:56:11 +0200
Message-ID: <87mrtobabo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Michael Roth <michael.roth@amd.com> writes:

> On Tue, Sep 08, 2026 at 04:03:28PM +0200, Markus Armbruster wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>> 
>> > From: Peter Xu <peterx@redhat.com>
>> >
>> > Host backends supports guest-memfd now by detecting whether it's a
>> > confidential VM.  There's no way to choose it yet from the memory level to
>> > use it fully shared.  If we use guest-memfd, it so far always implies we
>> > need two layers of memory backends, while the guest-memfd only provides the
>> > private set of pages.
>> >
>> > This patch introduces a way so that QEMU can consume guest memfd as the
>> > only source of memory to back the object (aka, fully shared).
>> >
>> > To use the fully shared guest-memfd, one can add a memfd object with:
>> >
>> >   -object memory-backend-memfd,guest-memfd=on,share=on
>> >
>> > Note that share=on is required with fully shared guest_memfd.
>> >
>> > PS: there's a trivial touch-up on fd<0 check, because the stub to create
>> > guest-memfd may return negative but not -1.
>> >
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
>> > Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 4a9b7f9088..909add4299 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -771,13 +771,17 @@
>> >  # @seal: if true, create a sealed-file, which will block further
>> >  #     resizing of the memory (default: true)
>> >  #
>> > +# @guest-memfd: if true, use guest-memfd to back the memory region.
>> > +#     (default: false, since: 11.2)
>> 
>> What's guest-memfd and why would I want to use it?
>
> I'm planning to squash the below documentation patch into this commit so
> it can be referenced in the schema documentation for the @guest-memfd
> option.
>
> I think it explains the "what", but the "why" is a bit awkward at this
> stage because we anticipate a lot of use-cases, and potentially it
> becoming the general default for backing guest memory that doesn't
> specifically need any functionality provided by the other
> memory-backend-* implementations, but admittedly at this stage it would
> be primarily for experimentation and getting infrastructure in place
> because there are feature gaps like hugepage/THP support that would
> prevent it from being a drop in replacement for memfd users.
>
> The first 'real' use-case will come when either one of the features
> mentioned in the documentation below (or something else) goes upstream,
> or (more likely at this point) the in-place conversion patches land and
> the @guest-memfd=on functionality becomes a requirement for Confidential
> VMs that want to run in that mode (which does have immediately tangible
> benefits like not needing to reallocate memory after every
> shared<->private conversion and will likely deprecate the existing
> out-of-place conversion mode currently used by SNP/TDX fairly quickly)).
> I plan to add that use-case to the document as well, but it seems more
> appropriate to do so in the context of the in-place conversion series
> where I can talk about it in a non-theoretical context.

Would it make sense to mark it experimental until then?  Also makes me
more willing to accept documentation gaps, and could serve as a reminder
to fill them.

I've come to ask "why would I want to use this?" more and more.  QEMU
has so many knobs to push and turn, and we provide so little guidance on
what to use them for.  Users' need for guidance is easy to miss when you
don't feel it yourself, because you're deep into the feature.

> But hopefully the below documentation is enough to at least let people
> know who should/shouldn't care about this option in the context of this
> series though. If that seems acceptable I can it into this patch for v6
> to compliment the schema documentation.

Yes, please.  Consider wrapping lines around column 70 to make it easier
to read.

[...]


