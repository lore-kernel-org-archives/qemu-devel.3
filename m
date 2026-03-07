Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AAFFC9EDA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 09:13:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyniz-0005u2-Kb; Sat, 07 Mar 2026 04:13:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyniw-0005t7-QA
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:13:26 -0500
Received: from ci-2003b-snip4-11.eps.apple.com ([57.103.91.151]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyniu-0005Ml-2Q
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 04:13:26 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPS id
 62BA61800167; Sat,  7 Mar 2026 09:13:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772874801; x=1775466801;
 bh=7QUN000MA0rOKOh8aD0F03Bdt/hAEWOM328SthX3qYg=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ayQ+uI9fWDGr1Vk8PcPamthaF3i3cgug5RX2J3A1BhLVpeXkWpuDR/reaHl+C3AuIFAqjO6fUlt0IryC2AdmGGJMbo60wGPK9qKEZH3HOK/aY87SCVQKHLsnBgA4QV9rmTEiM1r1E20NGsLugwQB7k8+Q75pG1jSORhwdmRF7xs5uVLWMy4uIBhw92TR8aMG4E+yPYmOzV8xfV1OfP9uB0pk7NBDW1qZl0dTMupEjfs5cHpok1xH8uC3a5O3+iaJckWcMbggMvk9aueR2/+vkBWtfWCnMh/mrBuNvrZehTjfDwidSfSOEU7jVjud4V+oH0tvVYoonbk1e4kT7R3vTg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-0 (Postfix) with ESMTPSA id
 519391800096; Sat,  7 Mar 2026 09:13:16 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH v17 12/14] hvf: arm: disable SME when nested virt is active
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260307090606.95300-13-mohamed@unpredictable.fr>
Date: Sat, 7 Mar 2026 10:13:03 +0100
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Mads Ynddal <mads@ynddal.dk>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <BE4DF00D-6E4A-4BBC-9E56-6A2327C9F371@unpredictable.fr>
References: <20260307090606.95300-1-mohamed@unpredictable.fr>
 <20260307090606.95300-13-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.400.21)
X-Proofpoint-ORIG-GUID: vqO6eo78Xgy56fbEtCOxDhbgur5m-0g7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA4NCBTYWx0ZWRfX6THsmKZA9VMB
 +MGGdN9xko41HYMkNZqJycWjWgONhKGc+cipPbGpGCG7YAA3Bi386zNKHtEEQcD2Eyrl4H15tez
 B2dqWPc196j/JzJCnDoykm5RghE9Msxrnx8QEOqDv8zS25s/nVJCKMpNrRJxZMd7wQEzRkt/W0k
 Z6XNbaGdKrcQIo1uadW2577PGOl+xEJ1J5X/GLSAaCvE23EEn/E4yYnx3oheTVka9dsIKO0k0+e
 uOFkRCyBBJVqIWORnwRpEK0trUaoLSF6gtvgHI1iJr2KQwSq9mOh3KOULg9FKJHoEiJWkXyNHeN
 /pentaj2x2vxMdvdhvS1aRy8HNsmRFclrn9j+Sgf2DhNKl1l+Jb0YNllm1IPUQ=
X-Authority-Info-Out: v=2.4 cv=FcI6BZ+6 c=1 sm=1 tr=0 ts=69abec2f
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=XYctVz3StARBtGIkRf4A:9
 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: vqO6eo78Xgy56fbEtCOxDhbgur5m-0g7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1030 phishscore=0
 bulkscore=0 mlxlogscore=702 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603070084
X-JNJ: AAAAAAABNKwDyN8TZpUZZXCAsxd0D06grUf0WwwriIhbJiPM8NX7SgG2de1ewxP8C+C4S67pYnAcFWAuPSnRNMQLXyy/xslBqLqW7/cnEq0hiVE9q/24sB5VsLyzJ/0ngEliGP9hRVu2mew+T38T1jN+zkI03i+ssFinR0/H2B5XUxI4r/tscgyWipRY/trYgakzYy07MuoG+mZCZenRQMLOB2/m1E2Erey/LjRrI9BWiFhO8pxiktRZ1OFbAU2coZ/9Lkk8gdRR9roQlopy0KMvO2t2Mv8jeClMUXyDB8ZkYOPyhVG6JPQCv3gfd6f7xB9c9GveJPfdnf5+PnPQtNHeOJqA+SHSAi5pxgrx2iqwR5w8hh2PxRafyGcat4WPQ8+Jvb39tXdJjaELzrw/hKRHVJjqpvyqwyJC3bYFPQ/aNhawS3Qi/e7BQZCLQpbCK5iLis6YnwGvIcawyF0DqPS4PUyj9EPrW3XYS2ov5ASSWqdaA485zYNBPFkDJpoXEHjhi2+yY0ndYC+pi/hEJ3aA2Mu/Bidg/S53lFTvzUGHyQpxw5oWmSpyG0DTtiihVOTRfpKe+nBUo85rQTEFhj4MMQ+wZYl1EUTXow6qI+x1vko42KJ/WuVZgA1rZu3rGenlYm6m0YAyQQ5gdI0TWd/HRHXHQxFSbZ5xq21e6aDhPGPJvMV91ne1IcyZJrElyVSITb/CjdZco5paHQM9fVUjvnN4rZChU/KbLpoJ385Y2Q==
Received-SPF: pass client-ip=57.103.91.151;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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



> On 7. Mar 2026, at 10:06, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> Currently, Apple doesn't support the nested virtualisation + SME =
combination.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/arm/hvf/hvf.c | 3 +++
> target/arm/hvf_arm.h | 5 +++++
> 2 files changed, 8 insertions(+)
>=20
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 6666d77e18..2cb4c4aa4e 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -1189,6 +1189,9 @@ static bool =
hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>=20
>     if (hvf_nested_virt_enabled()) {
>         FIELD_DP64_IDREG(&host_isar, ID_AA64DFR0, PMUVER, 0x1);
> +        /* SME is not implemented with nested virt on the Apple side =
*/
> +        SET_IDREG(&host_isar, ID_AA64PFR1,
> +              GET_IDREG(&host_isar, ID_AA64PFR1) & =
~R_ID_AA64PFR1_SME_MASK);

Oops, same note applies that this is equivalent to

FIELD_DP64_IDREG(&host_isar, ID_AA64PFR1, SME, 0);

>     }
>=20
>     ahcf->isar =3D host_isar;
> diff --git a/target/arm/hvf_arm.h b/target/arm/hvf_arm.h
> index 6b1c3b9792..9cb58ad9ab 100644
> --- a/target/arm/hvf_arm.h
> +++ b/target/arm/hvf_arm.h
> @@ -11,6 +11,7 @@
> #ifndef QEMU_HVF_ARM_H
> #define QEMU_HVF_ARM_H
>=20
> +#include "system/hvf.h"
> #include "target/arm/cpu-qom.h"
>=20
> /**
> @@ -35,6 +36,10 @@ void hvf_arm_set_cpu_features_from_host(ARMCPU =
*cpu);
>         if (__builtin_available(macOS 15.2, *)) {
>             size_t svl_bytes;
>             hv_return_t result =3D =
hv_sme_config_get_max_svl_bytes(&svl_bytes);
> +            /* Nested virt not supported together with SME right now. =
*/
> +            if (hvf_nested_virt_enabled()) {
> +                return false;
> +            }
>             if (result =3D=3D HV_UNSUPPORTED) {
>                 return false;
>             }
> --=20
> 2.50.1 (Apple Git-155)
>=20


