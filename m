Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32391C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC51-0007VN-AL; Wed, 29 Jan 2025 12:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC4w-0007TB-Ox
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:20 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC4v-00042y-76
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:18 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so5904151f8f.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172535; x=1738777335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Hqq8FEP6yKq0cIc60VpvJ7/P4Vkp0kfCYNCtYArodHw=;
 b=uAxsDH29Q17PlzlBWHlkQD4jj97QRZp/M6+Y3em5FNCUJ9ks5Zq5i4galjh6rDm3QX
 4g1MBRVKxUx4wAgCtFuoyl4cdMQoKPdiZ1OUpHP3Pra5wrzuCOu2ausG90bNspAAfq9g
 6vVT+chn9TM7ldcd51eF4SZiaSUjk2FEjyfLZNIc8eQIP+v0QtvURnXhAHpA1BgbeJA4
 2VW8s/RYX5n0yFvFFABeF0jD5rYHqpJ7DUBcQwzKYYBFC0xPOk04Hi4YSbqytokW+bL+
 ycHikZUI7yl7HY/qIr3clm9EBJrrI5n3TQxdBMytRpG79+rrGBfoOlS5YZRi7Hhdor56
 1/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172535; x=1738777335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hqq8FEP6yKq0cIc60VpvJ7/P4Vkp0kfCYNCtYArodHw=;
 b=tcvivy5RGnb3Fy2wD93Ta0SzrVVxsosXAcmR/IVegXklq8c9mTyIyZpfcAU/+ixtpP
 1rgNNpWFgpTBU6ysCjrcFOJlN49aTX7DVXQ23odsbNvcI9DtYIoBEx1gqEjaBZSuyuvo
 QynoB4cQaMpFGF27XMw8nYB7oZJSGF3wAWEM+K3ugkEgbS58QsYFLahoZkxPHVSJeZ/w
 pxCuOttGVxBmokt9pXVPC8n91muPGA0L5lV6+c1I4YoJx+gbdlMCxyChPu/96itocS0N
 tRq+ZssU2Da29T3Ch1MISs1VtUNEmZJ+jf1l+HQgYBTWJnQNLyZVMbg0wjxAN5zVTs3o
 xZYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7yKqskxRqlBOtrB3Tl8g089z4kcYqAwOfAlII2nsopQetppKjdr9/P3i1ZZKm4yOPGu7Oc2vpjwxh@nongnu.org
X-Gm-Message-State: AOJu0YyWj6gtyzPF4txLqneIUAmD6xCZD1ITc1IFjH6rG5MCGVxMz5uN
 82ZSlSdRlySica3HcCloxOdXIIi/Jxs58yl9RGSIq2bPrrzpQByx7MYAWDSHW4s=
X-Gm-Gg: ASbGncvHMHYp+FK3xp2tHAj4KVrGtfRrSpBR6ZZIF/9rH/idcw2TqR7ephcixnkN8BN
 obQ/NhrhjQY0E+CAUcZenVwXqRMdrX1OU489mKFfJ8jv9mzEIwE/iQ1+c9k4+dyEEj3hzvRW8bm
 650M7Jmzmacs7tcYJlAMWxrQ07D29OMNjdUQvB/5IaeEIVOC/6c0JcTxU/x68pjL+NZk5tVsiMI
 ueaKGrkM6QTO2tan4na3VfeLB9mLxG+t3Y5lx6cJTj5PTw+JmmYtSDRldwkQud2VS7zpKX8b+wA
 rETzd+psa08gzfQGSYPbcYglBfV/CAnEq6/4FCXkq1uSwS6rcFJoZeO7sjo=
X-Google-Smtp-Source: AGHT+IGNzY2untHb22sXGVDBZFI7fx2Y48d/JBqqD1s8JFBbeguHlAP739ccGcrIQJb6iNvjNzkGIw==
X-Received: by 2002:a5d:64a1:0:b0:385:f0dc:c9f4 with SMTP id
 ffacd0b85a97d-38c51967de4mr3374457f8f.20.1738172534655; 
 Wed, 29 Jan 2025 09:42:14 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176490sm17318970f8f.1.2025.01.29.09.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:42:14 -0800 (PST)
Message-ID: <b3d523fa-fb02-4e22-a59e-b8ced6316175@linaro.org>
Date: Wed, 29 Jan 2025 18:42:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/34] target/arm: Rename FPST_FPCR_A64 to FPST_A64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-3-richard.henderson@linaro.org>
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

On 29/1/25 02:38, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     |  8 +--
>   target/arm/tcg/translate-a64.c | 78 +++++++++++++--------------
>   target/arm/tcg/translate-sme.c |  4 +-
>   target/arm/tcg/translate-sve.c | 98 +++++++++++++++++-----------------
>   4 files changed, 94 insertions(+), 94 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


