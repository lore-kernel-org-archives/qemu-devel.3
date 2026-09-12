Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200B9C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 05:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5Gfj-0000rH-8q; Sat, 12 Sep 2026 01:53:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5Gfi-0000qo-6Y
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:53:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x5Gfg-0007S9-1D
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 01:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789192379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UgljSemThQOtOsTysjE4U+NLvcvT+dhG3CA8+WOGtRY=;
 b=A2FqoytXC15b9Fos44Ek2mlS1UBYJiAW+Vq4y1fLGFIs2E5+5i8r4pqJQwIbD3EP4Ldzm0
 gaWmVQE7vyBerf1AgRibRPNSyBu9yiHWE1EgEdGQWt06zEEh593dRPWFdyHBDLATcVB4Up
 3OPGocaerfYnyCWhDoaCJTq25kmJ5x8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-4VR2GVmnOWelIIfDhX0nRA-1; Sat,
 12 Sep 2026 01:52:52 -0400
X-MC-Unique: 4VR2GVmnOWelIIfDhX0nRA-1
X-Mimecast-MFC-AGG-ID: 4VR2GVmnOWelIIfDhX0nRA_1789192366
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 864C91954B11; Sat, 12 Sep 2026 05:52:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 683AA1800345; Sat, 12 Sep 2026 05:52:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 122C821E6A04; Sat, 12 Sep 2026 07:52:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
 <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>, <lpieralisi@kernel.org>
Subject: Re: [PATCH v2 07/19] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <sudqwq5bnygtkqc2cio6rq5khrfi252jcs6jq6i3uzblgtvgq7@3upjx5k5bp7s>
 (Michael Roth's message of "Fri, 11 Sep 2026 12:22:45 -0500")
References: <20260908205236.838281-1-michael.roth@amd.com>
 <20260908205236.838281-8-michael.roth@amd.com>
 <878q5bosi3.fsf@pond.sub.org>
 <sudqwq5bnygtkqc2cio6rq5khrfi252jcs6jq6i3uzblgtvgq7@3upjx5k5bp7s>
Date: Sat, 12 Sep 2026 07:52:43 +0200
Message-ID: <87pkyj3tjo.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Roth <michael.roth@amd.com> writes:

> On Wed, Sep 09, 2026 at 08:20:36AM +0200, Markus Armbruster wrote:
>> Michael Roth <michael.roth@amd.com> writes:
>> 
>> > For confidential guests, guest_memfd is currently used only for private
>> > guest memory, and normal guest memory comes from the configured memory
>> > backend just as it does for a non-confidential guest. It is now possible
>> > to use the same physical memory to back a particular GPA regardless of
>> > whether it is in a shared or private state. This avoids the need to
>> > rely on discarding memory between shared/private conversions (to avoid
>> > doubled memory usage), and is intended to be the primary mode of using
>> > guest_memfd for confidential guests moving forward, and future features
>> > like hugepage support will likely require it.
>> >
>> > Add an option to enable this support. Since ConfidentialGuestSupport is
>> > already used to track some guest_memfd-related functionality (e.g.
>> > whether it is required for the configured machine), similarly introduce
>> > this option as a property of ConfidentialGuestSupport.
>> >
>> > Also add the KVM-specific checks to enable this support, but leave the
>> > option disabled until other required changes are implemented for
>> > CGS variants that intend to make use of KVM's in-place conversion
>> > support.
>> >
>> > While technically the convert-in-place option could be introduced as an
>> > SEV-specific option, it is a given that TDX will also be introducing
>> > in-place conversion support based on the same guest_memfd kernel
>> > infrastructure, so introduce it via a new
>> > ConfidentialGuestSupportProperties base class that other confidential VM
>> > implementations can utilized for common options.
>> >
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 909add4299..20d6fefb04 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -1005,6 +1005,21 @@
>> >    'if': 'CONFIG_IGVM',
>> >    'data': { 'file': 'str' } }
>> >  
>> > +##
>> > +# @ConfidentialGuestSupportProperties:
>> > +#
>> > +# Properties for ConfidentialGuestSupport base class.
>> > +#
>> > +# @convert-in-place: If true, the same physical pages are reused
>> > +#     when memory is converted between shared and private states.
>> > +#     If false (default), separate allocations are used depending
>> > +#     on whether the page is private or shared.
>> 
>> Any guidance on when to enable @convert-in-place?
>
> A lot of it boils down to more Confidential Compute architectures
> now requiring it for new features (hugepage support and SEV-TIO will
> require it for instance). convert-in-place=true maps more closely to
> a normal VM, and not having more complicated memory management
> requirements avoids additional complications up the stack (like
> accounting for instances where memory usage might balloon passed
> expected resource limits due to needing to management multiple
> memory allocations for a given GPA range).
>
> convert-in-place=false will likely become a legacy path unless other
> use-case arise, but they'd probably need to be super-duper useful
> to warrant enabling new things on top of it going forward.

What are the use cases for false *now*?

Can a change from false to true upset a guest?

> I'll try to work something along that line into the guest-memfd.rst
> I proposed for Peter's series and add/reference that as part of this
> patch.
>
>> 
>> > +#
>> > +# Since: 11.2
>> > +##
>> > +{ 'struct': 'ConfidentialGuestSupportProperties',
>> > +  'data': { '*convert-in-place': 'bool' } }
>> > +
>> >  ##
>> >  # @SevCommonProperties:
>> >  #

[...]


