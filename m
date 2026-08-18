Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F52C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 22:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwSHE-0002aV-Fp; Tue, 18 Aug 2026 18:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwSHC-0002Zh-FN
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:27:22 -0400
Received: from st-2005f-snip6-11.eps.apple.com ([2a01:b747:3001:202::3d]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwSHA-00076o-58
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 18:27:22 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPS id
 81EEA18000AF; Tue, 18 Aug 2026 22:27:16 +0000 (UTC)
X-ICL-RepId: 01a016fc-6b62-7541-847a-80f07c6a80c8
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0AWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkAPTARYdlgBXQo5cFsaX3ZFAVULXnNYH0AITwUpB1MKQHxKAy1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787092038; x=1789684038;
 bh=nmEDMEHXhanDlQRjAfE0+Y1NOxj+UfXwkAZXh5ldDNI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=stmgm1pgKDEeNEaxmcBTIqTp6D5PyojQZAmmsPTeImAA1/C7sbLD9YHqraQDdEodMrNQZp1TLnsRE+NSAgaQvGcBdySIQ3EbCDx9HokQlDXjqiUzJ73knWBLEyf0S0VViLgBkNSe0nvhe2vB648LREEG6+Dl8DyZhdF2JWKfJazi+NCfpB9suP6kqeKMPaFd8rs83kEpHuT68Pk4y02WgMMUcgN8zrXLB5lk0xQUv9yynDVXff16dzVPyCtB7kfv77mZ+sF+12gj478+a2G3MVulfG3Hpgz9Rsg73ch1LpUJEkO9lfOR5OHpF8bGDA47WMbfXV+mlSkvEUv2l1quQQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-10-percent-0 (Postfix) with ESMTPSA id
 85D901800293; Tue, 18 Aug 2026 22:26:59 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH 4/8] RFC: tcg: probe the TB jump cache inline instead of
 calling a helper
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260818174247.649526-5-mattst88@gmail.com>
Date: Wed, 19 Aug 2026 00:26:35 +0200
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com,
 philmd@mailo.com, zhao1.liu@intel.com, laurent@vivier.eu, deller@gmx.de,
 pierrick.bouvier@oss.qualcomm.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <06475A33-3AC6-4D58-83D3-0176D0880E20@unpredictable.fr>
References: <20260818174247.649526-1-mattst88@gmail.com>
 <20260818174247.649526-5-mattst88@gmail.com>
To: Matt Turner <mattst88@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Proofpoint-ORIG-GUID: oBnyUoMA3wX0rT_WnHTntA6xnYtUaYH-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE2NSBTYWx0ZWRfX3y4H3/zbgQFP
 vS3NaAMpAwcFozTbC3nfgPZdbOx908jRjgSVz+h1ms8BllqOmgRXdPH4elzxwQzpJYd+fZ8BS09
 hvK7JmdvAScdDpzHQLIEKbbUJFc4Ff+VlrWU9HDTMx/kieOyKu7QY1h46hlB+vhgnt5qWxsGFnW
 1WE0qiTL5oi1RtC61NAZi8+SZ/jHAQKeyIxtD+hku2eOSo6EjPTl/9GeW/xUU1sAqkYPL6G9BkX
 sthoF7bEVeWJ/RwZ0cZSTboTYtC098hPXqpOzEEJwI1YdlZkUp4ttrEQizF7YaLzR2L8lwrHafY
 CW4cc06za6/3WUOd2I9TNk5+aEnL9Dic7e4F4KIYdXWFSkBj1yIk6Fmkc4BEmc=
X-Proofpoint-GUID: oBnyUoMA3wX0rT_WnHTntA6xnYtUaYH-
X-Authority-Info-Out: v=2.4 cv=XfOEDY55 c=1 sm=1 tr=0 ts=6a84dc45
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=kMGlg0-6h2fWJJ9VV7cA:9
 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABZ2m9XQqWJekkjYiHzCgZvn2nl6Mh6f5BOx0/WWelrT5cQRpbyeh40IFXZVudfWmhS75zt0AA0Ld3E6+e8GCqlZ+TgQJ7WzCXZ9jqw19OUEo9sVoZ3hdEiVsbO4UgOsWK7SiTl9Jw1v42IHkeOYv3Y2ZcZ6KrTMLzdlUt6vjCsqEM8te08zlDvhzifP0rmcyonQSGh6loaESHMSbvbCguzqNBplq7pZ9eK1qUAvRc6kEGtEjOVTQaxU367+xwK+0u5X3Gvljd52FAScCqMbDTij+7iTdB4N7xChQ2VBUvETYfYknEDqAts+RYNFGOPtRGQsZOM/ZxwgFf06AKbVcpIisqn8GzoMX+Uk5Wy4E8WAm0tT9bGs/Rhi1b9j47Pl2pp3QlEUYeu6CyVyEiownyAnQr3zJ+iiJGVSLdR4m6MJUrP+1P8+LHspAkhL9S2Fapzh1pUl40mbBVdb8z7VbzIoYrMhCMjTir+/tI52BklIX3wKopIXiy7EIX0BZacDbv2fqV/hZIyZ1MzdAqh0HLVsfRsHQzkQ8CY1CQlikfq3l961Olym7ag8dTis9xTsqlvT2VpZg5/46fpnihgnIPtdzzkGHAk5/anRc1zOXek35czhpTc8hKQvieihQqNgBJ3m/iIHo1uSgEzHGQTf8UR2MMzghI+8NO06jzWwsSOK/20ZktUm4fO5+22wupvLAYQiVgeQ332QmmtmMgb+KypvUcpmRGMVLokxH5KUaZO5JWpXPUwiNO3e4qo/ryNrLZuB4HQQ0+UG9xsYQ1qo8HkRn25hBt+/73Dxhuj2Y1DSozjXO4RS6GgXO4HrequYtIKtmtzxv686Nbjof7LKc4ws5GJCMcJwUSe6AznZ+W9qqkCpv1j7q90qj+g3BawoRNhwXgQsSZVDEnAzppLcbslI7bWZS6Zx9SxoBvNulsqe+Z+9DmOvnQRxKZb5Odj7FMde9TfOpQ7/IDa1+EkeuBh0M
 e8h01lCzOQkRrSpXyFxPKO29mcweW7MbPHDbjdATO2Ww0b5uJKbJ5VNlQy57fl0c807WAeb1lZkzkYk8/qilS3lsi1B0RQPDUG93YNaO3ZC24y1wcjtch36GCaZRA5mMJ7rb8TStEOrTSDoNqFUXLzweI7WFIvhB55KmWxWjOKB9muNdPDeWmc9UohA4MHHLrcoHjrBYuok7uUYCMEnVSBW42Jx4L3/mh2uCfnRTB9BTF/c9kagSbUXjTzYSfCC9Z+NLN+T/MYd9rVs6ROcZTfKBXZCZ5M75xtIyQ4a1TpUEaGtT6/L2MIU5G9GmkoLjvhG25pacVKeOPSQV2uyePBffKsH11zcUIdomEH5eeGR9OAqsB5CVdWR56GdziXS8Tj1ZLPUAYiI1SLZLZKocBx5vS7pOX8v4OJHHsaIHC7kcD2/8zoUU5/KMsyfE+igFOXztnokjuxIaJ4v/CMUV4BB9wAoP5tZHhyhhKubLsXXK8b2ncrFjTD4KdqBNAJH7EMGysko6bvrB+ftCTIgQCXkEFQw66PQ==
Received-SPF: pass client-ip=2a01:b747:3001:202::3d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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



> On 18. Aug 2026, at 19:42, Matt Turner <mattst88@gmail.com> wrote:
>=20
> Every indirect branch that cannot use goto_tb ends in
> tcg_gen_lookup_and_goto_ptr(), which calls helper_lookup_tb_ptr(). For =
an
> emulated compiler that is 8.4 billion helper calls in a single =
translation
> unit: 24.6% of all TB exits take this path, because jsr/ret/jmp have a
> register destination and because goto_tb is restricted to same-page
> targets.

Hi,

In your testing set, how many of those indirect branches were returns?

I=E2=80=99ve been (very slowly...) hacking on something adjacent for =
being able=20
to leverage hardware return stacks, although it showed an exceedingly =
large
amount of issues - especially around the maintaining coherency edge =
cases...

Your patch gets a lot of the way there on the perf side without a number
of the issues associated with that.

>=20
> The helper itself is already tight, but each call pays for a call =
frame,
> the can_do_io store, the get_tb_cpu_state() indirect call through
> TCGCPUOps, curr_cflags(), and a breakpoint check, before it gets to =
the
> jump cache probe that almost always hits (95.8% for this workload).
>=20
> Emit the probe inline instead. The destination PC is already in a TCG
> temp, and the flags and cflags the destination must match are =
constants at
> translation time, so the fast path is a hash, three guarded loads and =
a
> goto_ptr. Only a miss calls the helper, which still owns filling the =
cache.
>=20
> Two details matter for the generated code. The flags and cflags guards =
are
> folded into a single aligned 64-bit load and compare, since the fields =
are
> adjacent. And each path emits its own goto_ptr rather than branching =
to a
> shared one: a temp live across the label is spilled and reloaded on =
every
> dispatch, which cost 6.3% on its own.
>=20
> Measured with qemu-alpha running an emulated alpha gcc 16.2.0 =
compiling
> the SQLite 3.45.1 amalgamation (255k lines, -O2) on an x86-64 host, =
LTO
> build, on top of the preceding three patches:
>=20
>    before: 1,402,816,253,499 instructions
>    after:    890,713,633,237 instructions   -36.51%
>=20
>    before: 115.75s wall clock
>    after:   84.44s wall clock               -27.05%
>=20
> The gap between the two is the point at which this stops being a
> straight-line win: the helper call was highly predictable work that =
the
> host pipelined well, so removing it retires far fewer instructions =
than it
> saves time. IPC falls from 2.48 to 2.15 across this patch for that =
reason.
>=20
> Despite emitting more code, this also reduces instruction cache =
pressure,
> because a dispatch no longer jumps into qemu's .text and evicts =
translated
> code:
>=20
>    before: 11,476,318,964 L1-icache-load-misses
>    after:   6,990,186,701 L1-icache-load-misses   -39.1%
>=20
> The mechanism is visible directly in a profile: helper_lookup_tb_ptr()
> falls from 30.97% of samples to 0.42%, and qemu's own .text falls from
> 38.9% to 5.4%, with the balance moving into generated code.
>=20
> Combined with the three preceding patches, against an unmodified LTO
> build, 1,647,901,588,726 instructions fall to 890,713,633,237, or =
-45.95%.
> The emulated compiler produces byte-identical output throughout.
>=20
> Open issues, hence RFC:
>=20
> - The flags/cflags guards use the *current* TB's values as constants. =
That
>  assumes the CPU flags feeding get_tb_cpu_state() cannot change within =
a
>  TB, and that curr_cflags() cannot change under a running TB (gdb
>  attaching to enable single-step would). Both need to be established =
or
>  the values need to be loaded at runtime.
> - tcg/tcg-op.c has no business including accel/tcg/tb-jmp-cache.h or
>  knowing the CPUJumpCache layout. The probe likely belongs in =
accel/tcg
>  with a small emit helper exported from tcg/.

I don=E2=80=99t think that one is a problem.
> - The jump cache entry is read without qatomic_read(); entries are
>  invalidated concurrently by setting tb to NULL.
> - Only wired up for alpha so far, and only for 64-bit guest PCs.
>=20
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
> include/tcg/tcg-op-common.h |  2 +
> target/alpha/translate.c    |  4 +-
> tcg/tcg-op.c                | 79 +++++++++++++++++++++++++++++++++++++
> 3 files changed, 83 insertions(+), 2 deletions(-)
>=20
> diff --git ./include/tcg/tcg-op-common.h ./include/tcg/tcg-op-common.h
> index 1fe342db0d..65084c38b9 100644
> --- ./include/tcg/tcg-op-common.h
> +++ ./include/tcg/tcg-op-common.h
> @@ -84,6 +84,8 @@ void tcg_gen_goto_tb(unsigned idx);
>  * this op is equivalent to calling tcg_gen_exit_tb() with 0 as the =
argument.
>  */
> void tcg_gen_lookup_and_goto_ptr(void);
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
> +                                        const TranslationBlock *tb);
>=20
> void tcg_gen_plugin_cb(unsigned from);
> void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
> diff --git ./target/alpha/translate.c ./target/alpha/translate.c
> index c66e3f9c14..939170a28b 100644
> --- ./target/alpha/translate.c
> +++ ./target/alpha/translate.c
> @@ -449,7 +449,7 @@ static void gen_goto_tb(DisasContext *ctx, =
unsigned tb_slot_idx, int32_t disp)
>         tcg_gen_exit_tb(ctx->base.tb, tb_slot_idx);
>     } else {
>         gen_pc_disp(ctx, cpu_pc, disp);
> -        tcg_gen_lookup_and_goto_ptr();
> +        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
>     }
> }
>=20
> @@ -2917,7 +2917,7 @@ static void alpha_tr_tb_stop(DisasContextBase =
*dcbase, CPUState *cpu)
>         gen_pc_disp(ctx, cpu_pc, 0);
>         /* FALLTHRU */
>     case DISAS_PC_UPDATED:
> -        tcg_gen_lookup_and_goto_ptr();
> +        tcg_gen_lookup_and_goto_ptr_inline(cpu_pc, ctx->base.tb);
>         break;
>     case DISAS_PC_UPDATED_NOCHAIN:
>         tcg_gen_exit_tb(NULL, 0);
> diff --git ./tcg/tcg-op.c ./tcg/tcg-op.c
> index bbcb510c76..ab8d101871 100644
> --- ./tcg/tcg-op.c
> +++ ./tcg/tcg-op.c
> @@ -28,6 +28,8 @@
> #include "tcg/tcg-op-common.h"
> #include "exec/translation-block.h"
> #include "exec/plugin-gen.h"
> +#include "hw/core/cpu.h"
> +#include "../accel/tcg/tb-jmp-cache.h"
> #include "tcg-internal.h"
> #include "tcg-has.h"
>=20
> @@ -2620,3 +2622,80 @@ void tcg_gen_lookup_and_goto_ptr(void)
>     tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
>     tcg_temp_free_ptr(ptr);
> }
> +
> +/*
> + * As tcg_gen_lookup_and_goto_ptr(), but probe the TB jump cache =
inline
> + * instead of calling helper_lookup_tb_ptr() unconditionally.  @pc =
must
> + * hold the destination guest PC; @flags and @cflags are the values =
the
> + * destination TB must have been translated with.
> + */
> +void tcg_gen_lookup_and_goto_ptr_inline(TCGv_i64 pc,
> +                                        const TranslationBlock *tb)
> +{
> +    uint32_t flags =3D tb->flags;
> +    uint32_t cflags =3D tb->cflags;
> +    TCGv_ptr jc, ent, tbp, ptr;
> +    TCGv_i64 h, tmp;
> +    TCGLabel *slow;
> +    uint64_t fpair;
> +
> +    if (tcg_ctx->gen_tb->cflags & CF_NO_GOTO_PTR) {
> +        tcg_gen_exit_tb(NULL, 0);
> +        return;
> +    }
> +
> +    plugin_gen_disable_mem_helpers();
> +
> +    QEMU_BUILD_BUG_ON(sizeof(((CPUJumpCache *)0)->array[0]) !=3D 16);
> +    QEMU_BUILD_BUG_ON(offsetof(TranslationBlock, cflags) !=3D
> +                      offsetof(TranslationBlock, flags) + 4);
> +
> +    jc =3D tcg_temp_ebb_new_ptr();
> +    ent =3D tcg_temp_ebb_new_ptr();
> +    tbp =3D tcg_temp_ebb_new_ptr();
> +    ptr =3D tcg_temp_ebb_new_ptr();
> +    h =3D tcg_temp_ebb_new_i64();
> +    tmp =3D tcg_temp_ebb_new_i64();
> +    slow =3D gen_new_label();
> +
> +    /* h =3D tb_jmp_cache_hash_func(pc) * sizeof(array[0]) */
> +    tcg_gen_shri_i64(h, pc, TB_JMP_CACHE_BITS);
> +    tcg_gen_xor_i64(h, h, pc);
> +    tcg_gen_andi_i64(h, h, TB_JMP_CACHE_SIZE - 1);
> +    tcg_gen_shli_i64(h, h, 4);
> +
> +    tcg_gen_ld_ptr(jc, tcg_env,
> +                   offsetof(CPUState, tb_jmp_cache) - =
sizeof(CPUState));
> +    tcg_gen_trunc_i64_ptr(ent, h);
> +    tcg_gen_add_ptr(ent, jc, ent);
> +
> +    tcg_gen_ld_ptr(tbp, ent, offsetof(CPUJumpCache, array[0].tb));
> +    tcg_gen_brcondi_ptr(TCG_COND_EQ, tbp, 0, slow);
> +
> +    tcg_gen_ld_i64(tmp, ent, offsetof(CPUJumpCache, array[0].pc));
> +    tcg_gen_brcond_i64(TCG_COND_NE, tmp, pc, slow);
> +
> +    /*
> +     * flags and cflags are adjacent uint32_t, so one aligned 64-bit =
load
> +     * and compare covers both.
> +     */
> +#if HOST_BIG_ENDIAN
> +    fpair =3D ((uint64_t)flags << 32) | cflags;
> +#else
> +    fpair =3D ((uint64_t)cflags << 32) | flags;
> +#endif
> +    tcg_gen_ld_i64(tmp, tbp, offsetof(TranslationBlock, flags));
> +    tcg_gen_brcondi_i64(TCG_COND_NE, tmp, fpair, slow);
> +
> +    tcg_gen_ld_ptr(ptr, tbp, offsetof(TranslationBlock, tc.ptr));
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +
> +    /*
> +     * Emit a second goto_ptr rather than branching to a shared one: =
a temp
> +     * live across the label would be spilled and reloaded on every =
dispatch.
> +     */
> +    gen_set_label(slow);
> +    ptr =3D tcg_temp_ebb_new_ptr();
> +    gen_helper_lookup_tb_ptr(ptr, tcg_env);
> +    tcg_gen_op1i(INDEX_op_goto_ptr, TCG_TYPE_PTR, tcgv_ptr_arg(ptr));
> +}
> --=20
> 2.54.0
>=20
>=20


