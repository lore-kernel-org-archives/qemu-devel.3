Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5D4C3ABA9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 17:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAB5u-0002IL-DN; Wed, 30 Apr 2025 13:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB5s-0002Hw-U1
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:36 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAB5q-0005Ma-Ml
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 13:19:36 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736a72220edso168903b3a.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 10:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746033573; x=1746638373; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9X63Lgk0+vL2PFMhr9f+SnGmk7U3kkh1SGmOGzf65ig=;
 b=JoFQ46HrsR+nkn42YpFMqQXWCBIrBXGbUelOXySF82V3wIdIbqpq/JNkVRJ3+KICbQ
 6uc0gbcVXU3YOY35/UJ9APwixYR2zMKBDudFCisefEBC3LvednDfpT1MGakvr9F8bJ2x
 iSk4LVJRdikFogeO9jAmb/95Z8HI4YF8WBM11KKEnEYGyCk9MbYO7poTooCMhti8Va8C
 bp+HbP4PY5ODYlUOAwUbueYYFC2pNW+gDnSsV8Dk1b5AKNKM9ymJ3qORSaI4y4+43v0V
 rNaQDa/d+20SUdmwVwCOQJeHjjS5P+dOElLm0ioNZwYpFxA6ZvGn5M9HmdVlSkWR6NtL
 Y2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746033573; x=1746638373;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9X63Lgk0+vL2PFMhr9f+SnGmk7U3kkh1SGmOGzf65ig=;
 b=sJ7ea4aXetmzNTz+mlVQdGHMR2ZnXoSWrfo1dTBD1yv2olFghYINYqOwfv7lIfgle1
 Nu5GXsiazZc9ocRUa5qUoTCHi6ESktcuTHZWyDPyhUU219Iozo/t61CW5VJoqRbxO83Q
 3q0GknwIUm4E43IWQFjf5GwhQH8psnRd3/oln4OkL0PS2wJO4TxqNMEfDCovNrPAqxiD
 dl8dvStU2VM9R7QbvJBRm/gGN709WSUomSDtoUnrF/vHrj10shKOvmv6DzMTeNJH59+T
 fEE/qQGWq8efLyWdM3VWkzOEDMq7s4zhxSMo6kkftE+4FsgmodeF8+AgbWXtuVtdlQCw
 QkWg==
X-Gm-Message-State: AOJu0YyCqjQBGO3REfYstbUy5h0G9etojCRGeApri5e/cHW4V359WCj3
 FqzWYCL8UHpaSF2JxO/7SkOCDsWF76ao+hLZgXAcWEiZs4m7uzMmuA6DmJupR/rEPJuyABVHThd
 A
X-Gm-Gg: ASbGncvP9emMUGjvxj/yVzoGqYYDdCt5oBl5gCGeTLtvzd8htdgIi00/6g1hnMtPxHm
 PMwVKbjsNRafeYqxgP8AoxpO8M1Cibfaua0RQc7BBg3nDo7l9gY+3ZvDtYZZ1q2AbsU2x8njumF
 K9jWNiVgMVmS9D46fg0TBKhrHFUhndvXhC7z18hWtNB48Ri9OjY+fjBFGjcBQe4KpdGoCUDFPsa
 CwCchDacQnrR5qnig9D71E2dXm4065EGn1Us8AeqKDLMadSVc0oe3cMwSNoCNuvMLq1CQRq4j2q
 +5G35KV6mpJU2gUmnEYXJ++2YrAyQBs44DbYPl09YN8H7Ti+zeJyOhG6k7MrtoK0Zyge4MR1tL0
 K9cFlz8Q=
X-Google-Smtp-Source: AGHT+IHZQBsVIhID7jO4yRojWBB5z9RPM/8bO3Wp3VotsZdvnxD0cQW079+TPWsbfwx7x8wJ0ccUhg==
X-Received: by 2002:a05:6a00:1942:b0:736:a8db:93b8 with SMTP id
 d2e1a72fcca58-7403896034bmr6236454b3a.3.1746033572955; 
 Wed, 30 Apr 2025 10:19:32 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74039a31018sm1913001b3a.113.2025.04.30.10.19.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 10:19:32 -0700 (PDT)
Message-ID: <47be9d89-026b-48ac-9ebf-89902a2ec5c5@linaro.org>
Date: Wed, 30 Apr 2025 10:19:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] target/microblaze: Delay
 gdb_register_coprocessor() to realize
To: qemu-devel@nongnu.org
References: <20250429132200.605611-1-peter.maydell@linaro.org>
 <20250429132200.605611-3-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250429132200.605611-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

On 4/29/25 06:21, Peter Maydell wrote:
> Currently the microblaze code calls gdb_register_coprocessor() in its
> initfn.  This works, but we would like to delay setting up GDB
> registers until realize.  All other target architectures only call
> gdb_register_coprocessor() in realize, after the call to
> cpu_exec_realizefn().
> 
> Move the microblaze gdb_register_coprocessor() use, bringing it
> in line with other targets.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

