Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22957E85367
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 15:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8gJn-00059n-Je; Fri, 03 Apr 2026 11:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gJm-00059V-8m
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:20:18 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w8gJk-0003gL-BJ
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 11:20:17 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso12093285e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 08:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775229614; x=1775834414; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MoKl7MAJVVoQBh3jJHjMhxTrlAT1hvj3U0F3jpD+bug=;
 b=FbDwjCDSbjK8fYQqSadtAarp9WNG7gX1RFBvDOT8durwHAfwGPR/aLw+5I3r7Vuezh
 E2rfoNjJZxHK7qL/IJalnuKmCQgdG2B/OcpO9jlf43EYW6lzHcjGbT7m8+YN8KONKkRJ
 CfXBS4EJkmjA05C6j+Yw1wpJV3ZfezMr4llT3AKEcaCC5rrdpGZ75MGiDR4GKT4W/unr
 A2ZMqt65zUazEv/TtQZl8cYFKpUZgsSNKqM3TFJon0Ot3a5mgkivoWNhCsvlW2AZIXtm
 /nlUOCl4PX61Zvw5o8QtfkJxatduqpJ4bZSXO9l1jHb6PVQNSXJv6FkKga26+IZul7Ob
 jLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775229614; x=1775834414;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MoKl7MAJVVoQBh3jJHjMhxTrlAT1hvj3U0F3jpD+bug=;
 b=P1mtbmrrBTs1ikW2A7PyxhYYfoDN5QHiKIXfoTA+OPZ62Otf0Ivl6G3X9BEhxFVKxg
 rg3Upzk18huYefzb7X/+HTOg3Z0iQriCF7y0iyUbZ2LNk5yd6AmkQK6RA2xHgMTFYSnU
 yXvthFIr1SebGI3pccGoS8pBiXsBtB10rLn6FGbLELYyXnXnT8stMtDDaasQVt1FkEZO
 fOeFpMewNfJmQO4b8T0r1mM2T7QLiA8rNttMN5nnNmpojMsa0NmFFnuauMULHQtp8AVX
 ITVeDqFJCzR0VBw/KUpkNm8iXCJIQggTGkCSDg9omhAQUBItRfQYGrjWapS57zyHFXSr
 LQLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8ffWySdsnNSuJQa8vcPtgENmME/wSfOrJ0PQVTrw1XgolsZFnuBx8KBSMWs6S1LjhbQNVeLhrWhH2@nongnu.org
X-Gm-Message-State: AOJu0Yy2LQRsUOe1+NvZE9KDtKuhak+GLUstmPEi5J8t+xVtQw3EOFH2
 a3E80R+DQ1QM1lgXEliM3bJWlQT0kuIXGc5myFqwxnwwcEXzg5cRec2C5g0xx3imkZU=
X-Gm-Gg: ATEYQzz/UX5GYTb2tRHLqr0/zdLm6XANOsbsYUGekA5gaMlWwynUiY9BqLYaJuelW/T
 7x0gsM9/VRCLeFcqaFnlVtaPBz2GrhGbwJigCj3l7CcXDQyuZbR423rNRJMBGJQcRb4O9GH5kEa
 HRwT/OPv3z2YJYjWxrzY3KQi6vD4OjVQtfVqzmcE4Kf/pbPyJ3MOBNq+3qQcRmIB65nfWhAZH5p
 qmJTckj+XmSHUdAROl13l9zNCAUfxtbTrfvvwKS/4M1+HpuAXDqVm8CmUPj89uGhBOpQ0DFFHtW
 +EwYwYkLKJzG5aAEnzZqSGcrh4OlJLZmaEyQtMK9EQFwRBIiVcLzejc0ac7By3IoosEQYdGrT0F
 5M8lPP7fHDBAPxo71wjx+zXGGZaaRBtj07qP/FzwG4FCDtzWouabiLrqEh1ubxu3SMYqkQJdZiR
 oF8L3iaND/jll6sjliVk0E3t9QFusal+8L5Kk/bDpXUCa7F8RHbsOw4Mtgv910goxAZA==
X-Received: by 2002:a05:600c:5292:b0:488:966f:70a7 with SMTP id
 5b1f17b1804b1-488996b02f2mr59056445e9.2.1775229614020; 
 Fri, 03 Apr 2026 08:20:14 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93c014sm284836155e9.10.2026.04.03.08.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 08:20:12 -0700 (PDT)
Message-ID: <12644bc4-8713-489f-9ed8-1ee71bf26a3c@linaro.org>
Date: Fri, 3 Apr 2026 17:20:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/arm/omap_sx1: map CS3 at the correct base
To: zhaoguohan@kylinos.cn, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, =?UTF-8?Q?Beno=C3=AEt_Canet?= <benoit.canet@gmail.com>
References: <20260402071718.130490-1-zhaoguohan@kylinos.cn>
 <20260403014441.38725-1-zhaoguohan@kylinos.cn>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260403014441.38725-1-zhaoguohan@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 3/4/26 03:44, zhaoguohan@kylinos.cn wrote:
> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
> 
> omap_sx1 wires the "sx1.cs3" region to OMAP_CS2_BASE instead of
> OMAP_CS3_BASE.
> 
> That places both CS2 and CS3 at the same address and leaves the real
> CS3 window unmapped. Point the CS3 region at OMAP_CS3_BASE so the
> static chip-select layout matches the OMAP address definitions.
> 

Fixes: ba1580299d0 ("omap_sx1: convert to memory API")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Note, this got unnoticed for 15 years.

> Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
> ---
> v1 -> v2:
> - Resend to qemu-devel@nongnu.org
> - Keep qemu-arm@nongnu.org on Cc as requested by Peter Maydell
> 
>   hw/arm/omap_sx1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

