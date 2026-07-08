Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8BEC43602
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 10:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whPFK-0001lr-38; Wed, 08 Jul 2026 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whPFH-0001lI-Lr
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:11:11 -0400
Received: from p-east2-cluster5-host12-snip4-10.eps.apple.com ([57.103.79.83]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1whPFF-0003b2-Nv
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 06:11:11 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPS id
 585941800122; Wed, 08 Jul 2026 10:11:04 +0000 (UTC)
X-ICL-RepId: 019f4135-abd2-711c-9498-473a7486c2d9
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQhICkMDWhxBCEsdXwdcEhVdRV4CXwpfFV04RgNHGVcUUBtHDFUHV15fChMLU1ZHHkkKVgleCEYRWxRWQ1EZEgJaRQVNXw5eHwQXRhlVBEceXVZAGRkCURxWDVdDVARfUEkMQVBsWgBHF0gdXRlZb1BdHA4YWRtAFV0RUBlWCV4VFx5BTVoCVk0FPgRUAC0HRA1VBC9yWB9EDU8LQHVYA0kUSHdZD18BQABNBF4GK0ceSQpWCV4IRhFbFFZDURkMUE0BQwgKCEcDTRdeMlMEXxFQFg==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1783505468; x=1786097468;
 bh=CXFo8AMxA4e4gTlAGmPd0zHYOeaH2U4ywZ33vRhXN6I=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=fbxIOQ8t6BWftlx71lwMUY96UTTD2n/BeDc81B65WLswSbTquQwdk+r4lIq/SYYejjM+4ZagABmQEY6m23nBFz6PxJv9Iy70mfkPL0mFEQWv5YDWrKohRzwJhnVS6DpKPk9x+5PqOhnMmaoENH6rmGhBKm3ohwa8F4uVCltJq9RhmAy6aOAGOOmRsZAXO2fNDNfm9oi8+gy5S8czeI+pn9YIT2tR5YPUNXl+vJBZYZYbJP7hbLeMJFmEvTINrFiNYGBdJNBh+xM0e+ZImOq0ftmz8cFjk1tTMfdHqwWSH2b4V/crm+MUHdHMWtGT5Zy38poocRpJ/ZchPpuUVc2d6A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-20-percent-2 (Postfix) with ESMTPSA id
 A59431800404; Wed, 08 Jul 2026 10:11:02 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3895.100.17\))
Subject: Re: [RFC PATCH] target/arm: report M-profile BKPT to gdbstub when
 attached
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <CAFEAcA9x7tjW9xuT_XwNntdvoVtLrCL_PB+50tfhiW2XDvsCiw@mail.gmail.com>
Date: Wed, 8 Jul 2026 12:10:12 +0200
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Gilles Grimaud <gilles.grimaud@univ-lille.fr>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F797F544-7BE3-4478-B319-0D4843095731@unpredictable.fr>
References: <20260705224407.32464-1-gilles.grimaud@univ-lille.fr>
 <CAFEAcA9Heev=ydTzO2u3EzeF_2q7dytOF8=67qF8ZMMY6Ky2Tw@mail.gmail.com>
 <a14481eb-9eed-43c0-a29c-187798f7f769@linaro.org>
 <CAFEAcA9x7tjW9xuT_XwNntdvoVtLrCL_PB+50tfhiW2XDvsCiw@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3895.100.17)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5OCBTYWx0ZWRfX7IcM4sTMGXSq
 gDy/xs3YVqE+J1F8TcI0q1LYMM9OZkPk+huAXvTgkVYmDZ6Am6Q17u3862qXK4ojI0yFQJxjJ1u
 f83R1bhSx+oOLisPKeLBGyQNyMV52lpbg2UxjnGOT+5/G1vVBUgHnzxv/ZLDzEoDmLB3y48iT+v
 WZMEnhDOyxntxlePrnFJmi4fk1iGwjUXToXQKOFKhJnZ+6MePShAf1CFEWDRGIEhNz1yaE+hsTa
 HC2XMawTzzVARhYbEUMv6ARpzAg3K8fg9T95LBJLhQc/ZfqEDnI5VUuuZ8BvRgSp1Qj358/PrZH
 RcCqxPY3HuwAKvI3qln
X-Proofpoint-ORIG-GUID: nr4MdOw9mhJ9Quj3CzJPdLGPVcEAm92n
X-Proofpoint-GUID: nr4MdOw9mhJ9Quj3CzJPdLGPVcEAm92n
Received-SPF: pass client-ip=57.103.79.83;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 8. Jul 2026, at 11:31, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 7 Jul 2026 at 18:27, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>=20
>> On 7/6/26 02:21, Peter Maydell wrote:
>>> No other architecture, CPU or board in QEMU needs to do this,
>>> so my instinct is to say that M-profile should not be special here.
>>> Richard, Alex: how do we usually handle breakpoint insns for the
>>> gdbstub ?
>>=20
>> We handle them via CPUBreakpoint structures; we never inject code =
changes.
>=20
> I don't mean "breakpoints that the gdbstub requests", I mean
> "breakpoint insns that are already in the guest code that get
> executed".
>=20
>> The patch description explains the confusion: this is attempting to =
replicate a feature of
>> the Raspberry Pi Pico SDK, wherein a guest BPKT really is trapped by =
an external debugger.
>=20
> But aren't breakpoint instructions of all kinds typically trapped
> to the external jtag debugger, on any architecture ? I'm a bit
> surprised that we don't do this already.

Some context on the gdbstub implementation from the x86 side:

WHPX's gdbstub support is implemented with overriding the instruction
instead of leveraging HW breakpoints - although a bit hackily.

A big concern is still allowing self-hosted debug to work fine which
makes things a bit harder.

x86 makes things easier by having multiple different breakpoint =
instructions.
Linux uses int3 and we use int1*  for QEMU gdbstub-controlled =
breakpoints so
that things (mostly) work out for everyone.

And then, QEMU traps all debug exceptions from the guest when gdb is =
attached
and is supposed to take action when it=E2=80=99s an int1 breakpoint and =
not others.

Although we currently have a bug there that the non int1s just get =
ignored
instead of being injected back.

* on x86, the Intel manual says "Hardware vendors may use the INT1 =
instruction for hardware debug"=20

On Cortex-M self-hosted debug is far less used than for emulating bigger =
chips.

And then there=E2=80=99s emulating such a thing using hardware virt and =
using HW breakpoints
which quickly becomes quite complicated...



