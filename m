Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFD9C28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 00:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvQgn-0007Vs-G3; Thu, 20 Mar 2025 20:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQge-0007VP-Ud
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:56:38 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tvQgd-0005bc-89
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 20:56:36 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2254e0b4b79so39586825ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742518593; x=1743123393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERxYiY3ro5PhXmNfZjjk//PqewC3YwpAVchwGXRMzZ4=;
 b=XLiKYEP7sWrk3pwUix4STEllUNmNCq+303hiO06ItUGUSw3Qww1sPfuo4PG32K1keS
 MwYG+NQHCCnWDRclsbLKPbFo7O/tRyJI/A+bkCjqrI5seH8vk1L1JO8VlYO8Y5hKQUxf
 wmWDBhYyQ485KKTS/yyEFJKI771wVOGqRNdr6NiAvuvyEguD3W/JGag7ivC4DOSqbLfA
 NAWACDdzYNZBQ0yFB+KN1nu19uq3MrITPcGUPQKRaY58IRdWsiKeuE1rXGnBU4vTBVwE
 mzaDbiUlo9DivmZvdloRg9jpDYTCncLgYvBx5l/RtygtPWGM+VFa0GcPMSmhfHuiXrQS
 uQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742518593; x=1743123393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ERxYiY3ro5PhXmNfZjjk//PqewC3YwpAVchwGXRMzZ4=;
 b=sHqByMeT5XXMPaV8LQ+qIJEAGx4EgPWOfRr1CRKahV7XfQQDFxqJ58h7DaKg7slt1K
 VIyYnuTyNArSvycgNuoAqcjlIhCaoNGRWC0+7SXJYeMkMWlL92TyCZVPpHUEI4jl5BEB
 vQyQoJYQmTkbKu2YnHGW9fKuwOXWozikQGFXSO5kEWrs6YiSidTBnVBz5E3wEXXLD4Xj
 /hdihRK2Wjvk6mLreZniqupeJpfEUXUb7Rd3XWCZG0kvLjphoYJ57CbuWjY+H917cWTY
 gCywoGYPIMHgsIvJNt6WefZizB9R84mKsd3QLUpQ52eHvkcIWnbenLXjImQmebNhRctE
 qZ/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaTRh8nbno6/TiKoqZMScEZm24KGpUZyX1XPCeLh/94eEbQ8Rcr2PW8uPvNDgP5+bkxCa0dS7vkbX2@nongnu.org
X-Gm-Message-State: AOJu0Yx+aNGtYCKG/37tiqiW/yy2BDCV7PEpmTfDv8J4DAPLqiE5sycs
 69ERaTVI2l3rj7Xfw90xKIGVnxk0H+cd4Do58vhOMzpBUUz7DUylyNEnWMA5xk0=
X-Gm-Gg: ASbGnct0tnCzQVBflw5vx7doVP3vYhVoHmZS/Vvf+u7h1tvQgexe0vMn2f4vUficGWY
 NjskcOOxq5eL6M1AtcW817fcKXCsMYPP7ota8CtkBST3Kp92faDghMu6etcCTuZ9iFDtz3bi6yU
 O4D0b54cVenx+SKFsiHZVqMK5DCHHxtG44FUOizApE7OdeYlbFqJSoc06+2cABtGZPy+Qaqn3Vw
 O/c3Rvklt4CqHTv/iZA2YIgF2B8NDeK4+FE3iIhnx8RT+Q5i3BwekkDRnxuVo268OtVw9wC66OQ
 MrCWOlVwa8dcjuvyNI4YQ+mYAE/PckpbVvHHWwNffTPZ5CtL+PTbUvdPVjeYCfzcQlf6ByR+PvP
 6Y4qlaw/h
X-Google-Smtp-Source: AGHT+IHnpH2C4aUfs5mBLYFwX4Z/o1MfoWhyN2xhb2YdHOMGFjlPX1ii58nt4Z6u0PiqKZ9FyAAmPw==
X-Received: by 2002:a17:902:f60f:b0:224:23be:c569 with SMTP id
 d9443c01a7336-22780d82909mr26550205ad.22.1742518593191; 
 Thu, 20 Mar 2025 17:56:33 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b2bcdsm4542935ad.119.2025.03.20.17.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Mar 2025 17:56:32 -0700 (PDT)
Message-ID: <ac08bccc-453c-4aef-b6c5-f738107e07e3@linaro.org>
Date: Thu, 20 Mar 2025 17:56:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 37/42] include/exec: Split out icount.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
 <20250318213209.2579218-38-richard.henderson@linaro.org>
 <d57beca1-4be8-4332-b2d5-9f0368d7c007@linaro.org>
 <527eb1c5-59cf-4c8e-9671-f06343e9605a@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <527eb1c5-59cf-4c8e-9671-f06343e9605a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/19/25 00:21, Philippe Mathieu-Daudé wrote:
> On 19/3/25 01:33, Pierrick Bouvier wrote:
>> On 3/18/25 14:32, Richard Henderson wrote:
>>> Split icount stuff from system/cpu-timers.h.
>>> There are 17 files which only require icount.h, 7 that only
>>> require cpu-timers.h, and 7 that require both.
>>>
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/exec/icount.h            | 68 ++++++++++++++++++++++++++++++++
> 
>   ->  include/accel/tcg/icount.h

I don't think this is the best idea, because of

  hw/core/ptimer.c                 |  2 +-
  system/cpu-timers.c              |  1 +
  system/dma-helpers.c             |  2 +-
  system/vl.c                      |  1 +
  util/async.c                     |  2 +-
  util/main-loop.c                 |  1 +
  util/qemu-timer.c                |  1 +

these uses.


r~

