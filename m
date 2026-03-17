Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E652FED9EE
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2XiZ-0005qk-Da; Tue, 17 Mar 2026 12:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1w2XiX-0005qY-63; Tue, 17 Mar 2026 12:56:29 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1w2XiU-0008C6-81; Tue, 17 Mar 2026 12:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1773766127;
 bh=s0PFxc3yTdW5WkBM38OcskusrUUjKRZjQoqM1P8mMmo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AbcQHAnXU52+shjczZxkl7tUTr+BFRVfEBJ+S2BIiY+oEXRWqNSYAu+nQFEUrZydf
 5PJKwNPJkzNWDhG5eDnKiPaymjXa8TG2MDc+drRaC6/OBEQeiJWe+M+11q0DQWbNW1
 EL7HgQznCuwY6dY9zqsdrambYJjFihPQ4a0UEa6/l+SVXmpHtqjLcgeE4hiRvuTRpd
 t+RsAKi3T0cNrpGRaNy7KmHx8f87cCEvxHsbeqjJm3JCH7TAhw1ndrEOHnEaZ74Y9M
 aYittP5YEvZ+XJ3MG8gWqEPbNE5v9RxK0alR9/JIMzdk5Oen+ppte8ZpfNTgSk2/79
 XdzTdDQc0Dovg==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 1CE70402BE;
 Tue, 17 Mar 2026 17:48:47 +0100 (CET)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 18C25FF853;
 Tue, 17 Mar 2026 17:48:47 +0100 (CET)
Received: from [147.171.165.115] (pers-165-115.vpn.u-ga.fr [147.171.165.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 77BC21400DB;
 Tue, 17 Mar 2026 17:48:46 +0100 (CET)
Message-ID: <27b3c263-45eb-4adc-9fc6-5693bed31345@univ-grenoble-alpes.fr>
Date: Tue, 17 Mar 2026 17:48:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/riscv: Restrict access to RV128 registers on
 RV32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260315165949.40027-1-philmd@linaro.org>
 <35544128-3c7f-48b2-a67f-9253cf8f5df0@univ-grenoble-alpes.fr>
 <abfb425a-50b3-4807-b600-6977b8d1f2fe@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <abfb425a-50b3-4807-b600-6977b8d1f2fe@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks Phil,

On 3/17/26 11:05, Philippe Mathieu-Daudé wrote:
> Hi Frédéric,
> 
> On 15/3/26 19:55, Frédéric Pétrot wrote:
>> Hi Phil,
>>
>>    my understanding is that rv128 makes no sense with rv32, and
>>    the user is not expected to run qemu-system-riscv32 with
>>    the -cpu=x-rv128 (it triggers an "unable to find CPU model
>>    'x-rv128'" error).
>>    The rv128 code just relies on XLEN being 128, and assumes
>>    (implicitely I admit) running on a 64-bit host machine, so
>>    with tl = 64.
>>    The code is absolutely erroneous when tl = 32, agreed.
>>    The thing is that, as we want to get rid of the
>>    TARGET_RISCV64/TARGET_RISCV32 defines, the rv128 specific
>>    code still must compile whatever tl, so that qemu can be built.
>>    However, it should never be executed if tl = 32.
>>    Typically, the patches I sent earlier this year to deal
>>    with lq/sq endianness fit into that 'compile only' category
>>    for rv32.
> 
> I'd really like to include your patch which fixes the endianness
> issue I reported, but unfortunately as reported it doesn't even
> build for rv32 builds:
> 
> https://lore.kernel.org/qemu-devel/ad717d8c-a6b9-4dd8-a4bd-fdd6d1d756a5@linaro.org/

   Very sorry for that.
   I took care of the errors in a later patch you might have
   missed :
  
https://lore.kernel.org/qemu-devel/20260101181442.2489496-1-frederic.petrot@univ-grenoble-alpes.fr/

   This compiles fine on Alister current riscv-to-apply.next
   branch for both 32 and 64 bit versions (known that the
   32 bit version does nothing useful, but is never used
   anyway).

> 
> Which is why I'm trying to restrict RV128 on rv32 binary so
> we can apply your other patch.
> 
> Anyway, Daniel suggestions to use 'get_xl(ctx) == MXL_RV32'
> instead of this ugly TARGET_RISCV32 #ifdef'ry is certainly
> the way to go (which is why I posted this as RFC).

   It might, indeed.
   Thanks again for your time,
   Frédéric

> 
>>
>>    Thanks,
>>    Frédéric
>>
>> On 3/15/26 17:59, Philippe Mathieu-Daudé wrote:
>>> One half of 128-bit registers code is not reachable for CPUs
>>> running in 32-bit mode, while the other half is completely
>>> broken (handled as a pair of 32-bit registers).
>>> Better restrict this code on 32-bit builds until RV128 is
>>> properly implemented.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>> More than 1y having issue with the 128-bit code path and
>>> the single binary effort. Fortunately while I dunno how to
>>> test 128-bit I could with 32/64 bits.
>>> ---
>>>   target/riscv/cpu.h                          |  2 ++
>>>   target/riscv/machine.c                      |  4 +++
>>>   target/riscv/monitor.c                      |  4 +++
>>>   target/riscv/translate.c                    | 31 +++++++++++++++++++--
>>>   target/riscv/insn_trans/trans_rvzacas.c.inc |  2 ++
>>>   5 files changed, 41 insertions(+), 2 deletions(-)
> 
> 
> 
> 
> 

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


