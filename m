Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DC1E77199
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 17:40:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVa2G-00047l-Oc; Wed, 08 Jan 2025 12:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa2E-00047S-FD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:40:02 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVa2B-0001rB-Ms
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 12:40:00 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385eed29d17so30176f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 09:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736357998; x=1736962798; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4CGyRUd50nOFl9YtArXLvrcmi7SI4I8r5m4iO3cfA44=;
 b=xvKfk+nLnizySDmOWy+26477k82FnQBV4thwUvOKbZ6MkeTAGPMWwIucqteCzvlJYq
 S3WkI2yuMKAri+lVnKRdZhkggsnokRAmMvtUPDsGRz1ZdstAhb72418Gt0c+5eX4perS
 +kae1EtkIYGyJlFbuuimUspgReoU+vn+JPoEDjBBpkUz82ROA2NlLnIcBe2dPaITB7h9
 Gyx2fLzEwD72JBMPImuHEbB5XwErDTn+EoyiTRFbJzd9l7+7SNSnIpEzLODQ99FD8l4O
 5nZqs+L19laOW66cc4zhZU6NIoo1+VbeLaEQtubWYBLl55gMobSgtkONdK3mvWGebB6I
 SsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736357998; x=1736962798;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CGyRUd50nOFl9YtArXLvrcmi7SI4I8r5m4iO3cfA44=;
 b=w3wNP0DweEyuM3eUHwfUXSYyCJDkfWTcEMjT37nRT0eA1t6tozYNL1kdK+y+1mJmSO
 U8QKOOOn+snai61oyyAG1ueSXI0tGgYCO5Qcb2OYAnDuVKFGuReE9N5X/cMFuiieqfE9
 ATYn4kbCMWT35fBVAQm7XdMRJjOeC+oUMRctChZmL3BWTr4Vwl9JeuL8IEi6UYePp2AU
 ktGL3KeSL1aDLAR5jODK4JdcsnVHS2ysAlbqScVeSoUlptHqW9Rn3cAK7R9FwTwg7qWS
 PO5CzxUMKiTn+EvNqiLhk0qqE5OUEPvCecaDW7hXmQcoOwPZmv/zSZNcXQW/W3GBbrMJ
 DG2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgcmPOfOAatWX/KkTru/nsdnQHdzxbGJeWNnT3u1Rp4gKoKkg7QjTqjEAr1dp2K0QP91wsyepeXw/F@nongnu.org
X-Gm-Message-State: AOJu0YyokLedenfrYGvONDwDwcNUcPEPw/RKLCUFKUOyACq3N8+fG1sZ
 TaE1xjSWsROjFqRDdRKiWgt0SVf1dAOS46OFKKOpkFphiXtHri0h/EyDpcNUdFJnCoEvTIhs349
 bI8I=
X-Gm-Gg: ASbGnctbraFTqq1Qdu7JfMEZhd4xboq/mkPEKiLseaj+7HbIo3MZ+D4zclvZfDd5hLC
 88Jl/GgWo64SXAdX6nnvX2UZEWO/B1TPI2vta9my9FDaTrVdhYmWJioxJjMawtUSwUr1BSUHg+U
 4tf1+MPhogN3/IagE7VUuoDYo1nh74hBgcueGH7V8G8wQIUxxSJiFODYGqBpoaWc82as/HjmANC
 zSvn2QikIiCGNEFPYV2uc/bFPaKRGNtTv8+Ziu89ngElJ2PwjOLPi0qW9Ro7n0Uo/e9DPFPY9DX
 fnEgj3FpioWtcSf1KL4I9XCr
X-Google-Smtp-Source: AGHT+IFleJjnLRXKMyMqv8hBxMB5gAPo8bOS20rbw3idgn0wUp1I1jMUUSf0S6QJ0vOFTfQVAu98Cw==
X-Received: by 2002:a05:6000:470d:b0:38a:5ce8:7a21 with SMTP id
 ffacd0b85a97d-38a8708280fmr3456938f8f.0.1736357997635; 
 Wed, 08 Jan 2025 09:39:57 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e261sm54229427f8f.76.2025.01.08.09.39.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jan 2025 09:39:56 -0800 (PST)
Message-ID: <9d709773-a72a-4e36-8e5b-7fc04589d529@linaro.org>
Date: Wed, 8 Jan 2025 18:39:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/81] tcg: Copy TCGOP_TYPE in
 tcg_op_insert_{after,before}
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
 <20250107080112.1175095-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107080112.1175095-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 7/1/25 08:59, Richard Henderson wrote:
> Simplify use within the optimizers by defaulting the
> new opcode to the same type as the old opcode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c | 4 ++++
>   1 file changed, 4 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


