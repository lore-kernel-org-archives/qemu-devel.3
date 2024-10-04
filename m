Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C73ECFA77F
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 13:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swig2-0008Nd-PF; Fri, 04 Oct 2024 09:49:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1swig1-0008NM-AU; Fri, 04 Oct 2024 09:49:01 -0400
Received: from mta-03.yadro.com ([89.207.88.253])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <evgenii.prokopiev@syntacore.com>)
 id 1swifz-0006FZ-BX; Fri, 04 Oct 2024 09:49:01 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-03.yadro.com 79574E000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-04; t=1728049732;
 bh=CbH+BUzFMYoAoZTZfq7XLh5YiM1FPSP7QoyIDeItUJ0=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
 b=mmox61c4Er413B5tnDt/yOnV7J2Vh53zvr3U71o4SM/sLiLl6Zl572nYs0iW/Exv1
 JSaeqb0pGOLUy9K6h3AjEdFf4b3Bd0rjNm5/Lu0PN3C2F3xQ+jZWIkbAinFGiggeFL
 vPFDOSIwB/R9SU9hy/5CNXV3jIk8y0LN9a5/MSST7LIIf/wcPpbWaQhpheSlIdAuJM
 LC94Wr3hvhXDb45IldqR5Kzv4gordAQ4o9E+OTh6imwq1JcP0Hq40z0gFrNSBeXil6
 UiILAs7l54IV2ZaMnizQdQbujJss1iqSANHwf4wT1GaE0Ytzat9+I//QP7eMJ6MJwT
 tsMXz0L6z4+zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 s=mta-03; t=1728049732;
 bh=CbH+BUzFMYoAoZTZfq7XLh5YiM1FPSP7QoyIDeItUJ0=;
 h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type:From;
 b=EolURUCWmuKZHIrfXdm2KLXVWNzZFv13ptjpEu5+iQLxRfwHgpvSSQfit+H+j/aLm
 z1J+LPNUENjIVA3Pkw93k4dcE1wZfPj0MNKuuVQCzehQraHfuFqYiXTCnU/hAn4LR0
 UFZYUvPUJ0H9SV7rgaTjtHqCypxK+YRB91e2qrzBUnCBjCRTtNPeVYe0ECFAkaUsqf
 b0il6D2OW76q89lhuSQvXmZkujMIl6KF/9TSwnafPEL0UHTnP9qQZl4OeGplEsCZMV
 3t+OEYFviBYvDUy9Jhs4MxT/0ZXrvyPK8haJx4pcXQQr30d55IQdnZI25CJ+6623oK
 hNmyf1xKY5heg==
Message-ID: <44442707-dbe7-46dc-9039-2d88ec636c23@syntacore.com>
Date: Fri, 4 Oct 2024 16:48:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] target/riscv/csr.c: Fix an access to VXSAT
From: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
To: Richard Henderson <richard.henderson@linaro.org>, <alistair23@gmail.com>
CC: <alistair.francis@wdc.com>, <bmeng.cn@gmail.com>,
 <dbarboza@ventanamicro.com>, <liwei1518@gmail.com>, <palmer@dabbelt.com>,
 <qemu-devel@nongnu.org>, <qemu-riscv@nongnu.org>,
 <zhiwei_liu@linux.alibaba.com>
References: <CAKmqyKMmYPG0_jyrJFxvnxhTGTCAz4L5Lf6FouZpy3ZtywNiGA@mail.gmail.com>
 <20241002084436.89347-1-evgenii.prokopiev@syntacore.com>
 <163e6cfc-755e-487d-8653-a5524876e171@linaro.org>
 <ed5cf837-e397-44b8-b719-5c5b97646d10@syntacore.com>
Content-Language: en-US
In-Reply-To: <ed5cf837-e397-44b8-b719-5c5b97646d10@syntacore.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: T-Exch-05.corp.yadro.com (172.17.10.109) To
 T-EXCH-12.corp.yadro.com (172.17.11.143)
Received-SPF: permerror client-ip=89.207.88.253;
 envelope-from=evgenii.prokopiev@syntacore.com; helo=mta-03.yadro.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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



On 04.10.2024 16:38, Evgenii Prokopiev wrote:
> 
> 
> On 03.10.2024 23:13, Richard Henderson wrote:
>> On 10/2/24 01:44, Evgenii Prokopiev wrote:
>>> The register VXSAT should be RW only to the first bit.
>>> The remaining bits should be 0.
>>>
>>> The RISC-V Instruction Set Manual Volume I: Unprivileged Architecture
>>>
>>> The vxsat CSR has a single read-write least-significant bit (vxsat[0])
>>> that indicates if a fixed-point instruction has had to saturate an 
>>> output
>>> value to fit into a destination format. Bits vxsat[XLEN-1:1]
>>> should be written as zeros.
>>>
>>> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
>>> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>> ---
>>> Changes since v2:
>>>      - Added reviewed-by tag
>>>   target/riscv/csr.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> New versions should not be replies to previous versions.
>> No need to re-spin *only* to collect tags; tools can do that.
>>
> Hi!
> Thanks for your explanation.
>>>
>>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>>> index bd080f92b5..69c41212e9 100644
>>> --- a/target/riscv/csr.c
>>> +++ b/target/riscv/csr.c
>>> @@ -717,7 +717,7 @@ static RISCVException write_vxrm(CPURISCVState 
>>> *env, int csrno,
>>>   static RISCVException read_vxsat(CPURISCVState *env, int csrno,
>>>                                    target_ulong *val)
>>>   {
>>> -    *val = env->vxsat;
>>> +    *val = env->vxsat & BIT(0);
>>>       return RISCV_EXCP_NONE;
>>>   }
>>
>> Nit: no need to mask on read...
>>
>>> @@ -727,7 +727,7 @@ static RISCVException write_vxsat(CPURISCVState 
>>> *env, int csrno,
>>>   #if !defined(CONFIG_USER_ONLY)
>>>       env->mstatus |= MSTATUS_VS;
>>>   #endif
>>> -    env->vxsat = val;
>>> +    env->vxsat = val & BIT(0);
>>>       return RISCV_EXCP_NONE;
>>>   }
>>
>> ... because you know the value is already correct from the write.
>>
> Yes, we mask the value when we make a write. But this value could be
> changed in other places. So I added a mask when reading happens too.
> If additional verification is not required, I will delete it.
>>
>> r~

-- 
Sincerely,
Evgenii Prokopiev

