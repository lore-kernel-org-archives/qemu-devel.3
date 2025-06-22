Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FE8C7115C
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 01:59:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT9zb-0005oi-1K; Sat, 21 Jun 2025 21:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9zZ-0005oP-En
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:59:33 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT9zX-0006iO-T3
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 21:59:33 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-235ef62066eso40205985ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 18:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750557570; x=1751162370; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EvdnplU5xUFP1sW0UMxDhLNCumzv1Fh7G+p8V4hOMQY=;
 b=mo6dTmpc5x1qygM9Ci5nUwgbM7gqnzloQtqzKgfzFp5iDO6ETQgCXwN9D79dI5zvow
 UldvX5cNCv7P8IQPSEnotdjmYP0RdLW+XrRKvGPHVg0NZCom5mUIv1lKPwDdvVLGE5Jg
 Bn8RLY3pZaMPpX+NquwKdCJSSgtma4vtRKEze2EyU2glvrvs0rmBzs6GS51x4kg+sZ59
 V8WBGmNWkIFCTD1vFvJewSmM+2kUG59sttQAsCM/vU06Q7t9yqIhD7/qV1pFJAEkkq+i
 jkW8mvPCZyfPZqXGI3BulAbBot9SvDj4FfVB3mbb6MBh+dids6+CatSW7jsGXkCWbGy7
 IG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750557570; x=1751162370;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EvdnplU5xUFP1sW0UMxDhLNCumzv1Fh7G+p8V4hOMQY=;
 b=hIKKOlWfAujpo2wTCATphweryhH0eZhs/ERkChm+I7MDEYgqWvuRsVsSuJwR8VAwV4
 vMgwhs85fZoL1e2/41rrAzMSr5SSfbJpEG/QTmzRrQILEUiBecViLgLQb0QA6zJj4/ZR
 kzcpKjV3ThgHvYOf61EVkUzXgCSma4M/5r+r1cjVIk4MyJwuH4zlK0vOtBZEuTkD2yHI
 J43E9Bq40SKnaodDRPxHIH5C7de7fz8rNgjPSGiDNPsN7vmFFbKQBGhae0NyLpk+i7Wr
 qR31Ht0m0cArcCor3zDePkMF1e/boqwaE4MqW6FkUK5PyhVykJLE2637QdFWHzWmj48r
 XlYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6Fidli0ABqhRYgLWMmMHDRl1XE3wsaoMkzzEpCaitUREIeEDDzR3Jw1SLsLqCfeR53ZzGml2F/3Jp@nongnu.org
X-Gm-Message-State: AOJu0YwkesatLWsbFdSoR5iZwC4ybAVW/RaMtnHrQOIpOhQLTLtxAi12
 WcsfuKC572dofup3lFTVTiD5LuHAK6X5gXrmWuKeqfu34v2PN+vbQNKVRZJGkDIkXNEGweBgW3O
 ZvwgQ/Us=
X-Gm-Gg: ASbGncsc83nwJ0vzz4nk6Zrzw5/i0NyGb0KhgDosomHlyy4p9NrRJF984AgAcNPmdrL
 /wjFR3rLTHp/keW/wJpPBQzvIR30yTUOgRY8kxHafZomxpe1hOGY4z2KoIgmkPa90JVGVCG3Rfu
 LlWKgqBZe3Oh2eAioNmO3MC3k3s7RSL4ExbobABu7vOhr4WlHF6mkGROyWdT2rVIkgx6bmMTPPX
 it5izyUqz3OK75eLIROPkfILADMtvIxkKQPxNDqL2g+9S6z9PRyrwWuMEFjFXzq9EEJKnivPQRJ
 57HO1qIspj/+M4qNPXwBJJfteRM3HOQki2H8d2GXEO6Q3Nk6ao+j3IopRXlWYVEETAXEp3X7xH4
 R4r6sQbRtF0gnFcMfvEQAWSe89oPC
X-Google-Smtp-Source: AGHT+IGVh7fCxdbKza/dTnriCV/C998L5Kn/11P8s1TJd65Pykuy0HZ75Iq1nLnTs+DstOHWO7X5yw==
X-Received: by 2002:a17:902:ce85:b0:224:910:23f0 with SMTP id
 d9443c01a7336-237d99e5d48mr125942615ad.49.1750557570428; 
 Sat, 21 Jun 2025 18:59:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d8680d48sm49900725ad.179.2025.06.21.18.59.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 18:59:30 -0700 (PDT)
Message-ID: <806af2a1-e95d-4f70-9ca5-532a1edda330@linaro.org>
Date: Sat, 21 Jun 2025 18:59:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 31/48] accel/dummy: Convert to
 AccelOpsClass::cpu_thread_routine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620171342.92678-1-philmd@linaro.org>
 <20250620171342.92678-32-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620171342.92678-32-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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
> By converting toAccelOpsClass::cpu_thread_routine we can
> let the common accel_create_vcpu_thread() create the thread.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/cpus.h |  4 +---
>   accel/dummy-cpus.c    | 14 +-------------
>   accel/qtest/qtest.c   |  3 ++-
>   accel/xen/xen-all.c   |  3 ++-
>   4 files changed, 6 insertions(+), 18 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

