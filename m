Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BC77C36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 18:25:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1UfX-0006J7-6Q; Sun, 06 Apr 2025 14:24:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1u1UfV-0006Iu-C8; Sun, 06 Apr 2025 14:24:29 -0400
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <frederic.petrot@univ-grenoble-alpes.fr>)
 id 1u1UfS-0007FN-En; Sun, 06 Apr 2025 14:24:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=univ-grenoble-alpes.fr; s=2020; t=1743963860;
 bh=/pOcoCgeS4hAxj68GngkeRVN+S8O8o+UHlsW9vdToxw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Gr8lIIuxLkY1ubDpiqf2UBIuS+jhZgFW5X89w3eOHw6sl7CqEqCWXyo6SKEeF81wF
 O0H8ck69tPnn3AmwqCe7AlVfu9VoTya8TAqG1UHg7wOBArC00zjHJG1iRXpB2+/dXz
 6p0uCLY80yKQLxsUPo6QSqvUP3h7mtepDULzWpnksW7X9qQkOh6aqOfIC/jH8E5rmz
 O8qgMXtV5tJFp0SnRm71oKOdjtaxIuH+PA+SnPGzH2GDNmZ00Tsl3eG4CllYgyNWc2
 M1BNkyeSlGXHEaKlWF3jU3vSiNhSaSe9HWZQWq/6C0iKxp7NzrYqCzCeUsutim9uBy
 SgZCD0y3P+OSw==
Received: from mailhub-2.u-ga.fr (mailhub-2.u-ga.fr [129.88.178.102])
 by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 7A7B040212;
 Sun,  6 Apr 2025 20:24:20 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps2.u-ga.fr [152.77.18.2])
 by mailhub-2.u-ga.fr (Postfix) with ESMTP id 7656AFF853;
 Sun,  6 Apr 2025 20:24:20 +0200 (CEST)
Received: from [192.168.1.62] (35.201.90.79.rev.sfr.net [79.90.201.35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: petrotf@univ-grenoble-alpes.fr)
 by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 824551400B0;
 Sun,  6 Apr 2025 20:24:19 +0200 (CEST)
Message-ID: <9ae32149-fe18-49d3-a689-60ee6752c20d@univ-grenoble-alpes.fr>
Date: Sun, 6 Apr 2025 20:24:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 00/18] Adding partial support for 128-bit riscv target
To: Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, bin.meng@windriver.com,
 richard.henderson@linaro.org, palmer@dabbelt.com,
 fabien.portas@grenoble-inp.org, alistair.francis@wdc.com,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>
References: <20220106210108.138226-1-frederic.petrot@univ-grenoble-alpes.fr>
 <c5c8566a-fd0d-48d1-8ed1-e52f0bb4f210@linaro.org>
 <CAKmqyKN51+jriKkSL8V5EFc9hBSFoEHYKp-70uP6RvO_K6a=pg@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?RnLDqWTDqXJpYyBQw6l0cm90?=
 <frederic.petrot@univ-grenoble-alpes.fr>
In-Reply-To: <CAKmqyKN51+jriKkSL8V5EFc9hBSFoEHYKp-70uP6RvO_K6a=pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (petrotf@univ-grenoble-alpes.fr)
 via submission-587 ACL (41)
Received-SPF: pass client-ip=152.77.200.56;
 envelope-from=frederic.petrot@univ-grenoble-alpes.fr;
 helo=zm-mta-out-3.u-ga.fr
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.01,
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

Hi Alistair, Phil,
well, I'm trying to keep the thing alive, checking from time to time that
the current QEMU still runs the 128-bit tests that I have, and on which
I continue (slowly) to do stuffs.
I hope this can stay upstream for experimental/research purposes, but the
128-bit riscv community is, I follow you on that, scarce for now.

So, your call.
Cheers,
Frédéric

Le 04/04/2025 à 05:26, Alistair Francis a écrit :
> On Sat, Mar 22, 2025 at 1:09 AM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>
>> Hi,
>>
>> On 6/1/22 22:00, Frédéric Pétrot wrote:
>>> This series of patches provides partial 128-bit support for the riscv
>>> target architecture, namely RVI and RVM, with minimal csr support.
>>
>>
>>> Frédéric Pétrot (18):
>>>     exec/memop: Adding signedness to quad definitions
>>>     exec/memop: Adding signed quad and octo defines
>>>     qemu/int128: addition of div/rem 128-bit operations
>>>     target/riscv: additional macros to check instruction support
>>>     target/riscv: separation of bitwise logic and arithmetic helpers
>>>     target/riscv: array for the 64 upper bits of 128-bit registers
>>>     target/riscv: setup everything for rv64 to support rv128 execution
>>
>>
>> I see this series has been merged as commit afe33262585, with
>> 332dab68785b describing:
>>
>>       This patch adds the support of the '-cpu rv128' option to
>>       qemu-system-riscv64 so that we can indicate that we want to
>>       run rv128 executables.
>>
>>       Still, there is no support for 128-bit insns at that stage
>>       so qemu fails miserably (as expected) if launched with this
>>       option.
>>
>> Is this code tested? 3 years passed so I wonder about possible
>> code bitrot here.
> 
>  From memory at the time there was some momentum for RV128. So this was
> merged with the expectation that it would continue to improve.
> 
> That doesn't seem to have happened, either software or spec wise though.
> 
>>
>> (I reached this code by looking at targets not supporting MTTCG).
> 
> I'm happy to remove the CPU if it's blocking you, it's experimental so
> it doesn't need to be deprecated or anything fancy.
> 
> Alistair
> 
>>
>>>     target/riscv: moving some insns close to similar insns
>>>     target/riscv: accessors to registers upper part and 128-bit load/store
>>>     target/riscv: support for 128-bit bitwise instructions
>>>     target/riscv: support for 128-bit U-type instructions
>>>     target/riscv: support for 128-bit shift instructions
>>>     target/riscv: support for 128-bit arithmetic instructions
>>>     target/riscv: support for 128-bit M extension
>>>     target/riscv: adding high part of some csrs
>>>     target/riscv: helper functions to wrap calls to 128-bit csr insns
>>>     target/riscv: modification of the trans_csrxx for 128-bit support
>>>     target/riscv: actual functions to realize crs 128-bit insns
>>
>>

-- 
+---------------------------------------------------------------------------+
| Frédéric Pétrot,                        Pr. Grenoble INP-UGA@Ensimag/TIMA |
| Mob/Pho: +33 6 74 57 99 65/+33 4 76 57 48 70      Ad augusta  per angusta |
| http://tima.univ-grenoble-alpes.fr frederic.petrot@univ-grenoble-alpes.fr |
+---------------------------------------------------------------------------+


