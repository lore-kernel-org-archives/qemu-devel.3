Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34827606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 04:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Fz8ChfGI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUGIi-000607-Q5; Thu, 19 Nov 2026 23:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xUGIf-0005zy-VL
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 23:32:37 -0500
Received: from qs-2002g-snip6-3.eps.apple.com ([2a01:b747:3006:207::42]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xUGId-0002ji-Hr
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 23:32:37 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPS id
 E5B9118000B3; Fri, 20 Nov 2026 04:32:31 +0000 (UTC)
X-ICL-RepId: 01a1f73a-3d17-70e9-8f84-2b42daa5cb2e
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795149153; x=1826685153;
 bh=QcJapqi21SDpeDmx9SEUPZElA6KKQl+qb8kC3QImVXA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Fz8ChfGIimjL03UFI+2tWdcVVlqn37F3BeAYfJzgvNWCh1NK5S0D3cNSbOz2JTBnza8dFoYtPpsG1LkSBkLrTL2RaxYchQovcyZzS02W991faId7ceMzDAKHgEWLMs4OdxwesH9Dn9w5n/L3F0jdzvEggN3rOv2KuGcQcxY2GKDVVuBujoaB0BAQbkuKchQNElETOu3r4Sif6XiIkkOCklYSlimDHRYjqLDX3xcZHv+n9N3hwWLZ7kubHiffRhnUVv9DIvpdLOuneXrFj6BN9E8DgUcXT2gP7PyWXwyPLIo+pjJZYAXtX+EIRqGJHXG+PbsANVmOOuXy49PXR7Lpng==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-60-percent-2 (Postfix) with ESMTPSA id
 79CDB180013F; Fri, 20 Nov 2026 04:32:30 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [RFC PATCH] target/ia64: Add initial CPU state and PC accessors
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261120024920.1064-1-joaoanandalima@gmail.com>
Date: Fri, 20 Nov 2026 05:32:18 +0100
Cc: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <0D2184E6-F4D7-4E65-AFB4-12F084251F5E@unpredictable.fr>
References: <20261120024920.1064-1-joaoanandalima@gmail.com>
To: dev12124 <joaoanandalima@gmail.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-GUID: Z7A0F0TibVpkGzsl7AT41WRUhCeCnkZT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAxNyBTYWx0ZWRfX6s8vbBz/ZhGf
 xW4RVXMqwqYWDLCc9+gVvBq8HMH19zZYR7A0+hefWXED+WzV00rBa4kCICr/7ye3dMJSBJ5yGpR
 PSQMNjUyB1GTphoK6jRiLJKoRdAkyrw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAxNyBTYWx0ZWRfXwKuS/OjyPq1i
 qDaR/fqqAp/Pctwpir8japJw+chFzdg7m4ibzfKS57zzIlJWzhSnuTPVr9dzBG3V7hjRGonBVQj
 QbR0t79JAvq69KMvB0rcFBl0L1wfs4GcOh7LLv2tTSSoq8GHgZLhJk+DhRXqDM85udBVN7+zXUE
 vpG9TobeoD8PnsJckFF+JNooPxanAoY2w1/d2jVDhBckMkv+cADRdnnPalwLMGupdPzdPcxvCvN
 U3Orc8Y/oVonk1su1zB2jChw3UR8rAoYvdG0zy+XsdgT2S6i+RwVUMdwxu7UQth+/iLOv40Va68
 NophiQ5ao9RJ/sZQ8+NcK64yS3A07HYaQTHfli54BCDvlr0ao8rESUX64FRyvk=
X-Proofpoint-ORIG-GUID: Z7A0F0TibVpkGzsl7AT41WRUhCeCnkZT
X-Authority-Info-Out: v=2.4 cv=LpUHWXdc c=1 sm=1 tr=0 ts=6affcd60
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=fajnDIswKVxD1YtQT70F:22 a=MUMyTuqJ5fOr1Nv7BSmb:22
 a=pGLkceISAAAA:8 a=tQrIMejGTM08sTklPaUA:9 a=QEXdDO2ut3YA:10
X-JNJ: AAAAAAABYuxskdmSubPB6Tq7Rbvv8+OsjBOTGS5UeRGWAjb9hsLUyCsRk58bP1FAfHsBE8
 BVBhijBGhyrba7Z0GO6VnINBbLzt3McU83fLwcuoOsZajfcr8BMJsvaXoK3mNInz7XFITD
 wUwIMslzSfufzG4whdUBqRVBIO0DwpaoEmz6BjCosqiSLML0ME4kgZ0Hr/kgyAP4vUM4Oi
 KxTxOsrbfrPx/enE/8sZZRgXIENV8Fyqf2tiC+iMbg5LdBN9o2hdBG5lfXgsVJSamWYlyD
 5c0F1bU15UuAmMRyetejsvEPT0qY83omNF5+sIVpl9ye8+hS+vZxDPzLtJqho5xz+4cN8Z
 bMB/jC61wN41nukcMkw141/YOHZSduhSwuZ4MY/6qDIU22Yms+WMivI+jk1/DOXBkmEjuu
 GCQQaxg8fZHyoHZEQYyPj4C0vHmbUKqHLBBkwCE+yo7ZaVeVYk+CMfZPtTJ7zpLaQjk1AP
 0Ly9uwVmkQsEV8D+S4bbtZYaVLIIXPSNxnSDYdpRORTWMOdVdNaS2fPlG5li87S7xpv6Zb
 Gh7+nO5CYHIzYyCbZC/NenJt9kkOKl8PXo1lNX3RhaHFv8iEjnK4kRR9xXE6l53qw8fWbk
 +k9MpVfYBAcQlXJtiN/cshNoSFgJrPynzOWKHsVXRA6CnVhP2tmes3POESM9cm8NSxEu/U
 m7NHShgZ3z2pACBLVJduCma0QyG0c+70ounuw33ZWAOA5gTh9AGEUiN1au2R5vu9yh3h4C
 T91yUXigIEG17CM28mfhMTKQWx/SW/od13atSOk1Fdp7MfYYYCreD00qp12hcfBaVubpZ2
 HDX00ljdDwwGSdQzdML60pkeuhMel/RL++crotOaPblnHnCZDHMirmvDoGKb69IPoKNjxO
 /d3xTh/GMp3lyM+KQOEDDMtzp/m1ysmg5IalatX5C96cIIKzqldgTI60381T72l5/eJ+zP
 fYElaQ/Wdqi2mgN6bHkHBF0tu7GnMg6J9fWpMENCOIAlzHlhWjYiiVVJVDvxhqOEPIYyDg
 2+yQ3YlrxGq2Lqh3SNuB3xmQ/Zqwll+yWkNk6yVK3ieoLyKlVQaQ7RyfumTZHKaNMtD8zL
 8+K7MN2xzIvvjRwcZh9TlSnmIgCSq9NabiPtSAhVRuK6gNvKraMKppxL4OkpxFlm0fvG7H
 YjMe1Upeakd0vTvdgl5Fu6msOCtv5thIzrp8LfgrFcsY5IfEqHRcK/CKvM0EKQH6iyDeDr
 DX7T6jt1xaZ6JqSbXM9DCKzlUu5uykTs9nQLDXsZGfKhrNadylWehSBX5wDD8hcOblmzhV
 G5KD/CQWUhjbhNKv1oVlpzxJjeeeTIqed9eOf8M375OrsG2vzQ0Rw8i2QHc4w8
Received-SPF: pass client-ip=2a01:b747:3006:207::42;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 20. Nov 2026, at 03:49, dev12124 <joaoanandalima@gmail.com> wrote:
>=20
> Signed-off-by: dev12124 <joaoanandalima@gmail.com>

Hi,

No. This alone without a series around it doesn=E2=80=99t make a whole =
lot of sense
if any.

For context: there=E2=80=99s AI-assisted QEMU forks with IA-64 system =
emulation
around, that are functional. But this patch is not that.

> ---
> target/ia64/cpu-qom.h | 43 ++++++++++++++++++++++
> target/ia64/cpu.c     | 54 ++++++++++++++++++++++++++++
> target/ia64/cpu.h     | 83 +++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 180 insertions(+)
> create mode 100644 target/ia64/cpu-qom.h
> create mode 100644 target/ia64/cpu.c
> create mode 100644 target/ia64/cpu.h
>=20
> diff --git a/target/ia64/cpu-qom.h b/target/ia64/cpu-qom.h
> new file mode 100644
> index 0000000000..4ed395df81
> --- /dev/null
> +++ b/target/ia64/cpu-qom.h
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +/*
> +   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software =
Developer'.

This looks like output from a machine learning model.

Did you happen to review the QEMU LLM patches policy? Both the current =
one and what=E2=80=99s
on the list?

> +   *
> +   * Copyright (c) 2026-2028 Jo=C3=A3o (@dev12124 GitHub, @dev =
GitLab).
> +   *
> +   * This file is the CPU Header sign QEMU Models.
> +   * Author: Jo=C3=A3o Guilherme da Silva Freitas Lima =
<joaoanandalima@gmail.com>.
> +   *
> +   * WARNINGS:

Which LLM harness did you (most likely) use?
> +   *
> +   * Permission is hereby granted, free of charge, to any person =
obtaining a copy
> +   * of this software and associated documentation files (the =
"Software"), to deal
> +   * in the Software without restriction, including without =
limitation the rights
> +   * to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
> +   * copies of the Software, and to permit persons to whom the =
Software is
> +   * furnished to do so, subject to the following conditions:
> +   *
> +   * The above copyright notice and this permission notice shall be =
included in
> +   * all copies or substantial portions of the Software.
> +   *=20
> +   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
> +   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
> +   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO =
EVENT SHALL
> +   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, =
DAMAGES OR OTHER
> +   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
> +   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN
> +   * THE SOFTWARE.
> +   */
> +
> +#ifndef __CPu_CLASS_HID
> +#define __CPu_CLASS_HID
> +
> +#include "hw/core/cpu.h"
> +
> +struct IA64CPUClass {
> +    CPUClass parent_class;
> +    DeviceRealize parent_realize;=20
> +    ResettablePhases parent_phases;
> +} __attribute__((aligned(64))); /* Optimization in first local */
> +
> +#endif
> \ No newline at end of file
> diff --git a/target/ia64/cpu.c b/target/ia64/cpu.c
> new file mode 100644
> index 0000000000..731fd6b8bc
> --- /dev/null
> +++ b/target/ia64/cpu.c
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +/*
> +   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software =
Developer'.
> +   *
> +   * Copyright (c) 2026-2028 Jo=C3=A3o (@dev12124 GitHub, @dev =
GitLab).
> +   *
> +   * This file is Implementation CPU Emulated of IA64 Arch.
> +   * Author: Jo=C3=A3o Guilherme da Silva Freitas Lima =
<joaoanandalima@gmail.com>.
> +   *
> +   * WARNINGS:
> +   *
> +   * Permission is hereby granted, free of charge, to any person =
obtaining a copy
> +   * of this software and associated documentation files (the =
"Software"), to deal
> +   * in the Software without restriction, including without =
limitation the rights
> +   * to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
> +   * copies of the Software, and to permit persons to whom the =
Software is
> +   * furnished to do so, subject to the following conditions:
> +   *
> +   * The above copyright notice and this permission notice shall be =
included in
> +   * all copies or substantial portions of the Software.
> +   *=20
> +   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
> +   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
> +   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO =
EVENT SHALL
> +   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, =
DAMAGES OR OTHER
> +   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
> +   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN
> +   * THE SOFTWARE.
> +   */
> +
> +#include "qemu/osdep.h"=20
> +#include "cpu-qom.h" /* target/ia64/ */
> +#include "cpu.h" /* target/ia64/ */
> +
> +static void ia64_set_pc(CPUState *cs, vaddr value)
> +{
> +    if(unlikely(!cs)) /* Pure Optimizatiom */
> +        return;
> +
> +    CPUIA64State *env =3D cpu_env(cs); /* Extract */
> +    env->ip =3D env->ip | value & ~0xFULL;
> +    env->slot =3D value & 0x3;
> +}
> +
> +static vaddr ia64_get_pc(CPUState *cs)
> +{
> +    if(unlikely(!cs))
> +        return 0;
> +
> +    CPUIA64State *env =3D cpu_env(cs);
> +    vaddr result =3D env->ip | (env->slot & 0x3);
> +    return result;
> +}
> \ No newline at end of file
> diff --git a/target/ia64/cpu.h b/target/ia64/cpu.h
> new file mode 100644
> index 0000000000..f83f508c43
> --- /dev/null
> +++ b/target/ia64/cpu.h
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: MIT */
> +
> +/*
> +   * QEMU Project for Intel Itanium (IA-64) emulation by 'Software =
Developer'.
> +   *
> +   * Copyright (c) 2026-2028 Jo=C3=A3o (@dev12124 GitHub, @dev =
GitLab).
> +   *
> +   * This file is the CPU Header sign QEMU Models.
> +   * Author: Jo=C3=A3o Guilherme da Silva Freitas Lima =
<joaoanandalima@gmail.com>.
> +   *
> +   * WARNINGS:
> +   *
> +   * Permission is hereby granted, free of charge, to any person =
obtaining a copy
> +   * of this software and associated documentation files (the =
"Software"), to deal
> +   * in the Software without restriction, including without =
limitation the rights
> +   * to use, copy, modify, merge, publish, distribute, sublicense, =
and/or sell
> +   * copies of the Software, and to permit persons to whom the =
Software is
> +   * furnished to do so, subject to the following conditions:
> +   *
> +   * The above copyright notice and this permission notice shall be =
included in
> +   * all copies or substantial portions of the Software.
> +   *=20
> +   * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, =
EXPRESS OR
> +   * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF =
MERCHANTABILITY,
> +   * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO =
EVENT SHALL
> +   * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, =
DAMAGES OR OTHER
> +   * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, =
ARISING FROM,
> +   * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER =
DEALINGS IN
> +   * THE SOFTWARE.
> +   */
> +
> +#ifndef __CPU_HEADER_MODEL__
> +#define __CPU_HEADER_MODEL__
> +
> +#include "cpu-qom.h"
> +#include "exec/cpu-defs.h"
> +
> +#ifndef unlikely
> +#define unlikely(x) __builtin_expect(!!(x), 0)
> +#endif
> +
> +typedef struct CPUArchState {
> +      uint64_t gr[128];
> +
> +      uint64_t nat_lo;
> +      uint64_t nat_hi;
> +
> +      uint64_t pr;
> +
> +      uint64_t br[8];
> +
> +      uint64_t ar[128];
> +
> +      uint64_t cr[128];
> +
> +      uint64_t ip;
> +      uint64_t slot;
> +
> +      uint64_t cfm;
> +
> +      uint64_t psr;
> +} __attribute__((aligned(64))) CPUIA64State; /* Aligned in a Cache =
Line (I love optimization) */
> +
> +struct ArchCPU {
> +    CPUState parent_obj;
> +    CPUIA64State env;
> +} __attribute__((aligned(64)));
> +
> +#define TYPE_IA64_CPU "ia64-cpu"
> +OBJECT_DECLARE_CPU_TYPE(IA64CPU, IA64CPUClass, IA64_CPU)
> +
> +static inline void cpu_get_tb_cpu_state(CPUIA64State *env, vaddr *pc,
> +                                 uint64_t *cs_base, uint32_t *flags)
> +{
> +    =
if(unlikely(!env)||unlikely(!pc)||unlikely(!cs_base)||unlikely(!flags))
> +        return;
> +
> +    *pc =3D env->ip | (env->slot & 0x3);
> +    *cs_base =3D 0;
> +    *flags =3D 0;
> +}
> +
> +#endif
> \ No newline at end of file
> --=20
> 2.55.0.windows.3
>=20
>=20


