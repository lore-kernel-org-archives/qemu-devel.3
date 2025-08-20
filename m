Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BAACA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 12:17:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uohkv-0002jG-5o; Wed, 20 Aug 2025 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohk8-0002fM-Ll
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:16:47 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uohk6-0001CR-Cc
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 08:16:40 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45a15fd04d9so5682635e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 05:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755692194; x=1756296994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Vp/QjFZ1FU4U+xaHSRbqmEPNR+cg/hobxBDA2QWWMVo=;
 b=LWHmH0jDcTrKz1UhyCfbJJ4FDmWnwkJAtaF3FoMofxVwxw9WU1j+NIQzIhN85osVp/
 P604ek8N97JQobtRZUQc2qzKS8/oHASIP0K25O+utWRQITS0pKe22UgHnXolpPdXzeYQ
 iihfw1eTgcEDtVHqkz8/DZ7yQHghPD2+Sc3lkYpyrwoRm5IfMlJTxKDoYqxflBJd5ER5
 yEIRAU+6ediqYGpMk5R8BIuF/7+d29xQZBlvAWIMy5cDQpM78kI52+VvWEmu6xOUlzyL
 +sC3GIOVVKZyLZ+3p3uRzWKSMbUQCijC/OeGj4S90WEpXPiYItN2683RTccFv+wH5fSL
 tPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755692194; x=1756296994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Vp/QjFZ1FU4U+xaHSRbqmEPNR+cg/hobxBDA2QWWMVo=;
 b=g2PqU01ceCtSVxiSumlSRSMnPSKCR6+u55BMfIRUlIMmtxCOvTgkEo829U2IKcNT5u
 z4zDJcnqmKPZWLuBrmsp6A1u4pMgbn6JtLG0oZim/0Xnsa2ewF1JMVpz5JPSw7xEqPRb
 HAFBYOh0zImdJHUdtvke8dXKdHuSdgdGwZd96I6EHQvYTaCAD0JRzHqzS23b0vlK2siF
 LfMnSaHWQYfTr3xAL7iJtZDbW00egISlrFLexD3hAPNR/I9iA4UoWjP1onC+aadfh7GA
 konlYPfzhBZnomtQcDvTAk8DCZZaPbi7Vg7uFHPz20Blvrg1kIiZwB36347jan7jsD7X
 rNsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8ywF5EpuS0EVVfOtTXpqFrlov72A96DVDSXIA8obokW5Eqk10Bp1hXlGMKCPG1nRHMBb6pD/VWnM9@nongnu.org
X-Gm-Message-State: AOJu0Yy1CauLbTBVhcODndSZWgR7IKCeHyfUHz3rC3yS86TXt3c7UhbE
 thxhDY3Tn0+I/c1vxZftWGbFxT55iF7dSB5E+7a96kMLu2JMOP70IYtAGFCisYXWTr8=
X-Gm-Gg: ASbGncuDJAHMbhi73x7Ucwd2V/nkqgniPXCtrJDigcH2xipcdIWsSioRwmEZHnxiY06
 4yEle1VTOmg/xxIH/Q3p6ooJniUMdwGhqVUV4Vy9Pf+OHfgRWeRRQKh8GyIrs/D1nJHfNpz1cey
 Z3Db8/f/f4OHBBq1e9v+qANEeF0Sr6SsyuwI3eTGZeciG7mBDEKSCUPqbANvRiaLoWhoerPWLLs
 idBlGOQzVAOEhTR244fi+fvP3QOSfX9i0xoBd230WQSStYQsgsY3e2bw756k047iJ6EHMDAkzjZ
 l1uncatPNvGWCDgjWCbVcAbbiMV8DL/RkO6iohMEPr1z5YMzeYYREwZwP3/vN+VjbNKXh0pwDHb
 f7DAy7PWOx74GhxudYvbJch8/CY/JzeTYjhyKI3Vob3SeIgCQvhnd9fvTmVdhROjchBt9LEo=
X-Google-Smtp-Source: AGHT+IFEi4YgJwx9QOPHRuSQg9x7E9u5pPB/ENBTvrbrydSim9dsGKkDD6yoRwld9MJiXEfuk6kMaA==
X-Received: by 2002:a05:6000:4313:b0:3c3:5406:12b6 with SMTP id
 ffacd0b85a97d-3c3540616bdmr1896302f8f.30.1755692194097; 
 Wed, 20 Aug 2025 05:16:34 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b47c8e379sm33652275e9.13.2025.08.20.05.16.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 05:16:33 -0700 (PDT)
Message-ID: <9a47da92-1d12-4eda-9c18-235f93bca8b5@linaro.org>
Date: Wed, 20 Aug 2025 14:16:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 20/47] hw/arm/xlnx-versal: refactor CPU cluster creation
To: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
 <20250820082549.69724-21-luc.michel@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250820082549.69724-21-luc.michel@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi Luc,

On 20/8/25 10:25, Luc Michel wrote:
> Refactor the CPU cluster creation using the VersalMap structure. There
> is no functional change. The clusters properties are now described in
> the VersalMap structure. For now only the APU is converted. The RPU will
> be taken care of by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>
> Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
> ---
>   include/hw/arm/xlnx-versal.h |  11 +-
>   hw/arm/xlnx-versal-virt.c    |  80 +-------
>   hw/arm/xlnx-versal.c         | 346 ++++++++++++++++++++++++++---------
>   3 files changed, 269 insertions(+), 168 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index af47acb288f..ba5719d80f5 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h


> @@ -41,19 +40,10 @@ OBJECT_DECLARE_TYPE(Versal, VersalClass, XLNX_VERSAL_BASE)
>   struct Versal {
>       /*< private >*/
>       SysBusDevice parent_obj;
>   
>       /*< public >*/
> -    struct {
> -        struct {
> -            MemoryRegion mr;
> -            CPUClusterState cluster;
> -            ARMCPU cpu[XLNX_VERSAL_NR_ACPUS];
> -            GICv3State gic;
> -        } apu;
> -    } fpd;


> @@ -427,11 +359,11 @@ static void versal_virt_init(MachineState *machine)
>           /* Some boot-loaders (e.g u-boot) don't like blobs at address 0 (NULL).
>            * Offset things by 4K.  */
>           s->binfo.loader_start = 0x1000;
>           s->binfo.dtb_limit = 0x1000000;
>       }
> -    arm_load_kernel(&s->soc.fpd.apu.cpu[0], machine, &s->binfo);
> +    arm_load_kernel(ARM_CPU(qemu_get_cpu(0)), machine, &s->binfo);

We'd like to restrict qemu_get_cpu() to generic accelerator code, where
what type of scheduled vCPU doesn't matter. And forbid this API under
hw/, because it triggers odd bugs in heterogenous context (we can
instanciate vCPU in random order, and hot[un]plug them, changing their
id). Besides hw/ normally have knowledge of how to directly address a
CPU (how/where it is wired). So I'm not really keen on adding another
qemu_get_cpu() call here. Can't we keep references in VersalVirt (at
least for the booting cpu)?

>   
>       for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
>           ObjectClass *flash_klass;
>           DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
>           BlockBackend *blk;
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index fe2c789a557..5a08ad07b28 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -41,10 +41,11 @@
>   #include "hw/rtc/xlnx-zynqmp-rtc.h"
>   #include "hw/misc/xlnx-versal-cfu.h"
>   #include "hw/misc/xlnx-versal-cframe-reg.h"
>   #include "hw/or-irq.h"
>   #include "hw/misc/xlnx-versal-crl.h"
> +#include "hw/intc/arm_gicv3_common.h"
>   
>   #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>   #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>   #define GEM_REVISION        0x40070106
>   
> @@ -65,11 +66,38 @@ FIELD(VERSAL_IRQ, OR_IDX, 19, 4) /* input index on the IRQ OR gate */
>   typedef struct VersalSimplePeriphMap {
>       uint64_t addr;
>       int irq;
>   } VersalSimplePeriphMap;
>   
> +typedef struct VersalGicMap {
> +    int version;
> +    uint64_t dist;
> +    uint64_t redist;
> +    size_t num_irq;
> +} VersalGicMap;
> +
> +enum StartPoweredOffMode {
> +    SPO_SECONDARIES,
> +    SPO_ALL,
> +};
> +
> +typedef struct VersalCpuClusterMap {
> +    VersalGicMap gic;
> +
> +    const char *name;
> +    const char *cpu_model;
> +    size_t num_core;
> +    size_t num_cluster;
> +    uint32_t qemu_cluster_id;
> +    bool dtb_expose;
> +
> +    enum StartPoweredOffMode start_powered_off;
> +} VersalCpuClusterMap;
> +
>   typedef struct VersalMap {
> +    VersalCpuClusterMap apu;
> +
>       VersalSimplePeriphMap uart[2];
>       size_t num_uart;

