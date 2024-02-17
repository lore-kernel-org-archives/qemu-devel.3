Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8857AC48BC3
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Feb 2024 19:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbQCw-00072T-MU; Sat, 17 Feb 2024 14:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQCu-00072E-97
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:18:40 -0500
Received: from mail-il1-x12b.google.com ([2607:f8b0:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rbQCs-00033z-Qg
 for qemu-devel@nongnu.org; Sat, 17 Feb 2024 14:18:40 -0500
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3642281e4a6so5117335ab.2
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 11:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708197516; x=1708802316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eKuVMYufUwhI95mBir2EZb5PIP2P0JSyoSzdPq3E3MA=;
 b=PXN9u+RXqFGXZWDqeM7teIIhgQmfFwI7ZBT0gFX+rxLAd9trNqmYLPqq6AS8mRMecY
 vyTsjA0UszvT69ZnyjWef9Rl/v35DKzw9YCTnCEbXR3BvCNyfsT0vKJyn60eIHHuPx8m
 5nsBrURlpvrU9KQpJEHa8ZZWAsrDVbcyVIj6UFltZUG+Vd19xBZtNnzMidHegvXLfX9h
 JzWEHBSf129IxvDHSQ5Qo5KAXk0in0jEJxy7/J4aGtulm+NouobSfE657i5GFGBNhE9k
 23b1hP9+LX00EbvcCXSfW0PAaVpJvx21jOv77Dj6CEcaFhwFYt6ppU1W4EMWxvxtHTty
 xJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708197516; x=1708802316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eKuVMYufUwhI95mBir2EZb5PIP2P0JSyoSzdPq3E3MA=;
 b=dOCvSbiqb+GoFnJWf1LsyhWm5fQj6cG7+O7rijNS6BLkKjC6aWZ70+P6Jr7FI7Lv6j
 OhJN46ErCHoUwEskM17pbzMSJAAo7uXGN4Thv8rUv1tAqEnqQnnEzu9vVW2f1orTHt4c
 Lwyl8sTyNUbC3yWNb/8qAOMjh1iT58gV2+pT7hri1X6vTeCz/2DEexSPuRe6ihk0YOdQ
 bxjP5jCqPypKuMJyh08192NXpzhHaTZauV+k3/8s8mMws81CK7dy9Hoz/0q2HLNBRdym
 UaTNTqYa6SwUGWwlfNMOUyty36LsBh/OI4P95ZlwYOnnbxcpN/mqzguiudvE8HYw7unR
 VRGQ==
X-Gm-Message-State: AOJu0YwUwq6ps4kfa+uAWRA1rWyKgDE3sK2xYjWFbP7hWN9ATPYIP3My
 /xSq8Pvw4wTgo1LWU3vFbVXG8k0zYv8pyERO2mVHdHt8c9Cb+IjzsC71CS5grxY=
X-Google-Smtp-Source: AGHT+IFFBLQTYW6A9zaAWLChWKgTp8r0duvQ+attu06diavGwupAzduDNoYigVFz3Bl9BhqhiFnyCA==
X-Received: by 2002:a05:6e02:16ca:b0:365:147e:f810 with SMTP id
 10-20020a056e0216ca00b00365147ef810mr5555274ilx.7.1708197516541; 
 Sat, 17 Feb 2024 11:18:36 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 k15-20020a6568cf000000b005dc5129ba9dsm1638118pgt.72.2024.02.17.11.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 11:18:36 -0800 (PST)
Message-ID: <5a2d99cc-1349-4174-9adb-3742caf1ae87@linaro.org>
Date: Sat, 17 Feb 2024 09:18:32 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/10] util/bufferiszero: Improve scalar variant
To: Alexander Monakov <amonakov@ispras.ru>
Cc: qemu-devel@nongnu.org, mmromanov@ispras.ru
References: <20240217003918.52229-1-richard.henderson@linaro.org>
 <20240217003918.52229-7-richard.henderson@linaro.org>
 <0a4bd5d4-8632-78ec-e68f-be349fff2ed6@ispras.ru>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0a4bd5d4-8632-78ec-e68f-be349fff2ed6@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12b;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12b.google.com
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

On 2/17/24 02:13, Alexander Monakov wrote:
> 
> On Fri, 16 Feb 2024, Richard Henderson wrote:
> 
>> Split less-than and greater-than 256 cases.
>> Use unaligned accesses for head and tail.
>> Avoid using out-of-bounds pointers in loop boundary conditions.
> 
> I guess it did not carry
> 
>    typedef uint64_t uint64_a __attribute__((may_alias));
> 
> along the way, not a big deal since Qemu builds with -fno-strict-aliasing,
> but I felt it was nice to be explicit in the code about that.

I suppose.  My thought was that because of -fno-strict-aliasing, we don't care about 
aliasing anywhere else in the code base, and then explicitly caring about it here could 
cause confusion.

> 
> Am I expected to give Reviewed-by's to you? I did read the code to the
> best of my ability and did not spot any issues.

r-b is not necessary, though thanks for the review.

>> +    /*
>> +     * Use unaligned memory access functions to handle
>> +     * the beginning and end of the buffer, with a couple
>> +     * of loops handling the middle aligned section.
>> +     */
> 
> ... here, there is only one loop now, not two,

Thanks.  Fixed.


r~

