Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4269FCDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 10:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wby6a-00017A-4n; Tue, 23 Jun 2026 06:11:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wby6Y-00016u-Gz
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:11:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wby6U-0006rQ-Kt
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 06:11:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782209496;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aBHi9bXKiylk3vmsG6u+WXEJLl0QOvExoOQK7DatJ8Y=;
 b=fFnWskexmdkzhtBsNtGpwOI9WJxRCJCAvQpIO+eeg/E8MSG6wLwbZ4R75Pfd4kSoFqoe16
 b144CV+uXdmqam+YXNw6qQ1t7HzbNVWfodpy2DnzquiFFWlQOsJqIa186hYzmp1dP5ux7J
 xPgXIzO/EKAWpProOp+zdCnWSi6i/nI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-235-m5DVMsCIPjWsx8bGjDLdYw-1; Tue,
 23 Jun 2026 06:11:35 -0400
X-MC-Unique: m5DVMsCIPjWsx8bGjDLdYw-1
X-Mimecast-MFC-AGG-ID: m5DVMsCIPjWsx8bGjDLdYw_1782209493
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C65FA1954237; Tue, 23 Jun 2026 10:11:32 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.133])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBC04175F; Tue, 23 Jun 2026 10:11:27 +0000 (UTC)
Date: Tue, 23 Jun 2026 11:11:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Xu <peterx@redhat.com>,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>, Fabiano Rosas <farosas@suse.de>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [RFC 4/7] system: add memory_region_new / memory_region_new_io
Message-ID: <ajpbzAUvRLetntUL@redhat.com>
References: <20260616155554.264412-1-berrange@redhat.com>
 <20260616155554.264412-5-berrange@redhat.com>
 <aa4d417e-2e61-44ef-a695-31bc19dbafd1@redhat.com>
 <9976f829-7c33-7dce-b38e-aa6f04d6ec9d@eik.bme.hu>
 <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78798c63-5ca9-4acc-a878-8638724d487c@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 19, 2026 at 06:32:27PM +0200, Paolo Bonzini wrote:
> On 6/18/26 00:44, BALATON Zoltan wrote:
> > On Wed, 17 Jun 2026, Paolo Bonzini wrote:
> > > On 6/16/26 17:55, Daniel P. Berrangé wrote:
> > > > Prepare for the move to dynamically allocated memory regions by
> > > > introducing memory_region_new and memory_region_new_io functions
> > > > which call through to object_new instead of object_initialize.
> > > 
> > > MemoryRegionOps callback will certainly access fields in the parent.
> > > Having a separate object gives you no benefit because you still have
> > > the same use-after-free if the MemoryRegion outlives the device.
> > > Likewise for buses.
> > > 
> > > If the device itself is embedded, then all the invariants must hold
> > > recursively:
> > > 
> > > - the device must be kept alive by mutual references between the
> > > device itself and its parent;
> > > 
> > > - unparent for the device should wait for all guest memory accesses
> > > to be either completed or cancelled.
> > > 
> > > So, the problem is that "QEMU automatically references the owning
> > > Device to keep the MemoryRegion alive" is a hack that should die.
> > > [...] I disagree that removing embedding will fix any bugs
> > 
> > I'm trying to understand this better. The way it originally meant to
> > work according to the memory region docs and implementation is that
> > memory region is added to an owner as a child which takes a reference
> > and when the owner is freed it will unparent its children which will
> > then get unrefed and freed as well if nothing else increased their ref
> > count.
> 
> Yes, and that's broken.
> 
> > The problem is that when something accesses the memory region it has to
> > keep the owner alive as well so instead of referencing the memory region
> > it references the owner (not directly but using memory_region_ref which
> > does this).
> 
> A mechanism to keep the owner alive exists, and it is mutual references (so
> that neither owner nor MR die) + unparent of owner (which should wait for
> pending users to complete before returning).
> 
> The fact that this mechanism is not used, i.e. unparent of a PCIDevice does
> not wait for pending BAR accesses to complete, is a bug.
> 
> > So embedding seems unrelated to this passing refs on
> > memory regions to owner and could be fixed separately that my patches
> > attempted.
> 
> Your patches add the possibility of not embedding; I don't like having two
> separate API, but I think we only have a disagreement on aesthetics.
> 
> This is different for Daniel's patches, which try to fix something by not
> embedding, and I don't think they do.

NB, I'm not claiming my patches fix all problems - foremost this was
just an initial RFC, not a fully fleshed out final solution.

>                                       Currently, if the owner dies, the
> MemoryRegion dies with it while it shouldn't (which is a problem,
> absolutely).  But these patches, while preventing the MR from dying, still
> leave around a dangling pointer to the owner from the MR, so there's not
> much gained if anything.

The mutual reference logic needs fixing regardless. These patches
simplify the modelling such that we only have a single design approach
to think about going forward.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


