Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD8BF43680
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 09:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDf4D-0006xg-7X; Fri, 17 Apr 2026 05:00:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDf49-0006xX-Ke
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:00:47 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDf47-0005rx-60
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 05:00:45 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48374014a77so5265495e9.3
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776416436; x=1777021236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LNlFKkYKhegesswxpRS9pE3M//ZgBttYlhICEhuw6PQ=;
 b=T7dl2XY5elhwg9SpNMfSIHdVEqzkd0MN/GWWMGmw7A6FSNMuO9I2t4dWUKLVXI2fUq
 kuQynhEKCpsafgEx01z6VwmpTE2OsRjVHKlZfrDeF+bPE+OBvjZAcbvLDjeNQMjnsPbd
 niU+soIXScqKCS60lNnl8nBSoD+MR9buiM8fCZ3FeDXtyV5NiqgepZq/2xzNuiBhnj+r
 RM3JOsxHzx3V8O/CikoUSn0ZETB5SaY7GJiZWqp2gC8CgCDFxsb0VzqhIsg3hcLxg8jy
 jU5lCxg9dX0Wa3o3/FtLTdexYhBJdaUkcUjgADLZFHhxx2kwUbJn2ywjJaUrrkoX8q7r
 PNWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776416436; x=1777021236;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LNlFKkYKhegesswxpRS9pE3M//ZgBttYlhICEhuw6PQ=;
 b=i2dWxcMsa+7dwvzBIUXxHYPf0n0tqEuuGeSOdc0+eytDCVhDmut3iXsTctt+wwEQKt
 /BqspOCec+MsltMMQsLqNIu3i8GJbEYRRAd7mqj939YHU6Ji/77gidcosa8wYtl2aUG5
 OOnYoo6QZ1XJxnxT5DXBgtQJ8rtobbdGIYRW22+XBUj/0Btpm4N6MtupaHl64n0QZnm0
 mnvFCH/4XWlMTSBWnRULvurf1gqKDVBrUDWNtAnP99PrdHeaQzWnCHNgcv/piJFJC0dC
 3JBj6fmkfnLsafyuvSz1Z56KQ+ry2RyCaLekUvuGKd3GvdQuuLpiKEnH/9HVZx/zzP+A
 Q4rA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GW8jB9RvngUTxGTsxa32KgNroO9ZjYB5E81c3DzxlxCH/bEIe/ZsWiUq4fMxGOiofE5k90XQHUBYb@nongnu.org
X-Gm-Message-State: AOJu0Yx5x5D5p6sCb8Pyyf2LCOaZAoUQkMKovmq8QHVj49QEcPJg5iqP
 cbd8YrwRpKwBDozKQFTt+Mw/nk/L0GTmPzurqz5tRRlsUIHyGT34x+QMPpQxzBmdRW2NjnGBX4s
 rtIb5JlU=
X-Gm-Gg: AeBDievpMfy/9P9gOgQJdKeVhpDcyV4KN2HRMFKM8R+vmOUZCUIx+dg/5/4az7kbqQh
 QG4R1YykQPKGQYZdimQsqzbuKH3cJcxpQ3KeD26w4zPUaK0IgXJ7TkK0g28gOcmwRckqFomMv4T
 xq1FaFYs594FchpqOGDrnpPFmC0zUPNbZ10ZZbWPjGPSw5PI7PptvTGWsC4AR83Z2TAuZEeUhIC
 0JNufsCVtc3jRuAoJqxCk8VqK8RHIWbYBNiclsWJShRwUPpjAcsOWTYzuAS7Nq7sHNPVAPQHGC5
 TnfXopFtBj6KeqtqSsET8yuNMkeXFZfEFR+th/TWqVQYuEBVhJ3MdwOOtJEyhOhIxsbdACCHhJx
 0g1pwYzW9NFZPQF7XDhzM0ITbLyBmBRMBuQsfLMNfIDyP0jEFcg1GB0oSLtcKBezlCpru2r3yL6
 y1EiQ9Hb+nZQivRPl/xzDs6MgoyaGwzG5W5EB7mdBXNDkt7AyeX6LlGcReggkH7rFUQWL88dW/Q
 gS3
X-Received: by 2002:a05:600d:1b:b0:483:8062:b43 with SMTP id
 5b1f17b1804b1-488fb771438mr22042665e9.19.1776416435703; 
 Fri, 17 Apr 2026 02:00:35 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb74fce0sm15362305e9.2.2026.04.17.02.00.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Apr 2026 02:00:33 -0700 (PDT)
Message-ID: <3595868a-01d8-4cd7-a28a-cc6dca29deea@linaro.org>
Date: Fri, 17 Apr 2026 11:00:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/28] MAINTAINERS: Remove Yanan Wang
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-26-peter.maydell@linaro.org>
 <9cd1c037-1e47-47a9-b147-1a28c74077fa@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <9cd1c037-1e47-47a9-b147-1a28c74077fa@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 17/4/26 10:14, Thomas Huth wrote:
> On 16/04/2026 11.16, Peter Maydell wrote:
>> Yanan Wang has not posted to qemu-devel in some years and did not
>> respond to a query about whether they still wished to be listed in
>> our MAINTAINERS file.  Remove them, on the assumption that they are
>> no longer active in QEMU.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>>   MAINTAINERS | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 043d26b0c4..ca64361b24 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2006,7 +2006,6 @@ F: docs/system/i386/nitro-enclave.rst
>>   Machine core
>>   R: Philippe Mathieu-Daudé <philmd@linaro.org>
>> -R: Yanan Wang <wangyanan55@huawei.com>
>>   R: Zhao Liu <zhao1.liu@intel.com>
>>   S: Supported
>>   F: hw/core/cpu-common.c
> 
> For the patch:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> ... but I wonder why we marked this as "Supported" if there is no 
> maintainer for this section?

With my recent activity around I'd not bother to be listed as maintainer
but as 'Maintained' status, not 'Supported'.

