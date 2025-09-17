Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D260ECAC5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 15:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyuVQ-0000ZM-EQ; Wed, 17 Sep 2025 11:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuVO-0000Z9-6Q
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:55:38 -0400
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyuVM-0006VQ-F9
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 11:55:37 -0400
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3304dd2f119so373220a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Sep 2025 08:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758124535; x=1758729335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYmlIMZUb0oenUC541erRlHRn4hfBb2y10xyhSFXYVY=;
 b=iEiG00Rrbr6jkdnmxh3s+zBIqTfAD65GyucuRn3iGAxPuvcceh/hogpERav6/65uxA
 4fYi3Myw+r0thqZeocgvHNkGD2FAzUtvgOVYmYZjCKH/aBdCqdP38hDxTXVl3Gu9oCcx
 r3Nb4lPiOfHjXKeM6vXtmpV6mAmRGdZgy9YVQQIgwaN4+amm0ntn1/3blE6o/kQZzBtt
 kYJz/YUKXiish4rVkqcyOZq1wYuXsnZMFBkG3wqP0DxW8+NGOHg0a8a0/2nDsS8DVwtQ
 8Y3bgkmwUq8KVke+UQiCmngOTuwjlUzwGNqNs5daBL30R/UecGrQZEoAg3bgJTfTQLst
 sk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758124535; x=1758729335;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YYmlIMZUb0oenUC541erRlHRn4hfBb2y10xyhSFXYVY=;
 b=QqUOtITsy/KLmGWs7De00FbbWcGaBt6dRr0J4LH7mzJiLmQ8TnxzkJpTY/b+NJaUAE
 OTzBwETjPOo3EeTULveGOWtmTup+frpKcJkvCofqP9pmmN/8kbuSEz6Kz5BoiK/v5uaw
 zeb7R6k0axFCNedHnJyy6QJB+bSa3xNHWOiqNqnPQumAJ2g5FdVAjQrvdswVJtQ7jfUo
 BcLjAALAOQSUP0wW39SrD1a8jED97QmkD5yV2Uwp6w+JY8wxl+uXKH/cz+lHTOv3C77j
 RvoBR/SzPj17Qp1cv5evb+kDXpJK1uBzcEdRcXGQGC6/r5Nqxhm95QjFmCgIt4PTLK1E
 dNVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiUeLARA3lLS0VsWlfLovhf1sinfoD069XMVTBTMq2AmK4f8stmhvNpr+mCOVI4SgA7DVTZ5t1B/zo@nongnu.org
X-Gm-Message-State: AOJu0Yx7bKOP36Bnrpd8jtMjc4+04B0zMVqSf69QmPbxASp3KS/fpZ5K
 H0tUe0EYxKFi0YlEEQb8qgNfrxNeQvd3zTamioJ0U6zP4tu09shzp1u27C1lH/TTJEA=
X-Gm-Gg: ASbGncvAfmi8sUayjauhc+hsZq81iSnjJBF9hDFHxkJC/GzzJx3GEtLV+j/GVRr7pDY
 kQ4b4dG5kXX0FK+hSziDRpMo3CTBMzm17AOmneFWfOdWeSopCUTi1qV2oBekX2wo9UmYn2vJ+oN
 9SjNToxpW+4xcjm8XfZZ4DIc45M76lOy4KfRQA9Nvpmred++K+s9R8hGfeQvSS/3tPmyzHF8gLG
 Gg7VouEaR88i9sHahXvgZe1eQZpEMX1BdU9wwszCHb/vCDOTyX9YjJY/D/mZ3i/bkDt/mCXkKyt
 N3cenjnFAQwnFGDIhk0jE9oF/V5gpASWSxBo5aPbkgKDaCrheGyVE3tzFOhRO1J1kwJMTA2PQvS
 tEZQcUJ3hAcUaKqxnnV/Gn7688YCgeTJ7vOx8jF4eNiFiQpU=
X-Google-Smtp-Source: AGHT+IG63XM2gnqeK+AKiuUacKb59ROQqwQUM5XLFBb96eVZApO/6UgCEM9mSDmMBFMH6gvwt+/bdw==
X-Received: by 2002:a17:90b:3bcb:b0:32e:9a24:2dd9 with SMTP id
 98e67ed59e1d1-32ee3ed2409mr3256981a91.1.1758124534907; 
 Wed, 17 Sep 2025 08:55:34 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-32ed26de6a8sm2846186a91.23.2025.09.17.08.55.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Sep 2025 08:55:34 -0700 (PDT)
Message-ID: <546a6886-6812-4abe-affd-70ff59f85a04@linaro.org>
Date: Wed, 17 Sep 2025 08:55:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/35] hw/core/loader: Use address_space_get_path()
From: Richard Henderson <richard.henderson@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
References: <20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <20250917-qom-v1-2-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp>
 <73f3ad14-e9cd-4477-afdb-76fb65f5617e@linaro.org>
Content-Language: en-US
In-Reply-To: <73f3ad14-e9cd-4477-afdb-76fb65f5617e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102e.google.com
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

On 9/17/25 08:18, Richard Henderson wrote:
> On 9/17/25 05:56, Akihiko Odaki wrote:
>> The name field of an QOM-ified AddressSpace represents a property name,
>> which may not be sufficient to identify the AddressSpace. Use
>> address_space_get_path() instead.
>>
>> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
>> ---
>>   hw/core/loader.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/core/loader.c b/hw/core/loader.c
>> index 524af6f14a09..1ee603f19c90 100644
>> --- a/hw/core/loader.c
>> +++ b/hw/core/loader.c
>> @@ -1258,10 +1258,10 @@ static bool roms_overlap(Rom *last_rom, Rom *this_rom)
>>           last_rom->addr + last_rom->romsize > this_rom->addr;
>>   }
>> -static const char *rom_as_name(Rom *rom)
>> +static const char *rom_as_path(Rom *rom)
>>   {
>> -    const char *name = rom->as ? rom->as->name : NULL;
>> -    return name ?: "anonymous";
>> +    const char *path = rom->as ? address_space_get_path(rom->as) : NULL;
>> +    return path ?: "anonymous";
>>   }
> 
> You're not freeing the result of address_space_get_path.

In addition, I think the result of address_space_get_path cannot be null, so,

   if (rom->as) {
     return address_space_get_path(rom->as);
   }
   return g_strdup("anonymous");

r~

