Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE419CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 23:05:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Mvg-0003Tm-AI; Mon, 29 Sep 2025 19:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mve-0003PB-4L
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:05:10 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v3Mvb-0007fU-Ri
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 19:05:09 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77f343231fcso3000259b3a.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 16:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759187105; x=1759791905; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wuIbkj+ZyBCKGkCcEJQ8VZHPLPPgjfUw5c2woubcLGw=;
 b=dY3nAzhn1q738fPOBcYjg/NSPXUgovHEEOwH3hOPj6OJorbKSXnQzxegOLfCbuWxfB
 fEYSryh+2EWF+NXBpnpThKI6pbopcoTggR4emyqWehMqjKT7tJh1hOSaVnloWI/y7pqY
 DRloXli95h4MJC+U8h5W/IUiFdNLnSvCGqUAjxkpg+z6WpO0nXnz3NeQsbF/YS1QeL9w
 qXosjhAuVd/cIivaopmIRV/YlDXboUxGsvokPTHk5Pohi30sr7ZaLBep0Q8SZI4RkKeI
 PG0ibICZk76OI+Yo3ABOpOzoBJxDXgzNPP1js1nsnzXzzVXphj67PThL0uLTcQk9ob+Z
 CdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759187105; x=1759791905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wuIbkj+ZyBCKGkCcEJQ8VZHPLPPgjfUw5c2woubcLGw=;
 b=EGbda0X1fc4xzJxLgLHCVWm9NqwgRob6vyiFOQVqsqeU0W4RjPPs+I8jzVQkPGJCWm
 9mFw73cxpiUeV+LNgC1OdSuipHWfPZBVD5QUBmfG6Whh68Y3tKgDoy9TWrmlwh0oqU0H
 0StvIPcw5KkOz23azW3CgCXNasNdFxrRgv9h9h+GlmMtz53jt6mv2rNsZRZd60oo29Mt
 hGUzC/Gr+xJrviiFMpJwJh9e2VZhA4yBjDLxqBkhs5r6Z0w9aIwgLHHVwTDEVi/pBDkW
 79UqMYD61LUmWTO/kWQYXEjTjdDMmzsvXQvrJq3CL38NKk5BZxF4LCp1IJL8RaO5j8BF
 afow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmnSQOumYNlAwAEAlS8OAAcacStYJoJUrS0y0UlKNAcRfjiyNX28/dE/n0HqmfvWgmzppKQ3j5W1JJ@nongnu.org
X-Gm-Message-State: AOJu0YwYm/ta2SaumjGw42KlWvfoi8p8xyjhXtlk9gMnOrvT7OBdkrOv
 M5sUETUID9u3hA/D+TIO1oY9FAFLTnzc1g9J1xbInPzhniSCUPJBRjEWqYFLQOavATk=
X-Gm-Gg: ASbGncsDn9KgiHSWEGDla/fOb2MPVlxIkfLk0UxVjGHV5JdlSAY6XxjjLNbINGl7Nwm
 QPqpmDoc+CJ2CuI2Xe0goLatZ/t1chyhD2advibNr6Cf3HtXVOcezsZ7xEHO+iOhIeDu/GCfjWN
 8ZhN+HZ3ycn5nC/L1WyOTMCQOHwKkQY+D3fAM59yNYnlhTBpBPuf/E0/qDU4i0/B3bFf2W4y1jo
 a+kgBjtKY4LsiHrIk6J7kwuTsff+AUrF/Wn3sKdDCoY2PFoAcy735qagWrq0jULVU0NnzEd+tCb
 Ky/9lsUhbY5uMEV2QopR6C31nbGpD+5o1EgYraptRa6MJ0EnPYtQE5luR+U8I1H4583+6Pi9N4R
 OIrBq9pdRxuFn1LQ79AcBQmNQ7KKU1xY5ctFDP5gX7xEiChvbqiN/NzjDf2M=
X-Google-Smtp-Source: AGHT+IGzuRaFymrc7g+Kt4xgX+N6NQNehPHlkm0WhyYDqrgCqPCh6fz7Zo2RZFTxjclodmZ0qWCiYA==
X-Received: by 2002:a05:6a00:2186:b0:77f:2899:d443 with SMTP id
 d2e1a72fcca58-780fce1d14fmr17385349b3a.10.1759187105561; 
 Mon, 29 Sep 2025 16:05:05 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78102b23736sm12216303b3a.51.2025.09.29.16.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 16:05:05 -0700 (PDT)
Message-ID: <84dd6956-1bf2-481e-9a0d-da2b45224900@linaro.org>
Date: Mon, 29 Sep 2025 16:05:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] target/arm: Implement APPSAA
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250926001134.295547-1-richard.henderson@linaro.org>
 <20250926001134.295547-10-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250926001134.295547-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 9/25/25 5:11 PM, Richard Henderson wrote:
> This bit allows all spaces to access memory above PPS.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


