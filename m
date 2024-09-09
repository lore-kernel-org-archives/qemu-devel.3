Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6DBECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:25:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmop-0008B2-2v; Mon, 09 Sep 2024 18:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmom-00080x-AS
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:25:08 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmog-0000nX-C0
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:25:05 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so414954266b.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920692; x=1726525492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s3nccRPp9XSZgrwaQxSVXpKvn0JnR3Q7NoUBJkM8qqA=;
 b=LSrDtPJ37dxTpyaaYdoHh3/jV/dzwJE2zi68KH23kCeevMl9o2VcV//+NQrUafiv7e
 kmLYJ6DIIBVoeT3/wGWUG0gNR7m0SyWvKEwT9PhqJxj/ryDYEcW8A8ynk+CH3EPZeoAP
 svY4Q5x/Wm02qzcspFtLrXtSahACMZJvKMBPAyOSuaJBoeB/O4whISLA1RelFmD0z73t
 SAn7VmXCv2LnrBBHNN6ESt5ZwmgQHpXsmmulRpEJUjxHT1beOU/3mQLODVRd3NLfKqyY
 YXhkMzhIcgaiRSwNb2KGu3Dz60MQmLNDEsmlJnvT23P3x6ujDQ9yg/svjsXCj3PNOWj0
 B5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920692; x=1726525492;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s3nccRPp9XSZgrwaQxSVXpKvn0JnR3Q7NoUBJkM8qqA=;
 b=SbDBWgTNkqj4qNjOSYouDNXTnm85yGZAWiMgObbjWzdDTqEzbBc0WKGHLY+Wec7Hfe
 9gTDNfqGRd34/k6OJqv9fCB8g2G+z0PG0wMg8qi96vjehBwX6TN3r8rTKD7FGxCD4YQF
 azTPyU3CDH4Y2M/o6fkNDuzMitCNpXTz4j9CyKFhm5spNYzBOgXy3bYhPbjI7N5GGOdG
 f5YUT8nTeW58wfWEhRN7yvNKNlMtO1HZNqXWLC4hsMuz8Tb8Kt7DVZxXP7bHKNZQcrIu
 Dg/qucuZYNNb9fW4hOcloFMSpcDq1odjo30GNnmeaqg3ljBj8Bmzkua4mrxB+nLZZTjG
 62pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5PjQqWdIN59WZKpUALDD8wGM+ku0zJecdHNNeWj4VTGmLn+KUEcByvSgyoTNW9z0PUqWWi2lyX3y3@nongnu.org
X-Gm-Message-State: AOJu0YxZcawCGciOLsfx9VGoskF3G2xNB+m17BrfYfYbXPR+/G6RglTR
 OxwdyVk/E5OW/3oQgJOh8WElEyCupVQuq48E9qudhIf6ckBx7z3z8Mvs8g2VIJJXb62TgGy56oB
 R
X-Google-Smtp-Source: AGHT+IHBkVxlNQJZOtDG/VJR2qnuh/pQ2Ej0ttXDpvyC3nTzk6SARgtZ2VX0g195JAFSFOmpWNzpvA==
X-Received: by 2002:a17:907:6ea6:b0:a8d:498f:640 with SMTP id
 a640c23a62f3a-a8d731a7c8cmr86405466b.21.1725920691977; 
 Mon, 09 Sep 2024 15:24:51 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c6126esm392591766b.120.2024.09.09.15.24.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:24:51 -0700 (PDT)
Message-ID: <678932dd-02e3-488d-8cb1-6f3d37c112ab@linaro.org>
Date: Tue, 10 Sep 2024 00:24:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/29] target/arm: Convert FMOVI (scalar, immediate) to
 decodetree
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20240909162240.647173-1-richard.henderson@linaro.org>
 <20240909162240.647173-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909162240.647173-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/9/24 18:22, Richard Henderson wrote:
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I wonder, maybe you mispasted my previous R-b tags
with Peter's?
https://lore.kernel.org/qemu-devel/37096dc8-7827-4a4c-a27b-4f8343aa9c6c@linaro.org/

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate-a64.c | 74 ++++++++++++----------------------
>   target/arm/tcg/a64.decode      |  4 ++
>   2 files changed, 30 insertions(+), 48 deletions(-)


