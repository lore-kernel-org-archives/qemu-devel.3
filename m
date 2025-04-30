Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E80C369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 18:52:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uACWj-000517-Td; Wed, 30 Apr 2025 14:51:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACWi-0004tU-BY
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uACWg-0008MC-BU
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 14:51:23 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223fb0f619dso2409595ad.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 11:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746039081; x=1746643881; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxOJ9FBHYIfa8vp94TfzK7vL4Nw0T38BsxJdpM9mzsA=;
 b=EKSDAXktbZ6/w8iiQ+dJPB0aZ8vv8k/tKtbtKIGHow/fsT1cMkopZHpQZbNrxhYVbi
 pVxUFmINUga8316fxl46H3adiOvCuIqV0ovzVqyWzin++AhKKlye6NC1EP7Bm6WDBR1e
 342qyZkUsRF6CdHTzkueDD+zDec/SjRsAsmyfS2hY6I7agiMbq1b7rhWF9/b7bBMkPM9
 y1qxsZWw9e2rrArKGPU594f5Hwiufj64EJE3MkKCm4qBTaFAuDJZcsOQ7Map2Gh47kSP
 zFVdKtgDenL7lI1eaRlYpXSnVsI/sQOPdZFIOifCF/YdLqkp2Is+WnxA/shyq9uUxb5Z
 Ln5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746039081; x=1746643881;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hxOJ9FBHYIfa8vp94TfzK7vL4Nw0T38BsxJdpM9mzsA=;
 b=alYDCWvHnpQpi7E7grKMAIcn0Cg12LYDH5YaU7Ct8Zy/mva/sN0gAzKTEegjXWihJY
 vEiFvG0PGayGcWxyXQNZgOtgkEK4ByYBesjlgLbVv+Qr54Rds7F2R+5ct4HaxTe4Q5n5
 VZGxLCmj5Vq447Dq+aBv0wcYyLDPwHC7Js7/uHfpqwKjG56rZVtWHuT4l4zR9azd1gu/
 v/5+fbzy5MJXog4JelUq7gKcGKSI51udtzA+A3DX5V/bfdhmy3MIwW9uxouG/zf/aMHQ
 lFotBhVTrDJqEG/g+bQwIc1kJpRfSp5gKHlLAzImzajKQv4kbWttCOrXDO5hW/ktGgAH
 fCjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8nB+Dec8K9VTnXOy0ZQ9ahT9TImF4KeThaEFP8+rZIlsPPhggww9HH+ykEqxKqe8Y4bWB8nwK4g+w@nongnu.org
X-Gm-Message-State: AOJu0YySUSA9vrHr/iaCAjWiPS1mlna3eENIIp7UysXsjc4KyePtRPqt
 xOw19Dd0WHRX3crfb5sPbgrfjLyGZSu7z4VB+4OL71tRnxAFjy0uusR3tigdkaU=
X-Gm-Gg: ASbGncvVUQ4RSHDs21VosFMMkAPCC9SwKt8pj9D8yYH8KmIPFNRIARgbm74abDtjVr8
 CXNu3/gLbEyUvISlaqjt0ZUTXjTb90QW+xBcabdNcJqMfmetPXVl9EjKuq8WyELUxZ05T/rU7So
 8LFzxoyZ2xdu/ADKo5/UlwTeiby5422ZYTouOsmXoBiNvNog2EoHmwe9mLH6i90td9gP4twkDXM
 BiQhC5wehksF4/Z+jpFmFv73f7TLHt4ul8+XAlOWg1v/YbdgQWdT+psiCs4joHO8VFRPGFzLg9u
 J5wX/tvHB5MS6Nj3RaZtOLbmCkw+iKOlO99esFkMQypTGn588om9P7AZ8XLmU2GBfXRMvD7GcBu
 RFzOEbmMhnmiiTKkD+Q==
X-Google-Smtp-Source: AGHT+IEzWhuZd+fIFVzMg6dFdi+Ij1B5/pyHqYfzImCAOcoYiW7nODxF971GqI2yyzrn7iFeWN/CkQ==
X-Received: by 2002:a17:903:1a6f:b0:223:517c:bfa1 with SMTP id
 d9443c01a7336-22df3590ef6mr73173675ad.38.1746039080897; 
 Wed, 30 Apr 2025 11:51:20 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db52214fdsm125468425ad.251.2025.04.30.11.51.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 11:51:20 -0700 (PDT)
Message-ID: <344ca5a0-acaf-4934-841c-481aafb03052@linaro.org>
Date: Wed, 30 Apr 2025 11:51:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/12] target/arm/cpu32-stubs.c: compile file twice
 (user, system)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, anjo@rev.ng
References: <20250430145838.1790471-1-pierrick.bouvier@linaro.org>
 <20250430145838.1790471-13-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250430145838.1790471-13-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 4/30/25 07:58, Pierrick Bouvier wrote:
> It could be squashed with commit introducing it, but I would prefer to
> introduce target/arm/cpu.c first.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   target/arm/meson.build | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

