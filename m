Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC800C55ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrLEi-0004JE-9J; Tue, 04 Aug 2026 15:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wrLEc-0004Ix-Sp; Tue, 04 Aug 2026 15:55:36 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wrLEb-0000Us-3d; Tue, 04 Aug 2026 15:55:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2C1EB583781;
 Tue, 04 Aug 2026 21:55:28 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 638yrKVN5oFT; Tue,  4 Aug 2026 21:55:26 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 11FA9583224; Tue, 04 Aug 2026 21:55:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 10021583223;
 Tue, 04 Aug 2026 21:55:26 +0200 (CEST)
Date: Tue, 4 Aug 2026 21:55:26 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
cc: qemu-ppc@nongnu.org, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Vaibhav Jain <vaibhav@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 qemu-devel@nongnu.org, Gautam Menghani <gautam@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] target/ppc/kvm: Use host compatibility mode for
 nested guests
In-Reply-To: <20260804182914.83091-4-amachhiw@linux.ibm.com>
Message-ID: <bce28234-2d74-8a2d-d21f-ff1844147441@eik.bme.hu>
References: <20260804182914.83091-1-amachhiw@linux.ibm.com>
 <20260804182914.83091-4-amachhiw@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 4 Aug 2026, Amit Machhiwal wrote:
> On POWER systems, the host CPU may run in a compatibility mode (e.g.,
> a Power11 processor operating in Power10 compatibility mode). When
> running nested KVM guests, QEMU currently derives the host CPU type
> using mfpvr(), which reflects the physical processor version. This can
> result in a mismatch between the CPU model used by QEMU and the
> compatibility mode enforced by the host, leading to guest boot failures
> such as "KVM-NESTEDv2: couldn't set guest wide elements".
>
> Update kvm_ppc_get_host_cpu_class() to check if the host is running in
> a compatibility mode using kvm_ppc_host_compat_pvr(). When available,
> use the compatibility PVR instead of the raw hardware PVR when selecting
> the CPU model. This ensures that QEMU selects a CPU model consistent
> with the host compatibility mode, allowing nested guests to boot
> correctly.
>
> The guard uses #if defined(TARGET_PPC64) to prevent build breakage on
> ppc32 targets where the POWER9/10/11 PVR constants are not defined.
>
> Tested-by: Gautam Menghani <gautam@linux.ibm.com>
> Reviewed-by: Gautam Menghani <gautam@linux.ibm.com>
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> ---
> No changes in this version.
>
> target/ppc/kvm.c | 12 ++++++++++++
> 1 file changed, 12 insertions(+)
>
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d4c5601a00c4..aa8269186a1a 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2682,6 +2682,18 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>     uint32_t host_pvr = mfpvr();
>     PowerPCCPUClass *pvr_pcc;
>
> +#if defined(TARGET_PPC64)
> +#ifndef CONFIG_KVM
> +#error "CONFIG_KVM is not enabled"
> +#endif

In meson.build:

ppc_system_ss.add(when: 'CONFIG_KVM', if_true: files('kvm.c'))

so I think this check and #error does not make sense.

Regards,
BALATON Zoltan

> +    uint32_t compat_host_pvr;
> +
> +    compat_host_pvr = kvm_ppc_host_compat_pvr();
> +    if (compat_host_pvr) {
> +        host_pvr = compat_host_pvr;
> +    }
> +#endif /* TARGET_PPC64 */
> +
>     pvr_pcc = ppc_cpu_class_by_pvr(host_pvr);
>     if (pvr_pcc == NULL) {
>         pvr_pcc = ppc_cpu_class_by_pvr_mask(host_pvr);
>

