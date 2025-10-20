Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5361ACCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAyzY-0007xW-0y; Mon, 20 Oct 2025 19:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyzV-0007uw-CB
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:08:37 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyzT-0006Nv-Rj
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:08:37 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-290deb0e643so34783575ad.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001714; x=1761606514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fzBkV2fCoTAffj+UIbjcI0BpHVKodb0lg/6/u09lDrg=;
 b=d18jdQ8gy43s9efi5PlrozR5i7X22FH7+hvFANXjWWyN3/Xs85lD04P4DOSm1VMU5C
 KTRacb8AnUlKXiX29XCL9o0MSplGVF6eUR/zj99JFMXRWuyOxEYel0qjzzCKT/RabgzE
 ZS/3jVLsUYub4Az1WehKLkpYcQLzRHL3OL3kwa+Jd4+e3/2XBHxBf/m+/2irjWbQtujc
 YmgHKxec4tXz2TsY43vjCG5MVC7UUV8Dyz5PpYgZWX/ezgQECeZxzGjtOLmbMEu7HcXu
 loc377S0+ppLXGhY98IkjHH0fHfIlK9Ocv8Sc0z5SeUVZ826y4OklAGoToMvChdNQMxX
 ocKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001714; x=1761606514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fzBkV2fCoTAffj+UIbjcI0BpHVKodb0lg/6/u09lDrg=;
 b=VhcWzp8WjqHFHx11bC/TXPwiF1E/MRl84I4VgZITwFQaud97NvMSOTVzPAvEuJny6C
 qUS7OZWk3Ajd/fKtsuTKFqJ6xQVQcuK98oyO39mKs3qbokYYUj4a7XvenNhNR0jeismA
 5+J2T7DNUBLUs+T0eD67YTl4xN6k7AMBLx6Yliw+nDTNs0snT7RSsOvs6V0ciRGfPrGP
 kL6Nd8AqVsh3tIr/F/CJVMj/auMR0iPgTO+dDFMpM7dpwJhhgwPF3AouP9V0riZsnXY3
 bXYqGkJEN+6dKYyXvXRBxl5IlFD8coZpgztYAKrxYB3APrBhkEMqg7Gt9yy8tqWkBDJP
 fXVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6GJvJIKF2TynOCxnkX5W07u+XLaRrD6NWtl4JCBwTTHw0KaH4Gvah7buqSN2xXgJXkcfpObu8gL5k@nongnu.org
X-Gm-Message-State: AOJu0Yztl9mSHFVofXm56lyqyR/6NyUcwkXjXX97bfEijqswF7D7sClC
 URBl4qJX8RUxnLG4vC/CCqtkeEINDgph/ntpki1AjCHOal6ys038IzIJKzI1ClQ8rGw=
X-Gm-Gg: ASbGnctMyW/Blz7ZZhOvu2DXzieexGccdFB8/THDCEZMtx/35eEdamFe7ng9NYACmFn
 DdgfOIekyl/C8bo+6pemBFQZX++R8Pejine+mpaDYHKFjWI8EeiZRxt/AQjIJc5RB78swI0aMk8
 AosD8OzRzFj0rpaypGxq3TSdNQZWrYLiuKb4viaMLyrx/+vh+WrSdaxCxk43DXlOR4PfaYwadyt
 HxnhsuXv0toJfhgb22kzxBXIGPLzBXmYQ7U6rYW5MrzAMxfEyOXeDUgA5yxmXqPt1it9iHG64U1
 vwGPwqYSW3EfJbTppQUNIU/sVe9QtynkBNrIMZA/vBLsc9PrQ5qTE1g7veDkUHLQzsih2/+uXMJ
 8dwjJpRRZ2jY2cRkAaXgCc3ouhhrga8VwVLRrBdsmbwYEY4vjydiwsIaKSpXqu9WZTMaOpha2Ub
 Jd48Dw8ge4wMauLg==
X-Google-Smtp-Source: AGHT+IGzlOuvRIdoLUeevMgDFcx+Z4TA2VXUfzyLu7lZ+6TXLw4NBe2uVrQYbly4Jxdcd8d1I5Btsw==
X-Received: by 2002:a17:902:f68c:b0:27b:defc:802d with SMTP id
 d9443c01a7336-290caf82b93mr202055385ad.28.1761001713983; 
 Mon, 20 Oct 2025 16:08:33 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ffb815sm91117745ad.50.2025.10.20.16.08.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:08:33 -0700 (PDT)
Message-ID: <8babd55d-f700-430b-a60e-a412cf103319@linaro.org>
Date: Mon, 20 Oct 2025 16:08:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 18/30] qemu/target_info: Add target_aarch64() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

On 2025-10-20 15:14, Philippe Mathieu-Daudé wrote:
> Add a helper to distinct whether the binary is targetting
> Aarch64 or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


