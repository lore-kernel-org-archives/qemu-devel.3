Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DFCC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 16:14:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk4kf-0001sY-G9; Tue, 12 Mar 2024 12:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk4kH-0001c9-Cb
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:12:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rk4kE-0007aX-Ex
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 12:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710259968;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYuHTN5j++u3zJrH2d1fyCwaZODICudmqDWTtikX9As=;
 b=Q4cCcjfRpQ3lR8N3y6oJpZgnhBzncC0aSAvmGAb8NKgAV5bKIZmNn4s+sMKytz0/S7D+NL
 zty0NHcyZV0vK4W1U5U9I59UKk07qFBjBd0BHkpqfm8sRoviLQrnSRTyyW/JnlY2gjRVr1
 eHMWxtKRWrCCvILEInrfle4E0XWN2jo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-90ehjYPGPX-Sxdqc_JE9Qw-1; Tue, 12 Mar 2024 12:12:45 -0400
X-MC-Unique: 90ehjYPGPX-Sxdqc_JE9Qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 352391819442;
 Tue, 12 Mar 2024 16:12:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DFD61492BC6;
 Tue, 12 Mar 2024 16:12:40 +0000 (UTC)
Date: Tue, 12 Mar 2024 16:12:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH 7/9] i386/sev: Refactor setting of reset vector and
 initial CPU state
Message-ID: <ZfB-9lPyDUHv6FbG@redhat.com>
References: <cover.1709044754.git.roy.hopkins@suse.com>
 <bf045e3364a0575d9680832dec5acba7aa441895.1709044754.git.roy.hopkins@suse.com>
 <ZeIJ-3zFzj0PAvDe@redhat.com>
 <734b9e05fe7acbc7c09c323f1d78956b0394360a.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <734b9e05fe7acbc7c09c323f1d78956b0394360a.camel@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Mar 12, 2024 at 03:45:20PM +0000, Roy Hopkins wrote:
> On Fri, 2024-03-01 at 17:01 +0000, Daniel P. Berrangé wrote:
> > On Tue, Feb 27, 2024 at 02:50:13PM +0000, Roy Hopkins wrote:
> > > +            /*
> > > +             * Ideally we would provide the VMSA directly to kvm which
> > > would
> > > +             * ensure that the resulting initial VMSA measurement which is
> > > +             * calculated during KVM_SEV_LAUNCH_UPDATE_VMSA is calculated
> > > from
> > > +             * exactly what we provide here. Currently this is not possible
> > > so
> > > +             * we need to copy the parts of the VMSA structure that we
> > > currently
> > > +             * support into the CPU state.
> > > +             */
> > 
> > This sounds like it is saying that the code is not honouring
> > everything in the VMSA defiend by the IGVM file ?
> > 
> > If so, that is pretty awkward. The VMSA is effectively an external
> > ABI between QEMU and the guest owner (or whatever is validating
> > guest attestation reports for them), and thus predictability and
> > stability of this over time is critical.
> > 
> > We don't want the attestation process to be dependent/variable on
> > the particular QEMU/KVM version, because any upgrade to QEMU/KVM
> > could then alter the effective VMSA that the guest owner sees.
> > 
> > We've already suffered pain in this respect not long ago when the
> > kernel arbitrarily changed a default setting which altered the
> > VMSA it exposed, breaking existing apps that validate attestation.
> > 
> > What will it take to provide the full VMSA to KVM, so that we can
> > guarantee to the guest owner than the VMSA for the guest is going
> > to perfectly match what their IGVM defined ?
> > 
> 
> Yes, the fact that we have to copy the individual fields from the VMSA to
> "CPUX86State" is less than ideal - a problem made worse by the fact that the
> kernel does not allow direct control over some of the fields from userspace,
> "sev_features" being a good example here where "SVM_SEV_FEAT_DEBUG_SWAP" is
> unconditionally added by the kernel.

Ah yes, the SVM_SEV_FEAT_DEBUG_SWAP feature is the one I couldn't remember
the name of in my quoted text above, that break our apps when the kernel
suddenly set it by default (thankfully now reverted in Linux with
5abf6dceb066f2b02b225fd561440c98a8062681).

> The kernel VMSA is at least predictable. So, although we cannot yet allow full
> flexibility in providing a complete VMSA from QEMU and guarantee it will be
> honoured, we could check to see if any settings conflict with those imposed by
> the kernel and exit with an error if this is the case. I chose not to implement
> for this first series but could easily add a patch to support this. The problem
> here is that it ties the version of QEMU to VMSA handling functionality in the
> kernel. Any change to the VMSA handling in the kernel would potentially
> invalidate the checks in QEMU. The one upside here is that this will easily be
> detectable by the attestation measurement not matching the expected measurement
> of the IGVM file. But it will be difficult for the user to determine what the
> discrepancy is.

Yes, the difficulty in diagnosis is the big thing I'm worried about from
a distro supportability POV. The DEBUG_SWAP issue caused us a bunch of
pain and that's before CVMs are even widely used.

I agree that hardcoding checks in QEMU is pretty unpleasant, and probably
not something that I'd want us to do. I'd want QEMU to be able to live
query the kernel's default initial VMSA, if it were to be reporting
differences vs the IGVM provided VMSA. I dn't think there's a way to
do that nicely though - i only know of ftrace probes to dump it informally.

I guess if we know & document what subset of the VMSA QEMU /can/ directly
control, that at least narrows down where to look if something does change
or go wrong.

> The ideal solution is to add or modify a KVM ioctl to allow the VMSA to be set
> directly, overriding the state in "CPUX86State". The current
> KVM_SEV_LAUNCH_UPDATE_VMSA ioctl triggers the synchronisation of the VMSA but
> does not allow it to be specified directly. This could be modified for what we
> need. The SEV-SNP kernel patches add KVM_SEV_SNP_LAUNCH_UPDATE which allows a
> page type of VMSA to be updated, although the current patch series does not
> support using this to set the initial state of the VMSA:
> https://lore.kernel.org/lkml/20231230172351.574091-19-michael.roth@amd.com/ I
> have experimented with this myself and have successfully modified the SEV-SNP
> kernel patches to support directly setting the VMSA from QEMU.
> 
> On the other hand, I have also verified that I can indeed measure an IGVM file
> loaded using the VMSA synchronisation method currently employed and get a
> matching measurement from the SEV attestation report.
> 
> What would you suggest is the best way forward for this?

I'll delegate to Paolo for an opinion on the possiblity of new (or
updated) ioctls to provide the full VMSA data.

If we can't directly set the full VMSA, then next best option is a
more formal way query to VMSA. That way libvirt could report on
what the default initial kernel VMSA state is, which could be useful
debug info for any bug reports.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


