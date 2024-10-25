Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44718D0C602
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 11:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Iul-0000J6-Vm; Fri, 25 Oct 2024 07:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Iuk-0000Ih-Iw
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:55:34 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t4Iuj-00045S-07
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 07:55:34 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso19780005e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729857331; x=1730462131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6dDwzFdfFtGh2Y46LgafwADGO+ut0nhEisFfSK3GnEk=;
 b=b+NIgHT9WDm+dGtUMuZYVT8MXDiMF5L9xLz4CUpZ+xAaDunFQimzDfAwwixJ2g9p+z
 hx/DMaB1AQmmOSk46XjrRlfo+cD4W7iLWq+NJSx24g5guZtw8lagWMBB5UNvhieRiXtH
 3CPdiVgT+hNu229YLh1SYtq8cgtFoNw40MItTQokOlHEhgKcc2G4heen+doRZOMGUAAL
 k8QT+0dtjpJfuPSHSYGsf4jugwPl4n0sKSSNIEzABzeieLul4j3B1Tigw9+CnC47G1F1
 dpgh1lE50uXKeQsN5cO1i09P27HxETyMkE4RE7PF0L5hwKm6DRiSMLbEu718AK7b+OsE
 7ssQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729857331; x=1730462131;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6dDwzFdfFtGh2Y46LgafwADGO+ut0nhEisFfSK3GnEk=;
 b=IvSuiK6Egzg7bPC5HW0V9FS/iU2wxsW9f3uCiRZYvpbg+O8Cx3pHcfPao1UjUS9LHt
 G08eB0qdqLn4DrbwVSRrN2NsnaxYGEGVPOyhB3sIPcvvEM47tV2JckrgYkRONaor/m4B
 /iEKc8v/Bv4KiDGHGjNINmOwcQl/vcpR7V+6Pu77mH9Zfs25kGAQdIrO8yAGD2UBWcYG
 nU9rdrHomi6dWIfiYz2Rj+B7Cw6iU63nzmyNyvDGQHiVcejRqYACRLdjtm3+8xjyLyog
 GfNUNuv6k/YUfBACvNyAfQzTHbtuJ2O9EsAHRE3AFvZe8dGWIzt2OJhnXqyIutjCDoJ4
 Eccw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbmi/2HZtvlj5FOcAmx93cpRtJBa3hlALfskePthgqJUXUjkYRIukVuhrGKxMVa8LS2Cp1Hs0YlnGJ@nongnu.org
X-Gm-Message-State: AOJu0Yz5wsYGY50XACSKdVzPcTW8JY8UArVYGFji9E6aiEJPX/pgt69C
 ChmZf97VdsQujOPrLV2Lx8J3knDG5Kz2gKNE5f72b35aEVQpzZofq9gVLWu6hp4cBYwE2YI+xgB
 OrEI=
X-Google-Smtp-Source: AGHT+IGGw5CDxkw48w465lpqmSYHh+QXAY09YsEwcmcxT1Rd4ZXlUea6a3N9f+P1d2DMVWACGYOD1w==
X-Received: by 2002:a05:600c:511c:b0:431:5f3b:6ae4 with SMTP id
 5b1f17b1804b1-4318421fb96mr92944795e9.17.1729857331400; 
 Fri, 25 Oct 2024 04:55:31 -0700 (PDT)
Received: from [192.168.200.153] ([185.201.60.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b55f719sm45434155e9.15.2024.10.25.04.55.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 04:55:31 -0700 (PDT)
Message-ID: <5dfc6df8-dd40-4ec2-b3ca-6c428130e449@linaro.org>
Date: Fri, 25 Oct 2024 12:55:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cpu: ensure we don't call start_exclusive from
 cpu_exec
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241023222026.1430014-1-pierrick.bouvier@linaro.org>
 <20241023222026.1430014-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241023222026.1430014-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 10/23/24 23:20, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   cpu-common.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/cpu-common.c b/cpu-common.c
> index 6b262233a3b..c979138fce9 100644
> --- a/cpu-common.c
> +++ b/cpu-common.c
> @@ -194,6 +194,9 @@ void start_exclusive(void)
>       CPUState *other_cpu;
>       int running_cpus;
>   
> +    /* Ensure we are not running, or start_exclusive will be blocked. */
> +    g_assert(!current_cpu || !current_cpu->running);
> +
>       if (current_cpu->exclusive_context_count) {
>           current_cpu->exclusive_context_count++;
>           return;

Actually, current_cpu had better be non-null from the very next line.


r~

