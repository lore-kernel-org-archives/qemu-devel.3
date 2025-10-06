Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C315CAC5B8
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 22:00:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5tFB-00041N-Cc; Mon, 06 Oct 2025 17:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tFA-00040u-4w
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v5tF8-0001JC-6w
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 17:59:43 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-27d4d6b7ab5so78408775ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 14:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759787980; x=1760392780; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8gDJVKo2MuuSZFQQK5t6ffTeG+Pe/YFaNIEpTk2Dzqw=;
 b=qEfzRS92k/Yb4unawMWyows2nYFgesDyI/QqpYwRDN6gLILE8+KosEBBSrq3qWahye
 p3fBiz7YhqK/8y1cLcd0UusIFkGyn5MBMNYKxPN/x0a6eaXqi3QOp6Z6KdwQjhDzCAjm
 Eliu/Nk1RtDsFONKX/9mzqBjbvdpFQ2h+RqD+apzU9z8clqQeU95/Nb9+EpXDhKR2Rgp
 GYau9n2+J25afDaJvVa19FOHC5wiaiVTUbR+I/109v+3lYDA2BrWTQ5hZNPmUQ72UwcO
 aVFb1QK32jl8uHsuMjpovHfQQfZKBBtz4EYndWTS2sh1/G8BDjS3MiL7HBtgSLDQ21DX
 7EyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759787980; x=1760392780;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8gDJVKo2MuuSZFQQK5t6ffTeG+Pe/YFaNIEpTk2Dzqw=;
 b=mVLJguS/tFsckzvK3tMeQ+yswtOAtB0dW9PJItQSY+G9Cc068E+SjN4hPz1uwsYoS8
 LeBrSjkUOx7j/1HemdNaYAxUObRhA1Et1sSO6AfRlYQ+ETiWTz6BdQG1PB7Wk25vYB96
 ITPPmoBP8ErBYmr2itrdVOOKTuGirEPd6bIFLV73Fyc1cWcb2YVTgM4C/eJFHegNHReT
 d3kKXYpQxzoRub/hu9oY5hV/idQzxXlIiPA1jtu5YZ7UKChrE547aZGwXzHh+3yH/1lf
 MP7RxNTTP217K8zhdQZ88Qgwk+Nf9r5P0ZjkGFN67vV2qSBxH0LloMDN9O9fWUUVToCY
 CbHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCWYph0SVmRs4PSKgezzOdE3iOW9gA6JOksG22bVYcvRyOfVB1cxmwvFd8LdajEe/8i9Vt/9FAcUut@nongnu.org
X-Gm-Message-State: AOJu0YxXe0w6xa15DcuDc32xjJH7caUO7x0wZ6PIu8FC6Iv0RYFbkZNL
 JzMrXQ4/leESfe8+sVzc/Div9cIM8bOsEEA3zaP/C3YgNfBRSYlpDscI6v8bI85KLcg=
X-Gm-Gg: ASbGncubEimoT1JUoZg1b/Ge15h9idqVfM6whxYs07lwNvjFpPOjz/KbVfEBN5/1Mjq
 0CZs/ZNoEaRYcIkAO8yrqb0Fkm9r2b+yAFGKf1JP3c1KyPenyGBeu1cbtlwAACkSHIjYeNd01hd
 9a76azWgOoGkXVRTwHQUfv/6zkEU8UQLhT3lbwNP472BkLJww9+pZ8ZHN7JIJ/36o8fVjImc7Zw
 xPeyCuv830jYAmgdy6rRC4Iptwz8yoN4JnULq+HycdFSOAxWeTVlcv0DYmQkJ9ZJpkyY4ZsqQi7
 bmxPB/kPdtaujKfbTsA1sP2Hb+68WSBl1Ft9oeMrvcxyOqoaHkTyqrTm2bBOaAW25zA7y/iP+mX
 wgiXGhRjCWAjti/QvhuRvENQEO00feKTEdg4wwHgL/8fgtnEsQ1lz8GqlZxyj/cAWcCBRvOOF1w
 g=
X-Google-Smtp-Source: AGHT+IF1zQy+jJeK/hBgHjPsRhbIIs3NIXZiSSwQcxANJLu9CPW6+PSb8kTQUQfpfKC0uWy99aAQZw==
X-Received: by 2002:a17:903:fa6:b0:25f:45d9:6592 with SMTP id
 d9443c01a7336-28e9a65c0e9mr140912985ad.48.1759787980232; 
 Mon, 06 Oct 2025 14:59:40 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d1269b8sm142970975ad.50.2025.10.06.14.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Oct 2025 14:59:39 -0700 (PDT)
Message-ID: <1050e687-dd3e-45c2-99db-00f5d9932a96@linaro.org>
Date: Mon, 6 Oct 2025 14:59:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
References: <20251006145908.22594-1-stefanha@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251006145908.22594-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 10/6/25 07:59, Stefan Hajnoczi wrote:
> The following changes since commit bd6aa0d1e59d71218c3eee055bc8d222c6e1a628:
> 
>    Merge tag 'staging-pull-request' of https://gitlab.com/peterx/qemu into staging (2025-10-04 09:10:58 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git tags/block-pull-request
> 
> for you to fetch changes up to 21659e726e3832b33d108faa1046db79eb6f611c:
> 
>    scripts/checkpatch: Avoid recommending legacy qemu_bh_new_guarded() (2025-10-06 10:12:01 -0400)
> 
> ----------------------------------------------------------------
> Pull request
> 
> A checkpatch.pl improvement for the QEMU BH APIs.
> 
> ----------------------------------------------------------------
> 
> Philippe Mathieu-Daudé (1):
>    scripts/checkpatch: Avoid recommending legacy qemu_bh_new_guarded()
> 
>   scripts/checkpatch.pl | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

