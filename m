Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A296CCA472
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 13:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UYU-0000EL-Fr; Wed, 08 Oct 2025 09:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v6UYR-0000A8-6q
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:50:07 -0400
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1v6UYH-0000EG-AV
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 09:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1759931385; x=1760536185; i=deller@gmx.de;
 bh=TMZZoNous1EsSpdaAkEDM+EjHLwZkCKAC7LSQTuJt4I=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=bQ7Bacp/4NyEOAtbe3aWf9+CiyoZ4Y7+BETcALj1+8KWrTPJQkyPYKgNuTRWdWeT
 1vERihVCwUWTJoqr54LHYTSRLXBgV5ICjRonIGhW+IB+sEBCvhk34YQo3O2Jf+UlF
 BkfQQVSMuBvFRv43sdVX++MAHzaYOufaF7/wpzghXgyWiDL/VLstMRpdVIDrJXvxI
 AuFUzCeLamaK/Audo2MAT84aMGY28Gt8mWl7NTRhKEuGHRslaI10brwhhYxtjtGRw
 tiaohROBexm4njGfLdix5tUabP6eUQeYXf0LxZNaZZSmk6D6sy1ZTHSPShtxVsYIH
 YyGxpjPcMvINePNnvw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [10.8.0.6] ([78.94.87.245]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoN2-1v0QWs45sk-00AOjD; Wed, 08
 Oct 2025 15:49:45 +0200
Message-ID: <e11fbe55-2768-4acd-9ec3-37eb0ae14d7a@gmx.de>
Date: Wed, 8 Oct 2025 15:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/hppa: Fix booting Linux kernel with initrd
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 deller@kernel.org, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20250122180913.18667-1-deller@kernel.org>
 <20250122180913.18667-3-deller@kernel.org>
 <8eb571a6-f48c-4083-85ef-3e92603c84d1@linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <8eb571a6-f48c-4083-85ef-3e92603c84d1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j/gZTFxDhS1NjduZoFFN/+s3DqkVHJGQZeZvRnXudFgNZAoj5Ss
 XjQPLQY89C2MG1NUl0AFiBBy7288hlHE4KOROIbddLfJMTTcr9Uc/Uem1cNHguHGBHjflVo
 3U1aSxGmdoM8aO8DRkj5Vj9eBvmMF97MQJ+vTCbIA/ipheFYxnNTtDSSfTlB3kCApP4jGxK
 iktIc0E3yli9bieoV1LQA==
UI-OutboundReport: notjunk:1;M01:P0:rELGIZByexQ=;1emP67Lyj1UPuhrb16ZYOfohJsU
 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
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Philippe,

On 10/8/25 15:43, Philippe Mathieu-Daud=C3=A9 wrote:
> On 22/1/25 19:09, deller@kernel.org wrote:
>> From: Helge Deller <deller@gmx.de>
>>
>> Commit 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
>> broke booting the Linux kernel with initrd which may have been provided
>> on the command line. The problem is, that the mentioned commit zeroes
>> out initial registers which were preset with addresses for the Linux
>> kernel and initrd.
>>
>> Fix it by adding proper variables which are set shortly before starting
>> the firmware.
>>
>> Signed-off-by: Helge Deller <deller@gmx.de>
>> Fixes: 20f7b890173b ("hw/hppa: Reset vCPUs calling resettable_reset()")
>> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>> ---
>> =C2=A0 hw/hppa/machine.c | 48 +++++++++++++++++++----------------------=
=2D-----
>> =C2=A0 target/hppa/cpu.h |=C2=A0 4 ++++
>> =C2=A0 2 files changed, 23 insertions(+), 29 deletions(-)
>>
>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>> index 4bcc66cd6f..0dd1908214 100644
>> --- a/hw/hppa/machine.c
>> +++ b/hw/hppa/machine.c
>> @@ -356,7 +356,6 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint64_t kernel_entry =3D 0, kernel_low,=
 kernel_high;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *addr_space =3D get_system_=
memory();
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MemoryRegion *rom_region;
>> -=C2=A0=C2=A0=C2=A0 unsigned int smp_cpus =3D machine->smp.cpus;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SysBusDevice *s;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* SCSI disk setup. */
>> @@ -482,8 +481,8 @@ static void machine_HP_common_init_tail(MachineStat=
e *machine, PCIBus *pci_bus,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kern=
el_low, kernel_high, kernel_entry, size / KiB);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (kernel_cmdli=
ne) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
[0]->env.gr[24] =3D 0x4000;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pst=
rcpy_targphys("cmdline", cpu[0]->env.gr[24],
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu=
[0]->env.cmdline_or_bootorder =3D 0x4000;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pst=
rcpy_targphys("cmdline", cpu[0]->env.cmdline_or_bootorder,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TARGET_PAGE_SIZE, kernel_cmdline);
>=20
> I am a bit confused, here @cmdline_or_bootorder contains the physical
> address of the kernel command line, ...
...
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_entry =3D=
 machine->boot_config.has_menu ? machine->boot_config.menu : 0;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu[0]->env.gr[24] =3D mach=
ine->boot_config.order[0];
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cpu[0]->env.cmdline_or_boot=
order =3D machine->boot_config.order[0];
>=20
> ... but here a char ('c' or 'd'). Both seems different things.
> Is that expected?
Yes. That's why this variable is called "cmdline" or "bootorder".
If kernel and cmdline is given, the bios does not need to follow any booto=
rder
(which means: boot kernel from C or D).
If no kernel/cmdline, this parameter tells the firmare to load bootloader
from c (harddisc) or d (cdrom).

So, it's ok.

Helge

