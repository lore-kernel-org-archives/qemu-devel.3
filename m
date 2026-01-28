Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF27D46BFA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 20:39:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlCJe-0007Ah-HL; Wed, 28 Jan 2026 15:39:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlCJd-00079B-1p
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:05 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vlCJb-000812-Iw
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 15:39:04 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-823081bb15fso109416b3a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 12:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769632742; x=1770237542; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=znkftfnZkpZB+9hFAyREBqLJ1YqxCbXMKRqLG8+ibFQ=;
 b=Cg3fvjqobz9lJgiYV+cZ5aqOkflmSewVe713y/Uj06YgyBAVc0aOtDXOGoiPYOEOGw
 64f9uzTs9W2+kWA7NT+1TpZLo1kE4DsBKEER14lmwJWr+X39IAC8/rEqYyeMpiEyJ+WU
 /V4j5ecjyM6AGArhq7FxeG0M3vUPCfm6uxGvZsqRh7fU0nUhnTJaiG7ZXycqrh4n0s8W
 mYxMHbu0ntBPOwQtaEz8ZhPBZMSf+Rojav7Q0dI3IhMAIiBvcai/7U4Ll6mL6ZdllReg
 X261uHjhdhXeTYOs+DcaGc1N1hZSoKjbIl/0+SBpvZiRIKkMgD5M0B2Pw+ftblBHbB5c
 QVjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769632742; x=1770237542;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=znkftfnZkpZB+9hFAyREBqLJ1YqxCbXMKRqLG8+ibFQ=;
 b=RIwh7iwD+byW5lzE05wcZ8CCFSyFe1Pit0f4f90g1YN4LB1fczReTgxYxq57NNJO/D
 mK40EKcZ6K5x1bObGYk9zypRdSuscwicDdN9ZXG+aorysRfEYaxMKSGZBTYpsdF1KUFG
 oDGGicDCK7FthbNZA3aTKfPBiFe8+r+i3E1WMTXEvNDV0EDCLlVepv0ZYTRQAuoX/76/
 D0eLvtXQppqgHb973PqRHD4egh0Ly+xnHCw9o0AArH1Hi7ayHgE1GcdiHFI1kQHVbgPC
 scyh6HIXmTsoaW9gayRHQsCoqrRmnGqZF+gGR+owd8RUJv7lm9ZFaAVDZOrBvaVnSZjZ
 PC1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMhsyN1MSt9XrvJ8YSUolXc6k1ul1zycaX/1Qt1Ncra/R2cElu3J5fVtXpBJKEI+tOwwEpPmOOxVns@nongnu.org
X-Gm-Message-State: AOJu0YzA8Tf6VcDsv/p6DsaAftFuiJO/BVEwElzXphY8uSUVgTDFGXnA
 UxjZN6wNhy285unSA9tv4WlT9v/3GpQWJ9TiIy3HDrfXRqTf4TqXWjsowZIxohb8r8ZlGwBo58Q
 T/pkDoxw=
X-Gm-Gg: AZuq6aK6S8BOCWab7MjyhbZ2aMK3pcvV9mBROZn5akc2muXVK8urYfdcytKYQyGuhYG
 y09s3r/y2MrwK0hBjypsKZETn1bG3C3Erk6iTLCqgU3W1dgHA0m35LsfQGpcszVsQWyAZtV9TcP
 yYkj2/5Xiq3zKwmXosDA0bvEWtOAB9I6etNHyezNdWiBoDD67hnrsjwwfoJNZDe6ZhnYilmVcUZ
 JC4y4x9KcOsk3omkRVnk5XJoj+zVEVG0Tg1Iy3wCWq8HLmIv3TQ4Mb/8YgZx3yvsdsKPVTqPChV
 0uPLj9XiZCMjNdxqHRx99/8fhJDSII3x5C3I4QRlXGt6NUbB0HqZLh/AxOBXpDiFC+yyxGQkFug
 G18O+YApLJdAMNYEVG48bI9bmOAZdOG//l+j+S8lqGVnKAjWW3fSUSmGhFOViuY8w78HcanGKTb
 jykf+E28+cxih/wyZbVZkiendW3LLaqw==
X-Received: by 2002:a05:6a00:847:b0:81f:852b:a931 with SMTP id
 d2e1a72fcca58-823692882fbmr5891910b3a.35.1769632742096; 
 Wed, 28 Jan 2026 12:39:02 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379c21112sm3384629b3a.54.2026.01.28.12.38.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 12:39:01 -0800 (PST)
Message-ID: <e4e159f1-63f9-4486-9dcc-710675018fb1@linaro.org>
Date: Thu, 29 Jan 2026 07:38:55 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] target/s390x: Implement DIVIDE TO INTEGER
To: Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20260127153736.62730-1-iii@linux.ibm.com>
 <20260127153736.62730-4-iii@linux.ibm.com>
 <66027136-d91b-478c-becc-0aa41b40c445@linaro.org>
 <17cd88ba-52b1-46c4-9280-977bd50ac060@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <17cd88ba-52b1-46c4-9280-977bd50ac060@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 1/29/26 00:19, Ilya Leoshkevich wrote:
> With some testcases I hit this condition in parts_round_to_int_normal():
> 
>      if (a->exp >= frac_size) {
>          /* All integral */
>          return false;
>      }
> 
> which makes it a no-op.
> 
> I think the code assumes that FloatParts have just been unpacked and all low fraction bits 
> are zero, which is not the case for quotient here.
> 
>>> +        float_exception_flags = saved_flags;
>>> +        parts_s390_precision_round_normal(&n128, fmt);
>>
>> parts_round_to_int_normal already takes a rounding mode and frac_size.
>> It also returns whether or not the rounding was exact.
>> This appears to be trying to reinvent the wheel.
> 
> 
> Apparently I use this to paper over the above issue, which is not great.
> 
> I guess improving parts_round_to_int() to work with non-zero low fraction bits would be 
> better.
> 
> What do you think?

Yes indeed.  I think (a->exp >= N) should be sufficient?


r~

