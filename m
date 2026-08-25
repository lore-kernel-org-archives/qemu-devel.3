Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF457C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzde-00028Y-VT; Tue, 25 Aug 2026 18:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyzdb-000289-Vl
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:28:59 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyzdZ-0001Jd-7R
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:28:59 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-3900e39d935so530422a91.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 15:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787696936; x=1788301736; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JGM4MSAmbVOilagknl3UN1gb1k71SSkBxJejWUWkDqc=;
 b=cGerAO/Lw0ggZ1GxGOj9FybR+kAo06relk+R/if8upZ0wf9GASZ1H6N8KDDxjES6Pn
 lb/9KyzJ9lAayQGzh47va/9Np6T0+gUMjku0iarQC6UyfKYDXkV/xkrgOTHYL4RR6cjb
 GsfSAeHcxeo8PB0LRrd4ABtWjPeqjIIN/WqAmBvZg9jyzPZxIMPDL6q2qZHTmOoBXQpS
 F9lZ7vvTOwvC1/engOZ0SIFDll6iGMb7KcLobO/ZLkf3jo2R0r71S9IhbNM++pwEvQ11
 fAbEE3+8ZYR57VLha9Ii8tDthI5gvHyqzEvgTSRCFkypgxw9oAh8WVU4uH08aEC1iDMf
 pf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787696936; x=1788301736;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JGM4MSAmbVOilagknl3UN1gb1k71SSkBxJejWUWkDqc=;
 b=lLxpRhOsE2vgzipdbNmGwSJglD+lQAoYP/IDs+uTJ7IY2Jgmb+INzvZDkJT4LLdtmd
 pKvC2VNQbFyVe6Jhq0AS56Qc7EX65Eoj5HQc+m1+DnSJ+ytmglAM6LMXxSXuh00C/R+h
 wTp9jVlOK5VpLt4RA+fGj52ZsKeIbUGgb1KFnvS3Kjqcl7Zhp1ZApiXH8TBnoMfXzdli
 mV41aAsLXbnvW0XhZad2bqEec5INmZIaVwX1K1OjZYU6SqmTEdRVSQ5a8ukZYheXJhKV
 5cVmSEl8THbTcTQxbSbBAnR0iNFsagfZFPZQxfVeFjTF7+6hkMX+m5xV3QgfOPrdy0GB
 yl4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrINNB671J/0eHmYwSFmOodBYXw3E6q+BYPyrukIG3kBqwD9LONvXZPCHgpYME/Fh/8h9h9yT3A0Mb2@nongnu.org
X-Gm-Message-State: AFuF++ltIue0vnGO2hYezgZPtCCZXzHVlL9Zki041/GHwfsDJhIQIcxE
 amr5idM79Kr+GWM7S8Os6JW4sGWaCaAhx3w1sLWPqVbDUPKxgq0yvmhZWI7Su+2cd+tQicC7Aqy
 oF4JL
X-Gm-Gg: AR+sD12XkAOQ6en7lFYBMt/LmwU4HuA7bvLMu0W80J4hEYkZ4tGmxw3nDnHAfoATENz
 NgwYLbVVuETw41rdnV6MBDm2N4/AF0z3IKnpL0bxN9Rm+nFLWmGJSoKndbAXwbe1w1w0dax3PJ6
 LhhjHmr+aDTebeJCkaBnDlPAIfEaAwnIzaloo8J0OH4y+fa3UgrW0ICKcr2BAFjvngx/R7nuzaD
 0RF2nu59p0SvhxpPgg1GvBsfE77nLBwcznvpIWjdh3rJKGbeUTxnqC8W2E8z94+rnblPYzP2IkY
 9zzl5k7dCxFvhUTNjIswctdnDPe59Bl4JbkZyk06O/htBNRKTyABcDRopb18SBR/GziVdnulvZL
 roJkgU9AOR6ScdaxYFwBUlm+A99gqHweMT7f/z8syamSM88Wy73+26qeA78DYOiNFKLLzcBTV1Y
 Tn+LrFTlmg1JY/Etp4oi7QzzYOMUOvwUKEMEMnkfULkZfkfXYIZ8JLAz6XZA55KvaybmAbqgfmt
 8ZMdnsV8UKUF2a47pWQfLP1NlcQ
X-Received: by 2002:a17:90a:e7ca:b0:38f:de97:b06 with SMTP id
 98e67ed59e1d1-3966d3ba166mr4553779a91.5.1787696935293; 
 Tue, 25 Aug 2026 15:28:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396708c718dsm216287a91.1.2026.08.25.15.28.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 15:28:54 -0700 (PDT)
Message-ID: <8f221a33-1281-4710-8836-acc2367db444@linaro.org>
Date: Tue, 25 Aug 2026 15:28:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] RFC: tcg: probe the TB jump cache inline instead
 of calling a helper
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-5-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260822190818.1829249-5-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 8/22/26 12:08, Matt Turner wrote:
> Every indirect branch that cannot use goto_tb ends in
> tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For an
> emulated compiler that is 8.4 billion helper calls in a single translation
> unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> register destination and because goto_tb is restricted to same-page
> targets.
>
> The helper itself is already tight, but each call pays for a call frame,
> the can_do_io store, the get_tb_cpu_state() indirect call through
> TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to the
> jump cache probe that almost always hits (95.8% for this workload).
>
> Emit the probe inline instead. The destination PC is already in a TCG
> temp, and the flags, cflags and cs_base the destination must match are
> constants at translation time, so the fast path is a hash, four guarded
> loads and a goto_ptr. Only a miss calls the helper, which still owns
> filling the cache.
>
> tcg_gen_lookup_and_goto_ptr() therefore takes the destination PC and the
> TB being generated, and decides for itself whether to emit the probe or
> the old helper call; there is no second entry point for targets that opt
> in. A target that cannot name its destination in a single temp passes
> NULL and gets the helper. Since the probe hashes and compares the PC as
> one 64-bit value, a 32-bit guest PC also falls back.
>
> The PC a target passes must be exactly what get_tb_cpu_state() reports for
> the destination, which is the whole of the contract. alpha, loongarch,
> mips, ppc and s390x pass their PC register, whose value is that pc by
> construction. The rest pass NULL for now: avr's TB pc is the word address
> doubled, i386's is eip before segmentation, riscv masks it to 32 bits when
> xl is MXL_RV32, hppa derives it from the IAQ, hexagon adjusts it inside a
> hardware loop, and sparc puts npc in cs_base so the guard could not hit
> anyway. Each of those is a one-line change for whoever wants to measure it.
>
> Two details matter for the generated code. The flags and cflags guards are
> folded into a single aligned 64-bit load and compare, since the fields are
> adjacent. And each path emits its own goto_ptr rather than branching to a
> shared one: a temp live across the label is spilled and reloaded on every
> dispatch, which cost 6.3% on its own.
>
> The probe cannot check everything the helper checks, and the one that
> matters is breakpoints. check_for_breakpoints() raises EXCP_DEBUG on an
> exact pc match and selects CF_BP_PAGE cflags for the rest of the page, and
> setting a breakpoint deliberately invalidates no TB, so a block translated
> before the breakpoint was set is still sitting in the jump cache. Rather
> than pay for a breakpoint test on the fast path, give the probe its own
> base pointer, tb_jmp_cache_probe, that nothing else reads, and point it at
> a page of zeroes while any breakpoint is set. Every entry the probe finds
> then has a NULL tb, so every dispatch misses into the helper and the old
> behaviour is restored exactly. cpu_breakpoint_insert() poisons the pointer,
> so the poison takes effect at the next dispatch rather than whenever that
> vCPU next reaches its main loop, which matters because a vCPU chaining
> indirectly need never reach it. The main loop puts the pointer back once the
> last breakpoint is gone; that is a load and a compare per block dispatched
> from the main loop, and nothing at all in generated code.
>
> The flags and cflags constants are safe against the other things that can
> change them. CF_PARALLEL is only ever set by begin_parallel_context(),
> which flushes first, so no block predating it survives to dispatch. gdb
> single-step is only turned on with the CPU stopped, and a block translated
> without CF_SINGLE_STEP can only be re-entered through tb_lookup(), which
> from then on demands the new cflags -- so a stale-cflags block is never the
> one running. What is left is one_insn_per_tb and -d nochain, which the
> monitor can toggle under a running vCPU without a flush; see below.
>
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, LTO
> build, on top of the preceding three patches:
>
>      before: 1,402,667,803,616 instructions
>      after:    916,415,123,244 instructions   -34.67%
>
>      before: 115.56s wall clock
>      after:   85.59s wall clock               -25.94%
>
> The gap between the two is the point at which this stops being a
> straight-line win: the helper call was highly predictable work that the
> host pipelined well, so removing it retires far fewer instructions than it
> saves time. IPC falls from 2.48 to 2.17 across this patch for that reason.
>
> Despite emitting more code, this also reduces instruction cache pressure,
> because a dispatch no longer jumps into qemu's .text and evicts translated
> code:
>
>      before: 11,735,141,703 L1-icache-load-misses
>      after:   7,154,863,292 L1-icache-load-misses   -39.0%
>
> The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> falls from 31.01% of samples to 0.35%, and qemu's own .text falls from
> 38.8% to 5.3%, with the balance moving into generated code.
>
> Combined with the three preceding patches, against an unmodified LTO
> build, 1,646,994,254,249 instructions fall to 916,415,123,244, or -44.36%.
> The emulated compiler produces byte-identical output throughout.
>
> Open issues, hence RFC:
>
> - one_insn_per_tb and CPU_LOG_TB_NOCHAIN can be toggled from the monitor
>    while a vCPU is inside a block that was translated without them. The
>    block keeps dispatching inline with the old cflags until it exits for
>    some other reason. Poisoning the probe from
>    tcg_update_all_curr_cflags() would close it.
> - The jump cache entry is read without qatomic_read(); entries are
>    invalidated concurrently by setting tb to NULL.
> - Only alpha has been measured. The other four targets that pass a PC are
>    built and boot-tested only.
>
> v3: Fold the fast path into tcg_gen_lookup_and_goto_ptr() instead of
>      adding tcg_gen_lookup_and_goto_ptr_inline() beside it (Richard). It
>      now takes the destination PC and the TB unconditionally, from all 38
>      call sites, and picks the probe or the helper itself. Translators
>      built for both values of TARGET_LONG_BITS -- arm, s390x, microblaze --
>      cannot include tcg-op.h, so the common entry point takes a TCGTemp and
>      reads the width from it, and tcg-op.h wraps that for everyone else;
>      this is the same split as tcg_gen_qemu_ld_*_chk().
>
>      Compare cs_base too. v2 listed this as an open issue, and closing it
>      is what lets the choice be made generically rather than per target: a
>      target that uses cs_base would otherwise have been enabled silently by
>      a decision keyed on PC width alone. It costs a load and a compare on
>      the fast path, and the numbers above were measured with it in place.
>
>      Audited which targets may pass a real PC, the contract being that it
>      is exactly what get_tb_cpu_state() reports for the destination. Five
>      do; the rest pass NULL and keep the helper call, sparc among them
>      because it puts npc in cs_base and so could essentially never hit.
>
>      Poison the probe from cpu_breakpoint_insert() rather than only from
>      the poisoned CPU's own main loop. gdb inserts a breakpoint into every
>      CPU (tcg_insert_gdbstub_breakpoint()), and a thread already inside
>      generated code, dispatching indirectly, need never return to the main
>      loop -- so it would keep dispatching inline and run past a breakpoint
>      another thread had just set. Upstream has no such window: its
>      helper_lookup_tb_ptr() sees the new breakpoint at the next indirect
>      branch. The un-poison in tcg_cpu_sync_jmp_cache() now re-checks after
>      its store, with a barrier, so that it loses the race with a concurrent
>      insert in the safe direction.
>
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>   accel/tcg/cpu-exec.c                          | 102 ++++++++++++++++++
>   accel/tcg/internal-common.h                   |   2 +
>   cpu-common.c                                  |  11 ++
>   include/hw/core/cpu.h                         |   9 ++
>   include/system/tcg.h                          |   9 ++
>   include/tcg/tcg-op-common.h                   |  16 ++-
>   include/tcg/tcg-op.h                          |  12 +++
>   stubs/tcg-cflags.c                            |   8 +-
>   target/alpha/translate.c                      |   4 +-
>   target/arm/tcg/translate-a64.c                |   4 +-
>   target/arm/tcg/translate.c                    |  10 +-
>   target/avr/translate.c                        |   4 +-
>   target/hexagon/translate.c                    |   4 +-
>   target/hppa/translate.c                       |   6 +-
>   target/i386/tcg/translate.c                   |   2 +-
>   .../tcg/insn_trans/trans_branch.c.inc         |   2 +-
>   target/loongarch/tcg/translate.c              |   4 +-
>   target/m68k/translate.c                       |   2 +-
>   target/microblaze/translate.c                 |   4 +-
>   target/mips/tcg/nanomips_translate.c.inc      |   2 +-
>   target/mips/tcg/translate.c                   |   6 +-
>   target/or1k/translate.c                       |   4 +-
>   target/ppc/translate.c                        |   4 +-
>   target/riscv/tcg/insn_trans/trans_rvzce.c.inc |   4 +-
>   target/riscv/tcg/translate.c                  |   2 +-
>   target/rx/translate.c                         |   4 +-
>   target/s390x/tcg/translate.c                  |   5 +-
>   target/sh4/translate.c                        |   4 +-
>   target/sparc/translate.c                      |   4 +-
>   target/tricore/translate.c                    |   4 +-
>   tcg/tcg-op.c                                  |  92 +++++++++++++++-
>   31 files changed, 300 insertions(+), 50 deletions(-)
>
> diff --git ./accel/tcg/cpu-exec.c ./accel/tcg/cpu-exec.c
> index 148e0f583e..e546f717e8 100644
> --- ./accel/tcg/cpu-exec.c
> +++ ./accel/tcg/cpu-exec.c
> @@ -752,6 +752,99 @@ static inline bool cpu_handle_exception(CPUState *cpu, int *ret)
>       return false;
>   }
>   
> +/*
> + * The inline jump cache probe reads cpu->tb_jmp_cache_probe and takes the
> + * slow path when the entry it finds has a NULL tb.  Pointing the probe at a
> + * region that is all zeroes therefore forces every indirect dispatch into
> + * helper_lookup_tb_ptr(), which does the full lookup the inline probe only
> + * approximates.  The real jump cache is untouched, so no contents are lost
> + * and recovery is a single store.
> + *
> + * Only ever read from, and only the tb field of one entry per dispatch, so
> + * one shared zero-filled cache is enough for every CPU.
> + */
> +static const CPUJumpCache *tb_jmp_cache_poison(void)
> +{
> +    static CPUJumpCache *poison;
> +
> +    if (unlikely(poison == NULL)) {
> +        /* Raced allocations are harmless: both are all zeroes. */
> +        qatomic_cmpxchg(&poison, NULL, g_new0(CPUJumpCache, 1));
> +    }
> +    return poison;
> +}

Why allocate a jump cache at runtime?  Surely this would simply be a 
block of 0's in .rodata with

   static const CPUJumpCache poison;

I think this needs to be split into many pieces.  In particular:

(1) API change for tcg_gen_lookup_and_goto_ptr.

(2) Introduce tb_jmp_cache_probe, and the poisoning.

(3) Implementation of gen_jmp_cache_probe.

> @@ -28,6 +28,8 @@
>   #include "tcg/tcg-op-common.h"
>   #include "exec/translation-block.h"
>   #include "exec/plugin-gen.h"
> +#include "hw/core/cpu.h"
> +#include "../accel/tcg/tb-jmp-cache.h"
>   #include "tcg-internal.h"
>   #include "tcg-has.h"
>   
> @@ -2715,7 +2717,81 @@ void tcg_gen_goto_tb(unsigned idx)
>       tcg_gen_op1i(INDEX_op_goto_tb, 0, idx);
>   }
>   
> -void tcg_gen_lookup_and_goto_ptr(void)
> +static void gen_jmp_cache_probe(TCGv_i64 pc, const TranslationBlock *tb)
> +{
> +    TCGv_ptr jc, ent, tbp, ptr;
> +    TCGv_i64 h, tmp;
> +    TCGLabel *slow;
> +    uint64_t fpair;
> +
> +    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) != 16);
> +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=
> +                      offsetof(TranslationBlock, flags) + 4);
> +
> +    jc = tcg_temp_ebb_new_ptr();
> +    ent = tcg_temp_ebb_new_ptr();
> +    tbp = tcg_temp_ebb_new_ptr();
> +    ptr = tcg_temp_ebb_new_ptr();
> +    h = tcg_temp_ebb_new_i64();
> +    tmp = tcg_temp_ebb_new_i64();
> +    slow = gen_new_label();
> +
> +    /* h = tb_jmp_cache_hash_func(pc) * sizeof(array[0]) */
> +    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
> +    tcg_gen_xor_i64(h, h, pc);
> +    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
> +    tcg_gen_shli_i64(h, h, 4);

This hash function varies between system and user mode.

> +
> +    /*
> +     * Not cpu->tb_jmp_cache: the probe reads its own base so that the main
> +     * loop can poison it, which is how conditions the probe cannot test for
> +     * itself force every dispatch back into the helper.  See
> +     * tcg_cpu_sync_jmp_cache().
> +     */
> +    tcg_gen_ld_ptr(jc, tcg_env,
> +                   offsetof(CPUState, tb_jmp_cache_probe) - sizeof(CPUState));
> +    tcg_gen_trunc_i64_ptr(ent, h);
> +    tcg_gen_add_ptr(ent, jc, ent);
> +
> +    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
> +    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
> +
> +    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
> +    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);

I think you can test pc first as on hash miss, that's most likely to differ.


> +
> +    /*
> +     * flags and cflags are adjacent uint32_t, so one aligned 64-bit load
> +     * and compare covers both.
> +     */
> +#if HOST_BIG_ENDIAN
> +    fpair = ((uint64_t)tb->flags << 32) | tb->cflags;
> +#else
> +    fpair = ((uint64_t)tb->cflags << 32) | tb->flags;
> +#endif
> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);

I'm not keen on this without an additional _Static_assert that the 
offset is aligned.  It happens to be right now, but we're not currently 
relying on that.  :-)


> +
> +    /*
> +     * The destination must have been translated with the same cs_base, which
> +     * the pc alone does not imply on a target that uses it.
> +     */
> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, cs_base));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, tb->cs_base, slow);

The comment here should be more generic.  Despite the cs_base name, 
consider this target-specific tb->flags2.

> @@ -2724,7 +2800,21 @@ void tcg_gen_lookup_and_goto_ptr(void)
>           return;
>       }
>   
> +    /*
> +     * No icount_decr poll is needed for this exit: the helper is called on
> +     * every dispatch and returns to the main loop while an exit is pending.
> +     */
>       plugin_gen_disable_mem_helpers();
> +
> +    /*
> +     * The inline probe hashes and compares the pc as a single 64-bit value.
> +     * A target with a 32-bit guest PC keeps the helper call.
> +     */
> +    if (pc && pc->type == TCG_TYPE_I64) {
> +        gen_jmp_cache_probe(temp_tcgv_i64(pc), tb);
> +        return;
> +    }

Just extend, clearly.


r~


