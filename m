Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC353C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuthK-0005Vj-8z; Fri, 14 Aug 2026 11:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wuthJ-0005Va-EU
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:19:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wuthF-0003DG-Md
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 11:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786720788;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NGhAtk4Vi92yfK4L6NumTd/V0ZqhAdmO1s9WoTkn7E0=;
 b=cqV22QPHqaLqTRsxW+JqBiVA34H6kOE8vd+Y48hbpcgoMQKUU+2Vs7I24q/SIQACKUWoov
 GDXWVfzUmeEwt8iHb2C7+FzFTYuYl9iDpsAIOqZT9BUoswvD/8DvQ5iy0cQXxibTz3KjcE
 HNddonyi06atROtCNs1C9eagdNoJLJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-X0X84W_zMTyKl3VvDILqrQ-1; Fri,
 14 Aug 2026 11:19:46 -0400
X-MC-Unique: X0X84W_zMTyKl3VvDILqrQ-1
X-Mimecast-MFC-AGG-ID: X0X84W_zMTyKl3VvDILqrQ_1786720784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C311956095; Fri, 14 Aug 2026 15:19:43 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E7A030001A2; Fri, 14 Aug 2026 15:19:41 +0000 (UTC)
Date: Fri, 14 Aug 2026 16:19:38 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com, david@kernel.org, pbonzini@redhat.com,
 chenyi.qiang@intel.com, farosas@suse.de, aik@amd.com, xiaoyao.li@intel.com
Subject: Re: [PATCH v4 08/12] hostmem: Support fully shared guest memfd to
 back a VM
Message-ID: <an8yCp9qZ498aLu2@redhat.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
 <20260812201938.198915-9-michael.roth@amd.com>
 <an1_NmWhtHY_Cf9V@redhat.com> <an24aI4sAILoxncp@x1.local>
 <an29FY93x45qnJuR@redhat.com> <an3PWdPIdb6afDsS@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <an3PWdPIdb6afDsS@x1.local>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.751,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Aug 13, 2026 at 10:06:17AM -0400, Peter Xu wrote:
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

> > > > "memory-backend-memfd,guest-memfd=on|off" is switching between two
> > > > separate implementations of the class.
> > > > 
> > > > This whole thing is just shouting "use a different class".
> > > > 
> > > > There is no meaningful sharing of code here, and the sharing of the
> > > > public interface is offering apps no value as the impl prevents them
> > > > from choosing the value of the properties - they have to be set of
> > > > certain values which are not introspectable.
> > > > 
> > > > Please introduce a "memory-backend-guest-memfd" backend instead.
> > > 
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
> > 
> > Given that we need to be able to control memfd vs guest-memfd for
> > the non-Coco case, it is still worth introducing the new object
> > class today.
> > 
> > Even if the two classes shared all their properties (which they
> > don't given the comment about 'seal' being always on), then a
> > "foo=on|off" that toggles two separate impls is still creating
> > a pair of sub-classes by the backdoor. 
> 
> The idea of that, at least in my mind.. is an user shouldn't need to worry
> about differences of guest-memfd and memfd, QEMU should just do it for the
> users, based on the machine configurations.  Memfd is a concept more widely
> spread, the hope is anyone using guest-memfd should simply treat it as one
> memfd, no matter it is shared, in-place converted, two-layer-backed, or
> whatever is happening underneath.
> 
> Now we do create guest-memfd via a separate ioctl, what if we can create it
> via memfd_create() syscall too?  Then do we need to do the separation from
> QEMU layer?

If QEMU automatically did "the right thing" choosing between traditional
memfd and guest-memfd, then I wouldn't have even started this thread :-)

The "guest-memfd=on|off" is the trigger that made me think the design
was wrong from a public interface POV, as that explicitly says that the
memfd vs guest-memfd distinction is not automatic - it requires the
mgmt app to understand it and choose between them.

> IMHO that is now an ioctl is not required; it really can be part of
> memfd_create() syscall, it's just easier to manage, e.g. it's completely
> KVM alone, and it also has attached to the KVM instance.  The idea is still
> similar, and we can see that from possibly shared properties here on huge
> pages and so.  I don't treat seal= a block just to introduce a new object
> for that, and I expect as gmemfd evolves it will gradually get most
> features memfd supports.. like folio migration and so.. but I could be
> wrong.
> 
> IMHO one major question to ask is, is it more convenient for libvirt to
> have that new object?  Please keep in mind that after we introduce this as
> a new object, we may start to introduce even more *-guest-memfd in the
> future, we roughly talked about DAX in the previous discussion.  My goal is
> to make it most convenient for either user or libvirt to maintain the
> cmdlines for QEMU, but if you think that makes libvirt live harder instead,
> I've no strong feeling to go back to what Michael initially suggested.

It is no more or less difficult for libvirt to use different object
types vs using different guest-memfd=bool values.

What makes a difference for libvirt is understanding whether QEMU
implements a given feature or not.

If we have the situation with

  memory-backend-memfd,hugetlb=bool,guest-memfd=bool

with this series, IIUC,  libvirt can introspect to see the new
guest-memfd property, but it has no way of knowing that it can't
use the hugetlb proeprty when guest-memfd=on

If the next QEMU release now permits hugetlb=on at the same time
as guest-memfd=on, then libvirt has no way to know the restriction
was relaxed.

The QAPI introspection data for memory-backend-memfd is identical
in both cases.

To deal with this, you need to introduce a workaround to QAPI
by declaring a feature flag like

   features: ['hugetlb-with-guest-memfd-works']

that libvirt can probe for to determine the functional improvement
in QEMU.

By comparison, if we introduce a memory-backend-guest-memfd
object today, then it will omit the hugetlb property entirely.

If the next QEMU release adds a hugetlb property to the
memory-backend-guest-memfd object, this change is now visible
in the introspection data, and thus libvirt knows that combo
is possible with QEMU

(yes, there is the issue that this might have kernel dependancy
that is not visible from QEMU's introspection, so not perfect,
but at least libvirt can determine what QEMU is capable of)


> For example, if libvirt wants to detect hugetlb supports for an object, it
> can still pass in the parameters and test-boot a QEMU and then IIUC it'll
> still correctly capture an error for gmemfd case.  It might be that I
> didn't really get what will make libvirt complex by reusing the object, but
> I'll definitely follow your judgement on that.

Trying parameters to see if they fail and then boot again with different
options is not a viable approach. That is an indication that QEMU's
design and/or introspection is flawed.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


