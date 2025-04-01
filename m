Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B3DC36008
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 07:28:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzW28-0007f1-1S; Tue, 01 Apr 2025 03:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzW1x-0007e7-6f; Tue, 01 Apr 2025 03:27:29 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1tzW1u-0000pD-Pi; Tue, 01 Apr 2025 03:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743492447; x=1775028447;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=P00DF62q0qLd/W0aUFm42eTHI3bD77qudmwGeRB8KZY=;
 b=YsCgmSe5XrGl9bSP8L5bx4+diTVdwWvLZkkr9ggJjBFgLLWD9CcN3RNM
 THaUBLUUxXlSfaWH5MqVdeoGJGS23jDY7iTgDjIwO4YAG9dSXFwxVj6bk
 mEGx1wsskG2C/03Ltf70yXYlOZd2Bm/aynRFwqVkWuAhk7RawEvhmSQzD
 0f8AlN4nRu0S5kZESIaJWX9QcQ/F0hjRUp86Mthw78bZPVA08y/LwkcMY
 KYMRBUrsHDV+WwXqxC7yOMclK9hMwf8Rig/KdziLUDyvHzVAazxRUtSCp
 PCLkhgTCzOjS6aQjYWSfhmO/EtUeRKbgYmFkq54LxaY0cQfEt4dxrGia2 g==;
X-CSE-ConnectionGUID: KBMJwxWuTveY6rCFBBhd4w==
X-CSE-MsgGUID: MrdW6N0ISIm48tMGovLZRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11390"; a="67275282"
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; d="scan'208";a="67275282"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 00:27:21 -0700
X-CSE-ConnectionGUID: ZccWOwgLShqWgOHWvps2NA==
X-CSE-MsgGUID: 4EAw6vdBS0yfQ4s3rR4bKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,292,1736841600"; d="scan'208";a="131308361"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by orviesa004.jf.intel.com with ESMTP; 01 Apr 2025 00:27:17 -0700
Date: Tue, 1 Apr 2025 15:47:36 +0800
From: Zhao Liu <zhao1.liu@intel.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eauger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Sebastian Ott <sebott@redhat.com>, Gavin Shan <gshan@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Dapeng Mi <dapeng1.mi@intel.com>, Yi Lai <yi1.lai@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
Message-ID: <Z+uaGHiOkFJd6TAO@intel.com>
References: <20250122090517.294083-1-zhao1.liu@intel.com>
 <20250122090517.294083-2-zhao1.liu@intel.com>
 <871pwc3dyw.fsf@pond.sub.org> <Z6SMxlWhHgronott@intel.com>
 <87h657p8z0.fsf@pond.sub.org> <Z6TH+ZyLg/6pgKId@intel.com>
 <87v7tlhpqj.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v7tlhpqj.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.198,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
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

Hi Mrkus,

I'm really sorry I completely missed your reply (and your patient
advice). It wasn't until I looked back at the lore archives that I
realized my mistake. Thinking it over again, I see that your reply,
which I missed, really helped clear up my confusion:

On Fri, Feb 07, 2025 at 02:02:44PM +0100, Markus Armbruster wrote:
> Date: Fri, 07 Feb 2025 14:02:44 +0100
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [RFC v2 1/5] qapi/qom: Introduce kvm-pmu-filter object
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> >> Let's ignore how to place it for now, and focus on where we would *like*
> >> to place it.
> >> 
> >> Is it related to anything other than ObjectType / ObjectOptions in the
> >> QMP reference manual?
> >
> > Yes!
> 
> Now I'm confused :)
> 
> It is related to ObjectType / ObjectType.
> 
> Is it related to anything else in the QMP reference manual, and if yes,
> to what exactly is it related?

I misunderstood your point. The PMU stuff and the QAPI definitions for
ObjectType/ObjectOptions are not related. They should belong to separate
categories or sections.

> >> I guess qapi/kvm.json is for KVM-specific stuff in general, not just the
> >> KVM PMU filter.  Should we have a section for accelerator-specific
> >> stuff, with subsections for the various accelerators?
> >> 
> >> [...]
> >
> > If we consider the accelerator from a top-down perspective, I understand
> > that we need to add accelerator.json, kvm.json, and kvm-pmu-filter.json.
> >
> > The first two files are just to include subsections without any additional
> > content. Is this overkill? Could we just add a single kvm-pmu-filter.json
> > (I also considered this name, thinking that kvm might need to add more
> > things in the future)?
> >
> > Of course, I lack experience with the file organization here. If you think
> > the three-level sections (accelerator.json, kvm.json, and kvm-pmu-filter.json)
> > is necessary, I am happy to try this way. :-)
> 
> We don't have to create files just to get a desired section structure.
> 
> I'll show you how in a jiffie, but before I do that, let me stress: we
> should figure out what we want *first*, and only then how to get it.
> So, what section structure would make the most sense for the QMP
> reference manual?

Thank you for your patience. I have revisited and carefully considered
the "QEMU QMP Reference Manual," especially from a reader's perspective.
Indeed, I agree that, as you mentioned, a three-level directory
(accelerator - kvm - kvm stuff) is more readable and easier to maintain.

For this question "what we want *first*, and only then how to get it", I
think my thought is:

First, the structure should be considered, and then the specific content
can be added. Once the structure is clearly defined, categorizing items
into their appropriate places becomes a natural process...

Then for this question "what section structure would make the most sense
for the QMP reference manual?", I understand that a top-down, clearly
defined hierarchical directory makes the most sense, allowing readers to
follow the structure to find what they want. Directly adding
kvm-pmu-filter.json or kvm.json would disrupt the entire structure, because
KVM is just one of the accelerators supported by QEMU. Using "accelerator"
as the entry point for the documentation, similar to the "accel" directory
in QEMU's source code, would make indexing more convenient.

> A few hints on how...
> 
> Consider how qapi/block.json includes qapi/block-core.json:
> 
>     ##
>     # = Block devices
>     ##
> 
>     { 'include': 'block-core.json' }
> 
>     ##
>     # == Additional block stuff (VM related)
>     ##
> 
> block-core.json starts with
> 
>     ##
>     # == Block core (VM unrelated)
>     ##
> 
> Together, this produces this section structure
> 
>     = Block devices
>     == 
>     ##
> 
> Together, this produces this section structure
> 
>     = Block devices
>     == Block core (VM unrelated)
>     == Additional block stuff (VM related)
> 
> Note that qapi/block-core.json isn't included anywhere else.
> qapi/qapi-schema.json advises:
> 
>     # Documentation generated with qapi-gen.py is in source order, with
>     # included sub-schemas inserted at the first include directive
>     # (subsequent include directives have no effect).  To get a sane and
>     # stable order, it's best to include each sub-schema just once, or
>     # include it first right here.

Thank you very much!!

Based on your inspiration, I think the ideal section structure for my
issue could be:

    = accelerator
    == KVM
    === PMU

Firstly, I should have a new accelerator.json () to include KVM stuff:

    ##
    # = Accelerator
    ##

    { 'include': 'kvm.json' }

Next, in kvm.json, I could organize stuffs like:

    ##
    # == KVM
    ##

    ##
    # === PMU stuff
    ##

    ... (the below are my current QPAI definitions.)

Is such a structure reasonable?

Thank you again for your guidance!

Regards,
Zhao



