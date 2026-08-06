Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDE8C55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 03:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wroiI-00031p-Vy; Wed, 05 Aug 2026 23:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wroiC-00031V-RG
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:24:06 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@gmail.com>)
 id 1wroiA-0004tg-Qw
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 23:24:04 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2cab973140bso23877885ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 20:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785986641; x=1786591441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/SWxSCaJyl727Gqx6oYVD/kNJxNTwYMs6DIpfVsRm0A=;
 b=iS1Ie813Shks3LHG18AXnqRBmQ8MW61hU/MDFrcaE8Oh4sBfJhvTndnWRcYJc+rsFl
 ssDPt9PL16gnyDD6E7zM0D7tmOIUKdWPm6wOazo+6GpTgftUJldIcPkHSNMUk7ZvTCE3
 S0yXLR0p5EZA1vhDKQ7J1pCySSsyQb/mN4SQ3CXm1ZAZYZ/s+6eZNcZAiRctOzrjaCDs
 HV3szc0jUyqbNW9x4ggRZrIfiBYgvWtwMeVnupmS2SNuWn4saFefwdj2BpORgwGEBtpv
 2X8lvQ8+J/A1osgjmEnUlZlTQ68Q12sY0XQotWVb2mZHNsmANL0WTjWmxAPgTA+t5mtD
 HrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986641; x=1786591441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=/SWxSCaJyl727Gqx6oYVD/kNJxNTwYMs6DIpfVsRm0A=;
 b=M2XsjEVQJNWTTwhNg5HALyoiTISc+zD6PEQfeXlEV74inCZEAiaBRpU54ZfG2Ly09M
 adzNfRQAZ96hlNg1Lllaydppe7kUnweIApofMY0M5Tm1P3/akK0LAFg/jPEolQ46evUf
 87kZiMrAmdIlEzH3aibaMrtwppxy7S5m0670F1+/MphOvL9F/3q+7p/DJ/77VnPZihU2
 BIldOp4EO/r3HmNFMadO+XQk61XCgykE1Aj3wYXoGW1RbIQThdP6y7AJZJ619bU/4JyL
 kZtoqgvJsVz5f0C+u6zoeTDhAgTs+zJiPt7LhrMxrxmNWBha+/lvH3OVgs5nIH/KkQGd
 D2aw==
X-Forwarded-Encrypted: i=1;
 AHgh+RppBZuWv2XAi/1+6VCqjoD4swWDxFUEJ7BbdgFFXMY/Xv6A8Iec5eF/+w9RWW5/nMLxxZ5tg40fS+lK@nongnu.org
X-Gm-Message-State: AOJu0YzE7T7WkAOt1WDXERSYEPxK7fwz7jOOe0LmXS/kmkFxnKHsQyHD
 lfsyvAPu4oBv/mrZy2Cbkr8cqAf25eKF4DLefKScPkUqwmWnbnBdcOKxvpG4L6B7
X-Gm-Gg: AR+sD13JoXl8t4iNPvWAcZ6reUvH+CAlZjcNvpAxVH8f6fKiqicz4l/B6A9bv7lsS/V
 ru5mlMuQLEC9EHqyfeoqfOgO+dIwbYvkGPNLlb1HnPaXaiwcEPZucS6DMZ7MS3MwugwA8ULSM1U
 1PQTqT3+bajedyGIxdM5xyNVCEnSkyI2xqbnSc276SelcLKOHWqyK8AtAaOHR7PRZbDeewhrGy0
 KOs+1dqSEoHmixuiksMiC4MzVHLaHYADUtJc2y4udbZD/YSXl58folGQ6bwM5rS0WJx3Fu4RSgD
 /N1le3C6INFJXnC7WeKrngRGRoAqUEv3NZaHFf/cn/cOZOOFdR/c7eD/fdoLsYxkA6Ym6/igKdY
 u7ynduzW2hpZBkYw3r2Z8TGNQbJYs0rhv0MpwLxuZlhp8iL8e99ZeQtX7J8464UPJXXyutrBLaA
 ZndW9fwmxhLzuW3TeU8Sf0as9nRbHmO0EqUXFAQO3ernBIU/KJJzgzHLxUz+gy+XimohrVjMkzM
 TjayJaxIJlT2RwGPvl89USLCII=
X-Received: by 2002:a17:902:e54f:b0:2cc:1452:a014 with SMTP id
 d9443c01a7336-2d0ca9fe7d3mr134443245ad.18.1785986641018; 
 Wed, 05 Aug 2026 20:24:01 -0700 (PDT)
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp. [133.11.54.183])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d0aa4d9c77sm22894385ad.73.2026.08.05.20.23.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 20:24:00 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@gmail.com>
X-Google-Original-From: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <e173dbb1-d7e7-4a71-b1a0-765f11052283@daynix.com>
Date: Thu, 6 Aug 2026 12:23:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] elf2dmp: fill ContextBuffer with faulting CPU
 context
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: viktor.prutyanov@phystech.edu
References: <178592075881.15274.7510279315190894277@linux.alibaba.com>
 <178592075881.15274.12721897603002325817@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <178592075881.15274.12721897603002325817@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@gmail.com; helo=mail-pl1-x62d.google.com
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

On 2026/08/05 18:05, Zhengrong Li wrote:
> When is_crash_occurred_cpu is set in QEMUCPUState, copy that CPU's
> context into WinDumpHeader64 ContextBuffer so WinDbg opens on the
> faulting CPU instead of CPU 0.
> 
> Also extract KiBugCheckData from the guest kernel to populate
> BugcheckCode and BugcheckParameters in the dump header.
> 
> Changes since v1:
>    - Add size-based field detection in init_states() for forward compatibility
>    - Use has_is_crash_occurred_cpu flag instead of version check
>    - Set header context before best-effort guest memory operations to avoid
>      losing faulting CPU context on partial dump failures
>    - Use LIVE_SYSTEM_DUMP when BugcheckCode is zero
>    - Use PRIx32 for BugcheckCode format specifier
>    - Use linux.alibaba.com identity
> 
> Signed-off-by: Zhengrong Li <zhengrong_li@linux.alibaba.com>
> ---
>   contrib/elf2dmp/kdbg.h     |  9 +++++++
>   contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
>   contrib/elf2dmp/qemu_elf.c | 20 +++++++++------
>   contrib/elf2dmp/qemu_elf.h |  1 +
>   4 files changed, 71 insertions(+), 9 deletions(-)
> 
> diff --git a/contrib/elf2dmp/kdbg.h b/contrib/elf2dmp/kdbg.h
> index 002e3d0cd5..15e4fb1140 100644
> --- a/contrib/elf2dmp/kdbg.h
> +++ b/contrib/elf2dmp/kdbg.h
> @@ -195,4 +195,13 @@ typedef struct KDDEBUGGER_DATA64 {
>       uint16_t OffsetPrcbContext;
>   } KDDEBUGGER_DATA64;
>   
> +typedef struct KIBUGCHECK_INFO {
> +    uint32_t BugcheckCode;
> +    uint32_t unused0;
> +    uint64_t BugcheckParameter1;
> +    uint64_t BugcheckParameter2;
> +    uint64_t BugcheckParameter3;
> +    uint64_t BugcheckParameter4;
> +} KIBUGCHECK_INFO;
> +
>   #endif /* KDBG_H */
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index a62abadcc0..59ffc0f2e8 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -338,11 +338,26 @@ static bool fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
>    * A dump may still contain valuable information even if it lacks contexts of
>    * some CPUs due to dump corruption or a failure before starting CPUs.
>    */
> -static void fill_context(KDDEBUGGER_DATA64 *kdbg,
> +static void fill_context(WinDumpHeader64 *hdr, KDDEBUGGER_DATA64 *kdbg,
>                            struct va_space *vs, QEMU_Elf *qe)
>   {
>       int i;
> +    int fault_cpu = -1;
>   
> +    /* First pass: identify faulting CPU and set header context early */
> +    for (i = 0; i < qe->state_nr; i++) {
> +        QEMUCPUState *s = qe->state[i];
> +        if (qe->has_is_crash_occurred_cpu && s->is_crash_occurred_cpu) {
> +            WinContext64 ctx;
> +            win_context_init_from_qemu_cpu_state(&ctx, s);
> +            memcpy(hdr->ContextBuffer, &ctx, sizeof(ctx));
> +            fault_cpu = i;

fault_cpu is assigned but never read. Consequently:

     error: variable ‘fault_cpu’ set but not used
            [-Werror=unused-but-set-variable]

make -j8 contrib/elf2dmp/elf2dmp fails.

> +            printf("Faulting CPU identified: #%d\n", i);
> +            break;
> +        }
> +    }
> +
> +    /* Second pass: fill context for all CPUs (best-effort) */
>       for (i = 0; i < qe->state_nr; i++) {
>           uint64_t Prcb;
>           uint64_t Context;
> @@ -512,6 +527,7 @@ int main(int argc, char *argv[])
>       uint64_t KdVersionBlock;
>       bool kernel_found = false;
>       OMFSignatureRSDS rsds;
> +    uint64_t KiBugCheckData;
>   
>       if (argc != 3) {
>           eprintf("usage:\n\t%s elf_file dmp_file\n", argv[0]);
> @@ -611,7 +627,37 @@ int main(int argc, char *argv[])
>           goto out_kdbg;
>       }
>   
> -    fill_context(kdbg, &vs, &qemu_elf);
> +    if (!SYM_RESOLVE(KernBase, &pdb, KiBugCheckData)) {
> +        eprintf("Failed to get KiBugCheckData.\n");
> +    } else {
> +        KIBUGCHECK_INFO data = { 0 };
> +        if (va_space_rw(&vs, KiBugCheckData, &data, sizeof(data), 0)) {
> +            header.BugcheckCode = data.BugcheckCode;
> +            header.BugcheckParameter1 = data.BugcheckParameter1;
> +            header.BugcheckParameter2 = data.BugcheckParameter2;
> +            header.BugcheckParameter3 = data.BugcheckParameter3;
> +            header.BugcheckParameter4 = data.BugcheckParameter4;
> +
> +            /*
> +             * If BugcheckCode wasn't saved, we consider guest OS as alive.
> +             */
> +            if (!header.BugcheckCode) {
> +                header.BugcheckCode = LIVE_SYSTEM_DUMP;
> +            }
> +
> +            printf("KiBugCheckData: 0x%016" PRIx64
> +                   ", BugcheckCode: 0x%08" PRIx32 ", Args:"
> +                   " 0x%016" PRIx64 " 0x%016" PRIx64
> +                   " 0x%016" PRIx64 " 0x%016" PRIx64 "\n",
> +                    KiBugCheckData, header.BugcheckCode,
> +                    data.BugcheckParameter1, data.BugcheckParameter2,
> +                    data.BugcheckParameter3, data.BugcheckParameter4);
> +        } else {
> +            eprintf("Failed to va_space_rw KiBugCheckData.\n");
> +        }
> +    }
> +
> +    fill_context(&header, kdbg, &vs, &qemu_elf);
>   
>       if (!write_dump(&ps, &header, argv[2])) {
>           eprintf("Failed to save dump\n");
> diff --git a/contrib/elf2dmp/qemu_elf.c b/contrib/elf2dmp/qemu_elf.c
> index c9bad6e82c..8eb2654356 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -71,7 +71,8 @@ static bool init_states(QEMU_Elf *qe)
>           return false;
>       }
>   
> -    qe->has_kernel_gs_base = 1;
> +    qe->has_kernel_gs_base = 0;
> +    qe->has_is_crash_occurred_cpu = 0;
>       offset = phdr[0].p_offset;
>       states = g_ptr_array_new();
>   
> @@ -103,14 +104,19 @@ static bool init_states(QEMU_Elf *qe)
>               nhdr->n_descsz >= offsetof(QEMUCPUState, kernel_gs_base)) {
>               state_size = MIN(state->size, nhdr->n_descsz);
>   
> -            if (state_size < sizeof(*state)) {
> +            if (state_size >= offsetof(QEMUCPUState, kernel_gs_base) +
> +                              sizeof(state->kernel_gs_base)) {
> +                qe->has_kernel_gs_base = 1;
> +            }
> +
> +            if (state_size >= offsetof(QEMUCPUState, is_crash_occurred_cpu) +
> +                              sizeof(state->is_crash_occurred_cpu)) {
> +                qe->has_is_crash_occurred_cpu = 1;
> +            }
> +
> +            if (state_size != sizeof(*state)) {
>                   eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
>                           states->len, state_size);
> -                /*
> -                 * We assume either every QEMU CPU state has KERNEL_GS_BASE or
> -                 * no one has.
> -                 */
> -                qe->has_kernel_gs_base = 0;
>               }

Field availability is ORed across all CPU notes and then applied to 
every note. With a 440-byte CPU 0 note followed by a 448-byte CPU 1 
note, CPU 1 sets has_is_crash_occurred_cpu, after which fill_context() 
reads byte 440 beyond CPU 0’s descriptor. That byte normally belongs to 
the next note header and is nonzero, so CPU 0 can be falsely selected. 
The same aggregation can make fix_dtb() read a missing kernel_gs_base. 
Please follow what's previously done for kernel_gs_base.

Regards,
Akihiko Odaki

>               g_ptr_array_add(states, state);
>           }
> diff --git a/contrib/elf2dmp/qemu_elf.h b/contrib/elf2dmp/qemu_elf.h
> index 3b28332e67..120de4a2f4 100644
> --- a/contrib/elf2dmp/qemu_elf.h
> +++ b/contrib/elf2dmp/qemu_elf.h
> @@ -42,6 +42,7 @@ typedef struct QEMU_Elf {
>       QEMUCPUState **state;
>       size_t state_nr;
>       int has_kernel_gs_base;
> +    int has_is_crash_occurred_cpu;
>   } QEMU_Elf;
>   
>   bool QEMU_Elf_init(QEMU_Elf *qe, const char *filename);


