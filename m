Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E6BC3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 06:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWsQQ-00053o-AV; Thu, 25 Jul 2024 02:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsQP-0004zz-7l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:58:05 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sWsQM-0000tK-AD
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 02:58:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-368557c9e93so261157f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 23:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721890680; x=1722495480; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PeGEmRBAOhT/xkRbn6ISbWil2tWD4PNocyMx9/v0nys=;
 b=W5aJsVMStgMHgh9fwRa/EP8kSG8YlVBqtaXZUYtF44h5er/f97FMLl9pfe8B700pOy
 Uv5x8MM9CJadiHVQMCPYVnmJxIXZPtBZFoaGoFg6SrruUr6wcN2vSjJBiPgS4Ho8StBL
 LbCG6z6qYDjQY0GrNCPbN/2lpAI5TBPHpConCL/x5AS687X28tkSUgP27n0T6f3R2xz8
 LNGRRjbwmiu90UoEf9A3ZqB8GuCjT4dV6gJS6cI5Kozu5+TB0IiB60Ytm15hoUHMqcRK
 qK7FjzgdTTvSD0gsTCoFhbcDRwO0cKJ01jAn/S4S5mTjZLubfj7TapH3JAn2lXWQGI8p
 jPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721890680; x=1722495480;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PeGEmRBAOhT/xkRbn6ISbWil2tWD4PNocyMx9/v0nys=;
 b=auhtj0a0C0o8hjcxjpv1YeKpgtGX4Z9mspuwxigTe/ZMgsMrHZ493f5tkO+AvRyjvZ
 GexfuefdIAcSP75c4X0ai6YvO+5dHgCRYh+YLtmBtzVeayN1OT2KyV1Q27bllEtPbcwM
 /7zAwFEoZ40v6LVhopwcIMIlg3xnvQaEnXZekEIbROWGlD11T9Ust4Kd36HeGKnxR+tJ
 o4l+7X4cv53e+FHb/9armLscqIRBIGYhZuNn0Q5fYsqZNFWq2Ky+bRO0KO/z36J0ZZBx
 vAgwspWDyihH8oPIplUFkc44UN0Sqo+y/W0sHVwNaaXy9rwwrsCXAhkY4R1RiBELiFMD
 rcyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLPYdTyuUxTn69lMTMTptYcrdeVqKufA5O2AbOROxRxnApRmrkJmvbZx+uAuiYzeu+fxU9xfegcNX9Xq98yiF4eNzXJDo=
X-Gm-Message-State: AOJu0Yy2yqzC/DSNr4BQJVIo0GOoOLHsPls2nSVMUZmXjZMuuUtcNAZp
 /eXp2WOkRKiCvm73Gz0o1fe45BXZHgWCSpzpUdwIYnvPweLNe7BW0w76tpaAzKQ=
X-Google-Smtp-Source: AGHT+IFYd+86a4CdMeD8vAECR5ncKuYu2L+tqZOQR0k/0s7mBlAjDuinyINICZUilr2ZdZIOD9NEgg==
X-Received: by 2002:adf:f281:0:b0:367:9851:4f22 with SMTP id
 ffacd0b85a97d-36b36443da6mr555218f8f.58.1721890680067; 
 Wed, 24 Jul 2024 23:58:00 -0700 (PDT)
Received: from [192.168.114.175] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367c0aa1sm1070972f8f.21.2024.07.24.23.57.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 23:57:59 -0700 (PDT)
Message-ID: <0fb1abd0-5031-4098-8e76-7f65fcbbddcb@linaro.org>
Date: Thu, 25 Jul 2024 08:57:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/misc/bcm2835_property: Avoid overflow in OTP
 access properties
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <20240723131029.1159908-1-peter.maydell@linaro.org>
 <20240723131029.1159908-3-peter.maydell@linaro.org>
 <a8291990-e161-4a43-a1c9-69040f1f6f93@linaro.org>
 <CAFEAcA8GPPy4P330P8kgbCxf=S+f8WGmB6tnAHN5bXxxyN9U=A@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA8GPPy4P330P8kgbCxf=S+f8WGmB6tnAHN5bXxxyN9U=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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

On 24/7/24 14:31, Peter Maydell wrote:
> On Wed, 24 Jul 2024 at 08:06, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> Hi Peter,
>>
>> On 23/7/24 15:10, Peter Maydell wrote:
>>> Coverity points out that in our handling of the property
>>> RPI_FWREQ_SET_CUSTOMER_OTP we have a potential overflow.  This
>>> happens because we read start_num and number from the guest as
>>> unsigned 32 bit integers, but then the variable 'n' we use as a loop
>>> counter as we iterate from start_num to start_num + number is only an
>>> "int".  That means that if the guest passes us a very large start_num
>>> we will interpret it as negative.  This will result in an assertion
>>> failure inside bcm2835_otp_set_row(), which checks that we didn't
>>> pass it an invalid row number.
>>>
>>> A similar issue applies to all the properties for accessing OTP rows
>>> where we are iterating through with a start and length read from the
>>> guest.
>>>
>>> Use uint32_t for the loop counter to avoid this problem. Because in
>>> all cases 'n' is only used as a loop counter, we can do this as
>>> part of the for(), restricting its scope to exactly where we need it.
>>>
>>> Resolves: Coverity CID 1549401
>>> Cc: qemu-stable@nongnu.org
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>>> ---
>>>    hw/misc/bcm2835_property.c | 9 ++++-----
>>>    1 file changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/hw/misc/bcm2835_property.c b/hw/misc/bcm2835_property.c
>>> index e28fdca9846..7eb623b4e90 100644
>>> --- a/hw/misc/bcm2835_property.c
>>> +++ b/hw/misc/bcm2835_property.c
>>> @@ -30,7 +30,6 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>>>        uint32_t tot_len;
>>>        size_t resplen;
>>>        uint32_t tmp;
>>> -    int n;
>>>        uint32_t start_num, number, otp_row;
>>>
>>>        /*
>>> @@ -337,7 +336,7 @@ static void bcm2835_property_mbox_push(BCM2835PropertyState *s, uint32_t value)
>>>
>>>                resplen = 8 + 4 * number;
>>>
>>> -            for (n = start_num; n < start_num + number &&
>>> +            for (uint32_t n = start_num; n < start_num + number &&
>>>                     n < BCM2835_OTP_CUSTOMER_OTP_LEN; n++) {
>>
>> I find not making the counter size explicit and use 'unsigned'
>> simpler, since using 32-bit in particular doesn't bring much here.
>> Is there a reason I'm missing?
> 
> I just wanted to match the types between n and start_num and
> number (where the latter two should be uint32_t because we load
> them from the guest as 32-bit values). Otherwise we're relying
> on "unsigned" being at least 32 bit -- it is, but if we need
> it to be 32 bit then why not use the type that is guaranteed
> and says specifically that it's 32 bits ?

Yes OK no problem.

