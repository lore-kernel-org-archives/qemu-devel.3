Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769A710AB80E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 19:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5qdd-00027J-Ob; Thu, 26 Mar 2026 15:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qdP-00021U-W5
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:44:55 -0400
Received: from p-east2-cluster4-host10-snip4-8.eps.apple.com ([57.103.78.229]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5qdL-0005Gk-3l
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 15:44:49 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPS id
 548C218004E5; Thu, 26 Mar 2026 19:44:44 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774554285; x=1777146285;
 bh=tBmyJQ7p4Cluh+zdfrpL2L2IKX3SPyM40KfPD8MHHJk=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=X/7xPQWZnHaePw/g/TAM4Z3NK/xoCEIDu7fsuFkWAtkStT4DM3U+ZOIr04v997BbQHrZMqlS2x5eFwKrMGlel+dEscaoeNxMoZw8l7oOE8u/4lwQ48Gm8cbSLb+DlzezlSktKeq5mvOfQ6E7ocEC0aJ3X37YHHw7ZhNO7MxuTkRTvFDCfHhnxsea/oBqQsrgD2qd2VFBpS+G/BPpH8ASGY0LJuaTy5JpiFoygOAowqQ8sUbADnprULrdeUugNm0M9CxAJTKDhnTZU202bqrvUQuVExNHW4biYSq/1Ig/5GrC7MWpNKKugnW7CRDq6vkc1+2GDOK3eNI/jngdgLjgLw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-10 (Postfix) with ESMTPSA id
 BA071180029E; Thu, 26 Mar 2026 19:44:42 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v4 3/3] target/i386: emulate: LOG_GUEST_ERROR for
 read/write from unmapped MMIO
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260326193358.97858-4-mohamed@unpredictable.fr>
Date: Thu, 26 Mar 2026 20:44:30 +0100
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?B?IkRhbmllbCBQLiBCZXJyYW5nw6ki?= <berrange@redhat.com>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 =?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E508D818-79A4-4E0B-8581-2E94F332249F@unpredictable.fr>
References: <20260326193358.97858-1-mohamed@unpredictable.fr>
 <20260326193358.97858-4-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
X-Proofpoint-ORIG-GUID: dRoCwN_VYp3sPeOtksprrGVNeQw3kKso
X-Authority-Info-Out: v=2.4 cv=fKA0HJae c=1 sm=1 tr=0 ts=69c58cac
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=nKRBnGPCAAAA:8 a=RCJod1fPjBTFiDIV9qEA:9
 a=QEXdDO2ut3YA:10 a=JhrwjW1jOIvqYJKOqOMI:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDE0MiBTYWx0ZWRfX6V3gj0CcTB5N
 20/d2XeKcosqvbaziBVJrqmHV8BTZFEJgKU4OMWcjvXE2pWUU08Wcqzk9tAQpUVXT6OxyXFdo8F
 0qq9J/6mr5zAAEdjD0QTC8H+wZ2cPoudPt9eRaaHVY3n/ySAt770WmngimPsIHPyIbREHSMpQeu
 JLZv+a4wu1/1cZqKuMHZ5qWBJtjFLF2fKEoAbASr/tp4MuvR6mNx/IackIKK1iQ235qvaAcTDsD
 VNr5zWqeMccQPW1fjBASrABtDfpK8q7H8NuxxDQjtmNnV8uZaRUIR397k8sEFfmhpXpvZwW9EWv
 iKze8TepE0CSNFU98m6DspGeIeSMaMlISNHeSRfvfcp41/ODid+e9PGeQSxiFo=
X-Proofpoint-GUID: dRoCwN_VYp3sPeOtksprrGVNeQw3kKso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260142
Received-SPF: pass client-ip=57.103.78.229;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



> On 26. Mar 2026, at 20:33, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> ReactOS's install ISO does a bunch of 4-byte accesses
> to 0xffdff124. This doesn't happen for the boot ISO.
>=20
> It looks to be an access relative to the Windows KPCR
> which is at 0xffdff000 but mistakenly done prior to
> paging being on...
>=20
> =
https://geoffchappell.com/studies/windows/km/ntoskrnl/inc/ntos/i386_x/kpcr=
.htm
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

Thinking about it more, this is not necessary.

Because -d invalid_mem logs this already=E2=80=A6=20

Sending a new revision=E2=80=A6 (and got it confirmed that ReactOS does
the same thing under TCG=E2=80=A6)=20

> ---
> target/i386/emulate/x86_mmu.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/i386/emulate/x86_mmu.c =
b/target/i386/emulate/x86_mmu.c
> index c69ae96acb..815d01d97f 100644
> --- a/target/i386/emulate/x86_mmu.c
> +++ b/target/i386/emulate/x86_mmu.c
> @@ -21,7 +21,7 @@
> #include "cpu.h"
> #include "system/address-spaces.h"
> #include "system/memory.h"
> -#include "qemu/error-report.h"
> +#include "qemu/log.h"
> #include "emulate/x86.h"
> #include "emulate/x86_emu.h"
> #include "emulate/x86_mmu.h"
> @@ -287,7 +287,7 @@ static MMUTranslateResult =
x86_write_mem_ex(CPUState *cpu, void *data, target_ulo
>                             MEMTXATTRS_UNSPECIFIED, data, copy);
>=20
>         if (mem_tx_res =3D=3D MEMTX_DECODE_ERROR) {
> -            warn_report("write to unmapped mmio region gpa=3D0x%" =
PRIx64 " size=3D%i", gpa, bytes);
> +            qemu_log_mask(LOG_GUEST_ERROR, "write to unmapped mmio =
region gpa=3D0x%" PRIx64 " size=3D%i", gpa, bytes);
>             return MMU_TRANSLATE_GPA_UNMAPPED;
>         } else if (mem_tx_res =3D=3D MEMTX_ACCESS_ERROR) {
>             return MMU_TRANSLATE_GPA_NO_WRITE_ACCESS;
> @@ -339,7 +339,7 @@ static MMUTranslateResult x86_read_mem_ex(CPUState =
*cpu, void *data, target_ulon
>                            data, copy);
>=20
>         if (mem_tx_res =3D=3D MEMTX_DECODE_ERROR) {
> -            warn_report("read from unmapped mmio region gpa=3D0x%" =
PRIx64 " size=3D%i", gpa, bytes);
> +            qemu_log_mask(LOG_GUEST_ERROR, "read from unmapped mmio =
region gpa=3D0x%" PRIx64 " size=3D%i", gpa, bytes);
>             return MMU_TRANSLATE_GPA_UNMAPPED;
>         } else if (mem_tx_res =3D=3D MEMTX_ACCESS_ERROR) {
>             return MMU_TRANSLATE_GPA_NO_READ_ACCESS;
> --=20
> 2.50.1 (Apple Git-155)
>=20


