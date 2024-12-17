Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AB2E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 13:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNXtf-0000YI-Er; Tue, 17 Dec 2024 08:45:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNXtW-0000Xe-1M
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:45:50 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNXtU-00065k-BT
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 08:45:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434b3e32e9dso58007605e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 05:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734443146; x=1735047946; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=do9a+GsoK8fyYZPzjPqZjR9Y9T+197O23pdyi+E4q7E=;
 b=opNmQTC7QRZqz1JuQz4xCQdaz4lDB3yabKWsp4t1ThQdZPqeirAMv1xaZ4HsD4D3HN
 iPkMuw//6MInS6ccqN4QAmXYJxxPE/3QT4ML8qHEvyFGeX8hqcjcoOpwJTIe6908hg5A
 kH/rTX7wC/3KYLW7K9sUMPfNxY+1O+RtVyS1TEQjws5v1YSM/A1pPXmI2IhLZb4QJq8g
 Fi3qFLjA9Huc3Be41LUdPW+OC+mLo4loFVqJMsdEGhT9fO3tgVoRrP/eMcbtg5R0nm5B
 gWIcTcgbw4W+ET5gcPHO76gGXfYJ4uc40PZp9SIAzBUuXTvhCbqvQfwqFPUtWgh1l/4c
 fdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734443146; x=1735047946;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=do9a+GsoK8fyYZPzjPqZjR9Y9T+197O23pdyi+E4q7E=;
 b=t6/8BDy00QDAoSrrNj9ljA2qjBGA+ohnii7C4YQoDs66MfhCUmzJ/q48N23SwOW2RA
 DK88GC3IekYGvh7GD1XU6tRRbcW6h1xuRdF/Mb+S04rcAodAO3Eea9dlz0/BiBE/pba2
 H9LcPluvO/nMu8+m7+BGCLzskQtMJC7BuThiJ8hRT/3iD/ryh44i8qGwWWs7ZoAKvsBz
 +S5NkeCef7ZoClxqTD9CXdRVjEimYnISPIYgW9qdK9ZAcCMAu4Q29ut4cDhm/086Fhsj
 Dv5w4j9ut5YdUpkmxhjTASDH0kZkZ3E+Lo8ytA85b0FXdTyn99DExU9QWaaM9eTJ8Ob1
 hJvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSW93tLYbJ9MaTl0Jqbp6PFcPAuiMNV1NkrD+QWQ8ESjODXcum11OZzds97/Olt/yyvS/XbGa2Rn6W@nongnu.org
X-Gm-Message-State: AOJu0YwV+UEjDqj3NdUhY0S2DSPntzxz8+oLLqjze9QpFFIEkW8C74xY
 ozgnRMvBKxrMDNNdZ0pagH1FzqCQl9JEf0q35zBN7ZDlkBLfOwdK2WyCH1OrxhE=
X-Gm-Gg: ASbGncvjgsPSWWLXm2loPJkVMEsiqKSdaVLGkm62ubTvC4aJgwizzaytV4sW0//N4AV
 lEun9PkrSJGey9ghV6Y7C+BTq/hERZj3qdSVSVUzrqJJ6gV43FRVURddDu/KyT6ejkwt/0hhvOi
 9ORo/4YwnzJOpeYiVefFNU5Do4iS0KdrbvfQ3PAag7E79zKOLnSwmQlAN4X2yEJGIXCdWoa72YJ
 /mmOkCPLDL2FMx4D+cseS95pfxp+TsDd3wxcGdKfkkKenxuxRA5H7y6EBa8kFAeX3bfIh0O
X-Google-Smtp-Source: AGHT+IErONB06oDQw+OW61g+ZSdGOxbhHavS4H42eeUXsV9NMojxvTOgJJPcMe80ni7TivzTHQ9DGg==
X-Received: by 2002:a05:600c:83cf:b0:434:edcf:7474 with SMTP id
 5b1f17b1804b1-4362aaa1ee4mr135626515e9.33.1734443146600; 
 Tue, 17 Dec 2024 05:45:46 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362559ebe1sm172971525e9.19.2024.12.17.05.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Dec 2024 05:45:46 -0800 (PST)
Message-ID: <2cc30514-15a8-4765-8463-8d14ad270e51@linaro.org>
Date: Tue, 17 Dec 2024 14:45:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>
Cc: Alexander Graf <graf@amazon.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20241216114841.1025070-1-anisinha@redhat.com>
 <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
 <E18F7A48-BA4D-46B3-BD73-38322BF33CEC@redhat.com>
 <0d6d208a-00ee-47c9-8d47-bb5758133ecb@linaro.org>
 <FE6D8668-84D4-457E-994A-8066D52AD9B5@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <FE6D8668-84D4-457E-994A-8066D52AD9B5@redhat.com>
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

On 17/12/24 12:09, Ani Sinha wrote:
> 
> 
>> On 17 Dec 2024, at 4:11 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> On 17/12/24 11:06, Ani Sinha wrote:
>>>> On 16 Dec 2024, at 8:35 PM, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>>>
>>>> Hi Ani,


>>>>> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
>>>>> +{
>>>>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>>>>> +
>>>>> +    /* we are not interested in migration - so no need to populate dc->vmsd */
>>>>> +    dc->desc = "VM firmware blob update device";
>>>>> +    dc->realize = vmfwupdate_realize;
>>>>> +    dc->hotpluggable = false;
>>>>> +    device_class_set_props(dc, vmfwupdate_properties);
>>>>> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);
>>>>
>>>> How is this device instantiated?
>>> Something like this:
>>> $ ./qemu-system-x86_64 -device vmfwupdate
>>> VNC server running on ::1:5900
>>
>> But this device is not marked as allowed to be created on the
>> command line with:
>>
>>     dc->user_creatable = true;
>>
>> Am I missing something?
> 
> Isnt’ it true by default? See device_class_init(). Only when it’s a private device we need to set it explicitly to false.
> 
> Let me know if its me who is missing something :-)

Indeed, you are correct! I forgot about that default.

