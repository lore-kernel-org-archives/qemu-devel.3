Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A295BC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEVyf-0001vi-8O; Tue, 04 Jun 2024 11:21:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEVye-0001uM-Cu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:21:32 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=OW7X=NG=kaod.org=clg@ozlabs.org>)
 id 1sEVyc-0005Ku-EM
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:21:32 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4VtvSj5gm3z4x2f;
 Wed,  5 Jun 2024 01:21:25 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4VtvSg1qflz4x1T;
 Wed,  5 Jun 2024 01:21:22 +1000 (AEST)
Message-ID: <83ea5768-fbec-457e-954f-bfad462b1916@kaod.org>
Date: Tue, 4 Jun 2024 17:21:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/32] hw/sd: Subtract bootarea size from blk
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-25-clg@kaod.org>
 <29f32aca-74d0-4562-bffa-4573124812bf@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <29f32aca-74d0-4562-bffa-4573124812bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=OW7X=NG=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
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

On 6/3/24 14:31, Philippe Mathieu-Daudé wrote:
> On 3/7/23 15:25, Cédric Le Goater wrote:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The userdata size is derived from the file the user passes on the
>> command line, but we must take into account the boot areas.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>> ---
>>   hw/sd/sd.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 6da17a8d0972..1df7c7ac9dae 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -674,6 +674,7 @@ static unsigned sd_boot_capacity_bytes(SDState *sd)
>>   static void sd_reset(DeviceState *dev)
>>   {
>>       SDState *sd = SD_CARD(dev);
>> +    SDCardClass *sc = SD_CARD_GET_CLASS(sd);
>>       uint64_t size;
>>       uint64_t sect;
>> @@ -685,6 +686,10 @@ static void sd_reset(DeviceState *dev)
>>       }
>>       size = sect << 9;
>> +    if (sc->bootpart_offset) {
>> +        size -= sd_boot_capacity_bytes(sd) * 2;
> 
> IMO this patch and sd_boot_capacity_bytes() definition
> from previous patch should be squashed in patch 22 where
> you add emmc_cmd_SEND_EXT_CSD.

OK. I will check.

Have you looked at the other patches ?

Thanks,

C.


> 
>> +    }
>> +
>>       sect = sd_addr_to_wpnum(size) + 1;
>>       sd->state = sd_idle_state;
> 


