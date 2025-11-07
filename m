Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0F5CCFA05
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Nov 2025 10:00:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vHJGM-0004QQ-4t; Fri, 07 Nov 2025 05:00:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vHJGK-0004Q1-0L
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vHJGG-0004fQ-R4
 for qemu-devel@nongnu.org; Fri, 07 Nov 2025 05:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762509602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Dmmv2c/Zhjm4ukamgxhQU+o21mAuVZsjrQ062leqzZw=;
 b=RIQVrnQ1g+eXGDfm9757/2eKe2mHzah9kWumACfi9qhb2TpMCruI8gGN/85bUfrsBe7SpD
 EQIXwhrauB+D0Ow1l+zTSrUBW7H8DIt8hVk1CBSoGu1ZlzeyJ0P7beofu2lIwzYztOnA6Y
 R4bgOM0xAUrlwDAyXhsV+E2zgShQzIk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-84zePJ-aOMS3teb0xAYc7Q-1; Fri,
 07 Nov 2025 04:59:59 -0500
X-MC-Unique: 84zePJ-aOMS3teb0xAYc7Q-1
X-Mimecast-MFC-AGG-ID: 84zePJ-aOMS3teb0xAYc7Q_1762509597
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4926519560B5; Fri,  7 Nov 2025 09:59:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 829AF19560A7; Fri,  7 Nov 2025 09:59:51 +0000 (UTC)
Date: Fri, 7 Nov 2025 09:59:46 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Eric Blake <eblake@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Nikunj A Dadhania <nikunj@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>,
 Roy Hopkins <roy.hopkins@randomman.co.uk>,
 Srikanth Aithal <srikanth.aithal@amd.com>
Subject: Re: [PATCH v3 8/9] target/i386: SEV: Add support for setting TSC
 frequency for Secure TSC
Message-ID: <aQ3DEiKtuRf_bfqS@redhat.com>
References: <cover.1761648149.git.naveen@kernel.org>
 <cc40fed64f62649891bb8234daaba8a5cc926695.1761648149.git.naveen@kernel.org>
 <87cy5vgy66.fsf@pond.sub.org>
 <ot37mpc4y2oferchx6yroyriqickajnkiouok7quaaijq25c7n@cpqitwnuwyz2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ot37mpc4y2oferchx6yroyriqickajnkiouok7quaaijq25c7n@cpqitwnuwyz2>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.271,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Nov 07, 2025 at 02:21:24PM +0530, Naveen N Rao wrote:
> On Thu, Nov 06, 2025 at 01:09:37PM +0100, Markus Armbruster wrote:
> > Pardon my ignorance...
> > 
> > "Naveen N Rao (AMD)" <naveen@kernel.org> writes:
> > 
> > > Add support for configuring the TSC frequency when Secure TSC is enabled
> > > in SEV-SNP guests through a new "tsc-frequency" property on SEV-SNP
> > > guest objects, similar to the vCPU-specific property used by regular
> > > guests and TDX.
> > 
> > Which property exactly?
> 
> Same name: tsc-frequency specified with '-cpu'
> 
> > 
> > >                 A new property is needed since SEV-SNP guests require
> > > the TSC frequency to be specified during early SNP_LAUNCH_START command
> > > before any vCPUs are created.
> > 
> > Sounds awkward.
> > 
> > Do the two properties set the same thing at different times?
> 
> Yes. For regular guests, TSC frequency is set using a vCPU ioctl.  
> However, TDX and SEV-SNP (with Secure TSC) require the TSC frequency to 
> be set as a VM property (there is a VM ioctl for this purpose).

The '-cpu' arg is global to the VM, so even though the ioctl is per-VCPU,
a single '-cpu ...,tsc-frequency=NNN' argument applies universally to all
the vCPUs in regular guests. 

> This was Tom's question too (see v2): is there any way to re-use 
> 'tsc-frequency' specified with '-cpu' for Secure TSC.

I see no reason why we can't simply use the existing '-cpu tsc-frequency'
value. Fetch the CPU 0 object and query its "tsc-frequency" property,
and just assume all non-0 CPUs have the same tsc-frequency, since we
don't provide a way to set it differently per-CPU IIUC.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


