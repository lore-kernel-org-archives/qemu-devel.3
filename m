Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7AFC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 20:55:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Kdo-0008CA-LK; Tue, 22 Apr 2025 16:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kdm-0008Bj-7h
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:54:50 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u7Kdk-0007Ac-5m
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 16:54:49 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so4848009b3a.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745355286; x=1745960086; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fFx3txTMeNNjyFUxYLbZIlRNNo+Skm7uUQaVZdpr3vk=;
 b=i6Z4q2FQR5rfU1nxrnrI4enCiNl0bizZdA1TM3YlY71ahVHxnxj3GhNS1mXmOPY+6y
 Ho9YUCf3uRgc8DWQNncmcHCfi9DkZFB5jy36JGUl5rdA32RXrswkv3xlOjJ5cTUWPmoz
 sIhkfgL6RzC0x/Wxhmx0gO5O32xxVGOuiajDZ1XctoJ9XGywBhlxDa0N9HkjkdkHOso1
 lCUZ7zRO7T4gD2E1DPjwW0JbqErLrZ74BiKXwLYp+SQYvKUTNiinlbKic34EkAE2z9ft
 nd+tPhHo8guvKhr6tbFMRgmk6bYiNvVFqBbdoKQtrRT2yKR9RQo/YppHiDCkMhtVT7gK
 4K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745355286; x=1745960086;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fFx3txTMeNNjyFUxYLbZIlRNNo+Skm7uUQaVZdpr3vk=;
 b=JommklhoRQ8iW1cwK9vimDYcMrlMl/HagkdGdHnvgG3kvQagsx07VFoFO2eGCcOsCC
 GFesJKdtgmtT6RwRI/MFFCtTNrgQKjGYJtDJsNXgcEuJz9miZqOI3Ov7RRpuZpuD9osj
 97rKnMlFKYhBSyB5f1InImLXWamHe02DSRJlblJrfMrFL+atHmFDLM3yla6kvH+T59nI
 ZyWWXRbAE96WAbw/YHZUHTEccfEPq3DnshSxgrv0IOgZROnvzeaX4cUsQbhe7R3jsnUX
 LtrdsGigDkV6cyoMlBl5P39Pt4xx7AghWwXh5eupNL4GuZjU0yX0LvbJuvexOJoVLOWw
 X0bQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaAn23PT8GzeIiIR0KXlv3jmY8wimoCHsboFRlG4Y9lRd7d7pi6TdKn4O3Ctf5QCAFa1/5mIn2zjN6@nongnu.org
X-Gm-Message-State: AOJu0YxBi8hGYpENM4Bzb3kadXMOHEl/lRbhAT9ItJXF7LqBm6EMxC8W
 WJ+3vLINgvsRXEsUcn8tastMPvP+BlAf8UlrWD7U3YA3VKp37AHtIfp9n+ZcXYE=
X-Gm-Gg: ASbGncs7mpmxthuHbs3BTSA1NFwuAtKWZKrIuONNyrp5Q2I7iCJdBbeNCF3QqWfwEi5
 QMKqwmBlFL7KxdrjgGMviT2O7KWXNOND6vXad4U2b7nqs7royUdzj9agZo/9TxHzx8O0edAXo00
 y6/MYOW2mZ6jPnQjCkvYpHsfiCTF4sVZcwwzN9SugbnLqoIEDjAqx8kZUccUnDcZAxAT850RYDK
 TuvlvcZw0kfsaqtkezNexPvg4GMFwRVv538UZcaGx6q2Xi9x4gKpWvserdyQQlVISBvYoYG9/gd
 jCDsZxmx1ivP+INcJLgXdTBne0IHJkR9gZW0+l4OJlA7jl0VwgCX5Q==
X-Google-Smtp-Source: AGHT+IFLA+lgYUzsm1t7qI6oRA8k43wLkl5ZbWM/ESNksVj/g8Oo/KVFYEKEizes6esZo7FP9ywx5Q==
X-Received: by 2002:a05:6a21:1010:b0:203:9660:9e4a with SMTP id
 adf61e73a8af0-203cbd5074fmr27208266637.41.1745355286602; 
 Tue, 22 Apr 2025 13:54:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b0db1481724sm7752512a12.67.2025.04.22.13.54.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 13:54:46 -0700 (PDT)
Message-ID: <6dd9ef73-a4b4-473d-a098-73d5cacc8e02@linaro.org>
Date: Tue, 22 Apr 2025 13:54:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 066/147] include/exec: Move TLB_MMIO, TLB_DISCARD_WRITE to
 slow flags
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250422192819.302784-1-richard.henderson@linaro.org>
 <20250422192819.302784-67-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250422192819.302784-67-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 4/22/25 12:26, Richard Henderson wrote:
> Recover two bits from the inline flags.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tlb-flags.h | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
>

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


