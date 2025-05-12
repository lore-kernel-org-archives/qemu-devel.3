Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A61BC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 14:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEUBH-000152-J1; Mon, 12 May 2025 10:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEUAp-0000xY-8U
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:30:39 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uEUAn-0007Fo-0M
 for qemu-devel@nongnu.org; Mon, 12 May 2025 10:30:30 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so33443805e9.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 07:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747060227; x=1747665027; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CDHbfwwtGpejayhTK/B+witrioDgKibkJjLcwoyOovw=;
 b=CWd36MaWnqDz3Nr7Z9uWBYLgyo+oUHcCXPC6mbWU3zG005lHD2CxBnk4bYHkLk1PEo
 ykvQx3TXzGs6mOfUDujPgoersbybqnk9A/xx/ZHx+oAqTz7kxNDS1q9cjjHL6KUJL2nV
 3QR6Zs6rcVn7XSrKTs3xlal8S0SgoA+LtYUP2yiQXaZmR+TMx1CApGVotEg8BzqwrPt+
 YBydhH4+IzHLMCXuLlyzFuF1I1czYtLB76t/TebTirE1VYtkEEIM5w3WWi1z3rxilwsL
 BzMHE7xdVWL7AdmewW8GybpcQCEXScKllHNJyy/tNALMhX3lt3t0au/Ao8/xgNq7ACTt
 RPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747060227; x=1747665027;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CDHbfwwtGpejayhTK/B+witrioDgKibkJjLcwoyOovw=;
 b=DLFZ2qbEtRO/yoKu/7O/xUXJVQkyfQqeyQjqSN0xMDpiK/L4dbBOcNye2a1KxotacU
 SQvGSWe7CNQ3Xo7ztQFAHK1texOYvjnratI4qlvIAjp1czs5zw3rDAkO3R8CbClGBXE6
 CoxZOhlc74RxBkU33eEpS3TVYcnno0tzi1h6NtHCeYdaSyJSeUlIc9Nyo47x177264xe
 35J9Yvec/uvxjDoyHC3AI+p0gj2XlaZE1Ia4biYz5GNV9OroTX/BEPsnYTe5tt5KsUcX
 Q05RtGR8SYkJ/kBMxZG7lDTaHsaRwsIAQElKhnFoNCc1shTMb97FaIxdilK2DL4yY417
 TzCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr02lAMvky742w+NfMIxPqrxUyk10eqJU9Xp5F4FfVsscjTuefQQ9WQLgL7mgwy1Q3BnfI5846Ik9v@nongnu.org
X-Gm-Message-State: AOJu0YysH7sFEFze5K8+6xmQL33KJaeyiQax/I7tbcwr0i0Vt7Omtjra
 +0NDtmXwMZWXRq+ckhBY6KbiiAG2VGztO/ikF4+Wg+B7xr3rT3eSTPpEdvFPCVw=
X-Gm-Gg: ASbGncvPdHZsSfDsVWo8hupnXaaOR1YV0iA9QsBYwWNu5dGocjlIvz+efQNirGyh+KU
 BE/Ex2bdz1QRV4rC0zD0DSEonay78MCq5JZCAuqxx+JxacamM10i1wvSRobjBfNP1V3EWPuqmjD
 vIBCNYRzEZb9GgbDAH4T5IKzjPnt0+te06yJ5JNdrf11Xi1AQnI+TKMThTOxXnPqdav+QilK9bo
 ZHa7buElWmCjE5xZyoTeFMFQdBG6XG2UqsgbEmfw6VW7jJutKlX+rmoKqqVpB71+yyvFelZtZ7y
 R5Gki0XR5e8GZa4DlfYOWOh+KgeXjrqFnoPtamBXQBqAL6NYiv6gMGBCnMor/cyO5EN6EZfcUkZ
 A0mDYHOS16Sq4
X-Google-Smtp-Source: AGHT+IHqRHuEatPpsig+0Kkb9NO1jFZ2T+6yNEceFOw1Im00QeohPMfL8klzV47ONBJO+ZIhMpmhmA==
X-Received: by 2002:a05:600c:1da8:b0:43c:fb95:c76f with SMTP id
 5b1f17b1804b1-442d6d1f997mr127420355e9.9.1747060226768; 
 Mon, 12 May 2025 07:30:26 -0700 (PDT)
Received: from [10.93.5.179] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d77af6f9sm58264085e9.1.2025.05.12.07.30.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 07:30:26 -0700 (PDT)
Message-ID: <5cb82793-0e22-42e7-bfef-7f374c9b6dab@linaro.org>
Date: Mon, 12 May 2025 15:30:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, thuth@redhat.com
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, peter.maydell@linaro.org
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
 <3b7f61dc-8708-459c-b48b-db955ad462bf@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <3b7f61dc-8708-459c-b48b-db955ad462bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=gustavo.romero@linaro.org; helo=mail-wm1-x333.google.com
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

Hi Phil,

On 5/12/25 11:15, Philippe Mathieu-Daudé wrote:
> On 12/5/25 14:36, Gustavo Romero wrote:
>> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
>> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
>> native controller and does not support ACPI-based hotplugging. However,
>> since support is planned, this test sets 'acpi=force' and specifies an
>> EDK2 firmware image in advance. This is harmless and prepares for future
>> ACPI support.
>>
>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>> ---
>>   MAINTAINERS                                  |  5 ++
>>   tests/functional/meson.build                 |  1 +
>>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>>   3 files changed, 79 insertions(+)
>>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 23174b4ca7..9ebb768214 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2065,6 +2065,11 @@ S: Supported
>>   F: include/hw/pci/pcie_doe.h
>>   F: hw/pci/pcie_doe.c
>> +ARM PCI Hotplug
>> +M: Gustavo Romero <gustavo.romero@linaro.org>
> 
> Cc: qemu-arm@?

Thanks, cc:ed it in v3.


Cheers,
Gustavo

