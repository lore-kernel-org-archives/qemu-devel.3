Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C3C3DA49
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXIYE-00070L-GL; Fri, 26 Jul 2024 06:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIYC-0006zo-Gp
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:51:52 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIY9-00085r-Av
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:51:52 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVkzN5GF8z6K5kn;
 Fri, 26 Jul 2024 18:49:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 75541140A46;
 Fri, 26 Jul 2024 18:51:36 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 11:51:36 +0100
Date: Fri, 26 Jul 2024 11:51:35 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 4/9] Add RDT functionality
Message-ID: <20240726115135.00003804@Huawei.com>
In-Reply-To: <20240719162929.1197154-5-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-5-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
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

On Fri, 19 Jul 2024 16:29:24 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Add RDT code to Associate CLOSID with RMID / set RMID for monitoring,
> write COS, and read monitoring data. This patch does not add code for
> the guest to interact through these things with MSRs, only the actual
> ability for the RDT device to do them.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
> ---
>  hw/i386/rdt.c         | 124 ++++++++++++++++++++++++++++++++++++++++++
>  include/hw/i386/rdt.h |  13 +++++
>  2 files changed, 137 insertions(+)
>=20
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> index 259dafc963..77b7b4f2d4 100644
> --- a/hw/i386/rdt.c
> +++ b/hw/i386/rdt.c
> @@ -7,6 +7,11 @@
>  #include "target/i386/cpu.h"
>  #include "hw/isa/isa.h"
> =20
> +/* RDT Monitoring Event Codes */
> +#define RDT_EVENT_L3_OCCUPANCY 1
> +#define RDT_EVENT_L3_REMOTE_BW 2
> +#define RDT_EVENT_L3_LOCAL_BW 3
> +
>  /* Max counts for allocation masks or CBMs. In other words, the size of =
respective MSRs*/
>  #define MAX_L3_MASK_COUNT      128
>  #define MAX_L2_MASK_COUNT      48
> @@ -15,6 +20,9 @@
>  #define TYPE_RDT "rdt"
>  #define RDT_NUM_RMID_PROP "rmids"
> =20
> +#define QM_CTR_Error        (1ULL << 63)
> +#define QM_CTR_Unavailable  (1ULL << 62)

Mix of capitals and camel case is a bit unusual. I'd go
capitals throughout unless there is precedence.

Also, prefix with RDT_QM probably so we know it's a local
define where it is used.

> +
>  OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
> =20
>  struct RDTMonitor {
> @@ -49,6 +57,122 @@ struct RDTState {
> =20
>  struct RDTStateClass { };
> =20
> +bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc) {
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +    RDTAllocation *alloc;
> +
> +    uint32_t cos_id =3D (msr_ia32_pqr_assoc & 0xffff0000) >> 16;
> +    uint32_t rmid =3D msr_ia32_pqr_assoc & 0xffff;
> +
> +    if (cos_id > MAX_L3_MASK_COUNT || cos_id > MAX_L2_MASK_COUNT ||
> +    cos_id > MAX_MBA_THRTL_COUNT || rmid > rdt_max_rmid(rdt)) {

Fix indent to be
       if (cos_id...
           cos_id > ...


> +        return false;
> +    }
> +
> +    rdt->active_rmid =3D rmid;
> +
> +    alloc =3D &g_array_index(rdt->rdtstate->allocations, RDTAllocation, =
rmid);
> +
> +    alloc->active_cos =3D cos_id;
> +
> +    return true;
> +}
> +
> +uint32_t rdt_read_l3_mask(uint32_t pos)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    uint32_t val =3D rdt->rdtstate->msr_L3_ia32_mask_n[pos];
> +    return val;

return rdt->

> +}
> +
> +uint32_t rdt_read_l2_mask(uint32_t pos)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    uint32_t val =3D rdt->rdtstate->msr_L2_ia32_mask_n[pos];
> +    return val;

return rdt->

> +}
> +
> +uint32_t rdt_read_mba_thrtl(uint32_t pos)
> +{
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    uint32_t val =3D rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos];
> +    return val;

return rdt->rdstate...

> +}
> +
> +void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val) {
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    rdt->rdtstate->msr_L3_ia32_mask_n[pos] =3D val;
> +}
> +
> +void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val) {
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    rdt->rdtstate->msr_L2_ia32_mask_n[pos] =3D val;
> +}
> +
> +void rdt_write_mba_thrtl(uint32_t pos, uint32_t val) {
> +    X86CPU *cpu =3D X86_CPU(current_cpu);
> +    RDTStateInstance *rdt =3D cpu->rdt;
> +
> +    rdt->rdtstate->ia32_L2_qos_ext_bw_thrtl_n[pos] =3D val;
> +}
> +
> +uint32_t rdt_max_rmid(RDTStateInstance *rdt)
> +{
> +    RDTState *rdtdev =3D rdt->rdtstate;
> +    return rdtdev->rmids - 1;
> +}
> +
> +uint64_t rdt_read_event_count(RDTStateInstance *rdtInstance, uint32_t rm=
id, uint32_t event_id)

Long line - consider wrapping it.

> +{
> +    CPUState *cs;
> +    RDTMonitor *mon;
> +    RDTState *rdt =3D rdtInstance->rdtstate;
> +
> +    uint32_t count_l3 =3D 0;
> +    uint32_t count_local=3D 0;
> +    uint32_t count_remote =3D 0;
> +
> +    if (!rdt) {
> +        return 0;
> +    }
> +
> +    CPU_FOREACH(cs) {
> +        rdtInstance =3D &g_array_index(rdt->rdtInstances, RDTStateInstan=
ce, cs->cpu_index);
> +        if (rmid >=3D rdtInstance->monitors->len) {
> +            return QM_CTR_Error;
> +        }
> +        mon =3D &g_array_index(rdtInstance->monitors, RDTMonitor, rmid);
> +        count_l3 +=3D mon->count_l3;
> +        count_local +=3D mon->count_local;
> +        count_remote +=3D mon->count_remote;
> +    }
> +
> +    switch (event_id) {
> +        case RDT_EVENT_L3_OCCUPANCY:
> +            return count_l3 =3D=3D 0 ? QM_CTR_Unavailable : count_l3;
> +            break;
> +        case RDT_EVENT_L3_REMOTE_BW:
> +            return count_remote =3D=3D 0 ? QM_CTR_Unavailable : count_re=
mote;
> +            break;
> +        case RDT_EVENT_L3_LOCAL_BW:
> +            return count_local =3D=3D 0 ? QM_CTR_Unavailable : count_loc=
al;
> +            break;

break after return not needed. I'm a bit surprised that didn't give you a w=
arning.


> +        default:
> +            return QM_CTR_Error;
> +    }
> +}
> +
>  OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> =20
>  static Property rdt_properties[] =3D {
> diff --git a/include/hw/i386/rdt.h b/include/hw/i386/rdt.h
> index 45e34d3103..8092c5f290 100644
> --- a/include/hw/i386/rdt.h
> +++ b/include/hw/i386/rdt.h
> @@ -10,3 +10,16 @@ typedef struct RDTMonitor RDTMonitor;
>  typedef struct RDTAllocation RDTAllocation;
> =20
>  #endif
> +bool rdt_associate_rmid_cos(uint64_t msr_ia32_pqr_assoc);
> +
> +void rdt_write_msr_l3_mask(uint32_t pos, uint32_t val);
> +void rdt_write_msr_l2_mask(uint32_t pos, uint32_t val);
> +void rdt_write_mba_thrtl(uint32_t pos, uint32_t val);
> +
> +uint32_t rdt_read_l3_mask(uint32_t pos);
> +uint32_t rdt_read_l2_mask(uint32_t pos);
> +uint32_t rdt_read_mba_thrtl(uint32_t pos);
> +
> +uint64_t rdt_read_event_count(RDTStateInstance *rdt, uint32_t rmid, uint=
32_t event_id);
> +uint32_t rdt_max_rmid(RDTStateInstance *rdt);
> +
Trailing blank line doesn't add anything so I'd drop it.

Jonathan

