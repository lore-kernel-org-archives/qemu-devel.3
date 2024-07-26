Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D47C1C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 10:34:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXIGj-0000tF-Hw; Fri, 26 Jul 2024 06:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIGi-0000si-2M
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:33:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1sXIGf-0006DB-Rc
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 06:33:47 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WVkYt2Lpvz6K8mZ;
 Fri, 26 Jul 2024 18:31:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id AF86B140A46;
 Fri, 26 Jul 2024 18:33:41 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 26 Jul
 2024 11:33:41 +0100
Date: Fri, 26 Jul 2024 11:33:40 +0100
To: Hendrik Wuethrich <whendrik@google.com>
CC: <qemu-devel@nongnu.org>, <eduardo@habkost.net>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <peternewman@google.com>
Subject: Re: [PATCH v1 2/9] Add state for RDT device.
Message-ID: <20240726113340.00005d4d@Huawei.com>
In-Reply-To: <20240719162929.1197154-3-whendrik@google.com>
References: <20240719162929.1197154-1-whendrik@google.com>
 <20240719162929.1197154-3-whendrik@google.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.203.174.77]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

On Fri, 19 Jul 2024 16:29:22 +0000
Hendrik Wuethrich <whendrik@google.com> wrote:

> From: =E2=80=AAHendrik W=C3=BCthrich <whendrik@google.com>
>=20
> Add structures and variables needed to emulate Intel RDT, including
> module-internal sturctures and state in ArchCPU. No functionality yet.
>=20
> Signed-off-by: Hendrik W=C3=BCthrich <whendrik@google.com>
A few general comments inline.

J
> ---
>  hw/i386/rdt.c     | 33 +++++++++++++++++++++++++++++++++
>  target/i386/cpu.h |  5 +++++
>  2 files changed, 38 insertions(+)
>=20
> diff --git a/hw/i386/rdt.c b/hw/i386/rdt.c
> index 0a5e95606b..cf246ab835 100644
> --- a/hw/i386/rdt.c
> +++ b/hw/i386/rdt.c
> @@ -7,12 +7,44 @@
>  #include "target/i386/cpu.h"
>  #include "hw/isa/isa.h"
> =20
> +/* Max counts for allocation masks or CBMs. In other words, the size of =
respective MSRs*/
> +#define MAX_L3_MASK_COUNT      128

If these are an architectural limitation rather than a qemu one good
to have a reference. If it's an RDT requirement namespace them with
RDT_*

> +#define MAX_L2_MASK_COUNT      48
> +#define MAX_MBA_THRTL_COUNT    31
> +
>  #define TYPE_RDT "rdt"
> +#define RDT_NUM_RMID_PROP "rmids"
> =20
>  OBJECT_DECLARE_TYPE(RDTState, RDTStateClass, RDT);
> =20
> +struct RDTMonitor {
> +    uint64_t count_local;
> +    uint64_t count_remote;
> +    uint64_t count_l3;
> +};
> +
> +struct RDTAllocation {
> +    uint32_t active_cos;
> +};
> +
> +struct RDTStateInstance {

I'd add some docs for this and RDTState to make it obvious
what the scope of each is.  What do they represent and how
is it different?
This seems like it might be the per core part.  If so can
you name it to make that obvious?  RDTPerCoreState or
something like that?

> +    uint32_t active_rmid;
> +    GArray *monitors;
> +
> +    RDTState *rdtstate;
> +};
> +
>  struct RDTState {
>      ISADevice parent;
> +
> +    uint32_t rmids;
> +
> +    GArray *rdtInstances;

Whilst naming makes it likely I'd add a comment to say this
an array of RDTStateInstance with (I think) one per core?

> +    GArray *allocations;
> +
> +    uint32_t msr_L3_ia32_mask_n[MAX_L3_MASK_COUNT];
> +    uint32_t msr_L2_ia32_mask_n[MAX_L2_MASK_COUNT];
> +    uint32_t ia32_L2_qos_ext_bw_thrtl_n[MAX_MBA_THRTL_COUNT];
>  };
> =20
>  struct RDTStateClass { };
> @@ -20,6 +52,7 @@ struct RDTStateClass { };
>  OBJECT_DEFINE_TYPE(RDTState, rdt, RDT, ISA_DEVICE);
> =20
>  static Property rdt_properties[] =3D {
> +    DEFINE_PROP_UINT32(RDT_NUM_RMID_PROP, RDTState, rmids, 256),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 1e121acef5..bd0bbb75f2 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1987,6 +1987,8 @@ typedef struct CPUArchState {
> =20
>  struct kvm_msrs;
> =20
> +struct RDTState;

Not used?

> +struct rdtStateInstance;
>  /**
>   * X86CPU:
>   * @env: #CPUX86State
> @@ -2143,6 +2145,9 @@ struct ArchCPU {
>      struct MemoryRegion *cpu_as_root, *cpu_as_mem, *smram;
>      Notifier machine_done;
> =20
> +    /* Help the RDT MSRs find the RDT device */
> +    struct RDTStateInstance *rdt;
> +
>      struct kvm_msrs *kvm_msr_buf;
> =20
>      int32_t node_id; /* NUMA node this CPU belongs to */


