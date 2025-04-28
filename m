Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E471DC36005
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 07:26:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Isp-0004nt-GJ; Mon, 28 Apr 2025 03:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9IsX-0004hE-TP
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:26:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9IsS-0008DW-I8
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 03:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745825167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ep5vsTDMIvlMOpMmlujwECawCCp8PH/R3i2HglWtj1U=;
 b=ixGMDb7liLKJjK4T+oAeWU2oOXWF4wQSZ1CQf/8fhYsp/pPS+v1bcRfa0ss90P1rwlhe30
 pkogBkQcTmscnrinju9iVW08fmKbvNPg8He3mUvu85/Rx4UhYGxlgKSejkK/ha/kdXOAyp
 hmKR3+dR8VcbULo7QnVIa2Wv2+q5DwI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-A1i62NlANvOIKNqsvKAyjw-1; Mon,
 28 Apr 2025 03:26:03 -0400
X-MC-Unique: A1i62NlANvOIKNqsvKAyjw-1
X-Mimecast-MFC-AGG-ID: A1i62NlANvOIKNqsvKAyjw_1745825162
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8DDA1800ECA; Mon, 28 Apr 2025 07:26:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E450830001AB; Mon, 28 Apr 2025 07:26:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A93121E6682; Mon, 28 Apr 2025 09:19:07 +0200 (CEST)
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
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <aA3TeaYG9mNMdEiW@intel.com> (Zhao Liu's message of "Sun, 27 Apr
 2025 14:49:29 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-4-zhao1.liu@intel.com>
 <87frhwfuv1.fsf@pond.sub.org> <aA3TeaYG9mNMdEiW@intel.com>
Date: Mon, 28 Apr 2025 09:19:07 +0200
Message-ID: <87h6283g9g.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.492,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> Hi Markus,
>
>> > +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
>> > +            if (event->u.x86_select_umask.select > UINT12_MAX) {
>> > +                error_setg(errp,
>> > +                           "Parameter 'select' out of range (%d).",
>> > +                           UINT12_MAX);
>> > +                goto fail;
>> > +            }
>> > +
>> > +            /* No need to check the range of umask since it's uint8_t. */
>> > +            break;
>> > +        }
>> 
>> As we'll see below, the new x86-specific format is defined in the QAPI
>> schema regardless of target.
>> 
>> It is accepted here also regardless of target.  Doesn't matter much
>> right now, as the object is effectively useless for targets other than
>> x86, but I understand that will change.
>> 
>> Should we reject it unless the target is x86?
>
> I previously supposed that different architectures should implement
> their own kvm_arch_check_pmu_filter(), which is the `check` hook of
> object_class_property_add_link():
>
>     object_class_property_add_link(oc, "pmu-filter",
>                                    TYPE_KVM_PMU_FILTER,
>                                    offsetof(KVMState, pmu_filter),
>                                    kvm_arch_check_pmu_filter,
>                                    OBJ_PROP_LINK_STRONG);

This way, the checking happens only when you actually connect the
kvm-pmu-filter object to the accelerator.

Have you considered checking in the kvm-pmu-filter object's complete()
method?  Simple example of how to do that: qauthz_simple_complete() in
authz/simple.c.

> For x86, I implemented kvm_arch_check_pmu_filter() in target/i386/kvm/
> kvm.c and checked the supported formats (I also supposed arch-specific
> PMU filter could reject the unsupported format in
> kvm_arch_check_pmu_filter().)
>
> But I think your idea is better, i.e., rejecting unsupported format
> early in pmu-filter parsing.
>
> Well, IIUC, there is no way to specify in QAPI that certain enumerations
> are generic and certain enumerations are arch-specific,

Here's how to make enum values conditional:

    { 'enum': 'KvmPmuEventFormat',
      'data': ['raw',
               { 'name': 'x86-select-umask', 'if': 'TARGET_I386' }
               { 'name': 'x86-masked-entry', 'if': 'TARGET_I386' } ] }

However, TARGET_I386 is usable only in target-specific code.  This has
two consequences here:

1. It won't compile, since QAPI schema module kvm.json is
   target-independent.  We'd have to put it into a target-specific
   module kvm-target.json.

2. Target-specific QAPI schema mdoules are problematic for the single
   binary / heterogeneous machine work.  We are discussing how to best
   handle that.  Unclear whether adding more target-specific QAPI
   definitions are a good idea.

>                                                         so rejecting
> unsupported format can only happen in parsing code. For example, wrap
> the above code in "#if defined(TARGET_I386)":
>
>     for (node = head; node; node = node->next) {
>         KvmPmuFilterEvent *event = node->value;
>
>         switch (event->format) {
>         case KVM_PMU_EVENT_FORMAT_RAW:
>             break;
> #if defined(TARGET_I386)
>         case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
>             ...
>             break;
>         }
>         case KVM_PMU_EVENT_FORMAT_X86_MASKED_ENTRY: {
>             ...
> 	    break;
>         }
> #endif
>         default:
> 	    error_setg(errp,
>                        "Unsupported format.");
>             goto fail;
>         }
>
>         ...
>     }
>
> EMM, do you like this idea?

This is kvm_pmu_filter_set_event(), I presume.

The #if is necessary when you make the enum values conditional.  The
default: code is unreachable then, so it should stay
g_assert_not_reached().

The #if is fine even when you don't make the enum values conditional.
The default: code is reachable then, unless you reject the unwanted
enums earlier some other way.

>> If not, I feel the behavior should be noted in the commit message.
>
> With the above change, I think it's possible to reject x86-specific
> format on non-x86 arch. And I can also note this behavior in commit
> message.
>
>> >          default:
>> >              g_assert_not_reached();
>> >          }
>> > @@ -67,6 +82,9 @@ static void kvm_pmu_filter_set_event(Object *obj, Visitor *v, const char *name,
>> >      filter->events = head;
>> >      qapi_free_KvmPmuFilterEventList(old_head);
>> >      return;
>> > +
>> > +fail:
>> > +    qapi_free_KvmPmuFilterEventList(head);
>> >  }
>> >  
>> >  static void kvm_pmu_filter_class_init(ObjectClass *oc, void *data)
>
> ...
>
>> >  ##
>> >  # @KvmPmuFilterEvent:
>> >  #
>> > @@ -66,7 +82,8 @@
>> >  { 'union': 'KvmPmuFilterEvent',
>> >    'base': { 'format': 'KvmPmuEventFormat' },
>> >    'discriminator': 'format',
>> > -  'data': { 'raw': 'KvmPmuRawEvent' } }
>> > +  'data': { 'raw': 'KvmPmuRawEvent',
>> > +            'x86-select-umask': 'KvmPmuX86SelectUmaskEvent' } }
>> >  
>> >  ##
>> >  # @KvmPmuFilterProperties:
>> 
>> Documentation could perhaps be more explicit about this making sense
>> only for x86.
>
> What about the following doc?
>
> ##
> # @KvmPmuFilterProperties:
> #
> # Properties of KVM PMU Filter (only for x86).

Hmm.  Branch 'raw' make sense regardless of target, doesn't it?  It's
actually usable only for i86 so far, because this series implements
accelerator property "pmu-filter" only for i386.

Let's not worry about this until we decided whether to use QAPI
conditionals or not.

>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 51a7c61ce0b0..5dcce067d8dd 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -6180,6 +6180,9 @@ SRST
>> >               ((select) & 0xff) | \
>> >               ((umask) & 0xff) << 8)
>> >  
>> > +        ``{"format":"x86-select-umask","select":event_select,"umask":event_umask}``
>> > +            Specify the single x86 PMU event with select and umask fields.
>> > +
>> >          An example KVM PMU filter object would look like:
>> >  
>> >          .. parsed-literal::
>> > diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
>> > index fa3a696654cb..0d36ccf250ed 100644
>> > --- a/target/i386/kvm/kvm.c
>> > +++ b/target/i386/kvm/kvm.c
>> > @@ -5974,6 +5974,10 @@ static bool kvm_config_pmu_event(KVMPMUFilter *filter,
>> >          case KVM_PMU_EVENT_FORMAT_RAW:
>> >              code = event->u.raw.code;
>> >              break;
>> > +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
>> > +            code = X86_PMU_RAW_EVENT(event->u.x86_select_umask.select,
>> > +                                     event->u.x86_select_umask.umask);
>> > +            break;
>> >          default:
>> >              g_assert_not_reached();
>> >          }
>> > @@ -6644,6 +6648,7 @@ static void kvm_arch_check_pmu_filter(const Object *obj, const char *name,
>> >  
>> >          switch (event->format) {
>> >          case KVM_PMU_EVENT_FORMAT_RAW:
>> > +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK:
>
> Here's the current format check I mentioned above. But I agree your idea
> and will check in the parsing of pmu-filter object.
>
>> >              break;
>> >          default:
>> >              error_setg(errp,
>> 


