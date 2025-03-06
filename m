Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86C5C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 14:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqBqw-0001nM-Dz; Thu, 06 Mar 2025 09:05:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBqu-0001mn-EQ
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:05:32 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqBqs-0000Uy-Oc
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 09:05:32 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43bc30adad5so4491835e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 06:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741269927; x=1741874727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GyDRCgfPiYIvSPbDPjoXV/+/GCZTRFgu425oWxVgvpA=;
 b=hvE2h6LroggQeR2kFfVT84FS6o3q/ibizKWm699/xoakKo/rQJdsfVDZTzuodelI/K
 FwgJcrIOUHkm9XyK7OFK5RaY3c0pcxGtyhY4htojjj+mFctz9xGnB4AxeV8YHgo6eHIQ
 gwsS2DiYbh/6r9UBxeW4JCg+JGuNJpqGGbfBexmtGPaang9sAh+oSIjOXMpItaj8HX2v
 Iuru+HeIMEJpO9avk+qEVX6FgO3fqeDjsDY197WadIyJj1MEk1W6RGuaE6f1zPcQ5hd0
 njg3vxyYc601lge0yoNTuQS01z9QO2fcxogsiLUiEp0U9XuhZjvbzAmxFexQZjBjk0lE
 pqXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269927; x=1741874727;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GyDRCgfPiYIvSPbDPjoXV/+/GCZTRFgu425oWxVgvpA=;
 b=k3EvMtkmY19Tm5eXvYLxHnA429iM73nreTvcYXfEr4MUDXbfe7rM9xs0kzoZM39BU7
 HovkAtJXs/qw4laz6P8Uljhp5+AWQcINYj9P3VZCSXrP309eIFUCbPOxnIq8IJZErbfE
 Zfj1yQEBt6XgMy7sfXdE403LR9icbI2jm3YTlvHcJuTuXbRiBksffe6DlJiB0HkhO+FB
 kPiD38GkGjZ3EiseqR8aEJTM1fvlRdwmAbAFHLYQ0rIykRtLL/ElPoEWG26edpjruuVZ
 NU7qNLPea4BWuj/u0jjQzRerJ0WteM//IfGON0X1uauaMwDT9OYxg9aN88h8TEIuPx+1
 9Epw==
X-Gm-Message-State: AOJu0YzbWT7nWJpPqApiwVDC+m+xxW13gdqAmd9v3jhrDoTWsA9nsz2W
 n1i5kfQ1HwWWmXb7zXHHcMXWMDavVbQ927aCBu8xtW7Eak8J5Kl/PmvRdzYAi1TwCTAH/dapP8i
 pOb0=
X-Gm-Gg: ASbGncujZhHVqHG50eqm0kkO5uq7HIDNFkMWUYGLvO5bmhm4vNzBQa/2YX6wO7xi7mh
 cr3DrHrDzN/+8KNzGWsAPY4RUWxoeUnRRrNKvfVDfRwvezjce1iNN3eagCNyL/GP4TNhklieRyV
 sJOAS6xVs8jQEwZie6RvZ6TmihtQhBOBJJKwqQwIgsl9vC56YRFFX3DVuh9OxbXN2TZApNdUNTu
 Oa8dDAnlQ1KlP3uA+iPRka2kCjvEvCnAIjtsnffOPmbe1cBlUW8nXNqiIZ4TGUhWH98pRh/XHqc
 F7IMflDL+O/ZOyErSJWxI6bFChwZSF2e26LgvFMrCaS3rlYaR9DTDsi2JRJ5o8cI+JgdeehA5aQ
 OtT6nSUhcnpI3
X-Google-Smtp-Source: AGHT+IFZbUPVgAOL83Q3D3Kfv0D/cp/jixxIeOv4byR56pZi3wc8EWAeNrOdQ0qctK9YWBwv30vbvA==
X-Received: by 2002:a05:600c:1c9d:b0:439:955d:7adb with SMTP id
 5b1f17b1804b1-43bd29daf14mr65604005e9.30.1741269927352; 
 Thu, 06 Mar 2025 06:05:27 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd93cb9bsm21096545e9.31.2025.03.06.06.05.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 06:05:26 -0800 (PST)
Message-ID: <a5ca8711-64ed-400e-9eff-e8b4cd19bd72@linaro.org>
Date: Thu, 6 Mar 2025 15:05:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/openrisc: Call cpu_openrisc_clock_init() in
 cpu_realize()
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Jia Liu <proljc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250114231304.77150-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250114231304.77150-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 15/1/25 00:13, Philippe Mathieu-Daudé wrote:
> OpenRISC timer is architecturally tied to the CPU.
> 
> It doesn't belong to the machine init() code to
> instanciate it: move its creation when a vCPU is
> realized (after being created).
> 
> Reported-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/openrisc/openrisc_sim.c | 2 --
>   hw/openrisc/virt.c         | 2 --
>   target/openrisc/cpu.c      | 2 ++
>   3 files changed, 2 insertions(+), 4 deletions(-)

Patch queued, thanks.

