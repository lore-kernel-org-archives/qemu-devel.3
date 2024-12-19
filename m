Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4F9E77184
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2024 17:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOK5B-0000xW-WD; Thu, 19 Dec 2024 12:13:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK5A-0000x4-6d
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:13:04 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tOK58-0005vE-8u
 for qemu-devel@nongnu.org; Thu, 19 Dec 2024 12:13:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4362f61757fso10361455e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Dec 2024 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734628380; x=1735233180; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7YnkzAmkFqmtL76VFTwPDLfPwbxrJEkP8qWxk4gpa7k=;
 b=lDLvXAsb7xA7OFl+oBj560aNizuxNIVpPV6wC//64koEiRY5DXalkbb9BLpwY5SfjT
 E4bNSAVXZdbRyo8bhhRVnDq1oTRdPO7E8y2yPTegQokpXYnG0iEqH/K5gK4AOgnFsVKi
 Evop0rf+yeNglkuw8oA9/xLiOUi2UmaWpf+zZ78erEAUW3W4/J7NGzgIQkjId6BZVOMo
 n0Hz3yNV5vxywApG6BxdzRV1+1OCGTn8Ia/TZaaS2Ntu1aFlqXMMxcp1VTHRIqba3/tj
 azLYDmkOkH1fjxNk2DgVsJGCg7bFikx7YhWcB78bFGPNtVNgNMSu2vo+bnG1unk8nald
 6Rfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734628380; x=1735233180;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7YnkzAmkFqmtL76VFTwPDLfPwbxrJEkP8qWxk4gpa7k=;
 b=Unjue6rIRCDfj2vR7F0XUQ0HWJO94paJp5/vtHE/srt8KRely4E8xXkVP1DZLc7Xkr
 /SFCrpWQmJMIyJBkz3Ot23rr/uDprD4AT4yCQ5bnSk0N6XsG45mynPw/UeNtBi5VamKm
 beQLd0uhQT++9yuUrX5KNN9uoe3VuYxlAPZRF1g6OqeEF9rWVDrnCnv6+H9uLdZEM04q
 H+SwmQd3SNkAc7NFVDq5eHMO9EYz1wSGOnP8jkWLlKH1IB1sviX+aWyWBqjq3iOfXuAU
 KArR6XqZVDY2sWJsmYwd8anSAk/g7POD/+CXSezZI21EkDH44vIn/K/wH92f+nR++Z8c
 wvhg==
X-Gm-Message-State: AOJu0YyRDK6pYaZL7WRV1g7mqMldBwWD9LIQoyLZ01eqwOFzIfsJlRu8
 PomEI30iic5OD61h0ZoNqEvGgf3LC4dUuIPYvKDhAPp7oikrUubNcgn2zt6NS8w=
X-Gm-Gg: ASbGncsSobzSv183CeBh+1qLFT+j4ZD7+vaUhg+WI94VJvmCuk9Qw9r1E+N8sSVZvXr
 Zvms+XgeGqYIGLfiEyGvROegd/dNeq+/hXdkKDjG09rmidbyi4qeoicl5yWfQjHlfXQDRAevr/7
 h1QNDDbKGff7E68O6A0+eFWGieBSNcxDxh/h9WnBO783er+3eeB21fWan5dejk5DQqynwWPyfc4
 KfdCo3fT/FhYmPGdZVDVzdokOnkH+XrEQ2V4GDZZ6ptO3dpueNK27BcBHKIpSojN/4KAe4=
X-Google-Smtp-Source: AGHT+IEIhyK1QK5CFphG/lkbDLN21OBtGZCR4mwbMEGcbom1hdS/j6+uf9oIGKvAUWf3sL6YRHvOGQ==
X-Received: by 2002:a05:6000:79a:b0:385:ef39:6cf7 with SMTP id
 ffacd0b85a97d-388e4d647fcmr7009220f8f.32.1734628380350; 
 Thu, 19 Dec 2024 09:13:00 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c828ba0sm1973239f8f.14.2024.12.19.09.12.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Dec 2024 09:12:59 -0800 (PST)
Message-ID: <71deed14-7ad7-4927-8594-545ef350a2ab@linaro.org>
Date: Thu, 19 Dec 2024 18:12:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 04/10] hw/misc/vmcoreinfo: Rename VMCOREINFO_DEVICE ->
 TYPE_VMCOREINFO_DEVICE
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
References: <20241219153857.57450-1-philmd@linaro.org>
 <20241219153857.57450-5-philmd@linaro.org> <Z2RRARwT282Rj0aN@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <Z2RRARwT282Rj0aN@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 19/12/24 17:59, Daniel P. Berrangé wrote:
> On Thu, Dec 19, 2024 at 04:38:51PM +0100, Philippe Mathieu-Daudé wrote:
>> Follow the assumed QOM type definition style, prefixing with 'TYPE_'.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   include/hw/misc/vmcoreinfo.h | 6 +++---
>>   hw/misc/vmcoreinfo.c         | 8 ++++----
>>   2 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/include/hw/misc/vmcoreinfo.h b/include/hw/misc/vmcoreinfo.h
>> index da1066d540c..122c69686b0 100644
>> --- a/include/hw/misc/vmcoreinfo.h
>> +++ b/include/hw/misc/vmcoreinfo.h
>> @@ -16,10 +16,10 @@
>>   #include "standard-headers/linux/qemu_fw_cfg.h"
>>   #include "qom/object.h"
>>   
>> -#define VMCOREINFO_DEVICE "vmcoreinfo"
>> +#define TYPE_VMCOREINFO_DEVICE "vmcoreinfo"
> 
> Yes to adding TYPE_, but while there would also
> drop _DEVICE.  IMHO the best practice is for
> TYPE_<NNNN> where NNNN matches the "nnnn" name.
> An extra suffix doesn't add value, unless we've
> got some other symbol clashing which is almost
> never the case.

Yeah, I added the _DEVICE suffix in preparation of the
plain object implementation.

> 
>>   typedef struct VMCoreInfoState VMCoreInfoState;
>> -DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO,
>> -                         VMCOREINFO_DEVICE)
>> +DECLARE_INSTANCE_CHECKER(VMCoreInfoState, VMCOREINFO_DEVICE,
>> +                         TYPE_VMCOREINFO_DEVICE)
>>   
>>   typedef struct fw_cfg_vmcoreinfo FWCfgVMCoreInfo;
>>   
>> diff --git a/hw/misc/vmcoreinfo.c b/hw/misc/vmcoreinfo.c
>> index c5bb5c9fa52..9822615cfed 100644
>> --- a/hw/misc/vmcoreinfo.c
>> +++ b/hw/misc/vmcoreinfo.c
>> @@ -37,7 +37,7 @@ static void vmcoreinfo_reset(void *opaque)
>>   
>>   static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>>   {
>> -    VMCoreInfoState *s = VMCOREINFO(dev);
>> +    VMCoreInfoState *s = VMCOREINFO_DEVICE(dev);
>>       FWCfgState *fw_cfg = fw_cfg_find();
>>       /* for gdb script dump-guest-memory.py */
>>       static VMCoreInfoState * volatile vmcoreinfo_state G_GNUC_UNUSED;
>> @@ -48,13 +48,13 @@ static void vmcoreinfo_realize(DeviceState *dev, Error **errp)
>>        */
>>       if (!vmcoreinfo_find()) {
>>           error_setg(errp, "at most one %s instance is permitted",
>> -                   VMCOREINFO_DEVICE);
>> +                   TYPE_VMCOREINFO_DEVICE);
>>           return;
>>       }
>>   
>>       if (!fw_cfg || !fw_cfg->dma_enabled) {
>>           error_setg(errp, "%s device requires fw_cfg with DMA",
>> -                   VMCOREINFO_DEVICE);
>> +                   TYPE_VMCOREINFO_DEVICE);
>>           return;
>>       }
>>   
>> @@ -96,7 +96,7 @@ static void vmcoreinfo_device_class_init(ObjectClass *klass, void *data)
>>   
>>   static const TypeInfo vmcoreinfo_types[] = {
>>       {
>> -        .name           = VMCOREINFO_DEVICE,
>> +        .name           = TYPE_VMCOREINFO_DEVICE,
>>           .parent         = TYPE_DEVICE,
>>           .instance_size  = sizeof(VMCoreInfoState),
>>           .class_init     = vmcoreinfo_device_class_init,
>> -- 
>> 2.47.1
>>
> 
> With regards,
> Daniel


