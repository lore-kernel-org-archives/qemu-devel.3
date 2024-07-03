Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0628C30653
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 14:09:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP0fH-0004dA-BP; Wed, 03 Jul 2024 10:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0ez-0004VE-Lj; Wed, 03 Jul 2024 10:08:39 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org>)
 id 1sP0ew-0000Kr-0e; Wed, 03 Jul 2024 10:08:35 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WDhT91tP0z4wc1;
 Thu,  4 Jul 2024 00:08:29 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WDhT55MJrz4wbr;
 Thu,  4 Jul 2024 00:08:25 +1000 (AEST)
Message-ID: <88c24a7f-276f-44ed-9651-9ba6143fb812@kaod.org>
Date: Wed, 3 Jul 2024 16:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 5/5] hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from
 TYPE_SD_CARD
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
 <20240703134356.85972-6-philmd@linaro.org>
 <ab8de479-fc85-4e00-8fac-c49dde0a03bc@kaod.org>
 <6a12f867-08f0-4abc-b25a-6c8e4b05c89f@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <6a12f867-08f0-4abc-b25a-6c8e4b05c89f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=dfZQ=OD=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/3/24 4:07 PM, Philippe Mathieu-Daudé wrote:
> On 3/7/24 16:02, Cédric Le Goater wrote:
>> On 7/3/24 3:43 PM, Philippe Mathieu-Daudé wrote:
>>> In order to keep eMMC model simpler to maintain,
>>> extract common properties and the common code from
>>> class_init to the (internal) TYPE_SDMMC_COMMON.
>>>
>>> Update the corresponding QOM cast macros.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   hw/sd/sdmmc-internal.h |  3 +++
>>>   hw/sd/core.c           | 29 ++++++++++++------------
>>>   hw/sd/sd.c             | 50 ++++++++++++++++++++++++++++--------------
>>>   3 files changed, 52 insertions(+), 30 deletions(-)
> 
> 
>>> @@ -2508,14 +2521,19 @@ static void sd_spi_class_init(ObjectClass *klass, void *data)
>>>   static const TypeInfo sd_types[] = {
>>>       {
>>> -        .name           = TYPE_SD_CARD,
>>> +        .name           = TYPE_SDMMC_COMMON,
>>>           .parent         = TYPE_DEVICE,
>>>           .instance_size  = sizeof(SDState),
>>>           .class_size     = sizeof(SDCardClass),
>>> -        .class_init     = sd_class_init,
>>> +        .class_init     = sdmmc_common_class_init,
>>>           .instance_init  = sd_instance_init,
>>>           .instance_finalize = sd_instance_finalize,
>>>       },
>>
>> Shouldn't it be an abstract class ?
> 
> Ah yes, safer. Squashing:
> 
> -- >8 --
> @@ -2513,6 +2513,7 @@ static const TypeInfo sd_types[] = {
>       {
>           .name           = TYPE_SDMMC_COMMON,
>           .parent         = TYPE_DEVICE,
> +        .abstract       = true,
>           .instance_size  = sizeof(SDState),
>           .class_size     = sizeof(SDCardClass),
>           .class_init     = sdmmc_common_class_init,


with that,

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.



