Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CDED1CDA7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 06:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t38RK-0004Bd-Ae; Tue, 22 Oct 2024 02:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t38RF-0004BP-DS; Tue, 22 Oct 2024 02:32:17 -0400
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1t38RB-0004BA-MN; Tue, 22 Oct 2024 02:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1729578721; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=xFTHWmABz7tTVY3vzZrSJi7pXmKj27C/4N/K+UFrAoo=;
 b=TFkjoL3ccZX2BM8/WjmBOMXz8dFDnTgAhW9uXhfrfsWuQFnyaSYZHjVbDyDfsPYLMzhsXcTgKHGy8kR2T1fidA6G0CRpWH/FlW7PRUuVKikzeOMop9uMLJiI8LaWp+W9q74h0BT31vsvlQ/1OFzFP1GiJzhrsBoR6qWR+kSm8qQ=
Received: from 30.166.64.99(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WHgxZCG_1729578719 cluster:ay36) by smtp.aliyun-inc.com;
 Tue, 22 Oct 2024 14:32:00 +0800
Message-ID: <2fb117f7-55ca-4b07-838e-3ba629605e2b@linux.alibaba.com>
Date: Tue, 22 Oct 2024 14:31:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] tcg/riscv: Accept constant first argument to
 sub_vec
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-10-richard.henderson@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241016193140.2206352-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.30.124;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-124.freemail.mail.aliyun.com
X-Spam_score_int: -174
X-Spam_score: -17.5
X-Spam_bar: -----------------
X-Spam_report: (-17.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
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


On 2024/10/17 03:31, Richard Henderson wrote:
> Use vrsub.vi to subtract from a constant.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/riscv/tcg-target-con-set.h | 1 +
>   tcg/riscv/tcg-target.c.inc     | 8 ++++++--
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
> index 97e6ecdb0f..d8ce5414f5 100644
> --- a/tcg/riscv/tcg-target-con-set.h
> +++ b/tcg/riscv/tcg-target-con-set.h
> @@ -25,6 +25,7 @@ C_O0_I2(v, r)
>   C_O1_I1(v, r)
>   C_O1_I1(v, v)
>   C_O1_I2(v, v, v)
> +C_O1_I2(v, vK, v)
>   C_O1_I2(v, v, vK)
>   C_O1_I2(v, v, vL)
>   C_O1_I4(v, v, vL, vK, vK)
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index ce8d6d0293..1ce2f291d3 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc
> @@ -2350,7 +2350,11 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>           break;
>       case INDEX_op_sub_vec:
>           set_vtype_len_sew(s, type, vece);
> -        tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
> +        if (const_args[1]) {
> +            tcg_out_opc_vi(s, OPC_VRSUB_VI, a0, a2, a1);
> +        } else {
> +            tcg_out_opc_vv(s, OPC_VSUB_VV, a0, a1, a2);
> +        }
>           break;
>       case INDEX_op_and_vec:
>           set_vtype_len(s, type);
> @@ -2565,7 +2569,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
>       case INDEX_op_xor_vec:
>           return C_O1_I2(v, v, vK);
>       case INDEX_op_sub_vec:
> -        return C_O1_I2(v, v, v);
> +        return C_O1_I2(v, vK, v);

Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Zhiwei

>       case INDEX_op_cmp_vec:
>           return C_O1_I2(v, v, vL);
>       case INDEX_op_cmpsel_vec:

