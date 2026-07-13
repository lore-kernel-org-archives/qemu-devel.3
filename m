Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B17C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:35:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj9JM-0005dg-Ht; Mon, 13 Jul 2026 01:34:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj9JK-0005d4-VX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:34:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj9JI-0007Qo-Sk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:34:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783920872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
 b=SCbU/4rhYTItxmbujV5axREtQ9cMq1giA7eDzSw71uqMAH7EemN91JRMcH6Y+Gn3SFoHRc
 6T+twm94B4cTR/NOeQiRo24DTNpK4CxYAVSShu6LtJ0wVeUved6BHHXio1KmTsT3a1S8Fv
 P2e5WeOi5OLU7sZg5aeTzGyYpzZhWFo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-1M372xLMOduvPdhfgEIekg-1; Mon, 13 Jul 2026 01:34:30 -0400
X-MC-Unique: 1M372xLMOduvPdhfgEIekg-1
X-Mimecast-MFC-AGG-ID: 1M372xLMOduvPdhfgEIekg_1783920869
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so58027195ad.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783920869; x=1784525669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
 b=r2I8gvV1HgVy86nO7OHxmmwHCKDeVb09PsK122bZTN02sUCfDdPBzRCYttCu2rNt31
 cyQCxJwTUNJ1hud5IQxqk24McO/QyCBYPWt5Wz7DjNyTXJlMbzDCfKKkTa94kh/3tNl8
 ZVIvSFHIUq6JWV3UGQqp7Cex1N3kSEk46dRuTzkVzAImpbruTA33bP+hIn0ooJKiCzjI
 7knWZZmei6yG6AZPx/LqJoNF5FGigOFaGdwa9uDPm1t3Wffbbf6tS+zwO0ZPg1bfUzb6
 gdFi6zRcSl+zZqtXGzR872oBrWbm3Z2szIO1K7Ql7F0rpQZKxQcRkbIoq67q9GOgX3GX
 MNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783920869; x=1784525669;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xFoLwDT5tqPWB8FoQy7gl6/PC8pZZ1PnKfRKXRkT/2s=;
 b=mucQVG6KJhpjazlWsDWiGFU7HQX9wDMtJTspt0dWNEn5Mjgxuq5/ET5mNgvGQ0aDGR
 bMwiCgk7t6lwLytpl0czaBItqRewjDuQ440qEJdqUw7O5hC3SnOi4ZKEEGLDidcaOEdR
 FzoKx2B8hl+ZE9RD5sQUwYb414FO++p99MBzChP12Q+VKU1P/G0DbRdypu9qm2+HNJfi
 v0nNSAvBN2P0NqJ2an3E5BZqtAYxVisAtp48F0q9mC3ENHapPRLLPtxKwt7WRUUdOWmP
 T0UILkNa2920KOJyRYinxK0jpbbZz7X3XqPcEQHJFECWUD/eJFDIDlu8E0Y79TVbTCpp
 A+MA==
X-Gm-Message-State: AOJu0Yz4R7D067Fpwv86jcQ+mILSufinvwG02rIo+Xf/Zq0GD2k6lOw7
 snOHLVVXi7CLFzcC6XZnVdflVIH1QnWKB06sRqmEqU0aZWAAvZRW8yHieHGHNZBzdwvZOPoMOp6
 XMsVACAc2Ezw4Cary16GCejSBG7hhB48CoxEbWvhoGFA3pUFDfZXTz+6U
X-Gm-Gg: AfdE7cl2BAm4AdF/5wYVu4yzMX+ALXKzsD9+bYdhj2RP9RTUWXbYFDAVYHl9TV1/Uez
 mtyNX94BMYuK7AML4oxOW1NLfDDABeylIynwz+t3yPv4JZnVy14aF8aC2QJiwbJ4hWY+yM8zhHp
 eZI2Xn6Z+retFwATxbA5wqEqpRIiMhsoL7n4B4CqfNK2wb/V4Q88rk6+BFPqoRqLQTdpC6mBTn7
 iTCWJRvj2L+5RJraobumFz3bZDm+NElZrHFIOUhPVJkYOd9/AALvRrJnFrNNKwUzbyuQofsHnLK
 0fMwRbloLjP6JzwZIcvejhv6D2K3VgxrhHFTePSQ2XWK/EyFCMrBrqbyQ3O4arstCGb0bSoCeCH
 E24uCoYyH3jVsgCRYzLT+IVSNjZF5bJy2rMWU+fMbIGSf8ZrBh7QRzg==
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id
 d9443c01a7336-2ce9f27e6f1mr80488235ad.38.1783920869004; 
 Sun, 12 Jul 2026 22:34:29 -0700 (PDT)
X-Received: by 2002:a17:903:2444:b0:2ca:c4a5:84bb with SMTP id
 d9443c01a7336-2ce9f27e6f1mr80487835ad.38.1783920868533; 
 Sun, 12 Jul 2026 22:34:28 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdb746sm91888925ad.7.2026.07.12.22.34.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 22:34:27 -0700 (PDT)
Message-ID: <4ffc3787-a53e-4889-b245-458de4463cb9@redhat.com>
Date: Mon, 13 Jul 2026 15:34:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 04/25] target/arm/kvm-rme: Add mechanic to initialize
 realms
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-5-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Initialise an @rme_guest object and install a handler to get notified
> when the Realm is ready to start.  That way we can finish reading the
> Realm once we know everything is in place.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c  | 50 +++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm-stub.c |  5 +++++
>   target/arm/kvm.c      |  7 +++++-
>   target/arm/kvm_arm.h  |  9 ++++++++
>   4 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 42e1d1e7b859..b86b9d6a25cb 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -13,6 +13,7 @@
>   #include "kvm_arm.h"
>   #include "migration/blocker.h"
>   #include "qapi/error.h"
> +#include "qemu/error-report.h"
>   #include "qom/object_interfaces.h"
>   #include "system/confidential-guest-support.h"
>   #include "system/kvm.h"
> @@ -29,14 +30,63 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
>                                             CONFIDENTIAL_GUEST_SUPPORT,
>                                             { TYPE_USER_CREATABLE }, { })
>   
> +static RmeGuest *rme_guest;
> +
> +static void rme_vm_state_change(void *opaque, bool running, RunState state)
> +{
> +    if (!running) {
> +        return;
> +    }
> +
> +    kvm_mark_guest_state_protected();

This would be called in kvm_arm_rme_init(), why we can't call this to mark the
KVM state as protected in kvm_arm_rme_init() ?

> +}
> +
>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
>   }
>   
>   static void rme_guest_init(Object *obj)
>   {
> +    if (rme_guest) {
> +        error_report("a single instance of RmeGuest is supported");
> +        exit(1);
> +    }
> +    rme_guest = RME_GUEST(obj);
>   }
>   
>   static void rme_guest_finalize(Object *obj)
>   {
>   }
> +
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> +{
> +    static Error *rme_mig_blocker;
> +    ConfidentialGuestSupport *cgs = ms->cgs;
> +
> +    if (!rme_guest) {
> +        return 0;
> +    }
> +
> +    if (!cgs) {
> +        error_report("missing -machine confidential-guest-support parameter");
> +        return -EINVAL;
> +    }
> +
> +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> +        error_report("KVM doesn't support Realms");
> +        return -ENODEV;
> +    }
> +
> +    error_setg(&rme_mig_blocker, "RME: migration is not implemented");
> +    migrate_add_blocker(&rme_mig_blocker, &error_fatal);
> +
> +    /*
> +     * The realm activation is done last, when the VM starts, after all images
> +     * have been loaded and all vcpus finalized.
> +     */
> +    qemu_add_vm_change_state_handler(rme_vm_state_change, NULL);
> +
> +    cgs->require_guest_memfd = true;
> +    cgs->ready = true;
> +    return 0;
> +}
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 88cbe8d85c41..eec1ca3dd2e5 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
>   {
>       g_assert_not_reached();
>   }
> +
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ed99be7fd80c..28d5643d6779 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -660,7 +660,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> -    return 0;
> +    ret = kvm_arm_rme_init(ms, s);
> +    if (ret) {
> +        error_report("Failed to enable RME: %s", strerror(-ret));
> +    }
> +
> +    return ret;
>   }
>   
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e7c40fb003e4..6d058b0e08a2 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -240,4 +240,13 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>    */
>   char *kvm_print_register_name(uint64_t regidx);
>   
> +/**
> + * kvm_arm_rme_init
> + * @ms: the machine state
> + * @s: State of KVM
> + *
> + * Prepare the machine to be a Realm, if the user enabled it.
> + */
> +int kvm_arm_rme_init(MachineState *ms, KVMState *s);
> +
>   #endif

Thanks,
Gavin


