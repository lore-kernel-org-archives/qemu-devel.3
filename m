Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0913AFF886D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 18:05:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHmnn-0003Nr-K5; Tue, 28 Apr 2026 14:04:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmnU-0003Md-BI
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:04:38 -0400
Received: from p-west3-cluster5-host11-snip4-10.eps.apple.com ([57.103.72.113]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wHmnQ-00077j-8k
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 14:04:35 -0400
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPS id
 3555118000E8; Tue, 28 Apr 2026 18:04:27 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwROEwVSB11NVg1HD1geXBQXFUBDXgheH0wcHQ5YBhIATQoONgZZBV4JVgNDBTYSFF1FRgNHGVcUUBtHDFUHV15fChMAXg8PTAlAAytzLQVAFEEFLnZGBjYIPR5UAi0FXXs6cFoHKgNEez0KXHceXABLHVcEVB9TElUdHQtFVRIEQAhWUFQeQQRWFWwJWAZTGVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1777399470; x=1779991470;
 bh=q+AkgagEpEvE6yK+m9+tMpe+n2FML2MuyQJLGwNRiS4=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=P+r9WkcevOvyim0VzUAmLN5JGeG3XiuPpY2Wo7vkmgpVr24oRl/1gRJ5ue/4qvfxtLqDstXyztoi/GvE4zM7lX78JchC1cmNVitZLj60XAnw/Vy556l53EPAowMel3m8YOQKcyWUvEZDQaDn5AiqmoiqC0/UtbmJbgHZbh86VXuipOffJLK6NpYxzCeyqogtFwceHrdslxQKdEyzH5T6idz6aEXS9M9skqGaSvflHuO5m1SQrtVkqvZIN5wHCDGOFCJRxIHuWdVDgu1MCr98TWC7xDWzyD1Gx7PWMYCxcjXfxMYm+ZbN4r3QUYEE4VR5XOvFf9NqQtix7nU2CVDxXA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-6 (Postfix) with ESMTPSA id
 12F3B1800C3F; Tue, 28 Apr 2026 18:04:25 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH 5/6] target/i386/mshv: use the register page to get
 registers
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20260428135053.251200-6-dblanzeanu@linux.microsoft.com>
Date: Tue, 28 Apr 2026 20:04:13 +0200
Cc: qemu-devel@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <080FDF70-96CA-4F1E-95F7-BBC70A14BE91@unpredictable.fr>
References: <20260428135053.251200-1-dblanzeanu@linux.microsoft.com>
 <20260428135053.251200-6-dblanzeanu@linux.microsoft.com>
To: =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Authority-Info-Out: v=2.4 cv=LvifC3dc c=1 sm=1 tr=0 ts=69f0f6ad
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yMhMjlubAAAA:8
 a=gy0if3euEij6_eOLcIMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: FT3LtnMlotzliQ8v-aUmQWtV3VwHeTnH
X-Proofpoint-ORIG-GUID: FT3LtnMlotzliQ8v-aUmQWtV3VwHeTnH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE3NSBTYWx0ZWRfX3+h4YchNlxsi
 VjMzd7RI6DOl8YAOJRwkZtm33y+nap5RozXgIMUvWnu7TpKdN8ceIAHdKI3jgXXlUkH9B8bzbd4
 6QO9UXHWGfPJ3Q6Rzs1uJyvHpXF7qiEyvOCRt4lseC9zc4sqfHkFfA1bl/oYOX8UZqq01pYcMSz
 XIl83yz8juxHHvtGJtJOvVomDmcTf2eAd9OfeGDEyWlZiBpXIs9Jh4XUVATLY65SGWwxyE7xrA7
 ycRS/InQCdV20K3vBbX0yhToqMRDWj2cGbPHLKOFIZguuH6CADyWPx3a9cCf3Vcco8m3HuUGbwm
 27+RNuwjohUN9JXTRcYUkBDRFLgTth+uGKX2P9Jwl2NwE+RBMpTupTowsTVWYk=
Received-SPF: pass client-ip=57.103.72.113;
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



> On 28. Apr 2026, at 15:50, Doru Bl=C3=A2nzeanu =
<dblanzeanu@linux.microsoft.com> wrote:
>=20
> Change the mshv_load_regs to use the register page when it is mmapped
> and is valid.
> Otherwise use the existing logic that uses ioctls to fetch registers.
>=20
> When retrieving the special registers, there are some registers that =
are
> not present in the register page: TR, LDTR, GDTR, IDTR, CR2, =
APIC_BASE.
> For this ones we still need to use ioctls to correctly fetch.
>=20
> Signed-off-by: Doru Bl=C3=A2nzeanu <dblanzeanu@linux.microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>

But with comments below...

> ---
> target/i386/mshv/mshv-cpu.c | 137 +++++++++++++++++++++++++++++++++---
> 1 file changed, 128 insertions(+), 9 deletions(-)
>=20
> diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
> index 42b6fb1912..7949493e97 100644
> --- a/target/i386/mshv/mshv-cpu.c
> +++ b/target/i386/mshv/mshv-cpu.c
> @@ -107,6 +107,15 @@ static enum hv_register_name =
FPU_REGISTER_NAMES[26] =3D {
>     HV_X64_REGISTER_XMM_CONTROL_STATUS,
> };
>=20
> +static enum hv_register_name NON_VP_PAGE_REGISTER_NAMES[6] =3D {
> +    HV_X64_REGISTER_TR,
> +    HV_X64_REGISTER_LDTR,
> +    HV_X64_REGISTER_GDTR,

Those two _not_ being in a shared register page does cause quite a bit =
of
pain for perf if not dealt with carefully which leads to=E2=80=A6

> +    HV_X64_REGISTER_IDTR,
> +    HV_X64_REGISTER_CR2,
> +    HV_X64_REGISTER_APIC_BASE,
> +};
> +
> static int translate_gva(const CPUState *cpu, uint64_t gva, uint64_t =
*gpa,
>                          uint64_t flags)
> {
> @@ -401,6 +410,105 @@ static void populate_special_regs(const =
hv_register_assoc *assocs,
>     cpu_set_apic_base(x86cpu->apic_state, assocs[16].value.reg64);
> }
>=20
> +static void mshv_get_standard_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86cpu->env;
> +
> +    /* General Purpose Registers  */
> +    env->regs[R_EAX] =3D env->regs_page->rax;
> +    env->regs[R_EBX] =3D env->regs_page->rbx;
> +    env->regs[R_ECX] =3D env->regs_page->rcx;
> +    env->regs[R_EDX] =3D env->regs_page->rdx;
> +    env->regs[R_ESI] =3D env->regs_page->rsi;
> +    env->regs[R_EDI] =3D env->regs_page->rdi;
> +    env->regs[R_ESP] =3D env->regs_page->rsp;
> +    env->regs[R_EBP] =3D env->regs_page->rbp;
> +    env->regs[R_R8]  =3D env->regs_page->r8;
> +    env->regs[R_R9]  =3D env->regs_page->r9;
> +    env->regs[R_R10] =3D env->regs_page->r10;
> +    env->regs[R_R11] =3D env->regs_page->r11;
> +    env->regs[R_R12] =3D env->regs_page->r12;
> +    env->regs[R_R13] =3D env->regs_page->r13;
> +    env->regs[R_R14] =3D env->regs_page->r14;
> +    env->regs[R_R15] =3D env->regs_page->r15;
> +
> +    env->eip =3D env->regs_page->rip;
> +    env->eflags =3D env->regs_page->rflags;
> +    rflags_to_lflags(env);
> +}
> +
> +static int mshv_get_special_regs_vp_page(CPUState *cpu)
> +{
> +    X86CPU *x86cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86cpu->env;
> +    struct hv_register_assoc =
assocs[ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES)];
> +    int ret;
> +    size_t n_regs =3D ARRAY_SIZE(NON_VP_PAGE_REGISTER_NAMES);
> +    hv_x64_segment_register seg;
> +
> +    /* Populate special registers that are in the VP register page */
> +    env->cr[0] =3D env->regs_page->cr0;
> +    env->cr[3] =3D env->regs_page->cr3;
> +    env->cr[4] =3D env->regs_page->cr4;
> +    env->efer =3D env->regs_page->efer;
> +    cpu_set_apic_tpr(x86cpu->apic_state, env->regs_page->cr8);
> +
> +    /* Segment Registers - copy from packed struct to avoid unaligned =
access */
> +    memcpy(&seg, &env->regs_page->es, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_ES]);
> +    memcpy(&seg, &env->regs_page->cs, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_CS]);
> +    memcpy(&seg, &env->regs_page->ss, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_SS]);
> +    memcpy(&seg, &env->regs_page->ds, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_DS]);
> +    memcpy(&seg, &env->regs_page->fs, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_FS]);
> +    memcpy(&seg, &env->regs_page->gs, =
sizeof(hv_x64_segment_register));
> +    populate_segment_reg(&seg, &env->segs[R_GS]);

It=E2=80=99s probably best to split this function.

A =E2=80=9Cregular=E2=80=9D MMIO access is going to need segment info, =
but not GDTR/LDTR.

Otherwise you=E2=80=99d effectively defeat the point of the shared =
register page. Ideally
0 register fetch/writes outside of the shared register page would happen =
on an MMIO
access.

> +
> +    /* The rest of the special registers that are not in the VP =
register page */
> +    for (size_t i =3D 0; i < n_regs; i++) {
> +        assocs[i].name =3D NON_VP_PAGE_REGISTER_NAMES[i];
> +    }
> +
> +    ret =3D get_generic_regs(cpu, assocs, n_regs);
> +    if (ret < 0) {
> +        error_report("failed to get non-vp-page special registers");
> +        return -1;
> +    }
> +
> +    /* Non-VP page registers - TR, LDTR, GDTR, IDTR, CR2, APIC_BASE =
*/
> +    populate_segment_reg(&assocs[0].value.segment, &env->tr);
> +    populate_segment_reg(&assocs[1].value.segment, &env->ldt);
> +
> +    populate_table_reg(&assocs[2].value.table, &env->gdt);
> +    populate_table_reg(&assocs[3].value.table, &env->idt);
> +    env->cr[2] =3D assocs[4].value.reg64;

For CRs, there=E2=80=99s a read_cr x86 emulation callback now, although =
it never
needs to read CR2.

> +
> +    cpu_set_apic_base(x86cpu->apic_state, assocs[5].value.reg64);

For APIC base, what I ended up doing on WHPX (upcoming 11.1 series) is=20=

to just trap APIC base writes so that there=E2=80=99s never a need to =
read it.

> +
> +    return ret;
> +}
> +
> +static int mshv_get_registers_vp_page(CPUState *cpu)
> +{
> +    int ret;
> +
> +    /* General Purpose Registers  */
> +    mshv_get_standard_regs_vp_page(cpu);
> +
> +    /* Special Registers - makes a hypercall */
> +    ret =3D mshv_get_special_regs_vp_page(cpu);
> +    if (ret < 0) {
> +        error_report("failed to get special registers for vp page");
> +        return -1;
> +    }
> +
> +    return 0;
> +}
> +
>=20
> int mshv_get_special_regs(CPUState *cpu)
> {
> @@ -424,18 +532,29 @@ int mshv_get_special_regs(CPUState *cpu)
>=20
> int mshv_load_regs(CPUState *cpu)
> {
> +    X86CPU *x86_cpu =3D X86_CPU(cpu);
> +    CPUX86State *env =3D &x86_cpu->env;
>     int ret;
>=20
> -    ret =3D mshv_get_standard_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load standard registers");
> -        return -1;
> -    }
> +    /* Use register vp page to optimize registers access */
> +    if (env->regs_page && env->regs_page->isvalid !=3D 0) {
> +        ret =3D mshv_get_registers_vp_page(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load registers from vp page");
> +            return -1;
> +        }
> +    } else {
> +        ret =3D mshv_get_standard_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load standard registers");
> +            return -1;
> +        }
>=20
> -    ret =3D mshv_get_special_regs(cpu);
> -    if (ret < 0) {
> -        error_report("Failed to load special registers");
> -        return -1;
> +        ret =3D mshv_get_special_regs(cpu);
> +        if (ret < 0) {
> +            error_report("Failed to load special registers");
> +            return -1;
> +        }
>     }
>=20
>     return 0;
> --=20
> 2.53.0
>=20
>=20


