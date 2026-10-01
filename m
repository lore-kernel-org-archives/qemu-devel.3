Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF3ECA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQQD-0006u6-EX; Thu, 01 Oct 2026 19:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCQQA-0006tm-Gy
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCQQ8-000343-DZ
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:42:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790898154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
 b=JHsULws3a327/0dvdabsfgKW6zi32GbaIqzjvl++L51NJLCXxbtdEu9L2aFcOxnATAtvYz
 UmJvBGCNP0DJuFLtz7TLvLII8SuZ1TN75icc1jAsZ4qjnMgxleZYDvfriESwjdKrljjlT6
 v1h950aa1F7wtYIBh4kq9INatZ2MSqI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-fdHBxDa8NZSqyafLXlRZIw-1; Thu, 01 Oct 2026 19:42:33 -0400
X-MC-Unique: fdHBxDa8NZSqyafLXlRZIw-1
X-Mimecast-MFC-AGG-ID: fdHBxDa8NZSqyafLXlRZIw_1790898152
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39deda201bcso11285031a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790898152; x=1791502952; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
 b=UO6QGu9bLF4ZUGA4kdAzHQHCCWJmKXS+JAnSMlDr4yqHE10/UTjvLd4XcHPHA7CFpF
 lgn1wDVhHs2jVmM4cGFYBr+Mt6wisxcfUdeY2iQBRXWUHkD79HAxj/m4boGWMyoh6fqG
 52X+qfIhLrSnGgx6BwWEc+SJTEg8qX+VtfNQiDIFAGBFm1kBzJHWO7KxPi1+259eF51E
 b598poDKQVdn2UitZazY3nHMS0JInmBd9jnP439HSlUkjpM9FZVRVkjQtMr58oG/UQZd
 2GK6ntVclXX0RikPo8ba8kHNTs8IB6Xb8I31o8KE4/GZCWFgNKCnutK2Ud4hqtTp2nVs
 CF3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790898152; x=1791502952;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1rty/hi1E13diYp3gmh8YwjoDszZTbFvppq31VQMDY=;
 b=dGjfWBnuBObLMnpsNjnuVAcMZtpjiRXe/ZjLSETWfp0R0iTVMp2/ewrR2V/2Y7B7sT
 2aruyVKVJ94FqG0Exy+1AmcSSZykcNj5ZR19Rez4qjf+YQzWzNTcmnxx3zQ3heDue+mZ
 YJ+XHpccgAuVbBLGArfQRUNkfciha5TA8LzWZzZwlNc26hZXpbm5FQLQ+O7r2/tYybyu
 VJVHS04xXNNQwKNzNYjtODwFrDhD1vDu9pswI5jf0vDkC5Qt+OUX8z14mEnRx8vWDDzP
 MP2VW5EoGtE5PD2N2LHHwerwQJCT9PO2KC75HcsMYLpnmn3C8Eg1Eyod2DnrKNXJyw64
 6H3g==
X-Gm-Message-State: AFq9FYJvqVhplx8n0dEeiI2qylzxJal506iCzBLonbIZISpBWXMxmTQx
 Rm1SbDHOHinz6NPhXFWleX+SltOTXpS7nXPzwPACekb9M224cMiAcSRrKVg/3Eo3ZBobqLu85h7
 olJQzPIuGxCFdUFLiPlEAsLZjrfiXSNT5Vp4DnH3c/Hg8QWmpJrczKOx5
X-Gm-Gg: AYBFou1cjupGg/7ZSUqcVMXr+e7N3L64MLfaJ30nBTqCtpKoQ+2O+cWCv/6XPr+mwBD
 8YU0fcOPV5+sVvRH6i4KDJahn68FFe+563Hj9YPHAhZvUD93L/O1OlOPoae82kRCVjtnQ9Vh8uq
 d1rQv8rpSxnNr+HGkbpG74H3RtLqANVg4hi5JQA3nbASO98tzHy7z8Cdzj32d4eXUpK3Uilkgqg
 R8BXU3B2h7Tlp2Roie7hEpf5xVVqNaqqaQgf55SCVmO0Zv+cJvOWhHc6v6mOIBvvIW6QDlEFuNO
 O0r0qMS2ZyFmlKiFwxkeKGeexSZjbs7KMiyLXnRHIUjghKGJvExa9pqlSnkXpJ4jxSRAK/tv8hd
 fqncDIMOu6w5SXNM0OIgRa5wl7n+hVon13QkrHUVwfQ==
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id
 98e67ed59e1d1-3a6ce9b0fe4mr918289a91.65.1790898152004; 
 Thu, 01 Oct 2026 16:42:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1c86:b0:3a4:d5c0:f826 with SMTP id
 98e67ed59e1d1-3a6ce9b0fe4mr918273a91.65.1790898151463; 
 Thu, 01 Oct 2026 16:42:31 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4709a7csm6244308a91.8.2026.10.01.16.42.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 16:42:30 -0700 (PDT)
Message-ID: <5461472f-8ab2-4549-b04f-85f0030b4b79@redhat.com>
Date: Fri, 2 Oct 2026 09:42:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 04/24] target/arm/kvm-rme: Add mechanic to initialize
 realms
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-5-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-5-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> Initialise an @rme_guest object and install a handler to get notified
> when the Realm is ready to start.  That way we can finish reading the
> Realm once we know everything is in place.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/kvm-rme.c | 51 ++++++++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm.c     | 15 +++++++++++--
>   2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index 42e1d1e7b859..a4a5e195c196 100644
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
> @@ -29,12 +30,62 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
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
> +}
> +
> +static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
> +{
> +    KVMState *s = KVM_STATE(current_accel());
> +    static Error *rme_mig_blocker;
> +
> +    if (!rme_guest) {
> +        return 0;
> +    }
> +
> +    if (!kvm_vm_check_extension(s, KVM_CAP_ARM_RMI)) {
> +        error_setg(errp, "VM doesn't support Realms");
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
> +
>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
> +    ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> +
> +    klass->kvm_init = kvm_arm_rme_init;
>   }
>   
>   static void rme_guest_init(Object *obj)
>   {
> +    ConfidentialGuestSupport *cgs = CONFIDENTIAL_GUEST_SUPPORT(obj);
> +
> +    if (rme_guest) {
> +        error_report("a single instance of RmeGuest is supported");
> +        exit(1);
> +    }
> +    rme_guest = RME_GUEST(obj);
> +    cgs->allow_convert_in_place = true;
>   }
>   
>   static void rme_guest_finalize(Object *obj)
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index ed99be7fd80c..401a6f669cbb 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -33,6 +33,7 @@
>   #include "hw/pci/pci.h"
>   #include "exec/memattrs.h"
>   #include "system/address-spaces.h"
> +#include "system/confidential-guest-support.h"
>   #include "gdbstub/enums.h"
>   #include "hw/core/boards.h"
>   #include "hw/core/irq.h"
> @@ -596,7 +597,8 @@ int kvm_arch_get_default_type(MachineState *ms)
>   
>   int kvm_arch_init(MachineState *ms, KVMState *s)
>   {
> -    int ret;
> +    Error *local_err = NULL;
> +    int ret = 0;
>       /* For ARM interrupt delivery is always asynchronous,
>        * whether we are using an in-kernel VGIC or not.
>        */
> @@ -610,6 +612,15 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>   
>       cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
>   
> +    /* Initialize confidential guest (Realm) if needed */
> +    if (ms->cgs) {
> +        ret = confidential_guest_kvm_init(ms->cgs, &local_err);
> +            if (ret < 0) {
            ^^^^^

            Code alignment issue here.

> +                error_report_err(local_err);
> +                return ret;
> +        }
> +    }
> +
>       /* Check whether user space can specify guest syndrome value */
>       cap_has_inject_serror_esr =
>           kvm_check_extension(s, KVM_CAP_ARM_INJECT_SERROR_ESR);
> @@ -660,7 +671,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>       hw_breakpoints = g_array_sized_new(true, true,
>                                          sizeof(HWBreakpoint), max_hw_bps);
>   
> -    return 0;
> +    return ret;
>   }
>   
>   unsigned long kvm_arch_vcpu_id(CPUState *cpu)

Thanks,
Gavin


