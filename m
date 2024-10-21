Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA51CD15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:54:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tnu-0004vB-HT; Mon, 21 Oct 2024 10:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2tns-0004pk-D1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:54:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1t2tnq-0001xJ-0B
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729522476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CgM+blbhG/DXmex2HXxxirOY+9+2TYWr4pkLCNDOV+A=;
 b=JsQrlwSvP4A6D4h4L2umW87rrhw3AH3NVuKDO3TR3as1SRo3btCQZ0EARKh8JgWBXXiWVi
 fflZnFijpEjI41/NuACkcwp9PlOhPBIyI+EInItq0luPZK8br57e3WnbIYQ6Wrq4Rbj9A2
 2l8D81GibopLlYHf6SHsjP2wmdjEweE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-NfLQpglGM1-H_ZlD7Dd2Ug-1; Mon, 21 Oct 2024 10:54:35 -0400
X-MC-Unique: NfLQpglGM1-H_ZlD7Dd2Ug-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6cbe77eeeadso66649476d6.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522475; x=1730127275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CgM+blbhG/DXmex2HXxxirOY+9+2TYWr4pkLCNDOV+A=;
 b=b0odYtPrQAJjYgcwh0aGqh8WqC1HOnuw7hU3EC2Wq3DL7okJThEpv7hg9ghlghBwxH
 e70yK2vYQrdE0bI3kUXIam6bzwISI9nH8PfToc920RGd0uSqnyODcFXvWYu7v6Da+0SC
 4tCaD1wmRs95jtLTidPoN17v4LDRrKllFfAhFKby7zyZtin2suMGEHT9FmM1Dqcjj4WU
 mCPLU75zERguOs4xwbRI08Ztxjib4CAETR+xaZFqSG7CPVlDDbmhP3UVtvBcxP369HHK
 HuOINwTu8ffx5oTKaBJa4fbjpR6YMbtxAuwqa1v0GjR+r+32tTpUMO7zMPF2xNwoDBye
 Y7Gg==
X-Gm-Message-State: AOJu0YzyNreMbtFVSD8e7aMHqVeZYCvxBIXyawU2Hol2Bn8GsZ8wXlRr
 ArkzY157apy/9t9RxIX7g1tzX2qHj8/IdvtS3qgpiGnFOqYIq89LtMoTiTHhfTgIqBcARImT4fB
 EEov8IsmdQXbwSW0g6SahU5qIPZAclJpE8gDuWfM19QE0G0gjpD3U
X-Received: by 2002:a05:6214:468d:b0:6cb:e3ea:f07e with SMTP id
 6a1803df08f44-6cde155eae3mr230790466d6.26.1729522474709; 
 Mon, 21 Oct 2024 07:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVZ3j7GXCwftYNU2iK1/3xK4s415tvAodsHVctOaOZQV00hnPwGpd57zYsJOYmX0w5TGpZwA==
X-Received: by 2002:a05:6214:468d:b0:6cb:e3ea:f07e with SMTP id
 6a1803df08f44-6cde155eae3mr230789516d6.26.1729522473285; 
 Mon, 21 Oct 2024 07:54:33 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008fe8f9sm17794256d6.52.2024.10.21.07.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2024 07:54:32 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:54:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [RFC V1 02/14] accel: accel preinit function
Message-ID: <ZxZrJjGx0tifZf0B@x1n>
References: <1729178055-207271-1-git-send-email-steven.sistare@oracle.com>
 <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1729178055-207271-3-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
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

On Thu, Oct 17, 2024 at 08:14:03AM -0700, Steve Sistare wrote:
> Extract the first part of the AccelState init_machine function into
> a new function preinit, which can be called without knowing any
> machine properties.  For now call preinit and init_machine at the
> same place, so no functional change.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  accel/accel-system.c        |  6 +++++
>  accel/kvm/kvm-all.c         | 58 +++++++++++++++++++++++++++++----------------
>  accel/xen/xen-all.c         | 11 ++++++---
>  include/qemu/accel.h        |  1 +
>  target/i386/nvmm/nvmm-all.c | 10 +++++++-
>  target/i386/whpx/whpx-all.c | 14 +++++++----
>  6 files changed, 70 insertions(+), 30 deletions(-)
> 
> diff --git a/accel/accel-system.c b/accel/accel-system.c
> index f6c947d..fef6625 100644
> --- a/accel/accel-system.c
> +++ b/accel/accel-system.c
> @@ -36,8 +36,14 @@ int accel_init_machine(AccelState *accel, MachineState *ms)
>      int ret;
>      ms->accelerator = accel;
>      *(acc->allowed) = true;
> +    ret = acc->preinit(accel);
> +    if (ret < 0) {
> +        goto fail;
> +    }
> +
>      ret = acc->init_machine(ms);
>      if (ret < 0) {
> +fail:

Jump into another failure path's if clause might be error prone in the
future.

Maybe move the error handling out while at it, e.g.:

    ret = acc->init_machine();
    if (ret < 0) {
       goto fail;
    }
    object_set_accelerator_compat_props(acc->compat_props);
    return 0;

fail:
    ms->accelerator = NULL;
    *(acc->allowed) = false;
    object_unref(OBJECT(accel));
    return ret;

>          ms->accelerator = NULL;
>          *(acc->allowed) = false;
>          object_unref(OBJECT(accel));
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 905fb84..c7c6001 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -2484,6 +2484,42 @@ static int kvm_setup_dirty_ring(KVMState *s)
>      return 0;
>  }
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
>  static int kvm_init(MachineState *ms)
>  {
>      MachineClass *mc = MACHINE_GET_CLASS(ms);
> @@ -2523,27 +2559,6 @@ static int kvm_init(MachineState *ms)
>      QTAILQ_INIT(&s->kvm_sw_breakpoints);
>  #endif
>      QLIST_INIT(&s->kvm_parked_vcpus);
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
>      kvm_supported_memory_attributes = kvm_check_extension(s, KVM_CAP_MEMORY_ATTRIBUTES);
>      kvm_guest_memfd_supported =
> @@ -3891,6 +3906,7 @@ static void kvm_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "KVM";
> +    ac->preinit = kvm_preinit;
>      ac->init_machine = kvm_init;
>      ac->has_memory = kvm_accel_has_memory;
>      ac->allowed = &kvm_allowed;
> diff --git a/accel/xen/xen-all.c b/accel/xen/xen-all.c
> index 0bdefce..dfcb90c 100644
> --- a/accel/xen/xen-all.c
> +++ b/accel/xen/xen-all.c
> @@ -75,10 +75,8 @@ static void xen_setup_post(MachineState *ms, AccelState *accel)
>      }
>  }
>  
> -static int xen_init(MachineState *ms)
> +static int xen_preinit(AccelState *accel)
>  {
> -    MachineClass *mc = MACHINE_GET_CLASS(ms);
> -
>      xen_xc = xc_interface_open(0, 0, 0);
>      if (xen_xc == NULL) {
>          xen_pv_printf(NULL, 0, "can't open xen interface\n");
> @@ -97,6 +95,12 @@ static int xen_init(MachineState *ms)
>          xc_interface_close(xen_xc);
>          return -1;
>      }
> +    return 0;
> +}
> +
> +static int xen_init(MachineState *ms)
> +{
> +    MachineClass *mc = MACHINE_GET_CLASS(ms);
>  
>      /*
>       * The XenStore write would fail when running restricted so don't attempt
> @@ -125,6 +129,7 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
>      };
>  
>      ac->name = "Xen";
> +    ac->preinit = xen_preinit;
>      ac->init_machine = xen_init;
>      ac->setup_post = xen_setup_post;
>      ac->allowed = &xen_allowed;
> diff --git a/include/qemu/accel.h b/include/qemu/accel.h
> index 972a849..6b3b1cf 100644
> --- a/include/qemu/accel.h
> +++ b/include/qemu/accel.h
> @@ -37,6 +37,7 @@ typedef struct AccelClass {
>      /*< public >*/
>  
>      const char *name;
> +    int (*preinit)(AccelState *accel);
>      int (*init_machine)(MachineState *ms);

Might be nice to add some comment on what should be part of preinit() and
what should be part of init_machine().

AFAIU the preinit() was about probing whether an accel is supported. Maybe
rename it to probe()?  Then it's also clear why some accel (e.g. tcg)
doesn't need that, because it is always supported and no probe is needed.

>  #ifndef CONFIG_USER_ONLY
>      void (*setup_post)(MachineState *ms, AccelState *accel);
> diff --git a/target/i386/nvmm/nvmm-all.c b/target/i386/nvmm/nvmm-all.c
> index 65768ac..ce858a0 100644
> --- a/target/i386/nvmm/nvmm-all.c
> +++ b/target/i386/nvmm/nvmm-all.c
> @@ -1153,7 +1153,7 @@ static struct RAMBlockNotifier nvmm_ram_notifier = {
>  /* -------------------------------------------------------------------------- */
>  
>  static int
> -nvmm_accel_init(MachineState *ms)
> +nvmm_accel_preinit(MachineState *ms)
>  {
>      int ret, err;
>  
> @@ -1178,6 +1178,13 @@ nvmm_accel_init(MachineState *ms)
>          error_report("NVMM: Wrong state size %u", qemu_mach.cap.state_size);
>          return -EPROGMISMATCH;
>      }
> +    return 0;
> +}
> +
> +static int
> +nvmm_accel_init(MachineState *ms)
> +{
> +    int ret, err;
>  
>      ret = nvmm_machine_create(&qemu_mach.mach);
>      if (ret == -1) {
> @@ -1204,6 +1211,7 @@ nvmm_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "NVMM";
> +    ac->preinit = nvmm_accel_preinit;
>      ac->init_machine = nvmm_accel_init;
>      ac->allowed = &nvmm_allowed;
>  }
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index a6674a8..50bfc19 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -2516,6 +2516,14 @@ static void whpx_set_kernel_irqchip(Object *obj, Visitor *v,
>   * Partition support
>   */
>  
> +static int whpx_accel_preinit(AccelState *accel)
> +{
> +    if (!init_whp_dispatch()) {
> +        return -ENOSYS;
> +    }
> +    return 0;
> +}
> +
>  static int whpx_accel_init(MachineState *ms)
>  {
>      struct whpx_state *whpx;
> @@ -2529,11 +2537,6 @@ static int whpx_accel_init(MachineState *ms)
>  
>      whpx = &whpx_global;
>  
> -    if (!init_whp_dispatch()) {
> -        ret = -ENOSYS;
> -        goto error;
> -    }
> -
>      whpx->mem_quota = ms->ram_size;
>  
>      hr = whp_dispatch.WHvGetCapability(
> @@ -2713,6 +2716,7 @@ static void whpx_accel_class_init(ObjectClass *oc, void *data)
>  {
>      AccelClass *ac = ACCEL_CLASS(oc);
>      ac->name = "WHPX";
> +    ac->preinit = whpx_accel_preinit;
>      ac->init_machine = whpx_accel_init;
>      ac->allowed = &whpx_allowed;
>  
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


