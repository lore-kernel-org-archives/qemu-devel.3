Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13C5E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuSg-0005CM-FS; Wed, 18 Dec 2024 08:51:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuSf-0005C4-IB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:37 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuSd-0000EE-13
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:51:37 -0500
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-725ce7b82cbso7520695b3a.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529892; x=1735134692; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k9MecQmtKPB835U/FmTK+WTjeJva7NJMUFg5dUF5d90=;
 b=tgxRvOSgHl0b+qMmo+UNQz6xrMMtD10xlotz1ACtmXmiJ2HSpk3cuoRuf/pwKWAvOr
 ruvMoUIXxkpuOLEn9nsjV8YUzyEGKzia2AtxH+25E1u2Pl9pV64ofA+YGH1TpdeuYEqR
 OQ4J1BJ8ca88R1xy8jCQFw3rh2rpLAGb8iWKHp9mYAwiv0JpKdmg/gwaN4XrYmoVaIzB
 VqeukW8aMiE233He/BRZ4ZIzrqIPanvUEiD+hiDFssFRT/5fhlHqH09/bfxJcCXW7e7W
 tCPjPCzAB6/BZtTB9TuXwo3r6ctK/ZTMEDti2yMI926FcELpk8uV62dlWK0qISx+HWhT
 ajvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529892; x=1735134692;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k9MecQmtKPB835U/FmTK+WTjeJva7NJMUFg5dUF5d90=;
 b=JnUh1yEfA8jhH69SlESlDOuHYj6M3eMrALUhSVD5zYck0rxzcWfzIx1unGUEbqaPDz
 vDvGTAQExFvP52Evh8dzmyX431JEn/p7u+C20KlFQcePZ6MyvFk4kGsDT7L+MXsfsUKN
 bFnsRm7GZBbRbX3D2QAcduWmvlA/LMDPPJLcH6zknNnmWpAXFP2v9OjKt0yW3LCF3/LW
 tKyDoAMG2Zd0u7DPQ0dTNm8qTujHzS38/7yhNDmdJC3ZtMlb4KPxIGE+66JMwIOS+hbG
 6cBgXbxeFufVraoX+DXMfipxAL1Zdc+UfQWkjO8bxRFH6X2psOXd/E03rdtJd1nFNXJY
 rAGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWESwTg7TDhcgGjIgYPQKSsuh4n417VyJSNFjDy9WtbvbaHD21BOZuLH0yccp8JGKWHdO3U9I8+tFYi@nongnu.org
X-Gm-Message-State: AOJu0Yx+0hO4N7tdvg8c2sOrErajIbbx2GG31omHdMyzrgv1azA/g4xj
 8+JJX5156JSYgq0/ry376dAAIBP4PtUNPkqCAs9bov+36bC5MVvBom0E+4VOphk=
X-Gm-Gg: ASbGnctTFgsPCPdeTVneXThhIr+HNtLqI/8jb7/GZB1M6BflgDN+fYAeT1QmkTzDQl+
 f5NMbtgCjaQxZcWdPNEjNrbu5hhvJXlrENI2f7CqYY6w3qS3mRAbS1WfAyADzIweSjx86cgLKTj
 Jj16NonmEewgmDqu+ZmRGnNJ/NJkA5xhwTTY9AaNi2MbD9EihIGBlltQ58t/+KLfGp5UO1BlSTF
 WIs9OVVAzCfUlm+Dk2VusEKBwHT4fk/lU15q+2+lab6jF8njGyCGhCLM8H4uGpGVpq45NwL
X-Google-Smtp-Source: AGHT+IFsM1tiIu8mGWOXqiLtJddUx3Zjd38Bmsy8eW1SrTtIj1aoP3Xd89CUlkO5Z0oTJjJY9zEhuw==
X-Received: by 2002:a05:6a00:3cc2:b0:725:eacf:cfdb with SMTP id
 d2e1a72fcca58-72a8d2e03aamr4604790b3a.24.1734529892022; 
 Wed, 18 Dec 2024 05:51:32 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918ad7845sm8789563b3a.68.2024.12.18.05.51.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:51:31 -0800 (PST)
Message-ID: <5700922a-050b-485d-93eb-228256ff88f3@linaro.org>
Date: Wed, 18 Dec 2024 14:51:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/24] target/riscv: Do not abuse
 DEFINE_PROP_END_OF_LIST
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x430.google.com
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

On 18/12/24 14:42, Richard Henderson wrote:
> These are not arrays of Property and had no business
> using DEFINE_PROP_END_OF_LIST.  Use plain { } instead.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


