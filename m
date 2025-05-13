Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09B3C3ABC3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 10:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEmW6-0006Fc-QJ; Tue, 13 May 2025 06:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEmW4-0006FT-Ai
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:05:40 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uEmW2-0007mn-EB
 for qemu-devel@nongnu.org; Tue, 13 May 2025 06:05:39 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-442ea95f738so6459075e9.3
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 03:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747130736; x=1747735536; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9P9CoKOXto2b2QnaxdqU3rk2ZVbOrMJz8BSwdzzd+OI=;
 b=d01xpQd9C6ZbsNXYmm5Mfedzj+8KK6RAVvDrTTsJXihgrhTHgb9bBRI2Edxux2OdLL
 EIJZtdyXyXWBAaed9ywTS6sR+i5UvlC0S8l89F4ykw4bpQr9dF0BDmf9KG6XvrIm6Lyd
 ET2baPag2F+ywXnmn/Lnl/sbPEMGwcc4JWRjvZug1f/fdBxyG6AySe58OSRDWO/z49GY
 KkWJGlBZC1kU0repjqkd7h2uFuAKHUNXDG4039Mc/qNFcVL9k7+ytu9JIhVaGDI9QN0I
 2evEIEsYzioLBKWUXbqT1kBZvijfrelQYzr1ZUXVWuwtis2bRJUrklCAwkdbbdUIehry
 ATvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747130736; x=1747735536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9P9CoKOXto2b2QnaxdqU3rk2ZVbOrMJz8BSwdzzd+OI=;
 b=Yy5IcPh5Bs4ad8zU1I2AJQfvwWrq42V5lpdKBXo7XutvMWchJ+42f9PfyfPq6GzjP0
 AjfzNvPcdEcJCdrhdMWxhObl3wEzFNJittom1La9ztdrWmIgxQBZOSrgEkFkAqgeBCKY
 4HwtYIUEoOiTrmt7KXGnp7RbBFGAWsQfH0cxlyPI1uWmb0WR6ciuDXagKq/PNe4Cxu2d
 nmI8YqyuVEDk6hKvOq/yzi+ArDnHwgfrE8lETRi1edyqUrM0QOnYYa9p9/pEfWcUJqot
 CpdP4OlDCxm3sjTrx7sdyFWegI1cqsMIU/Lu6KTN/o6hgCnPVSarlU7GUmI2wteaE+a+
 3TdQ==
X-Gm-Message-State: AOJu0YyaYg7AhEG2V9veg6kByAP9yYxV/aido6UHy7Wyrwmnmrgj8yU/
 l8xEWYiynjWNsk38vKSmfdPv1fs7WZga9J/auYHeeRgL2eg46O1rVKOyUil0ws1QpVNYrjCZBek
 SK2g=
X-Gm-Gg: ASbGncv1DSyDWukIXSEfy64zT7VB+Jp0o76fxqybNAcKTCsakrJw26ySTDmRt987uAM
 fWEfBnRumFN45bx7LUOarzyrYvHaavVKr8B79IYckxXYPqvqq6jYGhRadcGzati+STBU54c7fOd
 VaPd+rSs31nQkKM2vjX2wXqA5EkJeGtHUtRmmYNjQyCQV2M/BsxdVCUZec9SDrWgXa6GRr8EeOz
 c9pzmjdd3b+nk3QrCtgmrDWZ1l/QmN+DVEbDa+s5va5vH9XO8mNLIdU1xSCjvoeQjutauvdr02B
 9DXz78G0d2koXOMJaDw8egVV81XWTtjAY44AghsGa7sUcftfubxO1oY9ccHFqGmpK4zwh26liDX
 t1OtNJxgwNFwq7qWM
X-Google-Smtp-Source: AGHT+IEgrMb3KvnO/Q9w4A/PFMynkRc5WTq3k38riyfalG9W50vub/jBI+hc0OUCeW49PDSwNzkOYQ==
X-Received: by 2002:a05:600c:3e8c:b0:43c:f597:d589 with SMTP id
 5b1f17b1804b1-442d6ddd795mr141822405e9.27.1747130736507; 
 Tue, 13 May 2025 03:05:36 -0700 (PDT)
Received: from [10.61.1.204] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d14e6d74sm192641705e9.21.2025.05.13.03.05.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 03:05:36 -0700 (PDT)
Message-ID: <c0f3e7b4-d618-403a-9438-f27cd43e8b9c@linaro.org>
Date: Tue, 13 May 2025 11:05:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] crypto: fully drop built-in cipher provider
To: qemu-devel@nongnu.org
References: <20250512142439.1101159-1-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250512142439.1101159-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x332.google.com
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

On 5/12/25 07:24, Daniel P. Berrangé wrote:
> Daniel P. Berrangé (4):
>    tests: skip encrypted secret tests if AES is not available
>    tests: skip legacy qcow2 encryption test if AES is not available
>    tests: fix skipping cipher tests when AES is not available
>    crypto: fully drop built-in cipher provider

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

