Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A587C561E6
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:10:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrtAR-0000Cq-Tg; Thu, 06 Aug 2026 04:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrtAO-0000CZ-QC
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 04:09:29 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrtAL-0005ZZ-5X
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 04:09:27 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 67689Ag1028608
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 17:09:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=vkzUz2tltMLSyUseir9AB5ilHYnEj4PQIV9zFCRWyhE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1786003750; v=1;
 b=fSBmfzURHUH8zF3umXVOsAlYV1ecsmEUNRPVVN/wHaxjcFqBjzU4zUjpvlQiB6Oq
 LUK8ue8GsSOIvA19RBNm3fJiJDFvTA3KcSHEhygBbY0Yr2dSbXrskaDO29lr9jbN
 /o5OVM9X2Oij62rBysNruYTHYnkBkhDPV2g/OqzPHdbo8Hk9Hrr+axqNRc0nWxKb
 8mtKOXsBD2gdu86e3szNUqUCfzWvPWB7CZoo9FQFoPO6XBM17Kb26WauZQXqXnvh
 uQl8mjc/yANw1zLQwXreq7u1EGNkSi5nCzJhTHy9BoSsrivx3YOlNDe2XhFVijiN
 0zZrK0ZTuR0Kuz/lRwFxWQ==
Message-ID: <1b01c4f2-53f8-43b2-8dd1-ceab19cc6be8@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 17:09:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] dump: add crash_occurred flag to QEMUCPUState
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@qualcomm.com, pbonzini@redhat.com, viktor.prutyanov@phystech.edu
References: <178599725914.10029.4441302124415593392@linux.alibaba.com>
 <178599725914.10029.14279751262185488168@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <178599725914.10029.14279751262185488168@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/08/06 15:20, Zhengrong Li wrote:
> Add is_crash_occurred_cpu field to QEMUCPUState so that
> dump-guest-memory can record which CPU triggered the guest
> panic. Bump QEMUCPUSTATE_VERSION to 2.

The patch message still says it bumps QEMUCPUSTATE_VERSION.

> 
> The new field is appended after kernel_gs_base, so existing
> tools that check the 'size' field can safely ignore it when
> reading older dumps.
> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
> ---
>   contrib/elf2dmp/qemu_elf.h | 2 ++
>   target/i386/arch_dump.c    | 6 ++++++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index adc50238b4..3b28332e67 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -27,6 +27,8 @@ typedef struct QEMUCPUState {
>       QEMUCPUSegment ldt, tr, gdt, idt;
>       uint64_t cr[5];
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];

Growing QEMUCPUState from 440 to 448 bytes confuses init_states() in 
contrib/elf2dmp/qemu_elf.c and makes valid version-1 notes and appear to 
lack kernel_gs_base, despite that field occupying bytes 432–439. Move 
this hunk to patch 2 which updates the function and other elf2dmp stuff.

Regards,
Akihiko Odaki

>   } QEMUCPUState;
>   
>   int is_system(QEMUCPUState *s);
> diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
> index 16e47c4747..8ce2c7e9bb 100644
> --- a/target/i386/arch_dump.c
> +++ b/target/i386/arch_dump.c
> @@ -264,6 +264,8 @@ struct QEMUCPUState {
>        * by checking 'size' field.
>        */
>       uint64_t kernel_gs_base;
> +    uint8_t  is_crash_occurred_cpu;
> +    uint8_t  pad[7];
>   };
>   
>   typedef struct QEMUCPUState QEMUCPUState;
> @@ -279,6 +281,7 @@ static void copy_segment(QEMUCPUSegment *d, SegmentCache *s)
>   
>   static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   {
> +    CPUState *cs = env_cpu(env);
>       memset(s, 0, sizeof(QEMUCPUState));
>   
>       s->version = QEMUCPUSTATE_VERSION;
> @@ -325,6 +328,9 @@ static void qemu_get_cpustate(QEMUCPUState *s, CPUX86State *env)
>   #ifdef TARGET_X86_64
>       s->kernel_gs_base = env->kernelgsbase;
>   #endif
> +    if (cs->crash_occurred) {
> +        s->is_crash_occurred_cpu = 1;
> +    }
>   }
>   
>   static inline int cpu_write_qemu_note(WriteCoreDumpFunction f,


