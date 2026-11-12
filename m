Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0F606A327
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SurB2W/g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRV5J-0004bo-60; Thu, 12 Nov 2026 08:43:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRV5H-0004Xv-0x
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:43:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRV5F-0004iQ-1P
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 08:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794491000;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=6h6g0wHWvKV2Nutj61rgDVrOeOCPiA8Sd5YSTzA22iA=;
 b=SurB2W/gsq6ONnFtaHk+ZpEAMW0Sipal3kGCUcY++90TcWbnM708qGVYi+NqlYQjPjAFsG
 LA+nXp+cZ6CySf0m1pOtzwG5OIHLy4oJlfXvCLvb3+bMq+mVRfQ3giuNnb1K+srOQ5epjN
 s1QhcQsICjeFk9Bb9jDpl45wmhwi+8Y=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-IQnlQwIuOciP-nv4vLlSRw-1; Thu,
 12 Nov 2026 08:43:14 -0500
X-MC-Unique: IQnlQwIuOciP-nv4vLlSRw-1
X-Mimecast-MFC-AGG-ID: IQnlQwIuOciP-nv4vLlSRw_1794490992
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B267A1955DE8; Thu, 12 Nov 2026 13:43:11 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22C5030000E8; Thu, 12 Nov 2026 13:43:05 +0000 (UTC)
Date: Thu, 12 Nov 2026 13:43:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Chao Liu <chao.liu@processmission.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v5 1/3] accel: register CPU parent only for AccelCPU
 subclasses
Message-ID: <avXCZ6IxBXWEuugm@redhat.com>
References: <20261106023936.772-1-luoyonggang@gmail.com>
 <20261106023936.772-2-luoyonggang@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106023936.772-2-luoyonggang@gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 06, 2026 at 10:39:33AM +0800, Yonggang Luo wrote:
> accel_cpu_register_type() creates the abstract parent
> accel-<cpu type>. A subclass names that parent, and
> type_initialize() aborts when the parent is missing. The old
> type_init registered only target_cpu_type(), which is one name
> in a multi-target process. Call the helper from the CPU type
> init of each target that has an AccelCPU subclass.
> 
> ARM calls it because whpx-common.c parents accel-arm-cpu on
> aarch64-softmmu. i386 calls it for TCG, KVM, HVF, NVMM, and
> MSHV. i386-softmmu and x86_64-softmmu each pass their own
> CPU_RESOLVING_TYPE, so WHPX on x86_64-softmmu finds
> accel-x86_64-cpu. RISC-V calls it for TCG and KVM. PowerPC
> calls it for KVM.
> 
> Other targets have no AccelCPU subclass. Machine init looks up
> tcg-accel-<cpu type> or kvm-accel-<cpu type> and skips a missing
> class, so those targets do not need the parent.
> 
> No extra tests is needed, as these QOM types already be
> tested by the existing logic instantiating all QOM types.
> 
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  accel/accel-common.c      | 6 ++----
>  include/accel/accel-cpu.h | 2 ++
>  target/arm/cpu.c          | 2 ++
>  target/i386/cpu.c         | 2 ++
>  target/ppc/cpu_init.c     | 2 ++
>  target/riscv/cpu.c        | 8 ++++++++
>  6 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/accel/accel-common.c b/accel/accel-common.c
> index 00a400243f..441d1b77fa 100644
> --- a/accel/accel-common.c
> +++ b/accel/accel-common.c
> @@ -130,9 +130,9 @@ static const TypeInfo accel_types[] = {
>  
>  DEFINE_TYPES(accel_types)
>  
> -static void register_accel_target_type(void)
> +void accel_cpu_register_type(const char *cpu_type)
>  {
> -    g_autofree char *name = g_strconcat("accel-", target_cpu_type(), NULL);
> +    g_autofree char *name = g_strconcat("accel-", cpu_type, NULL);
>      const TypeInfo accel_cpu_type = {
>          .name = name,
>          .parent = TYPE_OBJECT,
> @@ -142,5 +142,3 @@ static void register_accel_target_type(void)
>  
>      type_register_static(&accel_cpu_type);
>  }

Is there a reason why we need to register this base class
repeatedly for each target ? This class is defined in target
independent code and the target specific behaviour is provided
by subclasses AFAICT, so I'm not seeing why we need to
duplicate the class per target.

I just proposed changing its name to "accel-cpu" so that
it is always available:

  https://lists.gnu.org/archive/html/qemu-devel/2026-11/msg02741.html

> diff --git a/include/accel/accel-cpu.h b/include/accel/accel-cpu.h
> index 9e7eede7c3..2fdb64d2ae 100644
> --- a/include/accel/accel-cpu.h
> +++ b/include/accel/accel-cpu.h
> @@ -20,4 +20,6 @@ typedef struct AccelCPUClass {
>      bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
>  } AccelCPUClass;
>  
> +void accel_cpu_register_type(const char *cpu_type);
> +
>  #endif /* ACCEL_CPU_H */
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 71681447b2..725f1f3a5f 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -28,6 +28,7 @@
>  #include "qemu/module.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> +#include "accel/accel-cpu.h"
>  #ifdef CONFIG_TCG
>  #include "exec/translation-block.h"
>  #include "accel/tcg/cpu-ops.h"
> @@ -2753,6 +2754,7 @@ static const TypeInfo arm_cpu_type_info = {
>  
>  static void arm_cpu_register_types(void)
>  {
> +    accel_cpu_register_type(CPU_RESOLVING_TYPE);
>      type_register_static(&arm_cpu_type_info);
>  }
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index eab0d5a4d4..31b09e6f8e 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -23,6 +23,7 @@
>  #include "qemu/qemu-print.h"
>  #include "qemu/hw-version.h"
>  #include "cpu.h"
> +#include "accel/accel-cpu.h"
>  #include "tcg/helper-tcg.h"
>  #include "exec/translation-block.h"
>  #include "system/hvf.h"
> @@ -11093,6 +11094,7 @@ static void x86_cpu_register_types(void)
>  {
>      int i;
>  
> +    accel_cpu_register_type(CPU_RESOLVING_TYPE);
>      type_register_static(&x86_cpu_type_info);
>      for (i = 0; i < ARRAY_SIZE(builtin_x86_defs); i++) {
>          x86_register_cpudef_types(&builtin_x86_defs[i]);
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7f3036d903..fe3f2549b7 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -43,6 +43,7 @@
>  #include "exec/page-protection.h"
>  #include "exec/watchpoint.h"
>  #include "helper_regs.h"
> +#include "accel/accel-cpu.h"
>  #include "internal.h"
>  #include "spr_common.h"
>  #include "power8-pmu.h"
> @@ -7589,6 +7590,7 @@ static const TypeInfo ppc_vhyp_type_info = {
>  
>  static void ppc_cpu_register_types(void)
>  {
> +    accel_cpu_register_type(CPU_RESOLVING_TYPE);
>      type_register_static(&ppc_cpu_type_info);
>  #ifndef CONFIG_USER_ONLY
>      type_register_static(&ppc_vhyp_type_info);
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 362e561809..10e24f20e8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -25,6 +25,7 @@
>  #include "qemu/guest-random.h"
>  #include "qemu/atomic.h"
>  #include "cpu.h"
> +#include "accel/accel-cpu.h"
>  #include "cpu_vendorid.h"
>  #include "target/riscv/tcg/csr.h"
>  #include "internals.h"
> @@ -3931,3 +3932,10 @@ static const TypeInfo riscv_cpu_type_infos[] = {
>  };
>  
>  DEFINE_TYPES(riscv_cpu_type_infos)
> +
> +static void riscv_accel_cpu_register_type(void)
> +{
> +    accel_cpu_register_type(CPU_RESOLVING_TYPE);
> +}
> +
> +type_init(riscv_accel_cpu_register_type)
> -- 
> 2.55.0.windows.3
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


