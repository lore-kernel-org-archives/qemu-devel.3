Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C101C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 13:10:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubfOd-0002YJ-D7; Tue, 15 Jul 2025 09:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubevq-0004B5-EK
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:38:51 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ubevn-0001rX-C4
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 08:38:50 -0400
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-73d0152369fso1885072a34.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 05:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752583123; x=1753187923; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZUv0KmfMFlv4nuLCoOZPi29XPaIigvkXKS2ApxgMpTs=;
 b=XdbgDGvrPujp34P0N8VWuyqj5F6Xt5aqN+SqhU8z67gmC+Zl035Rmwxq4IDC6CYc5h
 O7RA/HqtRVkwOH/vgf3SlbTq6ztez8OfsxrvYLv/rhdmdB87KszsOiS+WdsU09cj0A+6
 83RkL+6PTGKqoEy8rJ9O2inPDr5+swd/eIyoLz1XRSbecffxaXS8b0rlpyNtfPdA1HmY
 1XgJAwT4PPE4HVlcXC11zKgUJAEO35ag4ISvbjWNKwhErUdGEURD+P0y9RJkfcg51Jve
 VtoUmLTz1zCqhEkKyZdlP590T8Fp8mPa4ZcFLcpy13ebGXgj5Emqy+1AKORFhy4avDF2
 KiAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752583123; x=1753187923;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZUv0KmfMFlv4nuLCoOZPi29XPaIigvkXKS2ApxgMpTs=;
 b=gOhkJCJQe0JJe7PbVtBiw0VClC0JQuKkBiuTKVPC5MF/qapPpkMQ/Ie4KsNWHMUQnw
 GBolJIKeahuoVPdsoK7/kNclAQtIqA10/+7ObOinQgW7CX41mYPr4pQ+4Ovvp5On2J4N
 fCEkAatikg4zsQT91LLdV4RMdIqg/YCuaF3/Lbm+VeeN8t76TOzGLcuQeFop9X5P8dTl
 Q/4VJIHiZnhRzYuGf759AXBTnrq1yiuoN+Z/lp3TK5Pp478TPwefwr7oSdMNZK2QQe6u
 rbiGOH7igAO3dIPg0DYrXgbfLXZI2oSBTcVzNZ9UHamL3Pym2ULkuPzHRP9jUiZOAsvx
 ghsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCUjnDVfBS1ywP+aot5ZlTLxUFaKouyIrSzcFJ1X9EqudQ1t+Xa5SW39s2EFYnL8u863UWsEBD9+VF@nongnu.org
X-Gm-Message-State: AOJu0YytbqyErKUi5IZQ4LMiuwW4oXswlhfqLcI5fev6RAvu7+zc7F9q
 TXtL6sn4VmUKuukI8YdgvBQ4k5Ga/onQgmaxmwbKiLvqAwWKl255S8KbYlH1l2dUJmU=
X-Gm-Gg: ASbGncsx0dsq73/LReWtwcrd2QLBaUCwRtxutPqOODZVQCyFlK2U/IgxVfHxn+NrPiQ
 7I43ho/tqKQbZK5v7ZsafYd6KDEj/yn3UaTOxa5BDFFbIxjnBLc8ZirVF04KKS+psim9x8oQQeM
 lMgvSb0jQSVOMWYyt3bRkMyGRTRu3hgOFqMxdPejaJ2n5rta7iu4Tly68bcQ/tESY0L5QTp3BuF
 iTVz2kyGo07DKRQPSrYcINgcq1Uklvhs7RQVYu+pJsem9y6jAm6NPftSfPNVXObTvQywuBfP9UB
 ni8Txwmol4nmZizAoHvnEpf8ct8uN518gI5epO4J0pdTLqwh9OneM3cQKQESxe7PvijPlG5ovAv
 5ERfX0AkyencVunt0UjoHpbQT/Hbpg7vGHS9DhaqIYClCN4NvwFZ/ioUa0CDTiK7UrUEJGK25Z7
 WbqEwgYSBPnec=
X-Google-Smtp-Source: AGHT+IGKHVUT9nMul9ApTkE5ct83e3rW5XU85beeF2+kg25Jv9UqgiCUS5f/P/+SKtjqFK3BS8bgJw==
X-Received: by 2002:a05:6830:6387:b0:73e:54cb:1de5 with SMTP id
 46e09a7af769-73e54cb27e7mr4016933a34.28.1752583123521; 
 Tue, 15 Jul 2025 05:38:43 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73e54544699sm600564a34.51.2025.07.15.05.38.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 05:38:42 -0700 (PDT)
Message-ID: <9cf478e2-1607-4cb7-9769-70d923a672b3@linaro.org>
Date: Tue, 15 Jul 2025 06:38:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 v5 1/7] Revert "accel/tcg: Unregister the RCU
 before exiting RR thread"
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Eric Blake <eblake@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250715104015.72663-1-philmd@linaro.org>
 <20250715104015.72663-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250715104015.72663-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x330.google.com
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

On 7/15/25 04:40, Philippe Mathieu-Daudé wrote:
> This reverts commit bc93332fe460211c2d2f4ff50e1a0e030c7b5159,
> which was merged prematurely, re-introducing Coverity CID 1547782
> (unreachable code).
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/tcg-accel-ops-rr.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> index a578698d071..6eec5c9eee9 100644
> --- a/accel/tcg/tcg-accel-ops-rr.c
> +++ b/accel/tcg/tcg-accel-ops-rr.c
> @@ -302,8 +302,6 @@ static void *rr_cpu_thread_fn(void *arg)
>           rr_deal_with_unplugged_cpus();
>       }
>   
> -    rcu_unregister_thread();
> -
>       g_assert_not_reached();
>   }
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

