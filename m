Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690ACC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2026 13:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdTB5-0002Ym-7T; Sat, 27 Jun 2026 09:34:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wdTAp-0002XU-Ve; Sat, 27 Jun 2026 09:34:27 -0400
Received: from [115.124.30.112] (helo=out30-112.freemail.mail.aliyun.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lyndra@linux.alibaba.com>)
 id 1wdTAi-0007VO-8L; Sat, 27 Jun 2026 09:34:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1782567217; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
 bh=2ejNFl09eg25wXLOtXnqOqzhY1La7fFxa8mBuSR+vh8=;
 b=n62tZkOoo02Dpi4BE6/kvFUgR9aUCM3RM1Cr6E/StKXLNQWk9JwHyMYdExlLR96abo+Ntt7WdJKMtCS/FsV0/WYiutO1zYe6PjHqLXd9xpGKR235XsNfItK00Sx11oiWJ5rWzg0lbyVUmlfvOkEjQ9qvLRfOQQaADSO4c2TVI5Q=
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=maildocker-contentspam033037033178;
 MF=lyndra@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0X5hLGTE_1782567214; 
Received: from 30.134.91.14(mailfrom:lyndra@linux.alibaba.com
 fp:SMTPD_---0X5hLGTE_1782567214 cluster:ay36) by smtp.aliyun-inc.com;
 Sat, 27 Jun 2026 21:33:34 +0800
Message-ID: <28a2dc5e-36f6-473e-9157-357557bc2e25@linux.alibaba.com>
Date: Sat, 27 Jun 2026 21:33:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] disas/riscv: Fix 6-bit immediate extraction
To: Richard Henderson <richard.henderson@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org
References: <20260626-b4-disas-xthead-fix-riscv-next-v1-0-74228a3c1b21@linux.alibaba.com>
 <20260626-b4-disas-xthead-fix-riscv-next-v1-2-74228a3c1b21@linux.alibaba.com>
 <1d9f53ca-4dbc-4d64-9811-17bf0328cb3a@oss.qualcomm.com>
 <c25526b6-885f-4c13-b4e2-ef423d2feffe@linaro.org>
From: TianCheng TANG <lyndra@linux.alibaba.com>
In-Reply-To: <c25526b6-885f-4c13-b4e2-ef423d2feffe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 115.124.30.112 (deferred)
Received-SPF: pass client-ip=115.124.30.112;
 envelope-from=lyndra@linux.alibaba.com;
 helo=out30-112.freemail.mail.aliyun.com
X-Spam_score_int: -166
X-Spam_score: -16.7
X-Spam_bar: ----------------
X-Spam_report: (-16.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, ENV_AND_HDR_SPF_MATCH=-0.5,
 RCVD_IN_DNSWL_NONE=-0.0001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


在 2026/6/27 06:47, Richard Henderson 写道:
> On 6/26/26 13:04, Daniel Henrique Barboza wrote:
>>
>>
>> On 6/26/2026 12:13 AM, TANG Tiancheng wrote:
>>> rv_codec_r2_imm6 is used for XThead instructions whose 6-bit
>>> immediate field is encoded in bits 25:20. The old expression
>>> left-shifted by 38 and then right-shifted by 60, so it kept only
>>> bits 25:22.
>>>
>>> Shift right by 58 instead, keeping the existing extraction style while
>>> retaining the full bits 25:20 field. This fixes the immediate printed
>>> for th.srri and th.tst.
>>>
>>> Fixes: 318df7238b9f ("disas/riscv: Add support for XThead* 
>>> instructions")
>>> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
>>> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
>>> ---
>>
>> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>>
>>>   disas/riscv.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/disas/riscv.c b/disas/riscv.c
>>> index 
>>> 7f1b26277378c225c963d8f435cc7a2fc6e4a0b8..400a57083f90be18ccd12415797bce0df974784b 
>>> 100644
>>> --- a/disas/riscv.c
>>> +++ b/disas/riscv.c
>>> @@ -4546,7 +4546,7 @@ static uint32_t operand_zcmp_rlist(rv_inst inst)
>>>   static uint32_t operand_imm6(rv_inst inst)
>>>   {
>>> -    return (inst << 38) >> 60;
>>> +    return (inst << 38) >> 58;
>>>   }
>>>   static uint32_t operand_imm2(rv_inst inst)
>>>
>>
>>
>
> Really, all of these should be using (s)extract32.
>
Thanks, agreed.

For v2 I will keep the immediate extraction fix as a minimal correctness
change, and add a separate cleanup patch converting the replaceable operand
helper bit extraction to extract32()/sextract32(), including split 
immediates.

I'll credit your suggestion in the cleanup patch with a Suggested-by tag.


Regards,

TianCheng

>
> r~

