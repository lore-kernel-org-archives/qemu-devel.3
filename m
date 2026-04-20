Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23D01F5581E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 11:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEmn9-00043s-Jd; Mon, 20 Apr 2026 07:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEmn4-00043Q-OS
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:27:47 -0400
Received: from p-west3-cluster1-host8-snip4-10.eps.apple.com ([57.103.73.211]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wEmn1-0003vU-HE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 07:27:45 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-5 (Postfix) with ESMTPS id
 C15791800411; Mon, 20 Apr 2026 11:27:38 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776684461; x=1779276461;
 bh=Krffpx7w2ZVSMIrNsZDbV8VgM7sYpLIn8x9ysKUuL/8=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=ZtFK0Re5/WdV1c0DJUDvM/5ty/S3DhFgBDsqDaotcthJUyXg1baJ98MrcgPIRq6mR4KjA3rKunmPuLxcDAFz9wHUDSaOI24D6F6k3l4qsqhwqDdwbX2dcKvViWimqfEWId9CuzCw3P4tDEhRvQFOrMHA+xpH6Lv8r/zAmiIDVg7Su0FDabYoQ6Bo5u8UMd57O1Sqz/6FKOHmlIM6bvVzSJACd5dHK8IIZJBEIfPKoe1YfJZBMd7Z5reyl9SPefEHUx4UZhGuO9396a+Go3KSmgKJnn1+CnCAN4W1POeXrVI0vTg/T2cy6FdWpXbMiZEGk/gm/prye8G1n5Unw9QIdg==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-5 (Postfix) with ESMTPSA id
 5814B1800401; Mon, 20 Apr 2026 11:27:36 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 35/38] target/i386: emulate, hvf: rdmsr/wrmsr GPF
 handling
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260420104248.86702-36-mohamed@unpredictable.fr>
Date: Mon, 20 Apr 2026 13:27:24 +0200
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5D9A012C-0278-44A4-82AA-185FF61AF3D8@unpredictable.fr>
References: <20260420104248.86702-1-mohamed@unpredictable.fr>
 <20260420104248.86702-36-mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=TambdBQh c=1 sm=1 tr=0 ts=69e60dab
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=U6C6HV61ui0oiVVhl9AA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 16tPBr9IHtOHWuoujYDLbEz0qr5Jr7Mt
X-Proofpoint-ORIG-GUID: 16tPBr9IHtOHWuoujYDLbEz0qr5Jr7Mt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExMSBTYWx0ZWRfX6X4izME+gVhF
 aZ/cgfneMbFhM/cFQrnOUUtC4yUAVSVJkT3YxAHXpWi8AkTFfQcqQ3JIm6xIPgWyCEIxvzk1d4h
 9PTaqhVG0iMO4YVzzsdDF3XmXAyemgfhtkNKNFz4TlE4BrZFFuuI84T/YxTg5/hJhJgSUA/04eT
 QBCixXSSry8prpsDxk/evjswv418Rgc5+dss2bEykg1liNQeYStL26bd4BBKtX5yeb6/McHZXYB
 LuDWZkEvmvRPZoll9uAKn41rDgjyPg0rlNc5R+Nm00HE4b+r3PxVRuhlco+vAXtuePL11BcMFr6
 qBmhD9qGGrPVkuUYOFnLaF0Hop8o52IDcypSrTA5sqBBDvQP1GwjIQPQ71iEek=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0 mlxscore=0 clxscore=1030
 phishscore=0
 lowpriorityscore=0 mlxlogscore=865 adultscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604200111
Received-SPF: pass client-ip=57.103.73.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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



> On 20. Apr 2026, at 12:42, Mohamed Mediouni <mohamed@unpredictable.fr> =
wrote:
>=20
> In that case, the instruction pointer mustn't be incremented.
>=20
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
> target/i386/emulate/x86_emu.c | 10 ++++++----
> target/i386/emulate/x86_emu.h |  4 ++--
> target/i386/hvf/hvf.c         |  9 +++++++--
> 3 files changed, 15 insertions(+), 8 deletions(-)
Hi,

Forgot to include this to the sent patch=E2=80=A6

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index 8c42ae6b01..b91c17e2fc 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -19,8 +19,8 @@
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
=20
 void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
-void hvf_simulate_rdmsr(CPUState *cpu);
-void hvf_simulate_wrmsr(CPUState *cpu);
+bool hvf_simulate_rdmsr(CPUState *cpu);
+bool hvf_simulate_wrmsr(CPUState *cpu);


> diff --git a/target/i386/emulate/x86_emu.c =
b/target/i386/emulate/x86_emu.c
> index c2da1a133f..c6ea854290 100644
> --- a/target/i386/emulate/x86_emu.c
> +++ b/target/i386/emulate/x86_emu.c
> @@ -792,15 +792,17 @@ void x86_emul_raise_exception(CPUX86State *env, =
int exception_index, int error_c
>=20
> static bool exec_rdmsr(CPUX86State *env, struct x86_decode *decode)
> {
> -    emul_ops->simulate_rdmsr(env_cpu(env));
> -    env->eip +=3D decode->len;
> +    if (!emul_ops->simulate_rdmsr(env_cpu(env))) {
> +        env->eip +=3D decode->len;
> +    }
>     return 0;
> }
>=20
> static bool exec_wrmsr(CPUX86State *env, struct x86_decode *decode)
> {
> -    emul_ops->simulate_wrmsr(env_cpu(env));
> -    env->eip +=3D decode->len;
> +    if (!emul_ops->simulate_wrmsr(env_cpu(env))) {
> +        env->eip +=3D decode->len;
> +    }
>     return 0;
> }
>=20
> diff --git a/target/i386/emulate/x86_emu.h =
b/target/i386/emulate/x86_emu.h
> index a8d4c93098..b985240b90 100644
> --- a/target/i386/emulate/x86_emu.h
> +++ b/target/i386/emulate/x86_emu.h
> @@ -31,8 +31,8 @@ struct x86_emul_ops {
>     target_ulong (*read_cr) (CPUState *cpu, int cr);
>     void (*handle_io)(CPUState *cpu, uint16_t port, void *data, int =
direction,
>                       int size, int count);
> -    void (*simulate_rdmsr)(CPUState *cs);
> -    void (*simulate_wrmsr)(CPUState *cs);
> +    bool (*simulate_rdmsr)(CPUState *cs);
> +    bool (*simulate_wrmsr)(CPUState *cs);
>     bool (*is_protected_mode)(CPUState *cpu);
>     bool (*is_long_mode)(CPUState *cpu);
>     bool (*is_user_mode)(CPUState *cpu);
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index c0d028b147..dfe7500010 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -536,7 +536,7 @@ void hvf_store_regs(CPUState *cs)
>     macvm_set_rip(cs, env->eip);
> }
>=20
> -void hvf_simulate_rdmsr(CPUState *cs)
> +bool hvf_simulate_rdmsr(CPUState *cs)
> {
>     X86CPU *cpu =3D X86_CPU(cs);
>     CPUX86State *env =3D &cpu->env;
> @@ -557,6 +557,7 @@ void hvf_simulate_rdmsr(CPUState *cs)
>         ret =3D apic_msr_read(cpu->apic_state, index, &val);
>         if (ret < 0) {
>             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
> +            return 1;
>         }
>=20
>         break;
> @@ -639,9 +640,10 @@ void hvf_simulate_rdmsr(CPUState *cs)
>=20
>     RAX(env) =3D (uint32_t)val;
>     RDX(env) =3D (uint32_t)(val >> 32);
> +    return 0;
> }
>=20
> -void hvf_simulate_wrmsr(CPUState *cs)
> +bool hvf_simulate_wrmsr(CPUState *cs)
> {
>     X86CPU *cpu =3D X86_CPU(cs);
>     CPUX86State *env =3D &cpu->env;
> @@ -657,6 +659,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
>         r =3D cpu_set_apic_base(cpu->apic_state, data);
>         if (r < 0) {
>             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
> +            return 1;
>         }
>=20
>         break;
> @@ -668,6 +671,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
>         ret =3D apic_msr_write(cpu->apic_state, index, data);
>         if (ret < 0) {
>             x86_emul_raise_exception(env, EXCP0D_GPF, 0);
> +            return 1;
>         }
>=20
>         break;
> @@ -746,6 +750,7 @@ void hvf_simulate_wrmsr(CPUState *cs)
>          g_hypervisor_iface->wrmsr_handler(cs, msr, data);
>=20
>     printf("write msr %llx\n", RCX(cs));*/
> +    return 0;
> }
>=20
> static int hvf_handle_vmexit(CPUState *cpu)
> --=20
> 2.50.1 (Apple Git-155)
>=20


