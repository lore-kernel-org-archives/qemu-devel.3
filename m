Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4B3CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu4i-00038Z-CQ; Tue, 12 May 2026 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMu4g-00037r-J8
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:51:30 -0400
Received: from qs-2007d-snip4-3.eps.apple.com ([57.103.84.164]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMu4c-00016N-UR
 for qemu-devel@nongnu.org; Tue, 12 May 2026 16:51:30 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPS id
 6A8C918000AD; Tue, 12 May 2026 20:51:20 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXCUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAtBBS8OUnNCFEkKKXJGBkUPQB4sA1kLXQBABykAWQZJfE8FWHceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778619083; x=1781211083;
 bh=dowCJmv0YyQe/HYja0aiB9YSlxqwGMSaD9jzrNcVu7U=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Kqj7sSjCid+JukTbL+ITHC9BgtZZOlC/l1aokDYAmBql6TdIA4OfvZADNflVQ+ACFMhdfHFr3F4zZZh8Zd165ECXsDT6aBxM2HxHTNDS16iyiXHXoIQZyD4IHR0cEIBgxjCMsJ5Oc3kqGHNLjkEAtNTkY1GFki7Htad79jLROsqgi7R6gWTVeUiFejNkW6p2TMGEHKahczRhzx9oJUsP/Iy4F+FBEocvmBConOMxBteTidVBQ86rYjr/v/b4nqcuVTgVSa9V+P2kQuvlF25cPKSmwIf0xmSjhTEZ/IZaFT8IrtjFufMtxW8491fhoK914REnxPQFuOWTpsI/8jygNg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-11 (Postfix) with ESMTPSA id
 A496918000A0; Tue, 12 May 2026 20:51:18 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DIGZJ3V3TPDK.3LY9W3NAULWWA@gmail.com>
Date: Tue, 12 May 2026 22:51:06 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <296B99A2-19DE-4568-A429-984D7249E765@unpredictable.fr>
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
 <794CB795-9462-4299-B7EC-528B0E4F1923@unpredictable.fr>
 <DIGZJ3V3TPDK.3LY9W3NAULWWA@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: iH1Xj6mGbit2X58s7RzFs4CGg5Dxdfz1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIxNCBTYWx0ZWRfXzg+lOXFNnPvG
 03acgZDzdcT82tBnYrSbEIW/XHatVm3Q/hjHVBcyMo+3lUFDzFObEsXR1+n1CS6bgcWjozhLQIu
 hblXjMFDJRva+vQ/RVL0j5wT+7ympS7TXm1eC63FBf/ra/0hJbyTi39IDmzkYBLySUEm1ELgnkQ
 kHAhYvGuqwSbkHC0QmroBjTwKICVMLJxNUrzn6fct2nhNVl6q7utO0loHXng3WNxk8q0HveL/Ys
 EhFCrT3fi9C3++b/FSypBFQPlQpPm5ETkniVi0VHzxphPQ0KDEJ9p6v7kIfAbKsBeXDr2MGAf26
 WTkrsxi+8u5kbfB206sq3iDrqFuEy9rY6k0fkgNv51AUDrz22hXh/mUUltCQLU=
X-Proofpoint-GUID: iH1Xj6mGbit2X58s7RzFs4CGg5Dxdfz1
X-Authority-Info-Out: v=2.4 cv=fMA0HJae c=1 sm=1 tr=0 ts=6a0392c9
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=dMFe32L-kBhxwVrZe4QA:9
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
Received-SPF: pass client-ip=57.103.84.164;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



> On 12. May 2026, at 22:36, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>=20
> On Tue May 12, 2026 at 1:54 PM EDT, Mohamed Mediouni wrote:
>>=20
>>=20
>>> On 27. Apr 2026, at 21:55, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>>>=20
>>> Commit b5f8f77271 ("accel/hvf: Implement WFI without using =
pselect()")
>>> changed hvf_wfi() from blocking the vCPU thread with pselect() to
>>> returning EXCP_HLT, intending QEMU's main event loop to handle the
>>> idle wait. However, cpu->halted was never set, so =
cpu_thread_is_idle()
>>> always returns false and the vCPU thread spins at 100% CPU per core
>>> while the guest is idle.
>>>=20
>>> Fix this by:
>>>=20
>>> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps =
on
>>>  halt_cond in qemu_process_cpu_events().
>>>=20
>>> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the =
guest's
>>>  virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>>  because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>>  hv_vcpu_run(), which is not called while the CPU is halted. The
>>>  timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>>  vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>>  interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>>=20
>>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>>  indicates a pending interrupt, and cancelling the WFI timer.
>>>=20
>>> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>>>  transition for any halted vCPU, since the QEMUTimer is per-instance
>>>  state and is not migrated. After cpu_synchronize_all_states() the
>>>  migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>>>  and CNTV_CVAL from there. If the vtimer has already expired by the
>>>  time the destination resumes, hvf_wfi_timer_cb() is invoked
>>>  directly so the halted vCPU is woken up.
>>>=20
>>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using =
pselect()")
>>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>>=20
>> Hi,
>>=20
>> A bit of a side note for reproducing this:
>>=20
>> To reproduce this on current master, as far as I can tell you need =
either=20
>> -M kernel-irqchip=3Doff or -M virt-11.0 or earlier. -M virt(-11.1) on =
master uses=20
>> the HVF vGIC path.
>=20
> Just wanted to confirm that I re-tested and it seems like you are
> correct. This must have changed semi recently?

Hi,

It finally got merged last week.

> I was just running with `-M virt` before. Either way, it's good that =
the defaults seem to work
> better now. Either way, I guess the fix still needs to go in for the
> non vGIC path?
>=20

Yes. I=E2=80=99ll do a review. This patch is also a qemu-stable =
candidate.




