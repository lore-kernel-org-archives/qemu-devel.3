Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4678B1125842
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:47:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Llo-0000EN-Kx; Wed, 11 Mar 2026 11:46:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0Llf-0000C2-AM; Wed, 11 Mar 2026 11:46:39 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0LlU-0000ZX-UG; Wed, 11 Mar 2026 11:46:32 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWFTh5BV9zHnGjM;
 Wed, 11 Mar 2026 23:46:16 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A6A1D40585;
 Wed, 11 Mar 2026 23:46:24 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 15:46:24 +0000
Date: Wed, 11 Mar 2026 15:46:22 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 32/65] hw/intc/arm_gicv5: Cache pending LPIs in a hash
 table
Message-ID: <20260311154622.00007541@huawei.com>
In-Reply-To: <20260223170212.441276-33-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-33-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

On Mon, 23 Feb 2026 17:01:39 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The GICv5 stores information about LPIs in a guest-memory data
> structure.  Iterating through this to identify the highest priority
> pending interrupt would be expensive; to avoid this we will use a
> hash table which contains an entry for each pending LPI and which
> caches the L2 ISTE.  Typically only a few LPIs will be pending at any
> one time, so iterating through the hash table should be fast.
> 
> We can access an L2 ISTE whenever it is valid, and can freely cache
> the data for as long as the IST is valid.  We only need to ensure
> that we have written back the data at the point where
> IRS_IST_BASER.VALID is written to 0.
> 
> We add an LPI to the cache when the pending bit is written to 1, and
> remove it when it is written to 0.  Handling of checking the cache,
> and of adding and removing entries, is handled within get_l2_iste()
> and put_l2_iste(), which all the operations that read and write ISTE
> words use.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

> ---
>  hw/intc/arm_gicv5.c         | 110 +++++++++++++++++++++++++++++++++++-
>  include/hw/intc/arm_gicv5.h |   2 +
>  2 files changed, 111 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index fa7692ca0e..30368998d3 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -474,10 +474,21 @@ static bool write_l2_iste_mem(GICv5Common *cs, const GICv5ISTConfig *cfg,
>   * reads and writes to update the L2 ISTE. In a future commit we
>   * will add support for a cache of some of the ISTE data in a
>   * local hashtable; the APIs are designed with that in mind.
> + * Not all these fields are always valid; they are private to
> + * the implementation of get_l2_iste() and put_l2_iste().

Completely trivial but wrap seems to be getting shorter as this comment gains
lines!




