Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1069AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:57:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXIdU-0007uB-KS; Fri, 26 Jul 2024 06:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIdR-0007k6-M7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:57:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIdP-0000wo-IX
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:57:17 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVl5C5xB7z6K5v4;
 Fri, 26 Jul 2024 18:54:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id DB9A2140B63;
 Fri, 26 Jul 2024 18:57:11 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 11:57:11 +0100
Date: Fri, 26 Jul 2024 11:57:10 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 5/9] Add RDT device interface through MSRs
Message-ID: <20240726115710.00005c9c@Huawei.com>
In-Reply-To: <20240719162929.1197154-6-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-6-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 19 Jul 2024 16:29:25 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Implement rdmsr and wrmsr for the following MSRs:
> * MSR_IA32_PQR_ASSOC
> * MSR_IA32_QM_EVTSEL
> * MSR_IA32_QM_CTR
> * IA32_L3_QOS_Mask_n
> * IA32_L2_QOS_Mask_n
> * IA32_L2_QoS_Ext_BW_Thrtl_n
>=20
> This allows for the guest to call RDT-internal functions to
> associate an RMID with a CLOSID / set an active RMID for
> monitoring, read monitoring data, and set classes of service.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
A few comments inline. Mostly code cleanup stuff.

> ---
>  hw/i386/rdt.c                        |  8 +++
>  include/hw/i386/rdt.h                |  8 ++-
>  target/i386/cpu.h                    | 14 +++++
>  target/i386/tcg/sysemu/misc_helper.c | 80 ++++++++++++++++++++++++++++
>  4 files changed, 109 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> index 77b7b4f2d4..0d0e5751fc 100644
> --- a/hw/i386/rdt.c
> +++ b/hw/i386/rdt.c
> @@ -17,6 +17,10 @@
>  #define MAX_L2_MASK_COUNT      48
>  #define MAX_MBA_THRTL_COUNT    31
> =20
> +#define CPUID_10_1_EDX_COS_MAX          MAX_L3_MASK_COUNT
> +#define CPUID_10_2_EDX_COS_MAX          MAX_L2_MASK_COUNT
> +#define CPUID_10_3_EDX_COS_MAX          MAX_MBA_THRTL_COUNT

Worth these defines?  Seems easier to just use the MAX_L3...
etc

> +
>  #define TYPE_RDT "rdt"
>  #define RDT_NUM_RMID_PROP "rmids"
> =20
> @@ -57,6 +61,10 @@ struct RDTState {
> =20
>  struct RDTStateClass { };
> =20
> +uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return CPUID_10_1_EDX_CO=
S_MAX; }
> +uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return CPUID_10_2_EDX_CO=
S_MAX; }
> +uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return CPUID_10_3_EDX_CO=
S_MAX; }
> +
>  bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
>      X86CPU *cpu =3D X86_CPU(current_cpu);
>      RDTStateInstance *rdt =3D cpu->rdt;
> diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
> index 8092c5f290..51d36822f0 100644
> --- a/include/hw/i386/rdt.h
> +++ b/include/hw/i386/rdt.h
> @@ -9,7 +9,12 @@ typedef struct RDTStateInstance RDTStateInstance;
>  typedef struct RDTMonitor RDTMonitor;
>  typedef struct RDTAllocation RDTAllocation;
> =20
> -#endif
> +uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
> +
> +uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
> +
> +uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);

No need for blank lines between these related function
definitions.

> +
>  bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
> =20
>  void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
> @@ -23,3 +28,4 @@ uint32_t rdt_read_mba_thrtl(uint32_t pos);
>  uint64_t rdt_read_event_count(RDTStateInstance *rdt, uint32_t rmid, uint=
32_t event_id);
>  uint32_t rdt_max_rmid(RDTStateInstance *rdt);
> =20
> +#endif

Fix that in earlier patch not here.

> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index bd0bbb75f2..0b3aca2d02 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -574,6 +574,17 @@ typedef enum X86Seg {
>  #define MSR_IA32_VMX_TRUE_ENTRY_CTLS     0x00000490
>  #define MSR_IA32_VMX_VMFUNC             0x00000491
> =20
> +#define MSR_IA32_QM_EVTSEL                  0x0c8d
> +#define MSR_IA32_QM_CTR                     0x0c8e
> +#define MSR_IA32_PQR_ASSOC                  0x0c8f
> +
> +#define MSR_IA32_L3_CBM_BASE                0x0c90
> +#define MSR_IA32_L3_MASKS_END               0x0d0f
> +#define MSR_IA32_L2_CBM_BASE                0x0d10
> +#define MSR_IA32_L2_CBM_END                 0x0d4f
> +#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE   0xd50
> +#define MSR_IA32_L2_QOS_Ext_BW_Thrtl_END    0xd80
> +
>  #define MSR_APIC_START                  0x00000800
>  #define MSR_APIC_END                    0x000008ff
> =20
> @@ -1778,6 +1789,9 @@ typedef struct CPUArchState {
>      uint64_t msr_ia32_feature_control;
>      uint64_t msr_ia32_sgxlepubkeyhash[4];
> =20
> +    uint64_t msr_ia32_qm_evtsel;
> +    uint64_t msr_ia32_pqr_assoc;
> +
>      uint64_t msr_fixed_ctr_ctrl;
>      uint64_t msr_global_ctrl;
>      uint64_t msr_global_status;
> diff --git a/target/i386/tcg/sysemu/misc_helper.c b/target/i386/tcg/sysem=
u/misc_helper.c
> index 094aa56a20..e48e6b0da1 100644
> --- a/target/i386/tcg/sysemu/misc_helper.c
> +++ b/target/i386/tcg/sysemu/misc_helper.c
> @@ -25,6 +25,7 @@
>  #include "exec/address-spaces.h"
>  #include "exec/exec-all.h"
>  #include "tcg/helper-tcg.h"
> +#include "hw/i386/rdt.h"
>  #include "hw/i386/apic.h"
> =20
>  void helper_outb(CPUX86State *env, uint32_t port, uint32_t data)
> @@ -293,6 +294,44 @@ void helper_wrmsr(CPUX86State *env)
>          env->msr_bndcfgs =3D val;
>          cpu_sync_bndcs_hflags(env);
>          break;
> +    case MSR_IA32_QM_EVTSEL:
> +        env->msr_ia32_qm_evtsel =3D val;
> +        break;
> +    case MSR_IA32_PQR_ASSOC:
> +    {
> +        env->msr_ia32_pqr_assoc =3D val;
> +        bool res =3D rdt_associate_rmid_cos(val);
QEMU tends to use traditional C style, so declare
variables at start of scope then blank line.
However...

> +        if (!res)
> +            goto error;
           if (rdt_associate_rmid_cos(val)) {
               goto error;
           }
> +        break;
> +    }
Drop this scoping as bool will have gone away.

> +    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BA=
SE;
blank line

> +        if (pos >=3D rdt_get_cpuid_10_1_edx_cos_max()) {
> +            goto error;
> +        }
> +        rdt_write_msr_l3_mask(pos, val);
> +        break;
> +    }
> +    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BA=
SE;
blank line.
> +        if (pos >=3D rdt_get_cpuid_10_2_edx_cos_max()) {
> +            goto error;
> +        }
> +        rdt_write_msr_l2_mask(pos, val);
> +        break;
> +    }
> +    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Th=
rtl_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ex=
t_BW_Thrtl_BASE;

blank line

> +        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
> +            goto error;
> +        }
> +        rdt_write_mba_thrtl(pos, val);
> +        break;
> +    }
>      case MSR_APIC_START ... MSR_APIC_END: {
>          int ret;
>          int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> @@ -472,6 +511,44 @@ void helper_rdmsr(CPUX86State *env)
>          val =3D (cs->nr_threads * cs->nr_cores) | (cs->nr_cores << 16);
>          break;
>      }
> +    case MSR_IA32_QM_CTR:
> +        val =3D rdt_read_event_count(x86_cpu->rdt,
> +                                   (env->msr_ia32_qm_evtsel >> 32) & 0xf=
f,
> +                                   env->msr_ia32_qm_evtsel & 0xff);
> +        break;
> +    case MSR_IA32_QM_EVTSEL:
> +        val =3D env->msr_ia32_qm_evtsel;
> +        break;
> +    case MSR_IA32_PQR_ASSOC:
> +        val =3D env->msr_ia32_pqr_assoc;
> +        break;
> +    case MSR_IA32_L3_CBM_BASE ... MSR_IA32_L3_MASKS_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L3_CBM_BA=
SE;

blank line.

> +        if (pos >=3D rdt_get_cpuid_10_1_edx_cos_max()) {
> +            goto error;
> +        }
> +        val =3D rdt_read_l3_mask(pos);
> +        break;
> +    }
> +    case MSR_IA32_L2_CBM_BASE ... MSR_IA32_L2_CBM_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_CBM_BA=
SE;

blank line.

> +        if (pos >=3D rdt_get_cpuid_10_2_edx_cos_max()) {
> +            goto error;
> +        }
> +        val =3D rdt_read_l2_mask(pos);
> +        break;
> +    }
> +    case MSR_IA32_L2_QOS_Ext_BW_Thrtl_BASE ... MSR_IA32_L2_QOS_Ext_BW_Th=
rtl_END:
> +    {
> +        uint32_t pos =3D (uint32_t)env->regs[R_ECX] - MSR_IA32_L2_QOS_Ex=
t_BW_Thrtl_BASE;

blank line.

> +        if (pos >=3D rdt_get_cpuid_10_3_edx_cos_max()) {
> +            goto error;
> +        }
> +        val =3D rdt_read_mba_thrtl(pos);
> +        break;
> +    }
>      case MSR_APIC_START ... MSR_APIC_END: {
>          int ret;
>          int index =3D (uint32_t)env->regs[R_ECX] - MSR_APIC_START;
> @@ -499,6 +576,9 @@ void helper_rdmsr(CPUX86State *env)
>      }
>      env->regs[R_EAX] =3D (uint32_t)(val);
>      env->regs[R_EDX] =3D (uint32_t)(val >> 32);
> +return;
    return;
fix the indent

blank line after the return.

> +error:
> +    raise_exception_err_ra(env, EXCP0D_GPF, 0, GETPC());
If this is only thing to do in error path it might be easier
to just do that inline instead of goto.

>  }
> =20
>  void helper_flush_page(CPUX86State *env, target_ulong addr)


