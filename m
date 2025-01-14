Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 541FCE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkHf-0004W4-Cb; Tue, 14 Jan 2025 12:00:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkHQ-0004Ps-FM
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:00:50 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXkHO-0002Ry-81
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:00:39 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43624b2d453so60370895e9.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736874036; x=1737478836; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cDiaU6Ou4orh/p5f/yzAZTdOXna3lUmzM1168MiihZs=;
 b=SHG+F6yLk98eBZLN+skfqFv2cL8CeH0RY4ZyWKa19y8Nk68V2BPmRVGU9IVwM5RCiz
 SZch3zDdDrAjWUc+kYDt9sAcBfH7jwGHiHSXxEK4GzOkcGFSnwa+A/XWmEDW7g43zHk+
 0wNzJlnkfa9eKNJfTM2ccwelWA+oksCziVjPE10/UvdCVAruLaAZrxFYil6rto6aFJ97
 l69Cztdg2EnqlQvn33UG/kv3zT02c+gg4aZofMLzNNQd45a6GiqnLc9Y1zsTQIgrmLNa
 yRs9GQfRDtSPLKpeKv7Vfe+qZfl76Bg4yWWdhQ2xD8r/ZUtxgfua6tpPViEFM9MvZpp8
 TCdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736874036; x=1737478836;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cDiaU6Ou4orh/p5f/yzAZTdOXna3lUmzM1168MiihZs=;
 b=vty2jVetzyksLqEzdEgAkf1P4bm0pVAuBu+uIHbelf/590wdSQCicC7VdFnKrF1GbP
 gIzlThuSBU5f98h2szRjzqdknNX+H9SNBv1mdNUqg7+0aeozas5hFXiEwpHCxutPlBnu
 QSvLlG+ZhLfDZB83qmQC7p2x+gAkqKuSkYcZcnZ0uOLOcb5kvvasoIsPJSshXShD4hEG
 I/MR51vvoV4+NpzUyVMdi7JwGlshAQodZYy/qM3IoC9+3P882+a1bh2U2PiPrAON2cBJ
 ovHTCysuHBsaLXUoJLA8VGCFDcZCsrnGNQSXzS6/sRAQDf3oUyRLc3Yr6GLNxbUP7jDi
 xUqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4ZyxIMP6iTq/3NO2r9c+0LAky/tVEPS96+iGSNmcQ3ZkDHFdP1YCLLbtEvJBnTdBY8O9RD3e5LTrN@nongnu.org
X-Gm-Message-State: AOJu0YyOdDSczJOzFNZus+zw37/bh0GqIxkBoI/jE8V1jCh2usPJLezT
 VS+3nvWt5WmKQf34T9/9n8+FIq+hTeQgUMcZQbH7aurcdrKJWr7uaPYwHCRs4yQ=
X-Gm-Gg: ASbGncuR3EBQdxmKVpxbynGCI5rFzFAWbSiQCGN+xZiGfCNSM3QFTYQ0YDDyKTtu2lO
 a2GsQ0fmFRym/S8iVtnekmyIhvKyGbPRNThtCQ3zXKoYiT0DilEnm2S40g5xJUg2z7/pDl8b4eE
 0d7QD0YfvF4xVseJywr6O3gI+ilr5cK423BnpyPEG7lBEczU9vL/clGmxEq5+bmPS61pQFyy9BB
 Wa3ytHRY3DWfmLQ3OSeFfXHtEMSJnJ1DVrmZNVKooYJ09eHYI//UbgIn1hfM5z8yFvDJHLmWHES
 8ldjjPdB6mPf6AF0Mfr7nxhg
X-Google-Smtp-Source: AGHT+IHQrOw2BeT4MTKVroa4VxOKDQALDgYMPAK2bHMapUWuVQSsKQGbH0dQjiNhzsgLk6VzvIjlBg==
X-Received: by 2002:a05:6000:1f85:b0:385:f909:eb2c with SMTP id
 ffacd0b85a97d-38a87338c26mr26948021f8f.38.1736874036293; 
 Tue, 14 Jan 2025 09:00:36 -0800 (PST)
Received: from [192.168.69.151] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e9e6249csm179665485e9.38.2025.01.14.09.00.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 09:00:34 -0800 (PST)
Message-ID: <e4d00312-e708-46fe-8e2b-adfa98beda55@linaro.org>
Date: Tue, 14 Jan 2025 18:00:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/81] tcg: Drop implementation checks from tcg-opc.h
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-31-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-31-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 7/1/25 09:00, Richard Henderson wrote:
> Now that we use a functional interface to query whether the opcode
> is supported, we can drop the TCG_OPF_NOT_PRESENT bit mapping from
> TCG_TARGET_HAS_foo in tcg-opc.h
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h | 306 +++++++++++++++++++-----------------------
>   1 file changed, 141 insertions(+), 165 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


