Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 11:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9i7-0007wZ-Sj; Fri, 28 Jun 2024 07:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN9i7-0007wL-BG
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:24:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN9i5-0007e7-GI
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 07:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719573848;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pWJku2JMz2ui+sxKLTOGxC7iW5eKu7vV1hR7tyySopA=;
 b=dH+IFmpwtPFxTRC0pzSnMPAlYz/rtVaCNpYJXqkqR7AVgxPAimJDK/lDWZORlp6lzvWuxv
 2W4SBrhe22ffyBpKouw+LUyEj2NAPPhOQTljMoIjD/7LsnHCMGhqtINxSexNxmGJJmNrKC
 w8U/pfySPauGfqAnsgZu4DSOikJ4+d4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-aZFkDRyENeyOEpDSDAWxJg-1; Fri,
 28 Jun 2024 07:24:05 -0400
X-MC-Unique: aZFkDRyENeyOEpDSDAWxJg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 03463197731D; Fri, 28 Jun 2024 11:24:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87FAA300021A; Fri, 28 Jun 2024 11:23:56 +0000 (UTC)
Date: Fri, 28 Jun 2024 12:23:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 04/15] hw/core/machine: Add igvm-cfg object and
 processing for IGVM files
Message-ID: <Zn6dSd6NiZl0_NeK@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <1b2fe6b03cba51f2f64c899163b9a0b7eea35b47.1718979106.git.roy.hopkins@suse.com>
 <Znl74gNWUQQxR_oE@redhat.com>
 <2171f08dc6630e20201d04cd96f84366111fae20.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2171f08dc6630e20201d04cd96f84366111fae20.camel@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.206,
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

On Fri, Jun 28, 2024 at 12:09:59PM +0100, Roy Hopkins wrote:
> On Mon, 2024-06-24 at 15:00 +0100, Daniel P. Berrangé wrote:
> > On Fri, Jun 21, 2024 at 03:29:07PM +0100, Roy Hopkins wrote:
> > > An IGVM file contains configuration of guest state that should be
> > > applied during configuration of the guest, before the guest is started.
> > > 
> > > This patch allows the user to add an igvm-cfg object to the machine
> > > configuration that allows an IGVM file to be configured that will be
> > > applied to the guest before it is started.
> > > 
> > > If an IGVM configuration is provided then the IGVM file is processed at
> > > the end of the board initialization, before the state transition to
> > > PHASE_MACHINE_INITIALIZED.
> > > 
> > > Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> > > ---
> > >  include/hw/boards.h |  2 ++
> > >  hw/core/machine.c   | 20 ++++++++++++++++++++
> > >  qemu-options.hx     | 25 +++++++++++++++++++++++++
> > >  3 files changed, 47 insertions(+)

snip

> > This adds igvm-cfg for all machines, regardless of architecture target.
> > 
> > Are igvm files fully cross-platform portable, or should we just put
> > this into the TYPE_X86_MACHINE base class to limit it ?
> > 
> > It at least reports errors if I try to load an IGVM file with
> > qemu-system-aarch64 + virt type
> > 
> > $ ./build/qemu-system-aarch64 -object igvm-cfg,file=../buildigvm/ovmf-
> > sev.igvm,id=igvm -machine virt,igvm-cfg=igvm
> > qemu-system-aarch64: IGVM file does not describe a compatible supported
> > platform
> > 
> > so that's good.
> 
> The IGVM specification is designed to support non X86 platforms, hence its
> inclusion for all machines. Support for non-X86 is likely to result in changes
> to the specification though that will impact the library we depend on.
> 
> There would obviously need to be some further implementation to support non-X86
> machines in QEMU, in the same way that further implementation is required to
> support other X86 confidential computing platforms such as TDX.
> 
> So, this poses the question: should we move it to TYPE_X86_MACHINE as the
> current supported platforms are all on X86? Or should we leave it where it is
> with a view to adding non X86 platform support with less impact later? I'd
> appreciate your views on this.

The pro of putting it in the base machine class is that we don't need to
repeat the property creation in each machine as we broaden support to other
arches, I presume aarch64 is probably most likely future candidate.

The downside of putting it in the base machine class is that it limits
mgmt app ability to probe QEMU for support. ie it wouldn't be possible
to probe whether individual machines support it or not, as we broaden
QEMU support.

Then again, we will already face that limited ability to probe even on
x86, as we won't be able to query whether IGVM is SNP only, or has been
extended to TDX too.

With my libvirt hat on, probing is still probably the more important
factor, so would push towards putting the property just to individual
machine classes that definitely have been wired up to be able to use
it.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


