Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F16CF2579
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 15:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t00uO-0003BV-U2; Sun, 13 Oct 2024 11:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00uN-0003BA-Pu
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:53:27 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00uM-0002at-ER
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:53:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-20c803787abso23031685ad.0
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728834805; x=1729439605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X56BqVoiJnTddvlzl0quySVsdRM2MjL9Gw6nnJ02nVc=;
 b=t7dqvM0ngBGcQ9WKJq/2Zz818K8N0L5BoArWN1/PIjL8OITHtwzPXnTKK9xi2iJ1Zf
 ONk7zk3FQjNka+gm7PrY4tdwb1VskuP1cCJhFJCX44p8gEYDdZAbJZXVwscOvgYI+xbk
 t024EGR2WZSeWtp+S2T3w65vCCMdXGw5C9Cz9M/gIfzALhdaIAJ/HIrsDATqahuflxqY
 ajMzWwSP7g8unOdm9fmifysvLXruVdm/yEBs1TAG7Q6ocrJ1jcmcUqyt05lWM+XraAE3
 t0/tgF3HNQ4jaaq0eympf8/0YmUeor50TvnTVXjH3hJNQJKlHNa78BDKHVFEmGQJ50fJ
 eXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728834805; x=1729439605;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X56BqVoiJnTddvlzl0quySVsdRM2MjL9Gw6nnJ02nVc=;
 b=YQvlAP7zeAi3XhLBdNeRcKzqPzEByQ8gqGSod6stWKeGN9xNagzjLKgDQb4A+vf/CW
 znTmp9dD7DkevNApiOIP6AQ2jP/8nUTqhXX2GtZOZKOE81Z0e9ggeuCWafiXzZH7Pr4P
 rGyXfdMWLILzzT9vq7/Jei87djWjve8O84E66iOAXJg0MAYBwydeED/GDlhbN6QO8RMk
 k/gPmwbvLHi+v1iJZ7zTMAndX1LuchJZ/gAPMXo5yX1bX+sejck+33OY97kYOoIP2ESp
 YaEVXoIgl2d+uShBH+p6T9Rw8Ni64rDhgqRblnxyjI4o1sGmkz6oOUCPkWareChzvfuk
 Y+iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAl2MK607nAHTM9rS5xG2RWC/4I6bbdX2sGJ/3Pm43SQiHk/lIo0D1uiSHUi3fC9y6sQ9fLoGYYGUP@nongnu.org
X-Gm-Message-State: AOJu0Yw9EObvF9+pu0xGrK3r87SkMSeEy8nKhWb9BrGk6Ydci9hlXUv4
 1zR8sw+EhKQMAqywIuEGtgI9w9uhfJAgziZMSNwqA4vKBWogubB2vJHlSJnkCac=
X-Google-Smtp-Source: AGHT+IED+oy4Z2ThxPqySdeuSoUsQthuHdRnUK7D/xjo7jdogFci4r1j1JNcEJsQQIhwSxSjXS4YGw==
X-Received: by 2002:a17:902:ccc6:b0:20b:8bd0:738a with SMTP id
 d9443c01a7336-20c804ee3a3mr203887935ad.20.1728834804803; 
 Sun, 13 Oct 2024 08:53:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bad350asm51571945ad.18.2024.10.13.08.53.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 08:53:24 -0700 (PDT)
Message-ID: <51566753-0b3a-4894-86b6-8108d95f113c@linaro.org>
Date: Sun, 13 Oct 2024 08:53:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/16] target/mips: Replace MO_TE by mo_endian_env() in
 get_pte()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 10/10/24 14:50, Philippe Mathieu-Daudé wrote:
> Replace compile-time MO_TE evaluation by runtime mo_endian_env()
> one, which expand target endianness from vCPU env.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> ---
>   target/mips/tcg/sysemu/tlb_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

