Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC48DC3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 12:21:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUmbx-00038v-La; Fri, 19 Jul 2024 08:21:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sUmbt-00030J-Ke
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:21:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sUmbr-0000p5-KY
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 08:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721391674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wdb8H9B7dXAjwpES2ljjfqGjFTVH3+0R9NofJlGwv4=;
 b=Hnpja8SMcJh5j+f0UupD0V/slIWBTC6ObgAYXWspoqKS6ds7TjPNAiaUcjRCb/SE0QdeC3
 jKxua86RiuRVVpSJP45cG+s/RV1r+/VBg1B0yUFOaBZ1pM87N1RiOlY3r/xnY/uRyrtU4U
 AGxSCSoRFApcA0AOnNl2/hTeiSNQgHo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-284-jEakaNN7NLKDTBuLuijVgA-1; Fri,
 19 Jul 2024 08:21:10 -0400
X-MC-Unique: jEakaNN7NLKDTBuLuijVgA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4DAE1955F66; Fri, 19 Jul 2024 12:21:07 +0000 (UTC)
Received: from localhost (unknown [10.22.8.77])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BDDBE1955D4D; Fri, 19 Jul 2024 12:21:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Peter Maydell
 <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: Re: [PATCH v3 2/5] target/arm/kvm: Fix PMU feature bit early
In-Reply-To: <f9cf0616-34df-42c3-a753-4dec8e2d25b5@daynix.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240716-pmu-v3-0-8c7c1858a227@daynix.com>
 <20240716-pmu-v3-2-8c7c1858a227@daynix.com>
 <CAFEAcA8tFtdpCQobU9ytzxvf3_y3DiA1TwNq8fWgFUtCUYT4hQ@mail.gmail.com>
 <f9cf0616-34df-42c3-a753-4dec8e2d25b5@daynix.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Fri, 19 Jul 2024 14:21:04 +0200
Message-ID: <87cyn9a7yn.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 19 2024, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:

> On 2024/07/18 21:07, Peter Maydell wrote:
>> On Tue, 16 Jul 2024 at 13:50, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>
>>> kvm_arm_get_host_cpu_features() used to add the PMU feature
>>> unconditionally, and kvm_arch_init_vcpu() removed it when it is actually
>>> not available. Conditionally add the PMU feature in
>>> kvm_arm_get_host_cpu_features() to save code.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> ---
>>>   target/arm/kvm.c | 7 +------
>>>   1 file changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>> index 70f79eda33cd..849e2e21b304 100644
>>> --- a/target/arm/kvm.c
>>> +++ b/target/arm/kvm.c
>>> @@ -280,6 +280,7 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>       if (kvm_arm_pmu_supported()) {
>>>           init.features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>>           pmu_supported = true;
>>> +        features |= 1ULL << ARM_FEATURE_PMU;
>>>       }
>>>
>>>       if (!kvm_arm_create_scratch_host_vcpu(cpus_to_try, fdarray, &init)) {
>>> @@ -448,7 +449,6 @@ static bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>       features |= 1ULL << ARM_FEATURE_V8;
>>>       features |= 1ULL << ARM_FEATURE_NEON;
>>>       features |= 1ULL << ARM_FEATURE_AARCH64;
>>> -    features |= 1ULL << ARM_FEATURE_PMU;
>>>       features |= 1ULL << ARM_FEATURE_GENERIC_TIMER;
>>>
>>>       ahcf->features = features;
>>> @@ -1888,13 +1888,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>>>       if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
>>>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
>>>       }
>>> -    if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
>>> -        cpu->has_pmu = false;
>>> -    }
>>>       if (cpu->has_pmu) {
>>>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PMU_V3;
>>> -    } else {
>>> -        env->features &= ~(1ULL << ARM_FEATURE_PMU);
>>>       }
>>>       if (cpu_isar_feature(aa64_sve, cpu)) {
>>>           assert(kvm_arm_sve_supported());
>> 
>> Not every KVM CPU is necessarily the "host" CPU type.
>> The "cortex-a57" and "cortex-a53" CPU types will work if you
>> happen to be on a host of that CPU type, and they don't go
>> through kvm_arm_get_host_cpu_features().
>
> kvm_arm_vcpu_init() will emit an error in such a situation and I think 
> it's better than silently removing a feature that the requested CPU type 
> has. A user can still disable the feature if desired.

OTOH, if we fail for the named cpu models if the kernel does not provide
the cap, but silently disable for the host cpu model in that case, that
also seems inconsistent. I'd rather keep it as it is now.


