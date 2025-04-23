Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAEB0C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 09:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7WME-00057u-8G; Wed, 23 Apr 2025 05:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WMB-00057f-4y
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:25:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7WM9-0006ih-6C
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 05:25:26 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39c13fa05ebso4461538f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 02:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745400323; x=1746005123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ywp9pT4+O7xjryuElIAEdoSkUlr/hM1RrQCAcm1tdg4=;
 b=EXirsalXUuVY/2AfCykaRZwbcqFASaHhUjC3OjP33QLczHLr/d5jsAtrodFHfE1Ay8
 JPZPBH8e2yFZeQLIJv+TXautvcX6kIvH+97DYWPJWIPpoyXyu1dKTSqOKmll1RGvuVd3
 +AGcwZukP7oua1BMGeBDGG1HmXgq453JJfetbY4JnBDVjfeaxig3S9H340ie/xbIGk0l
 GynayyJaUPWwDFiMym9OPZq0sMgCav0h46yeu3iZwRReqHBuMzeFPkt8RPEvJDdazCmK
 XokOySgs9P9/ZM1CdvBlmoc/BDvaB1dMVaaIw07avbcPYYal5IOEPtp0xsKZHiB0do16
 9vHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745400323; x=1746005123;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ywp9pT4+O7xjryuElIAEdoSkUlr/hM1RrQCAcm1tdg4=;
 b=YWFXUUN3JkI6ODGJXOGHjfWxMBOk3cLWVt/RLSjhdPPfXQx4GODoRG3O90TrCYNHCx
 Z9bFHvJyEKBSx9nnodU36gOaxuQiXt0lPxQa5tZ//vD4eSBi8XHXzR758cJkDJrzlzq1
 oMx7HNp+CIvFYD7UneJFEW3Q3SrCzBKY5KMSc+xKZ0u0EbJexWdXLU8sahi4QyfWTkRk
 jvrjgIpO/bSaKliJWKE2XVI7mq4B5RfP79gA1KthuQQQo++DIiTdPC0BwcFSNrsYTyPK
 1tt+2/I9qjiXQJvsmiYrPCYBBgXKj6D0ClCx2/1tErZwgaT0Ap6e1/82a/ahOIJoQeUX
 tJkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVeU+GLhCZCvcF5eE51hibXOYkOJT9S1rZ/oKdgtkNa1/WuhUF2ollYdJcSgQ3zKK/rqUwQqNYmZse@nongnu.org
X-Gm-Message-State: AOJu0Yx5N5loMDZ6G7xZjU/LgFW9yQF1tzp3QZt+xeTZF2OlbX9yzDl8
 7aMKxUaPzyEkQc3xYzMZXEBYuk3iQf90ko9hvX73EV59OjyBR11qkO1eXm1NTCY=
X-Gm-Gg: ASbGncvXXVSvLDi6ABexWMdgf47GKoD4kv9VwffthQyd7pyCmh5r1YUM72SoquvLw8j
 TFLvZw99z8JStqLx7dx1pkQxhCKbowIIPIOh1dcQeHtQfSulpLWEfxE3xJuJ4oBf8EnG8zXIU20
 73geN9eYegTkckBtsdn41mk1wIIU5mQn2xAngO2Ql2Qv8ZSmiygwyEZzpbny8/k8z0wi3h8Wy6m
 ToEWudwfij8rcgqeCnPTNmNi427AatmN6jlab23Mqpf+TYF3qkD31lmdama35OzsmZazITwJT/t
 K0dDt0UzV4hR0ROlJU4h4y3F5TRO4ccvyCVqi100MdkWfhsKqkBBBuf7/v2NPpJNtEeoWr1BqpN
 y1HTQdflU
X-Google-Smtp-Source: AGHT+IFVk4awFtHZ9HOUPdkXy7Ppy2eA5uR8LWTHA0QAtzEkzdcgrT0+kwmb+ZDeGx5erDPwnSZ9pw==
X-Received: by 2002:a05:6000:1846:b0:391:20ef:62d6 with SMTP id
 ffacd0b85a97d-39efba2e9b0mr14115581f8f.11.1745400322894; 
 Wed, 23 Apr 2025 02:25:22 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39efa43d03csm18402300f8f.59.2025.04.23.02.25.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 02:25:22 -0700 (PDT)
Message-ID: <258c3103-4777-42ef-80c9-dcdfec916aff@linaro.org>
Date: Wed, 23 Apr 2025 11:25:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 017/147] system/memory: make compilation unit common
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-18-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250422192819.302784-18-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 22/4/25 21:26, Richard Henderson wrote:
> From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> Message-ID: <20250317183417.285700-18-pierrick.bouvier@linaro.org>
> ---
>   system/memory.c    | 17 +++++------------
>   system/meson.build |  2 +-
>   2 files changed, 6 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


