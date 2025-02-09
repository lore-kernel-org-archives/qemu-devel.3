Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B441C0219B
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 22:32:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thFqX-0006rD-58; Sun, 09 Feb 2025 17:32:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thFqV-0006qu-OC
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 17:32:11 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thFqU-0003oX-9C
 for qemu-devel@nongnu.org; Sun, 09 Feb 2025 17:32:11 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-436341f575fso44252695e9.1
 for <qemu-devel@nongnu.org>; Sun, 09 Feb 2025 14:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739140328; x=1739745128; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LrzDn1MV/06wdigRUtm0WXPgHO1WnjIjyKgPFSPAoms=;
 b=YZAVnNwCQco088Dq82fWxNxIHaC/yYyFXldtguO1toiySkh0doE52oEZ0BeorZ/7V/
 HmeVKzH1bHVuw+MgMkc62TLDVlrVoxItU5+NBdJNemZa2UeDNdLJr457JIfnR6lY0LU4
 BwLZWHOoLOg3Fh12jIIzlG7n/Y6do4onFQlSw9e3jo0sunykk9UzVWGIoI7Z3yKq6kYY
 mXybsRrhUbsZgw9vZ85bghYbiUAsUWclVnAwBTAUkqlVDvyV2rpHDk96nb5axGZHTUyY
 KNtVC6TfZVC8uXDI/u+dljBJvAa4uItO9Ih3+GFAhNZq765EYzhZob5QOR5oMHJRC20/
 W6FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739140328; x=1739745128;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LrzDn1MV/06wdigRUtm0WXPgHO1WnjIjyKgPFSPAoms=;
 b=EW4kj1HsMFpmL5lvT9TGPO/fKmzsjzveeX8sI/9joHZQSX5GZ7DMI8XP3EopbIPOf9
 SllfsasFSoRT2qzoUlgqLSPTVxyLQzjDronCt95BFvOtPnVgoAGXoahGuL+APpgZoTjL
 kUrNDvav1nj0+djLJiy6+XCTELQYSC7idzJH9jbROYl9KYAg2XgZlXrKPhxLwPiM9zuI
 vrHvMnEraBKgBFIK/PXc/DMuMfhUiU5JAbGqgCQBG7RN4iNgBgWna3sZcXa8zRrlfw5I
 5ScYmwhxxZQHLc4dtQzgBtDhOtf4ziNEJ3tfOwdDC2cB5gDJq1Q3BgJ1RU71rc0lqu1J
 036Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQaIOAZPjmeWu1JOFH+w7InoUDyf5Oc+mj3wrxEPTGs6ens3WZT63Wj9dnL2Xvz9GNyYt2j34fXNqf@nongnu.org
X-Gm-Message-State: AOJu0Yyg3i0eTCJcZNg42FMuLRpstlvB5AACAX5fbuni+bQ8KJZ3eT/w
 NnanJM5NEW96/m+ahRO6gwyuvOJwauzUuR7j6C6DqDrpwQx/rQ1BiUu50c09bE8vQnQ5dTxi7zj
 tReo=
X-Gm-Gg: ASbGncvBTgcBi9W5uubV1CdnivZ9rEt2ypeLcIKugLsVc6yzsJ5byRfyjBgohBCFbBM
 98mx7QqQ9vjSuaeI1IESoFvZHxozK8FmmT7ESuOls552DGidxnGhJTOSOxAk5k1/9lnYIAwiyEB
 P5u8OBCtXdP+kpffc9UhDXKDUXb5P1EsL1i2Kt0cMU/B85tNvFEf6Fmt3oE0GayJmqJiyw63Uaa
 XvcrB76HsCm3rogrvTGoCLF3Q6ZFqXgPNLUYatL4N/5quubI/ntB9ze6TFIfU3gx8JrrcBMURcs
 /n8YVLWyVhmpwI2CKfPpsFIRIJI3vMucMM4MyePxZM6pDCUjrlfne8bkreHk316w
X-Google-Smtp-Source: AGHT+IHHNK8f3g/WzFe4twMHkFFNvI092tcUxWbyGcCh+jRAhyYn8rt9hSVUCntUkOUO3HM+/XGSdA==
X-Received: by 2002:a05:6000:1542:b0:38d:d0ca:fbaf with SMTP id
 ffacd0b85a97d-38dd0cb6ab6mr5987048f8f.18.1739140328393; 
 Sun, 09 Feb 2025 14:32:08 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dce8e34f5sm7123732f8f.58.2025.02.09.14.32.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Feb 2025 14:32:07 -0800 (PST)
Message-ID: <6f5f04d2-a228-4fc5-b938-79cf08cb7100@linaro.org>
Date: Sun, 9 Feb 2025 23:32:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/22] target/riscv: introduce RISCVCPUDef
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, Eduardo Habkost <eduardo@habkost.net>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
 <20250206182711.2420505-3-pbonzini@redhat.com>
 <f4ec871d-e759-44bc-a10b-872322330a3f@linaro.org>
 <d375a630-d136-4e0e-9103-fd4dcb1e03d7@linaro.org>
 <60d03735-35ae-4f96-8914-0049216eaa13@linaro.org>
 <74ed0984-061b-4523-b479-e85d3c008e7c@linaro.org>
Content-Language: en-US
In-Reply-To: <74ed0984-061b-4523-b479-e85d3c008e7c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/2/25 23:20, Philippe Mathieu-Daudé wrote:
> On 9/2/25 19:53, Philippe Mathieu-Daudé wrote:
>> On 9/2/25 19:44, Philippe Mathieu-Daudé wrote:
>>> On 6/2/25 22:16, Richard Henderson wrote:
>>>
>>>> It would be nice if this were const, i.e.
>>>>
>>>>    .class_data = (void *) &(const RISCVCPUDef){
>>>>        ...
>>>>    },
>>>>
>>>> This will in fact create an anonymous object in .rodata.
>>>>
>>>> We have other uses that do the extra casting away const,
>>>> e.g. armsse_variants in hw/arm/armsse.c.  Although I suspect
>>>> *all* usage of .class_init can and should be with const data.
>>>
>>> The only non-const use I noticed is Xtensa:
> 
> Also the object_class_foreach() callbacks update 'data':

Oops I misread, object_class_foreach() correctly takes non-const data :)


