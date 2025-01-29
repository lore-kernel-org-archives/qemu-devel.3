Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E66EC02193
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 17:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdC58-0007mV-PW; Wed, 29 Jan 2025 12:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC56-0007lG-LA
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:28 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tdC55-000442-4P
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 12:42:28 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so48795455e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2025 09:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738172545; x=1738777345; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wd/LUf6uv/W2ikZ4DFPHC+tSnuUMrmNvWEsLs0RJFl8=;
 b=x0uN23sFonC2H9kVs2Dt3T88v9eC3Pk9vNNx0IxnBefujHfD3nHcR2VMUOn4GKAVf9
 8BObjmkZJjE+1K3mlFqUhbIvzMhmVfhlFDaWT8twynk+x9TcsyOqSqND6AUM+syOOwwc
 xqw4rIUb7JIlbVOJgLd1rO/VvTGdu368mp1x2+w2VEAh1y7GB7V6ORgk/GY232UQNh3f
 yrRpIMoMJuJNA86oNC0LRXxoIIrXOWkJuFJ01Uffay592LEU9akN1zYjlTau4KXRfI3e
 qqL5vuU4cs4T7YRiHm8oY5W2BgCIUfCzVuJL9d/DgwpOAWMFQKPBPxWnOtkcPQwBz4rG
 lTMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738172545; x=1738777345;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wd/LUf6uv/W2ikZ4DFPHC+tSnuUMrmNvWEsLs0RJFl8=;
 b=hpjxY5VREwBeCWC74D2hxD7NS88MdRQG0/9i9WmjMxwrLFWA65SZDJhdXhOyqzKxgE
 xgcbhKqf/JKqvMHomgo8c8SorrR/MF8So05Mnebr1UsdNaYVhsYjeHj3Ot44qoES41Mk
 h7jHORlN9G/41uLvIcRew4QxOmMmbG14rcqS+z8JLoUR/b9KOFFZ6QYuUroK/DLnQVuV
 nw8tFOmr9XtbJD9tzflQjD0QkmgLCSckR33rYdGEm+yn237HUBt471CedkK/3leP+lJQ
 7h4k1gJOjRSRxCvK4fZoEMxOz/7EQhhayai0NO7KxK4euVG3NCIqhhanWlPZkkEq9XKz
 ooEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvWslQexx5Dfy3QnsZTiKsrV0OJy/uefveSJ2pnCU/zTYOqil5sDiaWuQ5hVe/4b0kCE2cJWSnZXYi@nongnu.org
X-Gm-Message-State: AOJu0YyW/aTN7jUjaNAyUUA8NxEvk5GeUM8G5wImqj6iXzoh8V6/k8pU
 TzbLKdrWBgw268fFbfRVUX75Fs378bmlnziD6dEf3gHahzDZfiYIOkjH707b/q3qmpdRorFsdZJ
 jmQU=
X-Gm-Gg: ASbGncue6GV0KOds/jpZg6dN7LpQZf+Xz8dHztKKPk+EdHMmHZ3qKwxsitkVsArRKVN
 OURnkKTTq0HwkWW4GdK/8ZrvO1OSraAIE+NsyoCe1HlclVJZvfNfIXZtnVZTiU4f8aA6SpLruaQ
 6WL+rxse8qCYp1yjwaFQEOwJpKRTl7cFdomscGnROSpyyh/IQpliq+zBR+ccXWfFzuomuRrUuQd
 9idKX8JA6DP4WvDmrH1rj79KZ3G/xFKaT1ucZEH/RqdSxTFWiLdQksEIIMmdrdRK0FvXKQjHTQP
 OC3bfL7XKndFUDHzADAToKXZjhCgeIXH9qcha+jL4pu+jr0YLQ2SAb2v94r+khw1khZX+A==
X-Google-Smtp-Source: AGHT+IGOPDIyAVPQbz2uvZ1PhNrfjbstGMRaftwWF4ocveVrKGGzLzBsAYtbI3zmYkPajdGvQLPVRg==
X-Received: by 2002:a05:600c:348e:b0:434:a734:d268 with SMTP id
 5b1f17b1804b1-438dc3cbb7cmr39354295e9.14.1738172545364; 
 Wed, 29 Jan 2025 09:42:25 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438dcc11bc1sm31144125e9.3.2025.01.29.09.42.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Jan 2025 09:42:24 -0800 (PST)
Message-ID: <fb7396c7-354e-4eb8-80d9-e3801c6c1d00@linaro.org>
Date: Wed, 29 Jan 2025 18:42:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/34] target/arm: Rename FPST_FPCR_F16_A32 to
 FPST_A32_F16
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20250129013857.135256-1-richard.henderson@linaro.org>
 <20250129013857.135256-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250129013857.135256-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
>   target/arm/tcg/translate.h     |  6 +++---
>   target/arm/tcg/translate-vfp.c | 24 ++++++++++++------------
>   2 files changed, 15 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


