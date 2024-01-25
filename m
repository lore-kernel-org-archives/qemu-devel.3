Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147E2C47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 08:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSvPU-0003tp-EL; Thu, 25 Jan 2024 03:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSvPL-0003mR-Op
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:48:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bjorn@kernel.org>) id 1rSvPJ-0002M3-AD
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 03:48:23 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A56C06213C;
 Thu, 25 Jan 2024 08:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C75C43390;
 Thu, 25 Jan 2024 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1706172499;
 bh=WEbO64N/RmnNRPLXNfI9QQWt4WdGLQ0o/XwARVfsNcQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=rDtcfwquf21WLdYSRVQSuChE53Q9rddnixjycGT5AcX2jLKdi3sBLdLBtpQvPQsRf
 aLSEBUTqg8joHfxLCNEOLImL00k6ahtS2CpigSt3yVvm+dPIRHscen26VoryYRFOVx
 pnf7NfW1XhT+2mslKdIUcGAw+rbhmeKuAFKTSIHIkh5XHB96aTqt7GO9sNotce6TPT
 IFQChfSE6wZkrJPUEB4XjnjaZqRxnpD479vpzO6X/c9dj5FgNwlD6lqTp0GL1rAfVJ
 kkdIS3I48jS3V8FAB2xIOn09DgEsDbkKqiU9asWE7ZJIm7z4/3+4NgOlwLDJDGFzsa
 RoqgFV0E+86Tg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 qemu-devel@nongnu.org, Christoph =?utf-8?Q?M=C3=BCllner?=
 <christoph.muellner@vrull.eu>
Cc: linux-riscv@lists.infradead.org, LIU Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley
 <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: qemu riscv, thead c906, Linux boot regression
In-Reply-To: <08188a93-0d5b-40bf-aefb-ac74d9c3d0be@ventanamicro.com>
References: <874jf2rj4g.fsf@all.your.base.are.belong.to.us>
 <78107c83-7035-414c-9a44-af5e234fd5c2@ventanamicro.com>
 <87wmryr0rx.fsf@all.your.base.are.belong.to.us>
 <08188a93-0d5b-40bf-aefb-ac74d9c3d0be@ventanamicro.com>
Date: Thu, 25 Jan 2024 09:48:16 +0100
Message-ID: <87y1cd4x4f.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=139.178.84.217; envelope-from=bjorn@kernel.org;
 helo=dfw.source.kernel.org
X-Spam_score_int: -85
X-Spam_score: -8.6
X-Spam_bar: --------
X-Spam_report: (-8.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On 1/24/24 16:26, Bj=C3=B6rn T=C3=B6pel wrote:
>> Daniel Henrique Barboza <dbarboza@ventanamicro.com> writes:
>>=20
>>> On 1/24/24 09:49, Bj=C3=B6rn T=C3=B6pel wrote:
>>>> Hi!
>>>>
>>>> I bumped the RISC-V Linux kernel CI to use qemu 8.2.0, and realized th=
at
>>>> thead c906 didn't boot anymore. Bisection points to commit d6a427e2c0b2
>>>> ("target/riscv/cpu.c: restrict 'marchid' value")
>>>>
>>>> Reverting that commit, or the hack below solves the boot issue:
>>>>
>>>> --8<--
>>>> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
>>>> index 8cbfc7e781ad..e18596c8a55a 100644
>>>> --- a/target/riscv/cpu.c
>>>> +++ b/target/riscv/cpu.c
>>>> @@ -505,6 +505,9 @@ static void rv64_thead_c906_cpu_init(Object *obj)
>>>>        cpu->cfg.ext_xtheadsync =3D true;
>>>>=20=20=20=20
>>>>        cpu->cfg.mvendorid =3D THEAD_VENDOR_ID;
>>>> +    cpu->cfg.marchid =3D ((QEMU_VERSION_MAJOR << 16) |
>>>> +                        (QEMU_VERSION_MINOR << 8)  |
>>>> +                        (QEMU_VERSION_MICRO));
>>>>    #ifndef CONFIG_USER_ONLY
>>>>        set_satp_mode_max_supported(cpu, VM_1_10_SV39);
>>>>    #endif
>>>> --8<--
>>>>
>>>> I'm unsure what the correct qemu way of adding a default value is,
>>>> or if c906 should have a proper marchid.
>>>
>>> In case you need to set a 'marchid' different than zero for c906, this =
hack would
>>> be a proper fix. As mentioned in the commit msg of the patch you mentio=
ned:
>>>
>>> "Named CPUs should set 'marchid' to a meaningful value instead, and gen=
eric
>>>    CPUs can set to any valid value."
>>>
>>> That means that any specific marchid value that the CPU uses must to be=
 set
>>> in its own cpu_init() function.
>>=20
>> Got it. Thanks, Daniel!
>>=20
>> For completeness (since it came up on the weekly PW call); Conor pointed
>> out that zero *is* indeed the right marchid for c906, and in fact, the
>> non-zero marchid pre commit d6a427e2c0b2 was incorrect.
>>=20
>> Post commit d6a427e2c0b2, the correct alternative is picked up, and
>> ERRATA_THEAD_PBMT (using non-standard memory type bits in
>> page-table-entries) kicks in. AFAIU, that's not implemented by qemu's
>> c906 support, which then traps.
>
>
> This looks like a very good reason to actually push what you called 'hack=
' as
> a fix. Yeah, in theory that commit did nothing wrong, but the side effect
> (missing support for non-standard memory type bits) is kind of a QEMU pro=
blem.

For me, it'd be weird to add the hack (setting marchid to non-zero).
Claiming that it's a "thead-c906 emulation" in qemu, but w/o the proper
page-bit support. That's just cpu rv64 plus some extra instructions --
not the c906.


Bj=C3=B6rn

