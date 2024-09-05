Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F2BCD4F4E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 01:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm1Un-0004iv-S3; Wed, 04 Sep 2024 21:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sm1Ul-0004fh-Li; Wed, 04 Sep 2024 21:41:11 -0400
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@linux.alibaba.com>)
 id 1sm1Uf-0005vq-OH; Wed, 04 Sep 2024 21:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1725500456; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=AUyvwqhWlvJm4UFDyVbmEqEJL2epIuduSJzXofegMec=;
 b=LnMdugljgTNN66fSK7ptXd2OhyVj1rLT3i8DZTk2/fJX2M+gJYzboIvo/n7Hbt/uF4PKH90SaNtFwExzVO0B0MlctCyo9KkIcOdBTddQDM+jZ4R84XMg3LjPUP9+DS6/q0V1ghLLru0wC82KtvQNTKzQiaA7hgXFmSs+G3Oqfgc=
Received: from 30.251.160.182(mailfrom:zhiwei_liu@linux.alibaba.com
 fp:SMTPD_---0WEJILUN_1725500454) by smtp.aliyun-inc.com;
 Thu, 05 Sep 2024 09:40:55 +0800
Message-ID: <ebfc53b7-6076-4f26-aa0c-879aa9c1158b@linux.alibaba.com>
Date: Thu, 5 Sep 2024 09:40:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] tcg/riscv: Implement vector roti/v/x shi ops
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240830061607.1940-1-zhiwei_liu@linux.alibaba.com>
 <20240830061607.1940-14-zhiwei_liu@linux.alibaba.com>
 <97873524-9e47-44c4-b34a-a27e9833b0e1@linaro.org>
 <141dbbff-55f6-4628-9701-554b0d32440d@linux.alibaba.com>
 <ea3474ab-947c-492e-b264-0fff3fcd30f7@linaro.org>
Content-Language: en-US
From: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
In-Reply-To: <ea3474ab-947c-492e-b264-0fff3fcd30f7@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=115.124.30.97;
 envelope-from=zhiwei_liu@linux.alibaba.com;
 helo=out30-97.freemail.mail.aliyun.com
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


On 2024/9/5 3:05, Richard Henderson wrote:
> On 9/4/24 08:25, LIU Zhiwei wrote:
>>> I'm trying to work out how much benefit there is here of expanding 
>>> these early, as opposed to simply using TCG_REG_TMP0 when the 
>>> immediate doesn't fit,
>>
>> We find for rotli,  it just copied code from the implementation of 
>> INDEX_op_shli_vec and INDEX_op_shri_vec if we don't expand it.
>>
>>    case INDEX_op_rotli_vec:
>>          if (a2 > 31) {
>>              tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, 
>> a2);
>>              tcg_out_opc_vx(s, OPC_VSLL_VX, TCG_REG_V0, a1, 
>> TCG_REG_TMP0, true);
>>          } else {
>>              tcg_out_opc_vi(s, OPC_VSLL_VI, TCG_REG_V0, a1, a2, true);
>>          }
>>
>>          if ((8 << vece) - a2) > 31) {
>>              tcg_out_opc_imm(s, OPC_ADDI, TCG_REG_TMP0, TCG_REG_ZERO, 
>> 8 << vece) - a2);
>>              tcg_out_opc_vx(s, OPC_VSRL_VX, a0, a1, TCG_REG_TMP0, true);
>>          } else {
>>              tcg_out_opc_vi(s, OPC_VSRL_VI, a0, a1, 8 << vece) - a2, 
>> true);
>>          }
>>          tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0, true);
>>          break;
>>
>> Thus, I prefer to expand it early, at least for rotli_vec.
>
> static void tcg_out_vshifti(TCGContext *s, RISCVInsn op_vi, RISCVInsn 
> op_vx,
>                             TCGReg dst, TCGReg src, unsigned imm)
> {
>     if (imm < 32) {
>         tcg_out_opc_vi(s, op_vi, dst, src, imm);
>     } else {
>         tcg_out_movi(s, TCG_TYPE_I32, TCG_REG_TMP0, imm);
>         tcg_out_opc_vx(s, op_vx, dst, src, TCG_REG_TMP0);
>     }
> }
>
>
Thanks for the guide.
> case INDEX_op_shli_vec:
>         set_vconfig_vl_sew(s, type, vece);
>         tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, a0, a1, a2);
>         break;
>
>     case INDEX_op_rotli_vec:
>         set_vconfig_vl_sew(s, type, vece);
>         tcg_out_vshifti(s, OPC_VSLL_VI, OPC_VSLL_VX, TCG_REG_V0, a1, a2);
>         a2 = -a2 & ((8 << vece) - 1);
>         tcg_out_vshifti(s, OPC_VSRL_VI, OPC_VSRL_VX, a0, a1, a2);
>         tcg_out_opc_vv(s, OPC_VOR_VV, a0, a0, TCG_REG_V0);
>         break;

OK. We will take this way.

Thanks,
Zhiwei

>
> r~

