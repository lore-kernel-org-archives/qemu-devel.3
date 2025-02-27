Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40934C197BF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 22:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnmA9-0008BS-8y; Thu, 27 Feb 2025 17:15:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmA7-0008Ac-1m
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:15:23 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tnmA4-0001Xz-Vo
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 17:15:22 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4397dff185fso13150875e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 14:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740694519; x=1741299319; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dQ8oRyWp+zcVZSGxJ/QE5G1tnsxekhvTRwNh6pijwrE=;
 b=wDBGaUPQ13m2InvaPGaRK26heHg0ckioz6deNNLKtqjGsdpmH+vLhxGh2sbHIgnIIn
 twfK2ahMJJNdc9+g321aP8QzgyK/bpnfSwRaTSUmYGBq5a1GhXIjtqzgVrdHexoIwmaI
 u4RHVMQT76rn1cO1Pj748JgsOUnLlbqn5GwmX4bOvVSixB0SoEloBuIvspnAyRJFOBhf
 UoUmcreW3rjVhoHYJMtQRjTuYA3Ea4GWXtdY6ivnKCaPwYZVmH8kAQ1N64+GA4ZXv2RB
 qcM+RCSrdcGlrZLgXDbvB7dSooZjZhHtJzk+R9UaBYt2bOhzE+i57Tx6os//4WUb0y9R
 WqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740694519; x=1741299319;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dQ8oRyWp+zcVZSGxJ/QE5G1tnsxekhvTRwNh6pijwrE=;
 b=HvsPPkxacOBe1ioF/fM9Vw5eCeRHwyGAFLfB2pKW95Nqk5FPpazBhdVfd+7UtOmvrA
 NTj6vyA7GR1s4hfwKQQQG+ZaKrRv63us9/hBZG98ZwG3F6j9WqvHFT7EzcsF99AK4esk
 a6BMEQsfkZZS8dMYDWo1mhW/IUy2qd+F9jximcEXpzT+b/WaHDF4nP+hW4hgisQtDDrT
 568qPPGHd/awaBjA8hiGZZofhz/1Xom6aE7xKROoirE9TSwFoCqmnG7DOVPewfxXrSkE
 a7FmRwaj1iGVKa3xm4KlhmZK0CXTwWpmQlv7jPfQgQwV+DzYr4O1mUfdi51JxgKg2Gdu
 pJMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf+NtWy5tIvUCJSRHPj6JzV32HiseY7KikQkaRPffC0JsdYjXURHQ4KcjJVyq9wbV3uLyqqLyQ/jlP@nongnu.org
X-Gm-Message-State: AOJu0YxGA9idVg0g1JY5ZltsCsVOp2LCGXSB+82mRX8nsHiFfxNfSfbI
 XnSPGFRYrxLnHJeKXscqaQI6MZfaFlPzj8pshCjIOlzH+jTtOyiNln1JPgCKwTttpUzIjxcsJge
 xckdwMQ==
X-Gm-Gg: ASbGncueJqljPZtWr7GJCY0V8gmD/cHW/j+NiLP3DrCFGXgRFFVPMrCi+LtJin7zDCg
 2t3u+MV9wsi1KGQtJSP9A/eE91TaSRioh7us54Ie49YM8JbC6iqzhuwO0Aeb963lM4WNq7mn4+v
 EmxWg+4FhJox5JXXCEAqxcrEftsx8sqvfOtQD3Wc93ljdoqy6k/kPSQGoJHGV+7Dax45i4x32Rw
 Ry9Jw0Nhe4DNXrCo4aUxA+nac+IN5spa0z1pjWGmJPgTblSwTVdijRJ3G77M1TuK6ieVC3uf0Fe
 KvGGscDdQAiwjNhy/HnfqEoa6SzgTmdiSGX+4NRqTU2YSLU6qxyUQkfL2kkVQ7EWVO9wrQ==
X-Google-Smtp-Source: AGHT+IEnkvnD7ungF1mBn6eK9yIEoU3j9JKeTgVj/UOY6b6J4hzRripUcnMHBxOl74EVmREyDe1OAw==
X-Received: by 2002:a05:600c:1d82:b0:439:9543:9488 with SMTP id
 5b1f17b1804b1-43ba6727b65mr5835535e9.21.1740694519186; 
 Thu, 27 Feb 2025 14:15:19 -0800 (PST)
Received: from [192.168.69.202] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba4c345asm71633975e9.0.2025.02.27.14.15.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Feb 2025 14:15:18 -0800 (PST)
Message-ID: <172cc542-939d-4415-95bf-6ead94c2ced3@linaro.org>
Date: Thu, 27 Feb 2025 23:15:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] hw/arm/omap1: Convert raw printfs to qemu_log_mask()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250227170117.1726895-1-peter.maydell@linaro.org>
 <20250227170117.1726895-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250227170117.1726895-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 27/2/25 18:01, Peter Maydell wrote:
> omap1.c is very old code, and it contains numerous calls direct to
> printf() for various error and information cases.
> 
> In this commit, convert the printf() calls that are for either guest
> error or unimplemented functionality to qemu_log_mask() calls.
> 
> This leaves the printf() calls that are informative or which are
> ifdeffed-out debug statements untouched.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/arm/omap1.c | 48 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 31 insertions(+), 17 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


