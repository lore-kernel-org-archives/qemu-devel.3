Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8FCCAC597
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 01:01:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyK3p-0001gl-Ah; Mon, 15 Sep 2025 21:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyK3a-0001VJ-MZ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 21:00:31 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uyK3X-0006YZ-QC
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 21:00:30 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b4f7053cc38so3198177a12.2
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757984425; x=1758589225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4VORNWWIAd7pPP67I1ECz1kK2tfhafOoMG6VBf3ICpI=;
 b=cqGSLfO1R2+THBmJnsH5vOciS3RSI4KWOxNySDvhEX+vjNVIH0cWSt3Tg7qxYduzRj
 mCNmouHN+ID3KIa/xsDUf5aVQmPkvJrZmr3Uymd7XCkEI6FG/LywUkwmR3jNxafKUvqu
 aOGeHJ3A60vUMgRQqIKGIMztDsfNi5KlSIOJXybdGSdDvIzL203N0R9d5keFJcdc2R9C
 u803KNLiRBaj86oUJdUZkhKMB908qxSN9tjGXyzXt5gw3TYdXnbN38/uNNopCX3x6flw
 xvYENZ8RvOBESJO02XpUhy7boh0diTUu0nEoE99YMqlYL63dIJRWXjMK9j/VDyhGFwSo
 q4tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757984425; x=1758589225;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4VORNWWIAd7pPP67I1ECz1kK2tfhafOoMG6VBf3ICpI=;
 b=EeUTCAn+zVuUg7c0WP6NM754OJAlKnLqq1eOx2dbZxvu7rJsRG8n2661YChLfvVbtC
 ho2U/0vXDXld5ak7/k75DRiBwo5QXkG3nSV2oKqkTUCReWIH4ZPJQtJMH36Zf9j5/UCY
 w0HMYLaES2gvqxAJNf6sh2b8zo9qkE2QJEqTsMLRM43VA3AVfN4Z3xCrB4R7vxdZskQB
 JH2d430I1jryQtfJJob6xPtB/MOMR/nXNifGvrDTSOkMikLXmsuhJbRTnFpjFsyWU732
 NFrcfuRH0afBRxQj+GwWxqWMfy0WoFcNs6zcFTa2BAOlz1xtTRr/qY2q8m7CkTlzFcCq
 mLcQ==
X-Gm-Message-State: AOJu0YxNTyjCeBaexYRlj6L/pPC6w2AzrDdzUKYfGvwokrIiRyKK4+Ws
 ZdRXDuJdR9L68RWE9lYsw3ws+7XnNs9DewqFOKJ8DebwvWD7yarqvbf2eismsTOJeyw=
X-Gm-Gg: ASbGncsV2RCwyFGTYond9gWSsfmC4MvP643kf0g+RR9ufjHm3EriQ/uZIyKil+D+XSt
 ORBFH7IOW4Ifg7iyrZ0KE/mdfROO/+xxO5Qq8AucFGGNxZGVxSypPHcui7s0YUDm+1BQbRorb4x
 VGERQukEK+pQkVayVouMimQ18XtbcMOsV9ITHDLy6Ij9RpFASAOt8eki/fOQPEqMf0YVs6rBYrC
 s61zcH+kyBijrh5IsopGdD2biuK4H186IqiueTpTetVrf0mVT3qH2BZXj9XuG15KaPIY5wpL+JM
 kdIN6NjB5YRa8Qghyl/Syw1Ut52J/oBK+19PneGj4tmzUEXaRDdK1S2JgbQaUGoHLZOZ1YIW3wd
 Crn3iSj3ZQ+ClA1Cry9yV05wrkleTAwAxw9t3
X-Google-Smtp-Source: AGHT+IFRcreltfXmPk6Fe8waennf3Ep67ETE6Ctbbjylwf6R9MgVOl/jO5RhLCOc4Bxz6mx1BCY0qg==
X-Received: by 2002:a17:903:1b4c:b0:24c:965a:f94d with SMTP id
 d9443c01a7336-25d26a595d2mr184714495ad.46.1757984425065; 
 Mon, 15 Sep 2025 18:00:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-260cf673181sm85284995ad.99.2025.09.15.18.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Sep 2025 18:00:24 -0700 (PDT)
Message-ID: <961b4cc0-4705-41c9-a575-2fba28d7a938@linaro.org>
Date: Mon, 15 Sep 2025 18:00:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 55/84] target/arm: Emit HSTR trap exception out of line
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
 <20250830054128.448363-56-richard.henderson@linaro.org>
 <CAFEAcA_1QRqHm-CsNn1SsvxiHybRDRob3fvn8U38uZorYtf0Ag@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_1QRqHm-CsNn1SsvxiHybRDRob3fvn8U38uZorYtf0Ag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
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

On 9/9/25 06:33, Peter Maydell wrote:
>> -            TCGv_i32 t;
>> -            DisasLabel over = gen_disas_label(s);
>> +            TCGLabel *fail = delay_exception_el(s, EXCP_UDEF, syndrome, 2);
>> +            TCGv_i32 t =
>> +                load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
>>
>> -            t = load_cpu_offset(offsetoflow32(CPUARMState, cp15.hstr_el2));
> 
> I almost certainly originally wrote this line with the declaration
> of t and its initialization split to avoid this awkward linebreak
> that you get if you put them together...

With -ftrivial-auto-var-init, it's always better not to split declaration from init.


r~

