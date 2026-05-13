Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48201CD37B6
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 07:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN3oG-0000mZ-JV; Wed, 13 May 2026 03:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wN3o8-0000ln-U5
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:15:04 -0400
Received: from mr-2006g-snip4-11.eps.apple.com ([57.103.70.53]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wN3nz-0004Wv-FB
 for qemu-devel@nongnu.org; Wed, 13 May 2026 03:15:00 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPS id
 241A8180017E; Wed, 13 May 2026 07:14:47 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRBEwVSB11NVg1HD1geXBQXFUFDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAFMAlkHXwBFFD5xXnJGBkUPTx4sBFJzXQ1OBy52Lws1fzx3WXceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778656489; x=1781248489;
 bh=+5Rak/NvONeNGSUZyuEaXyeLi0G3ivLlcIulIdCFBrg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=B9X0xIbAy9LO1ArZoxr9vCU+S4tJONiRpB1X9bDHio085NDWIQqzfMVUUlR57CoC/FSfq1hrBDiFmiB65BUfvGMs4jFlqYGCzjCTBlvl1IfLqqJp7SUs10WknxEHqzp+tDlyGvwxHs9jy6QMGyYaNqOWMqVjE/o8kL5EhQcEeiKtVbDTnm5KY5bJCu3ZAZp7bMcGQV2GltbitSNlYCCrsGmZEyDzCKOyUI0nthae0zF+F5neSLPMGgWZXA+dq0FuerRG0+3SYCE8rh2p/CPZ9CoJU1NZoWlRUlZuGSW4mp6Hte0JZQb5VtF9AucbDb5nxNe5p74Vc1tAwdjEqVUerQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-2 (Postfix) with ESMTPSA id
 642F518001E7; Wed, 13 May 2026 07:14:45 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <DIH6YGXVPFD4.2O7V71XKGBIB@gmail.com>
Date: Wed, 13 May 2026 09:14:32 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-stable@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <84140425-FB3E-4567-A39A-464CAD9EFDD4@unpredictable.fr>
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
 <E8468087-647B-45B5-AF4E-85DD15A6D35C@unpredictable.fr>
 <DIH6YGXVPFD4.2O7V71XKGBIB@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3MyBTYWx0ZWRfX/cYdaOFXdatK
 SxDIT1gnuPE2vMHbz5xnSZ8NkreQpPb2WGwFO2qag3/KpdMlBuBiDPvoJjmm0BdSRAe7VA8Coy0
 Bv486OUywaQ6vYZ0M+SvuoKuTGDdjWX6LuF3UebdDffD+EoCIvnGg5UCjnRF7EpfflktSUimJ11
 vdSsdklErKzIMoBAYIOLOPGt1LX37tlOilFZ2k3np2rGtBpfedEJZ7auuSxZw15Fht2gAt7wuCa
 ri4ARuFXOz3gsvS6PZ8/nB5AuKxH9Ar0vlzI1Wgv9laxAdhROfA5ecln50HfDpObafKej5X9sEB
 5qZ4iXItdIdCINzbilUrJPwSi9vdZUrdE2OfLP677qGZKttga5Kh+9WhgjMX4g=
X-Proofpoint-ORIG-GUID: 9NTaCIQ-ACvkdlEA4QmaYgFK60W3_bvn
X-Proofpoint-GUID: 9NTaCIQ-ACvkdlEA4QmaYgFK60W3_bvn
X-Authority-Info-Out: v=2.4 cv=aKH9aL9m c=1 sm=1 tr=0 ts=6a0424e8
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=JcIEX0jus5acmg8J3LQA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
Received-SPF: pass client-ip=57.103.70.53;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



> On 13. May 2026, at 04:25, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>=20
> On Tue May 12, 2026 at 9:21 PM EDT, Mohamed Mediouni wrote:
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
>>> halt_cond in qemu_process_cpu_events().
>>>=20
>>> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the =
guest's
>>> virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>>> because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>>> hv_vcpu_run(), which is not called while the CPU is halted. The
>>> timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>>> vtimer IRQ through the GIC and marks vtimer_masked, causing the
>>> interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>>>=20
>>> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>>> indicates a pending interrupt, and cancelling the WFI timer.
>>>=20
>>> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>>> transition for any halted vCPU, since the QEMUTimer is per-instance
>>> state and is not migrated. After cpu_synchronize_all_states() the
>>> migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>>> and CNTV_CVAL from there. If the vtimer has already expired by the
>>> time the destination resumes, hvf_wfi_timer_cb() is invoked
>>> directly so the halted vCPU is woken up.
>>>=20
>>> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using =
pselect()")
>>> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>
>>> ---
>>> Changes since v2:
>>> - Use QEMU_CLOCK_VIRTUAL instead of QEMU_CLOCK_HOST so the timer
>>> pauses with the VM and a halted vCPU isn't woken (or its IRQ
>>> raised) while the user has stopped the guest. (Peter)
>>> - Convert vtimer ticks to nanoseconds with muldiv64() to avoid
>>> intermediate overflow. (Peter)
>>> - Re-arm the WFI timer from hvf_vm_state_change() on the resume
>>> transition so a halted vCPU on the migration destination is
>>> woken when its vtimer expires (the QEMUTimer is per-instance
>>> state and isn't migrated). (Peter)
>>> v2: =
https://lore.kernel.org/qemu-devel/20260410055045.63001-1-scottjgo@gmail.c=
om/
>>> v1: =
https://lore.kernel.org/qemu-devel/20260410044726.61853-1-scottjgo@gmail.c=
om/
>>=20
>> For QEMU 11.0 (for backporting to stable):
>>=20
>> Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
>>=20
>> For QEMU 11.1:
>>=20
>> Adding some checks for !hvf_irqchip_in_kernel() needed
>> but can do them on my side if you prefer.
>>=20
>> Looks ready apart from that bit.
>=20
> Hi Mohamed,
>=20
> TFTR - I sent a follow-up patch that gates the wfi timer as you =
requested.
> For applying this v3 version to the stable tree, is there anyone else =
I
> should ping? I'm not very familiar with the process.
>=20
> Thanks!
> -sjg
>=20
>=20

Hi,

v3 of this patch is for QEMU 11.0 qemu-stable and v4 is for QEMU 11.1.

A catch is that this isn=E2=80=99t in master yet though.

This regression doesn=E2=80=99t apply to QEMU 10.2 or earlier.

Could this regression fix be included into QEMU 11.0.1?

(with qemu-stable@ in cc)


