Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF567C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 10:26:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4H0v-0002BF-1k; Mon, 14 Apr 2025 06:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H0p-000268-PV
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:26:00 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u4H0m-00041L-0q
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 06:25:57 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3441039f8f.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744626353; x=1745231153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c952BIfvWOz0A0zIYjWbdBd1tJH0jy1yJjlrh6KwyEA=;
 b=ka2QhVQ5y2FniGhqq8UHPy/pJr7ULbWUy6div7GaTq2fhNoE6JLBgyb5FwRNVQBAtx
 iW9Q67sndngjVd5eWv4tSq6cVkj2Q4mlblvJ28BRmowSRu+rb/twzzt2yaT+m65udkDW
 9HSwuOiS37i9Hc7339PrsBJDAChPGvIPS8q2nNGuRfUYZCxsBQ38FiI5oBrAgh1lGs4L
 PvYX9qXD+up5P3T6IArdWCunRSN4wLCnJDmNA+4MXH4dzLGJFXYn8n8BXfI0+HYmYsU1
 wSd3de45Jj+FxwSxX53q+t21KrzCeI/Bf/DLyE8s6fvgQ7JlUubG8QpE5CXLdFtyZwQr
 eoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744626353; x=1745231153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c952BIfvWOz0A0zIYjWbdBd1tJH0jy1yJjlrh6KwyEA=;
 b=TMapOdBsebThsbkXptN5HO9IZohtJc2z4BwmX8uueEmHAhQyuf6ttYhM+/bLHDYYCH
 mihLW1LTMz2lyOtkKzoJXlyOXOwc+iKsT0ExFkT9lTmY3H2LYD3xR3CZOYp3dDyoF9Gj
 YPolQmLhc1EyKNgkXPDyebJ3sNAKv2mL9pZbzv6oRxim8h/k+x0Xn0H0XSqGZ6SzvrW4
 MK55b1RriQuVud23z85Ur7SLADdE1K7wTLGCoZwtJ6jOmT7XfHbmyBe5Zx3lt4QtW0EW
 +ozF0gbBIesJNmFnEmDWaGMcWiyfKj8imGU1M/IHEOAhyM1JW4tGsVhT8Q7aTcnocXH6
 96Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcVGhpWh664+vRTl30cQgfje0yAECHPP7Ng7SnH7c5AI0TvcJsgnaOCsACoKQvwFoRnbtcf4C1WbxR@nongnu.org
X-Gm-Message-State: AOJu0YwMFqGsacdD16N13AnRWu+xqAwLL6jzAfboru/+HePHu7VHFc9C
 +XB7+Vcy/bT1O5tW30Z4gh34RjV8YWGWVs2msqySO8cgN/f7NJHfAyYDUX/jnTE=
X-Gm-Gg: ASbGncsDyXG0wOfUMuZ0lVahm86Dw2QklBGls0kNzdiQT0SoktpFhqB3Nrd08iQcWET
 3oToHlU9PUpCWdzk6Oy+9h0ruM8ZGMVTecLAlqf9xnMqzcLtWUjKR75gFU8vlKQqNTMLcwnNlKk
 U/OMzjlIUIhoBKeWfiH1lBbAlzJO5wSy41qHYtEQv0KY5Aj7NwGzpnIgxZdb2rorP2D/H7zdOYm
 hdrlGcCa2uZwTAt2yvGfbvv0qNFV3SQ3AUDhtB5P0iZ1HsxLmQ+GjprwU4eeRYzRphNQRM3wUNF
 sg/nfPhpCpe/fsotl/aDwHslJu5bCgmjLrk2TCMHcnYyfgkQtQbpo1hRk+ZF+AN8S2Nf+18x3Co
 0XFmz+hSg
X-Google-Smtp-Source: AGHT+IGxnEeIzuwkfQ62S9MW0k+FXAYuIx87xf8BlOUAMQHJTNdMwEU5y0wfHLqoYiujtO9Nl+jRHA==
X-Received: by 2002:a05:6000:2585:b0:390:f0ff:2c10 with SMTP id
 ffacd0b85a97d-39d8f4c95eamr13436297f8f.19.1744626353013; 
 Mon, 14 Apr 2025 03:25:53 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f2066d14fsm176010555e9.21.2025.04.14.03.25.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 03:25:52 -0700 (PDT)
Message-ID: <4c676f4a-93fa-4594-9f1b-7f6af80ff618@linaro.org>
Date: Mon, 14 Apr 2025 12:25:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0] docs: Document removal of 64-bit on 32-bit
 emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, stefanha@gmail.com
References: <20250412164315.36161-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250412164315.36161-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 12/4/25 18:43, Richard Henderson wrote:
> With acce728cbc6c we disallowed configuring 64-bit guests on
> 32-bit hosts, but forgot to document that in removed-features.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   docs/about/removed-features.rst | 9 +++++++++
>   1 file changed, 9 insertions(+)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


