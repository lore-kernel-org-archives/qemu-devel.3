Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962D1E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 08:51:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIl6L-0005Y3-R9; Wed, 04 Dec 2024 03:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIl6J-0005Vu-3x
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:51:15 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIl6H-0002Vf-Ij
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 03:51:14 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385dbf79881so351723f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 00:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733302272; x=1733907072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7sFc6889NF5XQTpNHkkYdysFK+mcsEJBJSdLnQpohI=;
 b=TlbVVgzglpaDB/f4v4GHXlTZZeEzcU8dKkrupLxXQgheDfNQSy7y27lPg1LioCmgIq
 RodTXuABjaHaOOEjOqMn9lAVD+k4MJB6j9sE1Q/LpHjEocNaPTiBY3ITmzVIUHy97sTi
 /OwC4lHSVyosJ4NXm4snegY8O9xJAn5jeL/il96FFcx3y3UIqaQe/CnOkmN3Z1NdYnL0
 S0bcPk3a1jLJNSPrPaA/Z5j9t/Rd+8gm9kAraGDGupIvcPUkNdlNTqUUQKUj3HCwqBpn
 +OmGTnTfhvtTO969sBHC7twDr4Zn/VGdfNR1tttIS68ZfQablT/53i4MCyBRfAP9Skf+
 dpog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733302272; x=1733907072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=W7sFc6889NF5XQTpNHkkYdysFK+mcsEJBJSdLnQpohI=;
 b=NIVYMCDOMKIDFJfDGyY96p0Nv2qTX1AWB5od4MWm9JfVGGE7WmMb7a4LABO5LelDFQ
 oecxNIjgF+OhCs5+S0xhZLPIeFWFl5oUevtufIWPNr0bann/aZFeMaWhC5GL1xi23Iu/
 uFTM/O6cZdG6+2GNTS3mcOufZooYqIPzuQI8QSY7VEBnAQIdq1J6XuLUOoQFF2ZJX6HZ
 yWYqZpmO/kGorPNLimUARp6XFACWPC3oebPPcNzyXGrUKsERmeZlQpDQiMQbCWQITZDi
 4aWph7MI14KfnGhBOgp5jL5VjpHL0QbLxWFYbzHTV+L2lUH0+FKE6ULAs2XbXDCDa8ww
 HNjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBTUCbdO6TFn8kbVMTW9g5In1H7332MPffyspCpgIdSXrTcuhdy2s4HnWcDU5m2uoSP/rDqgk7yiNR@nongnu.org
X-Gm-Message-State: AOJu0Yy6Rpw5hFJSL8cS0nGz9dUwe/cpyzzFbWKsLFMF4fJla9Yp8tQA
 fcmuuKowaerdJujWiM29aZakxb4XVVzgoZqsKOsAAU2PnEee+CMzpYDgqUEuNc4=
X-Gm-Gg: ASbGncvNq6T45o6zVKMKW0aRHVnQMkhnH7u/VM9IZ+iE4GnSXUOZ0O3ITjnA6S2+Kbc
 cXqtFty22YAgwN3qbecfqXq1mvR68s3teBM8MJ1G96hpHOgEEa6pvsr3hYs+RXqdyrL46McpdIY
 99Z1wLWY6XzLxupGbs6ycTnZqxqM+1f5/PczILi/ovtwt5PYMC5CACKFcjq7nq+6GBcw63cAuTN
 LXALCtiUD9mwvtcdTVtROEzS6bfg/usVmExHjg+aZ+jOSqA9qwjW6op9num69v3tWWVVJACEKeX
 eacssV2xI5+FqBXYMkxZO7u+dsLVcHBZ7Rsi
X-Google-Smtp-Source: AGHT+IFBf7MYj1UbapXPe+g3rWgefsHY7fs+/9LZs61uBQssPCAFJSZcbr1RJdadwiFJpqKChIW/Cg==
X-Received: by 2002:a05:6000:2c2:b0:385:e8e7:d09a with SMTP id
 ffacd0b85a97d-385fd969071mr5515162f8f.2.1733302271874; 
 Wed, 04 Dec 2024 00:51:11 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385ccd3a4bbsm17913424f8f.48.2024.12.04.00.51.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 00:51:10 -0800 (PST)
Message-ID: <21e0d69f-decd-4b50-8a31-c46a3a3fa7f8@linaro.org>
Date: Wed, 4 Dec 2024 09:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 25/67] target/arm: Remove helper_sqrt_f16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20241201150607.12812-1-richard.henderson@linaro.org>
 <20241201150607.12812-26-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241201150607.12812-26-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 1/12/24 16:05, Richard Henderson wrote:
> This function is identical with helper_vfp_sqrth.
> Replace all uses.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/helper-a64.h    |  1 -
>   target/arm/tcg/helper-a64.c    | 11 -----------
>   target/arm/tcg/translate-a64.c |  4 ++--
>   3 files changed, 2 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


