Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2768FFCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:58:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWd3-0002VG-9E; Fri, 06 Mar 2026 09:58:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyWcz-0002Ui-KO; Fri, 06 Mar 2026 09:58:09 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyWcx-0002Cl-Ee; Fri, 06 Mar 2026 09:58:09 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fS8d95fcGzHnH5G;
 Fri,  6 Mar 2026 22:57:01 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A16D940584;
 Fri,  6 Mar 2026 22:58:01 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 14:58:01 +0000
Date: Fri, 6 Mar 2026 14:57:59 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 07/65] hw/intc/arm_gicv5: Create inbound GPIO lines for
 SPIs
Message-ID: <20260306145759.000048b9@huawei.com>
In-Reply-To: <20260223170212.441276-8-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-8-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
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

On Mon, 23 Feb 2026 17:01:14 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The GICv5 IRS may have inbound GPIO lines corresponding to SPIs
> (shared peripheral interrupts).  Unlike the GICv3, it does not deal
> with PPIs (private peripheral interrupts, i.e.  per-CPU interrupts):
> in a GICv5 system those are handled entirely within the CPU
> interface.  The inbound GPIO array is therefore a simple sequence of
> one GPIO per SPI that this IRS handles.
> 
> Create the GPIO input array in gicv5_common_init_irqs_and_mmio().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Another bit of trivial stuff from me ;)

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


>  gicv5_common_realize(uint32_t irsid, uint32_t num_cpus, uint32_t spi_base, uint32_t spi_irs_range, uint32_t spi_range) "GICv5 IRS realized: IRS ID %u, %u CPUs, SPI base %u, SPI IRS range %u, SPI range %u"
> diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
> index b22f020a53..be898abcd5 100644
> --- a/include/hw/intc/arm_gicv5_common.h
> +++ b/include/hw/intc/arm_gicv5_common.h
> @@ -29,6 +29,9 @@
>   *   IRS (this is IRS_IDR7.SPI_BASE); default is 0
>   * + QOM property "spi-irs-range": number of SPI INTID.ID managed on this
>   *   IRS (this is IRS_IDR6.SPI_IRS_RANGE); defaults to value of spi-range
> + * + unnamed GPIO inputs: the SPIs handled by this IRS
> + *   (so GPIO input 0 is the SPI with INTID SPI_BASE, input 1 is
> + *   SPI_BASE+1, and so on up to SPI_BASE + SPI_IRS_RANGE - 1)
SPI_BASE + 1 

for consistency.




