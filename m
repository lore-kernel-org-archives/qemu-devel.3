Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A159C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9n0-0000t5-AA; Sat, 21 Jun 2025 21:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9my-0000sf-Dn
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:32 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9mw-0004Ml-JM
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:46:32 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso3092765a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750556789; x=1751161589; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WxBcgqO+IT207a+10UHqo+r/fYRXljiR/ECJ3qAyr0A=;
 b=Rhed9iKEZvBi8REmYSZePJUtwbose+bSpjItRzyib+6l55eOMSPte4m1DVlEB+3gmN
 B12n6Nh+HTVqD1BQVrVdH/sALL4VEW/ihO9Fp/xS0T3R+02mWnCWkbkr53Xk5aIiy80o
 J8MHUx9ODLJXOxTrx4IzNCPLpHOdWt0q5hzEV5gzPx8rZONEqDkvkP65YVP4JnYfNjgz
 EuqYuNLysyq8yVRBo3zt2Aj0/7Tc+BW1TRf+UXZqQyawnhjRRZM707zLommbmnDP7s45
 imiyZlm4j1a9zHh+5bIHUZfcdVZFcpjohMwVViyEnlemQSAa/GrcV/ELCPVYZVT6TIdO
 HZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750556789; x=1751161589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WxBcgqO+IT207a+10UHqo+r/fYRXljiR/ECJ3qAyr0A=;
 b=g7DfpBvPUY1JSU1SaDuzvDJbg+ZMGdtnMzIPvBwpGW7XCEqjiK+HiT0Ew/rmBBJSrC
 ACDibooxT4oWO+4bxlcLLtJqhysdTQTV++Hq0hX+qIVhzyI5/n8Kqh10OOKxe1Smh0gp
 FQdn6Gbg9PWGo2KihgmiD5+V4NYsy/dA7wl/5PZaLXF4iiWtmdPN3RxW/UwOiAjKnvv2
 VCn6ekPSc01A3519Y5hJA5yiXdU0yZpRi/33VP+m0U3fJeHfO4lfzF6YIsoG1YeMObPG
 OZlKwAJQh4iqNmXBGhOFCmi4DRNcposPdtACC0kOi7tJzuUOges6ziwbWaC3CiLpZvP7
 5mnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEeAsAPi7FdeVnUoluygn+ULeJOZmJxokrXax9wOz82yNDdGC01DaGgpfw+8G94xSsSs5MxTXUHcTe@nongnu.org
X-Gm-Message-State: AOJu0YxzuAJJwUpOXr9I59DrhJOQ7gynHYNk//Mpy8475jeMP5LR4mWP
 DcRo+6ysyq7x4KTpm6VcxiSlEwFuRbkf1ysnX6m/ft+AwgZqflb/VkKuEa1d3n1BNSE=
X-Gm-Gg: ASbGncvJxikR1PR807awaOOXiWhOD19DlGOaG3G1UVc87wM5tKAZbYiDWeMPc34EtJM
 +ETouDWZGZ2Ja+XwSIEVN0JTZcoLMOPhj0Cs89+K+tvbZxJ2NxJzTzPwliUDKVVVHRiyYNWue5z
 m50WpDo4YFg1hPz08QTQAN1MU4UvwGmQEufOf0MyItWahfd5HwPXPkvJj0NcuNTBrhCsOWrUQm4
 9QtXkuiUcmmBk+IpKXi1n5uVqkMZYWVCCmNxRaKCaP80uICAOxm+VS9Whz37hWvbZNclkPt6yFr
 pt7s1gb6RkPlg9pngZWiALILv8L7Hcku0t9k+9tCzHammrkq3/kI6ZmXE60SD0OlmAjEpzpzJoR
 B2k45+9JbTK8QdjCvnsAxQN04F2SX
X-Google-Smtp-Source: AGHT+IG5Mkq7rK6aSyZinDd0uxvoOYlYdU3l4Tp6ExC86hwd7GBd/rjfSHCEQcoE8fhzXcfYQq0mQQ==
X-Received: by 2002:a17:90a:dfc8:b0:312:1508:fb4e with SMTP id
 98e67ed59e1d1-3159d8c5dfcmr14832152a91.17.1750556788709; 
 Sat, 21 Jun 2025 18:46:28 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3158a2f0987sm8179551a91.25.2025.06.21.18.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:46:28 -0700 (PDT)
Message-ID: <d7772b18-803e-4146-8a5f-adb446a94556@linaro.org>
Date: Sat, 21 Jun 2025 18:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 25/48] accel/system: Document
 cpu_synchronize_state()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-26-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-26-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 6/20/25 10:13, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/accel-ops.h |  8 ++++++++
>   include/system/hw_accel.h  | 13 +++++++++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

