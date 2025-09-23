Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5A2CAC5B0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 10:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v10QN-0000wM-9I; Tue, 23 Sep 2025 06:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10QK-0000sz-6s
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:04 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v10QE-0005Go-C4
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 06:39:02 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-46c78a1784dso8032295e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 03:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758623935; x=1759228735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CRbwK4NBPHdo4l0/P5FLE2ifGdo+X2eMPuXGFnC1gKU=;
 b=RqClT7cVdYrXcw1Tqqflfsrk6iU1moDAb3YG6WIBhUuEqbKB/5uaGoPJkZ0vonmjwT
 Ei00cUMwb77QADmV0wLUAP9j0V1sUaw/2Y1WseELthh/AM5KNGtgBfayl4JYU8gs9ze7
 H6JKUzGFjZ79t8b5oKoZd3Tqm5LB4EHds3W5DevQPf0eXMwHpsC9zOiUwVAjJqzRFzQM
 XjDIF5N51WUgUB63mjvK+DkemB9USqvdSGqC0SIIWPmAe3GungOLY1SKKLoZqVapKDDu
 AXWRO0KCIawrLpxzDuBwqYf5KYZwHJGNnjSidgkpRozBHe5TinZZ0mjD32AfzKxP3uU4
 osiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758623935; x=1759228735;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CRbwK4NBPHdo4l0/P5FLE2ifGdo+X2eMPuXGFnC1gKU=;
 b=Dhbp81ra+dlRlJDjjeaoAj/U4PdFnqNyrpueZJB/YU92pRlsL/fkMrupYhhhmStje1
 Xk7DKNdJb/crO4Y9Gf8GqD2A4PcXr68mLYGusXHmjNHInz9d0I4DqpGX9Dhk+9UygwLp
 Hr/SX4YGybcTfq6A0rQKg+qkGXEjfvxUBSoq925OvF8grtEEyPPAOoa8ulhhlwNOXEio
 PIeHIs5ggpFQNRBTHgum513RUb7f0tlEAv2XJ85wwsTa85Ug5aqn6BHa7bTAvSwDZePL
 H/PErlcmHhKJ3muDqfKjK/vdMNTj+wtBbAMz5HWgkPnM1FCczomTn417nHVLaLcghZ7b
 USwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWb5FWWjO1VdhlMHxVfs2pIummF/SNcPYLzAeOEs9rcbMO6Jk7iun4rnWbm/byJP87TyQzPdYvKeqBC@nongnu.org
X-Gm-Message-State: AOJu0Yzek3UXAWLRFhPuXq85NJh5DwAILDGWMItDhQfVSLZXIWeiCDNG
 CFzKxJ3PAZ9NHwmyRL877rIe3k4R697zusGjScdTko3/zOlOfH6ifpGu6f+/W9LbQiA=
X-Gm-Gg: ASbGncvJ31ggFR7G7eht4TWQKz9+OToKIJ8CVyKm3B/wlgcY4n2x9M2+bRwuoHh4SWr
 GIqBYjenIVi29EjzPJbUVa3Nvgq7pRBLeLqUN6FxsuM2uvhqzj3+22m1C7Vc0oNJYluM1dXLgS9
 8/6SXEVZg0z2yl1T6pYttiXxByk7MrkTVq/7Ecu3I/s34lxsvijb7bb1DNOHNiCXBwx/t9qtEYX
 vKEaO7jjTcqWa8y0g2LynvOM9HoPN+24nAJc+UI1JVN0p7XQ6uzHGgIVIzM0rYneSKkWsYxtKXD
 CDAOvKukSqKHbZPCz3T2dxCils4yDYG7L2SX5SHGWvvfJPb/qG7U9PMIhQQ2nfO8zBz27J+CoEj
 WqP4PH/XeleYnC1FotRYLB6RLboraIeecoElz7ko4b56GA3k2UUJaz75qtF/Rh4wBDQ==
X-Google-Smtp-Source: AGHT+IEED/1eEDvqGeN2HUpSyohwO+hqti9yS6VXZf7uwr0ifC7od9VYb1TD4Xyqu0W/DojU8UBkMg==
X-Received: by 2002:a05:600c:3588:b0:45d:2ac9:4240 with SMTP id
 5b1f17b1804b1-46e1daacc85mr32542705e9.17.1758623935036; 
 Tue, 23 Sep 2025 03:38:55 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46c9d5d52dcsm107406275e9.8.2025.09.23.03.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 03:38:54 -0700 (PDT)
Message-ID: <43943c2c-126e-425a-b32e-f15fb144a1b5@linaro.org>
Date: Tue, 23 Sep 2025 12:38:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/36] target/arm/hvf: Reorder DEF_SYSREG arguments
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 16/9/25 16:22, Richard Henderson wrote:
> The order of the parameters in the Arm ARM is
> 
>    op0, op1, crn, crm, op2
> 
> Reorder the arguments of DEF_SYSREG to match.
> Mechanical change to sysreg.c.inc using
> 
>    sed 's/\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\),\([^,]*\)/\1,\4,\5,\2,\3/'
> 
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/hvf/hvf.c        |   2 +-
>   target/arm/hvf/sysreg.c.inc | 224 ++++++++++++++++++------------------
>   2 files changed, 113 insertions(+), 113 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


