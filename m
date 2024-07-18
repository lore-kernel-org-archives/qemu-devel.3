Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8F47C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 16:19:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUTqS-0004mJ-VX; Thu, 18 Jul 2024 12:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUTqN-0004il-Ve; Thu, 18 Jul 2024 12:19:00 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=3riu=OS=kaod.org=clg@ozlabs.org>)
 id 1sUTqK-00084D-NA; Thu, 18 Jul 2024 12:18:59 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WPyfh5M3kz4x3n;
 Fri, 19 Jul 2024 02:18:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WPyfd0YR3z4x3J;
 Fri, 19 Jul 2024 02:18:48 +1000 (AEST)
Message-ID: <70226be1-a54b-42ba-8680-edb0f8ecf4b0@kaod.org>
Date: Thu, 18 Jul 2024 18:18:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] aspeed: Add boot from eMMC support (AST2600)
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240717063022.549849-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240717063022.549849-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=3riu=OS=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/17/24 08:30, Cédric Le Goater wrote:
> Hello,
> 
> This series enables boot from eMMC on the rainier-bmc machine, which
> is the default behavior and also on the AST2600 EVB using a machine
> option to change the default.
> 
> First 6 patches adjust the machine setup and HW strapping to boot from
> eMMC, the last 2 are for the AST2600 EVB and are optional.
> 
> Thanks,
> 
> C.
> 
> Changes since v1:
> 
>   - Rebased on upstream, now that the eMMC device model is available
>   - Rephrased commit logs
>   - Fixed SCU prefix of bit definitions
>   - Tuned 'boot-config' and 'boot-partition-size' eMMC properties
> 
> Cédric Le Goater (8):
>    aspeed: Change type of eMMC device
>    aspeed: Load eMMC first boot area as a boot rom
>    aspeed/scu: Add boot-from-eMMC HW strapping bit for AST2600 SoC
>    aspeed: Introduce a AspeedSoCClass 'boot_from_emmc' handler
>    aspeed: Tune eMMC device properties to reflect HW strapping
>    aspeed: Add boot-from-eMMC HW strapping bit to rainier-bmc machine
>    aspeed: Introduce a 'hw_strap1' machine attribute
>    aspeed: Introduce a 'boot-emmc' machine option
> 
>   docs/system/arm/aspeed.rst   |  2 ++
>   include/hw/arm/aspeed_soc.h  |  1 +
>   include/hw/misc/aspeed_scu.h |  4 +++
>   hw/arm/aspeed.c              | 62 +++++++++++++++++++++++++++++++-----
>   hw/arm/aspeed_ast2600.c      |  8 +++++
>   hw/arm/aspeed_soc_common.c   |  7 ++++
>   6 files changed, 76 insertions(+), 8 deletions(-)
> 


Applied to aspeed-next.

Thanks,

C.



