Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B841BD6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 18:03:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGMNB-0002YX-Do; Wed, 27 Nov 2024 13:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMN8-0002Y8-VR
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:02:42 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGMN7-00070Q-BH
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 13:02:42 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-53dd57589c8so1169903e87.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732730559; x=1733335359; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=L7Df7KDuOmQvd77tLFPYQcSTR3lrxDvF7uYvnrx0U/U=;
 b=Nbwk7atHAXW0BK6fz2ijQa9OhP6/5Zxl5ghJikzDPFizym3lbLjj1vRjW/402YA+hn
 U0yvBk/Tu84/rX+EbIUMFH9ClisfLFjp7iZC8/jUspKdgO62hzV4Nh4tb/FAmkJoEsUf
 Aupv2LadQONyn6Ck63v10oJCUzFjERee5rmf3IviZVde4JKVnSwkX6arvmIoFEAJAfDl
 ztorG6/83JiDeV9XYsm6XHaNWxZWWGPDDK//I9UFuPi/zc2gDnidPXRkNKyDjmuVX9eC
 6Q915ybh8cMVZCYCDa9oTHp1u34hXa1abwKpjbqImRlPRZuugogiw/gxPuMmhNQUY5tW
 OSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732730559; x=1733335359;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=L7Df7KDuOmQvd77tLFPYQcSTR3lrxDvF7uYvnrx0U/U=;
 b=hMyVEXln1mFS+IbA+bgOmDw2Lb0FjA+rojM6AgNCuLaX818YEU3bvp6t+wWJEF2iSD
 4m1ey3d+dSRdDOiQvprDmU1Ox5UXoSfziNX6HplsSKbMt/RXnsNfvGAnA4EkAmKSO6a7
 S8bUnVcbay/54KA0nMApfwnZgaLkGeHBwZPFFyiY/ynCUd/0N7TEw1EvmKFtFIsrTNH8
 kJrkw/FFmhvmBg8CrDYk8YgcWxdsLN6B6yrGvyEH5n+1nPmTffqJWCyBGmK9+qP20BuC
 8P75xk72gEuqPNrBsJlGQJmcS3WYUVaF+5oKMBrA2AZ9aMofXagjEc0rwl/aDv/65uib
 Xm0w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNPkcO4YCPsbqejTjr7BSDmPb3TcVZvHnF3qrsYEIQwBrXRKHsGeEJzNfIbR/V+vuvEKMdUAsyM/PH@nongnu.org
X-Gm-Message-State: AOJu0YyNUjrvU/KwZ5QBW62+LfbngT/W+0OPWW8S9P9aO5BnsNXt9VUm
 jq92BYiLfB1liuLu4uX5dpUG/3RkKFZtiIQ+Tj4zE7VhvIRL4R07BeoRHaI5FrA=
X-Gm-Gg: ASbGncsUwey4/mASgTiBqZZrS6g32pVaGBTKi1oA+aFJF+CqkDNIbFD0r2Z2EjHjfmt
 cy7WPwICrXGCuDYWBftQ5aUCpuEkpJ0f3mZRDoJh+MJpfbQP51Gs5ikefEweCt5ytLwmSGllUa0
 Nd0qadEZke2TqUFtfFlv1JYqcWdAC5xPZZVpSXQ9lTIX+gAhGBEbBocAIeQGfNJ2i96ATRQFFTj
 WzF9ErmT1zkTFzxsWFAaETaUs00N7t1VFmrQDSepdQmQveFiZtod4C249taNO/um68R
X-Google-Smtp-Source: AGHT+IHfE+glPgRy2aGWvI3BFWqJsogvQe8HXAraWwU69qXBzoWw0OXoTEzdQzygZGN/jh3EJCfPHQ==
X-Received: by 2002:a05:6512:12cc:b0:53d:ed28:b0b1 with SMTP id
 2adb3069b0e04-53df509ebf0mr109986e87.23.1732730559165; 
 Wed, 27 Nov 2024 10:02:39 -0800 (PST)
Received: from [192.168.170.227] ([91.209.212.66])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53dd2445838sm2354371e87.21.2024.11.27.10.02.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Nov 2024 10:02:37 -0800 (PST)
Message-ID: <90b56207-a602-454f-9d3a-82de83a8f2a8@linaro.org>
Date: Wed, 27 Nov 2024 12:02:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
 <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
 <7c62e46b-26c8-48e7-b8ec-b7478146a8d1@linaro.org>
 <ce5825ff-53f5-4cf9-aa6d-e0d28639e664@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ce5825ff-53f5-4cf9-aa6d-e0d28639e664@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 11/27/24 00:29, Thomas Huth wrote:
> On 26/11/2024 23.54, Richard Henderson wrote:
>> On 11/26/24 11:52, Thomas Huth wrote:
>>> I think we want to continue to maek failing downloads as test failures, otherwise we'll 
>>> never notice when an asset is not available from the internet anymore (since SKIPs just 
>>> get ignored).
>>
>> I disagree.  Download failures are not rare.
> 
> That's not what I said / meant. Sure, servers can have hiccups and downloads can fail, but 
> that's what we have the cache for. So having a working cache is essential.
> 
> OTOH, if you simply mark tests as SKIP if the download fail, we'll likely miss if an asset 
> vanishes completely, since some people already have it in their cache and the remaining 
> people will likely just ignore skipped tests.
If the cache is populated, we will *not* miss if an asset vanishes, because we won't ever 
try the URL.

If the cache is unpopulated, and the download fails, then we cannot run the test. 
Indicating FAIL is *useless* because there's nothing that we can do about it, and we also 
skip additional tests that CI could be running.  If we skip, then we simply defer the test 
to the next CI run.  This isn't perfect, but it really is better.

Honestly, flaky test failures are the *worst*, because those quickly get ignored too.
Download failures go into the "flaky" bucket.


r~

