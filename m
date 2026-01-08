Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CA9D1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwHh-0000lw-Un; Thu, 08 Jan 2026 15:07:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwHh-0000lj-1e
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:07:05 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwHf-0007u2-Er
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:07:04 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so2505235b3a.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:07:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767902822; x=1768507622; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EyJ6ymGFAf1tjZakj3TPH/Wtg30m8FQO39obk0lxSso=;
 b=bYXzGKpgraJAgEmDqM05qW9aA7hYV0voXNBRbBCpsWjU3gNTTbNnk7z79g/2Vkh3pI
 Bk8y62FyUJ0l4bUL048oyKw34L8Nouc9PXCeIzHmK4sntY57acfo6zhvT8neoacLDkvv
 vilbSvkwKQRvwrdp/khIsIoIp13aJAdoCZnGsylDHYR9QSgFCTcFmYEROoPqdAA7M000
 O9/esTdPCl4Gzft+2CjKoeeN3y8MxVZBhZYDtJmgTW2u8CYuGmC1SLGckHCmEtl+xxg8
 aDqwI1IS0ogKsmlx5JENGQteS+cB+zShsLy5JrsUySd8GjApLDeBg0DI5DMvtWUAJCIv
 CGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767902822; x=1768507622;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EyJ6ymGFAf1tjZakj3TPH/Wtg30m8FQO39obk0lxSso=;
 b=Pzyp4dELMlsAn8xSsJU/NYW98Abg4+rf3OBgqHJYAb3m6gTsmrbR3HkS1fPXm9lASm
 842niJPksC0rgd2vpSKvYnVy/qzMht0b9Blf3fSG3e5K5f9cQ1N5DE0Cct3DUOZRCjCJ
 /8rRZCHylnfHFxuck1T+exKLehx5a5NvMUNrE3NeDZ9vwKmCBIQXT9X95AySk0dmyCQp
 oV3/zR3gS6na1FuUhhHll/E7KtVxTlQivg0siMj0E7FBsII5IktfQlhYzue+bZMH4KNn
 qaPvdEVyY4Oan6LvtNAoiMTsuTPziIUW8qs4moSP9xjguU8q+0K2Si237vEybBpy7sV4
 seyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX10r6S6OeluMS+7l5eCCbrsSqzh3O0surbPoWQGXxyhBirfjSFyN65TJkYl+NrFee99y46MgEnb01@nongnu.org
X-Gm-Message-State: AOJu0YzfzTD0vw2jGZmcL0M8WOhB7rPauNgPE4xdRhbc7NpBlzu4P17i
 vbpmnbCnlEm6IpxThY1DejOKrLvxOAdU9j1IcXIGh+AhOWmLXDaLO3ALmkRAON4ZQJ8=
X-Gm-Gg: AY/fxX5nr3tgSk+3ZeWe1lq5jJQfsQKaInfAZFm4Nhroux3+m4dJH4EARXTILP1brRm
 Tj1c6IuCdmZjU7I6CsNXBNDMDz2Pmschguu87KCtGTWo4ktsAhm8cGXBpQU+4NyzMef/56RMGQ+
 TLcaAYyDLXVVIyB1vimH2lyS/aYcTIuZlHh4M5kmThfGMjnx0IAgp1y88XpzeyUMuTO1+BL8ffO
 Ec1G1TpbYBTqaWAyounRcgPB1N0+3VOYCYJP+wL+caQvs3Bi3wpQ7D+xW6zWOEuxyarb1n9ABYh
 uhUqyn5gFe2JJNhCvuxbmDtsLKQa/MLfzSVyK5IZwUZbsb825s8yi9/3nmo9f3V/WLvcHe406oS
 M+87t8CM9RdyBjN31YkGmbvRmMi/PJ5jwXMDOXtwbRVv2gyQx/jAFc4Gcik9B4FIeJ3vH2dNqdu
 mdTUOeT4kU4tCbF64/x96qifEJSNxTldhPYrClOUJW3FfjwWMXyFloy+lX
X-Google-Smtp-Source: AGHT+IGxGGi5AQqoLVkNgff4o1qRtj+UAWEaHGgAYNEq9og1F0x2eKCOc9vRCtgUXm++hBEX2y6zyg==
X-Received: by 2002:a05:6a00:f86:b0:7ff:a5d0:f8e4 with SMTP id
 d2e1a72fcca58-81b7f7e2053mr6983841b3a.33.1767902821764; 
 Thu, 08 Jan 2026 12:07:01 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-819bafe96absm8412118b3a.17.2026.01.08.12.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:07:01 -0800 (PST)
Message-ID: <ae3a0a28-aafc-4710-89e8-04047fc929ec@linaro.org>
Date: Thu, 8 Jan 2026 12:07:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/50] *: Remove i386 host support
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-7-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> Move the files from host/include/i386 to host/include/x86_64,
> replacing the stub headers that redirected to i386.
> 
> Remove linux-user/include/host/i386.
> Remove common-user/host/i386.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   host/include/i386/host/cpuinfo.h            |  41 ------
>   host/include/i386/host/crypto/aes-round.h   | 152 -------------------
>   host/include/i386/host/crypto/clmul.h       |  29 ----
>   host/include/x86_64/host/cpuinfo.h          |  42 +++++-
>   host/include/x86_64/host/crypto/aes-round.h | 153 +++++++++++++++++++-
>   host/include/x86_64/host/crypto/clmul.h     |  30 +++-
>   linux-user/include/host/i386/host-signal.h  |  38 -----
>   common-user/host/i386/safe-syscall.inc.S    | 127 ----------------
>   host/include/i386/host/bufferiszero.c.inc   | 125 ----------------
>   host/include/x86_64/host/bufferiszero.c.inc | 126 +++++++++++++++-
>   10 files changed, 347 insertions(+), 516 deletions(-)
>   delete mode 100644 host/include/i386/host/cpuinfo.h
>   delete mode 100644 host/include/i386/host/crypto/aes-round.h
>   delete mode 100644 host/include/i386/host/crypto/clmul.h
>   delete mode 100644 linux-user/include/host/i386/host-signal.h
>   delete mode 100644 common-user/host/i386/safe-syscall.inc.S
>   delete mode 100644 host/include/i386/host/bufferiszero.c.inc
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

