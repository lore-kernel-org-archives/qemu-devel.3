Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B35CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrJw-0002gK-MV; Tue, 12 May 2026 13:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMrJq-0002fZ-3L
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:54:58 -0400
Received: from ci-2001l-snip4-3.eps.apple.com ([57.103.91.116]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wMrJl-0007ZM-8N
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:54:55 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPS id
 946A71800392; Tue, 12 May 2026 17:54:47 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRAEwVSB11NVg1HD1geXBQXG1pDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTA5BBy51XAtFFEEHWwVGBkIAQR4vAC5xXQxKCy8HLgY2CEEBXnceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1778608488; x=1781200488;
 bh=HZ/K3hvHOKnJzBcCuI+ghfBNNMFIC0SzfBrUufY2EIc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=LSJ3jWXaTX9nOmM1+pBSzuzMdOSIrAabQdn6EZZcxyWqe+GV1Pky1FhcOkICKdnpa6G7adAguL5Tut86A4LBSifxIgwNM2VMNdyYjavWXOob7m2q0M3lF+hy+iF1yPiCOvymWFQcn4yLsauMfZvOsoJA8KQG6oiaxTQZpilbRp7PbnbrSmRFSgN+feFZjk3PYF5lO5k0p/G4DsdnYjZSk7mOViW6tNbutW8l4I8dLZyf3CXTgk/MbEdd7dPpbkavFCMAUYkfKqS601A6etzQVpqMoYl7m95FUkkzoF3cERGtEBz0iCRcW2s2WwX+B+GGULdaf5bXpRxisToRZlpXLA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-8 (Postfix) with ESMTPSA id
 D6D0318003BF; Tue, 12 May 2026 17:54:45 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v3] target/arm/hvf: Fix WFI halting to stop idle vCPU
 spinning
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260427195516.46256-1-scottjgo@gmail.com>
Date: Tue, 12 May 2026 19:54:33 +0200
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <794CB795-9462-4299-B7EC-528B0E4F1923@unpredictable.fr>
References: <20260410055045.63001-1-scottjgo@gmail.com>
 <20260427195516.46256-1-scottjgo@gmail.com>
To: "Scott J. Goldman" <scottjgo@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-GUID: dk9vUSONVVtR_vkcGtqTZdBHekSXoD2d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NiBTYWx0ZWRfX193P2IsyPPq8
 ejq25+r/mBAtWWJMFm4cpbJ8NDVz7Q8UQMacSou7ciqGewW2jBLz7kRQnd+g6ur4IiM2o6tNnJR
 oXTrGRti7WSzmbyYMbkX1x7eiaAbtLpHvKawHqyCMwi+SutGP3lunevILKWmLH5SxsdnsZODagC
 KuKa3At5hAKKIibwjY8gZzngV4r0tI37C1lgRF2+kv7imEsGuUGdFdTxe2/vFbGw+Lsay+TDBgC
 23vijPol2DLxB7jtPfweNXjU2b8A6GLF9dmnNv4FeY5VbSZm8r8AQa90G7JL3O+pjYlk1fDYvPz
 WLE5Ue9ko4sv68zglKBusRZ/xzNkLp7ZLs+6z/Tz969JgFzaNSObVm3QzPfslE=
X-Authority-Info-Out: v=2.4 cv=YcOwJgRf c=1 sm=1 tr=0 ts=6a036968
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=Rd0dBYZo9EqFB7wkWVAA:9
 a=CjuIK1q_8ugA:10 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: dk9vUSONVVtR_vkcGtqTZdBHekSXoD2d
Received-SPF: pass client-ip=57.103.91.116;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
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



> On 27. Apr 2026, at 21:55, Scott J. Goldman <scottjgo@gmail.com> =
wrote:
>=20
> Commit b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> changed hvf_wfi() from blocking the vCPU thread with pselect() to
> returning EXCP_HLT, intending QEMU's main event loop to handle the
> idle wait. However, cpu->halted was never set, so cpu_thread_is_idle()
> always returns false and the vCPU thread spins at 100% CPU per core
> while the guest is idle.
>=20
> Fix this by:
>=20
> 1. Setting cpu->halted =3D 1 in hvf_wfi() so the vCPU thread sleeps on
>   halt_cond in qemu_process_cpu_events().
>=20
> 2. Arming a per-vCPU QEMU_CLOCK_VIRTUAL timer to fire when the guest's
>   virtual timer (CNTV_CVAL_EL0) would expire. This is necessary
>   because HVF only delivers HV_EXIT_REASON_VTIMER_ACTIVATED during
>   hv_vcpu_run(), which is not called while the CPU is halted. The
>   timer callback mirrors the VTIMER_ACTIVATED handler: it raises the
>   vtimer IRQ through the GIC and marks vtimer_masked, causing the
>   interrupt delivery chain to wake the vCPU via qemu_cpu_kick().
>=20
> 3. Clearing cpu->halted in hvf_arch_vcpu_exec() when cpu_has_work()
>   indicates a pending interrupt, and cancelling the WFI timer.
>=20
> 4. Re-arming the WFI timer from hvf_vm_state_change() on the resume
>   transition for any halted vCPU, since the QEMUTimer is per-instance
>   state and is not migrated. After cpu_synchronize_all_states() the
>   migrated vtimer state is mirrored in env, so we can read CNTV_CTL
>   and CNTV_CVAL from there. If the vtimer has already expired by the
>   time the destination resumes, hvf_wfi_timer_cb() is invoked
>   directly so the halted vCPU is woken up.
>=20
> Fixes: b5f8f77271 ("accel/hvf: Implement WFI without using pselect()")
> Signed-off-by: Scott J. Goldman <scottjgo@gmail.com>

Hi,

A bit of a side note for reproducing this:

To reproduce this on current master, as far as I can tell you need =
either=20
-M kernel-irqchip=3Doff or -M virt-11.0 or earlier. -M virt(-11.1) on =
master uses=20
the HVF vGIC path.




