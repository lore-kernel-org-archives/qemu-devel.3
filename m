Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5FCC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 11:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s67Xx-0006Co-2E; Sun, 12 May 2024 07:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s67Xv-0006CP-3e
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:39:15 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s67Xk-0000xl-Vb
 for qemu-devel@nongnu.org; Sun, 12 May 2024 07:39:11 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-34da4d6f543so2439344f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 May 2024 04:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715513943; x=1716118743; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pNy4N/0IVc8GcqFUb3iiXv8CUmbto1ApygcpnrRm/44=;
 b=O5LvgxmB11VqAd2ghDIATlGS19Gwl5xjtwIXBITxY/HnLlisZKbjmTMc+Li90Xd8aU
 cfTGXHWZRXgT6YNX8LKfPJaCQvf18nblaYw6drKOBsySP9/3YaZTJ2CjkR4t9Ej4aYuJ
 uD5AtgUtuFt0KZFaseZyCsl5D+79Jn9DZHXeSHWXOL8QK1jWBD806bxhUZ+DEAqcYVBm
 Ru2TUn+8Jzix9Cz2P2zeqD+oo6UtrmAWZadPDzuY9COu5QoH0t84cWmY/0a7THZqrCwO
 AEyP7YpsjnzIUjFWhGvGG/SB0wIKUvDb3qwYzgS6RnWoalUKlEcrTEZVBwCljgzT6BTk
 KjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715513943; x=1716118743;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pNy4N/0IVc8GcqFUb3iiXv8CUmbto1ApygcpnrRm/44=;
 b=cI/P/GcuWQ/s1bBdVi0ki6qbVjxo0epl5GLqmoVVcm+aIOCv1yefDg9DqfMC/QGVej
 4G1LtcOICDSFW1kCsgPnUKIjBVKZUT9E36U1Gw5EpeFuIw47EaSxBlGljIQoj4dzxWBY
 KDvvjkrGQ4xKTbd9a6HR0NtPYQrzczn0vJrgwFAeXc0Nhyzxmc0R/ORFzbSmDdGwyav3
 6U1z/S7rWCRfPnUhpJ0T7RNQT2PI1kwBPxnGTdLsdDw5OIgDjDTjaP4Xv4EdvO27syMC
 0kZcJj/RyliGNMiHp67tCumdPViEKFrDD4eU5un4umyxbwbUA9YDVoh/g8LSnmlQCKLY
 afmA==
X-Gm-Message-State: AOJu0YxkWyhKgF+gW2qUYsTDP9eeKvUtVi1wdeMdk6YfDOl/gpqH6OhU
 NIc2JOYsredUZ9yxZlkVqgqH+zvaCo/g5rfgq2UAt+rSCsiWjwf5CgPB2naUyxY=
X-Google-Smtp-Source: AGHT+IEjGoSGoHTjE7nvtiBZInquzVEg/1KXw/SPNvmtkT9O3UgHsCmmWVMoT0lTLdTyzdtt2Gyv0g==
X-Received: by 2002:a05:6000:551:b0:34b:b0ac:c63c with SMTP id
 ffacd0b85a97d-3504aa66a14mr4710195f8f.66.1715513942997; 
 Sun, 12 May 2024 04:39:02 -0700 (PDT)
Received: from [192.168.51.227] (12.red-213-97-13.staticip.rima-tde.net.
 [213.97.13.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b896a89sm8597352f8f.31.2024.05.12.04.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 May 2024 04:39:02 -0700 (PDT)
Message-ID: <c5eeb863-93af-4a03-a392-4eaf999d6643@linaro.org>
Date: Sun, 12 May 2024 13:38:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] target/ppc: Move VMX integer add/sub saturate insns
 to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com, lucas.araujo@eldorado.org.br
References: <20240512093847.18099-1-rathc@linux.ibm.com>
 <20240512093847.18099-2-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240512093847.18099-2-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 5/12/24 11:38, Chinmay Rath wrote:
> @@ -2934,6 +2870,184 @@ static bool do_vx_vaddsubcuw(DisasContext *ctx, arg_VX *a, int add)
>       return true;
>   }
>   
> +static inline void do_vadd_vsub_sat
> +(
> +    unsigned vece, TCGv_vec t, TCGv_vec sat, TCGv_vec a, TCGv_vec b,
> +    void (*norm_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec),
> +    void (*sat_op)(unsigned, TCGv_vec, TCGv_vec, TCGv_vec))
> +{
> +    TCGv_vec x = tcg_temp_new_vec_matching(t);
> +    norm_op(vece, x, a, b);
> +    sat_op(vece, t, a, b);
> +    tcg_gen_cmp_vec(TCG_COND_NE, vece, x, x, t);
> +    tcg_gen_or_vec(vece, sat, sat, x);
> +}

As a separate change, before or after, the cmp_vec may be simplified to xor_vec.  Which 
means that INDEX_op_cmp_vec need not be probed in the vecop_lists.  See

https://lore.kernel.org/qemu-devel/20240506010403.6204-31-richard.henderson@linaro.org/

which is performing the same operation on AArch64.


> +static bool do_vx_vadd_vsub_sat(DisasContext *ctx, arg_VX *a,
> +                                int sign, int vece, int add)
> +{
> +    static const TCGOpcode vecop_list_sub_u[] = {
> +        INDEX_op_sub_vec, INDEX_op_ussub_vec, INDEX_op_cmp_vec, 0
> +    };
> +    static const TCGOpcode vecop_list_sub_s[] = {
> +        INDEX_op_sub_vec, INDEX_op_sssub_vec, INDEX_op_cmp_vec, 0
> +    };
> +    static const TCGOpcode vecop_list_add_u[] = {
> +        INDEX_op_add_vec, INDEX_op_usadd_vec, INDEX_op_cmp_vec, 0
> +    };
> +    static const TCGOpcode vecop_list_add_s[] = {
> +        INDEX_op_add_vec, INDEX_op_ssadd_vec, INDEX_op_cmp_vec, 0
> +    };
> +
> +    static const GVecGen4 op[2][3][2] = {
> +        {
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_u,
> +                    .fno = gen_helper_VSUBUBS,
> +                    .opt_opc = vecop_list_sub_u,
> +                    .write_aofs = true,
> +                    .vece = MO_8
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_u,
> +                    .fno = gen_helper_VADDUBS,
> +                    .opt_opc = vecop_list_add_u,
> +                    .write_aofs = true,
> +                    .vece = MO_8
> +                },
> +            },
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_u,
> +                    .fno = gen_helper_VSUBUHS,
> +                    .opt_opc = vecop_list_sub_u,
> +                    .write_aofs = true,
> +                    .vece = MO_16
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_u,
> +                    .fno = gen_helper_VADDUHS,
> +                    .opt_opc = vecop_list_add_u,
> +                    .write_aofs = true,
> +                    .vece = MO_16
> +                },
> +            },
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_u,
> +                    .fno = gen_helper_VSUBUWS,
> +                    .opt_opc = vecop_list_sub_u,
> +                    .write_aofs = true,
> +                    .vece = MO_32
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_u,
> +                    .fno = gen_helper_VADDUWS,
> +                    .opt_opc = vecop_list_add_u,
> +                    .write_aofs = true,
> +                    .vece = MO_32
> +                },
> +            },
> +        },
> +        {
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_s,
> +                    .fno = gen_helper_VSUBSBS,
> +                    .opt_opc = vecop_list_sub_s,
> +                    .write_aofs = true,
> +                    .vece = MO_8
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_s,
> +                    .fno = gen_helper_VADDSBS,
> +                    .opt_opc = vecop_list_add_s,
> +                    .write_aofs = true,
> +                    .vece = MO_8
> +                },
> +            },
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_s,
> +                    .fno = gen_helper_VSUBSHS,
> +                    .opt_opc = vecop_list_sub_s,
> +                    .write_aofs = true,
> +                    .vece = MO_16
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_s,
> +                    .fno = gen_helper_VADDSHS,
> +                    .opt_opc = vecop_list_add_s,
> +                    .write_aofs = true,
> +                    .vece = MO_16
> +                },
> +            },
> +            {
> +                {
> +                    .fniv = gen_vsub_sat_s,
> +                    .fno = gen_helper_VSUBSWS,
> +                    .opt_opc = vecop_list_sub_s,
> +                    .write_aofs = true,
> +                    .vece = MO_32
> +                },
> +                {
> +                    .fniv = gen_vadd_sat_s,
> +                    .fno = gen_helper_VADDSWS,
> +                    .opt_opc = vecop_list_add_s,
> +                    .write_aofs = true,
> +                    .vece = MO_32
> +                },
> +            },
> +        },
> +    };

While this table is not wrong, I think it is clearer to have separate tables, one per 
operation, which are then passed in to a common expander.

> +
> +    REQUIRE_INSNS_FLAGS(ctx, ALTIVEC);
> +    REQUIRE_VECTOR(ctx);
> +
> +    tcg_gen_gvec_4(avr_full_offset(a->vrt), offsetof(CPUPPCState, vscr_sat),
> +                   avr_full_offset(a->vra), avr_full_offset(a->vrb), 16, 16,
> +                   &op[sign][vece][add]);
> +
> +    return true;
> +}
> +
> +TRANS(VSUBUBS, do_vx_vadd_vsub_sat, 0, MO_8, 0)

I think it is clearer to use TRANS_FLAGS than to sink the ISA check into the helper.  In 
general I seem to find the helper later gets reused for something else with a different 
ISA check.

Thus

static const TCGOpcode vecop_list_vsub_sat_u[] = {
     INDEX_op_sub_vec, INDEX_op_ussub_vec, 0
};
static const GVecGen4 op_vsububs = {
     .fno = gen_helper_VSUBUBS,
     .fniv = gen_vsub_sat_u,
     .opt_opc = vecop_list_vsub_sat_u,
     .write_aofs = true,
     .vece = MO_8
};
TRANS_FLAGS(VSUBUBS, do_vx_vadd_vsub_sat, &op_vsububs)

static const GVecGen4 op_vsubuhs = {
     .fno = gen_helper_VSUBUHS,
     .fniv = gen_vsub_sat_u,
     .opt_opc = vecop_list_vsub_sat_u,
     .write_aofs = true,
     .vece = MO_16
};
TRANS_FLAGS(VSUBUHS, do_vx_vadd_vsub_sat, &op_vsubuhs)

etc.

> -GEN_VXFORM_DUAL(vaddubs, vmul10uq, 0, 8, PPC_ALTIVEC, PPC_NONE),

You are correct in your cover letter that this is not right.
We should have been testing ISA300 for vmul10uq here.

> +GEN_VXFORM(vmul10euq, 0, 9),

And thus need GEN_VXFORM_300 here.

> +GEN_VXFORM(vmul10euq, 0, 9),
> +GEN_VXFORM(bcdcpsgn, 0, 13),
> +GEN_VXFORM(bcdadd, 0, 24),
> +GEN_VXFORM(bcdsub, 0, 25),
...
> +GEN_VXFORM(xpnd04_2, 0, 30),

None of these are in the base ISA, so all need a flag check.



r~

