Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ED3EE0204
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 03:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soE81-0006mQ-4K; Tue, 10 Sep 2024 23:34:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7z-0006ZF-G6
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:47 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soE7x-0001XK-V3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 23:34:47 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2da4e84c198so4228229a91.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 20:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726025684; x=1726630484; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Mq0CF1jrnRlGi8cpBf5CtUfMQDJCHU6PS2mcWi5Kb1A=;
 b=FUVvHeUfSEDirSSAVaoOVaav8LQJWPHNMi3qrlC9bx+CBaOuA87pm2SsxaDeXPYYGO
 PU30UeLxvIqmZdRfYA5IRsW/qvaYjCXFeIa4TgyH2lSzJL41uXvjTsvamW5Rv4uTNj0G
 fXMWEK3fDEmgn0Hxr7lTf2t+CnUKAcOq2R9n1HFgL+jQOBjj/RYQa/XTWf27FQQjzuNH
 1HTG6PluHuHepz9idkE6ivCcFetDVFVy5PJaBW5P1BXPTnMdqviLXgoXz3xgblu2lDAp
 gz/YZ42o5WpQ4bNCgrUShd7OW5pakdJMH+QL1VAOvC8MPoQ9PK0W4U6jrl0ZixB8uj8X
 zSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726025684; x=1726630484;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Mq0CF1jrnRlGi8cpBf5CtUfMQDJCHU6PS2mcWi5Kb1A=;
 b=BtXsUQyD2XwurX3wgzVXuZ/13cMwxRXB4oHIN3aqUyLCVLCo9ZL8hDHez84K+ZnjYT
 KF5+gpNLUrTXwg7GLW0esoW1s4Ah0sUqUlFviqL2luTnzndbajSyRSnZSjgYeXe0bhOm
 Koq+WQU5xWAvVrsfJFxzUD5/PCJzDweM6vhCRcSqCYqE4k9ZnK4/ZFLIh4ephCNctWWE
 g0whye761nfnFYxu9/Isvn8u6Ts6qrCry96Q0ofyaZ8QrVRRgXiokaAjApQ0jpDy8EWM
 qm0fW8Uz56Xy8PyytObqVUYQgPFMIfN8oM/o7Vn1OjBifsOXeant/ZyaEZKFXHFv94Bv
 cEEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKrkHdTmPEm4QtBq2h+X7yzhIC36ag2M3BaLPjZxPPBTnMg8Jq2MH1CX7fUrGNCmXenCBeE1CvPxoH@nongnu.org
X-Gm-Message-State: AOJu0YwmDnJ76bJrpN7KIw0I23I6lx++W+3YoSEdJd4BhB09d81qgvBq
 Xh1noTgRWl+SmGmgWGhDbkWnaqq41fxodq3i0Jxk52GPPXNxSXFQRmHzd0FJ8QThfz37GR2IaNT
 w
X-Google-Smtp-Source: AGHT+IFx6dOuRrSj06soRIJtaT/HPha5iq9Dc+xhM80slmzz+ckWbh324kcXbYiRJXb9Tp/lgAnziQ==
X-Received: by 2002:a17:90b:4b81:b0:2d8:b6a6:bc2b with SMTP id
 98e67ed59e1d1-2daffc8648emr14155152a91.21.1726025684507; 
 Tue, 10 Sep 2024 20:34:44 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dadc127b9asm9261751a91.50.2024.09.10.20.34.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 20:34:44 -0700 (PDT)
Message-ID: <2b92ec3c-e1b5-45f6-8597-d345587e2edb@linaro.org>
Date: Tue, 10 Sep 2024 20:34:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 36/39] ui: remove break after g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-37-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240910221606.1817478-37-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 9/10/24 15:16, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   ui/qemu-pixman.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
> index 5ca55dd1998..6cada8b45e1 100644
> --- a/ui/qemu-pixman.c
> +++ b/ui/qemu-pixman.c
> @@ -49,7 +49,6 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
>           break;
>       default:
>           g_assert_not_reached();
> -        break;
>       }
>   
>       pf.amax = (1 << pf.abits) - 1;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

