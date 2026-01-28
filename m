Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C34D3568D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 08:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl0er-0007O2-Bn; Wed, 28 Jan 2026 03:12:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0eq-0007Nj-AN
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:12:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vl0eo-0005b9-U6
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 03:12:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48069a48629so14861775e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 00:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769587929; x=1770192729; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oVxG9RvYWoFKgos34XVbR7h1z65nznrC5wJkMgpUapA=;
 b=PZkqTmoO5sPZgRdkePaXsSd8KfArTacR8+LfMqW35HOdTiu87ViKNm92d1yegzyjuf
 3Lj0nmIDKLN49Q12Pz8edy7Nax0vk//YlD9G4fffWBdZnotrQXE899fMKUgk+MDmXEgb
 FIuP39QZQZf1nmdM4H4pi/YxPBx9jSl9YdbluA2c+rXGIzNXH20UwqmZR4ZcLl2v2Iwp
 s6BJRIa/by9TtDLHWK+fSAhv5YA/RcDDx/INsMVT8o0OE7IP1exwEIIXc65m1DdmUuTQ
 WyBE4pfH1NuTsdn1Xxt2b/hKj/yEZQT0/E/fwFq6z54uQFur9675ixdsEgrKYWTdBdvj
 zWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769587929; x=1770192729;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVxG9RvYWoFKgos34XVbR7h1z65nznrC5wJkMgpUapA=;
 b=VKBFdDZ4EOQyZjIFzD1oviFYiik/GWAhBKGV6jkQJRMTrqHMDFxZzRSV9KKOHQy1Ds
 LZCApLKU1STBwtMCbeq0GhO/uHbkTMPPzDujY5WdCIjBRWU8lpSbSios2xA5qsIf/L5a
 sWDqCRxTLwKQ4uHKaxtIJnHcqhkM/O0SNhOnq7mYGkiOqqWDiszRXl9q1OxPahxRiJ5K
 ofE6IrmPsUtJgsAvPhD6YE5mM13WfKOp+90RLVpEdhnZ5KGmq2AgsEK72Uu9GSrH3lQS
 vCM2EDyB3rP2f5LpVGjW1ASD68kHcaf1WurN9P6hJQ9rIWkskt0PTyg2npppNqlQ+Sp4
 cTTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtnUc+3t+8mcy3kMv25OTbHGIylYWHrEAFNbR6i36omAthGgLb7L7rFoicFe6AagccvOJM1aIhXRsC@nongnu.org
X-Gm-Message-State: AOJu0Yw0+BOMYw2vaJ5CD6c3ZcOYjKRtiDEYo3d3cMdsvwtTmSY1sw2b
 jHCoWHGDKCUb0m1qmspvdF538ptDg+JBkxRBe46oJQeXLFbxCWvmLQuDXLfex33AIgs=
X-Gm-Gg: AZuq6aK4IqEtjToxC+hKVai74FnITsNklFH4YUlzhXhpF3OpGjoZT7NjvFSvS5ORO/7
 /1eEhvH3PHvONeoPl2zWR5rn+XJsOHp63aHqY8TJ1X/KUZaB/1Ba8o6i2JRahWjL6omylOkTU1F
 KIOZBjlG0QG+LSIuauXyOAX1JD0hMKX8irYz9DcO0n433eml0FYL3ukR/TwvC9Iu+8zU5ONyDYo
 PkAF0DDDobC3HCBd0QON4lPeTi+s/bYI2srmE5jromV0DJu5PEg1C/q6X69QltXEEG/yKode0oP
 rhjslni8rhAQKLYd7UiU+8XFd4AEbjsm1QSpBeMNXh9xMp/5FYpTMh3rCZtYG1CTvbpzPJ0NYl/
 hrQ3e3ZDPstc0c1F7rtE7hGni/KCaB+wJszcqW1OOVVzG59wwL9ydjFF4DjkhbGPMF5q2kTNTxO
 tmi1DU/c3Qi4Rhe5IU8EdICJwkgY+cFKLFh5S8EjuvjpuNOt5zN9QuwA==
X-Received: by 2002:a05:600c:8b22:b0:47b:da85:b9ef with SMTP id
 5b1f17b1804b1-48069c2335cmr65096715e9.16.1769587928813; 
 Wed, 28 Jan 2026 00:12:08 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806cdebf86sm44715775e9.8.2026.01.28.00.12.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Jan 2026 00:12:08 -0800 (PST)
Message-ID: <aa321a55-7af3-40c0-9750-2c45c2495d4f@linaro.org>
Date: Wed, 28 Jan 2026 09:12:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kvm: skip tsc synchronization on shutdown
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: marcel.apfelbaum@gmail.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, eduardo@habkost.net, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
References: <20260127201831.179237-1-vsementsov@yandex-team.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260127201831.179237-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 27/1/26 21:18, Vladimir Sementsov-Ogievskiy wrote:
> That doesn't make real sense, but may take much time when
> there are a lot of vCPUs. Let's just skip it.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/i386/kvm/clock.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

