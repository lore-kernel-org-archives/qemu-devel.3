Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0227CC282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 20:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tspak-0006kq-Cv; Thu, 13 Mar 2025 16:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspae-0006kL-Kd
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:55:41 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tspab-0005bI-E0
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 16:55:40 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fa8ada6662so3210853a91.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 13:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741899336; x=1742504136; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G/9hXYmTzwV+RTB30DRjR2yF1TPq50HiKAVfdM8z+k0=;
 b=kdIL9a2S1uIQJjxaMOsx8pvc+YfUBiwedSrcjN7nZvQOt97EBBln47aGiBck6oTN2K
 EQL/iQc50yGT+7zkxNI/qPKegBQwM2i78Er63O64SflaLGsW0xZoGZjRfI23rq6KgtHv
 6+1Ut0/6J76oTkNSSBVkFpwD+eEDGP53HYhzDRJ7dxVHAbtBRaYUkzfOgNF9uRIcf5O3
 n9VPfFGvBful2Gi18oyADTZ8NCG+8uHkFU4q8ZI55TZUf3wtqsnWyUpEfM9yE+ucA+MB
 2XTVzbyMTl24aKqXfT3BwEmLROlRm+8EShesTec6gxYbn7xma3XnCfDOiyxVoVgh5kSW
 lCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741899336; x=1742504136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G/9hXYmTzwV+RTB30DRjR2yF1TPq50HiKAVfdM8z+k0=;
 b=UpsjeSoa276b/AqZMuUB1qm/g+SwBZ64W9vmIGiTpv1ruhdbE1XvlT7bt/0Fv342aG
 5tbb8DxAUuRMzypkXfyQB6b9jrA3nrQ33StbYp33GUJtUrBlYgBjpM9Ko/zCUqTEO7xw
 2fAtVecIlJYeA0zBUksDuCzBGhX0zN83qU8YyoB6txHh/DIt/kkqagv2cPfv/jhn4Fyn
 wEpPOeeJstIlVh36R3xBFFY1fa15l4ky8YHcZUXY5kYPs/QtJLne5ktERW4CooL4Amoz
 DdRVGqEN2+qvW5WMDArc0OtdJXGM5zuUT3ps+O84oR4ifmQdAXnThrm2gQInpRZn0jOb
 Js1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWY3UYixR4NiyBS92zEVf8Kpbf3Ii8vKSrFXynSpSqfUb6uzpTB1tBd2Itxdl6PF8zh93qs6ep8ewnb@nongnu.org
X-Gm-Message-State: AOJu0YwTs06OqYXwtv4AQGo6dguxJQi5lfIqTojdqLEVS56ZsAD1CmC8
 QrS3UjHB5VSJDmVZNYJ6bqHK9Bf7U4+e0Cyov+uRZc6iLFBZgRdb+OIaE2puKV0=
X-Gm-Gg: ASbGnct/yv+e15MbPJCTZA4GL1mogLyQI6t8NuvY8vYQNc00eSDFCuT2JCqL8TV6xr5
 BH0pBDKtKEbwiWMIKTM8MeTSEAxMc4qBG2lgCg5PaFbqi46pAk8YiMTqnhTM5kmneW8ZmJNHXiM
 yJDCPtmQiQ9pG4I8qVLE9xQmWm/BC0/tahk8i67BFDKAWbwwurjQtAjUVjPZ16LfoE2Dq2ZO0X4
 3zPGTXKTPya8u2U5eF2edYr43EsyBxcb8/S5KU86eNDCbmohenKT3dXd56xZUGIXqRSVyLcGmTG
 9FVR+CTS8zy5wK+g9XZsVULZ1pM1LByEWnLxS8qNgGV8AlBDWC7a/yg+Mw==
X-Google-Smtp-Source: AGHT+IFR2tPt/Xqd1zEb4d608AAD3GqiJRDYbLJ2uW8dtk2kJh3+YKGt0+4OGb9vHpeSZTBz1VOMTw==
X-Received: by 2002:a05:6a20:2d27:b0:1f5:9961:c29 with SMTP id
 adf61e73a8af0-1f5c1209a02mr262761637.21.1741899336054; 
 Thu, 13 Mar 2025 13:55:36 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea04078sm1477293a12.41.2025.03.13.13.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 13:55:35 -0700 (PDT)
Message-ID: <18cf60c8-b360-42b9-8af1-7c4e85cd69cd@linaro.org>
Date: Thu, 13 Mar 2025 13:55:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/37] include/system: Move exec/ram_addr.h to
 system/ram_addr.h
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@linaro.org
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-24-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250313034524.3069690-24-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 3/12/25 20:45, Richard Henderson wrote:
> Convert the existing includes with sed.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/{exec => system}/ram_addr.h | 7 +++----
>   accel/kvm/kvm-all.c                 | 2 +-
>   accel/tcg/cputlb.c                  | 2 +-
>   accel/tcg/translate-all.c           | 2 +-
>   hw/ppc/spapr.c                      | 2 +-
>   hw/ppc/spapr_caps.c                 | 2 +-
>   hw/ppc/spapr_pci.c                  | 2 +-
>   hw/remote/memory.c                  | 2 +-
>   hw/remote/proxy-memory-listener.c   | 2 +-
>   hw/s390x/s390-stattrib-kvm.c        | 2 +-
>   hw/s390x/s390-stattrib.c            | 2 +-
>   hw/s390x/s390-virtio-ccw.c          | 2 +-
>   hw/vfio/common.c                    | 2 +-
>   hw/vfio/container.c                 | 2 +-
>   hw/vfio/iommufd.c                   | 2 +-
>   hw/vfio/migration.c                 | 2 +-
>   hw/vfio/spapr.c                     | 2 +-
>   hw/virtio/virtio-mem.c              | 2 +-
>   migration/ram.c                     | 2 +-
>   system/memory.c                     | 2 +-
>   system/physmem.c                    | 2 +-
>   target/arm/tcg/mte_helper.c         | 2 +-
>   target/ppc/kvm.c                    | 2 +-
>   target/s390x/kvm/kvm.c              | 2 +-
>   MAINTAINERS                         | 2 +-
>   25 files changed, 27 insertions(+), 28 deletions(-)
>   rename include/{exec => system}/ram_addr.h (99%)
> 
> diff --git a/include/exec/ram_addr.h b/include/system/ram_addr.h
> similarity index 99%
> rename from include/exec/ram_addr.h
> rename to include/system/ram_addr.h
> index 3d8df4edf1..65f8f37b2a 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/system/ram_addr.h
> @@ -16,10 +16,9 @@
>    * The functions declared here will be removed soon.
>    */
>   
> -#ifndef RAM_ADDR_H
> -#define RAM_ADDR_H
> +#ifndef SYSTEM_RAM_ADDR_H
> +#define SYSTEM_RAM_ADDR_H
>   
> -#ifndef CONFIG_USER_ONLY
>   #include "cpu.h"
>   #include "system/xen.h"
>   #include "system/tcg.h"
> @@ -557,5 +556,5 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
>   
>       return num_dirty;
>   }
> -#endif
> +
>   #endif
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 0d47bb0d9b..0723a3933b 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -34,7 +34,7 @@
>   #include "system/accel-blocker.h"
>   #include "qemu/bswap.h"
>   #include "system/memory.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qemu/event_notifier.h"
>   #include "qemu/main-loop.h"
>   #include "trace.h"
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 6f0ea9067b..134e523cab 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -27,7 +27,7 @@
>   #include "exec/cputlb.h"
>   #include "exec/tb-flush.h"
>   #include "exec/memory-internal.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "exec/mmu-access-type.h"
>   #include "exec/tlb-common.h"
>   #include "exec/vaddr.h"
> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 16e5043597..167535bcb1 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -40,7 +40,7 @@
>   #endif
>   #endif
>   #else
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #endif
>   
>   #include "exec/cputlb.h"
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index c15340a58d..e31bc0f0f3 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -74,7 +74,7 @@
>   #include "hw/virtio/virtio-scsi.h"
>   #include "hw/virtio/vhost-scsi-common.h"
>   
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "system/confidential-guest-support.h"
>   #include "hw/usb.h"
>   #include "qemu/config-file.h"
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 904bff87ce..fb010bd215 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -27,7 +27,7 @@
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
>   #include "system/hw_accel.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "target/ppc/cpu.h"
>   #include "target/ppc/mmu-hash64.h"
>   #include "cpu-models.h"
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index e0a9d50edc..384269b831 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -34,7 +34,7 @@
>   #include "hw/pci/pci_host.h"
>   #include "hw/ppc/spapr.h"
>   #include "hw/pci-host/spapr.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include <libfdt.h>
>   #include "trace.h"
>   #include "qemu/error-report.h"
> diff --git a/hw/remote/memory.c b/hw/remote/memory.c
> index 6d60da91e0..00193a552f 100644
> --- a/hw/remote/memory.c
> +++ b/hw/remote/memory.c
> @@ -11,7 +11,7 @@
>   #include "qemu/osdep.h"
>   
>   #include "hw/remote/memory.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qapi/error.h"
>   
>   static void remote_sysmem_reset(void)
> diff --git a/hw/remote/proxy-memory-listener.c b/hw/remote/proxy-memory-listener.c
> index ce7f5b9bfb..30ac74961d 100644
> --- a/hw/remote/proxy-memory-listener.c
> +++ b/hw/remote/proxy-memory-listener.c
> @@ -12,7 +12,7 @@
>   #include "qemu/range.h"
>   #include "system/memory.h"
>   #include "exec/cpu-common.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qapi/error.h"
>   #include "qemu/error-report.h"
>   #include "hw/remote/mpqemu-link.h"
> diff --git a/hw/s390x/s390-stattrib-kvm.c b/hw/s390x/s390-stattrib-kvm.c
> index 2a8e31718b..f5695b0e53 100644
> --- a/hw/s390x/s390-stattrib-kvm.c
> +++ b/hw/s390x/s390-stattrib-kvm.c
> @@ -16,7 +16,7 @@
>   #include "qemu/error-report.h"
>   #include "system/kvm.h"
>   #include "system/memory_mapping.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "kvm/kvm_s390x.h"
>   #include "qapi/error.h"
>   
> diff --git a/hw/s390x/s390-stattrib.c b/hw/s390x/s390-stattrib.c
> index be07c28c6e..d95b58a8a8 100644
> --- a/hw/s390x/s390-stattrib.c
> +++ b/hw/s390x/s390-stattrib.c
> @@ -16,7 +16,7 @@
>   #include "hw/qdev-properties.h"
>   #include "hw/s390x/storage-attributes.h"
>   #include "qemu/error-report.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qapi/error.h"
>   #include "qobject/qdict.h"
>   #include "cpu.h"
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index a9b3db19f6..d284b1c7d2 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -13,7 +13,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qapi/error.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "system/confidential-guest-support.h"
>   #include "hw/boards.h"
>   #include "hw/s390x/sclp.h"
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 5c3bc88222..f2d30cb06e 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -29,7 +29,7 @@
>   #include "hw/vfio/pci.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "hw/hw.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 2e993c7e73..812d5edbcf 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -25,7 +25,7 @@
>   #include "hw/vfio/vfio-common.h"
>   #include "system/address-spaces.h"
>   #include "system/memory.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qemu/error-report.h"
>   #include "qemu/range.h"
>   #include "system/reset.h"
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index df61edffc0..ec323fa32b 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -25,7 +25,7 @@
>   #include "qemu/cutils.h"
>   #include "qemu/chardev_open.h"
>   #include "pci.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   
>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>                               ram_addr_t size, void *vaddr, bool readonly)
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 416643ddd6..273618c7e0 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -27,7 +27,7 @@
>   #include "qapi/error.h"
>   #include "qapi/qapi-events-vfio.h"
>   #include "exec/ramlist.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "pci.h"
>   #include "trace.h"
>   #include "hw/hw.h"
> diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
> index bc00badb34..3c9a4385a2 100644
> --- a/hw/vfio/spapr.c
> +++ b/hw/vfio/spapr.c
> @@ -19,7 +19,7 @@
>   
>   #include "hw/vfio/vfio-common.h"
>   #include "hw/hw.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "trace.h"
> diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
> index 7b140add76..f6c9aca291 100644
> --- a/hw/virtio/virtio-mem.c
> +++ b/hw/virtio/virtio-mem.c
> @@ -24,7 +24,7 @@
>   #include "hw/virtio/virtio-mem.h"
>   #include "qapi/error.h"
>   #include "qapi/visitor.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "migration/misc.h"
>   #include "hw/boards.h"
>   #include "hw/qdev-properties.h"
> diff --git a/migration/ram.c b/migration/ram.c
> index 424df6d9f1..6295f675df 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -48,7 +48,7 @@
>   #include "qapi/qapi-commands-migration.h"
>   #include "qapi/qmp/qerror.h"
>   #include "trace.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "exec/target_page.h"
>   #include "qemu/rcu_queue.h"
>   #include "migration/colo.h"
> diff --git a/system/memory.c b/system/memory.c
> index 050bffdbf8..faddcbfd8a 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -26,7 +26,7 @@
>   #include "trace.h"
>   
>   #include "exec/memory-internal.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "system/kvm.h"
>   #include "system/runstate.h"
>   #include "system/tcg.h"
> diff --git a/system/physmem.c b/system/physmem.c
> index 2850e14780..765d195cb0 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -67,7 +67,7 @@
>   #include "system/replay.h"
>   
>   #include "exec/memory-internal.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   
>   #include "qemu/pmem.h"
>   
> diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
> index 5d6d8a17ae..80164a8050 100644
> --- a/target/arm/tcg/mte_helper.c
> +++ b/target/arm/tcg/mte_helper.c
> @@ -27,7 +27,7 @@
>   #include "user/cpu_loop.h"
>   #include "user/page-protection.h"
>   #else
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #endif
>   #include "exec/cpu_ldst.h"
>   #include "exec/helper-proto.h"
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 216638dee4..4e2663e3f1 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -41,7 +41,7 @@
>   #include "trace.h"
>   #include "gdbstub/enums.h"
>   #include "exec/memattrs.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "system/hostmem.h"
>   #include "qemu/cutils.h"
>   #include "qemu/main-loop.h"
> diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
> index 4d56e653dd..b9f1422197 100644
> --- a/target/s390x/kvm/kvm.c
> +++ b/target/s390x/kvm/kvm.c
> @@ -41,7 +41,7 @@
>   #include "system/runstate.h"
>   #include "system/device_tree.h"
>   #include "gdbstub/enums.h"
> -#include "exec/ram_addr.h"
> +#include "system/ram_addr.h"
>   #include "trace.h"
>   #include "hw/s390x/s390-pci-inst.h"
>   #include "hw/s390x/s390-pci-bus.h"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 751d611613..2cc0b54ec4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3110,7 +3110,7 @@ S: Supported
>   F: include/system/ioport.h
>   F: include/exec/memop.h
>   F: include/system/memory.h
> -F: include/exec/ram_addr.h
> +F: include/system/ram_addr.h
>   F: include/exec/ramblock.h
>   F: include/system/memory_mapping.h
>   F: system/dma-helpers.c

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


