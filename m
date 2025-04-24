Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83969C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 22:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u855q-000338-47; Thu, 24 Apr 2025 18:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u855i-00032S-GO
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:30:46 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u855g-0002Cm-MX
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 18:30:46 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-224341bbc1dso20644455ad.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 15:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745533843; x=1746138643; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=APvOJm9AY0XGha5hku0ahZGbWwBFOStDKeKYrQjvitM=;
 b=viIVKl1BEuE/0v2pKXXm46BHQOHJ36I8ReECqVXVXMV8dIdvw6MJfnPbvjH1FI2Jis
 BqbNxAlcmSD5ULBSkNdNYDPF1KCFYuh5Ghgv+SczXGosVUDqnct2aT2K68zTUv8oTuqa
 WiiH0D4cocrI9Yje2VnWkgqkllkr9KEhh3o+dgVNcki0Y2+FaTTQLUW7OUrEucGpyHOb
 RL9fmx028L7Vf+EQou5YMclThsaCJGXVqlImHDhVxfJmiEg37SbWbXbgS5goeOob6D3x
 PH3xqW18+OJ0HOrEv3IipN0y/5yXytMmqxKpg1zCzfOMjPwEtJycbfwRaa/9mmD1Gwdq
 9Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745533843; x=1746138643;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=APvOJm9AY0XGha5hku0ahZGbWwBFOStDKeKYrQjvitM=;
 b=NXGOtcXVqi4EoCow3CXIBttvyy9Qhu7YFsCeVHDSU37p1pC9eOZDYj+4CduPWFdyai
 cTtdPKBzbW7hrquin0PvQbg/KY8Dvg6xU3vIITaCeK58K77CYyvMkEvSxc0KMuRFdMcd
 CnL8W8Nx23ic0uHj0vUMkBQSZ+TXG+UlbrWV0Mzd8pVxCKsWbn8QJYsHWRiWj698hwOp
 65uNEsn8Gvr0U4hl/UrQUFgsDJUjVv82ABavgVGJ8/vulPuEMMKiyMYxGLRRJTlcDh8X
 r3fRHEkZ8DTmBj6YzsQEOqlEvalTk6vDqVRjG900lgowlc6mzbLE1UAlh/XAxijqNBv5
 Gj2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNNdfEmAqzRGBtssDa6ZLEgbu+B3ywwmXAB7CnNz9RamU3T5uyTkxU/x9FoK1JvNtLcWM7ohRjwg0N@nongnu.org
X-Gm-Message-State: AOJu0Yyv+UiKIQF39AHbSGfSJ2+EMLDNRrOKOYH9GTtLeHg17szhBGvb
 9ElhPxbBzKixO0h+yD39tgAJoZ4jEkZ+hqW+cIlwBymMEAGXCM9J7tRtz8hwPdI=
X-Gm-Gg: ASbGncu73l1roYXw7XHG7u3oBceJNrjamUae1IY3WkAdaTfVgmLaXvkj9NRAh+WIjjA
 Z7+Imo69nMpMXP/MwkZ8qRb78rg6KOuObr2EmLZcMhl5e2IdaH7THtpRIyjOFHWrgCiQNN92uUE
 Z/HPOInx/ZulX4u1tEKT+zm7hXad2XJmA4QZC31PD2ew08BLuhuH/8dLefVajElMn9CqZ7944Bp
 KHhSnfO74t1psYjnaINORf7te9Ltaof977b1JbnMy5dWjgZzbRmdHfl+mbejlyJ5rMljvcf5AVS
 9EM4qnxEa2rjTCYWo9Ycd3oJWP402jXqGo7hVdxoFWbwU3fbRFBwgQ==
X-Google-Smtp-Source: AGHT+IELG6AMQhG0NBlLAmDIV+aHu+XZh+9mmiq8+gbzRSEhEZLcoyfketU/Bgm2bBRgOzOjIhr3qw==
X-Received: by 2002:a17:903:3042:b0:223:fb3a:8647 with SMTP id
 d9443c01a7336-22dbf6403b2mr178375ad.41.1745533843014; 
 Thu, 24 Apr 2025 15:30:43 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db5216930sm19053705ad.236.2025.04.24.15.30.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 15:30:42 -0700 (PDT)
Message-ID: <8c32913f-5ee4-4f17-8fee-908c48dc4506@linaro.org>
Date: Thu, 24 Apr 2025 15:30:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v5 04/21] hw/core/null-machine: Define machine as
 generic QOM type
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Anton Johansson <anjo@rev.ng>
References: <20250424222112.36194-1-philmd@linaro.org>
 <20250424222112.36194-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424222112.36194-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/24/25 15:20, Philippe Mathieu-Daudé wrote:
> While DEFINE_MACHINE() is a succinct macro, it doesn't
> allow registering QOM interfaces to the defined machine.
> Convert to the generic DEFINE_TYPES() in preparation to
> register interfaces.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/null-machine.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Maybe you can integrate your other series changing existing arm machines 
also, so it's easy to apply this series without the other dependency.

