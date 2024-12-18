Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DCCE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuQD-0001S0-V2; Wed, 18 Dec 2024 08:49:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQ9-0001Qu-Oz
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:02 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNuQ3-0007ij-B0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:49:01 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-728e81257bfso5406524b3a.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529730; x=1735134530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0DV2ROIWeK5DkX8DVjfQeE+VR2NFwFHK8ubNJDXosN0=;
 b=T/jAuZ5KL719cbKgJugYnJg5TMS7tfglPywVzHYwjJwVrMQIHUgxJIyVLTUOEmWxtJ
 vYLBeLqC6Nnwsn/Z3YfdTyH/iEfEmpaC7jxr4Uemp1I59IuenZ8ofrITMADF3sK6RkMk
 dBv2GHddEit4sSFsdq5VL0fOjH2jQP32QZPH3I5SMpTcLq/SWKEZLwq6A6AkUnQyZ1Dr
 LgNE9Rt+vU/+KfaMvk1QXjZcwnJH83w+II2ZhM72oX3ZCHIWqcIfJvXJtL9pZRilV0Hz
 lkhoytWc+PwKLANyamUWUhrID6hNztQkNFZq45ud3K95thrmb1N/GJy6WxafzVCkbZyl
 Zztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529730; x=1735134530;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0DV2ROIWeK5DkX8DVjfQeE+VR2NFwFHK8ubNJDXosN0=;
 b=dllPhqBpUG+z0Yf3bzINScfToncdrKceqGT5b5ZBeYEA4Sn2h5zNW0+KK/s0isoVMh
 7+L+vXW0hP/ShSrlGCLIcuY7Iiwo0eoR/MIUqsGirW4wwRocesfgVHEhJBr6PqLC/Stm
 oh/SbTjrsgCYeP/2locqNFsQQIG8SX1XM7rXNrsUGbnZfGr2ye2p9PSO6BXaLiHRSJgh
 IaRt54y32FM/WmrgWEItj6Tp0oL4sDLfCOGH7mnKZeyM0DkdtwpY6kvoqJ2Cu88CM2kx
 l5ICu1dDYfTHdpZH4VYYDbmLXDtSvLvYuzavUYz0sBy2puXltPROJLTx6218O9hX/Dq6
 1d1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSf+weyTIyx35mXce/S5lQJJGOJCcSkn/i55yXA+xt8lOTXaMsG86Ie/UCg8TzV9tmsFHENpMqJ4QF@nongnu.org
X-Gm-Message-State: AOJu0Yyutz81pB75YmIF8U4eLi7dDl6PzfQyKNgmzUijKeInxJnhG9PI
 aNMmCrDyy0aTzRN5LjYwd0BPB2S/Ee6Rz7Xko/BakFMqTfrGYVqa1pQHPeKvFTE=
X-Gm-Gg: ASbGncttEhPUQJ6QfQ0VrSBnsWy6pljsgNTkR7qMbgKzJhcE9X5+VVFrzaytzBDVnvo
 +jinjWqUKsjBIyC8lK6LuP9SlzlGjq7GiizGQZecvCo1gbqJQbqPv+a1K+7IAPgUFL3eh0KOFA8
 +qGyIR3Ms8r8Q6kupI5/jBsIRh7uTAwG42HqK8YpH/mbtDRCyphrxFqcZfZ+QFso/JfmgqnHwkO
 PiBIf1W4ppzjZkL9K/PzxRs4EzDfuXUYsTj1lvARnOmLExY7kfbzUIUQQfdXuwPUQ/yyLoy
X-Google-Smtp-Source: AGHT+IFhlcCNnoE5RDw2zEbrhYif3c0FeEDzZX4ZXg8QyDqPag2Go2Zuy4FABV03S/fPg7gJSpuizQ==
X-Received: by 2002:a05:6a21:9103:b0:1e0:f059:db8 with SMTP id
 adf61e73a8af0-1e5b489f06dmr4637881637.44.1734529730021; 
 Wed, 18 Dec 2024 05:48:50 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-801d5c50081sm6232668a12.86.2024.12.18.05.48.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 05:48:49 -0800 (PST)
Message-ID: <acd7554d-8216-430c-a677-b9786fe43921@linaro.org>
Date: Wed, 18 Dec 2024 14:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/24] hw/ppc: Only register spapr_nvdimm_properties if
 CONFIG_LIBPMEM
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20241218134251.4724-1-richard.henderson@linaro.org>
 <20241218134251.4724-7-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241218134251.4724-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x436.google.com
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
> Do not register an empty set of properties.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   hw/ppc/spapr_nvdimm.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


