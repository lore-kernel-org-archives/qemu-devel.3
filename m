Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F00F4613F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 22:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4o9T-0005Ma-8r; Mon, 23 Mar 2026 18:53:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w4o9R-0005M2-Eo
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:53:37 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w4o9P-0005zD-Tn
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 18:53:37 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82a62714fe6so2265739b3a.0
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 15:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774306414; x=1774911214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nnEwQW71vA0cbEd0rFbBZYeSd3+uRgA/hncDuuGIaAU=;
 b=fH7v9aPXSnhMUivxKTZ2Q3anaYsUTB4sl/ZP/ib0UPXzXhyzVefQscBvmyI7r9TLip
 YVS++eT8oy+FOhQ9xyzg7sZd5nqTo4i2ZyMysQ3c9cLxU2saDkAgRaA0+OvjmGkvPkOM
 PUVrgteXeJBxdd4gPuZPBa+soWL+25K1hIu1y7At2VcPYJ4bjcaz+f9ZL8z1xigK9Q68
 aNKud2xHtYPK9ZMkQbRg/0v/osNFAox5ji4N981AYPT4pt/s8LBo4HD9fcpaY9vB8hWJ
 5nCbGuKs2OYm4XoPAb5AllQzd5Ii/3EpwNikSOI9ox7APatvt7ZMV0kgBluAq5hrr0Jp
 tQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774306414; x=1774911214;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nnEwQW71vA0cbEd0rFbBZYeSd3+uRgA/hncDuuGIaAU=;
 b=bz44ncGwFIN0GaR6k/j9BdXqGLwbYXNDZE2KdgtDRdKzIhImlKqpWkhrXFaO22dvVw
 KILKM1uGipmvpaHDWW61nPXRPbEaIvg3egpUwzKALLVR7v0c1ZLtK+CeRkU8sbM88fLd
 aE4KdgFRCrYvCVvG+T1hufplMWs6NuaqDyy27AwWamVdzra25MQSos2O2bH+u092Xzuk
 bQuFNkK+VU+lk4MY1yNWSOWgc+gSMe71DJpXrQEPwzKuJDoByKCK79I4bkR+2/IOOcsF
 Si3hzs+ywMDr7atiFp6MvZcz9CO5g54xf5H2bLcygLl3KI8kSgtKanuB8W+Uuea+exx3
 +lDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxOieODgArr5UlspZYTJWLu/lmxhUIK49IpVybcgl8K2Zgrmk3wTJ7zUUp0ibpb3I4unC984IAlsck@nongnu.org
X-Gm-Message-State: AOJu0YyvCQ1GYfxUiLp0D1rjzxHXPuYxzHR6XzMVzmA5rvcIdcHwOpZu
 eNyjMX3t7Wl/EWWwC+sVi0KSXqipk+LMU6zQTFOCg+lf3NCCyrHHK5EpNgRxa926IYA=
X-Gm-Gg: ATEYQzx0W9IZAppNZRcasfoz4jd4OCO1YNjq7XdUzYNZtDUjO2RIFx2TDAcByiGFbBQ
 b/RQHcFcTpB8G998H0YN/4J1h0cFr873AqJpa8w5NYg+UMC+ycxhbbzHTlTfuEZ9ZTWXMwXbDCI
 6HDoTHjbPuQlmCJFCg6X2Xq2/QC8HYxr1J8SmpjFTPRPQAvf53hrp+f0gnD5ES3PXwSBkdXIZ4w
 enTYFpmef0zYXwOAL2bX8ggUnaexsgNkCFKY49lNDQ8eBPpeeGCKGnauUsjjDd8+/WK3sCD5oNN
 Bk8l2kFZVUHLE5AIKm4nuXeKU1q99/whFJLSPrXAKsTx4imCvUo8SZgYgN92czf9pMzKpjXyfBV
 NlkJoQF0C+iUPBzM1P5fNF5++9w/eK+CfPbPnGaF7J1KWR4coi4AkYUWY7uGz42xLFgFxkpPA75
 hmUWJ9jWYC2NkM9QyKWZ04IBUDv+93wtg3thZ0vjDzWQ==
X-Received: by 2002:a05:6a00:4207:b0:829:acf6:9406 with SMTP id
 d2e1a72fcca58-82c5bf009f3mr845080b3a.29.1774306413234; 
 Mon, 23 Mar 2026 15:53:33 -0700 (PDT)
Received: from [172.16.11.156] ([103.100.225.140])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03aa5a9bsm10632687b3a.8.2026.03.23.15.53.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Mar 2026 15:53:32 -0700 (PDT)
Message-ID: <b20eb2a7-1386-477e-b3f7-e5ddffdd62ca@linaro.org>
Date: Tue, 24 Mar 2026 08:53:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Linux user for v11 patches
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Helge Deller <deller@gmx.de>
Cc: Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 qemu-stable <qemu-stable@nongnu.org>
References: <20260313183009.34221-1-deller@kernel.org>
 <66022765-b7b8-4f46-a90a-43dc473a16fd@tls.msk.ru>
 <0864102b-f32d-41a1-b19a-7eb9b237b368@gmx.de>
 <389cce41-5aad-4703-82bc-dfb9a8f7e774@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <389cce41-5aad-4703-82bc-dfb9a8f7e774@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 3/23/26 17:52, Michael Tokarev wrote:
> On 16.03.2026 20:00, Helge Deller wrote:
>> On 3/16/26 14:43, Michael Tokarev wrote:
>>> On 13.03.2026 21:30, Helge Deller wrote:
>>>
>>>> Razvan Ghiorghe (2):
>>>>    linux-user: Fix zero_bss for RX PT_LOAD segments
>>>>    linux-user: fix mremap with old_size=0 for shared mappings
>>>
>>> This looks like qemu-stable material, is it not?
>>
>> Yes.
> 
> ..with one caveat: mremap with old_size=0 fix doesn't apply to 10.0,
> the current LTS stable series, because 10.0.x doesn't have f55fc1c092
> "accel/tcg: Add clear_flags argument to page_set_flags", because of this:
> 
> +        page_set_flags(new_addr, new_addr + new_size - 1,
> +                       prot | PAGE_VALID, PAGE_VALID);
> 
> What would be the correct construct for this for 10.0.x?
> (Adding rth to Cc list).

Probably

   page_set_flags(new_addr, new_addr + new_size - 1,
                  prot | PAGE_VALID | PAGE_RESET);


r~

