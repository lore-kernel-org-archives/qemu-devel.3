Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9F0C54E6A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 00:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmNn0-0006Of-4u; Mon, 18 Mar 2024 20:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmNmx-0006OA-D9; Mon, 18 Mar 2024 20:57:11 -0400
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1rmNmv-0001z0-1x; Mon, 18 Mar 2024 20:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1710809817; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=6PTMi8nhkLz1MXkSbF2uHYnuB5e7giuyUeT/vwSy0d0=;
 b=VP0JHUPaZc6jFbCkTo+28tc9sFur5Jpptap2XC41cilpeBN7+1F31FeYkC1lTunUtUglciXJr/Evm8dgtrhsVQrS18KT6u3jH66Yzv2jSibMijCjN3GcLdbu0UMGCr9WmE3F1o9OlHCMvOhv8cGkfIT/meO23oyPZ+uBoJAmTx4=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046056;
 MF=zhiwei_liu@linux.alibaba.com; NM=1; PH=DS; RN=9; SR=0;
 TI=SMTPD_---0W2qkEo2_1710809815; 
Received: from 30.198.0.148(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0W2qkEo2_1710809815) by smtp.aliyun-inc.com;
 Tue, 19 Mar 2024 08:56:56 +0800
Message-ID: <0dd04dce-5955-4b50-bc07-72165a6ec197@linux.alibaba.com>
Date: Tue, 19 Mar 2024 08:56:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for 9.0 v15 02/10] trans_rvv.c.inc: set vstart = 0 in int
 scalar move insns
Content-Language: en-US
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, palmer@rivosinc.com, max.chou@sifive.com,
 richard.henderson@linaro.org
References: <20240314175704.478276-1-dbarboza@ventanamicro.com>
 <20240314175704.478276-3-dbarboza@ventanamicro.com>
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240314175704.478276-3-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.98;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-98.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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


On 2024/3/15 1:56, Daniel Henrique Barboza wrote:
> trans_vmv_x_s, trans_vmv_s_x, trans_vfmv_f_s and trans_vfmv_s_f aren't
> setting vstart = 0 after execution. This is usually done by a helper in
> vector_helper.c but these functions don't use helpers.
>
> We'll set vstart after any potential 'over' brconds, and that will also
> mandate a mark_vs_dirty() too.
>
> Fixes: dedc53cbc9 ("target/riscv: rvv-1.0: integer scalar move instructions")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewd-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index e42728990e..8c16a9f5b3 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -3373,6 +3373,8 @@ static bool trans_vmv_x_s(DisasContext *s, arg_vmv_x_s *a)
>           vec_element_loadi(s, t1, a->rs2, 0, true);
>           tcg_gen_trunc_i64_tl(dest, t1);
>           gen_set_gpr(s, a->rd, dest);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>           return true;
>       }
>       return false;
> @@ -3399,8 +3401,9 @@ static bool trans_vmv_s_x(DisasContext *s, arg_vmv_s_x *a)
>           s1 = get_gpr(s, a->rs1, EXT_NONE);
>           tcg_gen_ext_tl_i64(t1, s1);
>           vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
>           gen_set_label(over);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>           return true;
>       }
>       return false;
> @@ -3427,6 +3430,8 @@ static bool trans_vfmv_f_s(DisasContext *s, arg_vfmv_f_s *a)
>           }
>   
>           mark_fs_dirty(s);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>           return true;
>       }
>       return false;
> @@ -3452,8 +3457,9 @@ static bool trans_vfmv_s_f(DisasContext *s, arg_vfmv_s_f *a)
>           do_nanbox(s, t1, cpu_fpr[a->rs1]);
>   
>           vec_element_storei(s, a->rd, 0, t1);
> -        mark_vs_dirty(s);
>           gen_set_label(over);
> +        tcg_gen_movi_tl(cpu_vstart, 0);
> +        mark_vs_dirty(s);
>           return true;
>       }
>       return false;

