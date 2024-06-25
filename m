Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6290FC2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 15:55:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sM8VM-0004Yp-P1; Tue, 25 Jun 2024 11:54:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sM8VK-0004Yh-Vt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:54:46 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76] helo=mail.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=+2S4=N3=kaod.org=clg@ozlabs.org>)
 id 1sM8VI-00087J-IJ
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 11:54:46 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W7qCL4jXLz4w2M;
 Wed, 26 Jun 2024 01:54:38 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W7qCJ4g41z4w2K;
 Wed, 26 Jun 2024 01:54:36 +1000 (AEST)
Message-ID: <3942f344-7af2-43b9-8fe6-64e792519d7e@kaod.org>
Date: Tue, 25 Jun 2024 17:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/32] hw/sd: Add emmc_cmd_APP_CMD() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Lucien Murray-Pitts <lucienmp.qemu@gmail.com>
References: <20230703132509.2474225-1-clg@kaod.org>
 <20230703132509.2474225-19-clg@kaod.org>
 <1dd454c4-d7cd-4e8f-a824-e7743360b853@linaro.org>
 <4c336e09-910c-4452-becf-54f10718017f@kaod.org>
 <d2cb478d-d12e-4684-91d2-3e0d0d8265c5@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <d2cb478d-d12e-4684-91d2-3e0d0d8265c5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=150.107.74.76;
 envelope-from=SRS0=+2S4=N3=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/25/24 5:32 PM, Philippe Mathieu-Daudé wrote:
> On 25/6/24 17:13, Cédric Le Goater wrote:
>> On 6/25/24 5:04 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Cédric,
>>>
>>> On 3/7/23 15:24, Cédric Le Goater wrote:
>>>> Signed-off-by: Cédric Le Goater <clg@kaod.org>
>>>> ---
>>>>   hw/sd/sd.c | 6 ++++++
>>>>   1 file changed, 6 insertions(+)
>>>>
>>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>>> index 5ff132139ea9..95cb46b87519 100644
>>>> --- a/hw/sd/sd.c
>>>> +++ b/hw/sd/sd.c
>>>> @@ -2207,6 +2207,11 @@ static sd_rsp_type_t emmc_cmd_ALL_SEND_CID(SDState *sd, SDRequest req)
>>>>       return sd_r2_i;
>>>>   }
>>>> +static sd_rsp_type_t emmc_cmd_APP_CMD(SDState *sd, SDRequest req)
>>>> +{
>>>> +    return sd_r0;
>>>
>>> Why are you returning R0? This is invalid, only R1 can be
>>> returned by APP_CMD.
>>
>> Probably a typo. This is old ... 4/5 years at least.
> 
> Well, a smart typo, because it hides unimplemented features
> (and probably some bugs). Maybe someone clever used R0 on
> purpose :)

I can't tell. The initial patch [*] had :

@@ -1115,6 +1219,11 @@ static sd_rsp_type_t sd_normal_command(SDState *sd,
  
      /* Application specific commands (Class 8) */
      case 55:	/* CMD55:  APP_CMD */
+        /* Not supported by MMC */
+        if (sd->emmc) {
+            return sd_r0;
+        }
+

but it's 13 years old now.

Thanks,

C.


[*] https://lore.kernel.org/qemu-devel/1311635951-11047-5-git-send-email-vpalatin@chromium.org/


