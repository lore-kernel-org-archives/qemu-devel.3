Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298BBC3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 12:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXJlN-0003Kk-8T; Fri, 26 Jul 2024 08:09:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXJlK-0003Ie-Lk
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:09:30 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXJlH-000895-Fk
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 08:09:30 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVmj50D06z6K9Sj;
 Fri, 26 Jul 2024 20:07:37 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id EC776140CB1;
 Fri, 26 Jul 2024 20:09:20 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 13:09:20 +0100
Date: Fri, 26 Jul 2024 13:09:19 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 6/9] Add CPUID enumeration for RDT
Message-ID: <20240726130919.00007580@Huawei.com>
In-Reply-To: <20240719162929.1197154-7-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-7-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
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

On Fri, 19 Jul 2024 16:29:26 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Add CPUID enumeration for intel RDT monitoring and allocation, as well
> as the flags used in the enumeration code.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
> ---
>  hw/i386/rdt.c         | 29 ++++++++++++++
>  include/hw/i386/rdt.h | 29 ++++++++++++++
>  target/i386/cpu.c     | 91 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/cpu.h     |  5 +++
>  4 files changed, 154 insertions(+)
>=20
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> index 0d0e5751fc..5ad05f996a 100644
> --- a/hw/i386/rdt.c
> +++ b/hw/i386/rdt.c
> @@ -17,8 +17,18 @@
>  #define MAX_L2_MASK_COUNT      48
>  #define MAX_MBA_THRTL_COUNT    31
> =20
> +/* RDT L3 Allocation features */
> +#define CPUID_10_1_EAX_CBM_LENGTH       0xf
> +#define CPUID_10_1_EBX_CBM              0x0
> +#define CPUID_10_1_ECX_CDP              0x0 // to enable, it would be (1=
U << 2)
>  #define CPUID_10_1_EDX_COS_MAX          MAX_L3_MASK_COUNT
> +/* RDT L2 Allocation features*/
> +#define CPUID_10_2_EAX_CBM_LENGTH       0xf
> +#define CPUID_10_2_EBX_CBM              0x0
>  #define CPUID_10_2_EDX_COS_MAX          MAX_L2_MASK_COUNT
> +/* RDT MBA features */
> +#define CPUID_10_3_EAX_THRTL_MAX        89
> +#define CPUID_10_3_ECX_LINEAR_RESPONSE (1U << 2)
>  #define CPUID_10_3_EDX_COS_MAX          MAX_MBA_THRTL_COUNT
> =20
>  #define TYPE_RDT "rdt"
> @@ -61,8 +71,27 @@ struct RDTState {
> =20
>  struct RDTStateClass { };
> =20
> +uint32_t rdt_get_cpuid_15_0_edx_l3(void) { return CPUID_15_1_EDX_L3_OCCU=
PANCY | CPUID_15_1_EDX_L3_TOTAL_BW | CPUID_15_1_EDX_L3_LOCAL_BW; }
> +
> +uint32_t rdt_cpuid_15_1_edx_l3_total_bw_enabled(void) { return CPUID_15_=
1_EDX_L3_TOTAL_BW; }
> +uint32_t rdt_cpuid_15_1_edx_l3_local_bw_enabled(void) { return CPUID_15_=
1_EDX_L3_LOCAL_BW; }
> +uint32_t rdt_cpuid_15_1_edx_l3_occupancy_enabled(void) { return CPUID_15=
_1_EDX_L3_OCCUPANCY; }
> +
> +uint32_t rdt_cpuid_10_0_ebx_l3_cat_enabled(void) { return CPUID_10_0_EBX=
_L3_CAT; }
> +uint32_t rdt_cpuid_10_0_ebx_l2_cat_enabled(void) { return CPUID_10_0_EBX=
_L2_CAT; }
> +uint32_t rdt_cpuid_10_0_ebx_l2_mba_enabled(void) { return CPUID_10_0_EBX=
_MBA; }
> +
> +uint32_t rdt_get_cpuid_10_1_eax_cbm_length(void) { return CPUID_10_1_EAX=
_CBM_LENGTH; }
> +uint32_t rdt_cpuid_10_1_ebx_cbm_enabled(void) { return CPUID_10_1_EBX_CB=
M; }
> +uint32_t rdt_cpuid_10_1_ecx_cdp_enabled(void) { return CPUID_10_1_ECX_CD=
P; }
>  uint32_t rdt_get_cpuid_10_1_edx_cos_max(void) { return CPUID_10_1_EDX_CO=
S_MAX; }
> +
> +uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void) { return CPUID_10_2_EAX=
_CBM_LENGTH; }
> +uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void) { return CPUID_10_2_EBX_CB=
M; }
>  uint32_t rdt_get_cpuid_10_2_edx_cos_max(void) { return CPUID_10_2_EDX_CO=
S_MAX; }
> +
> +uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void) { return CPUID_10_3_EAX_=
THRTL_MAX; }
> +uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void) { return CPUID=
_10_3_ECX_LINEAR_RESPONSE; }
>  uint32_t rdt_get_cpuid_10_3_edx_cos_max(void) { return CPUID_10_3_EDX_CO=
S_MAX; }
> =20
>  bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
> diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
> index 51d36822f0..74aba33995 100644
> --- a/include/hw/i386/rdt.h
> +++ b/include/hw/i386/rdt.h
> @@ -4,15 +4,44 @@
>  #include <stdbool.h>
>  #include <stdint.h>
> =20
> +/* RDT L3 Cache Monitoring Technology */
> +#define CPUID_15_0_EDX_L3               (1U << 1)
> +#define CPUID_15_1_EDX_L3_OCCUPANCY     (1U << 0)
> +#define CPUID_15_1_EDX_L3_TOTAL_BW      (1U << 1)
> +#define CPUID_15_1_EDX_L3_LOCAL_BW      (1U << 2)
> +
> +/* RDT Cache Allocation Technology */
> +#define CPUID_10_0_EBX_L3_CAT           (1U << 1)
> +#define CPUID_10_0_EBX_L2_CAT           (1U << 2)
> +#define CPUID_10_0_EBX_MBA              (1U << 3)
> +#define CPUID_10_0_EDX CPUID_10_0_EBX_L3_CAT | CPUID_10_0_EBX_L2_CAT | C=
PUID_10_0_EBX_MBA
> +
>  typedef struct RDTState RDTState;
>  typedef struct RDTStateInstance RDTStateInstance;
>  typedef struct RDTMonitor RDTMonitor;
>  typedef struct RDTAllocation RDTAllocation;
> =20
> +uint32_t rdt_get_cpuid_15_0_edx_l3(void);
> +
> +uint32_t rdt_cpuid_15_1_edx_l3_total_bw_enabled(void);
> +uint32_t rdt_cpuid_15_1_edx_l3_local_bw_enabled(void);
> +uint32_t rdt_cpuid_15_1_edx_l3_occupancy_enabled(void);
> +
> +uint32_t rdt_cpuid_10_0_ebx_l3_cat_enabled(void);
> +uint32_t rdt_cpuid_10_0_ebx_l2_cat_enabled(void);
> +uint32_t rdt_cpuid_10_0_ebx_l2_mba_enabled(void);
> +
> +uint32_t rdt_get_cpuid_10_1_eax_cbm_length(void);
> +uint32_t rdt_cpuid_10_1_ebx_cbm_enabled(void);
> +uint32_t rdt_cpuid_10_1_ecx_cdp_enabled(void);
>  uint32_t rdt_get_cpuid_10_1_edx_cos_max(void);
> =20
> +uint32_t rdt_get_cpuid_10_2_eax_cbm_length(void);
> +uint32_t rdt_cpuid_10_2_ebx_cbm_enabled(void);
>  uint32_t rdt_get_cpuid_10_2_edx_cos_max(void);
> =20
> +uint32_t rdt_get_cpuid_10_3_eax_thrtl_max(void);
> +uint32_t rdt_cpuid_10_3_eax_linear_response_enabled(void);
>  uint32_t rdt_get_cpuid_10_3_edx_cos_max(void);
> =20
>  bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 4688d140c2..c61981bf82 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -42,6 +42,7 @@
>  #include "hw/boards.h"
>  #include "hw/i386/sgx-epc.h"
>  #endif
> +#include "hw/i386/rdt.h"
> =20
>  #include "disas/capstone.h"
>  #include "cpu-internal.h"
> @@ -6629,6 +6630,96 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t inde=
x, uint32_t count,
>          assert(!(*eax & ~0x1f));
>          *ebx &=3D 0xffff; /* The count doesn't need to be reliable. */
>          break;
> +#ifndef CONFIG_USER_ONLY
> +    case 0xF:
> +        /* Shared Resource Monitoring Enumeration Leaf */
> +        *eax =3D 0;
> +        *ebx =3D 0;
> +        *ecx =3D 0;
> +        *edx =3D 0;
> +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQM))
> +            break;
> +        assert(cpu->rdt);
> +        /* Non-zero count is ResId */
> +        switch (count) {
> +            /* Monitoring Resource Type Enumeration */
> +            case 0:
> +                *edx =3D env->features[FEAT_RDT_15_0_EDX];
> +                *ebx =3D rdt_max_rmid(cpu->rdt);
> +                break;
> +            /* L3 Cache Monitoring Capability Enumeration Data */
> +            case 1:
> +                /* Upscaling Factor */
> +                *ebx =3D 1;
> +                /* MaxRMID */
> +                *ecx =3D rdt_max_rmid(cpu->rdt);
> +                /* Set L3 Total BW */
comments fairly obvious from naming of functions so I'd be tempted
to drop them all and have
		   *ecx =3D rdt_max_rmid(cpu->rdt);
                   *edx =3D rdt_cpuid_15_1_edx_l3_total_bw_enabled() |
                          rdt_cpuid_15_1_edx_l3_local_bw_enabled() |
                          rdt_cpuid_15_1_edx_l3_occupancy_enabled();

Same for the rest of the cases
> +                *edx |=3D rdt_cpuid_15_1_edx_l3_total_bw_enabled();
> +                /* Set L3 Local BW */
> +                *edx |=3D rdt_cpuid_15_1_edx_l3_local_bw_enabled();
> +                /* Set L3 Occupancy */
> +                *edx |=3D rdt_cpuid_15_1_edx_l3_occupancy_enabled();
> +                break;
> +            default:
> +                break;
> +        }
> +        break;
> +    case 0x10:
> +        /* Shared Resource Director Technology Allocation Enumeration Le=
af */
> +        *eax =3D 0;
> +        *ebx =3D 0;
> +        *ecx =3D 0;
> +        *edx =3D 0;
> +        if (!(env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_PQE))
> +            break;
> +        assert(cpu->rdt);
> +        /* Non-zero count is ResId */
> +        switch (count) {
> +            /* Cache Allocation Technology Available Resource Types */
> +            case 0:
> +                /* Set L3 CAT */
> +                *ebx |=3D rdt_cpuid_10_0_ebx_l3_cat_enabled();
> +                /* Set L2 CAT */
> +                *ebx |=3D rdt_cpuid_10_0_ebx_l2_cat_enabled();
> +                /* Set MBA */
> +                *ebx |=3D rdt_cpuid_10_0_ebx_l2_mba_enabled();
> +                // *edx =3D env->features[FEAT_RDT_10_0_EBX];

Make sure to clean up any commented out code for v2.

> +                break;
> +            case 1:
> +                /* Length of capacity bitmask in -1 notation */
> +                *eax =3D rdt_get_cpuid_10_1_eax_cbm_length();
> +                /* Capability bit mask */
> +                *ebx =3D rdt_cpuid_10_1_ebx_cbm_enabled();
> +                /* Code and Data priotitization */
> +                *ecx |=3D rdt_cpuid_10_1_ecx_cdp_enabled();
> +                /* Support for n COS masks (zero-referenced)*/
> +                *edx =3D  rdt_get_cpuid_10_1_edx_cos_max();
> +                break;
> +            case 2:
> +                /* Length of capacity bitmask in -1 notation */
> +                *eax =3D rdt_get_cpuid_10_2_eax_cbm_length();
> +                /* Capability bit mask */
> +                *ebx =3D rdt_cpuid_10_2_ebx_cbm_enabled();
> +                /* Support for n COS masks (zero-referenced)*/
> +                *edx =3D  rdt_get_cpuid_10_2_edx_cos_max();
> +                break;
> +            case 3:
> +                /* Max throttling value -1 (89 means 90) */
> +                *eax =3D rdt_get_cpuid_10_3_eax_thrtl_max();
> +                /* Linear response of delay values */
> +                *ecx =3D rdt_cpuid_10_3_eax_linear_response_enabled();
> +                /* Max number of CLOS -1 (15 means 16) */
> +                *edx =3D rdt_get_cpuid_10_3_edx_cos_max();
> +                break;
> +            default:
> +                *eax =3D 0;
> +                *ebx =3D 0;
> +                *ecx =3D 0;
> +                *edx =3D 0;
already done above.
> +                break;
> +        }
> +        break;
> +#endif
>      case 0x1C:
>          if (cpu->enable_pmu && (env->features[FEAT_7_0_EDX] & CPUID_7_0_=
EDX_ARCH_LBR)) {
>              x86_cpu_get_supported_cpuid(0x1C, 0, eax, ebx, ecx, edx);



