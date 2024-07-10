Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2351C38150
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 07:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRRZD-0003cq-3l; Wed, 10 Jul 2024 03:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRRZ5-0003BW-2e
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRRZ0-0000pv-0N
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 03:16:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720595787;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I5ay2VRUwip0nMjiuiTGOO05fCeJ7Uz6LJBILh9iWug=;
 b=RHJQ0OWinHmwkyntPU2Ef9K0DR5KBtLvl2kzaDnMPIkHxaHAGYsYcAsDnbwZakBkyRH/Be
 c5KmgLFWMOB8bfZmgXihBApT3elWn0P31OwLT3+1xtvQqjArUbu/K7ImZdbNbiNezRY/2b
 BRLcvbAU9OVRkpkx61o5fr/86FZgmxQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-aQim4U5ANZ6EETATUXyr6A-1; Wed,
 10 Jul 2024 03:16:21 -0400
X-MC-Unique: aQim4U5ANZ6EETATUXyr6A-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C75AB1954207; Wed, 10 Jul 2024 07:16:20 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 335F219560AE; Wed, 10 Jul 2024 07:16:17 +0000 (UTC)
Date: Wed, 10 Jul 2024 08:16:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH] i386/sev: Don't allow automatic fallback to legacy
 KVM_SEV*_INIT
Message-ID: <Zo41PlcMWh8Dmujm@redhat.com>
References: <20240704000019.3928862-1-michael.roth@amd.com>
 <CABgObfYX+nDnQSW5xyT3SjYbQ72--EW5buCkUuG_Z_JPFqfQNA@mail.gmail.com>
 <ZoZge_2UT_yRJE56@redhat.com>
 <CABgObfbf1u_RvRTcoZFepFWdavFnkqNwUCwHm1nE4tNKmM8+pA@mail.gmail.com>
 <ZoZtxUPdDmnFaya6@redhat.com>
 <CABgObfZwmvpHE-cadR1yu_a4pftid9=N7X50HBfeCYokLge6-g@mail.gmail.com>
 <20240710040319.6bvsy4x7mnnuxled@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710040319.6bvsy4x7mnnuxled@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 09, 2024 at 11:03:19PM -0500, Michael Roth wrote:
> On Thu, Jul 04, 2024 at 11:53:33AM +0200, Paolo Bonzini wrote:
> > On Thu, Jul 4, 2024 at 11:39 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > The debug_swap parameter simply could not be enabled in the old API
> > > > without breaking measurements. The new API *is the fix* to allow using
> > > > it (though QEMU doesn't have the option plumbed in yet). There is no
> > > > extensibility.
> > > >
> > > > Enabling debug_swap by default is also a thorny problem; it cannot be
> > > > enabled by default because not all CPUs support it, and also we'd have
> > > > the same problem that we cannot enable debug_swap on new machine types
> > > > without requiring a new kernel. Tying the default to the -cpu model
> > > > would work but it is confusing.
> > >
> > > Presumably we can tie it to '-cpu host' without much problem, and
> > > then just leave it as an opt-in feature flag for named CPU models.
> > 
> > '-cpu host' for SEV-SNP is also problematic, since CPUID is part of
> > the measurement. It's okay for starting guests in a quick and dirty
> > manner, but it cannot be used if measurement is in use.
> > 
> > It's weird to have "-cpu" provide the default for "-object", since
> > -object is created much earlier than CPUs. But then "-cpu" itself is
> > weird because it's a kind of "factory" for future objects. Maybe we
> > should redo the same exercise I did to streamline machine
> > initialization, this time focusing on -cpu/-machine/-accel, to
> > understand the various phases and where sev-{,snp-}guest
> > initialization fits.
> > 
> > > > I think it's reasonable if the fix is displayed right into the error
> > > > message. It's only needed for SEV-ES though, SEV can use the old and
> > > > new APIs interchangeably.
> > >
> > > FYI currently it is proposed to unconditionally force set legacy-vm-type=true
> > > in libvirt, so QEMU guests would *never* use the new ioctl, to fix what we
> > > consider to be a QEMU / kernel guest ABI regression.
> > 
> > Ok, so it's probably best to apply both this and your patch for now.
> > Later debug-swap can be enabled and will automatically disable
> > legacy-vm-type if the user left it to the default.
> 
> I think this seems like the ideal default behavior, where QEMU will
> continue to stick with legacy interface unless the user specifically
> enables a new option like debug-swap that relies on KVM_SEV_INIT2.
> So I reworked this patch to make legacy-vm-type an OnOffAuto field,
> where 'auto' implements the above semantics, and 'on'/'off' continue
> to behave as they do here in v1.
> 
> At the moment, since QEMU doesn't actually expose anything that requires
> KVM_SEV_INIT2 for SEV-ES, setting legacy-vm-type to 'auto' or 'on' end
> up being equivalent, but by defaulting to 'auto' things will continue to
> "just work" on the libvirt side even when new features are enabled. And
> by adding a bit of that infrastructure now it's less likely that some
> option gets exposed in a way that doesn't abide by the above semantics.
> 
> So as part of v2 I switched the default for 9.1+ to 'auto'. But if
> v1+Daniel's patch is still preferred that should be fine too.

I think your v2 patch is good on its own. It avoids the issues that
concerned me and has sensible future behaviour too.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


