Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18ECF112583A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 14:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0KnQ-0003aW-SB; Wed, 11 Mar 2026 10:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KnM-0003a7-PK; Wed, 11 Mar 2026 10:44:22 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1w0KnJ-0007Aw-30; Wed, 11 Mar 2026 10:44:19 -0400
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fWD5B2909zJ46bk;
 Wed, 11 Mar 2026 22:43:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id A44CE40585;
 Wed, 11 Mar 2026 22:44:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Mar
 2026 14:44:12 +0000
Date: Wed, 11 Mar 2026 14:44:10 +0000
To: Peter Maydell <peter.maydell@linaro.org>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 24/65] hw/intc/arm_gicv5: Implement gicv5_request_config()
Message-ID: <20260311144410.000065c2@huawei.com>
In-Reply-To: <20260223170212.441276-25-peter.maydell@linaro.org>
References: <20260223170212.441276-1-peter.maydell@linaro.org>
 <20260223170212.441276-25-peter.maydell@linaro.org>
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

On Mon, 23 Feb 2026 17:01:31 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> Implement the gicv5_request_config() function, which corresponds to
> the RequestConfig command and its RequestConfigAck reply.
> 
> We provide read_l2_iste() as a separate function to keep the "access
> the in-guest-memory data structure" layer separate from the "operate
> on the L2_ISTE values" layer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

One comment in line. Pretty much follows from earlier comments.

> ---
>  hw/intc/arm_gicv5.c                | 92 ++++++++++++++++++++++++++++++
>  hw/intc/trace-events               |  1 +
>  include/hw/intc/arm_gicv5_stream.h | 24 ++++++++
>  3 files changed, 117 insertions(+)
> 
> diff --git a/hw/intc/arm_gicv5.c b/hw/intc/arm_gicv5.c
> index 4d99200122..51b25775c4 100644
> --- a/hw/intc/arm_gicv5.c
> +++ b/hw/intc/arm_gicv5.c


> +uint64_t gicv5_request_config(GICv5Common *cs, uint32_t id, GICv5Domain domain,
> +                              GICv5IntType type, bool virtual)
> +{
> +    const GICv5ISTConfig *cfg;
> +    GICv5 *s = ARM_GICV5(cs);
> +    uint64_t icsr;
> +
> +    if (virtual) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
> +                      "read config of a virtual interrupt\n");
> +        return R_ICSR_F_MASK;
> +    }
> +    if (type == GICV5_SPI) {

Seems a bit inconsistent to not reject the remaining defined
GICv5IntType as you did in previous patches.  As before I
think I'd prefer this as a switch statement with resulting clarity
on what is handled.

> +        GICv5SPIState *spi = gicv5_spi_state(cs, id, domain);
> +
> +        if (!spi) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "gicv5_request_config: tried to "
> +                          "read config of unreachable SPI %d\n", id);
> +            return R_ICSR_F_MASK;
> +        }
> +
> +        icsr = spi_state_to_icsr(spi);
> +        trace_gicv5_request_config(domain_name[domain], inttype_name(type),
> +                                   virtual, id, icsr);
> +        return icsr;
> +    }
> +    cfg = &s->phys_lpi_config[domain];
> +
> +    icsr = l2_iste_to_icsr(cs, cfg, id);
> +    trace_gicv5_request_config(domain_name[domain], inttype_name(type),
> +                               virtual, id, icsr);
> +    return icsr;
> +}


