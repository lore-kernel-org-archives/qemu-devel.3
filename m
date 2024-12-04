Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D0E7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIifY-0002WF-I2; Wed, 04 Dec 2024 01:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIifO-0002Tw-VK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:15:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tIifM-0004FA-JO
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 01:15:18 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so2272037f8f.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 22:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733292913; x=1733897713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UCfnhjjdX26m2YYhIWZbrWMg0XxTx4UjzICc/TjPCW0=;
 b=E5f0PBVEDIEk8l/uEh9IyyKZHQEapqNVPRWgq53GgUby9RdkUewsxGms0F+/UGqCFn
 Edg8P0/xTBfFP3kL8pKFBC9EWyDyhtPfsAYr+J/hCbvuOqKhFphOOq2jBAZgE7wXSgqX
 0wc9DpfofHAhg/TKV+DgUCAVvvH0/w6V6ZQ1yehIOnpVJr6OBBKM0RmXNjn07keTeDmV
 dB798/PK11+f8dHvvHjRflsFizTDGO2yeTsQX3lNS2l0ZmAV7eA0eC3TI8Xn+4JW6LSy
 L8C58FE3h4AOFEerrMcM2oNU63uIwYh4epSaG0ctUBn7moICIdUVAeKoDzjgLFR9O3S8
 RgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733292913; x=1733897713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UCfnhjjdX26m2YYhIWZbrWMg0XxTx4UjzICc/TjPCW0=;
 b=Oak7/eXX9hwYcct2LC701PP91D6nc8fPPO0fRgsOdc3GmQmIwbG2Rco5RZHTZdey4I
 7WsA9KxG+dRHyvdSLDkR6l34TsWMknEvkp00dsGWPdi+aW/wOKeqEssyIT7w84vhX0kP
 ECOpwjsy9wS8kqieUfkYmwzn0c0hnt30ahDyK6FuuzCOpsKi39xQdE+IaOIj5riifW59
 NQC1nJGdF1di16nYwTdAY/oBDrB5dpMymh9hiJH69WFK0Ub0Mi+dGnl2NdAQCVNgx6w6
 i46EBGoj361SbJt1ZkxAn7X9hR8tKPWDpC/O3efNPWlW0f2oLur1RmJwM5kk/jBN/kR+
 iZDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWzNSmc8752we8rCLwx+h023UN2aF5hWYWRODglI+8lf5SHHMVUbpjxFMS7OdUKAG9Ikv5QmncGZ9h@nongnu.org
X-Gm-Message-State: AOJu0YwFi1EX9t1PX/Nt1HqJBRI30XviTrl+JZvxT//G0ZkSrTlzVs/G
 SlF81AJt5PBz9vYBJjOsk/ttQmwLWyvQRbBGNx0hwT7Et1xficrp28blp9PQDqs=
X-Gm-Gg: ASbGncuFiNd5eBr1RSzMmzOKlM8XHYJ/1LHFWT11kfJDRobKu/2Q8kRrii0jmKnQuXv
 QPV8t0j6q8k1A1TQDSN8haIbEETV3zwVAPmGjqflO23P4ou/wvP/Kmfibmsr9Xf+15RRbGCuuWP
 ak/c/KhuEUlTjCX/j5seDLav6FFoJBwvDm8pQZ2zW7WCO7BHIrIar3QfJNNzny5f4euozwHfLa8
 3cUfJHfZC8fSdeCNfiCrgFnktLYZomiWE7OlA7LSQMKtumocdu4R3F89CBix1CDbCRErtKw5iPm
 cf5+eJymBsIyucU5y0US8UUdc47aSDwNA1W7dnNDEQ==
X-Google-Smtp-Source: AGHT+IGTU1nlxwVjXMq9EnzhGw4IAz4zx70S6Jd7f1OjM3tMLEOzYIII6IwM53UOMpMbzY6Rb+acmA==
X-Received: by 2002:a05:6000:1885:b0:382:5010:c8de with SMTP id
 ffacd0b85a97d-38607c164f8mr2426263f8f.46.1733292913425; 
 Tue, 03 Dec 2024 22:15:13 -0800 (PST)
Received: from [192.168.69.223] (sml13-h01-176-184-15-95.dsl.sta.abo.bbox.fr.
 [176.184.15.95]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-385d97ab259sm15584815f8f.95.2024.12.03.22.15.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 22:15:12 -0800 (PST)
Message-ID: <558f36d4-a113-4cb6-bd72-b93f05f2cf2d@linaro.org>
Date: Wed, 4 Dec 2024 07:15:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] softfloat: Use goto for default nan case in
 pick_nan_muladd
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20241203203949.483774-1-richard.henderson@linaro.org>
 <20241203203949.483774-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241203203949.483774-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 3/12/24 21:39, Richard Henderson wrote:
> Remove "3" as a special case for which and simply
> branch to return the desired value.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


