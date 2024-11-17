Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C13D10F23
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 17:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCiy5-0004wK-6Y; Sun, 17 Nov 2024 12:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCiy3-0004vx-9Q
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 12:21:47 -0500
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tCiy1-0005xu-9D
 for qemu-devel@nongnu.org; Sun, 17 Nov 2024 12:21:46 -0500
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so2546855b3a.1
 for <qemu-devel@nongnu.org>; Sun, 17 Nov 2024 09:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731864103; x=1732468903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v7jqDBFuQlqd4iZ78be4bHCC+8shG7OmVzEIuIJCQQU=;
 b=v/u7QQjdmdHdwKSKWvkvf6IzU3WH+fJ9yFbzUYcGMaZ282M0OKT5UA1nNWhQkoryQn
 LMrKvyMq+g+MZoRC2btaYUbou5uJJfHBKVtZdm20U366E/Mjjl849gFtpaCSnWyb+EPZ
 sLPvAfV4z6/4hqayil6HFhJPHVVtLfog2Sh0Pwk35IrTD6NrIVZD/CH+5HNlHAIKp4/r
 wFXq7ftadhgDsHo4omXnK6FW2aVQKE8SNTtJojTswwauFKGO67WljT2KEtxPhlI59IgZ
 JHgxZe4Wul0Uz9u3JY9xBDhLTbYylmFvbgiRQ7mc+ZSFFPzqVlM1v/dmcPNKfEYcblfI
 WLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731864103; x=1732468903;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v7jqDBFuQlqd4iZ78be4bHCC+8shG7OmVzEIuIJCQQU=;
 b=oTFaASUKBXxPghQhliRvdS6x3VbuvCKo7/pCE0bAg24RpnNPr+mUNa6PcXc1Eorx0d
 Drhc2RVJlpLC2bY2Dp84Vqx9WkWmLgxcveHKyuGf08FViyHvFaepIvsJ1Gm3lYCgJT60
 HudAW8In6gfUEXlbHeqAYmK7uftSItT5kRO+t/VK6+h6QYTeeZnuaJlCEWQCO/c/WJjG
 QXvuxNAe0LbgQ18OmYzsY4B14J+8+QitTZ0EGrpAw2KigHUkRWQIYBb7BCHRxWn0bZil
 qFRaaHtwpcGqIilQQI2NWZm7p+bw2AOP3e50LQbAfd1bbsx5nsrdSuosD4QJMWvLnTRQ
 FtTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMUKKhnx8fGPqcE4wmECq+dcGgHkCrTtZUpCW2mBO3vRAFbrh76BF9R+FHuZuM8DO1h6DbCOrFNOAL@nongnu.org
X-Gm-Message-State: AOJu0YyAt+KDUZs/IraH5OhsC8Xn7gg0DeGi3/0kkhMH8arCpts+whn8
 04VlB9h1CDb/cSpxU2qzlGBX3cGnr1UOUGgfzhe45EX5is/FVNwkmmBvsboZ3epeLFUhkWPNa54
 b
X-Google-Smtp-Source: AGHT+IFaZoCA1fmYb0ucj0BePshM9b2412+jd9/zqQgVMtOVth/zvRZ/VonMr3UDGydtjXxwMuV1pQ==
X-Received: by 2002:a05:6a00:998:b0:724:58dd:43aa with SMTP id
 d2e1a72fcca58-72476bbaa26mr13149239b3a.14.1731864103367; 
 Sun, 17 Nov 2024 09:21:43 -0800 (PST)
Received: from [192.168.0.4] ([71.212.139.183])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-724771e202asm4788830b3a.142.2024.11.17.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Nov 2024 09:21:42 -0800 (PST)
Message-ID: <6b3c11ab-6df5-4508-9aa8-9006d35736fd@linaro.org>
Date: Sun, 17 Nov 2024 09:21:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] linux-user: Honor elf alignment when placing images
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <20241112203757.804320-1-richard.henderson@linaro.org>
 <20241112203757.804320-2-richard.henderson@linaro.org>
 <f3baa53f-42e0-4a3b-aa15-469df31e1b71@tls.msk.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <f3baa53f-42e0-4a3b-aa15-469df31e1b71@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 11/16/24 19:41, Michael Tokarev wrote:
> 12.11.2024 23:37, Richard Henderson wrote:
>> Most binaries don't actually depend on more than page alignment,
>> but any binary can request it.  Not honoring this was a bug.
>>
>> This became obvious when gdb reported
>>
>>      Failed to read a valid object file image from memory
>>
>> when examining some vdso which are marked as needing more
>> than page alignment.
> 
> Should we pick this one up for stable series too (and maybe a
> subsequent cleanup)?

I'm not sure.  We've never had a bug report about it.

> And/or maybe all the alignment reducing patches for vdsos?

The alignment reducing patches alone are enough to fix the gdb issue that I found.

> One or the other is apparently needed, but I'm not sure how
> really problematic this issue is.  And you didn't Cc stable
> here for a reason, I guess :)

Yeah, cause I don't know how important it is.  :-)

> For now I picked up the alignment change for arm vdso due to
> a subsequent change there (be8 & be32 split).  What's left
> looks.. lonely :)

Heh.  Maybe let's be more conservative and leave this one out for now.


r~

