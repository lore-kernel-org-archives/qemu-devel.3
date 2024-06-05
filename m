Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B362CC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 19:07:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEvy1-0001lp-Na; Wed, 05 Jun 2024 15:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEvxz-0001lR-EY
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:06:35 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEvxw-00061k-3d
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 15:06:35 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52b93370ad0so257539e87.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 12:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717614390; x=1718219190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZaRY5a5qHM1qM9ZseBrPqfAr4kFxGRGBPGWu9EUjrio=;
 b=XmXVP76+V//e4TvvVlNxOILJsUoTRdSZICCA+PrkR9bW6vZPCpQyqQeZ3EzbixquHg
 GjjPGxrjYnFsXjaqRC5o5jire3ILoELhiOqm7rI4Km2L58RDYLb3lX33Kz2OWp7zxEOl
 Y4CsV+yp8G5SdIEGWsnLHLAFE/vYogtkmjMA1SPM7fErzRNd+QsbNKi50dIwiKxCvXKr
 wvTQvUVDBwj3IONVn2P9RUNramN466QTT8+L14gBAySGSBhDzp/Y2alJnEQNq6VoGA7m
 HXNAB7YipNi5VMXk78/7hBoNaLpyaOM4U89JoVvyIY9PD6a8Urlljcw09iZ6vm1K/YZR
 4CXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717614390; x=1718219190;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZaRY5a5qHM1qM9ZseBrPqfAr4kFxGRGBPGWu9EUjrio=;
 b=fadKcDg4T1Lq7Of2GK9ZEnx8koCl9C7f7QliwuxNR2zYyKJQBfvkcQXQfzcReBuBCS
 XaIfdHG7KQ3KbZnINwE+6LT0PH2Scj6LaylKcwW0gUQR+YIT5iItTomCxnENKY2uPzfs
 T/cjJuMvWNGVaYZp8ALRJDHx+xq+J1Gw18vy3iYN0hGjfVLimwBicfYugEKISHf0zMpA
 TbI7VpXrigMl33wZDsczbsQaQ+W38+VzLPcrbSnOTAj7Udhrf9guDod0nxgx87ze/ADo
 Q4uE1Gypli0qpvgA9AKisPfGnzo0X87UsMi5e3dHMvUQ/HLyUJWf5ZwscJNTkzFyhJqU
 ZhZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVApxc4PkQPsXSEnyiFr3NttYfH7M1dr9EkG+8PxkrABgpxoeNIFkjtcjW86tXGskdy3HG0AFNnI9cU9EBYZBjvjTfwb7U=
X-Gm-Message-State: AOJu0YzNgYz0jxkJehZvahK8gemLRwTG44d6gXjsjq27ITmKCBRzoOnN
 X31wCWzBClym8e3F7b3pVx8k4E/QWvTAJC8UmpZESIu1/Sr2Ml6bpIcjntS4bWk=
X-Google-Smtp-Source: AGHT+IGX6+jFI0n5NsAIChrTQiaoSmBtONgpfvGbjSSXBDJgfZ5X3JLhgZwE7h/1d8+5zN7CFPBC+g==
X-Received: by 2002:a05:6512:204:b0:52a:f0e7:65ae with SMTP id
 2adb3069b0e04-52bab4fc996mr2260482e87.46.1717614389780; 
 Wed, 05 Jun 2024 12:06:29 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.183.84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a690dccc0c6sm473048966b.77.2024.06.05.12.06.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 12:06:29 -0700 (PDT)
Message-ID: <d644678a-815e-4c49-bc65-15394bf897e4@linaro.org>
Date: Wed, 5 Jun 2024 21:06:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/28] linux-user/i386: Properly align signal frame
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, laurent@vivier.eu,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
References: <20240515150837.259747-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240515150837.259747-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

On 15/5/24 17:08, Richard Henderson wrote:
> v2: https://lore.kernel.org/qemu-devel/20240409050302.1523277-1-richard.henderson@linaro.org/
> 
> Disconnect fpstate from sigframe, just like the kernel does.
> Return the separate portions of the frame from get_sigframe.
> Alter all of the target fpu routines to access memory that
> has already been translated and sized.
> 
> Changes for v3:
>    - Address review issues (bonzini).
>    - Rebase.
> 
> Patches needing review:
>    02-target-i386-Convert-do_fldt-do_fstt-to-X86Access.patch
>    19-linux-user-i386-Fix-mregparm-3-for-signal-deliver.patch
>    23-target-i386-Honor-xfeatures-in-xrstor_sigcontext.patch

Cc'ing Pierrick & Gustavo.

