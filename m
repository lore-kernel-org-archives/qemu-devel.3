Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2492C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:22:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9PMa-0007aS-Vi; Mon, 28 Apr 2025 10:21:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9PMV-0007ZN-2a; Mon, 28 Apr 2025 10:21:36 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhao1.liu@intel.com>)
 id 1u9PMQ-0008AM-TJ; Mon, 28 Apr 2025 10:21:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1745850091; x=1777386091;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=M/8gKPrj9UzBo44bqxU2ZtRdrkTJFsFYsgFLwZFM444=;
 b=Sh/5UBxsbHM7n2qwlwPOBEopHj0S1xhlj2Tl8QTgxkaEowYZy2RVqb8Q
 L47x5uDseeaDfBo0g7LzcD8pFMta5dByAzkvNP/5OtMiMNlNbk4SpNmkB
 yA9J5aaqLjxpYjtFMhcZazKWF7AP/J0E6/1wvWl57ufx+V8iHzEaEOOmm
 4b3pBlJnJlX5YAdHnvYVdrOYUNOevsNgZB6KBfOiSaxvrLLUvR2nxutl6
 2fmYxFWPLRYKtKW5oct/m87JM0c2L/EGM9LT18mSn6qv1DnJ/XJ29yTE7
 vHKMABoTiBKZ/cYE87nUpkuawiqtERcGqebgBWav/HYYnBzOg9JZmK9tr Q==;
X-CSE-ConnectionGUID: XveKsrQxSju6+/fAQmsrrg==
X-CSE-MsgGUID: YjXFYiHiQ4Om9ilw/VWm+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11416"; a="69942578"
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="69942578"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2025 07:21:27 -0700
X-CSE-ConnectionGUID: aui4+n6AQBygx0YSOr8INg==
X-CSE-MsgGUID: zDo3OoVIT7+i4mGbisKf6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,246,1739865600"; d="scan'208";a="137584568"
Received: from liuzhao-optiplex-7080.sh.intel.com (HELO localhost)
 ([10.239.160.39])
 by fmviesa003.fm.intel.com with ESMTP; 28 Apr 2025 07:21:22 -0700
Date: Mon, 28 Apr 2025 22:42:19 +0800
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
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
Message-ID: <aA+Ty2IqnE4zQhJv@intel.com>
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-4-zhao1.liu@intel.com>
 <87frhwfuv1.fsf@pond.sub.org> <aA3TeaYG9mNMdEiW@intel.com>
 <87h6283g9g.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6283g9g.fsf@pond.sub.org>
Received-SPF: pass client-ip=198.175.65.9; envelope-from=zhao1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Apr 28, 2025 at 09:19:07AM +0200, Markus Armbruster wrote:
> Date: Mon, 28 Apr 2025 09:19:07 +0200
> From: Markus Armbruster <armbru@redhat.com>
> Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
>  in KVM PMU filter
> 
> Zhao Liu <zhao1.liu@intel.com> writes:
> 
> > Hi Markus,
> >
> >> > +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
> >> > +            if (event->u.x86_select_umask.select > UINT12_MAX) {
> >> > +                error_setg(errp,
> >> > +                           "Parameter 'select' out of range (%d).",
> >> > +                           UINT12_MAX);
> >> > +                goto fail;
> >> > +            }
> >> > +
> >> > +            /* No need to check the range of umask since it's uint8_t. */
> >> > +            break;
> >> > +        }
> >> 
> >> As we'll see below, the new x86-specific format is defined in the QAPI
> >> schema regardless of target.
> >> 
> >> It is accepted here also regardless of target.  Doesn't matter much
> >> right now, as the object is effectively useless for targets other than
> >> x86, but I understand that will change.
> >> 
> >> Should we reject it unless the target is x86?
> >
> > I previously supposed that different architectures should implement
> > their own kvm_arch_check_pmu_filter(), which is the `check` hook of
> > object_class_property_add_link():
> >
> >     object_class_property_add_link(oc, "pmu-filter",
> >                                    TYPE_KVM_PMU_FILTER,
> >                                    offsetof(KVMState, pmu_filter),
> >                                    kvm_arch_check_pmu_filter,
> >                                    OBJ_PROP_LINK_STRONG);
> 
> This way, the checking happens only when you actually connect the
> kvm-pmu-filter object to the accelerator.
> 
> Have you considered checking in the kvm-pmu-filter object's complete()
> method?  Simple example of how to do that: qauthz_simple_complete() in
> authz/simple.c.

Thank you, I hadn't noticed it before. Now I study it carefully, and yes,
this is a better way than `check` hook. Though in the following we are
talking about other ways to handle target-specific check, this helper
may be still useful as I proposed to help check accel-specific cases in
the reply to Philip [*].

[*]: https://lore.kernel.org/qemu-devel/aA3cHIcKmt3vdkVk@intel.com/

> > For x86, I implemented kvm_arch_check_pmu_filter() in target/i386/kvm/
> > kvm.c and checked the supported formats (I also supposed arch-specific
> > PMU filter could reject the unsupported format in
> > kvm_arch_check_pmu_filter().)
> >
> > But I think your idea is better, i.e., rejecting unsupported format
> > early in pmu-filter parsing.
> >
> > Well, IIUC, there is no way to specify in QAPI that certain enumerations
> > are generic and certain enumerations are arch-specific,
> 
> Here's how to make enum values conditional:
> 
>     { 'enum': 'KvmPmuEventFormat',
>       'data': ['raw',
>                { 'name': 'x86-select-umask', 'if': 'TARGET_I386' }
>                { 'name': 'x86-masked-entry', 'if': 'TARGET_I386' } ] }

What I'm a bit hesitant about is that, if different arches add similar
"conditional" enumerations later, it could cause the enumeration values
to change under different compilation conditions (correct? :-)). Although
it might not break anything, since we don't rely on the specific numeric
values.

> However, TARGET_I386 is usable only in target-specific code.  This has
> two consequences here:
> 
> 1. It won't compile, since QAPI schema module kvm.json is
>    target-independent.  We'd have to put it into a target-specific
>    module kvm-target.json.
> 
> 2. Target-specific QAPI schema mdoules are problematic for the single
>    binary / heterogeneous machine work.  We are discussing how to best
>    handle that.  Unclear whether adding more target-specific QAPI
>    definitions are a good idea.

And per yours feedback, CONFIG_KVM can also only be used in target-specific
code. Moreover, especially if we need to further consider multiple
accelerators, such as the HVF need mentioned by Philip, it seems that
we can't avoid target-specific issues here!

> >                                                         so rejecting
> > unsupported format can only happen in parsing code. For example, wrap
> > the above code in "#if defined(TARGET_I386)":
> >
> >     for (node = head; node; node = node->next) {
> >         KvmPmuFilterEvent *event = node->value;
> >
> >         switch (event->format) {
> >         case KVM_PMU_EVENT_FORMAT_RAW:
> >             break;
> > #if defined(TARGET_I386)
> >         case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
> >             ...
> >             break;
> >         }
> >         case KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY: {
> >             ...
> > 	    break;
> >         }
> > #endif
> >         default:
> > 	    error_setg(errp,
> >                        "Unsupported format.");
> >             goto fail;
> >         }
> >
> >         ...
> >     }
> >
> > EMM, do you like this idea?
> 
> This is kvm_pmu_filter_set_event(), I presume.
>
> The #if is necessary when you make the enum values conditional.  The
> default: code is unreachable then, so it should stay
> g_assert_not_reached().
>
> The #if is fine even when you don't make the enum values conditional.
> The default: code is reachable then, unless you reject the unwanted
> enums earlier some other way.

Thanks for your analysis, it's very accurate! I personally prefer the
2nd way.

> >> If not, I feel the behavior should be noted in the commit message.
> >
> > With the above change, I think it's possible to reject x86-specific
> > format on non-x86 arch. And I can also note this behavior in commit
> > message.
> >
> >> >          default:
> >> >              g_assert_not_reached();
> >> >          }
> >> > @@ -67,6 +82,9 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
> >> >      filter->events = head;
> >> >      qapi_free_KvmPmuFilterEventList(old_head);
> >> >      return;
> >> > +
> >> > +fail:
> >> > +    qapi_free_KvmPmuFilterEventList(head);
> >> >  }
> >> >  
> >> >  static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
> >
> > ...
> >
> >> >  ##
> >> >  # @KvmPmuFilterEvent:
> >> >  #
> >> > @@ -66,7 +82,8 @@
> >> >  { 'union': 'KvmPmuFilterEvent',
> >> >    'base': { 'format': 'KvmPmuEventFormat' },
> >> >    'discriminator': 'format',
> >> > -  'data': { 'raw': 'KvmPmuRawEvent' } }
> >> > +  'data': { 'raw': 'KvmPmuRawEvent',
> >> > +            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent' } }
> >> >  
> >> >  ##
> >> >  # @KvmPmuFilterProperties:
> >> 
> >> Documentation could perhaps be more explicit about this making sense
> >> only for x86.
> >
> > What about the following doc?
> >
> > ##
> > # @KvmPmuFilterProperties:
> > #
> > # Properties of KVM PMU Filter (only for x86).
> 
> Hmm.  Branch 'raw' make sense regardless of target, doesn't it?  It's
> actually usable only for i86 so far, because this series implements
> accelerator property "pmu-filter" only for i386.

The advantage of this single note is someone can easily mention other
arch in doc :-)

> Let's not worry about this until we decided whether to use QAPI
> conditionals or not.

OK, this is not a big deal (comparing with other issues).

Thanks,
Zhao


