Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB58CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 19:35:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqzQS-0006eH-Fu; Tue, 26 Aug 2025 15:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqzQN-0006e2-9N; Tue, 26 Aug 2025 15:33:43 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqzQJ-0006jV-Na; Tue, 26 Aug 2025 15:33:43 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-55f42dcbf4aso2872627e87.1; 
 Tue, 26 Aug 2025 12:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756236812; x=1756841612; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hsZ4JdflU0jHG0jI3A/2ie9c7TKVyoHoMLurY/I3gtk=;
 b=VAjZ0HA/3vBTAlTIXdIXiiCkq54dHNjsjAY0P1mDVFbmkQhs8Ywa/A9hqYYDU3HcG6
 TDYTMXgDvlxAIubZv1xxoQt/eyROtLM0sJrcb5RY8IzHYiJIQE5HaG25BsA62Ulv+at4
 843ZJhocVCejzxFs6+YpY6vhPP4h/hcMIH3tWO4LCa0sOwGThslPPN0dJ76S8CDdsfk1
 hMb8Hv+Bbr6cHfR2+cuRHK/hqi2PJRN9TZ/MIU+YXQb8QTATV/AW0faDlijltT1gmUPc
 ZxFS5mVZ+m4SHcBMdmgn/q/vsC+q0o8wzuSHHqQbM/Wbi70DXdatiIj78aWtoAMTVMhB
 hTCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756236812; x=1756841612;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hsZ4JdflU0jHG0jI3A/2ie9c7TKVyoHoMLurY/I3gtk=;
 b=A/8LJHci/8EWmJjucNuiujbfNJDmnkV94QNV8EYYASBPNTGHC5R40oV7/bC0GN665x
 6qaoXMnTOHJVNB6+2zLlYwdNSTr7M2YUDWUeQQhrCOhYEuWNBSr9VrblftCuwS4s4oFH
 4usNjud7sNKxmMQbXwHd+cZGxy1yWrF/xlBZebuGCRmu2KBaldu4o8BbXy+vFhupDjiI
 d57rn35rnLxxyvjeUiYI+yzXJ0l2pP2SAWj8dHDlnMgFOvIIAEZIwXvMbRiSKDi/X4vK
 IKv0dv3qnIXRw+wu/XsWts2uGgOQHAxvPIhW7Ic4Jjmo60xMNohcB0FGqSjGJjZp5PTL
 zgfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhe9rOGWk/Cm7SP+G5mbAlmEPH9DqT9gjaoaQ+1T8lhYwMjmtqit997iSaRiKscaR1gMuIJNmrhA==@nongnu.org
X-Gm-Message-State: AOJu0Yy4f4nkOWSBsXB48tiLPKPKWP68tviigZUwsrwoVReogVn0TtfJ
 A/2Tv6PjX864wKV9BvrQM+M4G7TsTVK3pPzEbv1zylTh5MoGlNg1DBpG
X-Gm-Gg: ASbGncsJlJnQaTMHYxCX/CCbhw6huSlPVWEYt8IGepyxA23E5+R+mQgDefAhzWDEqJn
 FKJq5WrRC5USb9kBE780byYisk45WsCGvQ8m/3rlwSvcOpXfZaE/BBqoMKnOezhQ1OY2LkiyE8v
 1itZj0hhfda6f14yxxisPxxQToBkylAI+wUj83R8y1ghMkKo+W92kyJDQdb3b9/rEZJS37pgndq
 LjH2+1ZBtxrB43SZg8RO5StPEAbr/wqq/+UXoyPE3D6u/9OZtGhCXKx9eVkTQSNY++tbrCfxU5V
 dP1VPdm3HQvAfbwV4f0LALoWL30LlpHaYvd47RhyKyS4HfZJFBY+4lQ745EH2cITzGBLAlD9i6f
 n9gu0/3Afb3BnGcDmhH3x8dHhmC43egX40ZPQl4QxIbi/y/zqRRUcnd81lJWSCm6MWMo5qQ==
X-Google-Smtp-Source: AGHT+IH0jSc5CiZpAmJht6PX144SbsjPN4qXxlxkQ5nUEprlSAbNHpE1RNN6MmHlBQ6GEuxDl952sQ==
X-Received: by 2002:a05:6512:6207:b0:55f:4714:f3c with SMTP id
 2adb3069b0e04-55f47141325mr2541092e87.4.1756236811615; 
 Tue, 26 Aug 2025 12:33:31 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35c13debsm2325299e87.57.2025.08.26.12.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 12:33:30 -0700 (PDT)
Date: Tue, 26 Aug 2025 21:33:29 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Francisco Iglesias <francisco.iglesias@xilinx.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v4 23/47] hw/intc/arm_gicv3: Introduce a
 'first-cpu-index' property
Message-ID: <aK4MCVXhR2hazu6B@zapote>
References: <20250822151614.187856-1-luc.michel@amd.com>
 <20250822151614.187856-24-luc.michel@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822151614.187856-24-luc.michel@amd.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 22, 2025 at 05:15:48PM +0200, Luc Michel wrote:
> From: Francisco Iglesias <francisco.iglesias@xilinx.com>
> 
> Introduce a 'first-cpu-index' property for specifying the first QEMU CPU
> connected to the GICv3. This makes it possible to have multiple instances
> of the GICv3 connected to different CPU clusters.
> 
> For KVM, mark this property has unsupported. It probably does not make
> much sense as it is intented to be used to model non-SMP systems.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>

Peter, were you looking at solving this with links to CPU's for the next
GIC? Perhaps we should do the same here?

I'm also fine with this patch as simple way of solving this problem.

Cheers,
Edgar




> ---
>  include/hw/intc/arm_gicv3_common.h | 1 +
>  hw/intc/arm_gicv3_common.c         | 3 ++-
>  hw/intc/arm_gicv3_cpuif.c          | 2 +-
>  hw/intc/arm_gicv3_kvm.c            | 6 ++++++
>  4 files changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
> index c18503869f9..3c2ed30de71 100644
> --- a/include/hw/intc/arm_gicv3_common.h
> +++ b/include/hw/intc/arm_gicv3_common.h
> @@ -226,10 +226,11 @@ struct GICv3State {
>      MemoryRegion iomem_dist; /* Distributor */
>      GICv3RedistRegion *redist_regions; /* Redistributor Regions */
>      uint32_t *redist_region_count; /* redistributor count within each region */
>      uint32_t nb_redist_regions; /* number of redist regions */
>  
> +    uint32_t first_cpu_idx;
>      uint32_t num_cpu;
>      uint32_t num_irq;
>      uint32_t revision;
>      uint32_t maint_irq;
>      bool lpi_enable;
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index e438d8c042d..2d0df6da86c 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -434,11 +434,11 @@ static void arm_gicv3_common_realize(DeviceState *dev, Error **errp)
>      }
>  
>      s->cpu = g_new0(GICv3CPUState, s->num_cpu);
>  
>      for (i = 0; i < s->num_cpu; i++) {
> -        CPUState *cpu = qemu_get_cpu(i);
> +        CPUState *cpu = qemu_get_cpu(s->first_cpu_idx + i);
>          uint64_t cpu_affid;
>  
>          s->cpu[i].cpu = cpu;
>          s->cpu[i].gic = s;
>          /* Store GICv3CPUState in CPUARMState gicv3state pointer */
> @@ -620,10 +620,11 @@ static const Property arm_gicv3_common_properties[] = {
>      DEFINE_PROP_BOOL("force-8-bit-prio", GICv3State, force_8bit_prio, 0),
>      DEFINE_PROP_ARRAY("redist-region-count", GICv3State, nb_redist_regions,
>                        redist_region_count, qdev_prop_uint32, uint32_t),
>      DEFINE_PROP_LINK("sysmem", GICv3State, dma, TYPE_MEMORY_REGION,
>                       MemoryRegion *),
> +    DEFINE_PROP_UINT32("first-cpu-index", GICv3State, first_cpu_idx, 0),
>  };
>  
>  static void arm_gicv3_common_class_init(ObjectClass *klass, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
> diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
> index 4b4cf091570..1af7690b958 100644
> --- a/hw/intc/arm_gicv3_cpuif.c
> +++ b/hw/intc/arm_gicv3_cpuif.c
> @@ -3022,11 +3022,11 @@ void gicv3_init_cpuif(GICv3State *s)
>       * registers with the CPU
>       */
>      int i;
>  
>      for (i = 0; i < s->num_cpu; i++) {
> -        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
> +        ARMCPU *cpu = ARM_CPU(qemu_get_cpu(s->first_cpu_idx + i));
>          GICv3CPUState *cs = &s->cpu[i];
>  
>          /*
>           * If the CPU doesn't define a GICv3 configuration, probably because
>           * in real hardware it doesn't have one, then we use default values
> diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
> index 6166283cd1a..e6a09c9b7d0 100644
> --- a/hw/intc/arm_gicv3_kvm.c
> +++ b/hw/intc/arm_gicv3_kvm.c
> @@ -807,10 +807,16 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
>      if (s->nmi_support) {
>          error_setg(errp, "NMI is not supported with the in-kernel GIC");
>          return;
>      }
>  
> +    if (s->first_cpu_idx != 0) {
> +        error_setg(errp, "Non-zero first-cpu-idx is unsupported with the "
> +                   "in-kernel GIC");
> +        return;
> +    }
> +
>      gicv3_init_irqs_and_mmio(s, kvm_arm_gicv3_set_irq, NULL);
>  
>      for (i = 0; i < s->num_cpu; i++) {
>          ARMCPU *cpu = ARM_CPU(qemu_get_cpu(i));
>  
> -- 
> 2.50.1
> 
> 

