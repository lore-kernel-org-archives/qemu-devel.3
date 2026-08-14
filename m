Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D5AC5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wutox-00088l-Sn; Fri, 14 Aug 2026 11:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wutox-00088c-7j
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:27:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wutot-0005Ay-LS
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786721262;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfIHyU2eFS4AjzfpmCV7sEwuQ6Rryx2KrHChaQ4DUgo=;
 b=Twcw343l242cCx3n02hpUI2IhrclqEl4+pXtmnKsYFJkjr8gK/b4exZMMlAMqrbeQbcy31
 pNDknUpMIanMXhLKtgnBOjdpc1XqQAuvphnrubDkT/aGzbMQIRoYa8TTcQZLPI9oRgtSz6
 B1G5+mROg0C54RGeMs8IIVU0Qz+31/M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-5xcNKWY9NTq5OX2YGz8a5Q-1; Fri,
 14 Aug 2026 11:27:39 -0400
X-MC-Unique: 5xcNKWY9NTq5OX2YGz8a5Q-1
X-Mimecast-MFC-AGG-ID: 5xcNKWY9NTq5OX2YGz8a5Q_1786721257
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 828FE1955E85; Fri, 14 Aug 2026 15:27:37 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9EC4818005B1; Fri, 14 Aug 2026 15:27:34 +0000 (UTC)
Date: Fri, 14 Aug 2026 16:27:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, jmarcin@redhat.com,
 david@kernel.org, pbonzini@redhat.com, chenyi.qiang@intel.com,
 farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <an8z4xPM6ui0-J2K@redhat.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com>
 <tjzytooy2a52jaw3rjhaph5nunc2locecvjh6dp567hdb2qrjs@zmtebtnfpv6b>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tjzytooy2a52jaw3rjhaph5nunc2locecvjh6dp567hdb2qrjs@zmtebtnfpv6b>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Aug 13, 2026 at 05:10:45PM -0500, Michael Roth wrote:
> On Thu, Aug 13, 2026 at 01:48:21PM +0100, Daniel P. Berrangé wrote:
> > On Thu, Aug 13, 2026 at 08:28:24AM -0400, Peter Xu wrote:
> > > On Thu, Aug 13, 2026 at 09:24:22AM +0100, Daniel P. Berrangé wrote:
> > > > On Wed, Aug 12, 2026 at 03:16:46PM -0500, Michael Roth wrote:
> > > > > From: Peter Xu <peterx@redhat.com>
> > > > > 
> > > > > Host backends supports guest-memfd now by detecting whether it's a
> > > > > confidential VM.  There's no way to choose it yet from the memory level to
> > > > > use it fully shared.  If we use guest-memfd, it so far always implies we
> > > > > need two layers of memory backends, while the guest-memfd only provides the
> > > > > private set of pages.
> > > > > 
> > > > > This patch introduces a way so that QEMU can consume guest memfd as the
> > > > > only source of memory to back the object (aka, fully shared).
> > > > > 
> > > > > To use the fully shared guest-memfd, one can add a memfd object with:
> > > > > 
> > > > >   -object memory-backend-memfd,guest-memfd=on,share=on
> > > > > 
> > > > > Note that share=on is required with fully shared guest_memfd.
> > > > > 
> > > > > PS: there's a trivial touch-up on fd<0 check, because the stub to create
> > > > > guest-memfd may return negative but not -1.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > > > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > > > > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > > > > ---
> > > > >  backends/hostmem-memfd.c | 56 ++++++++++++++++++++++++++++++++++++----
> > > > >  qapi/qom.json            |  6 ++++-
> > > > >  2 files changed, 56 insertions(+), 6 deletions(-)

snip

> > > > > diff --git a/qapi/qom.json b/qapi/qom.json
> > > > > index c55776af7d..ee981fc44c 100644
> > > > > --- a/qapi/qom.json
> > > > > +++ b/qapi/qom.json
> > > > > @@ -771,13 +771,17 @@

> > > > >  # @seal: if true, create a sealed-file, which will block further
> > > > >  #     resizing of the memory (default: true)
> > > > >  #
> > > > > +# @guest-memfd: if true, use guest-memfd to back the memory region.
> > > > > +#     (default: false, since: 11.2)
> > > > > +#
> > > > >  # Since: 2.12
> > > > >  ##
> > > > >  { 'struct': 'MemoryBackendMemfdProperties',
> > > > >    'base': 'MemoryBackendProperties',
> > > > >    'data': { '*hugetlb': 'bool',
> > > > >              '*hugetlbsize': 'size',
> > > > > -            '*seal': 'bool' },
> > > > > +            '*seal': 'bool',
> > > > > +            '*guest-memfd': 'bool' },
> > > > >    'if': 'CONFIG_LINUX' }
> > > > 
> > > > We're reusing the 'memory-backend-memfd' class, and then at runtime
> > > > refusing allow the user to control any of properties in
> > > > MemoryBackendProperties.
> > > 
> > > gmemfd should be able to use all ultimately.
> > > 
> > > For seal, IMHO it's already implied, kind of forced seal=on but it doesn't
> > > matter, gmemfd was introduced with sealing, at least what QEMU implies with
> > > "F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL".  So IMHO we could ignore what
> > > user selected and assume it's ON.
> 
> The naming threw me off, but looking at the actual schema description for
> 'seal', it basically implies 'fixed-size=on', which guest_memfd does
> enforce. So, aside from the question of whether to reuse the memfd backend,
> I do think it's more correct to imply seal=on for guest_memfd.
> 
> > 
> > Then we should not have a 'seal' property defined for guest memfd
> > at all. Defining a property and then ignoring it, or only ever
> > allowing 1 value to be set is a design mistake. The property should
> > not exist if it can't ever be changed by the user/app.
> 
> We have a couple examples of what seems like something similar with
> memory-backend-file,rom=on,readonly=off and
> memory-backend-*,prealloc=on,reserve=off. Granted, those seem a little
> more obvious to recognize as mutually-exclusive, but as far as the
> discussion around libvirt/mgmt/introspection: are there mechanisms in
> place already to handle cases like that? Or are these special-cases that
> would be problematic to try to handle similarly?

The difference only matters if what QEMU supports changes over
time. eg if current QEMU required 'reserve=off', but later
changed to allow either reserve=on or reserve=off, as libvirt
can't introspect the built-in runtime restriction.

> Regarding hugepage options, there will undoubtedly be kernels that support
> guest_memfd but not hugetlb, so even if we introduce
> memory-backend-guest-memfd now so that we can add options when/where it
> makes sense, libvirt/mgmt. would still need to eventually handle a
> 'hugetlb' option existing, but not necessarilly implying that the guest can
> actually use them. It seems like the issue exists in either case.

Yes, the varying kernel dependancy makes the QEMU introspection less
valuable than it would otherwise be :-(

> FWIW, I do anticipate that we will need something like
> memory-backend-guest-memfd for some of the use-cases coming down the
> pipeline, but for some stuff like CXL/HBM memory support where folks are
> talking about stuff like custom guest_memfd allocators or special-purpose
> NUMA nodes I'm not reasonably confident that memory-backend-guest-memfd won't
> itself end up being too generic of a construct and be immediately relegated
> to only handling the exact same set of options as memory-backend-memfd (give
> or take a 'seal').
> 
> Peter's suggested approach allows us to assume less about how things will
> eventually look by reusing existing options/command-lines and handling things
> underneath the covers for the more basic use-cases in the meantime. Once we
> hit cases that clearly have no business in memory-backend-memfd, we won't
> really have lost anything as far as our options to introduce
> memory-backend-guest-memfd at that point or maybe some subclass or something
> else entirely.

Hmm, if we think that even a separate memory-backend-guest-memfd is not
going to suitable / sufficiently flexible for future enhancements, that
reduces its value somewhat :-(


> > > This is indeed what Michael used to suggest, and we were discussing in
> > > previous version on which is better,
> > > 
> > > https://lore.kernel.org/r/rjqfiwh57gip3u3psqg33jhmo7ixaj2qwzupc7zdk7f3d26qnu@tglactz67ogk
> > > 
> > > The hope is this is also easier for either libvirt or most users, but
> > > please correct me if it's not the case, especially for libvirt.  The plan
> > > is when CoCo flags are provided, all things will automatically switch to a
> > > CoCo-friendly implementation within QEMU.
> > > 
> > > It also means here the guest-memfd= parameter shouldn't be needed in real
> > > CoCo contexts because they'll simply be implied (no cmdline change needed
> > > for the same "-object memory-backend-memfd" one used to use without CoCo).
> > > It's only needed for only special use of guest-memfd, in this case
> > > init-shared is the special case where CoCo doesn't use.
> > 
> > Reading all this, IMHO reusing memory-backend-memfd for the current
> > Coco support was a design mistake, it should have have a
> > memory-backend-guest-memfd object from the start.
> 
> I think your point still stands, but the current CoCo support doesn't rely
> on memory-backend-memfd, the private guest_memfd instance is handled by
> QEMU completely separately as a function of whether or not we are running
> a CoCo VM. The backends are only for shared memory, which aren't relevant
> to guest_memfd (without in-place conversion support), so users can select
> whatever they'd like.

Ah, I missed that the guest_memfd stuff for Coco is magically
handled with QEMU able to "do the right thing" there.

> However, backends like memory-backend-file tend to get used for special
> cases like persisting memory, where there is a high chance of surprises
> for users trying to make use of these sorts of things for a CoCo VM.
> That's why memory-backend-memfd is the configuration we normally suggest
> for CoCo VMs, but it's not required, since nothing stops users from
> persisting shared memory ranges if that's actually their intent.
> 
> The need to enforce the backend more explicitly becomes much more apparent
> once in-place conversion however, where even shared memory goes through
> guest-memfd and so the backend necessarily needs to be
> guest_memfd-aware. The in-place conversion series tracks this via a
> RAMBlock flag that can be set by whatever backends we decide would be
> appropriate for managing guest_memfd instances based on these
> discussions.
> 
> So, at least for users following the recommended configuration:
> 
>   qemu -object sev-snp-guest,...
>        -object memory-backend-memfd,...
> 
> they can then switch on in-place conversion via, e.g.:
> 
>   qemu -object sev-snp-guest,...,convert-in-place=on
>        -object memory-backend-memfd,...
> 
> and we can flip guest_memfd=on automatically underneath the covers
> so that both shared/private memory go through guest_memfd as
> convert-in-place would necessarily imply.

Yes, if we think we can make QEMU "do the right thing" internally
that makes a separate object much less desirable. That would
be saying that we have a tri-state,  guest_memfd=auto|on|off,
and such tri-state's would not invite a separate sub-class
design. The need for "auto" rather forces the approach you have
in this patch.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


