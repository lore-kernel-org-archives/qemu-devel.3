Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC9ACCD19F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:16:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAz7B-0002V4-Vs; Mon, 20 Oct 2025 19:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAz74-0002NL-P0
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:16:26 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAz6y-000768-Ma
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:16:26 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-781997d195aso3734439b3a.3
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761002179; x=1761606979; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YxslUiWtijanz2KnKE9U85eNT9mXBmJBekP5GHunCQg=;
 b=seVB8OXnCvtsl6v+V4ruz44hl6JPYB4rZXBnAuQK33mAn/xA1mIyDWmf+qgBY65XBO
 YSdOn73qIW1ptJZLfTJqBlpYe2nE6Yk/gVZA2kh5iD23TXKvtNwWQ2wdUyZ1b0dStQJs
 KykiPxusMBe81NHF4MsHaIqwHc7PVzYfLlwagHeUo5/p+TEuvfm+hcxhk+YO8eKa7aeD
 wb5kQOA3s3YE2NU/gix1FM3cj/9wRJnEfliyUF3hxyzR/LUPMIgGDMEXELeYseTNx+yB
 Wj7T125i5HHUPKzTYT40iKqSM+tTSdPORvHmbh43OSOgnRaSZ+oKd1oap9cq3GrCDN8I
 2z4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761002179; x=1761606979;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YxslUiWtijanz2KnKE9U85eNT9mXBmJBekP5GHunCQg=;
 b=ZtQYcySHLh4Iv9QGq3Gn3ePa12eU4RrF7/gt4ZZAf+KmEZW+7MwP9Rj/0yDrY8qqdN
 qVmmoDWUrfRHvWRY/UtskaYtgQBcX139omPVznNWFbEF/esXu9VAdqHXA7/7M1ZVHkli
 tb9rhZi4oyqrRT3/EO3SNfCvCVwFb0SWmbJpWhtb0BBQjarDOeWoz5TqMdaV1nV/YhwY
 FD88c1j5yxK7WJWmWd4WHGFfnEhU6vPNigigBZQ67Y5NTtELBwaSQZcBz1DXhysSzs9R
 OkOCJ3McZfPKO8j1fK0hjSDv6zPSB77+VbV54eNd8XWza/j13XsgWnGJ4xNi2wt5YHdZ
 xTew==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3Jc5/p7B7t9SwFVaTTB2fCdXKzHAl4wcx1ckTLfx2WJfy1AQgd/Jio1hvHg194PpaXOep+2jvBMyL@nongnu.org
X-Gm-Message-State: AOJu0Yw/oTqS0KqLT3hdPGJ9MESGBNj2jWD0+1b0G2mgq2DFOYymRCMY
 X9pYo9QkPzotOc4Z6CK+hxgDHU1nxCsYzFkL9KQ+x44Gl5ypNMmyKeXuko5YliA/VjY=
X-Gm-Gg: ASbGnctzNjNOthgD2paI+7aVVz/jZyuvf13RyofZwSMf3EQis4h+e8D5YmgfeGJtpj1
 a1ETQ34Nlouhk4He5y7xxan9Nkzzw0MxL3lLZJqjdyJrbc9XFDVhHVHs8ra7lmjKQw8vozDdrol
 jaYp4tY71rAqE7fib9hQt0m8CpvhElkSz31TyGFRNohHz2SM/ufnnLOyH9DxthVWTs9+h0AOXL7
 ZrYWWGK89kt6JFTfTPePhSoPzJip+JjD82JJg67OZpYdVe4h+jHyIpcMRDSzjpbpTzKx+86LCal
 OvJX3E6f374wQr8xdl9TOS7AcLUowlvwt6IukaS2JFoKKn5SQGWNKALdze9qHcSZTVNMzWz0bAg
 G18uqPoahe4ajg81kCFX0WVowxzM2+BikOOsn1SZzrkmr82iGNDs5eZJF0aT0JwbrIMsWaLwB6D
 Vrs0PEMjA/Cu7FGexluLAwPEWD
X-Google-Smtp-Source: AGHT+IH1DMUqgli/LZKsIz5AylhITzMRmiBVo2layFG5R1BiUmRSvlLj8o5B5UELbD8wM4ATZfxDqw==
X-Received: by 2002:a05:6a00:390b:b0:782:2f62:7059 with SMTP id
 d2e1a72fcca58-7a220ad2f7dmr16782197b3a.22.1761002179001; 
 Mon, 20 Oct 2025 16:16:19 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7a2300f253csm9399745b3a.47.2025.10.20.16.16.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:16:18 -0700 (PDT)
Message-ID: <57bcf8f1-e5a0-4402-bc8d-9a7b13f6cc4c@linaro.org>
Date: Mon, 20 Oct 2025 16:16:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 20/30] qemu/target_info: Add target_base_arm() helper
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020221508.67413-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020221508.67413-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 2025-10-20 15:14, Philippe Mathieu-Daudé wrote:
> Add a helper to check whether the target base architecture
> is ARM (either 32-bit or 64-bit).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/target-info.h |  7 +++++++
>   target-info.c              | 11 +++++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
> index e8fbdf19d53..62359622232 100644
> --- a/include/qemu/target-info.h
> +++ b/include/qemu/target-info.h
> @@ -50,6 +50,13 @@ const char *target_cpu_type(void);
>    */
>   bool target_big_endian(void);
>   
> +/**
> + * target_base_arm:
> + *
> + * Returns whether the target architecture is ARM or Aarch64.
> + */
> +bool target_base_arm(void);
> +
>   /**
>    * target_arm:
>    *
> diff --git a/target-info.c b/target-info.c
> index 332198e40a2..f661b1af289 100644
> --- a/target-info.c
> +++ b/target-info.c
> @@ -63,6 +63,17 @@ bool target_big_endian(void)
>       return target_endian_mode() == ENDIAN_MODE_BIG;
>   }
>   
> +bool target_base_arm(void)
> +{
> +    switch (target_arch()) {
> +    case SYS_EMU_TARGET_ARM:
> +    case SYS_EMU_TARGET_AARCH64:
> +        return true;
> +    default:
> +        return false;
> +    }
> +}
> +
>   bool target_arm(void)
>   {
>       return target_arch() == SYS_EMU_TARGET_ARM;

That's good, and we can extend that to all other base arch accordingly. 
It's a small amount of boilerplate for something that is safe by design 
and can't be misused.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


