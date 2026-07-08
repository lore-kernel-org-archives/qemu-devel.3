Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F4AC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 09:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whOPc-00031h-59; Wed, 08 Jul 2026 05:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whOPQ-000319-3U
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:17:36 -0400
Received: from st-2001j-snip4-5.eps.apple.com ([57.103.76.118]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whOPN-0007tX-T9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 05:17:35 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id
 53CA41800B8C; Wed, 08 Jul 2026 09:17:28 +0000 (UTC)
X-ICL-RepId: 019f4104-98f2-70b7-9311-872737e4e42c
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0PWFsIWwQPH0wMUQJCBVZeSgwdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkYJSQRUB1oKXQ89A18aX3ZIAVVyWQJZH0kKPHEodi8LNQ5Odi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1783502249; x=1786094249;
 bh=RbLcrpsAggBtg59TKF4CdPBa0LeMrb0CvDzSdKRAUEc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=UqEUt6669TIcVwqTIRJrN5xKvpA54xYR+MC9qCXZLze/UWDl60txKqbfVWS+pJjtYRBhwq1eQEFCkHatJLM6MGv2aYGkVwn9xVHykU8baR2KiuQtHAb2n1h7tiSYjeoWG/n2FanqfAGwwb0WlWC2izg7HJv9E82JEQsWEqNnt35oLB8cpSPPhD2n8pzUgnPr5hAQ53L3Ht/ucYuZGMdAaG5s+z1j18NPaJKq3sDRGXgnZnDggj1fFJzRpc4w302dix2mqnI6seRdCvEaRH95Sw4+sL8WMT29Ki0POAxhCV/GMwLQ+6Eqf1K8YphJZFt03PQkiqiQGljgOCAhy0VJtA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id
 F051C1800292; Wed, 08 Jul 2026 09:17:26 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3895.100.17\))
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
Date: Wed, 8 Jul 2026 11:17:14 +0200
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <60179018-6E02-4D88-A452-93DBEAD9E76E@unpredictable.fr>
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
X-Mailer: Apple Mail (2.3895.100.17)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA4OSBTYWx0ZWRfX9/BdinoLP+IK
 IBd+92SVIfXXJgj9SgfDuIT+++0PMQO3wCQSSm3NDVg8FtoMfyWSZXOWx/RD48CEiXkFKLvop17
 ZIoJohmmKdEZB8uRb0+BIIlrtjekcEJPA1eqL2mmoiP1KiEIIQOSnDrw/WXwKeGrA8ZDh+Li5vh
 SUQuKC+df7NJ93M1f3c9Bed3GaHjUuPVkDWijL8HwljEHpzyv4SZdAZ9yrLcOsEUeMyvmuF9cvk
 Cd5T3VW+AGLT7Ycyz05QLjfTKXCVYF5rQ+rmi2bguwRiA7z84i3TDMWnpj0Yjv9/MAVhIbyTOsP
 1sdRpDi3Edx54YmO2Hq
X-Proofpoint-GUID: UwWC9SifQFnH_lAgnaIXxXTk7iHLgrd7
X-Proofpoint-ORIG-GUID: UwWC9SifQFnH_lAgnaIXxXTk7iHLgrd7
Received-SPF: pass client-ip=57.103.76.118;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 7. Jul 2026, at 19:27, Richard Henderson =
<richard.henderson@linaro.org> wrote:
>=20
> On 7/6/26 02:21, Peter Maydell wrote:
>> On Sun, 5 Jul 2026 at 23:44, Gilles Grimaud
>> <gilles.grimaud@univ-lille.fr> wrote:
>>>=20
>>> While working on Raspberry Pi Pico/RP2040 support, I noticed that =
Pico SDK
>>> programs deliberately execute BKPT from _exit(). On real hardware =
this is
>>> useful when a debug probe is attached: returning from main() stops =
the
>>> debugger at the program exit point.
>>>=20
>>> Under QEMU this currently does not behave like the debug-probe case. =
For
>>> M-profile guests, the BKPT instruction is routed through the =
architectural
>>> guest debug exception path. Without halting debug, that path should =
remain a
>>> guest-visible DebugMonitor exception when DebugMonitor is enabled, =
or escalate
>>> towards HardFault otherwise. This patch deliberately leaves that =
no-debugger
>>> architectural path unchanged.
>>>=20
>>> The problem addressed here is the case where GDB is connected to =
QEMU's
>>> gdbstub. In that situation, firmware that uses BKPT as a debugger =
stop point
>>> should stop in the attached debugger. Instead, the M-profile guest =
currently
>>> continues down the guest exception path and may end in =
HardFault/lockup rather
>>> than reporting a clean trap to GDB.
>>>=20
>>> This is not specific to the RP2040 machine model. It is a generic
>>> Cortex-M/gdbstub interaction: firmware that uses BKPT as a debugger =
stop point
>>> should be reported to the attached debugger, while keeping the guest
>>> architectural exception path when no debugger is attached.
>>>=20
>>> Expose a small gdbstub helper to test whether a CPU is visible to an =
attached
>>> debugger. When an M-profile BKPT instruction is executed with such a =
debugger
>>> attached, leave the translated block with EXCP_DEBUG so the existing =
gdbstub
>>> stop path reports a trap to GDB.
>>>=20
>>> Signed-off-by: Gilles Grimaud <gilles.grimaud@univ-lille.fr>
>>> ---
>>> gdbstub/gdbstub.c      | 13 ++++++++++++-
>>> include/exec/gdbstub.h |  6 ++++++
>>> target/arm/tcg/debug.c |  9 +++++++++
>>> 3 files changed, 27 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
>>> index c3c944e965..9f259fc005 100644
>>> --- a/gdbstub/gdbstub.c
>>> +++ b/gdbstub/gdbstub.c
>>> @@ -237,6 +237,18 @@ static GDBProcess *gdb_get_cpu_process(CPUState =
*cpu)
>>>     return gdb_get_process(gdb_get_cpu_pid(cpu));
>>> }
>>>=20
>>> +bool gdb_cpu_is_attached(CPUState *cpu)
>>> +{
>>> +    GDBProcess *process;
>>> +
>>> +    if (!gdbserver_state.init || !cpu) {
>>> +        return false;
>>> +    }
>>> +
>>> +    process =3D gdb_get_cpu_process(cpu);
>>> +    return process && process->attached;
>>> +}
>> No other architecture, CPU or board in QEMU needs to do this,
>> so my instinct is to say that M-profile should not be special here.
>> Richard, Alex: how do we usually handle breakpoint insns for the
>> gdbstub ?
>=20
> We handle them via CPUBreakpoint structures; we never inject code =
changes.
>=20
> The patch description explains the confusion: this is attempting to =
replicate a feature of the Raspberry Pi Pico SDK, wherein a guest BPKT =
really is trapped by an external debugger.
>=20
> The only question is whether we want to follow that, and I suspect the =
answer is no.
>=20
>=20
> r~

Hi,

It=E2=80=99s a typical debugging pattern on Cortex-M platforms.

Especially as quite some designs around of Arm M profile are with no HW =
breakpoints at all.

The Armv8-M TRM says:

(B13.4.4)

> When DHCSR.C_DEBUGEN =3D=3D 0 or when the PE is in a state in which =
halting is prohibited,=20
> the BKPT instruction does not generate an entry to Debug state. If no =
DebugMonitor=20
> exception is generated, the BKPT instruction generates a HardFault =
exception or enters
> Lockup state.

With UDE added as an additional control in Armv8.1-M

(C2.4.25)

> BKPT
> Breakpoint. Breakpoint causes a DebugMonitor exception or a debug halt =
to occur=20
> depending on the configuration of the debug support.

with DebugMonitor being fairly new and not really used all that much =
because
self-hosting debug on Cortex-M is/was quite rare

Quite a number of Cortex-M platforms don=E2=80=99t have hardware =
breakpoints at all,
relying fully on BKPT. While there are other options when QEMU is =
around, I think
it=E2=80=99s still a good idea to be able to replicate the hardware =
behaviour.

Which in this case would mean having QEMU=E2=80=99s gdbstub match the =
behaviour=20
that can be obtained from OpenOCD providing a GDB stub.







