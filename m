Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3936CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 06:16:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unt9k-0008Tu-HD; Mon, 18 Aug 2025 02:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unt9i-0008Sa-MY
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:15:42 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1unt9g-0007JC-OH
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 02:15:42 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-45a1b0990b2so19610505e9.2
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 23:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755497739; x=1756102539; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hLogK+R1RBryQpe8LLdPWEj6d4ZcliC947B39ttSJUY=;
 b=ouLXka2tRsfdcMRYb/JmVh9mvohtS/VAjJ1mCE3uBkr+l5UL3fdGBiVmI6vL+jcUmC
 meD9vmkr0PBU3mq/ZzuBUGDV4aDWv9IKY6V2RPdpFJySC/c7fw6kIYXSQMd4TZnsQ5Of
 unAc5f33FWt4bqVuRbW6TIbd4jeCjt61f2sN2/ZdVEpkYBB4gx+tx5ePBRs50t3R/4h4
 W+NJ8CdkIedMR9WYXodyJWbBS2mLqgTK0vk525szXaAc3nBnDUgtDev2Zf/fPhd5khBX
 dAw5pbA/B2J134AOfSmew5X2YeAu2OkTH/TZJPCcFpkT1YKTLCWFHh0nzXOOrCqQ+Tnb
 Nvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755497739; x=1756102539;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLogK+R1RBryQpe8LLdPWEj6d4ZcliC947B39ttSJUY=;
 b=ECnbrNIv4HRhRvgAuF6wj62sTaJ4wvKixcW6TIcLGZyI+NXpqCVmxYn2JMEt+bPtL3
 akapikEb/dUQmC5Afp/TVUeXJWTXQ0wntp6/dDVgGwfy6mSvHz0E9yiTjqjiVTQXqf2H
 AjieZeWdeQT8otBamHV/HQxQezv5lRKSIqerChYh1o6OO+gDHU1JOGfsGCNRDpYPNuLL
 xUEr2Erhr4xVlD1V3YZvkgVzy/rT6KsIKkHReq2wsQ1w7XMA8zzR+cHoqZBaNenF4scF
 4lwTdEdP11waT+mF4YyK9nWskyDePr2q9FV9oDbBpWEfFQQouYGxCUVh4j8s7TTnMqY4
 OhUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsmuoO3E5LxkLXtuGxg5g/Faed5iFSbhLpNiGye8n38ZqbHZRLAA09q4YH/UKPVdNXoyPjtWIVEJGl@nongnu.org
X-Gm-Message-State: AOJu0YzFzQVGNyEivl9eTyfVBwKD5sfgT2/dcp/D5fSWA42KANEAGmH5
 +k4JLl4jvEw49lf50QJATZ65X0eCzBrMoOzBQP9Fh408l3iyYVKbYTaUVSX46f6RLoo=
X-Gm-Gg: ASbGnctLwUVWoHKnVAnbNEqstQ+Of4ONdGRu8aNHtqCKi4fCsVBEQkGMexaV6kE8IaV
 g87i9P0xzzdMtI6q/7wnTVPMma1+Oz1XCKXjLKkMxPPHA0K4ICedMiY0m9Y5qLR56sessmyQOql
 643XOevyAgC3s9E8WBdKvN3GPoB8NGJ1BvyutFgp/CrrW5ogCPNMkTCmPTsCea/oxMBVqPt9zzS
 24eBkjohRluiyLllaHcmPueqfPHmBb6RUOwHM8lNdjAT3CXqjmQufLADJwtxRXqi7CmldBnJfO2
 ZolDOP1yEOZCDwm6lmiC2FkmyP7IqzOV3E+/tdO0R89CA6UTvJguyzEbgqSfxKFY80WeCKREL4Y
 0h6e8Dnmy1XbtlhCvSuln0enD/wNaWCUItgRny5z7XERUpsNuxTUUvL81som6rqXQVg==
X-Google-Smtp-Source: AGHT+IG8zV/534OzQed6SUnQjzdA8jmCCaRWNSvgXdSwjelclVS8XKlraa86HHhFz3exhJMMzISCcQ==
X-Received: by 2002:a05:600c:1906:b0:459:d8c2:80b2 with SMTP id
 5b1f17b1804b1-45a217f71b3mr65203815e9.7.1755497738880; 
 Sun, 17 Aug 2025 23:15:38 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321985sm116395245e9.17.2025.08.17.23.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Aug 2025 23:15:38 -0700 (PDT)
Message-ID: <8f701cf5-5187-4d46-b6b4-1075e090efa9@linaro.org>
Date: Mon, 18 Aug 2025 08:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] target/arm/hvf: Remove hvf_sreg_match.key
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org
References: <20250818041354.2393041-1-richard.henderson@linaro.org>
 <20250818041354.2393041-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250818041354.2393041-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 18/8/25 06:13, Richard Henderson wrote:
> Use conversion functions instead of table lookup.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 35 +++++++++++++++++++----------------
>   1 file changed, 19 insertions(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


