Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A641C02181
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2025 13:32:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tc2k2-0006YN-4X; Sun, 26 Jan 2025 08:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2jz-0006YE-Pp
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:31:56 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tc2jy-0004Zf-9s
 for qemu-devel@nongnu.org; Sun, 26 Jan 2025 08:31:55 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-216281bc30fso83616975ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Jan 2025 05:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737898313; x=1738503113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xwyNbU6M3MPZ/2O3Ag6nCxSFTBuaiEpD9VGNOD+P+nw=;
 b=bQmAJGDXJxvkeQWn6p7RT2NhGOsFI8k0K+Q7p/EhWUTgzzuPNAR/OBQd8GO2t//Fhn
 PgXHPT6/RH7i5pryXfcSKHbOOpVbLgeEZe1E4Nzgr1cfMgGoIaTo2A97zcTScVTsj6eb
 81PJRiP6nDDyfJr2sdxEMLhd0Hv/i+eiERvp6XI3fnTPVg8mN3cn95z6Od5dBM8euhpV
 RC5wh86ciwJGWTR8ekHsyoBeg+L9cdVHUpvw6UpRBeck4eweqfZKomwRd1TtVN9cuFwM
 dRwBUsHjFuUkbVuRpCCqZu1hzFNNtwSPwA4Rwkm/ntzpmLHERg6jUyNpOJlWPyggLgwB
 yE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737898313; x=1738503113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xwyNbU6M3MPZ/2O3Ag6nCxSFTBuaiEpD9VGNOD+P+nw=;
 b=vWYiMILoyblU8VupfMX3VZPx/du9Rm7hY8EBnZY2mEX/y6XXLhWysb+Rahj57VJLrm
 cyWzU9TXBaghzqzheggSPkmQwwV9F9raQVLjdZmeyAaco5AFEtQ/BV2ZerIMY+2Xs5Dw
 l/4flUNBrYcpWWmCV+CaCZ0geE/jCKeD1rG5C8vcZSvTyLwA+CfSq46KOUlnY6GzMGy3
 GoIDrTrSXkS9J9TqdRS8qmJuxCY/hHkNsW14M7J/6ml6dn1iro4AQSgk6TYN3H+k3zYv
 BC0SeKbtksZs4aogZ9dBwViY6Km7nS4iyL9ggvKnJm6Q/dcVess40OphJOBtd/6eUYQB
 GYgQ==
X-Gm-Message-State: AOJu0Yx3LGUiJ9odUxPVp/AFixdVFq6LQkMVmJ3m0gtjVPHYhMl8yaSI
 TKlwyg3qh3eLaQJp7RkjTQHM2sArV5Yg48iQa3brnCXZc+JSpA86mk97RjiGR0D5JClUixJbz67
 8
X-Gm-Gg: ASbGncvaFH0U2OnoscUST9LcZYVt6TnbYpyro5FPXUgRDykNOXtDrEck0a5+ySKM4vd
 GM5jfPZaIYY7+K+iG53iJQnbAff06KN6sGxs+8BMXy9ODVEJ4nbHXCi2d0TQLnbCYGSX/FMX5tJ
 /ua77xxjBVnV7Dj0BPKw8sCSbMvB8vPyqQbjTNRS9tx9ds+92sw6F2LhH8AD9AVD30PzrXk+rMk
 d2CEjk700opY+QGWsH50s3fYNQFaAGN1VAdDPVDmvks7gIbAXRKS/WF5BW3HGnYQa/Jwpe7nRcg
 opourSyLYiBCurXVpvz9fWU=
X-Google-Smtp-Source: AGHT+IFM69f9HHMPvH0cLfLcMJmOOFYaEQDrEPFMhrJ5rRjHGdfRaRcde2bqUZVfalP/qFAkAUkofw==
X-Received: by 2002:a05:6a00:2184:b0:72a:8cc8:34aa with SMTP id
 d2e1a72fcca58-72daf88b65dmr56629043b3a.0.1737898312978; 
 Sun, 26 Jan 2025 05:31:52 -0800 (PST)
Received: from [192.168.163.227] ([50.225.135.10])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ac48e84d0b0sm4587162a12.5.2025.01.26.05.31.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Jan 2025 05:31:52 -0800 (PST)
Message-ID: <dc67f5cc-358a-43b8-ada2-25ed57e9a80b@linaro.org>
Date: Sun, 26 Jan 2025 05:31:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 75/76] target/i386: Wire up MXCSR.DE and FPUS.DE correctly
To: qemu-devel@nongnu.org
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
 <20250124162836.2332150-76-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250124162836.2332150-76-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/24/25 08:28, Peter Maydell wrote:
> The x86 DE bit in the FPU and MXCSR status is supposed to be set
> when an input denormal is consumed. We didn't previously report
> this from softfloat, so the x86 code either simply didn't set
> the DE bit or else incorrectly wired it up to denormal_flushed,
> depending on which register you looked at.
> 
> Now we have input_denormal_used we can wire up these DE bits
> with the semantics they are supposed to have.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/i386/tcg/fpu_helper.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

