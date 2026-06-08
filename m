Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8928DCD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:41:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXPl-0004Bi-Oz; Mon, 08 Jun 2026 06:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXPk-0004BS-L7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:41:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXPj-0007GJ-3v
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:41:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780915261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=KlDnfxYYPLOvgN18u8kIO2tpUHCLrwNedDslwD8Ss8c=;
 b=B0YoXTSCCzKZLHik5XuzxqZdto2SHRC5q35xA29N69FVD35B1GsuFvQ5qRppIDZ9pHyFPf
 +9A6I3rIiaAnMQupOPCdTvfqOLGZ1DDk2kgxp3cLvgFc8Fo9/5p1JPCKtiC1yLjeBu4ymO
 2WFZCH6PcnuXlsZNpM+sU/kqjhP4ArA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-IbCLl7wwMnikwVmcOSXs6w-1; Mon,
 08 Jun 2026 06:40:56 -0400
X-MC-Unique: IbCLl7wwMnikwVmcOSXs6w-1
X-Mimecast-MFC-AGG-ID: IbCLl7wwMnikwVmcOSXs6w_1780915255
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 214D1195608D; Mon,  8 Jun 2026 10:40:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 65DA3765; Mon,  8 Jun 2026 10:40:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0405D21E6A01; Mon, 08 Jun 2026 12:40:52 +0200 (CEST)
Resent-To: ashish.kalra@amd.com, michael.roth@amd.com, pankaj.gupta@amd.com,
 ackerleytng@google.com, isaku.yamahata@intel.com, xiaoyao.li@intel.com,
 david@kernel.org, chao.p.peng@linux.intel.com, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:40:51 +0200
Resent-Message-ID: <87qzmhiabw.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <kvm@vger.kernel.org>,  <pbonzini@redhat.com>,
 <berrange@redhat.com>,  <pankaj.gupta@amd.com>,
 <isaku.yamahata@intel.com>,  <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>,  <david@kernel.org>,
 <ashish.kalra@amd.com>,  <ackerleytng@google.com>
Subject: Re: [PATCH RFC 04/12] accel/kvm: Add CGS option to control in-place
 conversion support
In-Reply-To: <bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
 (Michael Roth's message of "Wed, 3 Jun 2026 01:39:26 -0500")
References: <20260528000416.8161-1-michael.roth@amd.com>
 <20260528000416.8161-5-michael.roth@amd.com>
 <87wlwh5p0z.fsf@pond.sub.org>
 <bhawvkft4dhs6aq7jcajyf2zqk2fo6rta37jwit45l3z2txmh2@3yav2up5cthy>
Date: Mon, 08 Jun 2026 10:15:41 +0200
Message-ID: <87zf15la6q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On Tue, Jun 02, 2026 at 10:23:40AM +0200, Markus Armbruster wrote:
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
>> > Signed-off-by: Michael Roth <michael.roth@amd.com>
>> 
>> [...]
>> 
>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 502fafeb15..037c078799 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -1014,6 +1014,21 @@
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
>> > +#
>> > +# Since: 11.1
>> > +##
>> > +{ 'struct': 'ConfidentialGuestSupportProperties',
>> > +  'data': { '*convert-in-place': 'bool' } }
>> > +
>> >  ##
>> >  # @SevCommonProperties:
>> >  #
>> > @@ -1038,6 +1053,7 @@
>> >  # Since: 9.1
>> >  ##
>> >  { 'struct': 'SevCommonProperties',
>> > +  'base': 'ConfidentialGuestSupportProperties',
>> >    'data': { '*sev-device': 'str',
>> >              '*cbitpos': 'uint32',
>> >              'reduced-phys-bits': 'uint32',
>> 
>> Why use a base type instead of simply adding @convert-in-place to
>> SevCommonProperties?
>> 
>
> My thinking was that TDX and other implementations would similarly enable
> this through their CGS implementation, so I went ahead and carved out a
> set of common properties that ConfidentialGuestSupport implementations
> could use the same ,convert-in-place=true option (or set it by default
> for newer implementations)

How confident are we in future reuse by TDX and others?

If there are doubts, refactoring for reuse when reuse happens would be
smarter.  The refactoring would be a bit of churn, but not all that
much.

If it's something like "pretty much inevitable", preparing the reuse now
saves us that churn, and makes sense.

Judgement call, i.e. you decide.

> It is sort of tied to the 'allow_convert_in_place' flag that is part of
> the common ConfidentialGuestSupport object struct, so the property
> handling is sort of tied to the common ConfidentialGuestSupport base
> class as well rather than something implementation-specific.

Valid point.  Not sure how much weight to assign to it, though.

> Not sure if there are better ways to handle all that though.

Work your rationale into the commit message, please.


