Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35ED0C83029
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:38:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGZT-00068B-Va; Mon, 30 Jun 2025 11:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGZR-0005ka-4E
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:37:25 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWGZK-0000qA-Rm
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:37:23 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4531e146a24so27409225e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297836; x=1751902636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOJ+rde49eR2UU0+SWNXcIZNdjGp05r03y3MCEvfDcs=;
 b=g0f7PIsq7aRyPvkZ4KPWVirS5OIrs7nZygqkWM0l0+5AictbXz+BgIma4XX5UwahTS
 17Y2SVJFGXk/vNvlSb0EH0fsRS5lrshWiB3D1fPBPzQrUQlbDPLgyYaFvfvmyqlzrTvH
 rNAqJr4a5CtJC3eD4K46YDJLu0jsLZ87SIZlzEPN9QttjPYEP03F97l2tqPQyTGiTuA0
 wHLcVlBPaH0tf67b5S4vvtaPA/2+OKnhe58u3zQMilaX7ewSpKuzM5vjdxC3vt1IV2cB
 dZKC5HtzFlmpTLm5o73wb/uqZicjGd6eHcH6mLVxbNX0+ZtoU+ncqwE4kFqrrZvXaEgT
 Weyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297836; x=1751902636;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JOJ+rde49eR2UU0+SWNXcIZNdjGp05r03y3MCEvfDcs=;
 b=NsHvfHA6Pp6DlrQ8Wxsya03U4hM1R8V6HRwybdbhEdcZrhwWNx46ukMY1/OLwNJaJi
 jjxaKpqOSD9dqVNkyx4e2M/hGJKwoIE66JCoRWUwoi+m82c5WQEz2LVbYr2h4sKTn1Qv
 3TVqWXMscs1wUWIwkiHTzRbxuCme6r1CDSPqxSgedjsBg0/kDMrmKb2t4YKAhUlTC/SV
 o4qqRtjR56sngOXAjtJ7/t7McDA3BCunZ6wCh3nfsT03kX9eWaHT4tJUwifdvjJFXLX8
 kYh70bS3ONrL7TYDNue2TfpZwK2oENwR2hy6P/HSrvLwSDLDE/lpX6YCOEHN5SMRWM6Q
 wTzw==
X-Gm-Message-State: AOJu0YyR9wR7M44m4kk3Ja7HfReB5elo0KBcq0EzwjOwAWxiulWMpzdQ
 E3IWJCiZ81QBzQUT8R0HbUJiw1pQWZorQzKXOgHYZjnXA7kk0dUlI9WX/EWImv9R77o=
X-Gm-Gg: ASbGnctg4UKU/95kpolXC2FcUwZZIobF82MrHgPIg64pyf4v5G88IcXbRKbjJz+Gnyh
 SYE+KL/5gDMTg/imsaL6E3MVgKjTR2AlLZ5S8/R3GDHXS9U4IDa7eTvZPJiai2Dmc/7fk326fUh
 cbuyXnEZEVxPaWHofcGqXmj8QE69LrlsKI6daoZB8lWGATJ052NWIeH0t5T0uHRwKWW29yE3KU3
 I8YsVZtbUlVquMr8Nqd0wF/mBWGfT8wnI1vL3A1Xgx45/CTx8l1Buidg18wzeNk7fj0/KXDP1hG
 p7pxdaXT5T4RluqpAMvGCUgnUz+NPPP7H2yaTALB8ATMpGZ6RzlDccvE2iM8ohnFFQ2jiY7Nyv2
 9cxkWomXhrfylaPh1aBGDUenTG7vnrA==
X-Google-Smtp-Source: AGHT+IGYHbO+RoFCZ8oKzQQkHeU05WvVBJlsvKY11qoLtZr2ZpLBYau/zHcgBKs4bF/U6gCnhASbMg==
X-Received: by 2002:a05:600c:5246:b0:441:ac58:ead5 with SMTP id
 5b1f17b1804b1-4539a843575mr83278015e9.31.1751297835988; 
 Mon, 30 Jun 2025 08:37:15 -0700 (PDT)
Received: from [192.168.69.218] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e599bdsm10489394f8f.84.2025.06.30.08.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 08:37:15 -0700 (PDT)
Message-ID: <d1d84b1f-3409-4292-82ac-5bdf65e3980e@linaro.org>
Date: Mon, 30 Jun 2025 17:37:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add myself as reviewer for Apple Silicon HVF
To: Peter Maydell <peter.maydell@linaro.org>, Mads Ynddal <mads@ynddal.dk>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>,
 Alexander Graf <agraf@csgraf.de>, Roman Bolshakov <rbolshakov@ddn.com>
References: <20250617093001.70080-1-mads@ynddal.dk>
 <CAFEAcA-QZjmmkD1wo+hs4wQr94u--J0qm8arQbnR9VH2tuT-mQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-QZjmmkD1wo+hs4wQr94u--J0qm8arQbnR9VH2tuT-mQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/6/25 16:38, Peter Maydell wrote:
> On Tue, 17 Jun 2025 at 10:30, Mads Ynddal <mads@ynddal.dk> wrote:
>>
>> I've both publicly and private been digging around the Apple Silicon HVF code,
>> and use it daily as part of my job. I feel I have a solid understanding of it,
>> so I thought I'd step up and assist.
>>
>> I've added myself as reviewer to the common "HVF" as well, to be informed of
>> changes that might affect the Apple Silicon HVF code, which will be my primary
>> focus.
>>
>> Signed-off-by: Mads Ynddal <mads@ynddal.dk>

Thank you Mads :)

> 
> Thanks for volunteering! I've applied this MAINTAINERS
> patch to target-arm.next.
> 
> -- PMM
> 


