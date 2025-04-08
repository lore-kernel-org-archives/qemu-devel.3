Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBE2C3600C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Apr 2025 05:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u21rv-00014K-19; Tue, 08 Apr 2025 01:51:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u21rr-00013F-H8
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:51:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u21rn-0007wP-Vs
 for qemu-devel@nongnu.org; Tue, 08 Apr 2025 01:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744091482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KsGOnFovtOzMtwHN1EPch6+uuIN1gHUnqKOr7Ubv4J8=;
 b=EjFi+V9EjXTJJpZgYPyTv9Yipe9YDvUW33Z4aSThRgjNzf+zcwsR09gthxfcW3DzMdMH2w
 +LWjS4WCbBSd25SAJMCWjwGDxNBgqAlQ0PkoCx+y4+rOiSuPX7Cn5KV7+1HOElOlXA2XlC
 1W6KywBPAEf2ONA8PU8j3Q77YyZO/CE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-PMoa9VyhMEafLbhCzvRMtA-1; Tue,
 08 Apr 2025 01:51:18 -0400
X-MC-Unique: PMoa9VyhMEafLbhCzvRMtA-1
X-Mimecast-MFC-AGG-ID: PMoa9VyhMEafLbhCzvRMtA_1744091477
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08F811956080; Tue,  8 Apr 2025 05:51:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1B3919560AD; Tue,  8 Apr 2025 05:51:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 981EB21E6757; Tue, 08 Apr 2025 07:51:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcelo
 Tosatti <mtosatti@redhat.com>,  Shaoqin Huang <shahuang@redhat.com>,  Eric
 Auger <eauger@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,  Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>,  Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org,  kvm@vger.kernel.org,  qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
In-Reply-To: <Z+uaGHiOkFJd6TAO@intel.com> (Zhao Liu's message of "Tue, 1 Apr
 2025 15:47:36 +0800")
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org> <Z6SMxlWhHgronott@intel.com>
 <87h657p8z0.fsf@pond.sub.org> <Z6TH+ZyLg/6pgKId@intel.com>
 <87v7tlhpqj.fsf@pond.sub.org> <Z+uaGHiOkFJd6TAO@intel.com>
Date: Tue, 08 Apr 2025 07:51:13 +0200
Message-ID: <878qobqjzi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.32,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Zhao Liu <zhao1.liu@intel.com> writes:

> Hi Mrkus,
>
> I'm really sorry I completely missed your reply (and your patient
> advice). It wasn't until I looked back at the lore archives that I
> realized my mistake. Thinking it over again, I see that your reply,
> which I missed, really helped clear up my confusion:

I'm glad I was able to help some!

> On Fri, Feb 07, 2025 at 02:02:44PM +0100, Markus Armbruster wrote:
>> Date: Fri, 07 Feb 2025 14:02:44 +0100
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> >> Let's ignore how to place it for now, and focus on where we would *like*
>> >> to place it.
>> >> 
>> >> Is it related to anything other than ObjectType / ObjectOptions in the
>> >> QMP reference manual?
>> >
>> > Yes!
>> 
>> Now I'm confused :)
>> 
>> It is related to ObjectType / ObjectType.
>> 
>> Is it related to anything else in the QMP reference manual, and if yes,
>> to what exactly is it related?
>
> I misunderstood your point. The PMU stuff and the QAPI definitions for
> ObjectType/ObjectOptions are not related. They should belong to separate
> categories or sections.
>
>> >> I guess qapi/kvm.json is for KVM-specific stuff in general, not just the
>> >> KVM PMU filter.  Should we have a section for accelerator-specific
>> >> stuff, with subsections for the various accelerators?
>> >> 
>> >> [...]
>> >
>> > If we consider the accelerator from a top-down perspective, I understand
>> > that we need to add accelerator.json, kvm.json, and kvm-pmu-filter.json.
>> >
>> > The first two files are just to include subsections without any additional
>> > content. Is this overkill? Could we just add a single kvm-pmu-filter.json
>> > (I also considered this name, thinking that kvm might need to add more
>> > things in the future)?
>> >
>> > Of course, I lack experience with the file organization here. If you think
>> > the three-level sections (accelerator.json, kvm.json, and kvm-pmu-filter.json)
>> > is necessary, I am happy to try this way. :-)
>> 
>> We don't have to create files just to get a desired section structure.
>> 
>> I'll show you how in a jiffie, but before I do that, let me stress: we
>> should figure out what we want *first*, and only then how to get it.
>> So, what section structure would make the most sense for the QMP
>> reference manual?
>
> Thank you for your patience. I have revisited and carefully considered
> the "QEMU QMP Reference Manual," especially from a reader's perspective.
> Indeed, I agree that, as you mentioned, a three-level directory
> (accelerator - kvm - kvm stuff) is more readable and easier to maintain.

Sounds good to me.

> For this question "what we want *first*, and only then how to get it", I
> think my thought is:
>
> First, the structure should be considered, and then the specific content
> can be added. Once the structure is clearly defined, categorizing items
> into their appropriate places becomes a natural process...
>
> Then for this question "what section structure would make the most sense
> for the QMP reference manual?", I understand that a top-down, clearly
> defined hierarchical directory makes the most sense, allowing readers to
> follow the structure to find what they want. Directly adding
> kvm-pmu-filter.json or kvm.json would disrupt the entire structure, because
> KVM is just one of the accelerators supported by QEMU. Using "accelerator"
> as the entry point for the documentation, similar to the "accel" directory
> in QEMU's source code, would make indexing more convenient.

I think so, too.

>> A few hints on how...
>> 
>> Consider how qapi/block.json includes qapi/block-core.json:
>> 
>>     ##
>>     # = Block devices
>>     ##
>> 
>>     { 'include': 'block-core.json' }
>> 
>>     ##
>>     # == Additional block stuff (VM related)
>>     ##
>> 
>> block-core.json starts with
>> 
>>     ##
>>     # == Block core (VM unrelated)
>>     ##
>> 
>> Together, this produces this section structure
>> 
>>     = Block devices
>>     == 
>>     ##
>> 
>> Together, this produces this section structure
>> 
>>     = Block devices
>>     == Block core (VM unrelated)
>>     == Additional block stuff (VM related)
>> 
>> Note that qapi/block-core.json isn't included anywhere else.
>> qapi/qapi-schema.json advises:
>> 
>>     # Documentation generated with qapi-gen.py is in source order, with
>>     # included sub-schemas inserted at the first include directive
>>     # (subsequent include directives have no effect).  To get a sane and
>>     # stable order, it's best to include each sub-schema just once, or
>>     # include it first right here.
>
> Thank you very much!!
>
> Based on your inspiration, I think the ideal section structure for my
> issue could be:
>
>     = accelerator
>     == KVM
>     === PMU
>
> Firstly, I should have a new accelerator.json () to include KVM stuff:
>
>     ##
>     # = Accelerator
>     ##
>
>     { 'include': 'kvm.json' }
>
> Next, in kvm.json, I could organize stuffs like:
>
>     ##
>     # == KVM
>     ##
>
>     ##
>     # === PMU stuff
>     ##
>
>     ... (the below are my current QPAI definitions.)
>
> Is such a structure reasonable?

Yes.

I'm not a fan of schema files with nothing but includes, like
accelerator.json.  But the alternative here would be putting its
contents into qapi-schema.json, which I really don't like, or keeping
the KVM contents there instead of in a separate kvm.json, which would
interfere with tracking maintainers in the MAINTAINERS file.

> Thank you again for your guidance!

You're welcome!


