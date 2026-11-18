Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612D606A33F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 14:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=Ln5CPB/N
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTgl7-0006UD-J9; Wed, 18 Nov 2026 09:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTgkP-00065u-7A; Wed, 18 Nov 2026 09:35:04 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xTgkL-000872-7p; Wed, 18 Nov 2026 09:34:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795012486; bh=NcFiA+dhP5i9p8TWr3SyRIutCyaFeO7yISqOtkZXiTM=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To;
 b=Ln5CPB/NGFInQV56g6exPvWiLkXM9fN2ZgNQw5UZkh/sU0/qUK1eTzkTmRyer0BnW
 r9ZBRBbqIDifwOam5xQf1Ewqo6zVOXYM6URC9knU4YbsggipN/Luw3sIBcSXyOEQCv
 TPlwA2PGHa8bbfuOBHL99vfQ8+/0z3dnQ6rnKZE15TqlS/lb2I6QqRFhs3GIKVvTUv
 9mecNLM6pz6bRMkKu2J5rIOxFaxIK1JYCmjXBjZkl3EaxpROZKsq97ETwJrQWekyqh
 htmofJPBnocE+fHp80TN1wcaJEM2jQZjXZ9DbtdfON9WwplfEkopbyaeZ5tkEAL8/0
 5i7G1vpORErDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E289C1E7B08;
 Wed, 18 Nov 2026 17:34:46 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id CB04C46110A;
 Wed, 18 Nov 2026 17:34:46 +0300 (MSK)
Message-ID: <5f508944-1398-4163-9c72-ba7970640c6b@tls.msk.ru>
Date: Wed, 18 Nov 2026 17:34:46 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] tcg/riscv64: Fix vector immediate handling
From: Michael Tokarev <mjt@tls.msk.ru>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <d16001a6-d66c-4af5-8e61-35484b24c37c@tls.msk.ru>
Content-Language: en-US, ru-RU
In-Reply-To: <d16001a6-d66c-4af5-8e61-35484b24c37c@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 17:32, Michael Tokarev wrote:
> On 10/28/26 17:33, Philippe Mathieu-Daudé wrote:
>> The riscv64 backend mishandles constant operands of RVV .vi forms:
>>
>> - logical ops apply the immediate at a stale SEW (wrong results,
>>    since v9.2);
>> - arithmetic, compare and select ops encode the whole replicated
>>    64-bit constant instead of one element;
>> - shifts take uimm5, but the encoder checks for simm5.
>>
>> 1-2: add a uimm5 encoder for shifts,
>> 3-4: extract one element (vec_imm()) for arithmetic and compare/select,
>> 5: follow rth suggestion of adding a new constraint to pick the smallest
>>     element size at which the constant replicates as a simm5, and the
>>     emitter switches SEW to it,
>> 6: AI-generated regression test.
>>
>> Tested with qemu-aarch64 built for a riscv64 host (debug-TCG), run
>> under qemu-riscv64 -cpu max: the new test fails or aborts before the
>> series, and passes with it at every SVE vector length.
>>
>> [1] https://lore.kernel.org/qemu-devel/20261010174742.3552498-1-aurelien@aurel32.net/
>> Supersedes: <20261010174742.3552498-1-aurelien@aurel32.net>
>>
>> Philippe Mathieu-Daudé (6):
>>    tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
>>    tcg/riscv64: Use a uimm5 encoder for vector shift immediates
>>    tcg/riscv64: Extract elements for vector arithmetic immediates
>>    tcg/riscv64: Fix constant handling in vector comparisons and selects
>>    tcg/riscv64: Fix logical vector immediate matching and emission
>>    tests/tcg/aarch64: Add vector immediate regression tests
> 
> Hi!
> 
>  From this patchset, 5/6 "Fix logical vector immediate matching and emission" is
> marked for-stable.  However, it uses a function (vec_imm) which is introduced in
> 3/6  "Fix logical vector immediate matching and emission".  Obviously, just 5/6
> alone wont work.
> 
> However, it feels like whole patchset should be picked up for the stable series,
> not just a single patch - because the whole thing fixes an assortment of problems
> in this area.

Aha, so the other patches fixes ussues introduced after the last qemu releases.
So..

> Alternatively I can pick just this function from 3/6, which does not feel right.

This seems to be the right way to go.

Thanks,

/mjt

