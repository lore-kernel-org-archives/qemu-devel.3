Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88722C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYreE-0007Eb-9E; Mon, 07 Jul 2025 15:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYre9-0007Cs-8t
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:37:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uYre7-00067z-Hl
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751917018;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UwKxTzM8ezx3ZqRSIcYtFWtjcWJDUNDfp+NLnX0RCdU=;
 b=hOeADz0o8spz8x3R+MmB5rlxbw6EBaftx0P28LRVZxJmsopXjrpXM5UomcEhRzh3hg+Aw6
 fYLFOOfEE5P9Ecstc75QeQ0o1cBJbKQLro44igKjLXkLTBCN3mfGAqvaJLrwQia+rrBFdr
 7mGnChC3/F67ee5X6LdIj184+BBNjYo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-DZLBptDUNE65nm1l5_zzkQ-1; Mon,
 07 Jul 2025 15:36:54 -0400
X-MC-Unique: DZLBptDUNE65nm1l5_zzkQ-1
X-Mimecast-MFC-AGG-ID: DZLBptDUNE65nm1l5_zzkQ_1751917012
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2E99B1801226; Mon,  7 Jul 2025 19:36:52 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.155])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98CE3195608F; Mon,  7 Jul 2025 19:36:49 +0000 (UTC)
Date: Mon, 7 Jul 2025 20:36:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 Alexandre Chartre <alexandre.chartre@oracle.com>,
 qemu-stable@nongnu.org, zhao1.liu@intel.com, konrad.wilk@oracle.com,
 boris.ostrovsky@oracle.com, qemu-devel@nongnu.org, pbonzini@redhat.com
Subject: Re: [PATCH] i386/cpu: ARCH_CAPABILITIES should not be advertised on
 AMD
Message-ID: <aGwhzh9cGAHmns8k@redhat.com>
References: <20250630133025.4189544-1-alexandre.chartre@oracle.com>
 <3a9c8152-3202-4962-a1fe-a2d7fdc33b76@intel.com>
 <36facfce-99a4-49ba-bdf9-9df6773ac723@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <36facfce-99a4-49ba-bdf9-9df6773ac723@maciej.szmigiero.name>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jul 01, 2025 at 11:25:36AM +0200, Maciej S. Szmigiero wrote:
> On 1.07.2025 10:23, Xiaoyao Li wrote:
> > On 6/30/2025 9:30 PM, Alexandre Chartre wrote:
> > > KVM emulates the ARCH_CAPABILITIES on x86 for both Intel and AMD
> > > cpus, although the IA32_ARCH_CAPABILITIES MSR is an Intel-specific
> > > MSR and it makes no sense to emulate it on AMD.
> > > 
> > > As a consequence, VMs created on AMD with qemu -cpu host and using
> > > KVM will advertise the ARCH_CAPABILITIES feature and provide the
> > > IA32_ARCH_CAPABILITIES MSR. This can cause issues (like Windows BSOD)
> > > as the guest OS might not expect this MSR to exist on such cpus (the
> > > AMD documentation specifies that ARCH_CAPABILITIES feature and MSR
> > > are not defined on the AMD architecture).
> > > 
> > > A fix was proposed in KVM code, however KVM maintainers don't want to
> > > change this behavior that exists for 6+ years and suggest changes to be
> > > done in qemu instead.
> > > 
> > > So this commit changes the behavior in qemu so that ARCH_CAPABILITIES
> > > is not provided by default on AMD cpus when the hypervisor emulates it,
> > > but it can still be provided by explicitly setting arch-capabilities=on.
> > > 
> > > Signed-off-by: Alexandre Chartre <alexandre.chartre@oracle.com>
> > > ---
> > >   target/i386/cpu.c | 14 ++++++++++++++
> > >   1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 0d35e95430..7e136c48df 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -8324,6 +8324,20 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
> > >           }
> > >       }
> > > +    /*
> > > +     * For years, KVM has inadvertently emulated the ARCH_CAPABILITIES
> > > +     * MSR on AMD although this is an Intel-specific MSR; and KVM will
> > > +     * continue doing so to not change its ABI for existing setups.
> > > +     *
> > > +     * So ensure that the ARCH_CAPABILITIES MSR is disabled on AMD cpus
> > > +     * to prevent providing a cpu with an MSR which is not supposed to
> > > +     * be there, unless it was explicitly requested by the user.
> > > +     */
> > > +    if (IS_AMD_CPU(env) &&
> > > +        !(env->user_features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_CAPABILITIES)) {
> > > +        env->features[FEAT_7_0_EDX] &= ~CPUID_7_0_EDX_ARCH_CAPABILITIES;
> > > +    }
> > 
> > This changes the result for the existing usage of "-cpu host" on AMD. So it will need a compat_prop to keep the old behavior for old machine.
> 
> Do we really add machine compat props for CPUID flags?
> 
> I thought CPUID flags aren't live migrated but the target QEMU uses whatever it was launched with (and the target machine exposes)?

The vast majority of the time we require compat props for guest visible
changes, to guarantee stable guest ABI across reboots with different
QEMU versions.

"-cpu host" is a bit of a special case though, because it is impossible
for QEMU to provide any ABI guarantee for the CPUID exposed by '-cpu host'
It can vary based on CPU silicon, firmware settings, microcode version,
KVM version and QEMU version. Any user of '-cpu host' has to expect that
variance, and so only if every single component  in the stack is identical
can they expect a matched CPUID for '-cpu host' between 2 cold boot attempts
of the guest.

So provided the proposed patch *exclusively* impacts '-cpu host', and NOT
any of the named CPU models, we can likely avoid adding compat props.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


