Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81491C021A0
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 23:42:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjRnD-00052Y-D1; Sat, 15 Feb 2025 18:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjRnB-00052L-NC
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 18:41:49 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjRn9-0004F2-PW
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 18:41:49 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2fc3fa00323so2045561a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739662904; x=1740267704; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mHWx0lGotZYCRZn+/Owj8m9dq6Cj0zq2Tl4Nnc72hVs=;
 b=VR6kyjSrkza6cgWg/qCEnkd7H9oXMJXIfvYND1L+dkIuMGQmSg6LBUclQndHUlQi5I
 94I80KmCZSeL2v3dI7LG/ngRJ90kOtBlSrsV+jOJVqe8YnlnZILr4O1legqh7frE22mO
 TKn0aLV/7aZ9muSITSaro9i6QnlzoP/a1+rlMySeZhN/A/J874Lmq1U7vmf+PvoTTKdz
 sqxKDR3s1Ud5HKYCfjqJoJmZmZDxX/LoMaBntFcv2cjWZXBFgUtl7JUYkigrOGm2ajLT
 Tfc2MlELSbTQTVgfNse/B7QJ+p11oC175y04OZSPeyE2Kf33Jas49vVnK+gmdtDd8DLX
 aQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739662904; x=1740267704;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mHWx0lGotZYCRZn+/Owj8m9dq6Cj0zq2Tl4Nnc72hVs=;
 b=eDzu3UB3d7InVS59r3NwYNZ0Wqvsue/lPO8mXBDos5KAofQwwvGEOAQU/0+s7GHXZG
 GZ1J9l9aIsAOsl4y0sW/mMGd5P1YJwn4kSK2b7srX3znwSRROmrpo4ZVDeND3ArzR2LQ
 rm7LdERxVqxlWRKE7yBAzg3upN3QLYg4oTwT8iLvG9b3TIA//9+XaiGcl2UZXyCG7B1K
 V5MvrXaweF9536Q12kqLlTi7/fEB76iHK+eVyZ6lnb0AH8g2w2Ub414ZxyItJrKzeIaX
 dPgAqQgwjvbh6DeGpTGeOBVHqO84VY4iYIQUvK9EQo3gBxsqW+9d3yA1MKerJftPSiBO
 Pi0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNxAY1noOoH8RgsFRX0p2VdnUXwb/AGNzO1tFhrCBjX31i4LkqtJh+bK82Syrr4D4ktobaJrdeotqs@nongnu.org
X-Gm-Message-State: AOJu0YyxXwqAxTghsW+z0E5t+Wner5Uny2k0n7Vw3pH+X0CW/CvMk+Mn
 5K2NI3FKjv7hLnK7jUkFkWlntmq7AogHjOxAnw2dWHceGPrldvSMgtdKIQzQU8b5Dui+F+hUHLU
 O
X-Gm-Gg: ASbGncuPGLhbKjx3AJcX3HSDcj478NyqJRGbqdstkLjSWcUJFZEFwPjhjED3N0WBWMR
 6P3vB/VfB5xYbyr8h3rc3J4Lw+IMUinu4xjyL8m9oRelU5ccY/b7CrgvwaQeiI7MDy4jY1na9ut
 Gn0EBh9iS3xZ6/QzaxL4ZRnw3ayyIZmTWLH3ufzm/OuyKKfD0HCX3S1eFj+rieLJExfoPUPw5i5
 Tj+GALwSgRCtf8WLL+2TbWZWEAcF/l65bK2Qtu0fB0IzURMCQyDNn/m/HFttcmsHnLorwRdL8R/
 LgPFgNPtthZRwHBShAzr0ZkN3khiy14VnI6DqcxloWjAQupDAuzc8hQ=
X-Google-Smtp-Source: AGHT+IEYrJgJJM9v3/QqI7S21zB2XoVzqRC4zelFm0zceG/3TfRm9yvH2vmJgEEpdVN5WC7nVk9Qhg==
X-Received: by 2002:a05:6a00:1746:b0:730:9752:d02a with SMTP id
 d2e1a72fcca58-7326177574cmr7041140b3a.4.1739662904546; 
 Sat, 15 Feb 2025 15:41:44 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242569673sm5623622b3a.51.2025.02.15.15.41.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2025 15:41:44 -0800 (PST)
Message-ID: <0ec10457-0461-46e7-95df-a5d1552ab722@linaro.org>
Date: Sat, 15 Feb 2025 15:41:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tcg: refactor pool data for simplicity and comprehension
To: Michael Clark <michael@anarch128.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250215021120.1647083-1-michael@anarch128.org>
 <a62ee246-4249-458c-9f9b-bad79816ce5e@linaro.org>
 <8f107cd4-f5a2-4d3e-b023-5e53225511d4@anarch128.org>
 <38bfbaac-329c-45c8-a672-68cad965201b@linaro.org>
 <6b9d6600-d430-4bcc-9f37-8d8d96d31e06@anarch128.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6b9d6600-d430-4bcc-9f37-8d8d96d31e06@anarch128.org>
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

On 2/15/25 14:40, Michael Clark wrote:
> On 2/16/25 10:50, Richard Henderson wrote:
>> On 2/15/25 12:24, Michael Clark wrote:
>>>> Why?  varargs generally produces horrible code.
>>>> The split between alloc and insert was intentional to avoid this.
>>>
>>> it's pretty good code on SysV because it goes via registers except for perhaps 
>>> new_pool_l8 which will spill to stack and get copied unless the inliner can eliminate 
>>> the copies. maybe windows has bad varargs. but I like the style better than deeper 
>>> layers of wrapper functions. they should fix the compiler so that it produces better code.
>>
>> varargs will generally prevent inlining.
>>
>> Indeed, just a quick look at aarch64 tcg_out_movi shows that without your change, 
>> new_pool_label, new_pool_data and new_pool_insert are all inlined.  With your change, 
>> new_pool_data is not inlined, all the argument regs are dumped to the stack, etc.
>>
>> I don't think this is a good change to make.
> 
> fixing varargs codegen in GCC/Clang would be a good change. count based varargs can be 
> reasoned about statically relatively easily. what is it like with an explicit inline as 
> opposed to just static?

Inline will still be rejected.


r~

