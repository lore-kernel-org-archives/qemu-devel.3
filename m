Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4ECC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 08:00:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlNwv-0002DF-Ln; Fri, 21 Feb 2025 02:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tlNwu-0002Cu-19; Fri, 21 Feb 2025 02:59:52 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vladimir.isaev@syntacore.com>)
 id 1tlNws-0004qI-3y; Fri, 21 Feb 2025 02:59:51 -0500
Received: from pmg.syntacore.com (localhost.localdomain [127.0.0.1])
 by m.syntacore.com (Proxmox) with ESMTP id 8029DB41C1A;
 Fri, 21 Feb 2025 10:59:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:from:from:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=m; bh=/CgyW+by9AtBGWY7IZ4XLgq
 saTkzvDeiCeVqfC19aY4=; b=Q1Xrd7wNix3Y5l3P6yxyvfnZi0NIGA8zfMSjdnM
 QcyE1/cFTBMNATwv8L6LSlLjpyz0saSM0n31Ps2sgSseNSyBafIQQ/Db0LDLwO1/
 IlrJ9U74qMt+8jyZPC/r4qxkVLq8F7GaKFYQbQv9AZWdWoeJDunPyU816XsftJ9V
 Lq43IZAXBGuwlwYhcqJJabscUJB2GS2TyW+Xkais4Mid+QLe4/X73aNl4DgWF5eN
 xwEyVOGQn6Dr053Q9vu9C6XmuHpXRp7wMdh83OiApOpV8lQIa5DJKWf/aFwY09Ft
 kRC2WHCLSxgUuJgG5YLzWd/QFcUxxNCxVn9tjHDcqX0eRoQ==
Received: from S-SC-EXCH-01.corp.syntacore.com (exchange.syntacore.com
 [10.76.202.20])
 by m.syntacore.com (Proxmox) with ESMTPS id 5E680B41B9D;
 Fri, 21 Feb 2025 10:59:45 +0300 (MSK)
Received: from [10.178.157.106] (10.178.157.106) by
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Feb 2025 10:59:12 +0300
Message-ID: <8e495335-7f21-47a5-925d-09ecf4b3a08b@syntacore.com>
Date: Fri, 21 Feb 2025 10:58:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: fix C extension disabling on misa write
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 <qemu-devel@nongnu.org>
CC: <qemu-riscv@nongnu.org>, <palmer@dabbelt.com>, <alistair.francis@wdc.com>, 
 <bmeng.cn@gmail.com>, <liwei1518@gmail.com>, <zhiwei_liu@linux.alibaba.com>,
 <mjc@sifive.com>
References: <20250220163120.77328-1-vladimir.isaev@syntacore.com>
 <3ffe3ecf-4bd8-447e-a984-442c71a94f89@ventanamicro.com>
Content-Language: en-US, ru-RU
From: Vladimir Isaev <vladimir.isaev@syntacore.com>
In-Reply-To: <3ffe3ecf-4bd8-447e-a984-442c71a94f89@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.178.157.106]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=vladimir.isaev@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



20.02.2025 20:59, Daniel Henrique Barboza wrote:
> 
> 
> On 2/20/25 1:31 PM, Vladimir Isaev wrote:
>> According to spec:
>> Writing misa may increase IALIGN, e.g., by disabling the "C" extension. If an instruction that would
>> write misa increases IALIGN, and the subsequent instruction’s address is not IALIGN-bit aligned, the
>> write to misa is suppressed, leaving misa unchanged.
>>
>> So we should suppress disabling "C" if it is already enabled and
>> next instruction is not aligned to 4.
>>
>> Fixes: f18637cd611c ("RISC-V: Add misa runtime write support")
>> Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
>> ---
>>   target/riscv/csr.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index afb7544f0780..32f9b7b16f6f 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -2067,11 +2067,12 @@ static RISCVException write_misa(CPURISCVState *env, int csrno,
>>       val &= env->misa_ext_mask;
>>         /*
>> -     * Suppress 'C' if next instruction is not aligned
>> +     * Disabling 'C' increases IALIGN to 32. If subsequent instruction's address
>> +     * is not 32-bit aligned, write to misa is suppressed.
>>        * TODO: this should check next_pc
>>        */
>> -    if ((val & RVC) && (GETPC() & ~3) != 0) {
>> -        val &= ~RVC;
> 
> Not related to your changes but it would be nice if we made more use of
> QEMU_IS_ALIGNED() instead of doing these bitwise ops to check alignment.
> E.g. to check if pc is aligned to 4: QEMU_IS_ALIGNED(GETPC(), 4).

will fix, thank you!

> 
> 
>> +    if (!(val & RVC) && (env->misa_ext & RVC) && (GETPC() & 0x3)) {
>> +        return RISCV_EXCP_NONE;
>>       }
> 
> This will abort the write altogether, skipping valid changes to other bits. What
> we want is a "val &= ~RVC" if the proper conditions for clearing RVC are met.

Not sure since specification says:

> If an instruction that would write misa increases IALIGN, and the subsequent instruction’s
> address is not IALIGN-bit aligned, the write to misa is suppressed, leaving misa unchanged.

In my understanding here we should skip all changes to misa, not just C.

Thank you,
Vladimir Isaev

> 
> Thanks,
> 
> Daniel
> 
>>         /* Disable RVG if any of its dependencies are disabled */
> 
> 



