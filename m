Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97826CD5BA4
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 08:32:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPypi-0004KR-KG; Thu, 21 May 2026 04:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPypX-0004Ja-9Z
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:32:36 -0400
Received: from mail-dy1-x1342.google.com ([2607:f8b0:4864:20::1342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wPypV-0000PB-KQ
 for qemu-devel@nongnu.org; Thu, 21 May 2026 04:32:35 -0400
Received: by mail-dy1-x1342.google.com with SMTP id
 5a478bee46e88-3042dffd80bso816432eec.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779352352; x=1779957152; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+6No0yjnmUWyrgInQKRrDpjvKNQHqNjJFRDChistP4I=;
 b=R+QwjfDfwQhQFZprUU06YAARLCYfUJ26pDbmap7WSkHlQg28IGgHzOt84JNOiCueEM
 LHB827CVBALETn4ZdQI7dr8zVKfGo6qenH01OpbpZLk1EETtGkB7XC1v9cTBX7JHIEaa
 WmXeuX4wuv2+Jko/PJMA3ehOqXiLfeR5wSdyRpnF9oUQcCilfPCY265afaDFpO4lb7Al
 mn6rV/RJ/caQZ2e9I7QKgL0mD8TkNemuELmnulRtH/+JTtp2vFBxOTzUnGbDjkKv8eYB
 qTwpPAYrVtim5niAaTj502NfGY4lN8hPvSA5k2sZalCkc8rs8RTFz/YeSrAMtY36s7Za
 dCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779352352; x=1779957152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+6No0yjnmUWyrgInQKRrDpjvKNQHqNjJFRDChistP4I=;
 b=SCBPTo2JW0KajDCFkb/TOy83/qnjS9SrXzpcz8+qZnFTQ6UpkzWc/bXEHWWDAKYNp/
 WT5uArVQ90YljTVx+zdeHveJH5fGolfREXVxVxLEjzKNU3XaRoChptysSNOb/RbD7urL
 FeyIz3MfbmTOLglVVNT+ZXIZC8HXWRlR46xCIe2clB49laWW5SAesty0KQUnIyKaZJ5U
 yUQuIsHSOiPRI5XFdZtGonhGnG22QtJbeRWb3s+92xMXMkvQslyKlVGbo+jV03h5IUPx
 bYN7D/caohD3lJWnCNiu/PxX5HiNdyh+26UNbit7Q6id03NeLUtXl1eT7gykOePB6yRH
 Xfkw==
X-Gm-Message-State: AOJu0YwFO7RpVVc1QWWnxcO8nGrROi9YpAo+QD081xnNlpXuHqbOEhxR
 /6p3VqWyQRRMVSC/nhOLJY+rMNDDnvAO/pmQ08N0UTIdHKkf6YDhsPi5
X-Gm-Gg: Acq92OE3GuLaKyE57lQYai3qWuvDFJ2dRbxyIITjrfLaCGViFOPs81LrFqre/DMZBQ5
 B2BFMQk0RzOM0BSfb3Sg9ABsao23YXuFKlPP4oMu04GJ8WcH3Io83POW6FVB1x1Pez2hBI0SIbj
 QFjDszyVPQNYtfR+oiNZlhS35jagZu8vGDVyhPNA7+AOZ035Z8YSHDBrm/HGJZIvO5DbvOyPU/x
 XzYPyUqKRLkNgeurhpabkgC8cAwHHakh6J46RwiQ5Q9uM8YWPBfhUIh/EeijaQIU2dc7Oumxvw5
 P1Zvygn47iJLg9rFwprdlc4JpcIFR/gbxjbquVjAgDaCqEdp2Qlrqwgk1lJsxJW/p7jwOz/mwkY
 391pXRIHw+Qg7cMEJ4EseSFVhiKCyhnhV2TJ+vetVtBc13/Qe94xttm0XRK+KNEJpqw7G1y2wG9
 Bd3U/X7KJnmSFGdL8/t0Hl3k+s8T2saDufKvck/vNKUg3IHq373lAejhHD7ZaaN995aZEH9w==
X-Received: by 2002:a05:7301:d8b:b0:2da:44ac:6d17 with SMTP id
 5a478bee46e88-3042f926620mr1172455eec.17.1779352351780; 
 Thu, 21 May 2026 01:32:31 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6e9sm25697180eec.16.2026.05.21.01.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:32:31 -0700 (PDT)
Date: Thu, 21 May 2026 16:32:27 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, philmd@linaro.org, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
Subject: Re: [PATCH v3 07/14] target/riscv: Replace TYPE_RISCV_CPU_BASE
Message-ID: <ag7DDwAL-H59sMB2@ChaodeMacBook-Pro.local>
References: <20260520-hw-riscv-cpu-int-v3-0-d1123ea63d9c@rev.ng>
 <20260520-hw-riscv-cpu-int-v3-7-d1123ea63d9c@rev.ng>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-hw-riscv-cpu-int-v3-7-d1123ea63d9c@rev.ng>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1342;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1342.google.com
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

On Wed, May 20, 2026 at 03:12:59PM +0800, Anton Johansson via wrote:
> TYPE_RISCV_CPU_BASE is used only to initialize the correct default
> machine for 3 machines. Replace it with a runtime check.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

> ---
>  include/hw/riscv/machines-qom.h | 12 ++++++++++++
>  target/riscv/cpu.h              |  6 ------
>  hw/riscv/microblaze-v-generic.c |  2 +-
>  hw/riscv/spike.c                |  2 +-
>  hw/riscv/virt.c                 |  2 +-
>  5 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/hw/riscv/machines-qom.h b/include/hw/riscv/machines-qom.h
> index 3459437d84..8396155373 100644
> --- a/include/hw/riscv/machines-qom.h
> +++ b/include/hw/riscv/machines-qom.h
> @@ -9,7 +9,9 @@
>  #ifndef HW_RISCV_MACHINES_QOM_H
>  #define HW_RISCV_MACHINES_QOM_H
>  
> +#include "qemu/target-info.h"
>  #include "hw/core/boards.h"
> +#include "target/riscv/cpu-qom.h"
>  
>  #define TYPE_TARGET_RISCV32_MACHINE \
>          "target-info-riscv32-machine"
> @@ -43,4 +45,14 @@ extern InterfaceInfo riscv32_64_machine_interfaces[];
>          DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
>                                              riscv32_64_machine_interfaces)
>  
> +/* Default CPU type inferred from target info */
> +static inline const char *riscv_default_cpu_type(void)
> +{
> +    if (target_riscv64()) {
> +        return TYPE_RISCV_CPU_BASE64;
> +    } else {
> +        return TYPE_RISCV_CPU_BASE32;
> +    }
> +}
> +
>  #endif
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index fb44f0485d..f521686c43 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -39,12 +39,6 @@ typedef struct CPUArchState CPURISCVState;
>  
>  #define CPU_RESOLVING_TYPE TYPE_RISCV_CPU
>  
> -#if defined(TARGET_RISCV32)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE32
> -#elif defined(TARGET_RISCV64)
> -# define TYPE_RISCV_CPU_BASE            TYPE_RISCV_CPU_BASE64
> -#endif
> -
>  /*
>   * b0: Whether a instruction always raise a store AMO or not.
>   */
> diff --git a/hw/riscv/microblaze-v-generic.c b/hw/riscv/microblaze-v-generic.c
> index d33ac39a68..386c5dce9c 100644
> --- a/hw/riscv/microblaze-v-generic.c
> +++ b/hw/riscv/microblaze-v-generic.c
> @@ -183,7 +183,7 @@ static void mb_v_generic_machine_init(MachineClass *mc)
>      mc->init = mb_v_generic_init;
>      mc->min_cpus = 1;
>      mc->max_cpus = 1;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = riscv_default_cpu_type();
>      mc->default_cpus = 1;
>  }
>  
> diff --git a/hw/riscv/spike.c b/hw/riscv/spike.c
> index 08ef291b6b..b937cf0fa6 100644
> --- a/hw/riscv/spike.c
> +++ b/hw/riscv/spike.c
> @@ -343,7 +343,7 @@ static void spike_machine_class_init(ObjectClass *oc, const void *data)
>      mc->init = spike_board_init;
>      mc->max_cpus = SPIKE_CPUS_MAX;
>      mc->is_default = true;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = riscv_default_cpu_type();
>      mc->possible_cpu_arch_ids = riscv_numa_possible_cpu_arch_ids;
>      mc->cpu_index_to_instance_props = riscv_numa_cpu_index_to_props;
>      mc->get_default_cpu_node_id = riscv_numa_get_default_cpu_node_id;
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 39caf37c01..e108e29f63 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1933,7 +1933,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
>      mc->desc = "RISC-V VirtIO board";
>      mc->init = virt_machine_init;
>      mc->max_cpus = VIRT_CPUS_MAX;
> -    mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
> +    mc->default_cpu_type = riscv_default_cpu_type();
>      mc->block_default_type = IF_VIRTIO;
>      mc->no_cdrom = 1;
>      mc->pci_allow_0_address = true;
> 
> -- 
> 2.52.0
> 
> 

