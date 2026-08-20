Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 800CDC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 00:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwqii-0002WA-Gs; Wed, 19 Aug 2026 20:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqig-0002Vb-HH
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:33:22 -0400
Received: from ms-2006k-snip6-2.eps.apple.com ([2a01:b747:3002:206::70]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wwqie-0001DE-Ox
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 20:33:22 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPS id
 530D71800112; Thu, 20 Aug 2026 00:33:16 +0000 (UTC)
X-ICL-RepId: 01a01c96-24f7-7d42-9da4-1379eb7e547a
X-ICL-Out-Info: HUtFAUMHWwJACUgATUQeDx5WFlZNRAJCTQBIHVoORQNGCVYLWhcOVk1UF1sMWg5WMEwWQx9SD1sTTRlRAVJFVAIZHldQQgVCAlwcWg5DClAcXFZVHxcZUU0KWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEDV0dRQ5WGVoMUg9bDhwWS1heBFNWDkN7QXYvcy0DXQ5AdigaXwE0D1UKL3FSHzV/OgJcA1sGNQpLAi1CBUICXBxaDkMKUBxcVlUfCUtGCUkdDg5CGEYfVCdXAloKWx4=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1787185999; x=1789777999;
 bh=kDA9xPfno4ZHl2g7VT5z861vBWbtiyPVCpTia1/rgSY=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=FXvNsrJjYlFfT08Gn2dla4tNxc9tid4LCrEIC/kIBPYZaTQ31ZmGUwxvjYNMtFzsZ6t4DGHvN7kAz6iuujy5QGEJpL/umILtyX1/mabv1JiNkZI55RGlU2B3Or1kdWvDEvXf7+tPCCPvgPyX2O3JBCSlsKcVXPsQmsvkeJUAju7wM29ldbvIU+03lAxYnNTj6ASSIUJM9PPuIBDVRyWP1AKn8R3E40BIYwKQIkQfvgilLJ+0Q7xT/2BJZC+xu5l7UvH0C5gCAiKqa2GYOy6qohG9A9V4ZAtMp7x257iQdqZ//Vxsi+/+RWizyTJegSifXiiTjewdT4HRnI8jJL/l7A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-20-percent-2 (Postfix) with ESMTPSA id
 C52511800212; Thu, 20 Aug 2026 00:33:15 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v2 3/3] target/arm/whpx: fix whpx-arm post-reset CPU state
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <LVXPR21MB700904005D373B0ADE250F3CADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
Date: Thu, 20 Aug 2026 02:33:02 +0200
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pedro d'Aquino Filocre F S Barbuda <pbarbuda@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B9EBDF1-78EE-43D6-9BF9-EFB11404E331@unpredictable.fr>
References: <LVXPR21MB700904005D373B0ADE250F3CADA42@LVXPR21MB7009.namprd21.prod.outlook.com>
To: "Doug Cook (WINDOWS)" <dcook@microsoft.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-Authority-Info-Out: v=2.4 cv=a/Y9NESF c=1 sm=1 tr=0 ts=6a864b4d
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8 a=oXoTwZWFiXUUZX5JRoAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bw1YFVI_t8clzYNzZQ_aFMzc1xuoR7jv
X-Proofpoint-ORIG-GUID: bw1YFVI_t8clzYNzZQ_aFMzc1xuoR7jv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDAwMiBTYWx0ZWRfX2G9CXvB1Kr/C
 usWfRgkllUUCCPrcAyp7ImcYtCcnydVLRo+rYfmX52LKBye32AD/3bX9/A7r6DjLZXgT1UzGzEK
 i0HKaGq3S4vr4V7Nz4RL1eTex4NjtKYOTxkIiF2jEwuQmFbK6bI/qhFaj/CCe3RqRj57wwFs/3U
 o69hQ2Z5jFsb/7J2b3uM0Mjm6TcfA6bZREjImSnVquG2WtVvS9PdMI1jZRYpFVvGnKHje2JMYba
 a8McRiDZqUEBzSSVHIXTNH5t/bw8Up3Vmea4Unsei9IN46mS4F4FMwSHxEeZt+8/6x7TdCg23jV
 BDn1YZkvoOiceV62egtADNfwSnPRr6ZJfkrhHkOW7py2crK70VeB+qIGpBtejI=
X-JNJ: AAAAAAAByVmbo0IJAGl6wAuTyY89tv0NEpXRHxck8DRm6b7GQ2Bj32tTu9mQOALWp5xyrHPvezmk/a3Ttcxx8/o0A09TFy4KjG0yAUiASw03ad7bGCdULszsIi3iOolI1nq655HkVwR6RnNfK/poiiXzA6j/Goe7pM/xM9YJQDb4Dv9EPIm0jMbAHUHbGEUeZ7xq/RQ1DPCmDH67HVL9/qI5eQ+jyrWt1l0/y86SvrZ+pcDnfA5HsozBjK9CJfdU0Mnl5o1nXuu7t6pTYyB9MpWslvYTnMUO57BRVSdNOkuxIYj8J+S9j5RSLzpHZKd57ng2G5Te6UnBD5+A1bgWTgdsEgDoyM5QjA4LZFnZHd9ejDz2BwbyijhBtuu1IOtZ6+r9M538dHJfgcQVDMRODYlwo+lwRUOIzhq31fCxaaq0DfvrMlXvEeJ+aA0IO4PLsd1Kg8fqkQZWT9QJf6uIvJY/TnYMSuxjorIs0+0bSxXG7qfIGBtMUIE3PbDr77Lum+MIdmFbTxvnR8dN4UO9FB0NCBQ5LDvFUX2BiKMBcCU+cNPxRwJ0r4thbQqgHvyloqvFgjK2pyuJ8yGRr0YQApaqapeotXjPYC020QbI25r2vBnSzN6kSRR7hLxUpxTQxoaoEcJIUnyVeLxl3zrEVmrotbm9pcXo3sApK8iM0yPDeN3ciFR6bwUqE/qoi7KVfQSP0F6PKUDmGXZCU3gpBmjrflr48pu8UziT58U/yQSubLCEZEpJsfhmc/Y5ff/g4n4XTT1ZnYSulx+bS7yzo98p+Kfw63Z76UL5egaVCBeX8IGIgDbBRQUETGnryDXvcpcH46EkC8WqIGUgXQdO4qEFWUyyQZe2NcmvPSASGA1uR8k/X283aGxBlKAIvVozCwLTC7jreWk64Q0Pg3ucLYT02NZtvq8EdhRgYDsgfNJBTokCKGVqPik1THZiMbOeQ/o8sFhHaYrfEAxvnHJfJsGq40QlppJ
 sZMy+STOw8MgJmd+qkbJ9rwZCoreskF3cSMr4dIgGlYU9/BF+lJrPi7vYBHeyWubTxMgPKNgWmNncHDyq2elXIaWQgMseJtJAAz0WcMGOSVtEaGB8i/uKpehOFFQGxEpxXhth+KidHJVVpgMf1SXQm6j5C4s0ZDgSWkVzFQV5GAmAHQG9e6TYGbsT16GcPUVRwkp3+BYBsxlUUwXaP1iJ+1Xh1zW4LkRXEhewmKk5vc9Tu+L4ihsX2wzXik0nv+hKaqIPhLR6oOQYNCdKgxhEfNwgnDxJM078bSIPpDkiJTEspthDqZs9Uxd1tZ2CP6VBgw8nB9hi4jEBAqK5rviO/Q++/6DqvEJovWtpXPYXIUpCu0BXd0SndRk/IEd+UHcnljM/
Received-SPF: pass client-ip=2a01:b747:3002:206::70;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
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



> On 20. Aug 2026, at 02:30, Doug Cook (WINDOWS) <dcook@microsoft.com> =
wrote:
>=20
> Reset should leave CPU 0 running, and should leave all other CPUs
> suspended. Instead, no CPUs are suspended and CPUs may be left in
> low-power states.
>=20
> Fix by updating state in whpx_set_registers WHPX_LEVEL_RESET_STATE.
>=20
> Signed-off-by: Doug Cook <dcook@microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/whpx/whpx-all.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
>=20
> diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
> index a05df7d2cb..d106400686 100644
> --- a/target/arm/whpx/whpx-all.c
> +++ b/target/arm/whpx/whpx-all.c
> @@ -613,6 +613,37 @@ void whpx_set_registers(CPUState *cpu, =
WHPXStateLevel level)
>             whpx_set_reg(cpu, whpx_sreg_match[i].reg, val);
>         }
>     }
> +
> +    if (level =3D=3D WHPX_LEVEL_RESET_STATE) {
> +        /*
> +         * WHPX keeps the "vCPU is in a low-power wait" state =
(entered when the
> +         * guest executes WFI/WFE) in =
WHvRegisterInternalActivityState, and that
> +         * state is not affected by writing the architectural =
registers above.
> +         * If the guest happened to be idle when the reset was =
requested, the
> +         * vCPU would stay suspended forever.
> +         *
> +         * StartupSuspend is the bit WHP uses to hold a vCPU that has =
not been
> +         * started yet, and it is how secondary vCPUs are parked =
until PSCI
> +         * CPU_ON releases them.
> +         */
> +        WHV_REGISTER_NAME name =3D WHvRegisterInternalActivityState;
> +        bool powered_off =3D arm_cpu->power_state =3D=3D PSCI_OFF;
> +        WHV_REGISTER_VALUE ia;
> +        HRESULT hr;
> +
> +        clean_whv_register_value(&ia);
> +        hr =3D whp_dispatch.WHvGetVirtualProcessorRegisters(
> +            whpx_global.partition, cpu->cpu_index, &name, 1, &ia);
> +        if (SUCCEEDED(hr) &&
> +            (ia.InternalActivity.IdleSuspend ||
> +             ia.InternalActivity.HaltSuspend ||
> +             ia.InternalActivity.StartupSuspend !=3D powered_off)) {
> +            ia.InternalActivity.IdleSuspend =3D 0;
> +            ia.InternalActivity.HaltSuspend =3D 0;
> +            ia.InternalActivity.StartupSuspend =3D powered_off;
> +            whpx_set_reg(cpu, WHvRegisterInternalActivityState, ia);
> +        }
> +    }
> }
>=20
> static uint32_t max_vcpu_index;
> --=20
> 2.55.0.vfs.0.3


