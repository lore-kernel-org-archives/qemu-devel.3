Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EABBC55ABF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:38:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrvUM-0001uO-Sc; Thu, 06 Aug 2026 06:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrvUK-0001u2-Il
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:38:12 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wrvUI-0005hp-Cv
 for qemu-devel@nongnu.org; Thu, 06 Aug 2026 06:38:12 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 676Ac3B1013502
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 6 Aug 2026 19:38:03 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=l1HypR3oxkSoEkMqY4wha+KI3nUgxl2mLhDdvrX6qxs=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1786012683; v=1;
 b=iSzeXYMZTTSQ+D3JN3z1rdgntGCJCsQbDsbUeu7ha6xVU0EONbe1Hxjgzlq4XbZu
 r88KFho2XaFVcihrOoXR9kf6CrmXDAxEAEIdXWjbrZ93O7YHV0Cat0VyfJoPKPPG
 7kZS8yK+kf5wcXuh6QftsJ+/dZd42uoHRJbKogKekg2ppThiKcjZz8rzelnV+5pq
 WtVg9kRNJVwRtlx20VnWC2BszjJ3DaP4nzyQeWx1Uc/OBeXEmkkZe5PtmUYXmP3/
 z0qZ90OhfPD8ePk+wOU/w9v/mfrZzcQKcmP2wr+3Qvv98N0opv25zhEHOwimaSdH
 cCse7W0W7GxNlmN+k4NQxg==
Message-ID: <54ea719f-750f-48a7-874d-0cab5c790163@rsg.ci.i.u-tokyo.ac.jp>
Date: Thu, 6 Aug 2026 19:38:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] elf2dmp: fill ContextBuffer with faulting CPU
 context
To: Zhengrong Li <zhengrong_li@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: philmd@qualcomm.com, pbonzini@redhat.com, viktor.prutyanov@phystech.edu
References: <178600606177.41696.3160576684819885412@linux.alibaba.com>
 <178600606177.41696.17020382803154474312@linux.alibaba.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <178600606177.41696.17020382803154474312@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2026/08/06 17:47, Zhengrong Li wrote:
> When is_crash_occurred_cpu is set in QEMUCPUState, copy that CPU's
> context into WinDumpHeader64 ContextBuffer so WinDbg opens on the
> faulting CPU instead of CPU 0. A per-CPU size check ensures the
> field is present before reading, supporting heterogeneous dumps.
> 
> Also extract KiBugCheckData from the guest kernel to populate
> BugcheckCode and BugcheckParameters in the dump header.
> 
> The embedded state->size is clamped to MIN(state->size, n_descsz)
> in init_states() to prevent reading beyond the note descriptor.
> 
> Signed-off-by: Zhengrong Li <zhengrong.lzr@alibaba-inc.com>
> ---
>   contrib/elf2dmp/kdbg.h     |  9 +++++++
>   contrib/elf2dmp/main.c     | 50 ++++++++++++++++++++++++++++++++++++--
>   contrib/elf2dmp/qemu_elf.c |  7 ++++++
>   contrib/elf2dmp/qemu_elf.h |  2 ++
>   4 files changed, 66 insertions(+), 2 deletions(-)
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
> index a62abadcc0..e25709b45d 100644
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
>   
> +    /* First pass: identify faulting CPU and set header context early */
> +    for (i = 0; i < qe->state_nr; i++) {
> +        QEMUCPUState *s = qe->state[i];
> +        if (s->size >= offsetof(QEMUCPUState, is_crash_occurred_cpu) +
> +                        sizeof(s->is_crash_occurred_cpu) &&
> +            s->is_crash_occurred_cpu) {
> +            WinContext64 ctx;
> +            win_context_init_from_qemu_cpu_state(&ctx, s);
> +            memcpy(hdr->ContextBuffer, &ctx, sizeof(ctx));
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
> index c9bad6e82c..b181d418bd 100644
> --- a/contrib/elf2dmp/qemu_elf.c
> +++ b/contrib/elf2dmp/qemu_elf.c
> @@ -103,6 +103,13 @@ static bool init_states(QEMU_Elf *qe)
>               nhdr->n_descsz >= offsetof(QEMUCPUState, kernel_gs_base)) {
>               state_size = MIN(state->size, nhdr->n_descsz);
>   
> +            /*
> +             * Clamp the embedded size to the actual note descriptor size
> +             * so that downstream size checks (e.g. fill_context) never
> +             * read beyond the descriptor boundary.
> +             */
> +            state->size = state_size;
> +
>               if (state_size < sizeof(*state)) {

This compares the validated size with the new 448-byte whole structure. 
Valid old 440-byte notes contain kernel_gs_base, but are classified as 
lacking it. Please change this to compare against the end of 
kernel_gs_base, not sizeof(*state).

Regards,
Akihiko Odaki

>                   eprintf("CPU #%u: QEMU CPU state size %u doesn't match\n",
>                           states->len, state_size);
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
>   } QEMUCPUState;
>   
>   int is_system(QEMUCPUState *s);


