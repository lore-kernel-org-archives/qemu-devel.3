Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201C1C282EC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 01:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuhsq-0004Q5-Tt; Tue, 18 Mar 2025 21:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuhsb-0004P0-Dd
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:05:57 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tuhsZ-0006pj-Mz
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 21:05:57 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-226185948ffso55649585ad.0
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 18:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742346354; x=1742951154; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iiCqOqbCqZ6SUNcJL1HC0yhXOmXipRE090pD704wPYs=;
 b=pOUk4WcjZUkr5mVRpSrz8rEeFxrGXAai+vcVRkDa/K+WLON0mCt5VkfYJYjJthau7m
 fnGPoB24vNWfy7JktVSKs90CljwdYHMVTOGLKvV37hjamrRX5QDz/pAPcOG7toSYcT//
 i30R1BD/SSg8cZWtAyHTxcm+g5T9rpNiX1aOIsM0ifDfrrGDiSSVp4YWuQ2uF5zRy2Q3
 xquO1e/Y9pu6RXpQBtjzuKczDX015UfV73iJit/aDfo99k4RQz6XZgMl3lc5LciIgX1x
 GQw/iVYGpuf3eTIkYjuyqAzpqOWtNkoF/8NnM33hWn8RodVEccdracXB+BsKWyVDQJFs
 2nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742346354; x=1742951154;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iiCqOqbCqZ6SUNcJL1HC0yhXOmXipRE090pD704wPYs=;
 b=jSCmYXfoq9KtDPwLYc8eZZCc3Zc7bGWF2lKjScHHJWPD9j1fSQeW/r6rDoSQoWu29S
 CfLzAYoWGpBJMOkbDElWxZ+PUU0Sv3IOZu+H4yyK0+f/d8fVbjOSsFs7UxzVA0kda+pb
 Y3nW9S3cm9RyseKaGFcbv8BlMSS5IL0auZzPLN0DBn30gqFUVOfhFV2+IM988KfLNxXw
 SwdrD5Uk968AzNMtdjXY7mStbTNmSXItpFZUh3oUvK4mtPaahML48y5gXLEbE4W19CYW
 FTuJJmalY5NOYykr+l6rbwvwkTX0z3AboZMMmJzVz+ECFkquH8EFBOxAfi4PepH8IZS/
 7jbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWp/XqiIBdopWqvYLPNhqyWwUb9A15jbTWYy7A1bl6lbxnbqwTGNuV7y0XLLOCQpGRhYwmeY9+bTzc@nongnu.org
X-Gm-Message-State: AOJu0Yw+D0sUlHG+QEeB+MicEKSLn+1ko26kpMyUtfCd3E4YVv/jCdiO
 vdHWehsJEMTDvYDNNl1YukD+tooKCc8Fk41dqA/uqTG65amaW7FwOSRLvXKbOs8=
X-Gm-Gg: ASbGncuMNUdu2YeG4+X8fU8YbvjY4gzge6b+3MKiXna0y8CqzQKl0qT8s/2Lo3RsxIB
 u1mT8Au3m8q+/jHZHQhOctepgk7rWVZvWSyNEbj15B2ef2W/MoGhVelJVstjbZ4xSxhunLe7tXf
 b7OkhpPm7JxnbGuq5Bn8rxcB2ixl4Stu4TV4bBBoc8G/qLmToYm8tpv2ymBzz+B5DiUVuHmNoiO
 MCTKkpeFn23OMD9LKDiYfjwBm30Bu675E0T7O4lub0PCGBt1VuQFR/cIZb0Z/jeK1WKapzEMc8W
 DLq3Rl++S1HMZ+wZeHdBSw9Uksd14NsbQJbqyw3EGOscPVRrf7QXssOtPEu+vKa7RLP3zq3Xp47
 jZ13nJU0O
X-Google-Smtp-Source: AGHT+IFm8GK/hm+uDFqBgRSdANq27JcXvcokh28ymk3DH32ywWS5VI9AMURo02A6TC6cs8wDKZZyhA==
X-Received: by 2002:a17:902:e882:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22649a67f8emr11989775ad.53.1742346353586; 
 Tue, 18 Mar 2025 18:05:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6bc012bsm101557595ad.205.2025.03.18.18.05.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Mar 2025 18:05:53 -0700 (PDT)
Message-ID: <d76c9ca8-3f3b-45d6-9ea2-b53ff59ae7e1@linaro.org>
Date: Tue, 18 Mar 2025 18:05:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/42] accel/tcg: Fix cpu_ld*_code_mmu for user mode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-4-richard.henderson@linaro.org>
 <de8fb1b6-0aef-47aa-aa17-37d836b5b983@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <de8fb1b6-0aef-47aa-aa17-37d836b5b983@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/18/25 16:52, Pierrick Bouvier wrote:
> On 3/18/25 14:31, Richard Henderson wrote:
>> These routines are buggy in multiple ways:
>>    - Use of target-endian loads, then a bswap that
>>      depends on the host endiannness.
> 
> The code is very similar to do_ld*_mmu functions, so it's subtle to notice.
> 
> Was the endianness bug due to the fact we use oi (MemOpIdx) directly instead of 
> get_memop(oi) (MemOp)?

No, it was due to ...

>> -    ret = lduw_p(haddr);
>> -    ret = ldl_p(haddr);
>> -    ret = ldq_p(haddr);

... these being target-endian macros.

What was intended, once upon a time, was ldl_he_p etc,
so that the load was host-endian.  But using the atomicity
routines is even better.


r~

