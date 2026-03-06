Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C3BFCC04F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:40:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ9Y-0008NV-FB; Fri, 06 Mar 2026 12:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZ9U-0008MX-KZ; Fri, 06 Mar 2026 12:39:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vyZ9S-0005VD-Ef; Fri, 06 Mar 2026 12:39:52 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fSDDD1H6HzJ46DX;
 Sat,  7 Mar 2026 01:39:08 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 822C140584;
 Sat,  7 Mar 2026 01:39:46 +0800 (CST)
Received: from localhost (10.48.149.21) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Mar
 2026 17:39:45 +0000
Date: Fri, 6 Mar 2026 17:39:42 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 15/65] hw/intc/arm_gicv5: Implement IRS_IST_{BASER,
 STATUSR, CFGR}
Message-ID: <20260306173942.000008c8@huawei.com>
In-Reply-To: <20260223170212.441276-16-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-16-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.149.21]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
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

On Mon, 23 Feb 2026 17:01:22 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement the three registers that handle configuration of the
> interrupt status table for physical LPIs:
> 
>  * IRS_IST_BASER holds the base address of the table, and
>    has the VALID bit that tells the IRS to start using the config
>  * IRS_IST_CFGR has all the other config data for the table
>  * IRS_IST_STATUSR has the IDLE bit that tells software when
>    updates to IRS_IST_BASER have taken effect
> 
> Implement these registers.  Note that neither BASER nor CFGR can be
> written when VALID == 1, except to clear the VALID bit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

One query inline but it'll probably become obvious later, so 
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> diff --git a/include/hw/intc/arm_gicv5_common.h b/include/hw/intc/arm_gicv5_common.h
> index 7db2c87ddc..2a49d58679 100644
> --- a/include/hw/intc/arm_gicv5_common.h
> +++ b/include/hw/intc/arm_gicv5_common.h
> @@ -62,6 +62,9 @@ struct GICv5Common {
>  
>      MemoryRegion iomem[NUM_GICV5_DOMAINS];
>  
> +    uint64_t irs_ist_baser[NUM_GICV5_DOMAINS];
> +    uint32_t irs_ist_cfgr[NUM_GICV5_DOMAINS];

Feels like you are going to have a lot of these, why not an array of
structures?

> +
>      /* Bits here are set for each physical interrupt domain implemented */
>      uint8_t implemented_domains;
>  


