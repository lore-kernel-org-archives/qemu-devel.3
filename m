Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ACDC8303B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 06:45:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWUid-00064Z-JJ; Tue, 01 Jul 2025 02:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUiZ-00062k-Iq
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:43:47 -0400
Received: from sg-1-12.ptr.blmpb.com ([118.26.132.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liujingqi@lanxincomputing.com>)
 id 1uWUiX-0005LO-Bv
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 02:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=lanxincomputing-com.20200927.dkim.feishu.cn; t=1751352216;
 h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=HZEvBH3F1v0lTVrzej5P3JS7VetTP8ExWtOdIwoMbto=;
 b=fnI7E0v6yAd9/Xzgzyij8gjS8YViAxtkhePzorQqWTkmIxyqWUpqNMsDavy9gTQEABL53f
 xdARJxw+KjtM6Hryfvt8bIPspy700tnRsbuzcr7ej1GPkUgwtJCffHBMT/a9Wf0IgfbSzC
 U8hOC6K6ucEDjqIsmpa7vWXpfizG+pRbayRXrL68TXlECa+8c+15exvBJK2uoqFPyvewGk
 0DaVisXsAtArNDbJ9RfHuri35C9IZSP7el2AC4be9ZWoYXeYrdSOG6C3f7CNjuGEDH6R1c
 Rp4YTGLCd05SfRjGi1MHy+iMGFzupsXbYuvFcgtiD2QjhEkxK+VrUHeK4JYqjA==
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, 
 "Alistair Francis" <alistair.francis@wdc.com>, 
 "Weiwei Li" <liwei1518@gmail.com>, 
 "Daniel Henrique Barboza" <dbarboza@ventanamicro.com>, 
 "Liu Zhiwei" <zhiwei_liu@linux.alibaba.com>, <antonb@tenstorrent.com>
Date: Tue, 1 Jul 2025 14:43:32 +0800
References: <20250627132022.439315-1-max.chou@sifive.com>
 <20250627132022.439315-2-max.chou@sifive.com>
Content-Transfer-Encoding: 7bit
To: "Max Chou" <max.chou@sifive.com>, <qemu-devel@nongnu.org>, 
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 1/3] target/riscv: rvv: Apply vext_check_input_eew to
 vector integer/fp compare instructions
Content-Language: en-US
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+268638396+74cbad+nongnu.org+liujingqi@lanxincomputing.com>
Message-Id: <55543227-0791-488b-9294-44e15dc5477e@lanxincomputing.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20250627132022.439315-2-max.chou@sifive.com>
From: "Nutty Liu" <liujingqi@lanxincomputing.com>
Mime-Version: 1.0
Received: from [127.0.0.1] ([116.237.111.137]) by smtp.feishu.cn with ESMTPS;
 Tue, 01 Jul 2025 14:43:33 +0800
X-Original-From: Nutty Liu <liujingqi@lanxincomputing.com>
Received-SPF: pass client-ip=118.26.132.12;
 envelope-from=liujingqi@lanxincomputing.com; helo=sg-1-12.ptr.blmpb.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 6/27/2025 9:20 PM, Max Chou wrote:
> From: Anton Blanchard <antonb@tenstorrent.com>
>
> Handle the overlap of source registers with different EEWs.
>
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> Reviewed-by: Max Chou <max.chou@sifive.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---
>   target/riscv/insn_trans/trans_rvv.c.inc | 22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/insn_trans/trans_rvv.c.inc b/target/riscv/insn_trans/trans_rvv.c.inc
> index 2b6077ac067..ec34d0d8c47 100644
> --- a/target/riscv/insn_trans/trans_rvv.c.inc
> +++ b/target/riscv/insn_trans/trans_rvv.c.inc
> @@ -436,9 +436,10 @@ static bool vext_check_sss(DisasContext *s, int vd, int vs1, int vs2, int vm)
>              require_align(vs1, s->lmul);
>   }
>   
> -static bool vext_check_ms(DisasContext *s, int vd, int vs)
> +static bool vext_check_ms(DisasContext *s, int vd, int vs, int vm)
>   {
> -    bool ret = require_align(vs, s->lmul);
> +    bool ret = require_align(vs, s->lmul) &&
> +               vext_check_input_eew(s, vs, s->sew, -1, 0, vm);
>       if (vd != vs) {
>           ret &= require_noover(vd, 0, vs, s->lmul);
>       }
> @@ -461,9 +462,10 @@ static bool vext_check_ms(DisasContext *s, int vd, int vs)
>    *      with a mask value (e.g., comparisons) or the scalar result
>    *      of a reduction. (Section 5.3)
>    */
> -static bool vext_check_mss(DisasContext *s, int vd, int vs1, int vs2)
> +static bool vext_check_mss(DisasContext *s, int vd, int vs1, int vs2, int vm)
>   {
> -    bool ret = vext_check_ms(s, vd, vs2) &&
> +    bool ret = vext_check_ms(s, vd, vs2, vm) &&
> +               vext_check_input_eew(s, vs1, s->sew, vs2, s->sew, vm) &&
>                  require_align(vs1, s->lmul);
>       if (vd != vs1) {
>           ret &= require_noover(vd, 0, vs1, s->lmul);
> @@ -2040,7 +2042,7 @@ static bool opivv_vmadc_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_mss(s, a->rd, a->rs1, a->rs2);
> +           vext_check_mss(s, a->rd, a->rs1, a->rs2, a->vm);
>   }
>   
>   GEN_OPIVV_TRANS(vmadc_vvm, opivv_vmadc_check)
> @@ -2076,7 +2078,7 @@ static bool opivx_vmadc_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_ms(s, a->rd, a->rs2);
> +           vext_check_ms(s, a->rd, a->rs2, a->vm);
>   }
>   
>   GEN_OPIVX_TRANS(vmadc_vxm, opivx_vmadc_check)
> @@ -2250,7 +2252,7 @@ static bool opivv_cmp_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_mss(s, a->rd, a->rs1, a->rs2);
> +           vext_check_mss(s, a->rd, a->rs1, a->rs2, a->vm);
>   }
>   
>   GEN_OPIVV_TRANS(vmseq_vv, opivv_cmp_check)
> @@ -2264,7 +2266,7 @@ static bool opivx_cmp_check(DisasContext *s, arg_rmrr *a)
>   {
>       return require_rvv(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_ms(s, a->rd, a->rs2);
> +           vext_check_ms(s, a->rd, a->rs2, a->vm);
>   }
>   
>   GEN_OPIVX_TRANS(vmseq_vx, opivx_cmp_check)
> @@ -2972,7 +2974,7 @@ static bool opfvv_cmp_check(DisasContext *s, arg_rmrr *a)
>       return require_rvv(s) &&
>              require_rvf(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_mss(s, a->rd, a->rs1, a->rs2);
> +           vext_check_mss(s, a->rd, a->rs1, a->rs2, a->vm);
>   }
>   
>   GEN_OPFVV_TRANS(vmfeq_vv, opfvv_cmp_check)
> @@ -2985,7 +2987,7 @@ static bool opfvf_cmp_check(DisasContext *s, arg_rmrr *a)
>       return require_rvv(s) &&
>              require_rvf(s) &&
>              vext_check_isa_ill(s) &&
> -           vext_check_ms(s, a->rd, a->rs2);
> +           vext_check_ms(s, a->rd, a->rs2, a->vm);
>   }
>   
>   GEN_OPFVF_TRANS(vmfeq_vf, opfvf_cmp_check)

Reviewed-by: Nutty Liu<liujingqi@lanxincomputing.com>

Thanks,
Nutty

