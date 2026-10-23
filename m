Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D1D606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=rev.ng header.i=@rev.ng header.a=rsa-sha256 header.s=dkim header.b=H/CRp3g1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBFc-0000sX-QG; Fri, 23 Oct 2026 05:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xKBFQ-0000m4-6t; Fri, 23 Oct 2026 05:07:37 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xKBFN-00056B-QO; Fri, 23 Oct 2026 05:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=lzUewjDsQvaKWJgcroY2kkG9ol5RMQOmdeAYzWj3LW0=; b=H/CRp3g1lHwNPSy
 xKisje04bi1cBLFGT+G4mAc466u1DCftIDLVmkA4ocPbIquVgbD2O9NywPhDY0pp2NkxWLx5r48EP
 xZRFzWqzvkabotTTeHOHf4oLmc3QMqGrionKkAuOHwQCSo7PLt/8RE4F9xViIc7b07YzT7hTduBjp
 yQ=;
Date: Fri, 23 Oct 2026 11:13:00 +0200
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-riscv@nongnu.org,
 palmer@dabbelt.com, 
 alistair.francis@wdc.com, daniel.barboza@oss.qualcomm.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com
Subject: Re: [PATCH] target/riscv: Fix CPU state access on big-endian hosts
Message-ID: <atsk3ZY1FinfijlC@hive.localdomain>
References: <20261022130657.6449-1-anjo@rev.ng>
 <3d9baf66-d412-439a-b9db-099124af6625@oss.qualcomm.com>
 <8299629b-7033-485c-8204-521e14e2f1d8@oss.qualcomm.com>
 <a7eb7b51-55ec-49e4-a4cc-209c41236c91@oss.qualcomm.com>
 <ee2dfd4c-b3aa-4157-a918-560895048422@oss.qualcomm.com>
 <fd74aa6b-9724-40a5-8a6a-54d7927307f8@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd74aa6b-9724-40a5-8a6a-54d7927307f8@oss.qualcomm.com>
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 23/10/26, Philippe Mathieu-Daudé wrote:
> On 23/10/26 10:10, Philippe Mathieu-DaudÃ© wrote:
> > On 23/10/26 10:07, Philippe Mathieu-DaudÃ© wrote:
> > > On 23/10/26 09:53, Philippe Mathieu-DaudÃ© wrote:
> > > > On 23/10/26 09:37, Philippe Mathieu-DaudÃ© wrote:
> > > > > On 22/10/26 15:06, Anton Johansson via qemu development wrote:
> > > > > > mstatus and mstatus_hs are uint64_t but accessed through
> > > > > > 
> > > > > >    tcg_gen_[ld|st]_tl(..., offsetof(mstatus))
> > > > > > 
> > > > > > which on a big-endian host running riscv32 incorrectly accesses the
> > > > > > top 32 bits rather than the lower bits.
> > > > > 
> > > > >    mstatus and mstatus_hs are uint64_t, but mark_fs_dirty() and
> > > > >    mark_vs_dirty() update them with tcg_gen_[ld|st]_tl().
> > > > >    On big-endian hosts with 32-bit target_ulong, this modifies
> > > > >    the upper half instead of the lower one, so the FS/VS dirty
> > > > >    bits are never set. Use 64-bit accesses instead.
> > > > > 
> > > > > Cc: qemu-stable@nongnu.org
> > > > > Fixes: 284d697c74e ("target/riscv: Merge m/vsstatus and
> > > > > m/vsstatush into one uint64_t unit")
> > > > > Fixes: 8e1ee1fb571 ("target/riscv: rvv-1.0: add
> > > > > translation-time vector context status")
> > > > > Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> > > > > 
> > > > > > Widen the operations to 64 bit so the lower bits are modified.
> > > > > > 
> > > > > > Signed-off-by: Anton Johansson <anjo@rev.ng>
> > > > > > ---
> > > > > >   target/riscv/tcg/translate.c | 32 ++++++++++++++++----------------
> > > > > >   1 file changed, 16 insertions(+), 16 deletions(-)
> > > > > > 
> > > > > > diff --git a/target/riscv/tcg/translate.c
> > > > > > b/target/riscv/tcg/ translate.c
> > > > > > index ede9c2563f..79b0f444ef 100644
> > > > > > --- a/target/riscv/tcg/translate.c
> > > > > > +++ b/target/riscv/tcg/translate.c
> > > > > > @@ -693,7 +693,7 @@ static TCGv
> > > > > > get_address_indexed(DisasContext *ctx, int rs1, TCGv
> > > > > > offs)
> > > > > >    */
> > > > > >   static void mark_fs_dirty(DisasContext *ctx)
> > > > > >   {
> > > > > > -    TCGv tmp;
> > > > > > +    TCGv_i64 tmp;
> > > > > >       if (!has_ext(ctx, RVF)) {
> > > > > >           return;
> > > > > > @@ -703,15 +703,15 @@ static void mark_fs_dirty(DisasContext *ctx)
> > > > > >           /* Remember the state change for the rest of the TB. */
> > > > > >           ctx->mstatus_fs = EXT_STATUS_DIRTY;
> > > > > > -        tmp = tcg_temp_new();
> > > > > > -        tcg_gen_ld_tl(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus));
> > > > > > -        tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> > > > > > -        tcg_gen_st_tl(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus));
> > > > > > +        tmp = tcg_temp_new_i64();
> > > > > > +        tcg_gen_ld_i64(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus));
> > > > > > +        tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> > > > > > +        tcg_gen_st_i64(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus));
> > > > > >           if (ctx->virt_enabled) {
> > > > > > -            tcg_gen_ld_tl(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus_hs));
> > > > > > -            tcg_gen_ori_tl(tmp, tmp, MSTATUS_FS);
> > > > > > -            tcg_gen_st_tl(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus_hs));
> > > > > > +            tcg_gen_ld_i64(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus_hs));
> > > > > > +            tcg_gen_ori_i64(tmp, tmp, MSTATUS_FS);
> > > > > > +            tcg_gen_st_i64(tmp, tcg_env,
> > > > > > offsetof(CPURISCVState, mstatus_hs));
> > > > > >           }
> > > > > >       }
> > > > > >   }
> > > > > 
> > > > > Wondering about being safe (or catching other bad uses)
> > > > > 
> > > > > #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
> > > > > #define TCG_ENV_SIZE_(f)    sizeof_field(CPUArchState, f)
> > > > > 
> > > > > #define tcg_gen_ld_env_tl(ret, f)                               \
> > > > >      do {                                                        \
> > > > >          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) !=                   \
> > > > >                            sizeof(target_ulong));                \
> > > > >          tcg_gen_ld_tl(ret, tcg_env, TCG_ENV_OFS_(f));           \
> > > > >      } while (0)
> > > > > 
> > > > > #define tcg_gen_ld_env_i64(ret, f)                              \
> > > > >      do {                                                        \
> > > > >          QEMU_BUILD_BUG_ON(TCG_ENV_SIZE_(f) != 8);               \
> > > > >          tcg_gen_ld_i64(ret, tcg_env, TCG_ENV_OFS_(f));          \
> > > > >      } while (0)
> > > > > 
> > > > > or even using _Generic:
> > > > > 
> > > > > #define TCG_ENV_FIELD_(f)   (((CPUArchState *)0)->f)
> > > > > #define TCG_ENV_OFS_(f)     offsetof(CPUArchState, f)
> > > > > 
> > > > > #define tcg_gen_st_env_i32(arg, f)                              \
> > > > >      _Generic(TCG_ENV_FIELD_(f),                                 \
> > > > >               bool:     tcg_gen_st8_i32,                         \
> > > > >               uint8_t:  tcg_gen_st8_i32,                         \
> > > > >               int8_t:   tcg_gen_st8_i32,                         \
> > > > >               uint16_t: tcg_gen_st16_i32,                        \
> > > > >               int16_t:  tcg_gen_st16_i32,                        \
> > > 
> > > Hmm tricky (dangerous?), this also change our current uses of
> > > target-long accesses to smaller fields. This is how I'd expect
> > > the uses but not always what we have now. For example, commit
> > > ebc9401a406 ("target/hppa: Split PSW X and B into their own
> > > field") reduced CPUHPPAState::psw from uint64_t to uint32_t,
> > > but both accessors -- trans_rsm() and trans_ssm() -- keep
> > > accessing with tcg_gen_ld_i64() instead of tcg_gen_ld32u_i64().
> > > Likely buggy wrt endianness.
> > 
> > Noticed because the coccinelle conversion now triggers:
> > 
> > ../target/hppa/translate.c:2367:5: error: controlling expression type
> > 'uint32_t' (aka 'unsigned int') not compatible with any generic
> > association type
> >   2367 |     tcg_gen_ld_env_i64(tmp, psw);
> >        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:30:14: note:
> > expanded from macro 'tcg_gen_ld_env_i64'
> >     30 |     _Generic(TCG_ENV_FIELD_(f),                                 \
> >        |              ^~~~~~~~~~~~~~~~~
> > /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note:
> > expanded from macro 'TCG_ENV_FIELD_'
> >     15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
> >        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > ../target/hppa/translate.c:2387:5: error: controlling expression type
> > 'uint32_t' (aka 'unsigned int') not compatible with any generic
> > association type
> >   2387 |     tcg_gen_ld_env_i64(tmp, psw);
> >        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:30:14: note:
> > expanded from macro 'tcg_gen_ld_env_i64'
> >     30 |     _Generic(TCG_ENV_FIELD_(f),                                 \
> >        |              ^~~~~~~~~~~~~~~~~
> > /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note:
> > expanded from macro 'TCG_ENV_FIELD_'
> >     15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
> >        |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 2 errors generated.
> > 
> > 
> 
> And using these macros on tcg_global_mem_*, another issue on Hexagon
> (slot_cancelled is u8 but registered to be accessed as u32):
> 
> FAILED: [code=1] libqemu-hexagon-softmmu.a.p/target_hexagon_translate.c.o
> ../target/hexagon/translate.c:1472:26: error: controlling expression type
> 'uint8_t' (aka 'unsigned char') not compatible with any generic association
> type
>  1472 |     hex_slot_cancelled = tcg_global_mem_new_env_tl(slot_cancelled,
>       |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  1473 | "slot_cancelled");
>       | ~~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:160:37: note:
> expanded from macro 'tcg_global_mem_new_env_tl'
>   160 | # define tcg_global_mem_new_env_tl  tcg_global_mem_new_env_i32
>       |                                     ^
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:52:14: note:
> expanded from macro 'tcg_global_mem_new_env_i32'
>    52 |     _Generic(TCG_ENV_FIELD_(f),                                 \
>       |              ^~~~~~~~~~~~~~~~~
> /Users/philmd/worktree/qemu/excp/include/tcg/tcg-op-env.h:15:29: note:
> expanded from macro 'TCG_ENV_FIELD_'
>    15 | #define TCG_ENV_FIELD_(f)   (((struct CPUArchState *)0)->f)
>       |                             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 error generated.
> 
> 

Ah this is nice, let's drop my patch and go for this instead IMO! :)

