Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC879FD0651
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Keb-0001uG-Cn; Wed, 11 Mar 2026 10:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KeV-0001ta-Dv; Wed, 11 Mar 2026 10:35:11 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KeS-00052R-Te; Wed, 11 Mar 2026 10:35:11 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWCtg4mK2zJ46YL;
 Wed, 11 Mar 2026 22:34:19 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 0717240575;
 Wed, 11 Mar 2026 22:35:06 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 14:35:05 +0000
Date: Wed, 11 Mar 2026 14:35:04 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 23/65] hw/intc/arm_gicv5: Make gicv5_set_* update SPI state
Message-ID: <20260311143504.00001363@huawei.com>
In-Reply-To: <20260223170212.441276-24-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-24-peter.maydell@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
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

On Mon, 23 Feb 2026 17:01:30 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> The GIC CD* insns that update interrupt state also work for SPIs.
> Instead of ignoring the GICV5_SPI type in gicv5_set_priority() and
> friends, update the state in our SPI state array.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
For this one I wonder if the resulting code structure is reflecting
more about how the patch series evolves rather than a more ideal
version where the SPI and LPI are treated as to 'equalish' options.
So to me a switch statement with two good legs and a default one
that rejects all other types of interrupt (so the 1 remaining one!)

Not that important however.

> ---
>  hw/intc/arm_gicv5.c                | 59 ++++++++++++++++++++++++++++++
>  include/hw/intc/arm_gicv5_common.h | 40 ++++++++++++++++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 3c6ef17573..4d99200122 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c
> @@ -478,6 +478,18 @@ void gicv5_set_priority(GICv5Common *cs, uint32_t id,
>                        "priority of a virtual interrupt\n");
>          return;
>      }
> +    if (type == GICV5_SPI) {

To me it feels a bit like this would be readable as a switch statement
given 2 out of 3 types are handled.

If you do go that way, then introducing the switch in the earlier patch
probably makes sense to minimize churn.

> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_set_priority: tried to set "
> +                          "priority of unreachable SPI %d\n", id);
> +            return;
> +        }
> +
> +        spi->priority = priority;
> +        return;
> +    }



