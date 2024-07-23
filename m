Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D6BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 15:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWH3A-0004l5-P7; Tue, 23 Jul 2024 11:03:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWH37-0004kG-E1
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sWH33-0008Li-T3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 11:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721747007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zQhwb1M2z2RFwCZQw4pIS+CwCSioBmlZ3MEJYRcKY3U=;
 b=axVUgDXfcT65Pnvph9lU8LSIAjVuMdQ4Z5oKUk7yQm7HwAsJnB1VBSOYphcTgmdxTjKzmJ
 0N/2IKPGK70E3r8sTKhKr56gYLy8ed2Tiisxs1KtkVge+fgJPJ5R+1EU1MSb5jsxnnxNxq
 eZWzW2vZitbwsLuSmDEVAJ/JJPAalOE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-Nt8FWpIVPlO-VAkNrxg3xw-1; Tue, 23 Jul 2024 11:03:26 -0400
X-MC-Unique: Nt8FWpIVPlO-VAkNrxg3xw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-52efcb739adso2925006e87.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721747005; x=1722351805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQhwb1M2z2RFwCZQw4pIS+CwCSioBmlZ3MEJYRcKY3U=;
 b=WR8s4gLTO5rKkml6OKRKOuNXnNmFWVpt6J8Ou0OdH3eSgfPUktFsyN8NyI3x62eOAv
 WNxqjXaRQSNQrb+IrKAybcRKD62qLpLdq42RAIYnUaH9/HqpUEbfCas6txmo+WDUPTba
 scppWOiwlOskxVV0pV4oIbGfNCMRJK1w72s3F4dwEBs74zZign3HnErlf1GqcagY9VCh
 64yP3JnAdx9CSIRlAGI7uK+aPkYj6wb/ET9Zkf6N/Z1++uNg1Bx3hn+LSvAZZ6NN6cAx
 u/jv8FATX0hg2BAl2P2pSbtHt/ewU6nP66TPU4i4U6Rq0XwMu9RsWTTJsbiMvX1bTmqV
 r3Uw==
X-Gm-Message-State: AOJu0Yy73UJWEEcXaXHoVI/X+d2sVzjbOQMrZplX3iFknfgLn076Ybfm
 A5HDTdNO/0/B9SvcBQ3kprq06hGradrHnZZYhXfDQPfCOBjTM8lgrryIO717FEix7wnhY0i4PYv
 cgvG7vQdIDDhu1PY9F1KXa7pl1bsNkInTuCHXnofo2tj7XR3qTCWk
X-Received: by 2002:a05:6512:1322:b0:52c:d750:bd19 with SMTP id
 2adb3069b0e04-52efb76b16dmr7158834e87.8.1721747004565; 
 Tue, 23 Jul 2024 08:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2pcYsAtvJGcfwmI+E0QEPMcb7pqvC7FuociMkjs6kWssWQsUcLpziYsZ93GQcvIFv1K+LFQ==
X-Received: by 2002:a05:6512:1322:b0:52c:d750:bd19 with SMTP id
 2adb3069b0e04-52efb76b16dmr7158741e87.8.1721747002866; 
 Tue, 23 Jul 2024 08:03:22 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d68f789csm178051345e9.6.2024.07.23.08.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 08:03:22 -0700 (PDT)
Date: Tue, 23 Jul 2024 17:03:21 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: "manish.mishra" <manish.mishra@nutanix.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, zhao1.liu@intel.com,
 pbonzini@redhat.com, bob.ball@nutanix.com, prerna.saxena@nutanix.com,
 john.levon@nutanix.com
Subject: Re: [PATCH] target/i386: Always set leaf 0x1f
Message-ID: <20240723170321.0ef780c5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240722101859.47408-1-manish.mishra@nutanix.com>
References: <20240722101859.47408-1-manish.mishra@nutanix.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, 22 Jul 2024 10:18:59 +0000
"manish.mishra" <manish.mishra@nutanix.com> wrote:

> QEMU does not set 0x1f in case VM does not have extended CPU topology
> and expects guests to fallback to 0xb. Some versions of windows i.e.
> windows 10, 11 does not like this behavior and expects this leaf to be
                 ^^^^^^^^^^^^^  
be more clear about

> populated. This is observed with windows VMs with secure boot, uefi
> and HyperV role enabled.

add here exact QME CLI and necessary guest OS details to reproduce the issue.

 
> Leaf 0x1f is superset of 0xb, so it makes sense to set 0x1f equivalent
> to 0xb by default and workaround windows issue. This change adds a
> new property 'cpuid-0x1f-enforce' to set leaf 0x1f equivalent to 0xb in
> case extended CPU topology is not present and behave as before otherwise.
> ---

maybe instead of adding workaround it would be better to enable
1F leaf on CPU models that supposed to have it?

>  hw/i386/pc.c          |  1 +
>  target/i386/cpu.c     | 71 +++++++++++++++++++++++++++----------------
>  target/i386/cpu.h     |  5 +++
>  target/i386/kvm/kvm.c |  4 ++-
>  4 files changed, 53 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index c74931d577..4cab04e443 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -85,6 +85,7 @@ GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
>      { "sev-guest", "legacy-vm-type", "on" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
> +    { TYPE_X86_CPU, "cpuid-0x1f-enforce", "false" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2..f89b2ef335 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -416,6 +416,43 @@ static void encode_topo_cpuid1f(CPUX86State *env, uint32_t count,
>      assert(!(*eax & ~0x1f));
>  }
>  
> +static void encode_topo_cpuid_b(CPUX86State *env, uint32_t count,
> +                                X86CPUTopoInfo *topo_info,
> +                                uint32_t threads_per_pkg,
> +                                uint32_t *eax, uint32_t *ebx,
> +                                uint32_t *ecx, uint32_t *edx)
> +{
> +    X86CPU *cpu = env_archcpu(env);
> +
> +    if (!cpu->enable_cpuid_0xb) {
> +        *eax = *ebx = *ecx = *edx = 0;
> +        return;
> +    }
> +
> +    *ecx = count & 0xff;
> +    *edx = cpu->apic_id;
> +
> +    switch (count) {
> +        case 0:
> +            *eax = apicid_core_offset(topo_info);
> +            *ebx = topo_info->threads_per_core;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
> +            break;
> +        case 1:
> +            *eax = apicid_pkg_offset(topo_info);
> +            *ebx = threads_per_pkg;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
> +            break;
> +        default:
> +            *eax = 0;
> +            *ebx = 0;
> +            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
> +    }
> +
> +    assert(!(*eax & ~0x1f));
> +    *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> +}
> +
>  /* Encode cache info for CPUID[0x80000005].ECX or CPUID[0x80000005].EDX */
>  static uint32_t encode_cache_cpuid80000005(CPUCacheInfo *cache)
>  {
> @@ -6601,33 +6638,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          break;
>      case 0xB:
>          /* Extended Topology Enumeration Leaf */
> -        if (!cpu->enable_cpuid_0xb) {
> -                *eax = *ebx = *ecx = *edx = 0;
> -                break;
> -        }
> -
> -        *ecx = count & 0xff;
> -        *edx = cpu->apic_id;
> -
> -        switch (count) {
> -        case 0:
> -            *eax = apicid_core_offset(&topo_info);
> -            *ebx = topo_info.threads_per_core;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_SMT << 8;
> -            break;
> -        case 1:
> -            *eax = apicid_pkg_offset(&topo_info);
> -            *ebx = threads_per_pkg;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_CORE << 8;
> -            break;
> -        default:
> -            *eax = 0;
> -            *ebx = 0;
> -            *ecx |= CPUID_B_ECX_TOPO_LEVEL_INVALID << 8;
> -        }
> -
> -        assert(!(*eax & ~0x1f));
> -        *ebx &= 0xffff; /* The count doesn't need to be reliable. */
> +        encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
> +                            eax, ebx, ecx, edx);
>          break;
>      case 0x1C:
>          if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_EDX_ARCH_LBR)) {
> @@ -6639,6 +6651,10 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
>          /* V2 Extended Topology Enumeration Leaf */
>          if (!x86_has_extended_topo(env->avail_cpu_topo)) {
>              *eax = *ebx = *ecx = *edx = 0;
> +            if (cpu->enable_cpuid_0x1f_enforce) {
> +                encode_topo_cpuid_b(env, count, &topo_info, threads_per_pkg,
> +                                    eax, ebx, ecx, edx);
> +            }
>              break;
>          }
>  
> @@ -8316,6 +8332,7 @@ static Property x86_cpu_properties[] = {
>      DEFINE_PROP_BOOL("full-cpuid-auto-level", X86CPU, full_cpuid_auto_level, true),
>      DEFINE_PROP_STRING("hv-vendor-id", X86CPU, hyperv_vendor),
>      DEFINE_PROP_BOOL("cpuid-0xb", X86CPU, enable_cpuid_0xb, true),
> +    DEFINE_PROP_BOOL("cpuid-0x1f-enforce", X86CPU, enable_cpuid_0x1f_enforce, true),
>      DEFINE_PROP_BOOL("x-vendor-cpuid-only", X86CPU, vendor_cpuid_only, true),
>      DEFINE_PROP_BOOL("x-amd-topoext-features-only", X86CPU, amd_topoext_features_only, true),
>      DEFINE_PROP_BOOL("lmce", X86CPU, enable_lmce, false),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1e121acef5..718b9f2b0b 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2102,6 +2102,11 @@ struct ArchCPU {
>      /* Compatibility bits for old machine types: */
>      bool enable_cpuid_0xb;
>  
> +    /* Always return values for 0x1f leaf. In cases where extended CPU topology
> +     * is not supported, return values equivalent of leaf 0xb.
> +     */
> +    bool enable_cpuid_0x1f_enforce;
> +
>      /* Enable auto level-increase for all CPUID leaves */
>      bool full_cpuid_auto_level;
>  
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index becca2efa5..a9c6f02900 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1799,6 +1799,7 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>      uint32_t limit, i, j;
>      uint32_t unused;
>      struct kvm_cpuid_entry2 *c;
> +    X86CPU *cpu = env_archcpu(env);
>  
>      cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
>  
> @@ -1831,7 +1832,8 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
>              break;
>          }
>          case 0x1f:
> -            if (!x86_has_extended_topo(env->avail_cpu_topo)) {
> +            if (!x86_has_extended_topo(env->avail_cpu_topo) &&
> +                !cpu->enable_cpuid_0x1f_enforce) {
>                  cpuid_i--;
>                  break;
>              }


