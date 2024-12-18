Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF69E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuVE-0000tT-8K; Wed, 18 Dec 2024 08:54:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuVC-0000sz-E5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:54:14 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuVA-0001Ne-Sp
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:54:14 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-436202dd7f6so70313505e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734530050; x=1735134850; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YnecDkPWabEfne3y0nP1JY8/y4mWLQYxsiiI/+bZmuM=;
 b=XnMUQ3v81HKzz8ZW7ioxob85Cb+L/7SHzV24ELka1pdpVcpdQC6F5Dms40f5BhtxID
 71wmFwRxYVle5LF3EPuVY6HnFfaiCzGHGhg8oqnb3s1QnS9idMEFFgCnzmxvIoXuC1pN
 5wE2bly3bHhHmMVWtvUVUsYXRH6RnESIZH9qG3iJre5CJU6o3ji7UBDymdqySP3I/S93
 msa6b1d92lMrVHOIqHsh6FKzi5SaTViQN03/UEQ+HBb6XZ5+3B4Nu2jCuc8enT/0PRCv
 q8e7ud5vX2qvWpLrfGANDPhcrYl1c90hOH51WMp9dnvhq6Wf4GfBezVSuTmIUCA3bYwH
 S8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734530050; x=1735134850;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YnecDkPWabEfne3y0nP1JY8/y4mWLQYxsiiI/+bZmuM=;
 b=RJo7Hqs4zAm7nB49z1JH2jLdHBflbm8Po64AFDcVhnaKCu/cFBXsj8TfDHpQYkywDu
 1MC3uwJ6WkfxcGi57ECHNeJ13JRNltGjXdvBPx10kkRKLuWUWbT/Pfc/WgUmaqr0m8cB
 ZKEih7anR0vpyO+/9P1x3wHd/BXL8UtY/n2NkH3eXu8kDuyWDvKZ7X1jcy/vSRhVNiGy
 Ztv+SkPrv524cg1HqqE1vUwLaE0t+crswvNtZQzsiu4Ihm1ywFwIGBTpCSyTQp4zB3b9
 Day2y/qHdSuf6o/8GsJ1vVZm4SdM2Ek1+Cw7fxNRQS2zAxS0njZCwkI/YV8TG4Ufc0PO
 wIdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/sCFR408h8ayMH6SUcxJP0gKFfgBG3w0kONSqTHQz9SYS+gSkcZG0X/IIlMjeSQqHcKXcBRpqHIn6@nongnu.org
X-Gm-Message-State: AOJu0YyjI8pckJuQJ+Pouk/wtsBXQLtJeE/UKSDNwn5QDtBHjqo6xNEt
 bvqBXBWcYrlN9Pch5L6MTcyLuJz+PHmN4j1ECNMaZGC33cKjdm6en/u8MQvxHVY=
X-Gm-Gg: ASbGncsZLJPOBJ3dO1n8xr3qi//9DYzE3BfQfwozNy01I3Cz8DVvZ2fCtzFNZ/ri3zM
 TQn2lS7nghKpSkYmdbNwm7Ir1FaR3Zozzmcsazms+KGhCgRgKIYObkZbrsMiBKw44+47W+IukPm
 p3hJn8OUU74sNF1Nm763t0tWcJGZ5cSRDeLh5Ogb9GMJc42mSVVol7A5F7mfXq2unzwRfW+oIMN
 VdJaVtF8Ka/WZwlR2KTSn8r/9Mx2aGCjGblD/rEBOl7ru6EnsCeYirpCUshVUdegtAQtJWK
X-Google-Smtp-Source: AGHT+IFzt+1lmnN4VVG9GkVfgVTZeBUrOCCFqJI3ujKzPT6P/gWmNxk/NvYCuIuk8VlLxreIFra/bA==
X-Received: by 2002:a05:600c:3106:b0:434:fa61:fdfb with SMTP id
 5b1f17b1804b1-436553685ecmr25967275e9.18.1734530050149; 
 Wed, 18 Dec 2024 05:54:10 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c801ac5asm13913070f8f.55.2024.12.18.05.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:54:09 -0800 (PST)
Message-ID: <116cf4fe-7b27-45bd-810f-daaa7c0d5ec8@linaro.org>
Date: Wed, 18 Dec 2024 14:54:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/24] target/s390x: Use s390x_cpu_properties for
 system mode only
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> Avoid the empty property list for user-only mode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/s390x/cpu.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


