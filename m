Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BB8FCC051
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 18:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZVo-0002Ch-99; Fri, 06 Mar 2026 13:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZVX-0002Ab-Kz; Fri, 06 Mar 2026 13:02:47 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZVT-0008Nr-8S; Fri, 06 Mar 2026 13:02:37 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fSDkS27G2zJ46BM;
 Sat,  7 Mar 2026 02:01:52 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A526340086;
 Sat,  7 Mar 2026 02:02:30 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 18:02:30 +0000
Date: Fri, 6 Mar 2026 18:02:26 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 17/65] hw/intc/arm_gicv5: Implement gicv5_set_priority()
Message-ID: <20260306180226.00002491@huawei.com>
In-Reply-To: <20260223170212.441276-18-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-18-peter.maydell@linaro.org>
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

On Mon, 23 Feb 2026 17:01:24 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement the gicv5_set_priority() function, which is our equivalent
> of the Stream Protocol SetPriority command.  This acts by looking the
> interrupt ID up in the Interrupt State Table and storing the new
> priority value into the table entry.
> 
> The memory transaction has to have the right transaction attributes
> for the domain it is for; we precalculate these and keep them in the
> GICv5ISTConfig.
> 
> The GIC has an optional software-error reporting mechanism via the
> IRS_SWERR_* registers; this does not report all failure cases, only
> those that would be annoying to detect and debug in some other way.
> We choose not to implement this, but include some comments for
> reportable error cases for future reference.  Our LOG_GUEST_ERROR
> logging is a superset of this.
> 
> At this point we implement only handling of SetPriority for LPIs; we
> will add SPI handling in a later commit.  Virtual interrupts aren't
> supported by this initial EL1-only GICv5 implementation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Trivial stuff inline.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 3f74069e01..8572823edc 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c




> +static bool read_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
> +                             hwaddr addr, uint32_t *l2_iste)
> +{
> +    MemTxResult res;

I'd like a blank line here.

> +    *l2_iste = address_space_ldl_le(&cs->dma_as, addr, cfg->txattrs, &res);
> +    if (res != MEMTX_OK) {
> +        /* Reportable with EC=0x02 if sw error reporting implemented */
> +        qemu_log_mask(LOG_GUEST_ERROR, "L2 ISTE read failed at physical "
> +                      "address 0x" HWADDR_FMT_plx "\n", addr);
> +    }
> +    return res == MEMTX_OK;
> +}
> +
> +static bool write_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
> +                              hwaddr addr, uint32_t l2_iste)
> +{
> +    MemTxResult res;

and here

> +    address_space_stl_le(&cs->dma_as, addr, l2_iste, cfg->txattrs, &res);
> +    if (res != MEMTX_OK) {
> +        /* Reportable with EC=0x02 if sw error reporting implemented */
> +        qemu_log_mask(LOG_GUEST_ERROR, "L2 ISTE write failed at physical "
> +                      "address 0x" HWADDR_FMT_plx "\n", addr);
> +    }
> +    return res == MEMTX_OK;
> +}


