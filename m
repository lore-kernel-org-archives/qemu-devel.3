Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A5FCA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENr8-0002Rx-VM; Wed, 07 Oct 2026 05:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xEN2g-0002xx-S4
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xEN2a-0005fp-UK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 04:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791361812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qp2lJL9snYnEKuT235PoTU9jnDR3ji5fB4b56J7+nvA=;
 b=BXZLOEj44xBTsHv0fB+TfMSIoaOzwXSJkkRrw58PfLNil4+2KVFRUOfdGQK0fMki+fdMqD
 nxV/OPWDz8saiQzBgE+HT9f3JoROaIJApWRaIT4+igOI2KMuzlr2xuPNLaStPJm8u6Z8XF
 +YG/FM+XCsz/5Cw6MijxqI5tJFku1tE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-255-YdLhlQb2PL2DJIgwqiN7Eg-1; Tue,
 06 Oct 2026 04:04:49 -0400
X-MC-Unique: YdLhlQb2PL2DJIgwqiN7Eg-1
X-Mimecast-MFC-AGG-ID: YdLhlQb2PL2DJIgwqiN7Eg_1791273888
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 174EC184B39D; Tue,  6 Oct 2026 08:04:48 +0000 (UTC)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36BBB1956042; Tue,  6 Oct 2026 08:04:45 +0000 (UTC)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Mushahid Hussain <hmushi@amazon.co.uk>, qemu-devel@nongnu.org,
 linux-hyperv@vger.kernel.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org, nh-open-source@amazon.com,
 mushi.shar@gmail.com, Michael Kelley <mhkelley58@gmail.com>
Subject: Re: [PATCH] i386: Hyper-V partition time restore feature
In-Reply-To: <20261005194057.10910-1-hmushi@amazon.co.uk>
References: <20261005194057.10910-1-hmushi@amazon.co.uk>
Date: Tue, 06 Oct 2026 10:04:42 +0200
Message-ID: <kupqzi35k6d.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Mushahid Hussain <hmushi@amazon.co.uk> writes:

> A nested Hyper-V that sees the frequency MSRs lets L0 own the
> partition reference time. After a resume from hibernation it issues
> HvCallRestorePartitionTime with the TSC and the reference counter it
> saved. Hyper-V offers hibernation to its root partition only when L0
> advertises CPUID 0x40000004 EAX bit 20 (RestoreTimeOnResume).
>
> Add 'hv-restore-time-on-resume' for the bit. It requires
> 'hv-frequencies'. KVM reports the bit in KVM_GET_SUPPORTED_HV_CPUID
> when it handles the hypercall.
>
> KVM side: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/
>
> The TLFS marks the bit as reserved. The name comes from Microsoft's
> hvdef crate.

This won't be the first time we use side channels to implement Hyper-V
features in KVM/QEMU but it's certainly better when feature bits are
documented and thus backwards compatible.

Cc: linux-hyperv list, maybe there's a chance to get TLFS amended.

>
> Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
> ---
>  docs/system/i386/hyperv.rst    | 9 +++++++++
>  target/i386/cpu.c              | 2 ++
>  target/i386/cpu.h              | 1 +
>  target/i386/kvm/hyperv-proto.h | 1 +
>  target/i386/kvm/kvm.c          | 8 ++++++++
>  5 files changed, 21 insertions(+)
>
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index e1babffb0f..2224dc2111 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -259,6 +259,15 @@ Existing enlightenments
>  
>    Recommended: ``hv-evmcs`` (Intel)
>  
> +``hv-restore-time-on-resume``
> +  The enlightenment is nested specific, it targets Hyper-V on KVM guests. When
> +  enabled, Hyper-V lets L0 (KVM) own the partition reference time and issues
> +  HvCallRestorePartitionTime after a resume from hibernation so that the TSC
> +  and the reference counter continue from the values it saved. Hyper-V offers
> +  hibernation to its root partition only when this enlightenment is present.
> +
> +  Requires: ``hv-frequencies``
> +
>  Supplementary features
>  ----------------------
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index f3bc6911c1..9fa14f6fab 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10769,6 +10769,8 @@ static const Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_TLBFLUSH_EXT, 0),
>      DEFINE_PROP_BIT64("hv-tlbflush-direct", X86CPU, hyperv_features,
>                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
> +    DEFINE_PROP_BIT64("hv-restore-time-on-resume", X86CPU, hyperv_features,
> +                      HYPERV_FEAT_RESTORE_TIME_ON_RESUME, 0),
>      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
>                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
>  #ifdef CONFIG_SYNDBG
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 786957fadd..dab559a3d8 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1487,6 +1487,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>  #define HYPERV_FEAT_XMM_INPUT           18
>  #define HYPERV_FEAT_TLBFLUSH_EXT        19
>  #define HYPERV_FEAT_TLBFLUSH_DIRECT     20
> +#define HYPERV_FEAT_RESTORE_TIME_ON_RESUME 21
>  
>  #ifndef HYPERV_SPINLOCK_NEVER_NOTIFY
>  #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
> diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> index a9f056f2f3..e420827a68 100644
> --- a/target/i386/kvm/hyperv-proto.h
> +++ b/target/i386/kvm/hyperv-proto.h
> @@ -81,6 +81,7 @@
>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
>  #define HV_NO_NONARCH_CORESHARING           (1u << 18)
> +#define HV_RESTORE_TIME_ON_RESUME           (1u << 20)
>  
>  /*
>   * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index a72b6e6b74..1b16af7cd4 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1137,6 +1137,14 @@ static struct {
>          },
>          .dependencies = BIT(HYPERV_FEAT_VAPIC)
>      },
> +    [HYPERV_FEAT_RESTORE_TIME_ON_RESUME] = {
> +        .desc = "partition time restore (hv-restore-time-on-resume)",
> +        .flags = {
> +            {.func = HV_CPUID_ENLIGHTMENT_INFO, .reg = R_EAX,
> +             .bits = HV_RESTORE_TIME_ON_RESUME}
> +        },
> +        .dependencies = BIT(HYPERV_FEAT_FREQUENCIES)
> +    },
>  };
>  
>  static struct kvm_cpuid2 *try_get_hv_cpuid(CPUState *cs, int max,

-- 
Vitaly


