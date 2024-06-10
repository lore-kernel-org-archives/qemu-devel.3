Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5674C41513
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 09:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGbGB-0003FY-02; Mon, 10 Jun 2024 05:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l9v5=NM=kaod.org=clg@ozlabs.org>)
 id 1sGbG9-0003FD-52; Mon, 10 Jun 2024 05:24:13 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=l9v5=NM=kaod.org=clg@ozlabs.org>)
 id 1sGbG7-0003Xq-IV; Mon, 10 Jun 2024 05:24:12 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VyRFb41Nlz4x2M;
 Mon, 10 Jun 2024 19:24:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VyRFY3hQ7z4x4T;
 Mon, 10 Jun 2024 19:24:01 +1000 (AEST)
Message-ID: <c8490af5-466d-44fd-ace5-2b32f653e4b6@kaod.org>
Date: Mon, 10 Jun 2024 11:23:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] aspeed/smc: Reintroduce "dram-base" property for AST2700
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20240527124315.35356-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240527124315.35356-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=l9v5=NM=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/27/24 2:43 PM, Cédric Le Goater wrote:
> The Aspeed SMC device model use to have a 'sdram_base' property. It
> was removed by commit d177892d4a48 ("aspeed/smc: Remove unused
> "sdram-base" property") because previous changes simplified the DMA
> transaction model to use an offset in RAM and not the physical
> address.
> 
> The AST2700 SoC has larger address space (64-bit) and a new register
> DMA DRAM Side Address High Part (0x7C) is introduced to deal with the
> high bits of the DMA address. To be able to compute the offset of the
> DMA transaction, as done on the other SoCs, we will need to know where
> the DRAM is mapped in the address space. Re-introduce a "dram-base"
> property to hold this value.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/ssi/aspeed_smc.h | 1 +
>   hw/ssi/aspeed_smc.c         | 1 +
>   2 files changed, 2 insertions(+)


Applied to aspeed-next.

Thanks,

C.


