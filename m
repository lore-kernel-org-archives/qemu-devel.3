Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA3AFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:06:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmom-0003lC-RV; Tue, 28 Apr 2026 14:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmob-0003fh-6Y
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:05:47 -0400
Received: from p-west3-cluster3-host5-snip4-3.eps.apple.com ([57.103.72.134]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmoX-0007ig-Fx
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:05:43 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPS id
 E63F518003B5; Tue, 28 Apr 2026 18:05:36 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAxNcSkOXgM1FEkKKANGBkR7QB5VDipxXQA8AltyLXdAfE8FVXceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777399538; x=1779991538;
 bh=y4RfdPIpWhCXiG3sbJK91ucXV5+qMlZfUWRk6IdgwwA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=XbUG05CEI5I1xjyVcAAAo2ifq+QwVR0djXUD80NFeoJQG2X8GVwSdAGqeAuEj39ypZcWKYMnKQrtjXt/piSY0IpCdeWWKHyZyvz16mxc+/UsP8B75pHJzzK+AMvaaxvl3fDOeZ37iGh9KN3MBLsZ9Zs9ZHQ2ZfmLQjWGYvEx4nhtSMET5CWlimhearnfUEm+P95TtFUfUTb+JzXVl0YBjEK+KHV4vvdVWW2HY1Wrb1+U5dXC4POYr4neS2ODjjBYUzUKxtbLpZSxNRTN5OwBrTGiJga4UP1uwdYGJKnUnTfubkUv6GvLd1sPAV+kdE1p/ZWPKM7T5ko9U/caxjfQ9A==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-11 (Postfix) with ESMTPSA id
 C12381800A53; Tue, 28 Apr 2026 18:05:34 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 6/6] target/i386/mshv: use the register page to set
 registers
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260428135053.251200-7-dblanzeanu@linux.microsoft.com>
Date: Tue, 28 Apr 2026 20:05:22 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <55BD951E-19E4-44B8-89AC-9D16EFE0E768@unpredictable.fr>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-7-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=YZywJgRf c=1 sm=1 tr=0 ts=69f0f6f1
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8
 a=ADczPIEOeSqyNKhzclwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NSBTYWx0ZWRfX+CxczoUwyuPJ
 BS3YHqQ+nzxhcqOnfFWq/SNV3PkhBl7IfbOcDaDkKl4yDirLV9pKz1+NL6kvfaoDjM19/Mv/tBb
 CSzxoXg+n4wdpul/CpIp9zMAo9EDwOpd9eYO3Lb7v3JJw4j4jkKTxNQ+GeB2gxDiJJvW/S06nlw
 +QRmYI9qXCP6u7VwaHyQ3US5sV3AhH2soFlZw315NoAomIXG6u0M2i8SNL3qkBcCmYUEEsQNxAD
 aHOM11JI2fv5001P3XEbO5beDpSNP72SVkvyDXx+L84b4XPRnsid3CYNcZl1hqpZ+Vy2KpbyCAs
 xe4WqqoRY3IRg3B3IZC6rxKthvbxiPxpoiaryE39ZVBktF/Cd+m04qR7S4W5u0=
X-Proofpoint-ORIG-GUID: DdzlshC7AvrNnCkGL5jjfSQsMdhm3tf4
X-Proofpoint-GUID: DdzlshC7AvrNnCkGL5jjfSQsMdhm3tf4
Received-SPF: pass client-ip=57.103.72.134;
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



> On 28. Apr 2026, at 15:50, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> Update mshv_store_regs to use the register page when it is mmapped and
> valid to set registers.
> Otherwise use the ioctls to set the registers.
>=20
> Signed-off-by: Doru Bl=C3=A2nzeanu <dblanzeanu@linux.microsoft.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

> ---
> target/i386/mshv/mshv-cpu.c | 45 +++++++++++++++++++++++++++++++++----
> 1 file changed, 41 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 7949493e97..6bb3e6d4a9 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -294,14 +294,51 @@ static int set_standard_regs(const CPUState =
*cpu)
>     return 0;
> }
>=20
> +static void mshv_set_standard_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86cpu->env;
> +
> +    env->regs_page->rax =3D env->regs[R_EAX];
> +    env->regs_page->rbx =3D env->regs[R_EBX];
> +    env->regs_page->rcx =3D env->regs[R_ECX];
> +    env->regs_page->rdx =3D env->regs[R_EDX];
> +    env->regs_page->rsi =3D env->regs[R_ESI];
> +    env->regs_page->rdi =3D env->regs[R_EDI];
> +    env->regs_page->rsp =3D env->regs[R_ESP];
> +    env->regs_page->rbp =3D env->regs[R_EBP];
> +    env->regs_page->r8  =3D env->regs[R_R8];
> +    env->regs_page->r9  =3D env->regs[R_R9];
> +    env->regs_page->r10 =3D env->regs[R_R10];
> +    env->regs_page->r11 =3D env->regs[R_R11];
> +    env->regs_page->r12 =3D env->regs[R_R12];
> +    env->regs_page->r13 =3D env->regs[R_R13];
> +    env->regs_page->r14 =3D env->regs[R_R14];
> +    env->regs_page->r15 =3D env->regs[R_R15];
> +    env->regs_page->rip =3D env->eip;
> +    lflags_to_rflags(env);
> +    env->regs_page->rflags =3D env->eflags;
> +
> +    env->regs_page->dirty |=3D (1u << HV_X64_REGISTER_CLASS_GENERAL)
> +                                | (1u << HV_X64_REGISTER_CLASS_IP)
> +                                | (1u << =
HV_X64_REGISTER_CLASS_FLAGS);
> +}
> +
> int mshv_store_regs(CPUState *cpu)
> {
> +    X86CPU *x86cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86cpu->env;
>     int ret;
>=20
> -    ret =3D set_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to store standard registers");
> -        return -1;
> +    /* Use register vp page to optimize registers access */
> +    if (env->regs_page && env->regs_page->isvalid !=3D 0) {
> +        mshv_set_standard_regs_vp_page(cpu);
> +    } else {
> +        ret =3D set_standard_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to store standard registers");
> +            return -1;
> +        }
>     }
>=20
>     return 0;
> --=20
> 2.53.0
>=20
>=20


