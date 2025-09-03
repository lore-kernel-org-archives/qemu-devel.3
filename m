Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7720DCA1007
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 03:00:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utdiD-00073q-0P; Tue, 02 Sep 2025 22:59:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1utdiB-00073I-9E; Tue, 02 Sep 2025 22:59:03 -0400
Received: from [115.124.28.43] (helo=out28-43.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1utdi7-0005XG-Vm; Tue, 02 Sep 2025 22:59:03 -0400
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.eW9AML6_1756868077 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 03 Sep 2025 10:54:38 +0800
Message-ID: <fca82a32-6ccd-4177-9923-45a8c3d63bb6@zevorn.cn>
Date: Wed, 3 Sep 2025 10:54:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] target/riscv: Generate strided vector ld/st with
 tcg
To: Nicholas Piggin <npiggin@gmail.com>
Cc: richard.henderson@linaro.org, paolo.savini@embecosm.com,
 ebiggers@kernel.org, dbarboza@ventanamicro.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <cover.1755609029.git.chao.liu@zevorn.cn>
 <6bqmz4ejwvp4vaj2vve7scqwsvrnjzm657htie7xcvciy54gw6@nbz6hvbombui>
From: "Zevorn(Chao Liu)" <chao.liu@zevorn.cn>
In-Reply-To: <6bqmz4ejwvp4vaj2vve7scqwsvrnjzm657htie7xcvciy54gw6@nbz6hvbombui>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.28.43 (deferred)
Received-SPF: pass client-ip=115.124.28.43; envelope-from=chao.liu@zevorn.cn;
 helo=out28-43.mail.aliyun.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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

On 2025/9/3 10:21, Nicholas Piggin wrote:
> On Tue, Aug 19, 2025 at 09:23:38PM +0800, Chao Liu wrote:
>> Hi all,
>>
>> In this patch (v5), I've removed the redundant call to mark_vs_dirty(s)
>> within the gen_ldst_stride_main_loop() function.
>>
>> The reason for this change is that mark_vs_dirty(s) is already being called
>> at a higher level, making the call inside gen_ldst_stride_main_loop()
>> unnecessary.
> 
> Hey, nice patch. Do you have any performance numbers?
> 

Thanks! Please modify my test case patch according to the following code. You
can perform a simple performance test:

```
enable_rvv:
	li	x15, 0x800000000024112d
	csrw	0x301, x15
	li	x1, 0x2200
	csrr	x2, mstatus
	or	x2, x2, x1
	csrw	mstatus, x2

rvv_test_func:
	vsetivli	zero, 1, e32, m1, ta, ma
	li	t0, 64  # copy 64 byte
copy_start:
	li	t2, 0
	li	t3, 10000000 # loop number： 10,000,000
copy_loop:
	# when t2 >= t3, copy end
	bge	 t2, t3, copy_done
	la	a0, source_data  # source_data
	li	a1, 0x80020000   # dest_data

	vlsseg8e32.v	v0, (a0), t0
	addi	a0, a0, 32
	vlsseg8e32.v	v8, (a0), t0

	vssseg8e32.v	v0, (a1), t0
	addi	a1, a1, 32
	vssseg8e32.v	v8, (a1), t0
	addi	t2, t2, 1
	j	copy_loop

copy_done:
	nop
```

Comparing it with the helper version. I tested it and observed a 25x performance
improvement.

> I hit a problem with this being unable to deal with restarts. You left
> the existing heleprs in there that can deal with vstart != 0, so I guess
> you intended it to fall back, but it's not quite wired up right.
> 
> I tried adding that in and it seems to work. Also made a little
> adjustment to your test case if you wouldn't mind changing that too.
> 
> I have a tcg test for interrupted vector memory operations that caught
> this bug, I will submit it soon and cc you on it.
> 
> Thanks,
> Nick
> 
> [PATCH] target/riscv: Fix "Generate strided vector ld/st with tcg"
> 
> If a strided vector memory access instruction has non-zero
> vstart, fall back to the helper functions rather than causing
> an illegal instruction trap. The vlse/vsse helpers were dead
> code before this.
> 
> An implementation is permitted to cause an illegal instruction
> if vstart is not 0 and it is set to a value that can not be
> produced implicitly by the implementation, but memory accesses
> will generally always need to deal with page faults.
> 
> This also adjusts the tcg test Makefile change to specify the
> cpu type on a per-test basis, because I have another test that
> needs different CPU options, and that gets broken if you
> change it this way.
> 
> [ feel free to take changes or parts of the changelog and adjust
> / merge them into your patches ]
> 

Thanks for the review. The primary author of this performance optimization patch
is Paolo. I will incorporate your changes and cc Paolo.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/riscv/insn_trans/trans_rvv.c.inc   | 37 ++++++++++++++++++++---
>  tests/tcg/riscv64/Makefile.softmmu-target |  3 +-
>  2 files changed, 35 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 5e200249ef..439ea0edcf 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -1090,11 +1090,30 @@ static void gen_ldst_stride_tail_loop(DisasContext *s, TCGv dest, uint32_t nf,
>      return;
>  }
>  
> +typedef void gen_helper_ldst_stride(TCGv_ptr, TCGv_ptr, TCGv,
> +                                    TCGv, TCGv_env, TCGv_i32);
> +
>  static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
> -                              uint32_t data, DisasContext *s, bool is_load)
> +                              uint32_t data, gen_helper_ldst_stride *fn,
> +                              DisasContext *s, bool is_load)
>  {
>      if (!s->vstart_eq_zero) {
> -        return false;
> +        TCGv_ptr dest, mask;
> +        TCGv base, stride;
> +        TCGv_i32 desc;
> +
> +        dest = tcg_temp_new_ptr();
> +        mask = tcg_temp_new_ptr();
> +        base = get_gpr(s, rs1, EXT_NONE);
> +        stride = get_gpr(s, rs2, EXT_NONE);
> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
> +                                          s->cfg_ptr->vlenb, data));
> +
> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
> +        tcg_gen_addi_ptr(mask, tcg_env, vreg_ofs(s, 0));
> +        mark_vs_dirty(s);
> +        fn(dest, mask, base, stride, tcg_env, desc);
> +        return true;
>      }
>  
>      TCGv dest = tcg_temp_new();
> @@ -1146,6 +1165,16 @@ static bool ldst_stride_trans(uint32_t vd, uint32_t rs1, uint32_t rs2,
>  static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>  {
>      uint32_t data = 0;
> +    gen_helper_ldst_stride *fn;
> +    static gen_helper_ldst_stride *const fns[4] = {
> +        gen_helper_vlse8_v, gen_helper_vlse16_v,
> +        gen_helper_vlse32_v, gen_helper_vlse64_v
> +    };
> +
> +    fn = fns[eew];
> +    if (fn == NULL) {
> +        return false;
> +    }
>  
>      uint8_t emul = vext_get_emul(s, eew);
>      data = FIELD_DP32(data, VDATA, VM, a->vm);
> @@ -1153,7 +1182,7 @@ static bool ld_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
>      data = FIELD_DP32(data, VDATA, VTA, s->vta);
>      data = FIELD_DP32(data, VDATA, VMA, s->vma);
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, true);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, fn, s, true);
>  }
>  
>  static bool ld_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> @@ -1177,7 +1206,7 @@ static bool st_stride_op(DisasContext *s, arg_rnfvm *a, uint8_t eew)
>      data = FIELD_DP32(data, VDATA, LMUL, emul);
>      data = FIELD_DP32(data, VDATA, NF, a->nf);
>  
> -    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, s, false);
> +    return ldst_stride_trans(a->rd, a->rs1, a->rs2, data, NULL, s, false);
>  }
>  
>  static bool st_stride_check(DisasContext *s, arg_rnfvm* a, uint8_t eew)
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv64/Makefile.softmmu-target
> index f09f1a57c4..d9f067dbd4 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -14,7 +14,7 @@ CFLAGS += -march=rv64gcv -mabi=lp64d -g -Og
>  %: %.o $(LINK_SCRIPT)
>  	$(LD) $(LDFLAGS) $< -o $@
>  
> -QEMU_OPTS += -M virt -cpu rv64,v=true -display none -semihosting -device loader,file=
> +QEMU_OPTS += -M virt -display none -semihosting -device loader,file=
>  
>  EXTRA_RUNS += run-issue1060
>  run-issue1060: issue1060
> @@ -30,6 +30,7 @@ run-misa-ialign: misa-ialign
>  	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>  
>  EXTRA_RUNS += run-vlsseg8e32
> +run-vlsseg8e32: QEMU_OPTS := -cpu rv64,v=true $(QEMU_OPTS)
>  run-vlsseg8e32: test-vlsseg8e32
>  	$(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
>  

nice improvement~

Thanks,
Chao

