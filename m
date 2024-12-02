Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF3E69E93
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 20:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIDGS-00045H-Px; Mon, 02 Dec 2024 15:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDGR-00044y-93
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:43:27 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIDGP-0006Sy-S4
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 15:43:27 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso772127466b.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 12:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733172204; x=1733777004; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rT3mm95OmWnv3iBreJ/r0Ks3/htZcxapOJ2qRIMwQQg=;
 b=rqEWZRG9TIXihQ+ZdTSMxSx0N+RtLm4ZkuLKQdTXTdzD6+J4P+V/cpHjIPIebiO+16
 PAaArK1vBY4u/ZgpaxHRAVKZkDarBU6BqeSUZ6bby7VSfSIt3Q9LWH9fsr9b+WegYy9n
 LBpg+86ToYhsvBT4LCbYt5ynkfIlPNHf7sX2PX5gTBjcja7J0LMgRiYDQCtaTC+2g/un
 ubr8cIXen6y7jS6lm07gy/gtGIINPyRuxLS802tiGYFHNvmOnYq4fYhKWU01ZwyhyCTN
 KMh64gTAgCO+144ahQyKtWUsGN7GlO48xsbWERVPZeFLrY+A9gfiPu8ov/I7BhcCLCxX
 jRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733172204; x=1733777004;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rT3mm95OmWnv3iBreJ/r0Ks3/htZcxapOJ2qRIMwQQg=;
 b=Yd1lhQ/JNFk8mrHbV9vN3oD/KHgGCvVSMiq/oNUXhd8ySGM9Js7/WxZZSEGHdpzODg
 asFa+gTvNOwSGl55mobnJ7X1VRANVvDBCSHULj8+JY4aB5UN2vHwuSo4HdUDKcxU569P
 eHO2vM8bQHyAUAxh88TYi9o3QMjo+UL8zl5vazh3hW05E+rFZT8Rh7qUWdOPOdwE6YSl
 a2Sm5/kuw6uHzFb4eRWZCR9wC36yyAEsCNzM7uMnZZqVrAvH02wh5AP6MRTr7HlInEuD
 r/ZmKaozLzRAgmbCKRf+WU8XPBwIaKU/P+C01hxYh3PVtyC2VVV122O3t3LjtURFY0r9
 lIYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzUewwof1x7QwWWKXcgHPCHW0wnBeuATa+k+QyfenY9GTxcOW9BoivYvKspKKHgODT9PLpoeVgJdIe@nongnu.org
X-Gm-Message-State: AOJu0YxAirH0Za5eWNWBY1z/F+gEU1b9h4RECJBksZ622bhn9LqUHfB/
 iZlpVOUMXxmogxZVd5NNIWjYkAO1AHQpkPcLVejDMfKHGR1+2pkM0CsTa4n8T74=
X-Gm-Gg: ASbGnctSe4RrrhBPes3LFLjm17cebQ04/BtfmCqjVP+wwfVbcWjg4J2Yf3BX3bt058M
 hQJpubtj+lYnKNHJxTJpMXKjZssDfMY0K3T8S6OysdIIGhZQlAQi5ZmgJd4xZy5FBgC6Jksdkx/
 fO+JVoXWsy0IcZjwpgnmnojr9cDL7OqxsIxqIwxxFazYyEx0kCIJjeKKIgaLdASva9SBDKUl9sU
 o561jbcSZqM80j8eXOyJfDg7RzUKnxhepnjF7cxy+4Jm7Caye2sWPNgtdTbl0309g==
X-Google-Smtp-Source: AGHT+IG/KfbCR0CKU3zFbS3tNFfc7wgq2N6XhxQRAsG1c/mzMAGGBTbwSz/URD69jDMpu4SVG1rK3Q==
X-Received: by 2002:a17:906:c395:b0:aa5:27d4:980a with SMTP id
 a640c23a62f3a-aa581081aeamr2061707266b.49.1733172204036; 
 Mon, 02 Dec 2024 12:43:24 -0800 (PST)
Received: from [192.168.69.223] ([176.176.160.129])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa59994b837sm539297766b.176.2024.12.02.12.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 12:43:23 -0800 (PST)
Message-ID: <014e9959-4995-4bf2-9a2c-ace318673804@linaro.org>
Date: Mon, 2 Dec 2024 21:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: update email addr for Brian Cain
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, peter.maydell@linaro.org,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com, alex.bennee@linaro.org,
 quic_mburton@quicinc.com, Brian Cain <brian.cain@oss.qualcomm.com>
References: <20241123164641.364748-1-bcain@quicinc.com>
 <20241123164641.364748-2-bcain@quicinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241123164641.364748-2-bcain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 23/11/24 17:46, Brian Cain wrote:
> From: Brian Cain <brian.cain@oss.qualcomm.com>
> 
> Also: add mapping for "quic_bcain@quicinc.com" which was ~briefly
> used for some replies to mailing list traffic.
> 
> Signed-off-by: Brian Cain <bcain@quicinc.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   .mailmap    | 2 ++
>   MAINTAINERS | 2 +-
>   2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


