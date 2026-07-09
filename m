Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FBE3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 23:44:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whyPq-0007cR-Hj; Thu, 09 Jul 2026 19:44:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whyPp-0007c9-Mn
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:44:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1whyPn-0000ZA-K5
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 19:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783640662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
 b=ZCkL2VIX8VEX0NRTSKa+vPmQNnrFvYAatoaxdyPGMMlBdYI5tD+HqeNbHhfCK9efuudqQt
 ReL4U1B01Vj/sAL7kAq4brZ5pqmVRoaNMUznDr+HBTpb7lxV0Lgc7k389qW7PpYHTcImR/
 QPolJkHnsnOFiB3iuzSP0NKIKJSKEPA=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-XYJ-V1OfN2WDp-XMvTUKMg-1; Thu, 09 Jul 2026 19:44:20 -0400
X-MC-Unique: XYJ-V1OfN2WDp-XMvTUKMg-1
X-Mimecast-MFC-AGG-ID: XYJ-V1OfN2WDp-XMvTUKMg_1783640660
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so310704a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783640660; x=1784245460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
 b=M+sthNbfrcBsIfAXoEOLn5MwGQdODy+G6eucaIsvwcXIVhUHzODWeZXfXfOCaW16EQ
 r5LhoxHQAcODOMg4OVwGcBTyMiKuJNkWeTPvvH0yH99DtDabo0TcjbtYu3dP31B3fRkw
 vG+2KL50g+XcuQSOo+w6FL7Du/9H3/Dycvs0trkU4VsHwKdy2Gl+etQn5V45Bn0S8X4g
 mM4rvqMOKUoXDtlb1VW7DHY9Zlf50mtQPYd98/YsVkuqPS12zb5HXyZn6ZihrI5cYMWF
 V2NRSytzFUbmKRqXIEZB71IPILkfcJfbtlLhGLDWcs1X8N+8r3na7lcgYn65E/0YqIft
 vupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783640660; x=1784245460;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g4EYloUwHPFb9+k5XAAGETquHtV4tqhX91bkpTXI8ww=;
 b=P3Tl1gDM6KjmKvxvUvluuu9YMgHuldbwCfQ3cBmd4ydDTyiWxxLGctVw8O9Z5E1M0C
 IDZOJV9yIVHEOeJl/xc18UmXu/Q2W08T4xzcMvCNrZKTS3GyZ1abPl0KVGU2zzKG005l
 J/BEm2yxsY09rmy6pQjXglk24iOpWlfn09lUheFg7Vvl+2hgT3oB1cqRo2B5ZKdPZGWS
 ntzp8aXrxk9S/e88TGUePGZCb9UP1bxzz83uUwPE8rn/HGYRNPhWvlDZUHwGzle+W1Y/
 3pBbiUriHAXZOtOwinyAZMM6AElM5jmOdOcrfa2+66DRuWq4BVkRVfqQR28VEE7NW8iW
 lJvg==
X-Gm-Message-State: AOJu0Yxdi0ncxlSlGS4KxKfZDtGTdA89U4miVzlXDqaxThLc2t4YV4lj
 GAijoXpKxI7oX8E0cMIpXi0HV7yTgW7KVj/1KvDxhcXPMfGDF9l4wtasLs4harukDCOaukSCnZH
 2umH18H0J7zcOw+WEE+7QYi1itLCmuf6iVgauGNCvzlbg3PkkddTQj3TO
X-Gm-Gg: AfdE7ckom3yjFhKR8q4c8ywEeA48ewoRNRauBQiedzZNxLH+eoXpVtOTw3kdNIpf5HU
 8BJnr9WiZ5AxmRw6vxgKwal4vx0A5x+Axm+beMGhC5+liIVd0q35F+jsRfNVwMvCW1aMC0IvF0K
 /vpQvt5wtEWuOSU7hDpvN8kwlhz/6rn5ehn1pLmUPQfQQi051uKjWh+AluE0W/HNXpKZWzl2h49
 hcrc8qSGquTKA0dlp4j/K3sDmbR41FFVQDEFpJ50XIVz9soMmcOEm0cQ0aceOfayO5iMKQM+vjR
 e8SYmP2unoyAUbADioiCCnrJ7zixlom43zcuNo3ygSgJQFarRlkAYoDzQFP3RTBtuI3QZETN/Aa
 Fj4RlnyJ6hPwgRRtg2B1GvawtIhGw2vLPK0m8RyiQ6ot8Gfldt3LjUQ==
X-Received: by 2002:a05:6a21:4c13:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c0bd0fa84emr11241168637.37.1783640659802; 
 Thu, 09 Jul 2026 16:44:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:4c13:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c0bd0fa84emr11241136637.37.1783640659263; 
 Thu, 09 Jul 2026 16:44:19 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8572sm35146664c88.9.2026.07.09.16.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jul 2026 16:44:18 -0700 (PDT)
Message-ID: <2a12f7ba-1c6c-460e-bbbe-07187548a719@redhat.com>
Date: Fri, 10 Jul 2026 09:44:11 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 09/25] target/arm/kvm-rme: Initialise Realm Initial
 Address space
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com, jpb@kernel.org,
 lorenzo.pieralisi@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260707224306.1202330-1-mathieu.poirier@linaro.org>
 <20260707224306.1202330-10-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260707224306.1202330-10-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Mathieu,

On 7/8/26 8:42 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> Initialise the Realm's initial physical address space based on
> the VM's configuration.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   hw/arm/boot.c         |  4 ++++
>   target/arm/kvm-rme.c  | 18 ++++++++++++++++++
>   target/arm/kvm-stub.c |  4 ++++
>   target/arm/kvm_arm.h  | 10 ++++++++++
>   4 files changed, 36 insertions(+)
> 

Thanks for the posting.

If RmeGuest::init_ram isn't needed in the future, this patch can be dropped.
There is no API exposed from (v14) host series to initialize RIPAS for the
specified IPA range, as we did in the earlier revisions. So this patch was
added for the earlier host serieses, not for (v14) host series any more?

Thanks,
Gavin

> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> index 9b7553dde5e1..bcab21d349b4 100644
> --- a/hw/arm/boot.c
> +++ b/hw/arm/boot.c
> @@ -32,6 +32,7 @@
>   #include "qemu/option.h"
>   #include "qemu/units.h"
>   #include "qemu/bswap.h"
> +#include "kvm_arm.h"
>   
>   /* Kernel boot protocol is specified in the kernel docs
>    * Documentation/arm/Booting and Documentation/arm64/booting.txt
> @@ -1210,6 +1211,9 @@ void arm_load_kernel(ARMCPU *cpu, MachineState *ms, struct arm_boot_info *info)
>       /* We assume the CPU passed as argument is the primary CPU.  */
>       info->primary_cpu = cpu;
>   
> +    /* Mark all Realm memory as RAM */
> +    kvm_arm_rme_init_guest_ram(info->loader_start, info->ram_size);
> +
>       /* Load the kernel.  */
>       if (!info->kernel_filename || info->firmware_loaded) {
>           arm_setup_firmware_boot(cpu, info);
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index f763d5ed6199..697e7d507f0d 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -22,8 +22,16 @@
>   #define TYPE_RME_GUEST "rme-guest"
>   OBJECT_DECLARE_SIMPLE_TYPE(RmeGuest, RME_GUEST)
>   
> +#define RME_PAGE_SIZE qemu_real_host_page_size()
> +
> +typedef struct {
> +    hwaddr base;
> +    hwaddr size;
> +} RmeRamRegion;
> +
>   struct RmeGuest {
>       ConfidentialGuestSupport parent_obj;
> +    RmeRamRegion init_ram;
>   };
>   
>   OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
> @@ -91,6 +99,16 @@ int kvm_arm_rme_init(MachineState *ms, KVMState *s)
>       return 0;
>   }
>   
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +    if (!rme_guest) {
> +        return;
> +    }
> +
> +    rme_guest->init_ram.base = base;
> +    rme_guest->init_ram.size = size;
> +}
> +
>   void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
>   {
>       if (!rme_guest) {
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 6d52f172c5df..790e1940fd8a 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -42,6 +42,10 @@ bool kvm_arm_el2_supported(void)
>       return false;
>   }
>   
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size)
> +{
> +}
> +
>   /*
>    * These functions should never actually be called without KVM support.
>    */
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index 65ec1b970606..c7dc45595159 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -267,4 +267,14 @@ void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
>    */
>   int kvm_arm_rme_vm_type(void);
>   
> +/*
> + * kvm_arm_rme_init_guest_ram
> + * @base: base address of RAM
> + * @size: size of RAM
> + *
> + * If the user requested a Realm, set the base and size of guest RAM, in order
> + * to initialize the Realm IPA space.
> + */
> +void kvm_arm_rme_init_guest_ram(hwaddr base, size_t size);
> +
>   #endif


