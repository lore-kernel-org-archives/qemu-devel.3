Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A4B6CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 11:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1kUE-0001Q0-0e; Thu, 25 Sep 2025 07:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kU6-0001LH-Rp
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:50:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1kTw-0002WK-Il
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 07:50:02 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e2562e8cbso7432055e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 04:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758800986; x=1759405786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GrslQH3j2gS6RCEFMkGPo6cpGZbJIbtUB9z8eMpeoRY=;
 b=ciltX4wwULx1WMTsSxW0z44tNfIrakFqjea/zropGxYTykAR3xjxrwyaUzGfGtUFGb
 p8r7gEZYBjgp2PFciQOf+OoVfavg5g5du78Rs+N1bTUjpQTP6N5inJv+1whwhFmwzi1a
 D4Kl72Sgl+Rwnn7zYYV4qi0XBeIdCJDR/8a9ka3moY2nFQp96G3QKZG7JZYYwWXWGl7p
 UIbCLrP1ro2NUO8oQObIA/TtTuwJPi0ibM8YZxEdzmaGaHs6jEQfHa/WjM8+vOcIg4l8
 N2hXcFvSCbqz/QkxNsRSINJEXfz3vMx6nQp0jhOwiBeckqkVx/6kpA7urxPMwha5vPOZ
 Qmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758800986; x=1759405786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GrslQH3j2gS6RCEFMkGPo6cpGZbJIbtUB9z8eMpeoRY=;
 b=ZbQbu9j53zidD9kUtVb74iQ7lmCbljJ7Rs6LgSp6bq0++ZbiS2sifd2unyHy3gNAYM
 3N6CERifN6Rfhp++bT4ny2qaGXGLmufduxUb+vnuIxH30prv+7+JJNRtdENUAvS7Iv2k
 iwknv3CQoRqiodn3UQ5KdhE9KbAK3q4wk4qoev0Jl6p0JPKQgKmeRdNj4FmhOHoj205A
 uRWt7p+tfguEeY0o3FSIEJLp1/YOE0Vnyi8xcF7mws9gwFM6g8Vs8ojz2oTp1k7NjBIQ
 srQPj9DOA5Xb63m2DFtmDPKMVa5GHGBOL2obvLdrTLAwcm2XCmfKoLLMXELn+VtcnegK
 FDJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVahBgN4plQkzDR5N7xmeICUvG0rGGgg7uDBzsR2NKEkhLPoE/B0bo93KiC8pBTPNxPDlxt/yEru2t1@nongnu.org
X-Gm-Message-State: AOJu0YxTX/TKcCKhkqE34lASDyo1NM261xCZPwtUiAxSABOpgravZKKf
 QypzdgdXcTawsOn5mc7gUjzauF77qI4ymYYhY54q4EOTYYjHPk2pv69e+yIDdLQ413Q=
X-Gm-Gg: ASbGncu+tHJB6hiBqMkIjyck39IANatgSQfFgVpIZ4PJgOQeQYvgoD35lLVWaJv5+7K
 0dq9bMqbr5yORoLsa1feTk0ZjSyXx7woLUAcnKCswjD0QNb9P2xSDe4N0gHelz7a8i3V0zpGpNU
 kvK/ozXsj4M1e7Lky/8ki54ff/Q4cd/AGDjilsg7E2BIEpjjSsRG5lrA/VqTt7ESCWXsuawRH5Y
 U4X1WiIChGiEyArfPuDj0/WTQ4N89yQg+G7KkcWJkx/PTbjwXa9L2lK3KYKDYZ/VNbd5M8ktOH2
 yK3eMUdHWY60isfqv2HBVtgdGLmN08J+Mgq07Z9h9uIdDq4dMu7H+r/v37wXdVPPhQyVeERk6DU
 jd+kQ5OVh/T26QNwRRsmQ1X5Y4eZZV8vxL54c74LaNrvSvflGw8zuSPr11XaX3dwEPA==
X-Google-Smtp-Source: AGHT+IG1sPx0l5eU8N9L1QmhlTviUUBgYwVkpQSUcDWxmb78Y8hn5ssOqCgzFz1S4FTbbruRqwtSyw==
X-Received: by 2002:a05:600c:1ca5:b0:46e:2637:d182 with SMTP id
 5b1f17b1804b1-46e32a08feamr38667365e9.28.1758800985673; 
 Thu, 25 Sep 2025 04:49:45 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc8aa0078sm2637874f8f.59.2025.09.25.04.49.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 04:49:45 -0700 (PDT)
Message-ID: <f8476922-5594-4a44-9ae4-ebe95d201887@linaro.org>
Date: Thu, 25 Sep 2025 13:49:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/36] target/arm: Move endianness fixup for 32-bit
 registers
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-31-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
> Move the test outside of the banked register block,

Because not related, OK.

> and repeat the AA32 test.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

