Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E5C3F43699
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 12:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDi3R-0007c2-0R; Fri, 17 Apr 2026 08:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi3B-0007b5-VH
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:11:59 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDi39-00082d-Um
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 08:11:57 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43cf8d550bdso598569f8f.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 05:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776427912; x=1777032712; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DjTzZb6kIivx8dL+r7coKGYIBTGCecSaPSQSzCs2fc0=;
 b=lDrF1bFFVN1eNuihD01u+I1IoDlDuLOPLFsfdNn7kkUvxBvhoWqQZ1plpdRFis4Kbq
 QhVHIcqr8NbxYc6eAVbEUPt6ciFcFqTCLHB8HYRZTpE7QPLPSKi90YmAqeBJUmYTtrxS
 Cmi7KSYItSpriIbGLfzaFBvPlWuqHl4GwpazPKA6XZWsTHeUVBHQovKQgO7Xb34L3pap
 71Vpd4ih8fiFEN3TMMll3SfNmOfnOFzXP2jcLE+wYhBxUSdBJ4iVbDasYezAkZugBBW0
 yuwQ974lzou932nAiascLn42IMv6fdavTZfL8idhTRJ1pBOj1jLMMxYLKODevc5VW3mb
 mQbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776427912; x=1777032712;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DjTzZb6kIivx8dL+r7coKGYIBTGCecSaPSQSzCs2fc0=;
 b=D6eXHPzvuw5n6wpyHuJajaV/oXbE65zL900bNXY1TqzXQF3R9aPC6pEDlA59G15LBN
 bffslv1vQgSGp2K242b5K424saEwviNGdrrUUmTQ0DIs8TxfqIr6g0PTGLh1dB4bn2IC
 R6aLt1oKIOooNVJ0eIfSWWVEqdtqtJoNmtz8dVrSb4l2ZJsVzhoaS3i6wZt9eeskNLEj
 Ib1HZVxeVwDn9BFJ7Qs3Bw8snnMUZDt/mv/izrFuhHN8P/7g9G39jeLXGugG1GKxnStz
 nx0uM4cjQbGxWN9UL4j/p9iYkto0dNbNDhpPYIERsrQBw2XgEY+LOzMvdHJUU0FWobvw
 Rx/A==
X-Forwarded-Encrypted: i=1;
 AFNElJ90UDNvq5EbPwGkVGVw5G3Se7TzXi09+LW+wkghHXCI+vb726kCRQRYv6fU5xQnJbYyLgdpYB9VIFo/@nongnu.org
X-Gm-Message-State: AOJu0YwCLnH2bqbLXXuuaq03nS/unMwmTkw7c0BpAaIar2pi26epS49H
 XbLEYORXJ+KYI2CHwAD+Hp7FXHa6mBPYP7mNJ96Njsq25RF/04C0WlG6j7cvkQAkhs0=
X-Gm-Gg: AeBDietPpTy7z4QvX73NMGEDsV7pnGoAEfqcyG8GvxcEeJgQIaWVaJ+aHnF7avFbIvS
 Wq5PmjhhG2ZDNKnC+lsHpL8PvwUzKSzLpCkY5/qHNV2koI/VUk54fSb5YvpicuDIi1qH4wSP88l
 efQbqMPYEDGsJ5BcCDwXz/wpqgpmRUBAQYEbjEVcrce0wLB7DkpJpjEPvx5oQdNuueKwpHr3e0n
 lGPLSigGSM8J4JU/YYYgV/6/K8crD5/p92zDzenE+1klK2BLLxbUlQ5YU+PKuxeNuqiUtiVVpeC
 ty7hY5bexZDBeLYjPD/SklpTRb89APxCAv7Koyj3Xov5itu/HfhIqgE2CxGgDt9OMs+dJs/CwuX
 ncN04Vr5dZXO4xKMRL/gdgGO1xY8J2OHatZtziGQUBkKQZcQ2g3l+MRpK6rIyhmY5KmjJT/PQnq
 aG5Yyja5IgkjnAqbBwslAagvMXtXi0k/JSHEUNH8QN8ZWEVEnPdgTnVgpObOVYu7FNhDc/WQ7iQ
 eC5
X-Received: by 2002:a05:6000:2c0c:b0:43f:e22e:e8da with SMTP id
 ffacd0b85a97d-43fe3dc5b0bmr3844339f8f.5.1776427912178; 
 Fri, 17 Apr 2026 05:11:52 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e3a341sm4455481f8f.24.2026.04.17.05.11.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 05:11:51 -0700 (PDT)
Message-ID: <73f62ca9-0960-42c2-b0ca-3699eca2e223@linaro.org>
Date: Fri, 17 Apr 2026 14:11:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] hw/sd/sdcard: Add erase-blocks-as-zero option.
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Christian Speich <c.speich@avm.de>, qemu-devel@nongnu.org
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260417-sdcard-performance-b4-v4-0-119e66be10c2@avm.de>
 <20260417-sdcard-performance-b4-v4-5-119e66be10c2@avm.de>
 <2bdfa874-468b-4f59-b0c8-a7f51fc9d5d9@linaro.org>
 <b57f0f08-d725-425f-bd5f-7d127f6fa83f@linaro.org>
In-Reply-To: <b57f0f08-d725-425f-bd5f-7d127f6fa83f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 17/4/26 14:09, Philippe Mathieu-Daudé wrote:
> On 17/4/26 14:06, Philippe Mathieu-Daudé wrote:
>> On 17/4/26 11:51, Christian Speich wrote:
>>> Currently, erased blocks are filled with 0xFF. However SCR Bit 55
>>> (DATA_STAT_AFTER_ERASE) indicates that an erase produces zeros. One of
>>> them is wrong.
>>>
>>> This patch does two things.
>>>
>>> First it fixes the reporting of DATA_STAT_AFTER_ERASE in SCR to
>>> correctly reflect the content of erased blocks. We also increase the
>>> Product Revision (REV in CID) to indicate to the guest that
>>> DATA_STAT_AFTER_ERASE is now reliable.
>>>
>>> Secondly, we introduce a erase-blocks-as-zero option, which allows the
>>> user to choose if erased blocks should contain 0xFF or 0x00. The default
>>> is still 0xFF to remain compatible with current users.
>>
>> I'll update as:
>>
>>    Secondly, we introduce a erase-blocks-as-zero option, which allows the
>>    user to choose if erased blocks should contain 0xFF or 0x00. While
>>    previous QEMU versions keep using the 'erase as 0xFF' pattern, the new
>>    default becomes the more efficient 'erase as 0x00'.
>>
>> Does it look OK to you?
>>
>>> Signed-off-by: Christian Speich <c.speich@avm.de>
>>> ---
>>>   hw/core/machine.c |  5 +++++
>>>   hw/sd/sd.c        | 15 +++++++++++++--
>>>   2 files changed, 18 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>> index 
>>> 0aa77a57e956693208d77fea6af5853ed4904234..54e4c05c96e3cf35ab2e702ee81fba36457cadd7 100644
>>> --- a/hw/core/machine.c
>>> +++ b/hw/core/machine.c
>>> @@ -38,6 +38,11 @@
>>>   #include "hw/acpi/generic_event_device.h"
>>>   #include "qemu/audio.h"
>>> +GlobalProperty hw_compat_11_0[] = {
>>> +    { "sdmmc-common", "erase-blocks-as-zero", "false" },
>>> +};
>>> +const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>> +
>>>   GlobalProperty hw_compat_10_2[] = {
>>>       { "scsi-block", "migrate-pr", "off" },
>>>       { "isa-cirrus-vga", "global-vmstate", "true" },
>>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>>> index 
>>> b27fed2e563e5971dd32787498eb8abed9ffe9be..0f997ed8cc80e38645101cb8f47c86f1c30d5a25 100644
>>> --- a/hw/sd/sd.c
>>> +++ b/hw/sd/sd.c
>>
>>> @@ -3287,6 +3296,8 @@ static void emmc_realize(DeviceState *dev, 
>>> Error **errp)
>>>   static const Property sdmmc_common_properties[] = {
>>>       DEFINE_PROP_DRIVE("drive", SDState, blk),
>>> +    DEFINE_PROP_BOOL("erase-blocks-as-zero", SDState, 
>>> erase_blocks_as_zero,
>>> +                     true),
> 
> Although to maintain bisectability we should expose the property
> after the next patch -- the 0x00 implementation --.

Ah no, this is correct, this patch contains the memset() implementation,
and the following patch *optimize* :)

> 
>>>   };
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
> 


