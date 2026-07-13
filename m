Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5BDC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:14:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wj8zu-0001Hs-VY; Mon, 13 Jul 2026 01:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj8zk-0001Go-W1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wj8zi-0003cj-W1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 01:14:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783919657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
 b=SOZqtyxMyyqbyC546TvoIIny3UcSZf4tmNLdDNsIm6H67dR3lwsUI8pHHCoWubNH23Uzix
 DKH2r8rUBkReIpKrgDq42JZduKcXK/q2ljG98hsCqJMa5p5U/OyZtcUQRQvGZlIEjNarHZ
 qaIRj7aprBUyej6a4AgVbKQRQ24vekY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-rTItQ3xbOqGrVUytvvPe1Q-1; Mon, 13 Jul 2026 01:14:15 -0400
X-MC-Unique: rTItQ3xbOqGrVUytvvPe1Q-1
X-Mimecast-MFC-AGG-ID: rTItQ3xbOqGrVUytvvPe1Q_1783919655
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc101287aso2453394a91.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2026 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783919655; x=1784524455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
 b=dtdlB2pT3DOxdHcbp92TKlc5pdt8N6j/+PDQirb2kd8Yef0x6fruUijg9L174wzgcW
 fzvIPwD6qIS8h7i0v1Q96mIwciqSU7ZnB11o2fTAW7683MHCjBINOIzdONVEorgMLSap
 5V6iE3OWF+OqeFNF2/1+3n1phHgep2LNydbiGAlOhHef9viv3s8bG0/ENlsGcLHujkS7
 GgcKBa/0QvZg1N1KpnN9MxZ51E3TqIKJ/YEMVgi3h60MD5y8VpxpZa84/1qoa4nxKa3f
 ridKCQhBvFEjmt+/F81CmGGD61YDGElZyjbD9R0xV2lGfQnaBsEm4JTNpgLFOGcwgfJt
 OMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783919655; x=1784524455;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Pd7YyxNvDAuEnjFNK+Ewr3cRxfagtzALbzN/XiFNig4=;
 b=SlaBqgU4GQqVi8DQadSBTWrllhDubjqu+oktccvpBBZ0lwmU69sDRZus6BofMAgrN2
 NhfhZscUjTLWF/2TBukORLlqajCnzQxx+MEK7k9Ymor5UiPjfrBLy9UzNPJqrx1x0qQb
 gEskIjK5HpvctnDv06b8MgI4MvM8wRSsg18DqraJsecWjmpGKbFvc/TrgRIWTjFdHif4
 uU83HyKbGIFTB8862BkW9MS41oPnuDIQi7tZB9qcvjT0ZbC/A+++t0sWk3SctQSO2Wkc
 tEPvvMdGFEDXjk2Jd0BII3qheyujidYyNM9za3Vg7Yxu0A+6qBQ/lOGyG5CQaZOGqzkX
 93PQ==
X-Gm-Message-State: AOJu0YzRlxOB/UEGh2XRVEjy7UISYwZwIXiwMFiupUwRlhYTj2GMOlMa
 VYJd+UfNeNKQtWYBLm9LUMuZgSkvuDU+EY6Sn8pExeGrlYlcMYr+grQx1/hhV03yePb42f4j2ca
 ii8/fuKr7f+eYCzCt1aElT5XvingBWxNzMCRjb1rCs4VnMAue+09/usnd
X-Gm-Gg: AfdE7ckAkqvtei41+OF7EdETSxeG7mS22UkHujodoEBAoLsfJOn+586z9VBSSzcGdGN
 rbb48c9MRnE2Jb+GUXYCMsZfkgzy5f72XFgy35l1atyzTTvD+hGDDN9AQ61kQgpxUYpP33CZmeT
 iYOoLUMYbaWmWG48yrd0XvoynDeuSaO63pyOxPSY9F5t3jhsvgPFCEQ6uPzy8nJr+SD8FdP27Tz
 c+z5eH3p9Cj5mMVj+HW6g4/gLYhpRsvi/DXKbVMmEYqHIQVUNeOO367iksbj7e8mDgo63u94ukp
 2NfikEoVwRTrlvl2enruF6Kdp3/mtLy+64FolMVoq/4EhWi9wPc1bKqv3nX5LH5mBEmyBWk5Y4L
 /NCfb64q8LZn6PUOLIf7ex+SAJ8QHU5f4vzc40gaaOimZ3ezUxcjPJQ==
X-Received: by 2002:a17:903:2a88:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2ce9e9b9691mr77163615ad.12.1783919654724; 
 Sun, 12 Jul 2026 22:14:14 -0700 (PDT)
X-Received: by 2002:a17:903:2a88:b0:2c0:b5c1:8e22 with SMTP id
 d9443c01a7336-2ce9e9b9691mr77163245ad.12.1783919654157; 
 Sun, 12 Jul 2026 22:14:14 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc99cc5aasm93166495ad.0.2026.07.12.22.14.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Jul 2026 22:14:13 -0700 (PDT)
Message-ID: <618fa1ec-c986-4075-9b6f-c720b48d75ce@redhat.com>
Date: Mon, 13 Jul 2026 15:14:05 +1000
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
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=gshan@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

I think it's more reasonable to set ConfidentialGuestSupportClass::kvm_init to
kvm_arm_rme_init in rme_guest_class_init(). confidential_guest_kvm_init()
gets called in target/arm/kvm.c::kvm_arch_init(). With this, the pattern matches
with that for x86.

More details can be found from commit 631a2ac5a4be ("i386/tdx: Implement tdx_kvm_init()
to initialize TDX VM context").

Thanks,
Gavin

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


