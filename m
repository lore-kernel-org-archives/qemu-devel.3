Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23822C27C79
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 02:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJOai-0006qm-OJ; Mon, 17 Jun 2024 22:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1sJOag-0006qI-8S
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 22:28:58 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1sJOad-0004Cc-Dd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 22:28:58 -0400
Received: from loongson.cn (unknown [10.20.42.239])
 by gateway (Coremail) with SMTP id _____8DxFPDe8HBmeckHAA--.31285S3;
 Tue, 18 Jun 2024 10:28:47 +0800 (CST)
Received: from [10.20.42.239] (unknown [10.20.42.239])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxZcXc8HBmAbYmAA--.17316S3; 
 Tue, 18 Jun 2024 10:28:46 +0800 (CST)
Subject: Re: [PATCH 13/18] tcg/loongarch64: Split out vdvjvk in tcg_out_vec_op
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: git@xen0n.name
References: <20240527211912.14060-1-richard.henderson@linaro.org>
 <20240527211912.14060-14-richard.henderson@linaro.org>
From: gaosong <gaosong@loongson.cn>
Message-ID: <7494ab33-5dad-a11c-1614-a640213cc3f9@loongson.cn>
Date: Tue, 18 Jun 2024 10:28:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20240527211912.14060-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxZcXc8HBmAbYmAA--.17316S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKFW5Jr45XF4xJF1ftr43urX_yoWDGFgEyr
 45WFy7tw47trsFvasxAr4rGrn5Grs0gr4ag3Wvv3W3GryDAryrGayUGF93Xr9Fqa4xJrWY
 93srW3s7A3WIkosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
 s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
 cSsGvfJTRUUUbxAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
 vaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
 w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
 W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4
 CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
 67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MI
 IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
 14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
 W8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UNvtZU
 UUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.388,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

在 2024/5/28 上午5:19, Richard Henderson 写道:
>       case INDEX_op_andc_vec:
>           /*
>            * vandn vd, vj, vk: vd = vk & ~vj
>            * andc_vec vd, vj, vk: vd = vj & ~vk
> -         * vk and vk are swapped
> +         * vj and vk are swapped
>            */
> -        tcg_out_opc_vandn_v(s, a0, a2, a1);
> -        break;
> +        a1 = a2;
> +        a2 = args[2];
Should be args[1]?  Similar to op_not_vec 'a2 = a1'.

Thanks.
Song Gao
> +        insn = OPC_VANDN_V;
> +        goto vdvjvk;
>       case INDEX_op_or_vec:
> -        tcg_out_opc_vor_v(s, a0, a1, a2);
> -        break;
> +        insn = OPC_VOR_V;
> +        goto vdvjvk;
>       case INDEX_op_orc_vec:
> -        tcg_out_opc_vorn_v(s, a0, a1, a2);
> -        break;
> +        insn = OPC_VORN_V;
> +        goto vdvjvk;
>       case INDEX_op_xor_vec:
> -        tcg_out_opc_vxor_v(s, a0, a1, a2);
> -        break;
> -    case INDEX_op_nor_vec:
> -        tcg_out_opc_vnor_v(s, a0, a1, a2);
> -        break;
> +        insn = OPC_VXOR_V;
> +        goto vdvjvk;
>       case INDEX_op_not_vec:
> -        tcg_out_opc_vnor_v(s, a0, a1, a1);
> -        break;
> +        a2 = a1;
> +        /* fall through */
> +    case INDEX_op_nor_vec:
> +        insn = OPC_VNOR_V;
> +        goto vdvjvk;


