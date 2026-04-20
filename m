Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1894F5A8B8
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 20:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEvH5-0003c1-Ci; Mon, 20 Apr 2026 16:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEvH2-0003Z0-Ph
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:31:16 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEvH0-0000sM-An
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 16:31:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso34828655e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 13:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776717072; x=1777321872; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aezpVBWiRfxiVJlNh46D7dvhL3ZNvgi21m1TmhkNb7g=;
 b=E0jZXX8red4CfQ1JvjyTPHTbgt4T4krjLvrWhaw4DeuJdbUfIOry8Olhv3G0oUBrp+
 eH1vQG6rcIVLXyeA1yOPPR7lx9nCK8z51E9swUHm+PZwrYUalxc0m7igXxfsC1kajyPX
 +YhgEb2/48ocG77VuqNRF+DhxzRIAtRc3JOkAIqTllWFY76gwrUDfPKo23Zq3ERahizE
 GNrINCSr9BzEqkuIh3qM0/dFjt4h1S/SVV46dd46yLIQ6Yng0u8/4QeBa2YVKKqCo55W
 BVj4kJ6giUurdSlJ2N6C1pr1Mpzh4U/SIE2dPfCpOzcq1OTsxFI7Nymf2Olem0MgfTgw
 ygIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776717072; x=1777321872;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aezpVBWiRfxiVJlNh46D7dvhL3ZNvgi21m1TmhkNb7g=;
 b=gH1pKDjO2K9WeRfOynVWkXC4MRRrc5KQRl1kIZyRsgy1i3BNWFQGsQCJ99tHCSSdNA
 kIzNo2/Ht6yBHebOR8t8CEpsLe1/ZEKbW2/p5PDvhVEfXLg5KGxg3KbAyid+2J1sZoX8
 JLT4tv1whYIHpalWk2ghnBFhIsQICA/L5zyXp1aYCKyVNTFo7l0hXCNPY7pdPkAeR7nQ
 41cKcKrKv6VbzXhf/GRAl8mtYAqUztov7oXz0w6mJI8BBPRGjHxq3LLsQiJ8XijharXP
 13lsqnjlFcL4uFW0OZ2l8b++67+sihiJSoV4tBtyjmB/gJd2GqglL6iLuS24RxyE06v5
 /4XQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8oJ/CBOO044AJdlP1CWNe6KAhwWvk3dZ9tUQJX0WgV5F5QyBe7aShrZBcFKtnmGymRTIusR9BS90Ki@nongnu.org
X-Gm-Message-State: AOJu0YzG+FY+79GEbyrGAWbHnMiPrDf8DE7VAZfNY7KtPL85cWXO/j5I
 xR9KJTHJ08JE+BiO/AeAQRVKKEH59G+Dho30CvCA/ncNnHv0rzt/UFy6aN+8npC0l9Y=
X-Gm-Gg: AeBDietHAeQD0BkxHQDR8Nbjw1jHWjhbqTKAD7hMlHNqcOwOTdarfYjAWKhS0jFA6hq
 vLnwFvXovlDRJeMJBNHTXYZhEhQf4f0EtKdXJ2AcDwtk/L2XZOQ7zOZf+u0PescRTCnxBpzz2+d
 KRJz7IgWVwyYXA6aGEfwSlaLWgKiVOJdezL0M5MC4/ke2oTALNdhEdCEaAlaogRDRBCZi5PvF1a
 kEnV1rYF2IGYZ6MF3bMYp3LSVD1M7d0fg67+KLSx1LMa/gkHl7X5fK5pEacU/0sK6liv/0Cal7X
 8D9eI/9XMjGO9HQYrR5SrZf8IA0SAsOTbRdX74JPll2xVq7EhgDBcpZDRxePPb8wiNM8yPdzsIx
 wiXC40y5fFFJsMBas3UbMspOedN5ymofkNy18Vg2X56o9btCXzSJbhV5Wc2Drk4EZAQbDqalPlO
 XxLuLeQnovErKNco7cdSzbkqGokcu/WpnGx0YxNtpkfZFvzZFkR/WCvSPNuszBAHpwqohP9434V
 k4i
X-Received: by 2002:a05:600c:1e09:b0:489:1f6b:6276 with SMTP id
 5b1f17b1804b1-4891f6b6464mr59719125e9.15.1776717072084; 
 Mon, 20 Apr 2026 13:31:12 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm52533155e9.11.2026.04.20.13.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 13:31:11 -0700 (PDT)
Message-ID: <082b5146-23ca-422f-854b-807ceab50427@linaro.org>
Date: Mon, 20 Apr 2026 22:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hw/tpm: Remove instance @ppi_enabled field
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <70bd2f29-9f33-43e0-897f-52f0b2af111f@linaro.org>
 <ece64b0e-7f05-43de-b326-38788a9abe8b@linux.ibm.com>
 <2c06e37f-477a-49d6-a65b-fd826fcdc5b2@linux.ibm.com>
 <184a1a43-d41b-4b23-bc53-768a12631884@linux.ibm.com>
 <01eb4b4a-b77f-421c-8ff8-bbd061482c8d@linaro.org>
In-Reply-To: <01eb4b4a-b77f-421c-8ff8-bbd061482c8d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Stefan,

On 28/3/26 00:37, Philippe Mathieu-Daudé wrote:
> On 27/3/26 19:17, Stefan Berger wrote:
>>
>>
>> On 3/27/26 11:21 AM, Stefan Berger wrote:
>>>
>>>
>>> On 3/27/26 11:18 AM, Stefan Berger wrote:
>>>>
>>>>
>>>> On 3/23/26 5:56 AM, Philippe Mathieu-Daudé wrote:
>>>>> On 17/3/26 13:02, Philippe Mathieu-Daudé wrote:
>>>>>
>>>>>> Philippe Mathieu-Daudé (5):
>>>>>>    hw/tpm: Factor tpm_ppi_enabled() out
>>>>>>    hw/tpm: Add TPMIfClass::ppi_enabled field
>>>>>>    hw/tpm: Remove CRBState::ppi_enabled field
>>>>>>    hw/tpm: Propagate @ppi_enabled to tpm_tis_reset() and remove in
>>>>>>      TPMState
>>>>>>    hw/tpm: Simplify tpm_ppi_enabled()
>>>>>
>>>>> Series queued for 11.1 (typo fixed), thanks.
>>>>>
>>>>
>>>> Here's another TPM PPI related series. It would make sense to 
>>>> upstream them together. Do you want to queue that one as well?
>>>>
>>>> https://lore.kernel.org/qemu-devel/20260327-tpm-tis-sysbus-ppi-v2-0- 
>>>> d8ec84d25dbc@redhat.com/T/#t
>>>>
>>>
>>> Actually, they will have to rebase on this series first...
>>>>
>>>
>>
>> v3 is good now:
>>
>> https://lore.kernel.org/qemu-devel/20260327173209.148180-1- 
>> mbawa@redhat.com/T/#t
>>
>> If you want to take it let me know, otherwise I will have to wait for 
>> your series.

I'm not seeing your R-b tag on v3 on the mailing list, did you
sent it? (asking because the list had some issue the last weeks).

> 
> Thanks for the head up, I'll queue it along and send the pull
> request after 11.0 is released.
> 
> Regards,
> 
> Phil.


