Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68693C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 12:17:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taw7q-0000gC-Dx; Thu, 23 Jan 2025 07:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1taw7i-0000ff-TI
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:15:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.savini@embecosm.com>)
 id 1taw7d-0004EL-GF
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 07:15:50 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so9660545e9.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 04:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1737634543; x=1738239343; darn=nongnu.org;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5BNNoZ8dZeh84oFaiH1ZSUeor/nwzEhu3eb9+mACH6o=;
 b=I8VTb4q8ZijvfJS/Cl+mRCxcx7+whMlcQyAflL5z/QZ76Zl0B6C+Eej/fcGS2PNUUO
 nmeFkDITY/VNvDJXewFkaLQDSGWMmWDk8Dyp1qggAd4CNloLfV/5lQq8aRwYe74Glq+Z
 azeolIBH07t/GnJI2lWYy7VKtnqev5PKno8icP93Bk8zSq3V85H8ZypWOWkNC1UKIszQ
 XMS6LhxaNMdDx8eMXgtTRp3v4Ydn3+RuC+tXCbaM8V/qrTmVbme/goLGMxT70nlAVcCo
 0p7QYv/YUwOVqR2Gg8+xEQ/J2azBI2yjNVTgu++jtVuYDHazj2T0IFKNCsyKljmk4rla
 fQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737634543; x=1738239343;
 h=in-reply-to:subject:autocrypt:from:content-language:references:cc
 :to:user-agent:mime-version:date:message-id:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5BNNoZ8dZeh84oFaiH1ZSUeor/nwzEhu3eb9+mACH6o=;
 b=cu5CLKqSI0OBcT6kALDLmoFfhH4bnpZQ9GoN4G3xrK+TI5szR9NIWWoPxIbWk5GgaR
 Ve7d16q4fCuTF58V+DLsE8TW22sounR1J6ox3xMMhbD6b/fTSNXAsZRHfjKguJ9pjt8n
 I9eb9jRYne2QteScLeprOshxbnNv1MgnK/utdUofpvJrLVu+dglYDuFgVPfsB8h7UDmx
 3JPwq0iBKvgZLNvxHk37ynL6jLeV8WbdELEtmsRkAl9mM8dpVx9I+iXHdNPQdVpVPjpD
 f6DrdZjD5CfFEMoUQTQLKVA4VfkTxPgUB/p8fXqh6Unbv6o6FPQQQRuJ7G/YpsvKXg3u
 7l9A==
X-Gm-Message-State: AOJu0Yxnl617KzWen5AmpQ2nuBWOaIycSQGE5h+AVv9HylKHXLauXNt3
 QcQhSg2c701HgsrAs/orC47BYbIPyL8uQWaaxSUi+H8u0ucCvPHurCB2AVSY9q4=
X-Gm-Gg: ASbGncsr/QFUm3uFbXHtJMSrJM6J6vwVCYh+8kJmBZHNPPf87jHifaBqDCRDkCqCDMh
 RS/UuXMKCHH+A+FW/Zj9vOEFppd7pPnatJxrsJ8xUEFDwdfJJ3o7bHoL0M+XIQBYyQcC5jOzB/B
 cnaNWIq23B6QnET8ZZ7ESh551EKTL8jO18cMsnJSKZ9/SACLjEIxOqj8YuNbfz6UelowVshezrv
 2XL7/dk+WBoyKMEfu8VKEnZwZMjoCnY6XbUjf+F5IvqyNZsMzTVxajrub7Jx7EhmC+DTieVMWHy
 fSXnH54BbeKuAF4=
X-Google-Smtp-Source: AGHT+IFy6lff892+ut53N9/2EuyoaZWe5GpSZWQljmBtXkuCqPxNMZBHNa9qoJO4FbooDe7RqMmaoQ==
X-Received: by 2002:a05:600c:524c:b0:435:23c:e23e with SMTP id
 5b1f17b1804b1-438913db8d1mr236673595e9.12.1737634542183; 
 Thu, 23 Jan 2025 04:15:42 -0800 (PST)
Received: from [192.168.0.200] ([212.69.42.53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31df407sm62413105e9.37.2025.01.23.04.15.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 04:15:41 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="------------wa3ZdTCeWFwxNuH0mg2Aoro0"
Message-ID: <02aae2cd-163c-4ca0-a2c5-0c5de6b3d5f1@embecosm.com>
Date: Thu, 23 Jan 2025 12:15:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Richard Handerson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>, Jeremy Bennett
 <jeremy.bennett@embecosm.com>, Craig Blackmore <craig.blackmore@embecosm.com>
References: <20250122164905.13615-1-paolo.savini@embecosm.com>
 <20250122164905.13615-2-paolo.savini@embecosm.com>
 <878qr2n3qt.fsf@draig.linaro.org>
Content-Language: en-US
From: Paolo Savini <paolo.savini@embecosm.com>
Autocrypt: addr=paolo.savini@embecosm.com; keydata=
 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
Subject: Re: [RFC 1/1 v3] target/riscv: use tcg ops generation to emulate
 whole reg rvv loads/stores.
In-Reply-To: <878qr2n3qt.fsf@draig.linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=paolo.savini@embecosm.com; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This is a multi-part message in MIME format.
--------------wa3ZdTCeWFwxNuH0mg2Aoro0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Alex,

thanks for the review!

On 1/22/25 17:43, Alex Bennée wrote:
> Paolo Savini<paolo.savini@embecosm.com> writes:
>
>> This patch replaces the use of a helper function with direct tcg ops generation
>> in order to emulate whole register loads and stores. This is done in order to
>> improve the performance of QEMU.
> Generally having the frontend second guess what the backend will do is
> not recommended.

Could you please clarify this bit? Is this about the calls to 
tcg_gen_qemu_[ld,st]_i64 and tcg_gen_[st,ld]_i64?

>
>> We still use the helper function when vstart is not 0 at the beginning of the
>> emulation of the whole register load or store or when we would end up generating
>> partial loads or stores of vector elements (e.g. emulating 64 bits element loads
>> with pairs of 32 bits loads on hosts with 32 bits registers).
>> The latter condition ensures that we are not surprised by a trap in mid-element
>> and consecutively that we can update vstart correctly.
> This is what probe functions are for, so you can verify you won't fault
> and then fully unroll the loop.

When generating these tcg nodes we don't have a load/store address to 
probe but only the generation of the contents of the base address 
register of the load/store and I assumed that can't be used to probe 
(correct me if I'm wrong):

static TCGv get_address(DisasContext *ctx, int rs1, int imm)
{
     TCGv addr = tcg_temp_new();
     TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
     tcg_gen_addi_tl(addr, src1, imm);
     if (ctx->addr_signed) {
         tcg_gen_sextract_tl(addr, addr, 0, ctx->addr_xl);
     } else {
         tcg_gen_extract_tl(addr, addr, 0, ctx->addr_xl);
     }
     return addr;
}

I haven't seen examples of probe functions used with the tcg generation 
but only in the helper functions, but I might have missed something?

>
>> We also use the helper function when it performs better than tcg for specific
>> combinations of vector length, number of fields and element size.
>>
>> Signed-off-by: Paolo Savini<paolo.savini@embecosm.com>
>> ---
>>   target/riscv/insn_trans/trans_rvv.c.inc | 164 +++++++++++++++++-------
>>   1 file changed, 119 insertions(+), 45 deletions(-)
>>
>> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
>> index b9883a5d32..85935276de 100644
>> --- a/target/riscv/insn_trans/trans_rvv.c.inc
>> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
>> @@ -1100,25 +1100,99 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
>>   typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
>>   
>>   static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>> -                             gen_helper_ldst_whole *fn,
>> -                             DisasContext *s)
>> +                             uint32_t log2_esz, gen_helper_ldst_whole *fn,
>> +                             DisasContext *s, bool is_load)
>>   {
>> -    TCGv_ptr dest;
>> -    TCGv base;
>> -    TCGv_i32 desc;
>> +    mark_vs_dirty(s);
>>   
>> -    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
>> -    data = FIELD_DP32(data, VDATA, VM, 1);
>> -    dest = tcg_temp_new_ptr();
>> -    desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>> -                                      s->cfg_ptr->vlenb, data));
>> +    uint32_t vlen = s->cfg_ptr->vlenb << 3;
>>   
>> -    base = get_gpr(s, rs1, EXT_NONE);
>> -    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>> +    /*
>> +     * Load/store multiple bytes per iteration.
>> +     * When possible do this atomically.
>> +     * Update vstart with the number of processed elements.
>> +     * Use the helper function if either:
>> +     * - vstart is not 0.
>> +     * - the target has 32 bit registers and we are loading/storing 64 bit long
>> +     *   elements. This is to ensure that we process every element with a single
>> +     *   memory instruction.
>> +     * - whether the helper function performs better:
>> +     *   on x86 the helper function performs better with few combinations of NF,
>> +     *   ESZ and VLEN.
>> +     *   Other architectures may have other combinations or conditions and they
>> +     *   can be added here if necessary.
>> +     */
>>   
>> -    mark_vs_dirty(s);
>> +    bool use_helper_fn = !s->vstart_eq_zero || (TCG_TARGET_REG_BITS == 32 && log2_esz == 3);
>> +
>> +#if defined(HOST_X86_64)
>> +    use_helper_fn |= ((nf == 4) && (log2_esz == 0) && (vlen == 1024)) ||
>> +                     ((nf == 8) && (log2_esz == 0) && (vlen == 512))  ||
>> +                     ((nf == 8) && (log2_esz == 0) && (vlen == 1024)) ||
>> +                     ((nf == 8) && (log2_esz == 3) && (vlen == 1024));
>> +#endif
> Using host architecture ifdefs is generally discouraged except in a few places.

I guess this is all about the compromise. The performance loss that we 
get in some cases by doing tcg instead of using the helper function is 
negligible compared to the performance gains obtained for most cases but 
still present.

We evaluated the performance of the whole register loads and stores with 
different vector lengths, number of fields and element sizes by running 
this test:

https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/wholereg-load-store

which is a simple loop repeating the same instruction many times to cut 
out statistical variations and overhead, and we got results like the 
following (see the graph in the following report):

https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250115.md

With subsequent testing and with the above conditions to fall back to 
the helper function when convenient we got the following results:

https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250122.md

The two sets of results differ a bit in scale because the machines were 
not the same and we don't have the intermediate results in a report 
upstream but the performance losses were the same and the final result 
is the same

So there is benefit in adding these conditions but I understand that it 
could be unorthodox or a bit difficult to maintain to add host specific 
ifdefs.

I'm happy to remove this though if there is a consensus on that.


Many thanks,

Paolo

>
>>   
>> -    fn(dest, base, tcg_env, desc);
>> +     if (!use_helper_fn) {
>> +        TCGv addr = tcg_temp_new();
>> +        uint32_t size = s->cfg_ptr->vlenb * nf;
>> +        TCGv_i64 t8 = tcg_temp_new_i64();
>> +        TCGv_i32 t4 = tcg_temp_new_i32();
>> +        MemOp atomicity = MO_ATOM_NONE;
>> +        if (log2_esz == 0) {
>> +            atomicity = MO_ATOM_NONE;
>> +        } else {
>> +            atomicity = MO_ATOM_IFALIGN_PAIR;
>> +        }
>> +        if (TCG_TARGET_REG_BITS == 64) {
>> +            for (int i = 0; i < size; i += 8) {
>> +                addr = get_address(s, rs1, i);
>> +                if (is_load) {
>> +                    tcg_gen_qemu_ld_i64(t8, addr, s->mem_idx,
>> +                            MO_LE | MO_64 | atomicity);
>> +                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
>> +                } else {
>> +                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
>> +                    tcg_gen_qemu_st_i64(t8, addr, s->mem_idx,
>> +                            MO_LE | MO_64 | atomicity);
>> +                }
>> +                if (i == size - 8) {
>> +                    tcg_gen_movi_tl(cpu_vstart, 0);
>> +                } else {
>> +                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 >> log2_esz);
>> +                }
>> +            }
>> +        } else {
>> +            for (int i = 0; i < size; i += 4) {
>> +                addr = get_address(s, rs1, i);
>> +                if (is_load) {
>> +                    tcg_gen_qemu_ld_i32(t4, addr, s->mem_idx,
>> +                            MO_LE | MO_32 | atomicity);
>> +                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
>> +                } else {
>> +                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
>> +                    tcg_gen_qemu_st_i32(t4, addr, s->mem_idx,
>> +                            MO_LE | MO_32 | atomicity);
>> +                }
>> +                if (i == size - 4) {
>> +                    tcg_gen_movi_tl(cpu_vstart, 0);
>> +                } else {
>> +                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 >> log2_esz);
>> +                }
>> +            }
>> +        }
>> +    } else {
>> +        TCGv_ptr dest;
>> +        TCGv base;
>> +        TCGv_i32 desc;
>> +        uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
>> +        data = FIELD_DP32(data, VDATA, VM, 1);
>> +        dest = tcg_temp_new_ptr();
>> +        desc = tcg_constant_i32(simd_desc(s->cfg_ptr->vlenb,
>> +                        s->cfg_ptr->vlenb, data));
>> +        base = get_gpr(s, rs1, EXT_NONE);
>> +        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
>> +        fn(dest, base, tcg_env, desc);
>> +    }
>>   
>>       finalize_rvv_inst(s);
>>       return true;
>> @@ -1128,42 +1202,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
>>    * load and store whole register instructions ignore vtype and vl setting.
>>    * Thus, we don't need to check vill bit. (Section 7.9)
>>    */
>> -#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
>> -static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
>> -{                                                                         \
>> -    if (require_rvv(s) &&                                                 \
>> -        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                 \
>> -        return ldst_whole_trans(a->rd, a->rs1, ARG_NF,                    \
>> -                                gen_helper_##NAME, s);                    \
>> -    }                                                                     \
>> -    return false;                                                         \
>> -}
>> -
>> -GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
>> -GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
>> -GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
>> -GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
>> -GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
>> -GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
>> -GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
>> -GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
>> -GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
>> -GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
>> -GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
>> -GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
>> -GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
>> -GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
>> -GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
>> -GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
>> +#define GEN_LDST_WHOLE_TRANS(NAME, ETYPE, ARG_NF, IS_LOAD)                  \
>> +static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
>> +{                                                                           \
>> +    if (require_rvv(s) &&                                                   \
>> +        QEMU_IS_ALIGNED(a->rd, ARG_NF)) {                                   \
>> +        return ldst_whole_trans(a->rd, a->rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
>> +                                gen_helper_##NAME, s, IS_LOAD);             \
>> +    }                                                                       \
>> +    return false;                                                           \
>> +}
>> +
>> +GEN_LDST_WHOLE_TRANS(vl1re8_v,  int8_t,  1, true)
>> +GEN_LDST_WHOLE_TRANS(vl1re16_v, int16_t, 1, true)
>> +GEN_LDST_WHOLE_TRANS(vl1re32_v, int32_t, 1, true)
>> +GEN_LDST_WHOLE_TRANS(vl1re64_v, int64_t, 1, true)
>> +GEN_LDST_WHOLE_TRANS(vl2re8_v,  int8_t,  2, true)
>> +GEN_LDST_WHOLE_TRANS(vl2re16_v, int16_t, 2, true)
>> +GEN_LDST_WHOLE_TRANS(vl2re32_v, int32_t, 2, true)
>> +GEN_LDST_WHOLE_TRANS(vl2re64_v, int64_t, 2, true)
>> +GEN_LDST_WHOLE_TRANS(vl4re8_v,  int8_t,  4, true)
>> +GEN_LDST_WHOLE_TRANS(vl4re16_v, int16_t, 4, true)
>> +GEN_LDST_WHOLE_TRANS(vl4re32_v, int32_t, 4, true)
>> +GEN_LDST_WHOLE_TRANS(vl4re64_v, int64_t, 4, true)
>> +GEN_LDST_WHOLE_TRANS(vl8re8_v,  int8_t,  8, true)
>> +GEN_LDST_WHOLE_TRANS(vl8re16_v, int16_t, 8, true)
>> +GEN_LDST_WHOLE_TRANS(vl8re32_v, int32_t, 8, true)
>> +GEN_LDST_WHOLE_TRANS(vl8re64_v, int64_t, 8, true)
>>   
>>   /*
>>    * The vector whole register store instructions are encoded similar to
>>    * unmasked unit-stride store of elements with EEW=8.
>>    */
>> -GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
>> -GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
>> -GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
>> -GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
>> +GEN_LDST_WHOLE_TRANS(vs1r_v, int8_t, 1, false)
>> +GEN_LDST_WHOLE_TRANS(vs2r_v, int8_t, 2, false)
>> +GEN_LDST_WHOLE_TRANS(vs4r_v, int8_t, 4, false)
>> +GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
>>   
>>   /*
>>    *** Vector Integer Arithmetic Instructions
--------------wa3ZdTCeWFwxNuH0mg2Aoro0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>Hi Alex,</p>
    <p>thanks for the review!<br>
    </p>
    <div class="moz-cite-prefix">On 1/22/25 17:43, Alex Bennée wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:878qr2n3qt.fsf@draig.linaro.org">
      <pre wrap="" class="moz-quote-pre">Paolo Savini <a class="moz-txt-link-rfc2396E" href="mailto:paolo.savini@embecosm.com">&lt;paolo.savini@embecosm.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">This patch replaces the use of a helper function with direct tcg ops generation
in order to emulate whole register loads and stores. This is done in order to
improve the performance of QEMU.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Generally having the frontend second guess what the backend will do is
not recommended.</pre>
    </blockquote>
    <p>Could you please clarify this bit? Is this about the calls to
      tcg_gen_qemu_[ld,st]_i64 and tcg_gen_[st,ld]_i64?</p>
    <blockquote type="cite" cite="mid:878qr2n3qt.fsf@draig.linaro.org">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">We still use the helper function when vstart is not 0 at the beginning of the
emulation of the whole register load or store or when we would end up generating
partial loads or stores of vector elements (e.g. emulating 64 bits element loads
with pairs of 32 bits loads on hosts with 32 bits registers).
The latter condition ensures that we are not surprised by a trap in mid-element
and consecutively that we can update vstart correctly.
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This is what probe functions are for, so you can verify you won't fault
and then fully unroll the loop.</pre>
    </blockquote>
    <p>When generating these tcg nodes we don't have a load/store
      address to probe but only the generation of the contents of the
      base address register of the load/store and I assumed that can't
      be used to probe (correct me if I'm wrong):</p>
    <pre>static TCGv get_address(DisasContext *ctx, int rs1, int imm)
{
    TCGv addr = tcg_temp_new();
    TCGv src1 = get_gpr(ctx, rs1, EXT_NONE);
    tcg_gen_addi_tl(addr, src1, imm);
    if (ctx-&gt;addr_signed) {
        tcg_gen_sextract_tl(addr, addr, 0, ctx-&gt;addr_xl);
    } else {
        tcg_gen_extract_tl(addr, addr, 0, ctx-&gt;addr_xl);
    }
    return addr;
}</pre>
    <p>I haven't seen examples of probe functions used with the tcg
      generation but only in the helper functions, but I might have
      missed something?<br>
    </p>
    <blockquote type="cite" cite="mid:878qr2n3qt.fsf@draig.linaro.org">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">We also use the helper function when it performs better than tcg for specific
combinations of vector length, number of fields and element size.

Signed-off-by: Paolo Savini <a class="moz-txt-link-rfc2396E" href="mailto:paolo.savini@embecosm.com">&lt;paolo.savini@embecosm.com&gt;</a>
---
 target/riscv/insn_trans/trans_rvv.c.inc | 164 +++++++++++++++++-------
 1 file changed, 119 insertions(+), 45 deletions(-)

diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
index b9883a5d32..85935276de 100644
--- a/target/riscv/insn_trans/trans_rvv.c.inc
+++ b/target/riscv/insn_trans/trans_rvv.c.inc
@@ -1100,25 +1100,99 @@ GEN_VEXT_TRANS(vle64ff_v, MO_64, r2nfvm, ldff_op, ld_us_check)
 typedef void gen_helper_ldst_whole(TCGv_ptr, TCGv, TCGv_env, TCGv_i32);
 
 static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
-                             gen_helper_ldst_whole *fn,
-                             DisasContext *s)
+                             uint32_t log2_esz, gen_helper_ldst_whole *fn,
+                             DisasContext *s, bool is_load)
 {
-    TCGv_ptr dest;
-    TCGv base;
-    TCGv_i32 desc;
+    mark_vs_dirty(s);
 
-    uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
-    data = FIELD_DP32(data, VDATA, VM, 1);
-    dest = tcg_temp_new_ptr();
-    desc = tcg_constant_i32(simd_desc(s-&gt;cfg_ptr-&gt;vlenb,
-                                      s-&gt;cfg_ptr-&gt;vlenb, data));
+    uint32_t vlen = s-&gt;cfg_ptr-&gt;vlenb &lt;&lt; 3;
 
-    base = get_gpr(s, rs1, EXT_NONE);
-    tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+    /*
+     * Load/store multiple bytes per iteration.
+     * When possible do this atomically.
+     * Update vstart with the number of processed elements.
+     * Use the helper function if either:
+     * - vstart is not 0.
+     * - the target has 32 bit registers and we are loading/storing 64 bit long
+     *   elements. This is to ensure that we process every element with a single
+     *   memory instruction.
+     * - whether the helper function performs better:
+     *   on x86 the helper function performs better with few combinations of NF,
+     *   ESZ and VLEN.
+     *   Other architectures may have other combinations or conditions and they
+     *   can be added here if necessary.
+     */
 
-    mark_vs_dirty(s);
+    bool use_helper_fn = !s-&gt;vstart_eq_zero || (TCG_TARGET_REG_BITS == 32 &amp;&amp; log2_esz == 3);
+
+#if defined(HOST_X86_64)
+    use_helper_fn |= ((nf == 4) &amp;&amp; (log2_esz == 0) &amp;&amp; (vlen == 1024)) ||
+                     ((nf == 8) &amp;&amp; (log2_esz == 0) &amp;&amp; (vlen == 512))  ||
+                     ((nf == 8) &amp;&amp; (log2_esz == 0) &amp;&amp; (vlen == 1024)) ||
+                     ((nf == 8) &amp;&amp; (log2_esz == 3) &amp;&amp; (vlen == 1024));
+#endif
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Using host architecture ifdefs is generally discouraged except in a few places.</pre>
    </blockquote>
    <p>I guess this is all about the compromise. The performance loss
      that we get in some cases by doing tcg instead of using the helper
      function is negligible compared to the performance gains obtained
      for most cases but still present.</p>
    <p>We evaluated the performance of the whole register loads and
      stores with different vector lengths, number of fields and element
      sizes by running this test:</p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/wholereg-load-store">https://github.com/embecosm/rise-rvv-tcg-qemu-tooling/tree/main/wholereg-load-store</a></p>
    <p>which is a simple loop repeating the same instruction many times
      to cut out statistical variations and overhead, and we got results
      like the following (see the graph in the following report):</p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250115.md">https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250115.md</a></p>
    <p>With subsequent testing and with the above conditions to fall
      back to the helper function when convenient we got the following
      results:</p>
    <p><a class="moz-txt-link-freetext" href="https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250122.md">https://github.com/embecosm/rise-rvv-tcg-qemu-reports/blob/main/20250122.md</a></p>
    <p>The two sets of results differ a bit in scale because the
      machines were not the same and we don't have the intermediate
      results in a report upstream but the performance losses were the
      same and the final result is the same<br>
    </p>
    <p>So there is benefit in adding these conditions but I understand
      that it could be unorthodox or a bit difficult to maintain to add
      host specific ifdefs.<br>
    </p>
    <p>I'm happy to remove this though if there is a consensus on that.</p>
    <p><br>
    </p>
    <p>Many thanks,<br>
    </p>
    <p>Paolo<br>
    </p>
    <blockquote type="cite" cite="mid:878qr2n3qt.fsf@draig.linaro.org">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 
-    fn(dest, base, tcg_env, desc);
+     if (!use_helper_fn) {
+        TCGv addr = tcg_temp_new();
+        uint32_t size = s-&gt;cfg_ptr-&gt;vlenb * nf;
+        TCGv_i64 t8 = tcg_temp_new_i64();
+        TCGv_i32 t4 = tcg_temp_new_i32();
+        MemOp atomicity = MO_ATOM_NONE;
+        if (log2_esz == 0) {
+            atomicity = MO_ATOM_NONE;
+        } else {
+            atomicity = MO_ATOM_IFALIGN_PAIR;
+        }
+        if (TCG_TARGET_REG_BITS == 64) {
+            for (int i = 0; i &lt; size; i += 8) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i64(t8, addr, s-&gt;mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                    tcg_gen_st_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i64(t8, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i64(t8, addr, s-&gt;mem_idx,
+                            MO_LE | MO_64 | atomicity);
+                }
+                if (i == size - 8) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 8 &gt;&gt; log2_esz);
+                }
+            }
+        } else {
+            for (int i = 0; i &lt; size; i += 4) {
+                addr = get_address(s, rs1, i);
+                if (is_load) {
+                    tcg_gen_qemu_ld_i32(t4, addr, s-&gt;mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                    tcg_gen_st_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                } else {
+                    tcg_gen_ld_i32(t4, tcg_env, vreg_ofs(s, vd) + i);
+                    tcg_gen_qemu_st_i32(t4, addr, s-&gt;mem_idx,
+                            MO_LE | MO_32 | atomicity);
+                }
+                if (i == size - 4) {
+                    tcg_gen_movi_tl(cpu_vstart, 0);
+                } else {
+                    tcg_gen_addi_tl(cpu_vstart, cpu_vstart, 4 &gt;&gt; log2_esz);
+                }
+            }
+        }
+    } else {
+        TCGv_ptr dest;
+        TCGv base;
+        TCGv_i32 desc;
+        uint32_t data = FIELD_DP32(0, VDATA, NF, nf);
+        data = FIELD_DP32(data, VDATA, VM, 1);
+        dest = tcg_temp_new_ptr();
+        desc = tcg_constant_i32(simd_desc(s-&gt;cfg_ptr-&gt;vlenb,
+                        s-&gt;cfg_ptr-&gt;vlenb, data));
+        base = get_gpr(s, rs1, EXT_NONE);
+        tcg_gen_addi_ptr(dest, tcg_env, vreg_ofs(s, vd));
+        fn(dest, base, tcg_env, desc);
+    }
 
     finalize_rvv_inst(s);
     return true;
@@ -1128,42 +1202,42 @@ static bool ldst_whole_trans(uint32_t vd, uint32_t rs1, uint32_t nf,
  * load and store whole register instructions ignore vtype and vl setting.
  * Thus, we don't need to check vill bit. (Section 7.9)
  */
-#define GEN_LDST_WHOLE_TRANS(NAME, ARG_NF)                                \
-static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                 \
-{                                                                         \
-    if (require_rvv(s) &amp;&amp;                                                 \
-        QEMU_IS_ALIGNED(a-&gt;rd, ARG_NF)) {                                 \
-        return ldst_whole_trans(a-&gt;rd, a-&gt;rs1, ARG_NF,                    \
-                                gen_helper_##NAME, s);                    \
-    }                                                                     \
-    return false;                                                         \
-}
-
-GEN_LDST_WHOLE_TRANS(vl1re8_v,  1)
-GEN_LDST_WHOLE_TRANS(vl1re16_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re32_v, 1)
-GEN_LDST_WHOLE_TRANS(vl1re64_v, 1)
-GEN_LDST_WHOLE_TRANS(vl2re8_v,  2)
-GEN_LDST_WHOLE_TRANS(vl2re16_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re32_v, 2)
-GEN_LDST_WHOLE_TRANS(vl2re64_v, 2)
-GEN_LDST_WHOLE_TRANS(vl4re8_v,  4)
-GEN_LDST_WHOLE_TRANS(vl4re16_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re32_v, 4)
-GEN_LDST_WHOLE_TRANS(vl4re64_v, 4)
-GEN_LDST_WHOLE_TRANS(vl8re8_v,  8)
-GEN_LDST_WHOLE_TRANS(vl8re16_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re32_v, 8)
-GEN_LDST_WHOLE_TRANS(vl8re64_v, 8)
+#define GEN_LDST_WHOLE_TRANS(NAME, ETYPE, ARG_NF, IS_LOAD)                  \
+static bool trans_##NAME(DisasContext *s, arg_##NAME * a)                   \
+{                                                                           \
+    if (require_rvv(s) &amp;&amp;                                                   \
+        QEMU_IS_ALIGNED(a-&gt;rd, ARG_NF)) {                                   \
+        return ldst_whole_trans(a-&gt;rd, a-&gt;rs1, ARG_NF, ctzl(sizeof(ETYPE)), \
+                                gen_helper_##NAME, s, IS_LOAD);             \
+    }                                                                       \
+    return false;                                                           \
+}
+
+GEN_LDST_WHOLE_TRANS(vl1re8_v,  int8_t,  1, true)
+GEN_LDST_WHOLE_TRANS(vl1re16_v, int16_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re32_v, int32_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl1re64_v, int64_t, 1, true)
+GEN_LDST_WHOLE_TRANS(vl2re8_v,  int8_t,  2, true)
+GEN_LDST_WHOLE_TRANS(vl2re16_v, int16_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re32_v, int32_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl2re64_v, int64_t, 2, true)
+GEN_LDST_WHOLE_TRANS(vl4re8_v,  int8_t,  4, true)
+GEN_LDST_WHOLE_TRANS(vl4re16_v, int16_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re32_v, int32_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl4re64_v, int64_t, 4, true)
+GEN_LDST_WHOLE_TRANS(vl8re8_v,  int8_t,  8, true)
+GEN_LDST_WHOLE_TRANS(vl8re16_v, int16_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re32_v, int32_t, 8, true)
+GEN_LDST_WHOLE_TRANS(vl8re64_v, int64_t, 8, true)
 
 /*
  * The vector whole register store instructions are encoded similar to
  * unmasked unit-stride store of elements with EEW=8.
  */
-GEN_LDST_WHOLE_TRANS(vs1r_v, 1)
-GEN_LDST_WHOLE_TRANS(vs2r_v, 2)
-GEN_LDST_WHOLE_TRANS(vs4r_v, 4)
-GEN_LDST_WHOLE_TRANS(vs8r_v, 8)
+GEN_LDST_WHOLE_TRANS(vs1r_v, int8_t, 1, false)
+GEN_LDST_WHOLE_TRANS(vs2r_v, int8_t, 2, false)
+GEN_LDST_WHOLE_TRANS(vs4r_v, int8_t, 4, false)
+GEN_LDST_WHOLE_TRANS(vs8r_v, int8_t, 8, false)
 
 /*
  *** Vector Integer Arithmetic Instructions
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------wa3ZdTCeWFwxNuH0mg2Aoro0--

