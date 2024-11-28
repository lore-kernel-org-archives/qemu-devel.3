Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 575DCD6910B
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGeZ7-0001IP-PU; Thu, 28 Nov 2024 08:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeZ6-0001I0-08
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:28:16 -0500
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGeZ4-0003ZZ-Eb
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 08:28:15 -0500
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-2958ddf99a7so741643fac.2
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 05:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732800493; x=1733405293; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GRfuUem/bc9wY//Ia1wliDkJKWzCtTfbKUBOEj9Szxo=;
 b=xOD+xU8rwpQ7/A3jm/EBj6VyTSYNdlhFzrQob3Cdn8EqZuGCxD0k3A2gtFJ6Ror1AO
 hfktkzGaJ/Sy+2cqdiT2NjLPkxQuhZ0Om6249to/4TI40hVP+XFfgxTtKkgJUvKd6sY/
 4xvvqYPJ72krKvD/bo5BcUDElvRPHM2JgxNrMuSPJk9gWR4PKPc133Uzdb+t9f+yD4l1
 kEuQra+RltCh9ewryoWFrE6yOWP3ZsZ+TP1oAvqI+viBnxxtuoPb5Vxa4V0oc2GZhuMG
 wMeu+PEc2WBoDnX4aI/UGv3K7BPx+ZgkVdCVn/Xt8rcmW1qLPxL6L7EwLijbzY7UZqDG
 qjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732800493; x=1733405293;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GRfuUem/bc9wY//Ia1wliDkJKWzCtTfbKUBOEj9Szxo=;
 b=FK4FW2qyxneLqlrvTzLZf8cjF65Vc+7zTQU/z3CEQw6Du22jUunGupxpMdPbJ4IriT
 6HqXZQ9crb9CyzU3o38blPba0o/yU7vr60ykWUJQX651hKoFeUeM0VT9Fq734jaluDOY
 MLpgDAjT7Tw4TaW+Hwbtgmzal1ya9SPDS1iFCINI0Ci2ovZcijyyYV7pnZlmYQDnyJMR
 ccCAxqPWNVi7teP5cUaWQ0QWcsDoqXh9j+O7hr6pyVJZG4waAJkYBJaDWUuwgDG8WwQx
 Cz2M0xFMkkZ0A0Oad1qPhVouASUtyNNXoGLI1M5prC+Ui96JemBR51gOKE+wP6bSFZjw
 B3ZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2dRj4b6srxB8LVwWkNT+9BO6sa96njwIv2ir7tiWh1F4mUN3Oq3F72zz3YDW+KXevLNYanpaNdsPD@nongnu.org
X-Gm-Message-State: AOJu0YxoAI9NFoL/FdS5muUqNaqvLzgUNzYt++9OTRzHL9cRkyW1LUBm
 E6TspSWvxYGRDpPrgScqxhnAN0ltq7d9X1fXJD0U32ERxBe1IwMI+XVpRRZTLr0=
X-Gm-Gg: ASbGncsc1l3VhgoEB+qlLFOujwyqt8gjATxYa3A5ccmxgkWjyH+RcbXWaXwJu7wn+pZ
 A8gVL3aQj5XLtNfCuQNo+8wLYyILuhKQz4Uk5kiJSOEdRk0m2umREMUSdOPhK3FjVX4eRfuT1sZ
 +Bg4K11OperOLMif3k6Ff20khRC9OnImOXArEvHGFziPvy+ohp4l06iOap26cI7JJWqNnMFhEJn
 mSDee8Jnkl/tPXSsAqdLwi1Re3Qxkm8AUjICqi+Q6Od/lEZonsTy5uFxjQDVStwHbZrchS/5iR6
 K/QSH2eeVUNufrQcerkFIV/zrw/a
X-Google-Smtp-Source: AGHT+IECCQUaS2c8AA7LnC3Lkke5P9U/YRJA5pMSDk4X4gOYGv7R/tWCxTGv9gOJYkOS4/bOIWPyYw==
X-Received: by 2002:a05:6870:ab07:b0:297:2bdc:f533 with SMTP id
 586e51a60fabf-29dc43056fdmr7288089fac.31.1732800493070; 
 Thu, 28 Nov 2024 05:28:13 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-29de902d0a3sm397253fac.20.2024.11.28.05.28.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 05:28:12 -0800 (PST)
Message-ID: <b58ff496-ffbf-49cc-9668-c01f8a568867@linaro.org>
Date: Thu, 28 Nov 2024 07:28:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 06/25] target/s390: Set FloatInfZeroNaNRule
 explicitly
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241128104310.3452934-1-peter.maydell@linaro.org>
 <20241128104310.3452934-7-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128104310.3452934-7-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x32.google.com
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

On 11/28/24 04:42, Peter Maydell wrote:
> Set the FloatInfZeroNaNRule explicitly for s390, so we
> can remove the ifdef from pickNaNMulAdd().
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/s390x/cpu.c             | 2 ++
>   fpu/softfloat-specialize.c.inc | 2 --
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

