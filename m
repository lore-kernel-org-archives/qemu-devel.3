Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E29FAD3E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 01:51:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFjE1-0002ZM-6v; Wed, 22 Apr 2026 21:51:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjDz-0002Z3-06
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:51:27 -0400
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wFjDx-0005bQ-53
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 21:51:26 -0400
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-8d7e7f48499so685418685a.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 18:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776909083; x=1777513883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mvODFvouzFtekDxFTRCuLNEOo39dtr+XK18QT7+L97s=;
 b=fhg62kn3al5CFr5onRRn0VjeiEzH9QWK4YGeUSs8O9AIeRRp83wSl+cXhBo1y9ieWZ
 GpEjcJ0z54KLyrp5Nu//qqcqkJa+0TNhnfQIMjS2tfRj9j9k0KjndH4N6BIrjeMyJtuz
 qOdPuoKEYc/B1daBPb9wOACFi+jXCKUkJcIaS/iAHrzmbils09hnRF+rTzmc7gW/WMVx
 7gleL8UdXZtuFtkiD23uevaMnZZlb0O7VVBm658wx9ERw0ScoyvOT0DRUwW9nvKcU/tf
 0LzvWXq2Nz/f8bLzauU6UplHzefWyeTjNdYSJUd9n0hmTGD6QG5nAWLehX6nDx9danqY
 h7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776909083; x=1777513883;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mvODFvouzFtekDxFTRCuLNEOo39dtr+XK18QT7+L97s=;
 b=o7z4WPgdC8NaoptN07sRMdLmLkGejvQEU5MWhH+l/mNhPkDRrUdbY5p5Pp2Ra2evpo
 k1K9xjN4is5PyLnIL7ThbBEjp/oiSr9E+h07mDjeX4geDsaRBRIrCljLFbNB04UkGLHw
 UmMWyHYykZdzQov6mz37heznDJ9sA2QS2mGt0SmA+47FgY6yQ9MXLboxyeWahjehH8IJ
 WnR8FipmH4QglL/IZ2uA0u5QM0e9iy6qA+zEsNFqHLSlmZF4c+Gwmkvf8tosz3Njd1ao
 nuV+QF49G9wUp0YyJoRcHtrE4fWx4yrw8i7PVDGHJhJf8W+FLivNIdjEqA/yAXeELtM0
 leZQ==
X-Gm-Message-State: AOJu0YzMu1CGKhzcDvAqmYQt5QHfVgZUbHNnk9uiOsg608hT3DZ1rqTL
 zEtu2xXacC8W2oOtYfZ1P/vaTYeT8BmaMPVDBIcugyCuPxiKyQQxPTNDe41fHfTu8VQDFPe5uK+
 vUs6A9ng=
X-Gm-Gg: AeBDieuUJWRV++294kyDfGyTxKtigvaIXgbaAdT7NzltK6w8nfzLgnvFkTLdyZJVWf5
 VbmnCgO9dgz5Q1x34aYtiAwRsOFiXbzMarO/+Gl06LU2MZ+aH9NxdRdcJUE5L/tc9HttjuV0Gup
 BZ6EwGXVZVk+kOtvFI7gue4XoubxPM8XWheZtY45k4Vc4sCdwgJ+76fxwyZMNQ1dDPb25vMzASI
 ykni2hEOcm+HRmUhJFk64FBLQJrfVvAbMEcP3I26W5Pru3GSYBm0381eglHs2Yy0L1L8BygG5Dl
 bN0MgjYsvt32MowNjmIlbTMZOTVK1aDrsiiKYdMba87nm1oz4w5zIBbyPtiUSqFupDKGhMt+Ltv
 SpybszIa9wJ+5purBUPWzkG6ZLQj7VaKozFx6on+JS6BEiMa036DtKxmSGqssOrp0ozfAm9V8E5
 0NA4mzyVE4njEUeJzTR8VnP5ht49W7vszO0qF+5VUPuqI9e/nVeCtDvBglyTAKRr3Fyq4q74UPj
 SDWXi2vMevTCyoe3R5bBEhVtkGL
X-Received: by 2002:a05:620a:4093:b0:8ca:fe5c:ea6d with SMTP id
 af79cd13be357-8e792a59afamr3535737585a.59.1776909083478; 
 Wed, 22 Apr 2026 18:51:23 -0700 (PDT)
Received: from [10.72.56.227] ([172.59.184.224])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d94d3f99sm1502036985a.40.2026.04.22.18.51.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 18:51:23 -0700 (PDT)
Message-ID: <8e4483bb-852d-41aa-bcff-26a460d24762@linaro.org>
Date: Thu, 23 Apr 2026 11:51:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/14] accel/mshv: add arch-specific accelerator init
 hook
To: qemu-devel@nongnu.org
References: <20260421-mshv_accel_arm64_supp-v3-0-469f544778ba@linux.microsoft.com>
 <20260421-mshv_accel_arm64_supp-v3-6-469f544778ba@linux.microsoft.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260421-mshv_accel_arm64_supp-v3-6-469f544778ba@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::736;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x736.google.com
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

On 4/21/26 15:21, Aastha Rawat wrote:
> From: "Anirudh Rayabharam (Microsoft)" <anirudh@anirudhrb.com>
> 
> Introduce mshv_arch_accel_init() as an arch-specific hook called early
> in mshv_init(), before VM creation. This allows each architecture to
> perform platform-specific initialization at accelerator init time.
> 
> For arm64, the hook queries the hypervisor for the supported IPA bit
> size and validates it against the guest memory map via the machine's
> get_physical_address_range callback, following the same pattern used by
> HVF and WHPX. This also populates the memory map which comes in handy
> later when retreiving the vGIC layout.
> 
> For x86, the hook calls mshv_init_mmio_emu() which was previously called
> directly from the common init path. Also move set_unimplemented_msr_action()
> and mshv_arch_post_init_vm() from mshv-cpu.c to the new mshv-all.c, as
> they are not vCPU-specific.
> 
> Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
> ---
>   accel/mshv/mshv-all.c        |  5 ++-
>   include/system/mshv_int.h    |  1 +
>   target/arm/mshv/mshv-all.c   | 25 ++++++++++----
>   target/i386/mshv/meson.build |  1 +
>   target/i386/mshv/mshv-all.c  | 80 ++++++++++++++++++++++++++++++++++++++++++++
>   target/i386/mshv/mshv-cpu.c  | 40 ----------------------
>   6 files changed, 105 insertions(+), 47 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 44f35a1463..6940ad9989 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -434,7 +434,10 @@ static int mshv_init(AccelState *as, MachineState *ms)
>           return -1;
>       }
>   
> -    mshv_init_mmio_emu();
> +    ret = mshv_arch_accel_init(as, ms, mshv_fd);
> +    if (ret < 0) {
> +        return -1;
> +    }
>   
>       mshv_init_msicontrol();
>   
> diff --git a/include/system/mshv_int.h b/include/system/mshv_int.h
> index ff3ab957b5..c72c91cd23 100644
> --- a/include/system/mshv_int.h
> +++ b/include/system/mshv_int.h
> @@ -96,6 +96,7 @@ void mshv_arch_init_vcpu(CPUState *cpu);
>   void mshv_arch_destroy_vcpu(CPUState *cpu);
>   void mshv_arch_amend_proc_features(
>       union hv_partition_synthetic_processor_features *features);
> +int mshv_arch_accel_init(AccelState *as, MachineState *ms, int mshv_fd);
>   int mshv_arch_post_init_vm(int vm_fd);
>   void mshv_setup_hvcall_args(AccelCPUState *state);
>   
> diff --git a/target/arm/mshv/mshv-all.c b/target/arm/mshv/mshv-all.c
> index db1174b444..8d16971c0d 100644
> --- a/target/arm/mshv/mshv-all.c
> +++ b/target/arm/mshv/mshv-all.c
> @@ -9,12 +9,13 @@
>    * SPDX-License-Identifier: GPL-2.0-or-later
>    */
>   
> -
>   #include "qemu/osdep.h"
>   #include <sys/ioctl.h>
>   
>   #include "qemu/error-report.h"
>   #include "qemu/memalign.h"
> +#include "hw/arm/bsa.h"
> +#include "hw/arm/virt.h"
>   
>   #include "system/cpus.h"
>   #include "target/arm/cpu.h"
> @@ -188,11 +189,6 @@ void mshv_arch_destroy_vcpu(CPUState *cpu)
>       state->hvcall_args = (MshvHvCallArgs){0};
>   }
>   
> -void mshv_init_mmio_emu(void)
> -{
> -
> -}

It would be nice to introduce the mshv_arch_accel_init hook earlier in the series, so that 
you don't have to add and then remove this function.


r~

