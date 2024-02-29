Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA2C6C54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 09:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfcva-0001RF-Sp; Thu, 29 Feb 2024 04:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcvV-0001QZ-1z
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:42:05 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rfcvT-0006fc-AJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 04:42:04 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-412c1dea53cso462275e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 01:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709199722; x=1709804522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hNzYypkHhjYV8oaAOwwcNsby7uRdR9TNer5MflUzylc=;
 b=pYZVEtwv/f6mhqA4ateolCksHi3vafdCVXH0LCr6/Y1a0JMwqLTXFjiWWoBT4upMOo
 61138BP4V7TZm93VMEl8FKHLiPNxFmyD9w/HHfrmGuxy2lFOuNylqscF6xeYLBB/+Nf0
 HfrZ0U+qhv8Gu1TiTpk9DuMA0JYg7Hllv2vCdSXQAe5NS95bHrDD430XDt4sHlBk6JDx
 St24bQTYI9rTQeIdi+3kBPJ6W9lqHZGy/nDNt2lyjFa3L59ZzTVc1BVthAqiujwbzhnP
 BmJCaQqyRVfxA+muQl+uw5LMtc5q7vjwlRKnM7zz+5Nc8yzZT5EoEAyEXQZY3Fa8SUNR
 U1FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709199722; x=1709804522;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hNzYypkHhjYV8oaAOwwcNsby7uRdR9TNer5MflUzylc=;
 b=Knj39ye8F0tEEW2lPoppliAN076in1Lrg+BMXN/graAn8IIGtJ9eydE86mZRAuw9sU
 xB+vMK8KUY3OA08/bbBqdPVuCj1wsygZaKFErkzC20CGGMpZJZj4GxuOdG9TZWHKC5d2
 M4TSe9DteccBS9ffP7iNxVIkeySKE6hTfbCjTj7EXfC/ho7i1ywtPD763xt+DNfsxb4S
 aYXM5tVBpd7PT1NasFZz1zv/wXNXs0OieJp9AYU5nRjqmzWRbIMA/buay7PvawwRWDHN
 c98rMsgv9UQH80/C6WxApIuj/mTtiKuCU9XLPUOEEK/sSk24G10NJFztLcYrpY0P0BW0
 00bg==
X-Gm-Message-State: AOJu0YzayZN+KRvit8FjUEiOzvXs4Plcpi2CYkBu4r+CeBwhZ9170mQp
 iizhznZi9uYC8m8iY2Zz9eMz5uAnGggUP0KiMb1jnKeR4PHHqozVVMXg0uMTewM=
X-Google-Smtp-Source: AGHT+IGYqK+6VkMZPMgwXZaeSkbBATaor14O2Pp1BMhmHubVTHIonMJpI4lOLCAdVZH9ymHZBAQS6g==
X-Received: by 2002:a05:600c:4511:b0:412:bca4:b78e with SMTP id
 t17-20020a05600c451100b00412bca4b78emr944879wmo.24.1709199721924; 
 Thu, 29 Feb 2024 01:42:01 -0800 (PST)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 l22-20020a05600c4f1600b004128f41a13fsm1537291wmq.38.2024.02.29.01.42.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Feb 2024 01:42:01 -0800 (PST)
Message-ID: <c4d23c22-992c-4acf-8858-3b1968b44dfd@linaro.org>
Date: Thu, 29 Feb 2024 10:41:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ISO C90 compilation error
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paz Offer <poffer@nvidia.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <MW4PR12MB6997B8D6225D08E8F3E2DE55A05F2@MW4PR12MB6997.namprd12.prod.outlook.com>
 <ZeA5ZbbHLy9mhmsa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZeA5ZbbHLy9mhmsa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 29/2/24 08:59, Daniel P. Berrangé wrote:
> On Thu, Feb 29, 2024 at 07:03:35AM +0000, Paz Offer wrote:
>> Hi,
>>
>> I am trying to build my code with QEMU and getting compilation error according to the ISO C90 standard:
>>
>>       const size_t buf_size = 31;
>>       char buffer[buf_size + 1];
>>
>>       error: ISO C90 forbids array ‘buffer’ whose size can’t be evaluated [-Werror=vla]
>>
>> I noticed that the code builds with '-std=gnu11', which is newer then
>> C90, so this is not clear to me why I get this error.
>> Where is the correct place to specify the language version for this?
> 
> QEMU has set compiler flags to explicitly /forbid/ use of variable
> sized arrays on the stack, as it is a known dangerous language
> feature. You must refactor your changes to avoid this by using either
> a statically sized array, or allocating on the heap.

If you array has a fixed size, you could use a definition, so the
proprocessor can evaluate the buffer size:

   #define BUF_SIZE 31
   char buffer[BUF_SIZE + 1];

Regards,

Phil.

