Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12702606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=vCBqpASn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiIk-0002WK-TE; Thu, 26 Nov 2026 17:50:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWiIe-0002VO-0p
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:50:44 -0500
Received: from st-2002g-snip6-11.eps.apple.com ([2a01:b747:3001:205::47]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWiIc-0000Uj-BN
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:50:43 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPS id
 6AB081800094; Thu, 26 Nov 2026 22:50:38 +0000 (UTC)
X-ICL-RepId: 01a21a0d-bf6d-7ea8-939f-3e4013d20d9f
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795733441; x=1827269441;
 bh=3DLV1FkxtLrmuBkMUT2riCkywbUt/E944P97VMKmSwU=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=vCBqpASnbgH0tI8PtvJ40YiTlBhEfE8gcCjzchs/NYT0DSEEhd3zcJirvGjY0LcY9ne5Tg0CRMYkAC1LRl5BWCWkdjipscgW+Sa/VIZnfgwC/kqengwT2DgkrvDtoKvwzHvISNv0blVgqxslObYh+ADVct8XT15T+UdIgoT5lEiMESHY7MDaJwBbKPfMWHbmc5RooRKkN9i6M9aZ60TKO6pN7BrmZdhuGSMcESddwqp70BLMd1pGvUUvwsh72V+SGB3AMvsI5m2Ja2Xqmt/a4RguSPld2/r3d5wIvv4U6rymmpaX7VJFukoLRrU9uzaLrnHjukDtRXYLDmRQtn69EQ==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.216.30])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-0 (Postfix) with ESMTPSA id
 52E8018000B9; Thu, 26 Nov 2026 22:50:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 2/2] target/arm: Read generic timer counters without the
 BQL
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126223959.62899-3-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:50:23 +0100
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <41747CDF-9F97-459E-B059-58E719895ABD@unpredictable.fr>
References: <20261126223959.62899-1-philmd@oss.qualcomm.com>
 <20261126223959.62899-3-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA5MCBTYWx0ZWRfX+XsA+GlaqmZ+
 tJJGJ7d7Kws82FrwTcH7SVF7gY0ChBk8fxkcEhxRlR9kGMAjnkU1jv3RCRgh2TbT8Os35RBquId
 xJULNnmryLjwtiQCT+dCrTu0l/fQg+A=
X-Authority-Info-Out: v=2.4 cv=LsgHWXdc c=1 sm=1 tr=0 ts=6b08b7bf
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fajnDIswKVxD1YtQT70F:22 a=DklAH-oqaN1iciwkUFA5:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=jDd60jxTQFTj_aT_ubcA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: tCm2n0OVf0I77iDUvHsh9JdlkkvwX4wJ
X-Proofpoint-ORIG-GUID: tCm2n0OVf0I77iDUvHsh9JdlkkvwX4wJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA5MCBTYWx0ZWRfX56rxCEHo4Kb7
 67fOiyVdEClPXy4pVJklngSmTILZG1027Xd33Pn6h3E7CXw12r5d1CG7oHrwq14jzYktAuNWrpL
 oRpMUZAa0eE7e80cgMF9uPj0szBONmn+ZtsGZ9zzgDHXIW3+YjFa9lC+rlBNaqREL1S1AtLy4cu
 ZB02dD/OMOhxN4Or7JXYK4kJppBzg2YtexQtBemBeN3glImruFU9sQQvvsepLHWfXxUqnNN8TkR
 MJU0ZQFqtib1JWKXMrM0ksE6L6wW1tlaqZzXe3fe1m10dj4glqZpLoWUDwIFKgkVZpsCA6fnBW9
 7PU6YFcf5Yjvo09d1z+jIR2VTuKuVG2CAbkNebsqmFVmDyhZ033rPCEBXjJUB4=
X-JNJ: AAAAAAABjCewcTM+gwmjPgLN7ePVrivB8g01c7IDHjxV3xfYASdvNBSMmYJquMGysoWFVz
 PEdnFo12P+chiOe4ooCREOzoRYkLiW8IOZUZwMMPgpuN8TazZ73uzwKE9/IgcJMU2EFzsQ
 g9AoQLYwT1VJAdASovKMnL1lULk9xsYGsNcU1y6w+shjQZSCd3fQKG+DN9MjHIz9oaXZ1W
 CR/Qwze+4JTCXZjO6zXsF9AZhF21yYBWlccLHk84DHulyB3zhCHZrpJSJfduTpfdRv99zr
 lIyVqr5Ze+hFD1nBOwmkU/TlIX9FnhB7/+xQeIKxwL+OS4sDO9gPcX8LwTqgsmEe4HMWeV
 JBZ0mhYXWIVALKk6OqTz4iUE6JaO+FRvkxCRTn0fwuWMnoCIPY0BQ+yrdpFf5LbuuV67kw
 qUuOLqd1MrHrTGBasL8fBfyZjUs+c20WdQ4xfBH95mxLeDA5HK2lFf8bUY2TXiKaT3heSF
 QdLFkbXPOu6QydhXhK3367HPc17E9LrN4uzHkMRdLqn/RrOrF3wS6XoonTWMni3MO1oHo/
 CrBtKAvHYEHhDFvmE51mT6Io58oYJwY74Tli+g4fACwCvWsTdXxJ3GU0cMVzYe+KxX8GNB
 /GxjZ+Gd26DX14XgsPUHxRi/TAQ7AdIJuToNOvJqt5GB//IFqtvYjmV/Tm3OyIfEbtbW/N
 /IIwFiCa9Lz9MyZczkwXed9XesndCmwrxYU/8unmbKBqaX41fYg+152TMZ9b4gHR+ix/Rv
 sRc+dqcgUNOZxW88HSG9ykh0D3udVYk2XODpPYrpOl89pQHEq7zquYRI81M9J0RJTiNhT/
 cwQXqpafPhMZDi4nS95UyNXbRSXAvfMmz5B1qVbABVQoU5M3Qm6+Prvo6+sjFC+nwIWMhk
 YJxJf0Krp7mjjYJ4bRWZccn44iUoXDkS1xwli4XcpDzT8MvPyilUwCd44GrLny0zi2nWpK
 eiPInywbpwsbW2quRyscYy5DyYrgpEAPvtJ1frfFuHWJer47ghYfps+j8KnhfxHA/L6MM1
 CTkEbNg1dcoO04zMP9HRCb2MaI4buYRIiG5aB6L6mn9fpln1u9GUAlRssNPQQcELYcpqsE
 41e3ro5qjThDuYqhrsAHeY3i4oL5M387BTVw75MN9LJDzX14IXjgQdyrg9u7ZFSYM6daiN
 7ScU9xyPX6ezf/4S7yY362Xwtnfi72fvP7BRqCwLifCIMm8Cgp1hG/sUhItg4XdReSbagU
 alu4s3/gOGDxdGzvvuDUt2+EzH57OIvDiYgtCZJucFafzeFDdXXTeI4skIzcrq154iE95Z
 8mSqAuG6sw3fCJZHaB1snEJhAWwqMHbc+YYSfJrfPYt4vWxmaEfrBbzNY4z3LXSmM4epOi
 P98+9ApCbgMIQub9XaWy1RiuHMhKuXGZ0BK+Jh/FXrKBEuhR0d6Edb8nqLwUgmtAYE2E3q
 k=
Received-SPF: pass client-ip=2a01:b747:3001:205::47;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26. Nov 2026, at 23:39, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> CNTPCT, CNTVCT and their self-synchronized variants are read-only;
> their readfn uses per-CPU state and QEMU_CLOCK_VIRTUAL, which reads
> through the timers_state seqlock (cpu_get_clock() or icount_get()).
> Mark them ARM_CP_IO_ENDTB only, so MTTCG vCPUs reading the counter
> do not contend on the BQL.
>=20
> Suggested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>

> ---
> target/arm/helper.c | 20 ++++++++++----------
> 1 file changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 198ffc69aeac..cdac27858feb 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2333,23 +2333,23 @@ static const ARMCPRegInfo =
generic_timer_cp_reginfo[] =3D {
>     },
>     /* The counter itself */
>     { .name =3D "CNTPCT", .cp =3D 15, .crm =3D 14, .opc1 =3D 0,
> -      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_pct_access,
>       .readfn =3D gt_cnt_read,
>     },
>     { .name =3D "CNTPCT_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 1,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_pct_access, .readfn =3D gt_cnt_read,
>     },
>     { .name =3D "CNTVCT", .cp =3D 15, .crm =3D 14, .opc1 =3D 1,
> -      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_vct_access,
>       .readfn =3D gt_virt_cnt_read,
>     },
>     { .name =3D "CNTVCT_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 2,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_vct_access, .readfn =3D gt_virt_cnt_read,
>     },
>     /* Comparison value, indicating when the timer goes off */
> @@ -2434,23 +2434,23 @@ static const ARMCPRegInfo =
generic_timer_cp_reginfo[] =3D {
>  */
> static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] =3D {
>     { .name =3D "CNTVCTSS", .cp =3D 15, .crm =3D 14, .opc1 =3D 9,
> -      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_vct_access,
>       .readfn =3D gt_virt_cnt_read,
>     },
>     { .name =3D "CNTVCTSS_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 6,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_vct_access, .readfn =3D gt_virt_cnt_read,
>     },
>     { .name =3D "CNTPCTSS", .cp =3D 15, .crm =3D 14, .opc1 =3D 8,
> -      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_64BIT | ARM_CP_NO_RAW | =
ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_pct_access,
>       .readfn =3D gt_cnt_read,
>     },
>     { .name =3D "CNTPCTSS_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 5,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .accessfn =3D gt_pct_access, .readfn =3D gt_cnt_read,
>     },
> };
> @@ -2512,7 +2512,7 @@ static const ARMCPRegInfo =
generic_timer_cp_reginfo[] =3D {
>     },
>     { .name =3D "CNTVCT_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 2,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .readfn =3D gt_virt_cnt_read,
>     },

Small note that I had when reading the diff:

CNTVCT_EL0 here is for linux-user and the earlier one was for system =
emulation.=20

> };
> @@ -2524,7 +2524,7 @@ static const ARMCPRegInfo =
generic_timer_cp_reginfo[] =3D {
> static const ARMCPRegInfo gen_timer_ecv_cp_reginfo[] =3D {
>     { .name =3D "CNTVCTSS_EL0", .state =3D ARM_CP_STATE_AA64,
>       .opc0 =3D 3, .opc1 =3D 3, .crn =3D 14, .crm =3D 0, .opc2 =3D 6,
> -      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO,
> +      .access =3D PL0_R, .type =3D ARM_CP_NO_RAW | ARM_CP_IO_ENDTB,
>       .readfn =3D gt_virt_cnt_read,
>     },
> };
> --=20
> 2.55.0
>=20
>=20


