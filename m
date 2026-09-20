Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E956C982D0
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Sep 2026 09:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8DpZ-0007JN-O0; Sun, 20 Sep 2026 05:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x8DpU-0007J8-LI
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 05:27:26 -0400
Received: from ci-2001k-snip6-6.eps.apple.com ([2a01:b747:3005:205::6d]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1x8DpS-0004p1-CD
 for qemu-devel@nongnu.org; Sun, 20 Sep 2026 05:27:24 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPS id
 D37BC18000D3; Sun, 20 Sep 2026 09:27:13 +0000 (UTC)
X-ICL-RepId: 01a0be24-2023-7d7a-9c73-819dad91c20b
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQ1OHVwPUhxEDlYCVRcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeWhEdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkIPTHFacioAXX86AVQaXwJFAFUKLnYuH0MAPAZUDioLRHhOdS1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1789896434; x=1792488434;
 bh=iEyBt6Nu1wrcjo/ror+dF8hn+n5mavu1nRmsRpxz/S8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=EBenj5dmK3BmZYJ0xsAXuOR5kIKkVMiDxb5mQDprSWfVBbSw2Z2x5G3uUS0YzMjgtR1sWbhkM9nQf3SGwcYCJZCnWQKmdZ2dpzRNfVsha+f9vH3BVzLqwdN0BBdhJiTtQCpOA6yFgQ/ibRMoxUr9ToYR/PswkL5y6XCFoxgDYC/MeFmUkIhHuy2kqy/9K6NwHkJUlf8uJwjourjsBHtMYXNCXG9FKEekXTq3WnyK2xijmnvqHzXoaN6BtGi2HAVqh9AYiz5cqngnyXgg30vbxXbrWWWhCWHxmfX/kFLKx+cCbYfyOdmyLnrw14LW3rgm/XwEjAB/AjgAe3+5E1/TWQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-1 (Postfix) with ESMTPSA id
 BF8FE18000CD; Sun, 20 Sep 2026 09:27:12 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH] whpx: i386: avoid updating hflags for vmexits
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260920020320.1466-1-bodenrandin1@gmail.com>
Date: Sun, 20 Sep 2026 11:27:00 +0200
Cc: qemu-devel@nongnu.org,
 Pedro Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <264B7EA2-FB29-4059-9CAE-39D599A94A6F@unpredictable.fr>
References: <20260920020320.1466-1-bodenrandin1@gmail.com>
To: Boden Randin <bodenrandin1@gmail.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=ddCNHHXe c=1 sm=1 tr=0 ts=6aafa6f2
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=DYtnV2cK7ZQKjr27wRUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 7-YWNCSwqGRoOyjGzcKX0i6Z-Pd-Ncnb
X-Proofpoint-ORIG-GUID: 7-YWNCSwqGRoOyjGzcKX0i6Z-Pd-Ncnb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDEzNiBTYWx0ZWRfXxJCSo0MRRiEM
 mr4yWPeySgKxM/T3jKifZhO76MjcGCGNScXJY9Z9g1+Ww+oc5GIHXoLK5tFAd/hZXPIX9TT+bO7
 i+xKMGvs5ozlipxJN0HQx/Q2VCZKviGToj7vM2Re4m+3sVyjzZdewsgZdvLuEZiey5RUmpL1ymI
 GeqZFReCB85NLb2tf1Oh0TQs5coE291QEgE41qUV+Dq6IeKGJmIGiUqPSHBZFE6CB7IQn0AO9E6
 W166fphMtifrQnk9MQnzjxTOCRI8kBbbspJzaBPhKyB4zkEyPgVMOhEnz8oPt36WSnHKqyAKs5l
 oUp6ul0ZNzM16jzUc8KpWhlYRXeEQH16B1VodJiF4GhzRlRzaTw7oSJP5jezj0=
X-JNJ: AAAAAAABK2mkMtfwG7bQOY/4BZSXdm/sQ7IAljqCpcPcPRM2Osddyv9Qf68M1qXup1dobiJ5U3wTXqT73NdGtJwEvvOZ8qRMlGF//ZtGFUTXVg/T4j457CbQx9xr9h5F/Zw4C0g1n2pxuUFpQan7gBbv9+4bAsHL6eIHVBxckMCbfizforpTAKCr6Cw5R6j0TzmMRSfr9lvAtxsLhziGNRE2YVgaaav+Ez3DPodsOPZn8MtmeL3CBFcpvyZ5ZvJGsBtf/I+ZYoSCckmq/i60dG/iLlzwdYjSKRpf2SKlWzvrd5dVHyxHNaQklbIqgvM903vZHDRfTJaRNL/gZC5Pv7rhyyX2b/jFDiH+8gLZ+B9rmVH5zecogbiyA9YNys+URl010bKLSw9ou2GocXfl+d2SIwlie0YgJPLkzwoMHK+ClzMJo2vYIAg0fmt5KeLdAzKwkSjJBhDjY+8U+j2ldWL/0PMZEukH9RRAH82yWrPHEg6gshNgQwvKLoKhGd+bll3rcox3juj/DS75Jof1/vqxoUonV9DfX8aDeCGdtp28+Ta5nfAUnujLBgNy3DHsTv/zVhVcX1rWsZU/qk/qZnMulWwPj8ogpcx0TkAL6SB86MAC/m3GoVWLeTp5mlP/O8CzvaP/Mkqee5bdq8LY893tsyBDBpCvpORMFG4iyttT8ndyF0jnXXdDGWWzJIhbBe04NmwqJsFFyzqr8RFkdNlOkBTfHIDETMoz0Z7t8JPglFZEHqoQpQc3djHU+TRDiUoaAm4RKXURMfbRMqNjQCCqqyiOXJmwu13FYDMMQj2Wm6wmvxDT1l5eErRhmxrNqDwTPc7heNGTj/RRJAXj1UUcY/ITOggwKv3WzYaqxV+PHrNbcftGeC707lQt+2MNov8FKV4RWDVmtpl8nNFxzn9xO11P5cptjOWy24fm4yo9TLV086fW6VzFbPUsdxNIHnONGDeRw+d5+O0wUQoofGVdhI1e2Il
 FjJFweOW4t3OlUH2Y0DHg2wxJ2gZ74Szptzf/ewmFgrfyvyjcfoTT/5WJj9xrk2kwcWL01KzZutr3kBbOuyGgBSf1wendcFDYmd7lLoYb/0bS4yU4jo7g6nndBKaY68clr/+AfbwZvJxLnRsmyAgIMNTyZ6CVTqbJgvnEcETE+EDMgmcZz2ecQXA5cP/31Gjb03ceurx8Ncz8OIo1bIB53LUrOw5/jlLxIx+hO3V7Y1+AfI4xpST+MqD3Tda2/PAifdwNPHgyR9/1VMQobrFO28Wu+jcoO2yN/m1XRbdOiQGuLu86fSxEBaiMSDnhCKu5gLX793xs1I6SzcVcSd+/c5/JeTu4C7yRWI0uL5xDWd6iWORGpzI1FltRpumclNAQO4sdj3Wh33AHV9PyiUzAOO4C82RP0IoLONnTym2Kt820ZTiM43U=
Received-SPF: pass client-ip=2a01:b747:3005:205::6d;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
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



> On 20. Sep 2026, at 04:03, Boden Randin <bodenrandin1@gmail.com> =
wrote:
>=20
> whpx_get_registers_for_vmexit only refreshes GPRs, RIP and RFLAGS.
>=20
> x86_update_hflags() depends on state not refreshed here, while the =
code
> using the fast runtime state does not depend on the hflags it =
recomputes.
>=20
> Signed-off-by: Boden Randin <bodenrandin1@gmail.com>
> ---
>=20
> Notes:
>    I opted to remove x86_update_hflags() in this patch instead of =
changing whpx_get_registers_for_vmexit to refresh the registers it =
requires because I couldn't find any code that depends on hflags after =
it calls the whpx_get_registers fast path.
>=20
>    Please let me know if I missed something or if maintaining the =
x86_update_hflags call would be preferable. This is my first open-source =
contribution, so please also let me know if I made any mistakes in the =
submission process.
>=20
> target/i386/whpx/whpx-all.c | 2 --
> 1 file changed, 2 deletions(-)
>=20
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index 113f79afb9..79a5256b20 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -744,8 +744,6 @@ static void whpx_get_registers_for_vmexit(CPUState =
*cpu, WHPXStateLevel level)
>     rflags_to_lflags(env);
>=20
>     assert(idx =3D=3D RTL_NUMBER_OF(whpx_register_names_for_vmexit));
> -
> -    x86_update_hflags(env);
> }

Hi,

target/i386/emulate indeed doesn=E2=80=99t use hflags and we do a =
partial
register sync instead of a full one.=20

The purpose of not syncing all the registers needed to compute hflags
is to avoid some of them which aren=E2=80=99t covered by the shared =
register page -
thus affecting performance of MMIO accesses.

For reference these are the registers that are safe to fetch without
tanking performance as they=E2=80=99re part of the shared register page =
between the
VMM and the hypervisor as of recent Windows releases (Win11 era):

    pub gp_registers: [u64; 16],
    pub rip: u64,
    pub rflags: u64,
    pub reserved: u64,
    pub xmm: [u128; 6],
    pub segment: [u128; 6],
    // Misc. control registers (cannot be set via this interface).
    pub cr0: u64,
    pub cr3: u64,
    pub cr4: u64,
    pub cr8: u64,
    pub efer: u64,
    pub dr7: u64,
    pub pending_interruption: HvX64PendingInterruptionRegister,
    pub interrupt_state: HvX64InterruptStateRegister,
    pub instruction_emulation_hints: HvInstructionEmulatorHintsRegister,

WHP documentation doesn=E2=80=99t highlight this (but it is documented =
for
using Linux as dom0/L1VH). Fetching anything not in that list will
instantly go to the slow path of a hypercall and result in a major
MMIO performance hit.

That said, now that we=E2=80=99re properly rebuilding the segments from =
the
Hyper-V provided state instead of using TR/LDTR, it should be safe
to sync all the state required for hflagsat least for Windows 11.

For Windows 10, we=E2=80=99re still half as fast on some workloads than
the prior winhvemulate path so I wouldn=E2=80=99t be so sure...

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>=20
>=20
> static void whpx_get_legacy_fp_registers(CPUState *cpu, WHPXStateLevel =
level)
> --=20
> 2.53.0.windows.1
>=20


