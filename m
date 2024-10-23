Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF614CFA448
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 15:54:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3dgW-0004d9-HQ; Wed, 23 Oct 2024 11:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dgV-0004ct-BN
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:54:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3dgQ-0001Pr-4f
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 11:54:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729698840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Sr5t7lsjkcWNRLov3A3pP2OIbRHk2T+oMAmSoPPsNQM=;
 b=UHIAjdh0hSAC+e8SZZUkIERJ24W5AaMLOhkkUhimLYU9DBWJViy0co2S+oUoK7m1fxTNUB
 rzofM4T3S5Mb4tEfYV19uGYI1lqfkchi7bjfFiIFxS8hXhi5NdycDumu6Bo1/OOvAQEI+9
 axd5z5nXdQHL/kTpr6AadtqkEyK8Sv0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-vB5MDI2mPDaU0_fZAB-KdA-1; Wed, 23 Oct 2024 11:53:58 -0400
X-MC-Unique: vB5MDI2mPDaU0_fZAB-KdA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d432f9f5eso3522296f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 08:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729698837; x=1730303637;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Sr5t7lsjkcWNRLov3A3pP2OIbRHk2T+oMAmSoPPsNQM=;
 b=OX5w/bkC30hnCTxeRLyjyLik+iMYxfdtaFtaohd91x4v5404fHKkYwwG88P/+T3KFV
 05Z4lB+LJAo/c4UR26FHM42j1uJifMElwSufr4dA0nfoCRq9FMa/TyCsuBmmVhPPMCpi
 T386CDGOY3foEYhxa7u3SkeZ054Y4sAZtClgrs1MNJiPkomtMKu2qNPA/eE8LNah1kbV
 waym1xtdnB9jrf6COuOxu4W6YtinYR75gSowhkxTkOzJ04BIhR33jStwUdtZVqp3GlQX
 jFNpQ9c3GykTXfFzEiD5MUrGv0kDLT0FIipRiAPRlPfSE8+YsSdrOt2Zt3+yCMWEtq4k
 oiMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw5ciLLifgqn7BpqEvkEqwPgyUA5zMFXVWy0LKzUlYnowtktSgr/eEtc3dzU1376YFILMP8PPLWHTm@nongnu.org
X-Gm-Message-State: AOJu0Yxu5bfCwTohX0Ju7ytJgH//leYo4h2pEq6jelNdoU2PloIPwGM3
 pQ6FdDstojJCEUAGVUjOeR9oY9tKnW7f+Mpzp6UeM+CxnqK5VWISzs5Q1+udVdib6sAf1u6tyWX
 TqBRarijb4bG7qZGgTjxrpDgQtU/tqmxkdbHfAWgjGeN2mbiIzhX3
X-Received: by 2002:a05:6000:1183:b0:37d:3735:8fe9 with SMTP id
 ffacd0b85a97d-37efcf1a9b6mr2219234f8f.27.1729698837435; 
 Wed, 23 Oct 2024 08:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7gFeGxmJfLxwUwx7GN5jPeAahT4wbK/u25uwkdL4UBo6zMZZb3HUUrwA6kCzNKJi0U4X1nA==
X-Received: by 2002:a05:6000:1183:b0:37d:3735:8fe9 with SMTP id
 ffacd0b85a97d-37efcf1a9b6mr2219215f8f.27.1729698836984; 
 Wed, 23 Oct 2024 08:53:56 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.144.54])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b93d53sm9280975f8f.70.2024.10.23.08.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 08:53:56 -0700 (PDT)
Message-ID: <82f35464-0f7c-4678-aa74-1865cf3d89dd@redhat.com>
Date: Wed, 23 Oct 2024 17:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V1 02/14] accel: accel preinit function
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/17/24 17:14, Steve Sistare wrote:
> Extract the first part of the AccelState init_machine function into
> a new function preinit, which can be called without knowing any
> machine properties.  For now call preinit and init_machine at the
> same place, so no functional change.

For KVM I would also include

     missing_cap = kvm_check_extension_list(s, kvm_required_capabilites);
     if (!missing_cap) {
         missing_cap =
             kvm_check_extension_list(s, kvm_arch_required_capabilities);
     }

With this change, patches 1-3 are okay as a separate submission.

Paolo

> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   accel/accel-system.c        |  6 +++++
>   accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
>   accel/xen/xen-all.c         | 11 ++++++---
>   include/qemu/accel.h        |  1 +
>   target/i386/nvmm/nvmm-all.c | 10 +++++++-
>   target/i386/whpx/whpx-all.c | 14 +++++++----
>   6 files changed, 70 insertions(+), 30 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..fef6625 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>       int ret;
>       ms->accelerator = accel;
>       *(acc->allowed) = true;
> +    ret = acc->preinit(accel);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
>       ret = acc->init_machine(ms);
>       if (ret < 0) {
> +fail:
>           ms->accelerator = NULL;
>           *(acc->allowed) = false;
>           object_unref(OBJECT(accel));
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 905fb84..c7c6001 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
>       return 0;
>   }
>   
> +static int kvm_preinit(AccelState *accel)
> +{
> +    int ret;
> +    KVMState *s = KVM_STATE(accel);
> +
> +    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> +    if (s->fd == -1) {
> +        error_report("Could not access KVM kernel module: %m");
> +        ret = -errno;
> +        goto err;
> +    }
> +
> +    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
> +    if (ret < KVM_API_VERSION) {
> +        if (ret >= 0) {
> +            ret = -EINVAL;
> +        }
> +        fprintf(stderr, "kvm version too old\n");
> +        goto err;
> +    }
> +
> +    if (ret > KVM_API_VERSION) {
> +        ret = -EINVAL;
> +        error_report("kvm version not supported");
> +        goto err;
> +    }
> +    return 0;
> +
> +err:
> +    assert(ret < 0);
> +    if (s->fd != -1) {
> +        close(s->fd);
> +    }
> +    return ret;
> +}
> +
>   static int kvm_init(MachineState *ms)
>   {
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
>       QTAILQ_INIT(&s->kvm_sw_breakpoints);
>   #endif
>       QLIST_INIT(&s->kvm_parked_vcpus);
> -    s->fd = qemu_open_old(s->device ?: "/dev/kvm", O_RDWR);
> -    if (s->fd == -1) {
> -        error_report("Could not access KVM kernel module: %m");
> -        ret = -errno;
> -        goto err;
> -    }
> -
> -    ret = kvm_ioctl(s, KVM_GET_API_VERSION, 0);
> -    if (ret < KVM_API_VERSION) {
> -        if (ret >= 0) {
> -            ret = -EINVAL;
> -        }
> -        error_report("kvm version too old");
> -        goto err;
> -    }
> -
> -    if (ret > KVM_API_VERSION) {
> -        ret = -EINVAL;
> -        error_report("kvm version not supported");
> -        goto err;
> -    }
>   
>       kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>       kvm_guest_memfd_supported =
> @@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "KVM";
> +    ac->preinit = kvm_preinit;
>       ac->init_machine = kvm_init;
>       ac->has_memory = kvm_accel_has_memory;
>       ac->allowed = &kvm_allowed;
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 0bdefce..dfcb90c 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>       }
>   }
>   
> -static int xen_init(MachineState *ms)
> +static int xen_preinit(AccelState *accel)
>   {
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> -
>       xen_xc = xc_interface_open(0, 0, 0);
>       if (xen_xc == NULL) {
>           xen_pv_printf(NULL, 0, "can't open xen interface\n");
> @@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
>           xc_interface_close(xen_xc);
>           return -1;
>       }
> +    return 0;
> +}
> +
> +static int xen_init(MachineState *ms)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>   
>       /*
>        * The XenStore write would fail when running restricted so don't attempt
> @@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>       };
>   
>       ac->name = "Xen";
> +    ac->preinit = xen_preinit;
>       ac->init_machine = xen_init;
>       ac->setup_post = xen_setup_post;
>       ac->allowed = &xen_allowed;
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index 972a849..6b3b1cf 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -37,6 +37,7 @@ typedef struct AccelClass {
>       /*< public >*/
>   
>       const char *name;
> +    int (*preinit)(AccelState *accel);
>       int (*init_machine)(MachineState *ms);
>   #ifndef CONFIG_USER_ONLY
>       void (*setup_post)(MachineState *ms, AccelState *accel);
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 65768ac..ce858a0 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
>   /* -------------------------------------------------------------------------- */
>   
>   static int
> -nvmm_accel_init(MachineState *ms)
> +nvmm_accel_preinit(MachineState *ms)
>   {
>       int ret, err;
>   
> @@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
>           error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
>           return -EPROGMISMATCH;
>       }
> +    return 0;
> +}
> +
> +static int
> +nvmm_accel_init(MachineState *ms)
> +{
> +    int ret, err;
>   
>       ret = nvmm_machine_create(&qemu_mach.mach);
>       if (ret == -1) {
> @@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "NVMM";
> +    ac->preinit = nvmm_accel_preinit;
>       ac->init_machine = nvmm_accel_init;
>       ac->allowed = &nvmm_allowed;
>   }
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index a6674a8..50bfc19 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>    * Partition support
>    */
>   
> +static int whpx_accel_preinit(AccelState *accel)
> +{
> +    if (!init_whp_dispatch()) {
> +        return -ENOSYS;
> +    }
> +    return 0;
> +}
> +
>   static int whpx_accel_init(MachineState *ms)
>   {
>       struct whpx_state *whpx;
> @@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
>   
>       whpx = &whpx_global;
>   
> -    if (!init_whp_dispatch()) {
> -        ret = -ENOSYS;
> -        goto error;
> -    }
> -
>       whpx->mem_quota = ms->ram_size;
>   
>       hr = whp_dispatch.WHvGetCapability(
> @@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
>   {
>       AccelClass *ac = ACCEL_CLASS(oc);
>       ac->name = "WHPX";
> +    ac->preinit = whpx_accel_preinit;
>       ac->init_machine = whpx_accel_init;
>       ac->allowed = &whpx_allowed;
>   


