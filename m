Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD611C25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 10:25:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6SrY-00070v-9D; Mon, 13 May 2024 06:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6SrW-00070K-Rs
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:24:54 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6SrR-0000UX-VN
 for qemu-devel@nongnu.org; Mon, 13 May 2024 06:24:54 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-34d8d11a523so2634516f8f.2
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 03:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715595888; x=1716200688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wZf3x69BVX1ZPIkd4JOb+cwd+KZG3NreBlixMWB9UZE=;
 b=dwIkgwzbnC0mUPf5IKMApaSR1ybIRtuvGL4UdM5Jzvoq5EytSsGtLP7yKMLhDF5Cqy
 l0CVAetxD/a0Fl1/RJRS8c+VGPylkO5vQhuAz7GdU3Mp0ytTJLdtD8pwvuPmTzg0e/Ap
 Dr3zeu9GpIwRg+QCc5E/y/eRwrR9IIFV4nHckR+fXYz6jiQVcktwXoKyuFOjw2LcetSr
 JLM7x/FiAXO52RBqBkInFM6fOnilLRflSvUUnY4ZapNewDA+l0J7/EbPdn88bQbgLj1S
 mF/9+gsSEIru3Zx8OJGw/8sJUIP2kWo/FgJ/1Zmc9zJH1jqPlglbq7tDSue21UDS3EKX
 mMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715595888; x=1716200688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wZf3x69BVX1ZPIkd4JOb+cwd+KZG3NreBlixMWB9UZE=;
 b=Z/0FyKGFM16gFtSTaXrSVvRdiq2GxjlpGAs3Z3YEMas5rBCJffbj+MeAQhNoFYIZHI
 JhGHiZqz2F0yb+FQNuDwhiexRUerKFOKRrRm3jhzYVZIj01t0SO8Ti74I90BcXuDvAwV
 eKlo3IoQSVLClBV6wd6PfUEaFKodlD8lywexFLfT2LyEzxa158dUNDbFUaBYvx9BJbjs
 EqtU8AiLiB6R8B6H+HpkLwv7HnBxp2pNZnNkFZ1cwBxHTKXdQd9x6kyzFJLetvCMC7lT
 T5VfW44TKV0B+PHTsJnPdcZwYGoXbAx8WMU6Ec6SI2CAAdvYOGvr5tey4+kI1l2+vX6f
 qoyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEpm66sudLlNOXYTIGoLktxVBoMCIupI0zWb6bDQi2pmTFVcNRiifSeKjbMO2L8tcTN7+ham0rodXd2jje/L0fH4tcrYE=
X-Gm-Message-State: AOJu0Yw/1DtjFGWRWhc/LQuv15+876giA0r3Z1UqUoqzCQmqnbTrqfkR
 MLmwtj8+3Epv83NpJUV/AMAhi6xuna3j3xEAzjmiouuepPGu4982huuBLV3BwyQ=
X-Google-Smtp-Source: AGHT+IGFT8EyUBYBoOwbhw3/LRTdreHipVEamBI8g6Y/fsfL5cE9hlSJNhBJhswFkluX/uAh+ssSgg==
X-Received: by 2002:adf:faca:0:b0:34d:ef22:70d9 with SMTP id
 ffacd0b85a97d-3504a7363b2mr6367603f8f.15.1715595887837; 
 Mon, 13 May 2024 03:24:47 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baad0absm10729424f8f.69.2024.05.13.03.24.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 03:24:47 -0700 (PDT)
Message-ID: <5abd75ef-596a-4236-a431-04f98c2bc5e7@linaro.org>
Date: Mon, 13 May 2024 12:24:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/45] target/hppa: Remove cond_free
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20240513074717.130949-1-richard.henderson@linaro.org>
 <20240513074717.130949-28-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513074717.130949-28-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 13/5/24 09:46, Richard Henderson wrote:
> Now that we do not need to free tcg temporaries, the only
> thing cond_free does is reset the condition to never.
> Instead, simply write a new condition over the old, which
> may be simply cond_make_f() for the never condition.
> 
> The do_*_cond functions do the right thing with c or cf == 0,
> so there's no need for a special case anymore.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 102 +++++++++++-----------------------------
>   1 file changed, 27 insertions(+), 75 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


