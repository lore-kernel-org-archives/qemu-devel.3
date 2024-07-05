Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A220C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPjlh-0007wU-QE; Fri, 05 Jul 2024 10:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=slai=OF=kaod.org=clg@ozlabs.org>)
 id 1sPjlg-0007w8-48; Fri, 05 Jul 2024 10:18:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=slai=OF=kaod.org=clg@ozlabs.org>)
 id 1sPjle-0003il-9y; Fri, 05 Jul 2024 10:18:31 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WFwbf2hz1z4wbr;
 Sat,  6 Jul 2024 00:18:22 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFwbZ2Hs6z4wZx;
 Sat,  6 Jul 2024 00:18:17 +1000 (AEST)
Message-ID: <34099911-4c2b-4cfa-a1e7-c03e78a25f6e@kaod.org>
Date: Fri, 5 Jul 2024 16:18:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 0/5] hw/sd/sdcard: Cleanups before adding eMMC support
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=slai=OF=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/3/24 3:43 PM, Philippe Mathieu-Daudé wrote:
> (patches from v42 already reviewed not reposted)
> 
> Since v45:
> - RAZ/WI on GEN_CMD (Luc & Manos)
> - Rename sd_cmd_SEND_OP_COND
> - Introduce TYPE_SDMMC_COMMON
> 
> Philippe Mathieu-Daudé (5):
>    hw/sd/sdcard: Use spec v3.01 by default
>    hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
>    hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
>    hw/sd/sdcard: Introduce set_csd/set_cid handlers
>    hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD
> 
>   hw/sd/sdmmc-internal.h |   3 ++
>   include/hw/sd/sd.h     |   2 +
>   hw/core/machine.c      |   1 +
>   hw/sd/core.c           |  29 ++++++-----
>   hw/sd/sd.c             | 113 ++++++++++++++++++++++-------------------
>   5 files changed, 81 insertions(+), 67 deletions(-)
> 


Tested-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



