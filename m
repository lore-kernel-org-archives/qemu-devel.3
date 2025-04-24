Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC46C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 12:46:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7vy1-0006dU-LL; Thu, 24 Apr 2025 08:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7vxm-0006b6-0p; Thu, 24 Apr 2025 08:46:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1u7vxh-0006KP-R0; Thu, 24 Apr 2025 08:45:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA0D655D236;
 Thu, 24 Apr 2025 14:45:46 +0200 (CEST)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id okHTfySDD_AI; Thu, 24 Apr 2025 14:45:44 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 665B955C592; Thu, 24 Apr 2025 14:45:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 64580745682;
 Thu, 24 Apr 2025 14:45:44 +0200 (CEST)
Date: Thu, 24 Apr 2025 14:45:44 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
cc: Nicholas Piggin <npiggin@gmail.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
In-Reply-To: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
Message-ID: <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Hello,

On Mon, 1 Jul 2024, BALATON Zoltan wrote:
> This is an RFC patch, not finished, just to show the idea and test
> this approach. I'm not sure it's correct but I'm sure it can be
> improved so comments are requested.

Last time I did not get any replies to this so I try again. Some people 
recently tried using passed through GPUs with qemu-system-ppc running 
AmigaOS again and while it works it was slower than expected. This was 
previosly found to maybe related to dcbz and accessing passed through PCI 
memory with 32 bit instead of 128 bit access. The dcbz opcode is also 
commonly used for clearing memory in MacOS so optimising it would make 
these run faster even without pass through. (This was explored with KVM 
here: 
https://www.talospace.com/2018/08/making-your-talos-ii-into-power-mac_29.html)

dcbz was improved with user emulation after my last try but system 
emulation is still affected. Results from the test case below now on QEMU 
master on the same host machine (accessing RAM not passed through VRAM 
same as previous tests below which also were to RAM):

qemu-ppc -cpu 7457:
byte loop: 2.22 sec
memcpy: 2.21 sec
copyToVRAMNoAltivec: 1.69 sec
copyToVRAMAltivec: 2.12 sec
copyFromVRAMNoAltivec: 2.24 sec
copyFromVRAMAltivec: 2.82 sec

qemu-system-ppc -machine pegasos2:
byte loop: 5.28 sec
memcpy: 5.06 sec
copyToVRAMNoAltivec: 2.52 sec
copyToVRAMAltivec: 2.66 sec
copyFromVRAMNoAltivec: 6.37 sec
copyFromVRAMAltivec: 6.84 sec

The qemu-system-ppc case is still very much not optimal. Is threre anybody 
who wants to give this a try or any recommendations on what to do? I think 
ideally maybe we should try to implement dcbz with TCG ops to avoid the 
helper and try to use vector ops so these may be translated to wider 128 
bit access ops on the host which is believed to be needed to for accessing 
VRAM to avoid overhead of the transfer that's why these used AltiVec on 
PPC. See original message below for more details.

Thank you,
BALATON Zoltan

> The test case I've used came out of a discussion about very slow
> access to VRAM of a graphics card passed through with vfio the reason
> for which is still not clear but it was already known that dcbz is
> often used by MacOS and AmigaOS for clearing memory and to avoid
> reading values about to be overwritten which is faster on real CPU but
> was found to be slower on QEMU. The optimised copy routines were
> posted here:
> https://www.amigans.net/modules/newbb/viewtopic.php?post_id=149123#forumpost149123
> and the rest of it I've written to make it a test case is here:
> http://zero.eik.bme.hu/~balaton/qemu/vramcopy.tar.xz
> Replace the body of has_altivec() with just "return false". Sorry for
> only giving pieces but the code posted above has a copyright that does
> not allow me to include it in the test. This is not measuring VRAM
> access now just memory copy but shows the effect of dcbz. I've got
> these results with this patch:
>
> Linux user master:                  Linux user patch:
> byte loop: 2.2 sec                  byte loop: 2.2 sec
> memcpy: 2.19 sec                    memcpy: 2.19 sec
> copyToVRAMNoAltivec: 1.7 sec        copyToVRAMNoAltivec: 1.71 sec
> copyToVRAMAltivec: 2.13 sec         copyToVRAMAltivec: 2.12 sec
> copyFromVRAMNoAltivec: 5.11 sec     copyFromVRAMNoAltivec: 2.79 sec
> copyFromVRAMAltivec: 5.87 sec       copyFromVRAMAltivec: 3.26 sec
>
> Linux system master:                Linux system patch:
> byte loop: 5.86 sec                 byte loop: 5.9 sec
> memcpy: 5.45 sec                    memcpy: 5.47 sec
> copyToVRAMNoAltivec: 2.51 sec       copyToVRAMNoAltivec: 2.53 sec
> copyToVRAMAltivec: 3.84 sec         copyToVRAMAltivec: 3.85 sec
> copyFromVRAMNoAltivec: 6.11 sec     copyFromVRAMNoAltivec: 3.92 sec
> copyFromVRAMAltivec: 7.22 sec       copyFromVRAMAltivec: 5.51 sec
>
> It could probably be further optimised with using vector instuctions
> (dcbz_size is between 32 and 128) or by eliminating the check left in
> the helper for 970 but I don't know how to do those. (Also the series
> that convert AltiVec to use 128 bit access may help but I haven't
> tested that, only trying to optimise dcbz here,)
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> target/ppc/helper.h     |  1 +
> target/ppc/mem_helper.c | 14 ++++++++++++++
> target/ppc/translate.c  | 34 ++++++++++++++++++++++++++++------
> 3 files changed, 43 insertions(+), 6 deletions(-)
>
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 76b8f25c77..e49681c25b 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -46,6 +46,7 @@ DEF_HELPER_FLAGS_3(stmw, TCG_CALL_NO_WG, void, env, tl, i32)
> DEF_HELPER_4(lsw, void, env, tl, i32, i32)
> DEF_HELPER_5(lswx, void, env, tl, i32, i32, i32)
> DEF_HELPER_FLAGS_4(stsw, TCG_CALL_NO_WG, void, env, tl, i32, i32)
> +DEF_HELPER_FLAGS_2(dcbz_size, TCG_CALL_NO_WG_SE, tl, env, i32)
> DEF_HELPER_FLAGS_3(dcbz, TCG_CALL_NO_WG, void, env, tl, i32)
> DEF_HELPER_FLAGS_3(dcbzep, TCG_CALL_NO_WG, void, env, tl, i32)
> DEF_HELPER_FLAGS_2(icbi, TCG_CALL_NO_WG, void, env, tl)
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index f88155ad45..b06cb2d00e 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -270,6 +270,20 @@ void helper_stsw(CPUPPCState *env, target_ulong addr, uint32_t nb,
>     }
> }
>
> +target_ulong helper_dcbz_size(CPUPPCState *env, uint32_t opcode)
> +{
> +    target_ulong dcbz_size = env->dcache_line_size;
> +
> +#if defined(TARGET_PPC64)
> +    /* Check for dcbz vs dcbzl on 970 */
> +    if (env->excp_model == POWERPC_EXCP_970 &&
> +        !(opcode & 0x00200000) && ((env->spr[SPR_970_HID5] >> 7) & 0x3) == 1) {
> +        dcbz_size = 32;
> +    }
> +#endif
> +    return dcbz_size;
> +}
> +
> static void dcbz_common(CPUPPCState *env, target_ulong addr,
>                         uint32_t opcode, bool epid, uintptr_t retaddr)
> {
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 0bc16d7251..49221b8303 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4445,14 +4445,36 @@ static void gen_dcblc(DisasContext *ctx)
> /* dcbz */
> static void gen_dcbz(DisasContext *ctx)
> {
> -    TCGv tcgv_addr;
> -    TCGv_i32 tcgv_op;
> +    TCGv addr, mask, dcbz_size, t0;
> +    TCGv_i32 op = tcg_constant_i32(ctx->opcode & 0x03FF000);
> +    TCGv_i64 z64 = tcg_constant_i64(0);
> +    TCGv_i128 z128 = tcg_temp_new_i128();
> +    TCGLabel *l;
> +
> +    addr = tcg_temp_new();
> +    mask = tcg_temp_new();
> +    dcbz_size = tcg_temp_new();
> +    t0 = tcg_temp_new();
> +    l = gen_new_label();
>
>     gen_set_access_type(ctx, ACCESS_CACHE);
> -    tcgv_addr = tcg_temp_new();
> -    tcgv_op = tcg_constant_i32(ctx->opcode & 0x03FF000);
> -    gen_addr_reg_index(ctx, tcgv_addr);
> -    gen_helper_dcbz(tcg_env, tcgv_addr, tcgv_op);
> +    gen_helper_dcbz_size(dcbz_size, tcg_env, op);
> +    tcg_gen_mov_tl(mask, dcbz_size);
> +    tcg_gen_subi_tl(mask, mask, 1);
> +    tcg_gen_not_tl(mask, mask);
> +    gen_addr_reg_index(ctx, addr);
> +    tcg_gen_and_tl(addr, addr, mask);
> +    tcg_gen_mov_tl(t0, cpu_reserve);
> +    tcg_gen_and_tl(t0, t0, mask);
> +    tcg_gen_movcond_tl(TCG_COND_EQ, cpu_reserve, addr, t0,
> +                       tcg_constant_tl(-1), cpu_reserve);
> +
> +    tcg_gen_concat_i64_i128(z128, z64, z64);
> +    gen_set_label(l);
> +    tcg_gen_qemu_st_i128(z128, addr, ctx->mem_idx, DEF_MEMOP(MO_128));
> +    tcg_gen_addi_tl(addr, addr, 16);
> +    tcg_gen_subi_tl(dcbz_size, dcbz_size, 16);
> +    tcg_gen_brcondi_tl(TCG_COND_GT, dcbz_size, 0, l);
> }
>
> /* dcbzep */
>

