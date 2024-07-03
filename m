Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10AD8C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 08:08:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOv2P-0000T9-MM; Wed, 03 Jul 2024 04:08:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOv2I-0000RU-2h
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:08:18 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOv2E-0000EE-Tx
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 04:08:17 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ebe40673d8so67262721fa.3
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2024 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719994091; x=1720598891; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZ5/GucKocm/XaMEXaXI1aflj8uY+sC07wFmVZfv8lk=;
 b=hBw0FodxqI47AhGnukjAW7bYslbE4HK6gumq13YzYvU9B9U5//pcU0TDolXQxx2xEu
 DDcOgg8ge3o5qPVW3/n55UlxQjEe2HX0fmBvLCkylfJorhIJ6EktPEPAY6Q0b5LFGDc6
 //a87jE44RFI4ridlW8BGgz+epwns/Z/xWuQQ/OQcGE6eVJgTJAjD0IpMIYDnkh+MVoE
 it0GVMY6sQ2x0rjoQVbfOiTsseVcrIIpdUaKLoY8lsp8cBXYey5+X5ZFfeRtwXpbNMt1
 ahv7g0gtCrRv4Xxrnv1YiPhd1nGOSThH11N+qVpS+rC8+6zYw00i+lKou8seTZ9Avnky
 KzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719994091; x=1720598891;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cZ5/GucKocm/XaMEXaXI1aflj8uY+sC07wFmVZfv8lk=;
 b=bV3eCxf06iqOxeq1edEL6lvFElSwTJnVoLOquP+JgQ/Njx3ScODC3YvjZwFAS2Qrm/
 Rd5uROS+c3wxrU7zb+9JtCBCpKD6U2bU/Dh3VsWxwcM4uFXmVEMXsm9gihzFcF2WOMJK
 PuVJ1g1uIUlrAteRYGLj8GvfEiau2cDENUMMyDEmV008QamqOz5fc60Ai78Z2gFERiay
 zgij6yGPpGxA164wnGuM07AtA6omoggMeKbNmNMUufmtlfUY2hf6xNVC1tcPEO9GE/8l
 YmNlvyn65sOXfpJBYyZlrK4bvz9RXNJcCYwTwS2RpCazn7X2UpoLZWvHJQGMMSDKzs/P
 7j8A==
X-Gm-Message-State: AOJu0YwUlWuImuHUYeKkZhX+fOb1RpCbumnrlYGTPTMHquweRuwGqOWN
 DKVigTcWClJuGSTBLSaIN+LPAJYOq8oo5BIDhE/NkQvPesWrmeblS9c1VIVt3B0=
X-Google-Smtp-Source: AGHT+IHlgnPC/2KpSXD8wCEEO7Bcm3ks+VB4TnPhsCDC6B85GWaecT2VpkDZLdm4O58WXZup6caF7g==
X-Received: by 2002:a2e:7e0b:0:b0:2ee:80e0:b9f5 with SMTP id
 38308e7fff4ca-2ee80e0bf4emr6340921fa.42.1719994089100; 
 Wed, 03 Jul 2024 01:08:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.220.97])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42581bd5e4bsm122169485e9.10.2024.07.03.01.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jul 2024 01:08:08 -0700 (PDT)
Message-ID: <4ee9fdea-369b-4aaf-a31b-249beaa58a6a@linaro.org>
Date: Wed, 3 Jul 2024 10:08:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v43 2/2] hw/sd/sdcard: Do not store vendor data on block
 drive (CMD56)
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, qemu-block@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240702161031.59362-1-philmd@linaro.org>
 <20240702161031.59362-3-philmd@linaro.org>
 <ZoUAREvcNtlgpK3r@XFR-LUMICHEL-L2.amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZoUAREvcNtlgpK3r@XFR-LUMICHEL-L2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 3/7/24 09:39, Luc Michel wrote:
> On 18:10 Tue 02 Jul     , Philippe Mathieu-Daudé wrote:
>> "General command" (GEN_CMD, CMD56) is described as:
>>
>>    GEN_CMD is the same as the single block read or write
>>    commands (CMD24 or CMD17). The difference is that [...]
>>    the data block is not a memory payload data but has a
>>    vendor specific format and meaning.
>>
>> Thus this block must not be stored overwriting data block
>> on underlying storage drive. Keep it in a dedicated
>> 'vendor_data[]' array.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Cédric Le Goater <clg@redhat.com>
>> ---
>> v43: Do not re-use VMSTATE_UNUSED_V (danpb)
>> ---
>>   hw/sd/sd.c | 16 +++++++++-------
>>   1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
>> index 808dc1cea6..418ccb14a4 100644
>> --- a/hw/sd/sd.c
>> +++ b/hw/sd/sd.c
>> @@ -153,6 +153,8 @@ struct SDState {
>>       uint32_t data_offset;
>>       size_t data_size;
>>       uint8_t data[512];
>> +    uint8_t vendor_data[512];
>> +
>>       qemu_irq readonly_cb;
>>       qemu_irq inserted_cb;
>>       QEMUTimer *ocr_power_timer;
>> @@ -719,6 +721,7 @@ static void sd_reset(DeviceState *dev)
>>       sd->wp_switch = sd->blk ? !blk_is_writable(sd->blk) : false;
>>       sd->wp_group_bits = sect;
>>       sd->wp_group_bmap = bitmap_new(sd->wp_group_bits);
>> +    memset(sd->vendor_data, 0xec, sizeof(sd->vendor_data));
>>       memset(sd->function_group, 0, sizeof(sd->function_group));
>>       sd->erase_start = INVALID_ADDRESS;
>>       sd->erase_end = INVALID_ADDRESS;
>> @@ -835,6 +838,7 @@ static const VMStateDescription sd_vmstate = {
>>           VMSTATE_UINT32(data_offset, SDState),
>>           VMSTATE_UINT8_ARRAY(data, SDState, 512),
>>           VMSTATE_UNUSED_V(1, 512),
>> +        VMSTATE_UINT8_ARRAY(vendor_data, SDState, 512),
> 
> Don't you need to bump the VMState version then?

Indeed. I'll add a subsection which is the recommended way:
https://www.qemu.org/docs/master/devel/migration/main.html#subsections

   The most common structure change is adding new data, e.g. when
   adding a newer form of device, or adding that state that you
   previously forgot to migrate. This is best solved using a subsection.

Thanks,

Phil.


