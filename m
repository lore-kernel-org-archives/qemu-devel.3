Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5067CCCFA05
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Nov 2025 16:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vH2QL-0001yD-Kt; Thu, 06 Nov 2025 11:01:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH2Q9-0001xy-CI
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:01:09 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vH2Q7-00056L-Lw
 for qemu-devel@nongnu.org; Thu, 06 Nov 2025 11:01:09 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso1716147a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Nov 2025 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762444865; x=1763049665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DJVRT0UFdOFrSp9oGWjSJS5v/sHehnZWwIJQnJtn7hI=;
 b=YCgqLEgLmbeSOthNdd6FtnZExWwO3xlFinICjxGdo2TjybktZgrMYUFclP3t7IN+lX
 SXrnmU6kVaJvy/gDHsnP4rQbGri33YVNe4UMiW/jSg0UldwYF1LSC0eNbAK4u6+0/Hxd
 /YAr9WD8G9sT3NP7ZssHrQwOBxU1fhe9aNjN39hWwYU34eoR89UM3OGqiaLfpPskiHTm
 6MhzDdpTurSSXiPb3OSwLJdHESo9ipUINUzlF0zP+Bv20lq6MZNng7x/7bQgyc5wKxgo
 gwWfHexLsr9EBGE3PH8A6+OFzbpRaAnlIBYoccxV+j399hbOP5m//Jwk/Gr1dsoLp0bp
 hRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762444865; x=1763049665;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJVRT0UFdOFrSp9oGWjSJS5v/sHehnZWwIJQnJtn7hI=;
 b=kyFMUc61G8W1CMtyymT6uD3yGV6I0tLW5UcnnCbIKq1kTTaawsHzhYa84YBrw7Vdbi
 20IlIty+Wraf7GhsQCuybx21ZqbHtUYIDnsfRINBdH511toU/jsdK3eIzlQw1u5gQObE
 sCelRDzuwToAOjKundVICv5hgiIlrRKYKhD3l0E2hE9m35qeklCXfBMk8iPeVbYnDPia
 B0HtSJq6XBAvkTUAfvofibVgCnHhrqVAp77U6K+rxfsulahP2TdHRSZLDBwXIZFZ0TiZ
 9s90gJ8S/MEyrGWSgGuiZQp5vOccKKN3fNEtIYryEYSNhxJna0djj7ndT2nWQvhayBT5
 uwAw==
X-Gm-Message-State: AOJu0YySCyLA8Rl9aZrXB5F+8r2c356RW/kCRaPPQAnSF+l3lFTW4eUm
 gtpKovtOiqgTty5betiqXrXaKIH9c/XSe5pE+4pyEd/niqmgAAirzXGGODyHJQdXcSc=
X-Gm-Gg: ASbGncv4noO+m5OkhYzdawE5Pr9IaMYZTY+9R0pUn7xRHlx9wNy7jf3WwOxHP4hQrEP
 /jfZmjnR8gIDGhW3l5Nt6GLmCiO1QNgwX5pn71O4W1VR3qMdor1NPnpjzRlKIrovkvSR6MXX7uD
 kgqK8RQFRNwxNjQ1HvGoYse3jBwDRM6Fxm+YeQwCKHOSnFMgjfM0ONSHhMDll7Xek8FedGOV4rr
 NZNyS2SZIobLLn7fSIntjbCOj07TenugMvESw+tRwDQxQAU1WFPmOEJCDtxSUAENuciCP4dY2Ea
 afBfy/IOhVKPuvmY0PKRlX/I7pZmT0z//hw6pNpXs/Xl0+u9sAvB3lg2D6AWGGWK23gOw3/Pvly
 AtgFxMw4mC6nQg+HfAMcRy9VhvNZyXCExlpeszbclSila++jgGKCoYldc5Nsf6D+T+z0YC+FY6w
 eqSzTRAxEDJ5ubpWYVx4Zthj2zbH3OdsNT+x/vuw==
X-Google-Smtp-Source: AGHT+IHxU9cxyG2o9WRicLBRDy5e5nbukyJK3KjtLqHStND0frNtL3b23jrf41fyF6P0nXMgtBqPgg==
X-Received: by 2002:a05:6402:2688:b0:640:b373:205e with SMTP id
 4fb4d7f45d1cf-641058d6595mr7056709a12.15.1762444865197; 
 Thu, 06 Nov 2025 08:01:05 -0800 (PST)
Received: from [172.20.148.100] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6411f8578dfsm2135641a12.24.2025.11.06.08.01.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Nov 2025 08:01:04 -0800 (PST)
Message-ID: <40afd528-ece1-42eb-8d02-d2094ebc58c9@linaro.org>
Date: Thu, 6 Nov 2025 17:01:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Fix accidental write to TCG constant
To: Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>
References: <20251106144909.533997-1-richard.henderson@linaro.org>
 <5ad511f4-eb36-4d49-90a6-fbb1e5f67c6c@linaro.org>
 <CAFEAcA_gkyMTynt6ndVCDaq1RwwvpOUbYNm-=RjE17xuuTTCyw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_gkyMTynt6ndVCDaq1RwwvpOUbYNm-=RjE17xuuTTCyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x52e.google.com
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

On 11/6/25 16:57, Peter Maydell wrote:
> On Thu, 6 Nov 2025 at 15:48, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi folks,
>>
>> On 11/6/25 15:49, Richard Henderson wrote:
>>> Currently an unpredictable movw such as
>>>
>>>     movw pc, 0x123
>>
>> bah, how did you get this insn.? Are you using any fuzzer? :P
>>
>>
>>> results in the tinycode
>>>
>>>      and_i32 $0x123,$0x123,$0xfffffffc
>>>      mov_i32 pc,$0x123
>>>      exit_tb $0x0
>>>
>>> which is clearly a bug, writing to a constant is incorrect and discards
>>> the result of the mask.  Fix this by adding a temporary in store_reg().
> 
>> The difference between v1 and v2 is:
>>
>> v1:
>>    mov_i32 tmp3,$0x123
>>    and_i32 tmp3,tmp3,$0xfffffffc
>>    mov_i32 pc,tmp3
>>
>> v2 (this version)
>> and_i32 pc,$0x123,$0xfffffffc
>>
>>
>> I think we need only a v3 that updates the commit message since we
>> are not adding a temporary anymore.
>>
>> Interestingly, I was not able to crash the host when native code
>> was generated from:
>>
>> and_i32 $0x123,$0x123,$0xfffffffc
> 
> The commit message doesn't say this crashes, it says it
> discards the result of the mask. (That is, we intended to
> clear the low bits of the guest PC but don't.)
> 
> Should there be a TCG debug assert for "TCGv for the
> result of an operation is a constant" ?

There is, at least with --enable-debug-tcg.
I assumed there was a crash from the description,
but I haven't yet tried the test case Gustavo put together.


r~


