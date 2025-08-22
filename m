Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D156FCA0EEB
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 14:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upT9X-0004M5-1H; Fri, 22 Aug 2025 10:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upT9V-0004JL-38
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:54:01 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1upT9Q-0003t3-JN
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 10:53:59 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3b9d41bfa35so1672716f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755874428; x=1756479228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B8/yuiXH2uxuuKdRnM6zCV4MFEMK8N2lAEcE0P13lBc=;
 b=yquo+4oqfSkAZnvKFJSLkDwYBhLL9AuciToiSm57aPQ+bGEwACxwwVDaupuPhJUpZJ
 PNK+ucJTy4PJTgnt0yxWzzfOFoMgbPLe3odLipwfW+POgugclNNJqQT0of28ripyuKek
 v+1qNmgx4VomTXV0rFIr4dYxxckveKrN+6WO2vuOsDdd01qmx8ZIMOPv8Yq7VTCaGYe4
 7gIr8RzQIedORv4yYDXN5bg3UIEd5ycQrPgnzO3qwfU/eVY2skD1+eSWRqH4nYYQQcWH
 5y+gX+zYNz51E6iRDkAKNkr3ZE4UqLFdbkWM8ZpRt//DzyRgMiWpKByeZRvEbv/zXFgf
 xyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755874428; x=1756479228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B8/yuiXH2uxuuKdRnM6zCV4MFEMK8N2lAEcE0P13lBc=;
 b=Jvls7zWg/XRoq8o1AmVLFhEgkwtXfCRHnqobV0/Mws6y47ZEJ0xfRcstNOcKmOjzpz
 a1uiwB9L4DI8J/ROv1wt/H/FvQehDG00xewuPG9pQ2twUOD+ODtg61KC1Nc/YSIczIij
 p2ISieZP4tlyvl5Jl3qs2Hi8ncBcLK7SibKFqYEx5dvMBa8Y5t29V3j3EPoku4sanaSi
 BAU4ZKE57T1PItBi0kJZ+oz4mJK3KRWGH6r9mkXxpjy6SZNudBq2HlzV8UJ+6J5gjYjc
 Ywm86OyeJhshqiX4KRSas53xOJsqWsF7OYnpJ8MzbZE3pnyGSXb70MmKMXxJA8IBj2UC
 LaMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWIdCx1bMT3IidVesk0eGhqxhQPKUVowIJ+gwXfUAymfIeU9M8E867Cj/B+FRtLF4KTPIjiQrDdn80@nongnu.org
X-Gm-Message-State: AOJu0Yxxezu9sfwnGFu7m+xL7QC2o+Q1dIET3iZJ14QKkpwK5LpVL9Pc
 QdEzTYFxbXaq4yYF5gHNu6i/NYkoSz5K+KJrIqKrjU7f4gW5iBnXWN1d9txNF/L7BDYdvAoMeP5
 ykmLJ
X-Gm-Gg: ASbGncvzZKKq5yW+LF4hMcnoGWTh9GI/RKtLBOqzl2kTJXJRCsdrqd6nB89+xxaX2AR
 JJc07uWYYeOYuF8x5Ta1czEwsm4WrI11eUcQg7y7Qk6/2B5gHyqBHn709BIqep8mo8LuXOKRzCv
 yjF7aTKBoUEGoPGBYM2C9NAV98PxWHV64nGB4uNg8XqxLaOJaWEK4FVpUD+C0fEKS5DM8SzCDjd
 CSeOPwbxqifxe9bxpcBIykoo2qWMe0BUklWhLdXQlydPEikWMEIGKkOeEkZ5KRIWM6PFtMYGKo8
 bSS+4ehSe+9sQd1OsnPFdxNwGFWRaKK4fOVEaJ6ZH9ZuPdS6bdWrj1bOt6BHiTCo2zhaT3FyOt0
 zKrXEQcag5lMXAe2CBvERjGrsaHWy4n7p/koPWts/8dwmI3SyggkdX9A0tARIYTrQSrWYeUE=
X-Google-Smtp-Source: AGHT+IGSiOjltcILbAQ1a2kF/lG9KVWrw4COLVmMBEjJbdkJy/DJIbwwDmrhay7GCMfbAGCs0kMvNw==
X-Received: by 2002:a05:6000:26cb:b0:3b7:952c:5de with SMTP id
 ffacd0b85a97d-3c5dc638421mr2047820f8f.29.1755874427931; 
 Fri, 22 Aug 2025 07:53:47 -0700 (PDT)
Received: from [192.168.69.208] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c6e2d3f2aesm339567f8f.58.2025.08.22.07.53.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Aug 2025 07:53:47 -0700 (PDT)
Message-ID: <ac33ad27-856e-45c6-a1d9-aa6704783ac1@linaro.org>
Date: Fri, 22 Aug 2025 16:53:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] single-binary: compile once migration files
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250730220435.1139101-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 31/7/25 00:04, Pierrick Bouvier wrote:
> This series removes target dependencies in migration code.


> Pierrick Bouvier (2):
>    migration: compile migration/ram.c once
>    migration/vfio: compile only once

Series queued, thanks!

