Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C57C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 05:10:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvfQ-00088T-32; Wed, 15 Jan 2025 00:10:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvfG-00086J-Uz
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:10:04 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tXvfD-0005hL-86
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 00:10:00 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21675fd60feso138672085ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 21:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736917796; x=1737522596; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mJBoia5EBMWWgxaFZn5NdRGfUmWSzY7HEjjYfuxVHo=;
 b=GCQl+xe5uV8eGf9DPAu9aFf5NAmAHfbB6AOLCEjnLvuufA300l2joE0NCdrQ8BzoO+
 BEYEWD50w18C7JWLnJNrzq/hgRe4669wtzSbjVWuFtVx3FBreGOIc44DyN9WrTepCx3w
 8n6/y9CMMlXqca7q61kPFGATCL0aRGXRzjNZeIwsuGUEe9Z85+vlSSMPJ8/hzDsJFjCJ
 Cf6QKAxRnYB0KGAJRL5IrDRTZpffoF1kQujb3hUSQd+rwi55dZRGVh1yi6vAH5RU2LaF
 NRFZZCW/dJpfoDXaCy06jhY9einI/hUYhD80cZxIo19xnagpMF50+5h6ymmfNyOTfDoQ
 uhNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736917796; x=1737522596;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mJBoia5EBMWWgxaFZn5NdRGfUmWSzY7HEjjYfuxVHo=;
 b=JzpMdsRaZg3gEGzDVPhDzspwPYWWq7M+UGXccOZS7XOPTOhS+RTPcq+49yTodHXxwm
 y6t7083sNBobJT0jxmZkhyzELw+jeDHChmEaMh1Fjy9sJhjaNVsBIJ7bEv4S8Z8Vrglm
 65PdC+hXNfu22dHAcZ4hEv4vY16IU6xtT9G25KF+5NPK+l/XK105dCAAfP1Zi22e2Ts9
 2zdH+qaTb5QxvLSlYVXXzcuMJAFZ2myv5BxN+DLFoyj4n8v3yOwCZ7SlLiuPRWPtPttp
 +5NQtRZfnXUULuEV9L0mdbgSMc4zlx5/kx9XzDebWE52VTZNVPThXq6jMhgD6k6kwXs6
 D7Rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbCgVr8k/8aiAMWhUMbA8BMILcomWDbhug92uUfl+VtcMBeb4acqDWqafC3p+4xSYI3YuZr4t5YTjn@nongnu.org
X-Gm-Message-State: AOJu0Yzg6lHS9fbvyRdA7UBkM3mlkPyCCWiA4KDCsbUIXxrfTa3iJdNT
 j1FZkr3prDjGbW8KcqKK7DU9QnwZuTVYU4AYfO104NEHBKlvqcMUBBdT1zoakwLwi3J6NTGwkg6
 z
X-Gm-Gg: ASbGnctZUd0izcMP21KiK8f15afWShxraCV93Tm3pZ+Cb8KalKprbH6FFERyTImhopp
 cSDIzTorI1Kb2ipqN2ATY1SKtkc4KMcW/XyJFiy5Wy+Jv8/5lMsoQFE4owRtgUw234WPqwY4ABS
 kn/e4OYPRdtetlz5rYNtRJwA+qG9/wtEX8b6WzNnc9zL+a8wmrg8xx3A2gPoxLmie92V1egqEEU
 22bOyDQYmAfZ/pn6x41u/t0cUgFrMWR4/98C0yVkSjJcBUOe0XWLjGloyPSWJO8Uj9jh7TxSDj0
 9hoIzbFhVyO2oVXcum6lAGo=
X-Google-Smtp-Source: AGHT+IGVG9OK9A5xehsldUBROQdJZcyBOjO7pccJzVPV1zKiik6/mH+FBuYmasMmko63HeJf5wkYQw==
X-Received: by 2002:a05:6a20:43ab:b0:1e1:b1e4:e750 with SMTP id
 adf61e73a8af0-1e88d1c2651mr44320306637.18.1736917796434; 
 Tue, 14 Jan 2025 21:09:56 -0800 (PST)
Received: from [192.168.0.4] (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a319a21afe5sm9033014a12.49.2025.01.14.21.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 21:09:56 -0800 (PST)
Message-ID: <3ebace4e-922c-4523-a7db-7cb4be0da272@linaro.org>
Date: Tue, 14 Jan 2025 21:09:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] hw/mips/loongson3_virt: Pass CPU argument to
 get_cpu_freq_hz()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250112215835.29320-1-philmd@linaro.org>
 <20250112215835.29320-5-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250112215835.29320-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 1/12/25 13:58, Philippe Mathieu-Daudé wrote:
> Pass the first vCPU as argument, allowing to remove
> another &first_cpu global use.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/mips/loongson3_virt.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

