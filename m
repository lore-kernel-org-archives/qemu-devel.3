Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253C4FCC04D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:10:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZcv-0006tA-Us; Fri, 06 Mar 2026 13:10:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZcu-0006qu-7Z; Fri, 06 Mar 2026 13:10:16 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZcs-0001PI-D4; Fri, 06 Mar 2026 13:10:16 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fSDtt4P8szHnGhr;
 Sat,  7 Mar 2026 02:09:10 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id B660F4056A;
 Sat,  7 Mar 2026 02:10:10 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 18:10:09 +0000
Date: Fri, 6 Mar 2026 18:10:08 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 19/65] hw/intc/arm_gicv5: Implement IRS_MAP_L2_ISTR
Message-ID: <20260306181008.00001850@huawei.com>
In-Reply-To: <20260223170212.441276-20-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-20-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
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

On Mon, 23 Feb 2026 17:01:26 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The IRS register IRS_MAP_L2_ISTR is used by software to tell the IRS
> that it has updated the address in an L1 IST entry to point to an
> L2 IST. The sequence of events here is:
>  * software writes to L1_ISTE.L2_ADDR for some L1 ISTE which is
>    not valid (i.e. where L1_ISTE.VALID is 0); it leaves VALID at 0
>  * software writes to IRS_MAP_L2_ISTR with some INTID that is inside
>    the range for this L1 ISTE
>  * the IRS sets IRS_IST_STATUSR.IDLE to 0
>  * the IRS takes note of this information
>  * the IRS writes to the L1_ISTE to set VALID=1
>  * the IRS sets IRS_IST_STATUSR.IDLE to 1 to indicate that the
>    update is complete
> 
> For QEMU, we're strictly synchronous, so (as with IRS_IST_BASER
> updates) we don't need to model the IDLE transitions and can have
> IRS_IST_STATUSR always return IDLE=1.  We also don't currently cache
> anything for ISTE lookups, so we don't need to invalidate or update
> anything when software makes the L2 valid.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
One trivial thing inline.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

That's enough for today, not sure when I'll get back to the rest of the series.
So far very nice and clean. Makes reviewing pleasant!

J
> ---
>  hw/intc/arm_gicv5.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 8572823edc..af27fb7e63 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -492,6 +492,44 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
>      put_l2_iste(cs, cfg, &h);
>  }
>  
> +static void irs_map_l2_istr_write(GICv5 *s, GICv5Domain domain, uint64_t value)
> +{
> +    GICv5Common *cs = ARM_GICV5_COMMON(s);
> +    GICv5ISTConfig *cfg = &s->phys_lpi_config[domain];
> +    uint32_t intid = FIELD_EX32(value, IRS_MAP_L2_ISTR, ID);
> +    hwaddr l1_addr;
> +    uint64_t l1_iste;
> +    MemTxResult res;
> +
> +    if (!FIELD_EX64(cs->irs_ist_baser[domain], IRS_IST_BASER, VALID) ||
> +        !cfg->structure) {
> +        /* WI if no IST set up or it is not 2-level */
> +        return;
> +    }
> +
> +    /* Find the relevant L1 ISTE and set its VALID bit */
> +    l1_addr = l1_iste_addr(cs, cfg, intid);
> +
> +    l1_iste = address_space_ldq_le(&cs->dma_as, l1_addr, cfg->txattrs, &res);
> +    if (res != MEMTX_OK) {
> +        goto txfail;
> +    }
> +
> +    l1_iste = FIELD_DP64(l1_iste, L1_ISTE, VALID, 1);
> +
> +    address_space_stq_le(&cs->dma_as, l1_addr, l1_iste, cfg->txattrs, &res);
> +    if (res != MEMTX_OK) {
> +        goto txfail;
> +    }
> +    return;
> +
> +txfail:
> +    /* Reportable with EC=0x0 if sw error reporting implemented */
> +    qemu_log_mask(LOG_GUEST_ERROR, "L1 ISTE update failed for ID 0x%x at "
> +                  "physical address 0x" HWADDR_FMT_plx "\n", intid, l1_addr);
> +}
> +

I think other code is all one blank line between functions.  Guessing no
particular reason for 2 here?

> +
>  static void irs_ist_baser_write(GICv5 *s, GICv5Domain domain, uint64_t value)
>  {
>      GICv5Common *cs = ARM_GICV5_COMMON(s);
> @@ -675,6 +713,9 @@ static bool config_writel(GICv5 *s, GICv5Domain domain, hwaddr offset,
>              cs->irs_ist_cfgr[domain] = data;
>          }
>          return true;
> +    case A_IRS_MAP_L2_ISTR:
> +        irs_map_l2_istr_write(s, domain, data);
> +        return true;
>      }
>      return false;
>  }


