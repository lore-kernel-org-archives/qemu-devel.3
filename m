Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FDC0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 14:33:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiaHa-00027p-Kb; Thu, 13 Feb 2025 09:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaHX-00020A-VK
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:33:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tiaHW-0007tz-Bk
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 09:33:35 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4395f81db4dso5910965e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 06:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739457212; x=1740062012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ufXxPctyzx3sXk4Vlp69CV6m60zYQZlp17H8lhPZbYs=;
 b=f0rFUAV+LzzbS+rYRJCmCYdI2Ke99cwjnQ1/z1U9QNbLnfSHccUoW4AtIW9XeJtVws
 j9Uok3zt754akymqvFnZTySErRS2Ko9y4GzJRIna29wODfnEbv6+OL5XVSU2TN0qEqBr
 LiMlS63LJHT1zCR7/kfA+gIlyidYR6Oe75lJ1jg8iTjiVXMe9OIRLyU8SoAuV1mX2pQy
 QXPx/9kQwH+4U9+5+cBcMkW9ayniXb1N91Ec2hnEraVUbc9GD6uNlXqxQ/gQ69Rm+O6G
 JRkYnaopW2ZU8QCiHCuCEM23yVastjhfa9BMo1ADjUDlC3rQsyjADY8GLRL8R7zwMUVY
 UNtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457212; x=1740062012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ufXxPctyzx3sXk4Vlp69CV6m60zYQZlp17H8lhPZbYs=;
 b=eJXI1Ai/O4YI4VWpEcOAHpvGCBhbaB7BEQLTIpaQRjelQLeqhN8BT/Ujdl8LIYbSDL
 Aj7t5QbgWoB3VVHwt6vqwpwAW0zQTd0hkx9329lj1DU7e/SqgZKEBRaBfXujHGPQhgqh
 hO3Zq1cqKmZpE1nLUS7zGbPP2kXbwYF57JsM1CnvCzy9rMOURYQMR/3L1+7YMakLZAWT
 C4kcgTSTpQ3d3hL2MR20Fkmy2dpMKDlyCcDJA3Yrz3k2Gnkv+1vIRN8FMk7+H+1e4oiX
 THSrhc3dwzZM4415JeBqIxASeJMFTQIHeLiIvDe0+BMIlEGnRw6dtliapShTfxkWlPH2
 OJ3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQpFHyac8uxi1HpX5SQ/v0tZ0/8Jtpo/V+EzL1knEEeZHuqFi25do2mcT2AvxkTOE3sAe/aRM5lRua@nongnu.org
X-Gm-Message-State: AOJu0YwidescbaUvY03JFpT8y+ZxSBTQmGtgEtQZrooSGxjIfJgUcu5t
 uII2oBoa5kAT8AyBI9zMtaiqF8xrl0nLQ7NrSJL78yHjr0BIJTBeN/N/9WZXw1Lb9SGwG8R6dHN
 qRw8=
X-Gm-Gg: ASbGncuSx13o8D23yhxqYj3X3tRs0EwEBj1aI3tSFOpTV7rBnBNHyQBnDPITmM0e42G
 cjm25EelwBJ++d97dpvMV5rquhyv/OLMfl9JcTxr8XjxehdESJaXUm/KMlTsFAybG4IsYMoQpL5
 JihmIaDdy4TuGbTKeCa3YWvXVX6q0I/GXf+QGriBeaZ9deaJeV1sN5ONFPO70HA4Qg5adZ5cdCd
 FLn7+m1IWSCUrSp/SabUyaASVMvfioQ3ALc4jIW5YJ6hZQ7NcOnTJ2JmjnSzQoRBdqE1mCpDhHx
 NXsgixEsSfMcnO3gJoWUPf+AaIIsX5VlhmWMQXpxwoUwtrCzYCawwk6GMzk7Qdltnb1gGqtKUg=
 =
X-Google-Smtp-Source: AGHT+IFFnVqMspAer9ze7a3lBa1vEjY7p5o/5l9lUd1zdWsw4/wBLrXgFO1dqCuztnOHrLauPUmFpg==
X-Received: by 2002:a05:600c:3b9e:b0:436:1b86:f05 with SMTP id
 5b1f17b1804b1-43960eab785mr35656945e9.11.1739457212196; 
 Thu, 13 Feb 2025 06:33:32 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961884e88sm19214345e9.26.2025.02.13.06.33.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:33:30 -0800 (PST)
Message-ID: <0b123b79-98d4-4f15-830c-81e9bf3122ad@linaro.org>
Date: Thu, 13 Feb 2025 15:33:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/11] tcg/mips: Drop addrhi from prepare_host_addr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250205040341.2056361-1-richard.henderson@linaro.org>
 <20250205040341.2056361-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250205040341.2056361-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 5/2/25 05:03, Richard Henderson wrote:
> The guest address will now always fit in one register.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/mips/tcg-target.c.inc | 62 ++++++++++++++-------------------------
>   1 file changed, 22 insertions(+), 40 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


