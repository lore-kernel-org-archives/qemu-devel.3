Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893EEC46CD2
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jan 2024 19:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSitI-0001mS-L0; Wed, 24 Jan 2024 14:26:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSitC-0001k8-5A
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 14:26:22 -0500
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSit8-0006AZ-CZ
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 14:26:20 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id C0BE1CE312D;
 Wed, 24 Jan 2024 19:26:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D48FC433C7;
 Wed, 24 Jan 2024 19:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706124374;
 bh=1luHflipx08MCbwskQYWL44FDmImdsKPSiQ2SiqpMTU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=nmq3HUbXIzGld9+zZrrdh3XTvYDu2bcKTpFtnnB1njrhuAZzpUqwaJk58R1Bg4968
 G9VQf8DaGxNSX7Cp3S0F073p8aqBUE8w2dUOqMqhIXr0BFKzjtf5UJ8O0I3B+3Scrt
 twz/O/hEs3LR1FbuBVmFV7PQVaMma84l9+jgvIklBTTwf3jokMiLquShNKi/EnVrPr
 LTpvm2L4LBJyPQVRG8rkrON40GwAvEot3s5SA1Bewk56YYgP2vPl+vdGDVaFw4/Fq/
 cyt3rDXosI2RKxqwda8nK3DgxVdDVdQ+KtYHGbFaA9XOeXiQEDCXKmRKZSEEjffWEA
 3+kMhp7m51WXQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Christoph =?utf-8?Q?M=C3=BCllner?=
 <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley
 <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: qemu riscv, thead c906, Linux boot regression
In-Reply-To: <78107c83-7035-414c-9a44-af5e234fd5c2@ventanamicro.com>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
 <78107c83-7035-414c-9a44-af5e234fd5c2@ventanamicro.com>
Date: Wed, 24 Jan 2024 20:26:10 +0100
Message-ID: <87wmryr0rx.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=bjorn@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:

> On 1/24/24 09:49, Bj=C3=B6rn T=C3=B6pel wrote:
>> Hi!
>>=20
>> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized that
>> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
>> ("target/riscv/cpu.c: restrict 'marchid' value")
>>=20
>> Reverting that commit, or the hack below solves the boot issue:
>>=20
>> --8<--
>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>> index 8cbfc7e781ad..e18596c8a55a 100644
>> --- a/target/riscv/cpu.c
>> +++ b/target/riscv/cpu.c
>> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>>       cpu->cfg.ext_xtheadsync =3D true;
>>=20=20=20
>>       cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>> +    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
>> +                        (QEMU_VERSION_MINOR << 8)  |
>> +                        (QEMU_VERSION_MICRO));
>>   #ifndef CONFIG_USER_ONLY
>>       set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>>   #endif
>> --8<--
>>=20
>> I'm unsure what the correct qemu way of adding a default value is,
>> or if c906 should have a proper marchid.
>
> In case you need to set a 'marchid' different than zero for c906, this ha=
ck would
> be a proper fix. As mentioned in the commit msg of the patch you mentione=
d:
>
> "Named CPUs should set 'marchid' to a meaningful value instead, and gener=
ic
>   CPUs can set to any valid value."
>
> That means that any specific marchid value that the CPU uses must to be s=
et
> in its own cpu_init() function.

Got it. Thanks, Daniel!

For completeness (since it came up on the weekly PW call); Conor pointed
out that zero *is* indeed the right marchid for c906, and in fact, the
non-zero marchid pre commit d6a427e2c0b2 was incorrect.

Post commit d6a427e2c0b2, the correct alternative is picked up, and
ERRATA_THEAD_PBMT (using non-standard memory type bits in
page-table-entries) kicks in. AFAIU, that's not implemented by qemu's
c906 support, which then traps.

That's the theory. Maybe Christoph knows if the non-standard bits are
implemented or not?

Regardless; I removed booting Qemu T-head c906 from the CI, and the
build/boot passes nicely ;-) [1]


Bj=C3=B6rn

[1] https://github.com/linux-riscv/linux-riscv/actions/runs/7641764759/job/=
20819801235?pr=3D447

