Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3CC54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 21:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkWGX-00048g-Ti; Wed, 13 Mar 2024 17:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWGE-0003Vk-Vq
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:35:46 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rkWGA-0008AJ-7y
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 17:35:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4132f37e170so1838925e9.2
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 14:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710365733; x=1710970533; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=svjCTisGiEuMKVELvljXjDjtc3jjQSsctIP4+v6peTM=;
 b=HQ97rcIynizEnuZIfWaMqIRy0gvI/8+4tZbwQ+LPTBADnnOkUgWHwVxi5UPHT/Hui8
 2wB32GERwuA6AhAXVgnGCyBlPkZMwv7d8OLYH9z/+GyZVRHOhubH+m4om7U8ta2ml2UW
 cHY/8d8SIZFDxERj9VcDtvwmhCPDwTkmTSbJf/GIq9c9G+lUhmB8labsa91kSsYkTq7B
 AQPbUrHie0+olobmTvjHrA3ZOvt1+xAXIyLGbPGv1Rw7lLKubfUc4ovinGS+8il47XoZ
 eT/2RPF5vG+WM8zlV68GySG6OZOyiku9oiKjKF6JnqNY0SblwfoMfKB550wVpugs//IP
 4K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710365733; x=1710970533;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=svjCTisGiEuMKVELvljXjDjtc3jjQSsctIP4+v6peTM=;
 b=l8i/HwQJH/5sPR4o8t6gmS/2acUSv3ggJutCJHiQTZj1cCus66rSsAHfz+nlYNhMS+
 0bQCF6adTmHyKH+OVJykVMRl3CSZldKIEZS+eHOBRaPZFZ2tE9F0bq6IWWrBnYerRLfZ
 YxT+VmoxRhc7HaWNsCNTYJSxYKs6rbP6njbRoQKjXBbIaGx8MlHZcC5vwt6iiE+HTj/J
 lWiurq0dJZfF3/QQB972aIkmK0rHuni5e695O4FhJX6bpnvR1V1hCtzZNBz2+LfR1xv6
 QnpBkczRYj8dcXF27HNfRKqu/V1xqKwyBY2tZvVlpKBIITQrLbldUaj3Ms0D7ay5A3FS
 YMOw==
X-Gm-Message-State: AOJu0YwY7MyMp7lZLcZT+X4nSg41PFnos5XAfPjStU5NUVA7PlcTzZC6
 GPybP18KkVqMXH0EvgTyiQzMbNZEDD+1R1tty5VnbORh2R2dVmlM2IeI5kdCTO8=
X-Google-Smtp-Source: AGHT+IFpCMLCYisN59FS3Ync3UNdTrQjwaXcs9KCm1fdojdS48G4pjvCSpGMbs0hiNTAC/UgcC0eWA==
X-Received: by 2002:a05:600c:4e02:b0:413:ef80:58d5 with SMTP id
 b2-20020a05600c4e0200b00413ef8058d5mr51440wmq.0.1710365733178; 
 Wed, 13 Mar 2024 14:35:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.182.179])
 by smtp.gmail.com with ESMTPSA id
 r17-20020a05600c459100b00413429bfab0sm3467769wmo.16.2024.03.13.14.35.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 14:35:32 -0700 (PDT)
Message-ID: <43b500a3-e2c8-42b3-827b-1c74011dd99b@linaro.org>
Date: Wed, 13 Mar 2024 22:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 3/4] qtest/libqos: Un-inline size_to_prdtl()
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, John Snow <jsnow@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Eric Auger <eric.auger@redhat.com>,
 qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20240313184954.42513-1-philmd@linaro.org>
 <20240313184954.42513-4-philmd@linaro.org>
 <CAFEAcA9ZtyRG5G=vLXNJdA3RPKsvLGh-v8MO2tq1mC3ch5_asw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA9ZtyRG5G=vLXNJdA3RPKsvLGh-v8MO2tq1mC3ch5_asw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13/3/24 20:39, Peter Maydell wrote:
> On Wed, 13 Mar 2024 at 18:50, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> See previous commit and commit 9de9fa5cf2 ("Avoid using inlined
>> functions with external linkage") for rationale.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/qtest/libqos/ahci.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
>> index a2c94c6e06..135b23ffd9 100644
>> --- a/tests/qtest/libqos/ahci.c
>> +++ b/tests/qtest/libqos/ahci.c
>> @@ -662,7 +662,7 @@ unsigned ahci_pick_cmd(AHCIQState *ahci, uint8_t port)
>>       g_assert_not_reached();
>>   }
>>
>> -inline unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
>> +unsigned size_to_prdtl(unsigned bytes, unsigned bytes_per_prd)
>>   {
>>       /* Each PRD can describe up to 4MiB */
>>       g_assert_cmphex(bytes_per_prd, <=, 4096 * 1024);
> 
> It looks like this function is only used in this file, so
> we could make it static ?

Eh I did check for that, but sure how I missed it...


