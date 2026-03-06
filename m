Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E4EFCB61C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 16:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyXqn-0004rW-Dl; Fri, 06 Mar 2026 11:16:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyXql-0004pp-DZ; Fri, 06 Mar 2026 11:16:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyXqh-0007Gd-Fl; Fri, 06 Mar 2026 11:16:27 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fSBMx1sNVzJ46DQ;
 Sat,  7 Mar 2026 00:15:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 7DA4840086;
 Sat,  7 Mar 2026 00:16:19 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 16:16:18 +0000
Date: Fri, 6 Mar 2026 16:16:17 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 09/65] hw/intc/arm_gicv5: Implement IRS ID regs
Message-ID: <20260306161617.00000f71@huawei.com>
In-Reply-To: <20260223170212.441276-10-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-10-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 23 Feb 2026 17:01:16 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement the IRS frame ID registers IRS_IDR[0-7], IRS_IIDR and
> IRS_AIDR.  These are all 32-bit registers.
> 
> We make these fields in the GIC state struct rather than just
> hardcoding them in the register read function so that we can later
> code "do this only if X is implemented" as a test on the ID register
> value.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gicv5.c                | 112 +++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv5_common.h |  39 ++++++++++
>  2 files changed, 151 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index db754e7681..f34bb81966 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -268,6 +268,62 @@ REG64(IRS_SWERR_SYNDROMER1, 0x3d0)
>  static bool config_readl(GICv5 *s, GICv5Domain domain, hwaddr offset,
>                           uint64_t *data, MemTxAttrs attrs)
>  {
> +    GICv5Common *cs = ARM_GICV5_COMMON(s);
> +    uint32_t v = 0;
> +
> +    switch (offset) {
> +    case A_IRS_IDR0:
> +        v = cs->irs_idr0;
> +        /* INT_DOM reports the domain this register is for */
> +        v = FIELD_DP32(v, IRS_IDR0, INT_DOM, domain);
> +        if (domain != GICV5_ID_REALM) {
> +            /* MEC field RES0 except for the Realm domain */
> +            v &= ~R_IRS_IDR0_MEC_MASK;
> +        }
> +        if (domain == GICV5_ID_EL3) {
> +            /* VIRT is RES0 for EL3 domain */
> +            v &= ~R_IRS_IDR0_VIRT_MASK;
> +        }

There are some more complex RES0 conditions that kind of build
off these, like VIRT_ONE_N is RES0 if VIRT is 0, including
I think if VIRT is RES0 as a result of the above.  That particular
condition is perhaps worth encoding in here as you can see we may
have it implemented for everything other than EL3.

This is similar to what you do for the whole of IDR3.

> +        return true;
> +
> +    case A_IRS_IDR1:
> +        *data = cs->irs_idr1;
> +        return true;
> +
> +    case A_IRS_IDR2:
> +        *data = cs->irs_idr2;
> +        return true;
> +
> +    case A_IRS_IDR3:
> +        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
> +        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr3;

The spec has that condition on a field by field bases. I wonder
if it would be clearer to mask out each field rather than set
whole thing to 0.

> +        return true;
> +
> +    case A_IRS_IDR4:
> +        /* In EL3 IDR0.VIRT is 0 so this is RES0 */
> +        *data = domain == GICV5_ID_EL3 ? 0 : cs->irs_idr4;
Similar for this one.  Most of register is currently res0 and
we don't know if those bits will be used later for stuff that
isn't dependent on IRS_IDR0.VIRT being 1.

> +        return true;

...

>  }
>  
> @@ -443,6 +499,60 @@ static void gicv5_reset_hold(Object *obj, ResetType type)
>      }
>  }
>  
> +static void gicv5_set_idregs(GICv5Common *cs)
> +{
> +    /* Set the ID register value fields */
> +    uint32_t v;
> +
> +    /*
> +     * We don't support any of the optional parts of the spec currently,
Doesn't matter much but 'currently' does add anything to this sentence so
could just drop it.

> +     * so most of the fields in IRS_IDR0 are zero.
> +     */
> +    v = 0;


> +}
> +

>  
> diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
> index be898abcd5..bcf7cd4239 100644
> --- a/include/hw/intc/arm_gicv5_common.h
> +++ b/include/hw/intc/arm_gicv5_common.h
> @@ -65,6 +65,18 @@ struct GICv5Common {


> +/*
> + * The architecture allows a GICv5 to implement less than the
> + * full width for various ID fields. QEMU's implementation
> + * always supports the full width of these fields. These constants
> + * define our implementation's limits.
> + */
> +
> +/* Number of INTID.ID bits we support */
> +#define QEMU_GICV5_ID_BITS 24
> +/* Min LPI_ID_BITS supported */
> +#define QEMU_GICV5_MIN_LPI_ID_BITS 14
> +/* IAFFID bits supported */
> +#define QEMU_GICV5_IAFFID_BITS 16
> +/* Number of priority bits supported in the IRS */
> +#define QEMU_GICV5_PRI_BITS 5
> +
> +/*
> + * There are no TRMs currently published for hardware
> + * implementations of GICv5 that we might identify ourselves
> + * as. Instead, we borrow the Arm Implementer code and
> + * pick an arbitrary product ID (ASCII "Q")

Rather short wrap.


> + */
> +#define QEMU_GICV5_IMPLEMENTER 0x43b
> +#define QEMU_GICV5_PRODUCTID 0x51
> +#define QEMU_GICV5_REVISION 0
> +#define QEMU_GICV5_VARIANT 0
> +
>  /**
>   * gicv5_common_init_irqs_and_mmio: Create IRQs and MMIO regions for the GICv5
>   * @s: GIC object


