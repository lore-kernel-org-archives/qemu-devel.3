Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79621D35164
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7rkM-0005q8-0a; Wed, 01 Apr 2026 05:20:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w7rkF-0005mT-TY
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:20:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w7rkA-0004qx-Lj
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 05:20:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775035208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=t7GqbkW1I03avVG11yTmo4FPlVcI7P7mbRwrNb+BIKo=;
 b=Mqgx4Q9aezg1lypn+OhaSDmIXLsm6m0fhQssgVDA5SSNQrqBUKWuEU3MtFCkm8rb9K1OkQ
 QMj0FjQBCZ4rVSnj0qZW1+TX4nsod8OnZMbhVNSRJTuoSRq7Y+U2E3RhLX7CIVvsNTkygY
 8oWwYJihNWOkHDEmftH0YSSW+X9BLqQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-Yw3iXyfeOUqoChr17qMpfw-1; Wed, 01 Apr 2026 05:20:07 -0400
X-MC-Unique: Yw3iXyfeOUqoChr17qMpfw-1
X-Mimecast-MFC-AGG-ID: Yw3iXyfeOUqoChr17qMpfw_1775035206
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d02fa5860so2596010f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 02:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775035206; x=1775640006; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=t7GqbkW1I03avVG11yTmo4FPlVcI7P7mbRwrNb+BIKo=;
 b=Olqi1MhGLkew56tcjKHqwKNDD9iNlze59nkt2xcLcZ8IFnZE+qsPgufH1Y7kD728DJ
 XW6HnPLQOu9Sx7PGDG8J8jJCX4kfRP6tXt3UFRZLbiTg/1gWYSeN3fiJ8mK4K2YP63Nk
 lWid/Ap9IjYyfZQ7HyHSclQkD4MaKnLFL+w/P9ZQhszVFlybDydsP0Iuu6Um5vxCC2La
 MNSPCNc6QZiiStpQGOUafb5tQO+z+0WeQojQ96tW1J3tdcWVsu8S5idyf1DAa5JwQNrY
 Q7D1EYA93z6N04RqlTTilJV3tdAk+Ch1L/c2tiYaLQK2ZHz6sJ4/3yOObpwtyLPVyX74
 6tWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775035206; x=1775640006;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7GqbkW1I03avVG11yTmo4FPlVcI7P7mbRwrNb+BIKo=;
 b=DjvwduDG+P5St7xt7tn5wd+zwxs6//AGIhkAg6TIofzWcDgIJdAUjnRX8qyrp/qCrS
 lfqcEUOc3JdJ2qzSL9VGo5keUst2Q010s9/bPWsSphuhiAGlJjJwWi1To3hXyDgS2E2j
 K2UhF5Z9tp4wkDP00aibYcfuOyNypyOD2jhjD9G0z7cRyx4SBJpd15zUSi/aRJIGJgJi
 9otf/HcYTLlnhL3sxJirZM6oHR2sBJO39S9f6bxsDuNMo/Vs6ewI1RmRlEGpknQL1wyC
 GxUA86/YJw4uEhwjRJsBheGA3n+/FZyqNZjawPjA8Ivfl/nJx/VPYoMM0Yyk8nf/APgo
 uI/g==
X-Gm-Message-State: AOJu0Ywg0GTgg5HWdDvNMkC4XhyiY20m1291B34/uhKQubXo0paBNpis
 7MSz6g9zt5KFr7/vJkgu6Vt/Yl0dgmAm4z3xDiHZ6H08bBCgpjKpdZuJ8Aa+SPrgYbbLd50uE89
 q1GRnzAGoUDZQWaxibzP8reFtBF1QIq34KehElEWGvzStw6EujV/+7vAA
X-Gm-Gg: ATEYQzx6y3o/IglNf0pbX5DBjFeZ9G8C9MQ2FeQs0/WM09CvurkqXp6LWx/54Z8l4d0
 CHs2YBkpfGQBpO4A1cdUah6tfZPqJADkvScQ9KYgpxIK7JYZFTv+w2GmCdmGDOBtuqZu4oR8mPn
 8knmIPhKLAmNFpUwcvAAXu3lhLM9vlCxh8gHiMH51ROmD6KHK7+VTfHAZBJAJsjHClQkMmXBoBZ
 hcgoDisL72BR73k23HoOoL3+8VyUnhq7LlfdtquLg9La9DLQ+3Gx3+hbbEksIHfkaonLT3TjXud
 W7btJCRiL0fbAXLHxcN197k6Se/AyGDJjLaHb7FVyq8WOY1r2wi98YbHXIXUZM1y7wpzEtNGYZt
 salXjGjzpyMV5qv6MamjP+/Oe+KN/4gtlzjKpz98tPWUeciM=
X-Received: by 2002:a05:600c:4704:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-4888358931fmr43331135e9.13.1775035205743; 
 Wed, 01 Apr 2026 02:20:05 -0700 (PDT)
X-Received: by 2002:a05:600c:4704:b0:486:fcc7:d6a with SMTP id
 5b1f17b1804b1-4888358931fmr43330315e9.13.1775035204994; 
 Wed, 01 Apr 2026 02:20:04 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887a630922sm138642715e9.0.2026.04.01.02.20.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 02:20:04 -0700 (PDT)
Message-ID: <e2051467-b798-46e4-9f8c-c0144b528b5f@redhat.com>
Date: Wed, 1 Apr 2026 11:20:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: convert TABS indentation to spaces for consistency
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>,
 richard.henderson@linaro.org, pbonzini@redhat.com, zhao1.liu@intel.com,
 edgar.iglesias@gmail.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260328170913.3673-1-tanyaagarwal25699@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 28/03/2026 18.09, Tanya Agarwal wrote:
> From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> 
> To follow consistent coding style, convert TABS indentation to spaces
> for consistency.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/372
> 
> Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
> ---
>   target/alpha/cpu.h      |   6 +-
>   target/i386/cpu.h       |  40 ++---
>   target/i386/svm.h       | 308 ++++++++++++++++++-------------------
>   target/microblaze/cpu.h |  12 +-
>   target/sparc/asi.h      | 328 ++++++++++++++++++++--------------------
>   5 files changed, 347 insertions(+), 347 deletions(-)

  Hi!

Formatting looks right, and I checked with "diff -b" that there are no 
unintended changes in here ==> Patch looks good!

Reviewed-by: Thomas Huth <thuth@redhat.com>

Thank you very much for tackling this, Tanya!

  Thomas


> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index 45944e46b5..b530cd0088 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -311,9 +311,9 @@ enum {
>   };
>   
>   /* Alpha-specific interrupt pending bits.  */
> -#define CPU_INTERRUPT_TIMER	CPU_INTERRUPT_TGT_EXT_0
> -#define CPU_INTERRUPT_SMP	CPU_INTERRUPT_TGT_EXT_1
> -#define CPU_INTERRUPT_MCHK	CPU_INTERRUPT_TGT_EXT_2
> +#define CPU_INTERRUPT_TIMER     CPU_INTERRUPT_TGT_EXT_0
> +#define CPU_INTERRUPT_SMP       CPU_INTERRUPT_TGT_EXT_1
> +#define CPU_INTERRUPT_MCHK      CPU_INTERRUPT_TGT_EXT_2
>   
>   /* OSF/1 Page table bits.  */
>   enum {
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0b539155c4..a09d5de121 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -417,12 +417,12 @@ typedef enum X86Seg {
>   #define MSR_IA32_CORE_CAPABILITY        0xcf
>   
>   #define MSR_IA32_ARCH_CAPABILITIES      0x10a
> -#define ARCH_CAP_TSX_CTRL_MSR		(1<<7)
> +#define ARCH_CAP_TSX_CTRL_MSR           (1 << 7)
>   
>   #define MSR_IA32_PERF_CAPABILITIES      0x345
>   #define PERF_CAP_LBR_FMT                0x3f
>   
> -#define MSR_IA32_TSX_CTRL		0x122
> +#define MSR_IA32_TSX_CTRL               0x122
>   #define MSR_IA32_TSCDEADLINE            0x6e0
>   #define MSR_IA32_PKRS                   0x6e1
>   #define MSR_RAPL_POWER_UNIT             0x00000606
> @@ -1482,24 +1482,24 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
>   #define HYPERV_SPINLOCK_NEVER_NOTIFY             0xFFFFFFFF
>   #endif
>   
> -#define EXCP00_DIVZ	0
> -#define EXCP01_DB	1
> -#define EXCP02_NMI	2
> -#define EXCP03_INT3	3
> -#define EXCP04_INTO	4
> -#define EXCP05_BOUND	5
> -#define EXCP06_ILLOP	6
> -#define EXCP07_PREX	7
> -#define EXCP08_DBLE	8
> -#define EXCP09_XERR	9
> -#define EXCP0A_TSS	10
> -#define EXCP0B_NOSEG	11
> -#define EXCP0C_STACK	12
> -#define EXCP0D_GPF	13
> -#define EXCP0E_PAGE	14
> -#define EXCP10_COPR	16
> -#define EXCP11_ALGN	17
> -#define EXCP12_MCHK	18
> +#define EXCP00_DIVZ     0
> +#define EXCP01_DB       1
> +#define EXCP02_NMI      2
> +#define EXCP03_INT3     3
> +#define EXCP04_INTO     4
> +#define EXCP05_BOUND    5
> +#define EXCP06_ILLOP    6
> +#define EXCP07_PREX     7
> +#define EXCP08_DBLE     8
> +#define EXCP09_XERR     9
> +#define EXCP0A_TSS      10
> +#define EXCP0B_NOSEG    11
> +#define EXCP0C_STACK    12
> +#define EXCP0D_GPF      13
> +#define EXCP0E_PAGE     14
> +#define EXCP10_COPR     16
> +#define EXCP11_ALGN     17
> +#define EXCP12_MCHK     18
>   
>   #define EXCP_VMEXIT     0x100 /* only for system emulation */
>   #define EXCP_SYSCALL    0x101 /* only for user emulation */
> diff --git a/target/i386/svm.h b/target/i386/svm.h
> index 1bd7844730..23c36637d4 100644
> --- a/target/i386/svm.h
> +++ b/target/i386/svm.h
> @@ -54,88 +54,88 @@
>   
>   #define SVM_EXITINTINFO_VEC_MASK SVM_EVTINJ_VEC_MASK
>   
> -#define	SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
> -#define	SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
> -#define	SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
> -#define	SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
> +#define SVM_EXITINTINFO_TYPE_INTR SVM_EVTINJ_TYPE_INTR
> +#define SVM_EXITINTINFO_TYPE_NMI SVM_EVTINJ_TYPE_NMI
> +#define SVM_EXITINTINFO_TYPE_EXEPT SVM_EVTINJ_TYPE_EXEPT
> +#define SVM_EXITINTINFO_TYPE_SOFT SVM_EVTINJ_TYPE_SOFT
>   
>   #define SVM_EXITINTINFO_VALID SVM_EVTINJ_VALID
>   #define SVM_EXITINTINFO_VALID_ERR SVM_EVTINJ_VALID_ERR
>   
> -#define	SVM_EXIT_READ_CR0 	0x000
> -#define	SVM_EXIT_READ_CR3 	0x003
> -#define	SVM_EXIT_READ_CR4 	0x004
> -#define	SVM_EXIT_READ_CR8 	0x008
> -#define	SVM_EXIT_WRITE_CR0 	0x010
> -#define	SVM_EXIT_WRITE_CR3 	0x013
> -#define	SVM_EXIT_WRITE_CR4 	0x014
> -#define	SVM_EXIT_WRITE_CR8 	0x018
> -#define	SVM_EXIT_READ_DR0 	0x020
> -#define	SVM_EXIT_READ_DR1 	0x021
> -#define	SVM_EXIT_READ_DR2 	0x022
> -#define	SVM_EXIT_READ_DR3 	0x023
> -#define	SVM_EXIT_READ_DR4 	0x024
> -#define	SVM_EXIT_READ_DR5 	0x025
> -#define	SVM_EXIT_READ_DR6 	0x026
> -#define	SVM_EXIT_READ_DR7 	0x027
> -#define	SVM_EXIT_WRITE_DR0 	0x030
> -#define	SVM_EXIT_WRITE_DR1 	0x031
> -#define	SVM_EXIT_WRITE_DR2 	0x032
> -#define	SVM_EXIT_WRITE_DR3 	0x033
> -#define	SVM_EXIT_WRITE_DR4 	0x034
> -#define	SVM_EXIT_WRITE_DR5 	0x035
> -#define	SVM_EXIT_WRITE_DR6 	0x036
> -#define	SVM_EXIT_WRITE_DR7 	0x037
> +#define SVM_EXIT_READ_CR0       0x000
> +#define SVM_EXIT_READ_CR3       0x003
> +#define SVM_EXIT_READ_CR4       0x004
> +#define SVM_EXIT_READ_CR8       0x008
> +#define SVM_EXIT_WRITE_CR0      0x010
> +#define SVM_EXIT_WRITE_CR3      0x013
> +#define SVM_EXIT_WRITE_CR4      0x014
> +#define SVM_EXIT_WRITE_CR8      0x018
> +#define SVM_EXIT_READ_DR0       0x020
> +#define SVM_EXIT_READ_DR1       0x021
> +#define SVM_EXIT_READ_DR2       0x022
> +#define SVM_EXIT_READ_DR3       0x023
> +#define SVM_EXIT_READ_DR4       0x024
> +#define SVM_EXIT_READ_DR5       0x025
> +#define SVM_EXIT_READ_DR6       0x026
> +#define SVM_EXIT_READ_DR7       0x027
> +#define SVM_EXIT_WRITE_DR0      0x030
> +#define SVM_EXIT_WRITE_DR1      0x031
> +#define SVM_EXIT_WRITE_DR2      0x032
> +#define SVM_EXIT_WRITE_DR3      0x033
> +#define SVM_EXIT_WRITE_DR4      0x034
> +#define SVM_EXIT_WRITE_DR5      0x035
> +#define SVM_EXIT_WRITE_DR6      0x036
> +#define SVM_EXIT_WRITE_DR7      0x037
>   #define SVM_EXIT_EXCP_BASE      0x040
> -#define SVM_EXIT_INTR		0x060
> -#define SVM_EXIT_NMI		0x061
> -#define SVM_EXIT_SMI		0x062
> -#define SVM_EXIT_INIT		0x063
> -#define SVM_EXIT_VINTR		0x064
> -#define SVM_EXIT_CR0_SEL_WRITE	0x065
> -#define SVM_EXIT_IDTR_READ	0x066
> -#define SVM_EXIT_GDTR_READ	0x067
> -#define SVM_EXIT_LDTR_READ	0x068
> -#define SVM_EXIT_TR_READ	0x069
> -#define SVM_EXIT_IDTR_WRITE	0x06a
> -#define SVM_EXIT_GDTR_WRITE	0x06b
> -#define SVM_EXIT_LDTR_WRITE	0x06c
> -#define SVM_EXIT_TR_WRITE	0x06d
> -#define SVM_EXIT_RDTSC		0x06e
> -#define SVM_EXIT_RDPMC		0x06f
> -#define SVM_EXIT_PUSHF		0x070
> -#define SVM_EXIT_POPF		0x071
> -#define SVM_EXIT_CPUID		0x072
> -#define SVM_EXIT_RSM		0x073
> -#define SVM_EXIT_IRET		0x074
> -#define SVM_EXIT_SWINT		0x075
> -#define SVM_EXIT_INVD		0x076
> -#define SVM_EXIT_PAUSE		0x077
> -#define SVM_EXIT_HLT		0x078
> -#define SVM_EXIT_INVLPG		0x079
> -#define SVM_EXIT_INVLPGA	0x07a
> -#define SVM_EXIT_IOIO		0x07b
> -#define SVM_EXIT_MSR		0x07c
> -#define SVM_EXIT_TASK_SWITCH	0x07d
> -#define SVM_EXIT_FERR_FREEZE	0x07e
> -#define SVM_EXIT_SHUTDOWN	0x07f
> -#define SVM_EXIT_VMRUN		0x080
> -#define SVM_EXIT_VMMCALL	0x081
> -#define SVM_EXIT_VMLOAD		0x082
> -#define SVM_EXIT_VMSAVE		0x083
> -#define SVM_EXIT_STGI		0x084
> -#define SVM_EXIT_CLGI		0x085
> -#define SVM_EXIT_SKINIT		0x086
> -#define SVM_EXIT_RDTSCP		0x087
> -#define SVM_EXIT_ICEBP		0x088
> -#define SVM_EXIT_WBINVD		0x089
> +#define SVM_EXIT_INTR           0x060
> +#define SVM_EXIT_NMI            0x061
> +#define SVM_EXIT_SMI            0x062
> +#define SVM_EXIT_INIT           0x063
> +#define SVM_EXIT_VINTR          0x064
> +#define SVM_EXIT_CR0_SEL_WRITE  0x065
> +#define SVM_EXIT_IDTR_READ      0x066
> +#define SVM_EXIT_GDTR_READ      0x067
> +#define SVM_EXIT_LDTR_READ      0x068
> +#define SVM_EXIT_TR_READ        0x069
> +#define SVM_EXIT_IDTR_WRITE     0x06a
> +#define SVM_EXIT_GDTR_WRITE     0x06b
> +#define SVM_EXIT_LDTR_WRITE     0x06c
> +#define SVM_EXIT_TR_WRITE       0x06d
> +#define SVM_EXIT_RDTSC          0x06e
> +#define SVM_EXIT_RDPMC          0x06f
> +#define SVM_EXIT_PUSHF          0x070
> +#define SVM_EXIT_POPF           0x071
> +#define SVM_EXIT_CPUID          0x072
> +#define SVM_EXIT_RSM            0x073
> +#define SVM_EXIT_IRET           0x074
> +#define SVM_EXIT_SWINT          0x075
> +#define SVM_EXIT_INVD           0x076
> +#define SVM_EXIT_PAUSE          0x077
> +#define SVM_EXIT_HLT            0x078
> +#define SVM_EXIT_INVLPG         0x079
> +#define SVM_EXIT_INVLPGA        0x07a
> +#define SVM_EXIT_IOIO           0x07b
> +#define SVM_EXIT_MSR            0x07c
> +#define SVM_EXIT_TASK_SWITCH    0x07d
> +#define SVM_EXIT_FERR_FREEZE    0x07e
> +#define SVM_EXIT_SHUTDOWN       0x07f
> +#define SVM_EXIT_VMRUN          0x080
> +#define SVM_EXIT_VMMCALL        0x081
> +#define SVM_EXIT_VMLOAD         0x082
> +#define SVM_EXIT_VMSAVE         0x083
> +#define SVM_EXIT_STGI           0x084
> +#define SVM_EXIT_CLGI           0x085
> +#define SVM_EXIT_SKINIT         0x086
> +#define SVM_EXIT_RDTSCP         0x087
> +#define SVM_EXIT_ICEBP          0x088
> +#define SVM_EXIT_WBINVD         0x089
>   /* only included in documentation, maybe wrong */
> -#define SVM_EXIT_MONITOR	0x08a
> -#define SVM_EXIT_MWAIT		0x08b
> -#define SVM_EXIT_XSETBV		0x08d
> -#define SVM_EXIT_NPF  		0x400
> +#define SVM_EXIT_MONITOR        0x08a
> +#define SVM_EXIT_MWAIT          0x08b
> +#define SVM_EXIT_XSETBV         0x08d
> +#define SVM_EXIT_NPF            0x400
>   
> -#define SVM_EXIT_ERR		-1
> +#define SVM_EXIT_ERR            -1
>   
>   #define SVM_CR0_SELECTIVE_MASK (1 << 3 | 1) /* TS and MP */
>   
> @@ -146,96 +146,96 @@
>   
>   #define SVM_CR0_RESERVED_MASK 0xffffffff00000000U
>   
> -#define SVM_MSRPM_SIZE		(1ULL << 13)
> -#define SVM_IOPM_SIZE		((1ULL << 13) + 1)
> +#define SVM_MSRPM_SIZE          (1ULL << 13)
> +#define SVM_IOPM_SIZE           ((1ULL << 13) + 1)
>   
>   struct QEMU_PACKED vmcb_control_area {
> -	uint16_t intercept_cr_read;
> -	uint16_t intercept_cr_write;
> -	uint16_t intercept_dr_read;
> -	uint16_t intercept_dr_write;
> -	uint32_t intercept_exceptions;
> -	uint64_t intercept;
> -	uint8_t reserved_1[44];
> -	uint64_t iopm_base_pa;
> -	uint64_t msrpm_base_pa;
> -	uint64_t tsc_offset;
> -	uint32_t asid;
> -	uint8_t tlb_ctl;
> -	uint8_t reserved_2[3];
> -	uint32_t int_ctl;
> -	uint32_t int_vector;
> -	uint32_t int_state;
> -	uint8_t reserved_3[4];
> -	uint64_t exit_code;
> -	uint64_t exit_info_1;
> -	uint64_t exit_info_2;
> -	uint32_t exit_int_info;
> -	uint32_t exit_int_info_err;
> -	uint64_t nested_ctl;
> -	uint8_t reserved_4[16];
> -	uint32_t event_inj;
> -	uint32_t event_inj_err;
> -	uint64_t nested_cr3;
> -	uint64_t lbr_ctl;
> -	uint8_t reserved_5[832];
> +    uint16_t intercept_cr_read;
> +    uint16_t intercept_cr_write;
> +    uint16_t intercept_dr_read;
> +    uint16_t intercept_dr_write;
> +    uint32_t intercept_exceptions;
> +    uint64_t intercept;
> +    uint8_t reserved_1[44];
> +    uint64_t iopm_base_pa;
> +    uint64_t msrpm_base_pa;
> +    uint64_t tsc_offset;
> +    uint32_t asid;
> +    uint8_t tlb_ctl;
> +    uint8_t reserved_2[3];
> +    uint32_t int_ctl;
> +    uint32_t int_vector;
> +    uint32_t int_state;
> +    uint8_t reserved_3[4];
> +    uint64_t exit_code;
> +    uint64_t exit_info_1;
> +    uint64_t exit_info_2;
> +    uint32_t exit_int_info;
> +    uint32_t exit_int_info_err;
> +    uint64_t nested_ctl;
> +    uint8_t reserved_4[16];
> +    uint32_t event_inj;
> +    uint32_t event_inj_err;
> +    uint64_t nested_cr3;
> +    uint64_t lbr_ctl;
> +    uint8_t reserved_5[832];
>   };
>   
>   struct QEMU_PACKED vmcb_seg {
> -	uint16_t selector;
> -	uint16_t attrib;
> -	uint32_t limit;
> -	uint64_t base;
> +    uint16_t selector;
> +    uint16_t attrib;
> +    uint32_t limit;
> +    uint64_t base;
>   };
>   
>   struct QEMU_PACKED vmcb_save_area {
> -	struct vmcb_seg es;
> -	struct vmcb_seg cs;
> -	struct vmcb_seg ss;
> -	struct vmcb_seg ds;
> -	struct vmcb_seg fs;
> -	struct vmcb_seg gs;
> -	struct vmcb_seg gdtr;
> -	struct vmcb_seg ldtr;
> -	struct vmcb_seg idtr;
> -	struct vmcb_seg tr;
> -	uint8_t reserved_1[43];
> -	uint8_t cpl;
> -	uint8_t reserved_2[4];
> -	uint64_t efer;
> -	uint8_t reserved_3[112];
> -	uint64_t cr4;
> -	uint64_t cr3;
> -	uint64_t cr0;
> -	uint64_t dr7;
> -	uint64_t dr6;
> -	uint64_t rflags;
> -	uint64_t rip;
> -	uint8_t reserved_4[88];
> -	uint64_t rsp;
> -	uint8_t reserved_5[24];
> -	uint64_t rax;
> -	uint64_t star;
> -	uint64_t lstar;
> -	uint64_t cstar;
> -	uint64_t sfmask;
> -	uint64_t kernel_gs_base;
> -	uint64_t sysenter_cs;
> -	uint64_t sysenter_esp;
> -	uint64_t sysenter_eip;
> -	uint64_t cr2;
> -	uint8_t reserved_6[32];
> -	uint64_t g_pat;
> -	uint64_t dbgctl;
> -	uint64_t br_from;
> -	uint64_t br_to;
> -	uint64_t last_excp_from;
> -	uint64_t last_excp_to;
> +    struct vmcb_seg es;
> +    struct vmcb_seg cs;
> +    struct vmcb_seg ss;
> +    struct vmcb_seg ds;
> +    struct vmcb_seg fs;
> +    struct vmcb_seg gs;
> +    struct vmcb_seg gdtr;
> +    struct vmcb_seg ldtr;
> +    struct vmcb_seg idtr;
> +    struct vmcb_seg tr;
> +    uint8_t reserved_1[43];
> +    uint8_t cpl;
> +    uint8_t reserved_2[4];
> +    uint64_t efer;
> +    uint8_t reserved_3[112];
> +    uint64_t cr4;
> +    uint64_t cr3;
> +    uint64_t cr0;
> +    uint64_t dr7;
> +    uint64_t dr6;
> +    uint64_t rflags;
> +    uint64_t rip;
> +    uint8_t reserved_4[88];
> +    uint64_t rsp;
> +    uint8_t reserved_5[24];
> +    uint64_t rax;
> +    uint64_t star;
> +    uint64_t lstar;
> +    uint64_t cstar;
> +    uint64_t sfmask;
> +    uint64_t kernel_gs_base;
> +    uint64_t sysenter_cs;
> +    uint64_t sysenter_esp;
> +    uint64_t sysenter_eip;
> +    uint64_t cr2;
> +    uint8_t reserved_6[32];
> +    uint64_t g_pat;
> +    uint64_t dbgctl;
> +    uint64_t br_from;
> +    uint64_t br_to;
> +    uint64_t last_excp_from;
> +    uint64_t last_excp_to;
>   };
>   
>   struct QEMU_PACKED vmcb {
> -	struct vmcb_control_area control;
> -	struct vmcb_save_area save;
> +    struct vmcb_control_area control;
> +    struct vmcb_save_area save;
>   };
>   
>   #endif
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index d26b933b6d..5a856edaaa 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -122,9 +122,9 @@ typedef struct CPUArchState CPUMBState;
>   #define PVR0_USE_ICACHE_MASK            0x02000000
>   #define PVR0_USE_DCACHE_MASK            0x01000000
>   #define PVR0_USE_MMU_MASK               0x00800000
> -#define PVR0_USE_BTC			0x00400000
> +#define PVR0_USE_BTC                    0x00400000
>   #define PVR0_ENDI_MASK                  0x00200000
> -#define PVR0_FAULT			0x00100000
> +#define PVR0_FAULT                      0x00100000
>   #define PVR0_VERSION_MASK               0x0000FF00
>   #define PVR0_USER1_MASK                 0x000000FF
>   #define PVR0_SPROT_MASK                 0x00000001
> @@ -271,10 +271,10 @@ struct CPUArchState {
>   /* MSR_UM               (1 << 11) */
>   /* MSR_VM               (1 << 13) */
>   /* ESR_ESS_MASK         [11:5]    -- unwind into iflags for unaligned excp */
> -#define D_FLAG		(1 << 12)  /* Bit in ESR.  */
> -#define DRTI_FLAG	(1 << 16)
> -#define DRTE_FLAG	(1 << 17)
> -#define DRTB_FLAG	(1 << 18)
> +#define D_FLAG          (1 << 12)  /* Bit in ESR.  */
> +#define DRTI_FLAG       (1 << 16)
> +#define DRTE_FLAG       (1 << 17)
> +#define DRTB_FLAG       (1 << 18)
>   
>   /* TB dependent CPUMBState.  */
>   #define IFLAGS_TB_MASK  (D_FLAG | BIMM_FLAG | IMM_FLAG | \
> diff --git a/target/sparc/asi.h b/target/sparc/asi.h
> index 14ffaa3842..7d6dae6d61 100644
> --- a/target/sparc/asi.h
> +++ b/target/sparc/asi.h
> @@ -102,7 +102,7 @@
>   
>   #define ASI_M_DCDR         0x39   /* Data Cache Diagnostics Register rw, ss */
>   
> -#define ASI_M_VIKING_TMP1  0x40	  /* Emulation temporary 1 on Viking */
> +#define ASI_M_VIKING_TMP1  0x40   /* Emulation temporary 1 on Viking */
>   /* only available on SuperSparc I */
>   /* #define ASI_M_VIKING_TMP2  0x41 */  /* Emulation temporary 2 on Viking */
>   
> @@ -123,20 +123,20 @@
>   #define ASI_LEON_FLUSH_PAGE     0x10
>   
>   /* V9 Architecture mandary ASIs. */
> -#define ASI_N			0x04 /* Nucleus				*/
> -#define ASI_NL			0x0c /* Nucleus, little endian		*/
> -#define ASI_AIUP		0x10 /* Primary, user			*/
> -#define ASI_AIUS		0x11 /* Secondary, user			*/
> -#define ASI_AIUPL		0x18 /* Primary, user, little endian	*/
> -#define ASI_AIUSL		0x19 /* Secondary, user, little endian	*/
> -#define ASI_P			0x80 /* Primary, implicit		*/
> -#define ASI_S			0x81 /* Secondary, implicit		*/
> -#define ASI_PNF			0x82 /* Primary, no fault		*/
> -#define ASI_SNF			0x83 /* Secondary, no fault		*/
> -#define ASI_PL			0x88 /* Primary, implicit, l-endian	*/
> -#define ASI_SL			0x89 /* Secondary, implicit, l-endian	*/
> -#define ASI_PNFL		0x8a /* Primary, no fault, l-endian	*/
> -#define ASI_SNFL		0x8b /* Secondary, no fault, l-endian	*/
> +#define ASI_N                   0x04 /* Nucleus                         */
> +#define ASI_NL                  0x0c /* Nucleus, little endian          */
> +#define ASI_AIUP                0x10 /* Primary, user                   */
> +#define ASI_AIUS                0x11 /* Secondary, user                 */
> +#define ASI_AIUPL               0x18 /* Primary, user, little endian    */
> +#define ASI_AIUSL               0x19 /* Secondary, user, little endian  */
> +#define ASI_P                   0x80 /* Primary, implicit               */
> +#define ASI_S                   0x81 /* Secondary, implicit             */
> +#define ASI_PNF                 0x82 /* Primary, no fault               */
> +#define ASI_SNF                 0x83 /* Secondary, no fault             */
> +#define ASI_PL                  0x88 /* Primary, implicit, l-endian     */
> +#define ASI_SL                  0x89 /* Secondary, implicit, l-endian   */
> +#define ASI_PNFL                0x8a /* Primary, no fault, l-endian     */
> +#define ASI_SNFL                0x8b /* Secondary, no fault, l-endian   */
>   
>   /* SpitFire and later extended ASIs.  The "(III)" marker designates
>    * UltraSparc-III and later specific ASIs.  The "(CMT)" marker designates
> @@ -147,170 +147,170 @@
>   #define ASI_MON_AIUP            0x12 /* (VIS4) Primary, user, monitor   */
>   #define ASI_MON_AIUS            0x13 /* (VIS4) Secondary, user, monitor */
>   #define ASI_REAL                0x14 /* Real address, cacheable          */
> -#define ASI_PHYS_USE_EC		0x14 /* PADDR, E-cacheable		*/
> +#define ASI_PHYS_USE_EC         0x14 /* PADDR, E-cacheable              */
>   #define ASI_REAL_IO             0x15 /* Real address, non-cacheable      */
> -#define ASI_PHYS_BYPASS_EC_E	0x15 /* PADDR, E-bit			*/
> -#define ASI_BLK_AIUP_4V		0x16 /* (4V) Prim, user, block ld/st	*/
> -#define ASI_BLK_AIUS_4V		0x17 /* (4V) Sec, user, block ld/st	*/
> +#define ASI_PHYS_BYPASS_EC_E    0x15 /* PADDR, E-bit                    */
> +#define ASI_BLK_AIUP_4V         0x16 /* (4V) Prim, user, block ld/st    */
> +#define ASI_BLK_AIUS_4V         0x17 /* (4V) Sec, user, block ld/st     */
>   #define ASI_REAL_L              0x1c /* Real address, cacheable, LE      */
> -#define ASI_PHYS_USE_EC_L	0x1c /* PADDR, E-cacheable, little endian*/
> +#define ASI_PHYS_USE_EC_L       0x1c /* PADDR, E-cacheable, little endian*/
>   #define ASI_REAL_IO_L           0x1d /* Real address, non-cacheable, LE  */
> -#define ASI_PHYS_BYPASS_EC_E_L	0x1d /* PADDR, E-bit, little endian	*/
> -#define ASI_BLK_AIUP_L_4V	0x1e /* (4V) Prim, user, block, l-endian*/
> -#define ASI_BLK_AIUS_L_4V	0x1f /* (4V) Sec, user, block, l-endian	*/
> -#define ASI_SCRATCHPAD		0x20 /* (4V) Scratch Pad Registers	*/
> -#define ASI_MMU			0x21 /* (4V) MMU Context Registers	*/
> +#define ASI_PHYS_BYPASS_EC_E_L  0x1d /* PADDR, E-bit, little endian     */
> +#define ASI_BLK_AIUP_L_4V       0x1e /* (4V) Prim, user, block, l-endian*/
> +#define ASI_BLK_AIUS_L_4V       0x1f /* (4V) Sec, user, block, l-endian */
> +#define ASI_SCRATCHPAD          0x20 /* (4V) Scratch Pad Registers      */
> +#define ASI_MMU                 0x21 /* (4V) MMU Context Registers      */
>   #define ASI_TWINX_AIUP          0x22 /* twin load, primary user         */
>   #define ASI_TWINX_AIUS          0x23 /* twin load, secondary user       */
>   #define ASI_BLK_INIT_QUAD_LDD_AIUS 0x23 /* (NG) init-store, twin load,
> -					 * secondary, user
> -					 */
> -#define ASI_NUCLEUS_QUAD_LDD	0x24 /* Cacheable, qword load		*/
> -#define ASI_QUEUE		0x25 /* (4V) Interrupt Queue Registers	*/
> -#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable	*/
> -#define ASI_QUAD_LDD_PHYS_4V	0x26 /* (4V) Physical, qword load	*/
> +                     * secondary, user
> +                     */
> +#define ASI_NUCLEUS_QUAD_LDD    0x24 /* Cacheable, qword load           */
> +#define ASI_QUEUE               0x25 /* (4V) Interrupt Queue Registers  */
> +#define ASI_TWINX_REAL          0x26 /* twin load, real, cacheable      */
> +#define ASI_QUAD_LDD_PHYS_4V    0x26 /* (4V) Physical, qword load       */
>   #define ASI_TWINX_N             0x27 /* twin load, nucleus              */
>   #define ASI_TWINX_AIUP_L        0x2a /* twin load, primary user, LE     */
>   #define ASI_TWINX_AIUS_L        0x2b /* twin load, secondary user, LE   */
> -#define ASI_NUCLEUS_QUAD_LDD_L	0x2c /* Cacheable, qword load, l-endian */
> -#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE	*/
> -#define ASI_QUAD_LDD_PHYS_L_4V	0x2e /* (4V) Phys, qword load, l-endian	*/
> +#define ASI_NUCLEUS_QUAD_LDD_L  0x2c /* Cacheable, qword load, l-endian */
> +#define ASI_TWINX_REAL_L        0x2e /* twin load, real, cacheable, LE  */
> +#define ASI_QUAD_LDD_PHYS_L_4V  0x2e /* (4V) Phys, qword load, l-endian */
>   #define ASI_TWINX_NL            0x2f /* twin load, nucleus, LE          */
> -#define ASI_PCACHE_DATA_STATUS	0x30 /* (III) PCache data stat RAM diag	*/
> -#define ASI_PCACHE_DATA		0x31 /* (III) PCache data RAM diag	*/
> -#define ASI_PCACHE_TAG		0x32 /* (III) PCache tag RAM diag	*/
> -#define ASI_PCACHE_SNOOP_TAG	0x33 /* (III) PCache snoop tag RAM diag	*/
> -#define ASI_QUAD_LDD_PHYS	0x34 /* (III+) PADDR, qword load	*/
> -#define ASI_WCACHE_VALID_BITS	0x38 /* (III) WCache Valid Bits diag	*/
> -#define ASI_WCACHE_DATA		0x39 /* (III) WCache data RAM diag	*/
> -#define ASI_WCACHE_TAG		0x3a /* (III) WCache tag RAM diag	*/
> -#define ASI_WCACHE_SNOOP_TAG	0x3b /* (III) WCache snoop tag RAM diag	*/
> -#define ASI_QUAD_LDD_PHYS_L	0x3c /* (III+) PADDR, qw-load, l-endian	*/
> -#define ASI_SRAM_FAST_INIT	0x40 /* (III+) Fast SRAM init		*/
> -#define ASI_CORE_AVAILABLE	0x41 /* (CMT) LP Available		*/
> -#define ASI_CORE_ENABLE_STAT	0x41 /* (CMT) LP Enable Status		*/
> -#define ASI_CORE_ENABLE		0x41 /* (CMT) LP Enable RW		*/
> -#define ASI_XIR_STEERING	0x41 /* (CMT) XIR Steering RW		*/
> -#define ASI_CORE_RUNNING_RW	0x41 /* (CMT) LP Running RW		*/
> -#define ASI_CORE_RUNNING_W1S	0x41 /* (CMT) LP Running Write-One Set	*/
> -#define ASI_CORE_RUNNING_W1C	0x41 /* (CMT) LP Running Write-One Clr	*/
> -#define ASI_CORE_RUNNING_STAT	0x41 /* (CMT) LP Running Status		*/
> -#define ASI_CMT_ERROR_STEERING	0x41 /* (CMT) Error Steering RW		*/
> -#define ASI_DCACHE_INVALIDATE	0x42 /* (III) DCache Invalidate diag	*/
> -#define ASI_DCACHE_UTAG		0x43 /* (III) DCache uTag diag		*/
> -#define ASI_DCACHE_SNOOP_TAG	0x44 /* (III) DCache snoop tag RAM diag	*/
> -#define ASI_LSU_CONTROL		0x45 /* Load-store control unit		*/
> -#define ASI_DCU_CONTROL_REG	0x45 /* (III) DCache Unit Control reg	*/
> -#define ASI_DCACHE_DATA		0x46 /* DCache data-ram diag access	*/
> -#define ASI_DCACHE_TAG		0x47 /* Dcache tag/valid ram diag access*/
> -#define ASI_INTR_DISPATCH_STAT	0x48 /* IRQ vector dispatch status	*/
> -#define ASI_INTR_RECEIVE	0x49 /* IRQ vector receive status	*/
> -#define ASI_UPA_CONFIG		0x4a /* UPA config space		*/
> -#define ASI_JBUS_CONFIG		0x4a /* (IIIi) JBUS Config Register	*/
> -#define ASI_SAFARI_CONFIG	0x4a /* (III) Safari Config Register	*/
> -#define ASI_SAFARI_ADDRESS	0x4a /* (III) Safari Address Register	*/
> -#define ASI_ESTATE_ERROR_EN	0x4b /* E-cache error enable space	*/
> -#define ASI_AFSR		0x4c /* Async fault status register	*/
> -#define ASI_AFAR		0x4d /* Async fault address register	*/
> -#define ASI_EC_TAG_DATA		0x4e /* E-cache tag/valid ram diag acc	*/
> -#define ASI_HYP_SCRATCHPAD	0x4f /* (4V) Hypervisor scratchpad	*/
> -#define ASI_IMMU		0x50 /* Insn-MMU main register space	*/
> -#define ASI_IMMU_TSB_8KB_PTR	0x51 /* Insn-MMU 8KB TSB pointer reg	*/
> -#define ASI_IMMU_TSB_64KB_PTR	0x52 /* Insn-MMU 64KB TSB pointer reg	*/
> -#define ASI_ITLB_DATA_IN	0x54 /* Insn-MMU TLB data in reg	*/
> -#define ASI_ITLB_DATA_ACCESS	0x55 /* Insn-MMU TLB data access reg	*/
> -#define ASI_ITLB_TAG_READ	0x56 /* Insn-MMU TLB tag read reg	*/
> -#define ASI_IMMU_DEMAP		0x57 /* Insn-MMU TLB demap		*/
> -#define ASI_DMMU		0x58 /* Data-MMU main register space	*/
> -#define ASI_DMMU_TSB_8KB_PTR	0x59 /* Data-MMU 8KB TSB pointer reg	*/
> -#define ASI_DMMU_TSB_64KB_PTR	0x5a /* Data-MMU 16KB TSB pointer reg	*/
> -#define ASI_DMMU_TSB_DIRECT_PTR	0x5b /* Data-MMU TSB direct pointer reg	*/
> -#define ASI_DTLB_DATA_IN	0x5c /* Data-MMU TLB data in reg	*/
> -#define ASI_DTLB_DATA_ACCESS	0x5d /* Data-MMU TLB data access reg	*/
> -#define ASI_DTLB_TAG_READ	0x5e /* Data-MMU TLB tag read reg	*/
> -#define ASI_DMMU_DEMAP		0x5f /* Data-MMU TLB demap		*/
> -#define ASI_IIU_INST_TRAP	0x60 /* (III) Instruction Breakpoint	*/
> -#define ASI_INTR_ID		0x63 /* (CMT) Interrupt ID register	*/
> -#define ASI_CORE_ID		0x63 /* (CMT) LP ID register		*/
> -#define ASI_CESR_ID		0x63 /* (CMT) CESR ID register		*/
> -#define ASI_IC_INSTR		0x66 /* Insn cache instruction ram diag	*/
> -#define ASI_IC_TAG		0x67 /* Insn cache tag/valid ram diag 	*/
> -#define ASI_IC_STAG		0x68 /* (III) Insn cache snoop tag ram	*/
> -#define ASI_IC_PRE_DECODE	0x6e /* Insn cache pre-decode ram diag	*/
> -#define ASI_IC_NEXT_FIELD	0x6f /* Insn cache next-field ram diag	*/
> -#define ASI_BRPRED_ARRAY	0x6f /* (III) Branch Prediction RAM diag*/
> -#define ASI_BLK_AIUP		0x70 /* Primary, user, block load/store	*/
> -#define ASI_BLK_AIUS		0x71 /* Secondary, user, block ld/st	*/
> -#define ASI_MCU_CTRL_REG	0x72 /* (III) Memory controller regs	*/
> -#define ASI_EC_DATA		0x74 /* (III) E-cache data staging reg	*/
> -#define ASI_EC_CTRL		0x75 /* (III) E-cache control reg	*/
> -#define ASI_EC_W		0x76 /* E-cache diag write access	*/
> -#define ASI_UDB_ERROR_W		0x77 /* External UDB error regs W	*/
> -#define ASI_UDB_CONTROL_W	0x77 /* External UDB control regs W	*/
> -#define ASI_INTR_W		0x77 /* IRQ vector dispatch write	*/
> -#define ASI_INTR_DATAN_W	0x77 /* (III) Out irq vector data reg N	*/
> -#define ASI_INTR_DISPATCH_W	0x77 /* (III) Interrupt vector dispatch	*/
> -#define ASI_BLK_AIUPL		0x78 /* Primary, user, little, blk ld/st*/
> -#define ASI_BLK_AIUSL		0x79 /* Secondary, user, little, blk ld/st*/
> -#define ASI_EC_R		0x7e /* E-cache diag read access	*/
> -#define ASI_UDBH_ERROR_R	0x7f /* External UDB error regs rd hi	*/
> -#define ASI_UDBL_ERROR_R	0x7f /* External UDB error regs rd low	*/
> -#define ASI_UDBH_CONTROL_R	0x7f /* External UDB control regs rd hi	*/
> -#define ASI_UDBL_CONTROL_R	0x7f /* External UDB control regs rd low*/
> -#define ASI_INTR_R		0x7f /* IRQ vector dispatch read	*/
> -#define ASI_INTR_DATAN_R	0x7f /* (III) In irq vector data reg N	*/
> +#define ASI_PCACHE_DATA_STATUS  0x30 /* (III) PCache data stat RAM diag */
> +#define ASI_PCACHE_DATA         0x31 /* (III) PCache data RAM diag      */
> +#define ASI_PCACHE_TAG          0x32 /* (III) PCache tag RAM diag       */
> +#define ASI_PCACHE_SNOOP_TAG    0x33 /* (III) PCache snoop tag RAM diag */
> +#define ASI_QUAD_LDD_PHYS       0x34 /* (III+) PADDR, qword load        */
> +#define ASI_WCACHE_VALID_BITS   0x38 /* (III) WCache Valid Bits diag    */
> +#define ASI_WCACHE_DATA         0x39 /* (III) WCache data RAM diag      */
> +#define ASI_WCACHE_TAG          0x3a /* (III) WCache tag RAM diag       */
> +#define ASI_WCACHE_SNOOP_TAG    0x3b /* (III) WCache snoop tag RAM diag */
> +#define ASI_QUAD_LDD_PHYS_L     0x3c /* (III+) PADDR, qw-load, l-endian */
> +#define ASI_SRAM_FAST_INIT      0x40 /* (III+) Fast SRAM init           */
> +#define ASI_CORE_AVAILABLE      0x41 /* (CMT) LP Available              */
> +#define ASI_CORE_ENABLE_STAT    0x41 /* (CMT) LP Enable Status          */
> +#define ASI_CORE_ENABLE         0x41 /* (CMT) LP Enable RW              */
> +#define ASI_XIR_STEERING        0x41 /* (CMT) XIR Steering RW           */
> +#define ASI_CORE_RUNNING_RW     0x41 /* (CMT) LP Running RW             */
> +#define ASI_CORE_RUNNING_W1S    0x41 /* (CMT) LP Running Write-One Set  */
> +#define ASI_CORE_RUNNING_W1C    0x41 /* (CMT) LP Running Write-One Clr  */
> +#define ASI_CORE_RUNNING_STAT   0x41 /* (CMT) LP Running Status         */
> +#define ASI_CMT_ERROR_STEERING  0x41 /* (CMT) Error Steering RW         */
> +#define ASI_DCACHE_INVALIDATE   0x42 /* (III) DCache Invalidate diag    */
> +#define ASI_DCACHE_UTAG         0x43 /* (III) DCache uTag diag          */
> +#define ASI_DCACHE_SNOOP_TAG    0x44 /* (III) DCache snoop tag RAM diag */
> +#define ASI_LSU_CONTROL         0x45 /* Load-store control unit         */
> +#define ASI_DCU_CONTROL_REG     0x45 /* (III) DCache Unit Control reg   */
> +#define ASI_DCACHE_DATA         0x46 /* DCache data-ram diag access     */
> +#define ASI_DCACHE_TAG          0x47 /* Dcache tag/valid ram diag access*/
> +#define ASI_INTR_DISPATCH_STAT  0x48 /* IRQ vector dispatch status      */
> +#define ASI_INTR_RECEIVE        0x49 /* IRQ vector receive status       */
> +#define ASI_UPA_CONFIG          0x4a /* UPA config space                */
> +#define ASI_JBUS_CONFIG         0x4a /* (IIIi) JBUS Config Register     */
> +#define ASI_SAFARI_CONFIG       0x4a /* (III) Safari Config Register    */
> +#define ASI_SAFARI_ADDRESS      0x4a /* (III) Safari Address Register   */
> +#define ASI_ESTATE_ERROR_EN     0x4b /* E-cache error enable space      */
> +#define ASI_AFSR                0x4c /* Async fault status register     */
> +#define ASI_AFAR                0x4d /* Async fault address register    */
> +#define ASI_EC_TAG_DATA         0x4e /* E-cache tag/valid ram diag acc  */
> +#define ASI_HYP_SCRATCHPAD      0x4f /* (4V) Hypervisor scratchpad      */
> +#define ASI_IMMU                0x50 /* Insn-MMU main register space    */
> +#define ASI_IMMU_TSB_8KB_PTR    0x51 /* Insn-MMU 8KB TSB pointer reg    */
> +#define ASI_IMMU_TSB_64KB_PTR   0x52 /* Insn-MMU 64KB TSB pointer reg   */
> +#define ASI_ITLB_DATA_IN        0x54 /* Insn-MMU TLB data in reg        */
> +#define ASI_ITLB_DATA_ACCESS    0x55 /* Insn-MMU TLB data access reg    */
> +#define ASI_ITLB_TAG_READ       0x56 /* Insn-MMU TLB tag read reg       */
> +#define ASI_IMMU_DEMAP          0x57 /* Insn-MMU TLB demap              */
> +#define ASI_DMMU                0x58 /* Data-MMU main register space    */
> +#define ASI_DMMU_TSB_8KB_PTR    0x59 /* Data-MMU 8KB TSB pointer reg    */
> +#define ASI_DMMU_TSB_64KB_PTR   0x5a /* Data-MMU 16KB TSB pointer reg   */
> +#define ASI_DMMU_TSB_DIRECT_PTR 0x5b /* Data-MMU TSB direct pointer reg */
> +#define ASI_DTLB_DATA_IN        0x5c /* Data-MMU TLB data in reg        */
> +#define ASI_DTLB_DATA_ACCESS    0x5d /* Data-MMU TLB data access reg    */
> +#define ASI_DTLB_TAG_READ       0x5e /* Data-MMU TLB tag read reg       */
> +#define ASI_DMMU_DEMAP          0x5f /* Data-MMU TLB demap              */
> +#define ASI_IIU_INST_TRAP       0x60 /* (III) Instruction Breakpoint    */
> +#define ASI_INTR_ID             0x63 /* (CMT) Interrupt ID register     */
> +#define ASI_CORE_ID             0x63 /* (CMT) LP ID register            */
> +#define ASI_CESR_ID             0x63 /* (CMT) CESR ID register          */
> +#define ASI_IC_INSTR            0x66 /* Insn cache instruction ram diag */
> +#define ASI_IC_TAG              0x67 /* Insn cache tag/valid ram diag   */
> +#define ASI_IC_STAG             0x68 /* (III) Insn cache snoop tag ram  */
> +#define ASI_IC_PRE_DECODE       0x6e /* Insn cache pre-decode ram diag  */
> +#define ASI_IC_NEXT_FIELD       0x6f /* Insn cache next-field ram diag  */
> +#define ASI_BRPRED_ARRAY        0x6f /* (III) Branch Prediction RAM diag*/
> +#define ASI_BLK_AIUP            0x70 /* Primary, user, block load/store */
> +#define ASI_BLK_AIUS            0x71 /* Secondary, user, block ld/st    */
> +#define ASI_MCU_CTRL_REG        0x72 /* (III) Memory controller regs    */
> +#define ASI_EC_DATA             0x74 /* (III) E-cache data staging reg  */
> +#define ASI_EC_CTRL             0x75 /* (III) E-cache control reg       */
> +#define ASI_EC_W                0x76 /* E-cache diag write access       */
> +#define ASI_UDB_ERROR_W         0x77 /* External UDB error regs W       */
> +#define ASI_UDB_CONTROL_W       0x77 /* External UDB control regs W     */
> +#define ASI_INTR_W              0x77 /* IRQ vector dispatch write       */
> +#define ASI_INTR_DATAN_W        0x77 /* (III) Out irq vector data reg N */
> +#define ASI_INTR_DISPATCH_W     0x77 /* (III) Interrupt vector dispatch */
> +#define ASI_BLK_AIUPL           0x78 /* Primary, user, little, blk ld/st*/
> +#define ASI_BLK_AIUSL           0x79 /* Secondary, user, little, blk ld/st*/
> +#define ASI_EC_R                0x7e /* E-cache diag read access        */
> +#define ASI_UDBH_ERROR_R        0x7f /* External UDB error regs rd hi   */
> +#define ASI_UDBL_ERROR_R        0x7f /* External UDB error regs rd low  */
> +#define ASI_UDBH_CONTROL_R      0x7f /* External UDB control regs rd hi */
> +#define ASI_UDBL_CONTROL_R      0x7f /* External UDB control regs rd low*/
> +#define ASI_INTR_R              0x7f /* IRQ vector dispatch read        */
> +#define ASI_INTR_DATAN_R        0x7f /* (III) In irq vector data reg N  */
>   #define ASI_MON_P               0x84 /* (VIS4) Primary, monitor         */
>   #define ASI_MON_S               0x85 /* (VIS4) Secondary, monitor       */
> -#define ASI_PIC			0xb0 /* (NG4) PIC registers		*/
> -#define ASI_PST8_P		0xc0 /* Primary, 8 8-bit, partial	*/
> -#define ASI_PST8_S		0xc1 /* Secondary, 8 8-bit, partial	*/
> -#define ASI_PST16_P		0xc2 /* Primary, 4 16-bit, partial	*/
> -#define ASI_PST16_S		0xc3 /* Secondary, 4 16-bit, partial	*/
> -#define ASI_PST32_P		0xc4 /* Primary, 2 32-bit, partial	*/
> -#define ASI_PST32_S		0xc5 /* Secondary, 2 32-bit, partial	*/
> -#define ASI_PST8_PL		0xc8 /* Primary, 8 8-bit, partial, L	*/
> -#define ASI_PST8_SL		0xc9 /* Secondary, 8 8-bit, partial, L	*/
> -#define ASI_PST16_PL		0xca /* Primary, 4 16-bit, partial, L	*/
> -#define ASI_PST16_SL		0xcb /* Secondary, 4 16-bit, partial, L	*/
> -#define ASI_PST32_PL		0xcc /* Primary, 2 32-bit, partial, L	*/
> -#define ASI_PST32_SL		0xcd /* Secondary, 2 32-bit, partial, L	*/
> -#define ASI_FL8_P		0xd0 /* Primary, 1 8-bit, fpu ld/st	*/
> -#define ASI_FL8_S		0xd1 /* Secondary, 1 8-bit, fpu ld/st	*/
> -#define ASI_FL16_P		0xd2 /* Primary, 1 16-bit, fpu ld/st	*/
> -#define ASI_FL16_S		0xd3 /* Secondary, 1 16-bit, fpu ld/st	*/
> -#define ASI_FL8_PL		0xd8 /* Primary, 1 8-bit, fpu ld/st, L	*/
> -#define ASI_FL8_SL		0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
> -#define ASI_FL16_PL		0xda /* Primary, 1 16-bit, fpu ld/st, L	*/
> -#define ASI_FL16_SL		0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
> -#define ASI_BLK_COMMIT_P	0xe0 /* Primary, blk store commit	*/
> -#define ASI_BLK_COMMIT_S	0xe1 /* Secondary, blk store commit	*/
> +#define ASI_PIC                 0xb0 /* (NG4) PIC registers             */
> +#define ASI_PST8_P              0xc0 /* Primary, 8 8-bit, partial       */
> +#define ASI_PST8_S              0xc1 /* Secondary, 8 8-bit, partial     */
> +#define ASI_PST16_P             0xc2 /* Primary, 4 16-bit, partial      */
> +#define ASI_PST16_S             0xc3 /* Secondary, 4 16-bit, partial    */
> +#define ASI_PST32_P             0xc4 /* Primary, 2 32-bit, partial      */
> +#define ASI_PST32_S             0xc5 /* Secondary, 2 32-bit, partial    */
> +#define ASI_PST8_PL             0xc8 /* Primary, 8 8-bit, partial, L    */
> +#define ASI_PST8_SL             0xc9 /* Secondary, 8 8-bit, partial, L  */
> +#define ASI_PST16_PL            0xca /* Primary, 4 16-bit, partial, L   */
> +#define ASI_PST16_SL            0xcb /* Secondary, 4 16-bit, partial, L */
> +#define ASI_PST32_PL            0xcc /* Primary, 2 32-bit, partial, L   */
> +#define ASI_PST32_SL            0xcd /* Secondary, 2 32-bit, partial, L */
> +#define ASI_FL8_P               0xd0 /* Primary, 1 8-bit, fpu ld/st     */
> +#define ASI_FL8_S               0xd1 /* Secondary, 1 8-bit, fpu ld/st   */
> +#define ASI_FL16_P              0xd2 /* Primary, 1 16-bit, fpu ld/st    */
> +#define ASI_FL16_S              0xd3 /* Secondary, 1 16-bit, fpu ld/st  */
> +#define ASI_FL8_PL              0xd8 /* Primary, 1 8-bit, fpu ld/st, L  */
> +#define ASI_FL8_SL              0xd9 /* Secondary, 1 8-bit, fpu ld/st, L*/
> +#define ASI_FL16_PL             0xda /* Primary, 1 16-bit, fpu ld/st, L */
> +#define ASI_FL16_SL             0xdb /* Secondary, 1 16-bit, fpu ld/st,L*/
> +#define ASI_BLK_COMMIT_P        0xe0 /* Primary, blk store commit       */
> +#define ASI_BLK_COMMIT_S        0xe1 /* Secondary, blk store commit     */
>   #define ASI_TWINX_P             0xe2 /* twin load, primary implicit     */
> -#define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
> -				      * primary, implicit */
> +#define ASI_BLK_INIT_QUAD_LDD_P 0xe2 /* (NG) init-store, twin load,
> +                                      * primary, implicit               */
>   #define ASI_TWINX_S             0xe3 /* twin load, secondary implicit   */
> -#define ASI_BLK_INIT_QUAD_LDD_S	0xe3 /* (NG) init-store, twin load,
> -				      * secondary, implicit */
> +#define ASI_BLK_INIT_QUAD_LDD_S 0xe3 /* (NG) init-store, twin load,
> +                                      * secondary, implicit             */
>   #define ASI_TWINX_PL            0xea /* twin load, primary implicit, LE */
>   #define ASI_TWINX_SL            0xeb /* twin load, secondary implicit, LE */
> -#define ASI_BLK_P		0xf0 /* Primary, blk ld/st		*/
> -#define ASI_BLK_S		0xf1 /* Secondary, blk ld/st		*/
> -#define ASI_ST_BLKINIT_MRU_P	0xf2 /* (NG4) init-store, twin load,
> -				      * Most-Recently-Used, primary,
> -				      * implicit
> -				      */
> -#define ASI_ST_BLKINIT_MRU_S	0xf2 /* (NG4) init-store, twin load,
> -				      * Most-Recently-Used, secondary,
> -				      * implicit
> -				      */
> -#define ASI_BLK_PL		0xf8 /* Primary, blk ld/st, little	*/
> -#define ASI_BLK_SL		0xf9 /* Secondary, blk ld/st, little	*/
> -#define ASI_ST_BLKINIT_MRU_PL	0xfa /* (NG4) init-store, twin load,
> -				      * Most-Recently-Used, primary,
> -				      * implicit, little-endian
> -				      */
> -#define ASI_ST_BLKINIT_MRU_SL	0xfb /* (NG4) init-store, twin load,
> -				      * Most-Recently-Used, secondary,
> -				      * implicit, little-endian
> -				      */
> +#define ASI_BLK_P               0xf0 /* Primary, blk ld/st              */
> +#define ASI_BLK_S               0xf1 /* Secondary, blk ld/st            */
> +#define ASI_ST_BLKINIT_MRU_P    0xf2 /* (NG4) init-store, twin load,
> +                                      * Most-Recently-Used, primary,
> +                                      * implicit
> +                                      */
> +#define ASI_ST_BLKINIT_MRU_S    0xf2 /* (NG4) init-store, twin load,
> +                                      * Most-Recently-Used, secondary,
> +                                      * implicit
> +                                      */
> +#define ASI_BLK_PL              0xf8 /* Primary, blk ld/st, little      */
> +#define ASI_BLK_SL              0xf9 /* Secondary, blk ld/st, little    */
> +#define ASI_ST_BLKINIT_MRU_PL   0xfa /* (NG4) init-store, twin load,
> +                                      * Most-Recently-Used, primary,
> +                                      * implicit, little-endian
> +                                      */
> +#define ASI_ST_BLKINIT_MRU_SL   0xfb /* (NG4) init-store, twin load,
> +                                      * Most-Recently-Used, secondary,
> +                                      * implicit, little-endian
> +                                      */
>   
>   #endif /* SPARC_ASI_H */


