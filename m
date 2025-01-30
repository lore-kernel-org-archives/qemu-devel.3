Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A67EC0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 19:40:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdaO8-00054T-7w; Thu, 30 Jan 2025 14:39:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdaNv-00052y-8y
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:39:34 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdaNt-0000kc-BN
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:39:31 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862b40a6e0so826033f8f.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 11:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738265967; x=1738870767; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J1PxNw5hGSUL2fGaja8I+hNFWdNicgYAu3pXwQKprDU=;
 b=gHCPRdUl0JNu/Fp8U7JxGKzrVRBulNZfL1NPQjI3dOt+dkr0rFptQ/9XoQUl4HN6qY
 mXrQ/zvF0+fAibk2xRBkujsnlgaVff0iSIVbKAH2nXFCk06HYtvrSWFaDCprMcB5tM1c
 zp1j/IbAC4jw4vK3iAtLogfOmcoFQ8WP1TFRleTy1bS+uFVdBNOgZWRKcTBCSLmj+Moj
 k5G2myOgGPtM39O0Bi7xDI4lVh/MYjNH0ayuE0pPd67Sr46XsiTKeGAdsm9CX6ZZ+bfk
 msOKNnngdiFwcmarnRcNofUVYNCx7i5tJGzrxqdffcoOzeyXIu8VWWiwQvNpEAB9Qrdm
 r3UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738265967; x=1738870767;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J1PxNw5hGSUL2fGaja8I+hNFWdNicgYAu3pXwQKprDU=;
 b=QcMTmcstZQNbhM+PLhp3ZiSzR3wqjIw6z9uXLUBIy09ak8V46CKiiv2h2G+r6rdtGI
 hpl+N0hS0eIYYjwWXbiuK8/B4OVCWUUwZk8dQ1QPTe+0DquZp63LS4F3Kg2ww5bNP8jU
 NsNMHBU8kJeqJzCh9H45rfUnW4MK/zH3eMnVRr3LMY/N1Crmr1n2rb2HtPyBac0zTNP4
 HzhebV8pf5/Vx7wmGDPm12rJ/ozhawQjCz65jeIVxdf6dbZfYxergFSGU/k5NSX8nn6w
 0Ot6QW6JpaGfZJOHmpCU75fRfMddYmlW7ugW5E5xsHnI0lMZn8amVgLfAb4pi7mrpT3M
 u6pQ==
X-Gm-Message-State: AOJu0Yw/D64wnl5a/ysA+8lQt1wY+ER3ANBJIekZrVjTAyHFTe60MiKs
 8KyqjUo6HN1Hjan/LHAt22VMH07quOJ0YAs8DvdohGW7EYJ4tCzbVh2UPOLXLe0=
X-Gm-Gg: ASbGncuNpA3zA76xLg7+qN4aDsqldwKMF0zVGGPa7njTvGG4g2QeVxFWK5C9SZ/IzLU
 1CtK+jyBdprZwOARB1OWDO/fKU4hvUSFJHZXds3Zg70QN69bv25cUsMZCVyel3iz0arjTsZ9tKk
 XGoIZ1Gjgwq0YAQVHHnfTNQOcJhLvKEST+ZaMZDq/aWBVc915J6hJvxCbU5bhGuWcPFf4N/4/l/
 4KAVpBcwY9gc9tMcJfdbXqjwo7Vobmvdp8SrAbQ34qggIQrQn4bmeMNLo8j1MWrMKVmH0m3hcg8
 Uy+JkrD8uGqG9Zid7JnE0OZwrTBoSc1xQuABOsFdXDNi/gXyv0z0XOyfM4E=
X-Google-Smtp-Source: AGHT+IFTko4c1fH0wIJNcGV+l95QPh8vJnzsxV8Nj/68/q6uKwx3nCoPYblcuRVqwpEgcDc9xYK0aw==
X-Received: by 2002:adf:f382:0:b0:38a:41a3:218 with SMTP id
 ffacd0b85a97d-38c51e92ab1mr5386243f8f.36.1738265967294; 
 Thu, 30 Jan 2025 11:39:27 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e244ecd6sm33900525e9.28.2025.01.30.11.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 11:39:26 -0800 (PST)
Message-ID: <6aaf2d43-a52f-4392-93af-ef2173493be7@linaro.org>
Date: Thu, 30 Jan 2025 20:39:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/arm/exynos4210: Explicit number of GIC external
 IRQs
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Rob Herring <robh@kernel.org>, qemu-arm@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>
References: <20250130182441.40480-1-philmd@linaro.org>
 <20250130182441.40480-3-philmd@linaro.org>
 <CAFEAcA__VjxHZpFqhnYYU+gV2hg7V-pwq_2ZZSVBQDheSmTvDw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA__VjxHZpFqhnYYU+gV2hg7V-pwq_2ZZSVBQDheSmTvDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 30/1/25 19:30, Peter Maydell wrote:
> On Thu, 30 Jan 2025 at 18:25, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> When not specified, Cortex-A9MP configures its GIC with 64 external
>> IRQs (see commit a32134aad89 "arm:make the number of GIC interrupts
>> configurable"). Add the GIC_EXT_IRQS definition (with a comment)
>> to make that explicit.
>>
>> Except explicitly setting a property value to its same implicit
>> value, there is no logical change intended.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/exynos4210.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
>> index 99b05a175d6..75d6e4d1ab9 100644
>> --- a/hw/arm/exynos4210.c
>> +++ b/hw/arm/exynos4210.c
>> @@ -103,6 +103,14 @@
>>   #define EXYNOS4210_PL330_BASE1_ADDR         0x12690000
>>   #define EXYNOS4210_PL330_BASE2_ADDR         0x12850000
>>
>> +/*
>> + * The Cortex-A9MP may have anything from 0 to 224 external interrupt
>> + * IRQ lines (with another 32 internal). We default to 64+32, which
>> + * is the number provided by the Cortex-A9MP test chip in the
>> + * Realview PBX-A9 and Versatile Express A9 development boards.
>> + */
> 
> This isn't the A9MP test chip or the vexpress or realview
> board, though. We should be setting this to whatever the
> exynos4210's GIC is actually configured with, or else saying
> we don't know what the right value is but this is the
> one QEMU has always used (i.e. probably a TODO comment). Those
> Arm devboards are irrelevant either way.

Historically this is how this board ended using this value though.

I'll reword the comment appropriately.

Regards,

Phil.

> 
>> +#define GIC_EXT_IRQS 64



