Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A5EC369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 16:26:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9RII-0005Nu-St; Mon, 28 Apr 2025 12:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9RIG-0005Md-1H
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:25:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u9RI7-0002o6-9l
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 12:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745857507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=26jfT4yYws4ox9C/3roTpInDX9JvbAHrajw/qRQX6u8=;
 b=YTke+g0E7yWtDE5pyW39/GfNzUOJ0Z9cwZ3KhSGuDx9ypbJesWlBzO+GXoPy0VhOv67fhO
 yRC2tKvAdRQ2mWUXlow3GWVvvuQijukd1aFSIHEitQjoxA4hpKIURGsT3TSWVp9XOqNIl1
 OjocrZqpYfOtmYTiESXRkJKbZmC07uw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-370-ReANHy3WO9utRsUTJJy7fw-1; Mon,
 28 Apr 2025 12:25:02 -0400
X-MC-Unique: ReANHy3WO9utRsUTJJy7fw-1
X-Mimecast-MFC-AGG-ID: ReANHy3WO9utRsUTJJy7fw_1745857500
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35B3E1955E79; Mon, 28 Apr 2025 16:24:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3FDA19560A3; Mon, 28 Apr 2025 16:24:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 94FBC21E66C2; Mon, 28 Apr 2025 18:24:55 +0200 (CEST)
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
 Dapeng Mi <dapeng1.mi@intel.com>,  Yi Lai <yi1.lai@intel.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pierrick.bouvier@linaro.org
Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
 in KVM PMU filter
In-Reply-To: <aA+Ty2IqnE4zQhJv@intel.com> (Zhao Liu's message of "Mon, 28 Apr
 2025 22:42:19 +0800")
References: <20250409082649.14733-1-zhao1.liu@intel.com>
 <20250409082649.14733-4-zhao1.liu@intel.com>
 <87frhwfuv1.fsf@pond.sub.org> <aA3TeaYG9mNMdEiW@intel.com>
 <87h6283g9g.fsf@pond.sub.org> <aA+Ty2IqnE4zQhJv@intel.com>
Date: Mon, 28 Apr 2025 18:24:55 +0200
Message-ID: <87ldrks17s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
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

> On Mon, Apr 28, 2025 at 09:19:07AM +0200, Markus Armbruster wrote:
>> Date: Mon, 28 Apr 2025 09:19:07 +0200
>> From: Markus Armbruster <armbru@redhat.com>
>> Subject: Re: [PATCH 3/5] i386/kvm: Support event with select & umask format
>>  in KVM PMU filter
>> 
>> Zhao Liu <zhao1.liu@intel.com> writes:
>> 
>> > Hi Markus,
>> >
>> >> > +        case KVM_PMU_EVENT_FORMAT_X86_SELECT_UMASK: {
>> >> > +            if (event->u.x86_select_umask.select > UINT12_MAX) {
>> >> > +                error_setg(errp,
>> >> > +                           "Parameter 'select' out of range (%d).",
>> >> > +                           UINT12_MAX);
>> >> > +                goto fail;
>> >> > +            }
>> >> > +
>> >> > +            /* No need to check the range of umask since it's uint8_t. */
>> >> > +            break;
>> >> > +        }
>> >> 
>> >> As we'll see below, the new x86-specific format is defined in the QAPI
>> >> schema regardless of target.
>> >> 
>> >> It is accepted here also regardless of target.  Doesn't matter much
>> >> right now, as the object is effectively useless for targets other than
>> >> x86, but I understand that will change.
>> >> 
>> >> Should we reject it unless the target is x86?
>> >
>> > I previously supposed that different architectures should implement
>> > their own kvm_arch_check_pmu_filter(), which is the `check` hook of
>> > object_class_property_add_link():
>> >
>> >     object_class_property_add_link(oc, "pmu-filter",
>> >                                    TYPE_KVM_PMU_FILTER,
>> >                                    offsetof(KVMState, pmu_filter),
>> >                                    kvm_arch_check_pmu_filter,
>> >                                    OBJ_PROP_LINK_STRONG);
>> 
>> This way, the checking happens only when you actually connect the
>> kvm-pmu-filter object to the accelerator.
>> 
>> Have you considered checking in the kvm-pmu-filter object's complete()
>> method?  Simple example of how to do that: qauthz_simple_complete() in
>> authz/simple.c.
>
> Thank you, I hadn't noticed it before. Now I study it carefully, and yes,
> this is a better way than `check` hook. Though in the following we are
> talking about other ways to handle target-specific check, this helper
> may be still useful as I proposed to help check accel-specific cases in
> the reply to Philip [*].
>
> [*]: https://lore.kernel.org/qemu-devel/aA3cHIcKmt3vdkVk@intel.com/
>
>> > For x86, I implemented kvm_arch_check_pmu_filter() in target/i386/kvm/
>> > kvm.c and checked the supported formats (I also supposed arch-specific
>> > PMU filter could reject the unsupported format in
>> > kvm_arch_check_pmu_filter().)
>> >
>> > But I think your idea is better, i.e., rejecting unsupported format
>> > early in pmu-filter parsing.
>> >
>> > Well, IIUC, there is no way to specify in QAPI that certain enumerations
>> > are generic and certain enumerations are arch-specific,
>> 
>> Here's how to make enum values conditional:
>> 
>>     { 'enum': 'KvmPmuEventFormat',
>>       'data': ['raw',
>>                { 'name': 'x86-select-umask', 'if': 'TARGET_I386' }
>>                { 'name': 'x86-masked-entry', 'if': 'TARGET_I386' } ] }
>
> What I'm a bit hesitant about is that, if different arches add similar
> "conditional" enumerations later, it could cause the enumeration values
> to change under different compilation conditions (correct? :-)). Although
> it might not break anything, since we don't rely on the specific numeric
> values.

Every binary we create contains target-specific code for at most one
target.  Therefore, different numerical encodings for different targets
are fine.

Same argument for struct members, by the way.  Consider

    { 'struct': 'CpuModelExpansionInfo',
      'data': { 'model': 'CpuModelInfo',
                'deprecated-props' : { 'type': ['str'],
                                       'if': 'TARGET_S390X' } },
      'if': { 'any': [ 'TARGET_S390X',
                       'TARGET_I386',
                       'TARGET_ARM',
                       'TARGET_LOONGARCH64',
                       'TARGET_RISCV' ] } }

This generates

    #if defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV)
    struct CpuModelExpansionInfo {
        CpuModelInfo *model;
    #if defined(TARGET_S390X)
        strList *deprecated_props;
    #endif /* defined(TARGET_S390X) */
    };
    #endif /* defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET_ARM) || defined(TARGET_LOONGARCH64) || defined(TARGET_RISCV) */

The struct's size depends on the target.  If we ever add members after
@deprecated_props, their offset depends on the target, too.

The single binary work will invalidate the "at most one target"
property.  We need to figure out how to best deal with that, but not in
this thread.

[...]


