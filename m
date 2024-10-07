Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE51CED240
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 21:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxvBL-0006Pz-Qt; Mon, 07 Oct 2024 17:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBE-0006IW-1J
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:22:12 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sxvBC-0001lt-2g
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 17:22:11 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-71e038f3835so1216623b3a.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 14:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728336128; x=1728940928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QbC6iSFiT+vyi7lenYJBdeaISTUeTzDuIpwS6XLTde0=;
 b=p+kGtiOFEUoe+Mk590SCrI3/wd2fSdxAxav6hC/HhSIQvXcGJP/QF790VMy8S0rI9N
 RJzDc4XZ53i2aSzeir6x1hJuYsqPMi43rYhoEgAxFZHozZivmqFeNHgjmAECx4DHBvMQ
 uCYLd+sIdROOmgoIXjNIHb0JCpAbI0sqmDXAq52j/ivOTo4DNBLzEtM5tJ2H7qmOrEZD
 3bj5ovm2ceyZqF0RNnocPD/P1JT+0MfKfn6XbLCyx1fRD7zQtn9UwqxXol66vnBeD51h
 0CC8O5fp7Wtla0ivKe3NIstl6gsyEnUKVrmaoeqsQQyvWFKHxVAJBKj2LpnH1ZSvnOOg
 yjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728336128; x=1728940928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QbC6iSFiT+vyi7lenYJBdeaISTUeTzDuIpwS6XLTde0=;
 b=Ie8br8mUTRC9ebQs5+7Qz91OduEBgxPTIvEgXl5TLsV2BJdKt408xLoFZ5f3I34nMh
 7Kpn+iDT4m2yp69fiBNVFW6XHIxD0faWbvmLn73uDWDpKlZt+ghxSARlLnNM67h2Bht7
 Tkm0Gsl2o4ZRqSJTJr9/g1k5kA8y5z6Nf8cdTs6rhiqCggTSD4sWhq7TTNbM45mTZ2ZX
 O3eIBitPdMV+DYWc6nJegSNv2Qh8S0V4LsKykPNvIBJQC/mvuEzxryc+4ms60MhxGhZ8
 ZbWPY01EVXnspW9JXG+Tb6sVgvcrD8to8JN7iTE/5v7Kyh3wtS0ossQq7rVUjuswX/vs
 n+Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVs+ZK+XSSSAbfK4OYBTgaBfU6s58bObNBnngnJW2dnu4A07RxxyG8T/UipQqScip9ZahY/poYjD5zr@nongnu.org
X-Gm-Message-State: AOJu0YzLLd3wapduqzDMaUEtYOpWshdJ+4O+MHg4cChG8fEqcZCZ8n+9
 90rYqPQukYT+/jbfrBxdoZyhS7KwCCnm9VAy5jmpj+XG881MSm4kU257a8PC6F/3Avj6uJRKQpC
 p
X-Google-Smtp-Source: AGHT+IHcMgpcblQ88BmMDtyLEo+3l2e90THqkCBjAA7AYZv3VuMXhqSdmGZ+MOg9Fynw2K+IOkN6/g==
X-Received: by 2002:a05:6a00:2d98:b0:71e:cb:e7bc with SMTP id
 d2e1a72fcca58-71e00cbe88bmr8548269b3a.22.1728336128601; 
 Mon, 07 Oct 2024 14:22:08 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.163])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0cd0610sm4883622b3a.69.2024.10.07.14.22.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 14:22:08 -0700 (PDT)
Message-ID: <3d52273d-d97c-4aa0-99fa-fa672330b8c5@linaro.org>
Date: Mon, 7 Oct 2024 18:22:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/20] target/arm: Pass MemOp to get_phys_addr_nogpc
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
References: <20241005152551.307923-1-richard.henderson@linaro.org>
 <20241005152551.307923-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241005152551.307923-17-richard.henderson@linaro.org>
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

On 5/10/24 12:25, Richard Henderson wrote:
> Zero is the safe do-nothing value for callers to use.
> Pass the value through from get_phys_addr_gpc and
> get_phys_addr_with_space_nogpc.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


