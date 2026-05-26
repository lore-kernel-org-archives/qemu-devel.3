Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB1E6CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 12:10:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRqbE-0003Mn-Qv; Tue, 26 May 2026 08:09:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqb9-0003MP-Oa
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:09:29 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wRqb6-0002W6-4Q
 for qemu-devel@nongnu.org; Tue, 26 May 2026 08:09:26 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so7782649f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 05:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779797359; x=1780402159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57HzQERrCan/jRIcrFkPBCgEB7wT971pbE1li72yhCk=;
 b=SttWH0J3w13M6dHiIojhBnrRSjSmBhnRs84bI7hw9IGABwea0Nq6jm7dWVZE8VP+G9
 ctTycPAL30fWe8ZWZNsCBfhnL3tg2zTf13078cWlXTNlpDGMNu3noYlPG79u44QqVz+2
 VpPADCN4obPwOk6zYswh3Zb1ddefC5cI9k/+ROqnHU54iFbIILFMcRoJaY9xxSvp+QZX
 wtnMr+NuMvvVQFcObbgNv2YhJl4ck8JtDfMqiFl9VFTZqs3J8hZI9t/E9KAtTeOSpTmj
 X40QhotG+dVXbtDmMPcRXC+83qc0fVAhGJNxcS6nNT7c2AuJ86IDvK3rdMOz9sbOOQPJ
 h99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779797359; x=1780402159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57HzQERrCan/jRIcrFkPBCgEB7wT971pbE1li72yhCk=;
 b=Iv4XRcLcnwmwCizGAbx4hEkOSvAtQLRBNAs7j9KCQvuuXFad8GWbOcAsTHp8h10iQ/
 JWoVfyoOvmpnk0fPQULPdX0QMxQXpIrS1gXHzg9XMA9CaOUTSRMvn2GJdxrsr/DAWZVn
 oFdnEkXkbzzEg5HREGyE/WaAhfwYO7XufnKkRlAXxa1ZOn2iA0tp/K+CbC1X0Pw1re86
 uAvzgjU3y3rpkZ7xSsRywa2XgpHqAuh1OL+1XaRCSjsFS5HpsVr0eF5d75eCfuJ28K/J
 YBKSg0VhH48pvbmg260H9Y2uKoKo7tCBC1dI+GRvtwl/yXuD4yyeXKEYIbUiPqB3AZNo
 Bfyw==
X-Gm-Message-State: AOJu0YyZognM5JhPpF0xf1Cax2sVBCuifn87G8D9bvKJP3H2by9M28rY
 0WgjRjkDQODIR2GbFjRbFho33SRI+wI6AD2C62iNwhh9a8PDY5X/lBCh/Oo1KAWwo30Zngjr0ZR
 naYiB+k7IIw==
X-Gm-Gg: Acq92OGvWYw3IGyOQt/YpQPg0bQuhbeOz9bRcwJ9ieEJq18M8M6p1ovfvSaqOd/+qHN
 yPuZjJz2YsI9KEDc7QfbEuaFhP1Fyq+bgX0u336HSHkpTYHthVUEw1mKSbVwHQ9/xn51ld5M5mp
 2ZnE8K+bDipwMzNJ6hqvfAMqV/VBM6p8ItfgULUCRxZMauqYN9PPCsYOW2/+rF34+My0Gmn0H+V
 1aYBH5wZ2AuPC7ILg5TEBm5BovFqvE0AbXb3gVts/wX1B6BV6JoVV1cNXRfNmjpA1HBcGBMMw6f
 TuaGFzJPTLbfIRPHu5QD9J+evb5oK8nuvz7lp2CiXpajSblifShTKj/6vaXWU3DNTiCFUqxGIBn
 U1eVRExiGnSO0UoFVEANQAS4FE3jn2hMJ0uSEJhb8oBhiyFB3tmR6tUbGwE8NfTmwlntjEZLWeP
 JIEVCIzMM0AdPAMssaSEf4nKPdGM0Cv0UCP2nroE3mmrNH7mxalWgKnd8wGbCYLmJMfA==
X-Received: by 2002:a05:600c:c83:b0:48f:d612:3c4a with SMTP id
 5b1f17b1804b1-49042488b81mr308715215e9.1.1779797358904; 
 Tue, 26 May 2026 05:09:18 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042aeafa8sm105570155e9.27.2026.05.26.05.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 05:09:18 -0700 (PDT)
Message-ID: <4a1446f7-4867-46fe-ab80-6dbca9d4956d@linaro.org>
Date: Tue, 26 May 2026 14:09:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] MAINTAINERS: Transfer FW schema specs section to
 Daniel
Content-Language: en-US
To: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy
 <kchamart@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20260519173014.98967-1-philmd@linaro.org>
 <20260519173014.98967-2-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260519173014.98967-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Daniel,

Could you Ack this change?

On 19/5/26 19:30, Philippe Mathieu-Daudé wrote:
> Pass the torch to Daniel, but demote the 'Firmware schema
> specifications' section from 'Maintained' to 'Odd fixes'.
> 
> Suggested-by: Daniel P. Berrange <berrange@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 85651cf2a18..0ba6391dea6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4004,10 +4004,9 @@ F: docs/specs/fsi.rst
>   F: tests/qtest/aspeed_fsi-test.c
>   
>   Firmware schema specifications
> -M: Philippe Mathieu-Daudé <philmd@linaro.org>
> -R: Daniel P. Berrange <berrange@redhat.com>
> +M: Daniel P. Berrange <berrange@redhat.com>
>   R: Kashyap Chamarthy <kchamart@redhat.com>
> -S: Maintained
> +S: Odd fixes
>   F: docs/interop/firmware.json
>   
>   EDK2 Firmware


