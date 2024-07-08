Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D7FC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 20:30:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQuzq-0004ek-IE; Mon, 08 Jul 2024 16:30:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VcrY=OI=kaod.org=clg@ozlabs.org>)
 id 1sQuzp-0004ds-0r
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 16:30:01 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=VcrY=OI=kaod.org=clg@ozlabs.org>)
 id 1sQuzn-0006m1-13
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 16:30:00 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WHwhn2r6hz4xQN;
 Tue,  9 Jul 2024 06:29:45 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WHwhk5jsWz4w2M;
 Tue,  9 Jul 2024 06:29:42 +1000 (AEST)
Message-ID: <d48b6357-c839-4971-aa28-bdbd5b1bab53@kaod.org>
Date: Mon, 8 Jul 2024 22:29:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v42 96/98] hw/sd/sdcard: Support boot area in emmc
 image
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-97-philmd@linaro.org>
 <152d9c90-3e58-4706-b12a-6d2796681d0f@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <152d9c90-3e58-4706-b12a-6d2796681d0f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=VcrY=OI=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 7/8/24 6:58 PM, Philippe Mathieu-Daudé wrote:
> Hi Joel, Cédric,
> 
> On 28/6/24 09:02, Philippe Mathieu-Daudé wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> This assumes a specially constructed image:
>>
>>    dd if=/dev/zero of=mmc-bootarea.img count=2 bs=1M
>>    dd if=u-boot-spl.bin of=mmc-bootarea.img conv=notrunc
>>    dd if=u-boot.bin of=mmc-bootarea.img conv=notrunc count=64 bs=1K
>>    cat mmc-bootarea.img obmc-phosphor-image.wic > mmc.img
> 
> I'm not keen on imposing that layout to use the model (besides
> so far we use 1MiB as constant). I'd rather use 3 BlockBackends
> for eMMC (boot[01], user). This would scale for multiple sizes.

This is the same device with multiple partitions. Why would you
want to have 3 backends ? The sizes are defined in an EXT_CSD
register AFAIR.

  
>>    truncate --size 16GB mmc.img
>>    truncate --size 128MB mmc-bootarea.img
>>
>> For now this still requires a mtd image to load the SPL:
>>
>>    qemu-system-arm -M tacoma-bmc -nographic \
>>     -global driver=sd-card,property=emmc,value=true \
>>     -drive file=mmc.img,if=sd,index=2 \
>>     -drive file=mmc-bootarea.img,if=mtd,format=raw
> 
> (AFAICT we don't need that mtd anymore, correct?)

we don't.

Thanks,

C.



> 
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/sd/sd.h |  1 +
>>   hw/sd/sd.c         | 39 +++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 40 insertions(+)
> 


