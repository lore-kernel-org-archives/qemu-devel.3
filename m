Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D361FC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 18:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdsO-0005KO-Gs; Tue, 19 Mar 2024 14:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdsN-0005Ja-6a
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:07:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmdsK-0008EA-9T
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:07:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710871667;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VWp7xEBQhmkS/WPvgx1mvlXZVR4gYbNBkwlsQq0v4mw=;
 b=FG1ohEhxw5x4EF9dJej1PO84dN5ONE/zk/tiHxhktcWldSdIeBBaITJjlVT/q/VF86U4gb
 HeapjwYAV9G1yrgeUrZL+4NQXXhPkD00H4wG98r5NZxSy6va8yAY8xdkRVQVIuHcBq4l41
 CruNXOOROG10aHMpQCBZJEeyQt18two=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-q2iMwBpROIuABlfBz2jwkQ-1; Tue, 19 Mar 2024 14:07:42 -0400
X-MC-Unique: q2iMwBpROIuABlfBz2jwkQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E72285CE41;
 Tue, 19 Mar 2024 18:07:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.88])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D5AA492BD0;
 Tue, 19 Mar 2024 18:07:39 +0000 (UTC)
Date: Tue, 19 Mar 2024 18:07:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Auger <eauger@redhat.com>
Cc: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org,
 Sebastian Ott <sebott@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH v7] arm/kvm: Enable support for KVM_ARM_VCPU_PMU_V3_FILTER
Message-ID: <ZfnUZKf3p8jv2yEM@redhat.com>
References: <20240221063431.76992-1-shahuang@redhat.com>
 <ZfmtxxlATpvhK61y@redhat.com>
 <84e01fa8-0de6-4d2b-8696-53cd3c3f42fa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84e01fa8-0de6-4d2b-8696-53cd3c3f42fa@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Mar 19, 2024 at 06:58:33PM +0100, Eric Auger wrote:
> Hi Daniel,
> 
> On 3/19/24 16:22, Daniel P. Berrangé wrote:
> > On Wed, Feb 21, 2024 at 01:34:31AM -0500, Shaoqin Huang wrote:
> >> The KVM_ARM_VCPU_PMU_V3_FILTER provides the ability to let the VMM decide
> >> which PMU events are provided to the guest. Add a new option
> >> `kvm-pmu-filter` as -cpu sub-option to set the PMU Event Filtering.
> >> Without the filter, all PMU events are exposed from host to guest by
> >> default. The usage of the new sub-option can be found from the updated
> >> document (docs/system/arm/cpu-features.rst).
> >>
> >> Here is an example which shows how to use the PMU Event Filtering, when
> >> we launch a guest by use kvm, add such command line:
> >>
> >>   # qemu-system-aarch64 \
> >>         -accel kvm \
> >>         -cpu host,kvm-pmu-filter="D:0x11-0x11"
> > 
> > snip
> > 
> >> @@ -517,6 +533,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
> >>                               kvm_steal_time_set);
> >>      object_property_set_description(obj, "kvm-steal-time",
> >>                                      "Set off to disable KVM steal time.");
> >> +
> >> +    object_property_add_str(obj, "kvm-pmu-filter", kvm_pmu_filter_get,
> >> +                            kvm_pmu_filter_set);
> >> +    object_property_set_description(obj, "kvm-pmu-filter",
> >> +                                    "PMU Event Filtering description for "
> >> +                                    "guest PMU. (default: NULL, disabled)");
> >>  }
> > 
> > Passing a string property, but....[1]
> > 
> >>  
> >>  bool kvm_arm_pmu_supported(void)
> >> @@ -1706,6 +1728,62 @@ static bool kvm_arm_set_device_attr(ARMCPU *cpu, struct kvm_device_attr *attr,
> >>      return true;
> >>  }
> >>  
> >> +static void kvm_arm_pmu_filter_init(ARMCPU *cpu)
> >> +{
> >> +    static bool pmu_filter_init;
> >> +    struct kvm_pmu_event_filter filter;
> >> +    struct kvm_device_attr attr = {
> >> +        .group      = KVM_ARM_VCPU_PMU_V3_CTRL,
> >> +        .attr       = KVM_ARM_VCPU_PMU_V3_FILTER,
> >> +        .addr       = (uint64_t)&filter,
> >> +    };
> >> +    int i;
> >> +    g_auto(GStrv) event_filters;
> >> +
> >> +    if (!cpu->kvm_pmu_filter) {
> >> +        return;
> >> +    }
> >> +    if (kvm_vcpu_ioctl(CPU(cpu), KVM_HAS_DEVICE_ATTR, &attr)) {
> >> +        warn_report("The KVM doesn't support the PMU Event Filter!");
> > 
> > If the user requested a filter and it can't be supported, QEMU
> > must exit with an error, not ignore the user's request.
> > 
> >> +        return;
> >> +    }
> >> +
> >> +    /*
> >> +     * The filter only needs to be initialized through one vcpu ioctl and it
> >> +     * will affect all other vcpu in the vm.
> >> +     */
> >> +    if (pmu_filter_init) {
> >> +        return;
> >> +    } else {
> >> +        pmu_filter_init = true;
> >> +    }
> >> +
> >> +    event_filters = g_strsplit(cpu->kvm_pmu_filter, ";", -1);
> >> +    for (i = 0; event_filters[i]; i++) {
> >> +        unsigned short start = 0, end = 0;
> >> +        char act;
> >> +
> >> +        if (sscanf(event_filters[i], "%c:%hx-%hx", &act, &start, &end) != 3) {
> >> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> >> +            continue;
> > 
> > Warning on user syntax errors is undesirable - it should be a fatal
> > error of the user gets this wrong.
> > 
> >> +        }
> >> +
> >> +        if ((act != 'A' && act != 'D') || start > end) {
> >> +            warn_report("Skipping invalid PMU filter %s", event_filters[i]);
> >> +            continue;
> > 
> > Likewise should be fatal.
> > 
> >> +        }
> >> +
> >> +        filter.base_event = start;
> >> +        filter.nevents = end - start + 1;
> >> +        filter.action = (act == 'A') ? KVM_PMU_EVENT_ALLOW :
> >> +                                       KVM_PMU_EVENT_DENY;
> >> +
> >> +        if (!kvm_arm_set_device_attr(cpu, &attr, "PMU_V3_FILTER")) {
> >> +            break;
> >> +        }
> >> +    }
> >> +}
> > 
> > ..[1] then implementing a custom parser is rather a QEMU design anti-pattern,
> > especially when the proposed syntax is incapable of being mapped into the
> > normal QAPI syntax for a list of structs should we want to fully convert
> > -cpu to QAPI parsing later. I wonder if can we model this property with
> > QAPI now ?
> I guess you mean creating a new property like those in
> hw/core/qdev-properties-system.c for instance  and populating an array
> of those at CPU object level?

Yeah, something like the IOThreadVirtQueueMapping data type would
be the more QAPI like code pattern.

> Note there is v8 but most of your comments still apply
> https://lore.kernel.org/all/20240312074849.71475-1-shahuang@redhat.com/

Yes, sorry I just saw Peter's query about libvirt on this v7 and
didn't think to look for a newer version

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


