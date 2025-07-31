Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5642C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 21:28:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhaou-00088k-H4; Thu, 31 Jul 2025 17:28:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaXD-00015M-Bp
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:09:55 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhaXB-0004c9-Rc
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:09:55 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31ecd40352fso912505a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753996192; x=1754600992; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+msUqKeJtOPYHsf2Z8coTdhHyrlU6PDEv2IGL7Fa0Rc=;
 b=wWSlcnd1a17DtcNQ/UShYElP9MQpoNSSDDzOTu1mdyfNZyKymW14a+z/RH6oONfkoR
 S8/QyhIpZoASmdNSvnfUWUuFG7f0OVqoOS62ZcuGfFIxmiOI3Tmtw1L6NrK2P1FqmfsY
 OSswN9P8Ho9Akhao8jmR2+GH8sGF3+rvQMCkvTxDRZtHEmjjLjSw7vu5lQC3s+W72hTK
 A3IEcwJTh1JnAAqU6E/JWKm3/wOUFees2hLrgp4/WE0NlAxcqoMp4oBEkHlMfCqyhawz
 IIC5F6mc4AnpavZDf7D3AnV8popC5+agJKGxfpg5mcK1bY43/3vSpQcOZHRI4LEDwu9/
 iArw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753996192; x=1754600992;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+msUqKeJtOPYHsf2Z8coTdhHyrlU6PDEv2IGL7Fa0Rc=;
 b=t/0d7eIS4zk/GwgNsCwbcgoKvSRvHG0cmsnBcZqWZs1IhPVWkvohIg6d8bovGNoFNq
 Huve/Be72iQKzIqQnKVishppjP+AEWiQQ4KM8QqijWJP+bT5uPrcocOqhzPYw2fK5mLt
 CqnLY6Yhuv38fCbZdkw/tOf23FjfR6qcOR+aPz+KHstQn1wZx3UYXa2pO784B6BV2hl0
 wd77E6kKVRrowu7oLGcek19C7A2VgmojQb9CuMAVebSHO8TwzxJfX1YK0RIvy/WCXYBt
 RIO9MO85La//NmnMj8o5D8r2mimyeIHGMCrYU+3j2qIwXWJqny0c8Il3+jqB79s2yZ74
 +1+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfzSNBzeqiRVM5S2OeI5QAWeKRGxWBBbAI6pqRPUDkJIxLYYciGTAJyzGxDxmwiDOx8GV9BOGX1g18@nongnu.org
X-Gm-Message-State: AOJu0YwmLxhM0HUdaO9DfR996GXlow2n9s+qNwIYrY4+dL5eNKQ3yZzh
 5iUELp/EQcZsz6DE1GBFvF8vrSs1yLbFDtCUZWQME9xwwRT1/aN8+w2SS6UR7eXlxxE=
X-Gm-Gg: ASbGnctcDKygascr07+PgUEnCRrAR0gBCWc5aPY4wl2AhmRrnkIZX6KqNlPwZwBG/QB
 8FD6uei2VU7QlUQsDHHLIiMmEOxwKRftBJDn3f3uHtbmfYRRbryDgEBqZ4F0ENP4QKnMLZkkFXM
 yfJYZ8hfGvdSJWbach2clau/QWULokP2d/vZuT/4wVOMv9WfrJyx5Ua/3lkFpjrJ7n9rM/xzxyQ
 I11WKIv8daWxjmasqIhxEPNrALvOwgsr9FS1AjfntWJETD9gguhEewBwT1STdYKTaiiPnwOBdQH
 PlS0+pR4WQLXX6C5xjB3kx0toLCsfC6fsksLjzsWTcYN+s3cMEN27bQU1Wx3VytlipuNwfJIBzE
 MlC4RFXinL4ksGDyKvC3kDgbYbDxJPwdRUps=
X-Google-Smtp-Source: AGHT+IFVcVYliSuKnurN83ag1sy5RMIjVt3/ks3iKe1fgaSKIfMmjoI+FGToFijhNyDDVhAOfnQ6nA==
X-Received: by 2002:a17:90b:3ec6:b0:311:e8cc:424c with SMTP id
 98e67ed59e1d1-320fbc1f6bcmr377675a91.25.1753996192360; 
 Thu, 31 Jul 2025 14:09:52 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63f0cb39sm5493816a91.30.2025.07.31.14.09.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:09:51 -0700 (PDT)
Message-ID: <5ed07015-de84-4e1a-ba21-9758ce2ca5d1@linaro.org>
Date: Thu, 31 Jul 2025 14:09:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 51/82] target/arm: Introduce delay_exception{_el}
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-52-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-52-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Add infrastructure to raise an exception out of line.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     | 20 +++++++++++++
>   target/arm/tcg/translate-a64.c |  2 ++
>   target/arm/tcg/translate.c     | 53 ++++++++++++++++++++++++++++++++++
>   3 files changed, 75 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


