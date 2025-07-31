Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE891C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uha5r-0001hx-DV; Thu, 31 Jul 2025 16:41:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhZ4F-0001Uu-5H
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:35:57 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhZ4A-0005fr-77
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 15:35:54 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-31f1da6d294so751255a91.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753990548; x=1754595348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xm1DRsI6oo59P2afvYnyuJByykwd9XwU1EhM5GRqUsk=;
 b=r0t1X9tkNOWfarmCMqMx6dvVjMea+eTaAWkiUffmSyXTrZJmO1NnThv72M1NC48BKx
 Q7JltAqnRJltk85z4xPW1YUyKdtv1teZy2EGrthXx4terb7puI0SZIOD7VxInnpxp5Or
 kQGAB3ND+bcCSWxkUWm+oGv/1NhAJiZgO8S1k7aXLSmUCdeQDKUtQStHLr6q+za+A9BO
 CtAr4X/X511Rfx05y5PKNw8b7XUpI4cLIgeZm7mTIuIoLQkOi5ap6I2sXR3y7wzLFoO4
 x1mmiOP4xlPNS8/x8pnBu6HizM0dwm4Nl4z+NRqXo31bDkrmO1oqjenN1ZtNd4u2cNpv
 M7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753990548; x=1754595348;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xm1DRsI6oo59P2afvYnyuJByykwd9XwU1EhM5GRqUsk=;
 b=GlutR5No1qew5CHZjvEiBEpI4Pfc3aCRsG+Mw+V8ytzvR3yxu3124zL4jOzcpmTtn6
 ukmFIxdAFfTk9U+iKGWUDRf2spzCgR9kTyKiZyuRsqnZ/Q3VNN85oRizWZHnBd6TiQ5f
 MRj7OjhIsKp515qzF4wpx3pBpEa2RphbWvV3RqTUA88uldvUo0dHcdeV73WJJRcIJHxg
 U7d4VHiZ9LvZDD2uxVykkq3USnLzOLvQmuZopAb4FCyd4xya8omCkJ50u+4DKxh0v2rT
 t7KS+C/AQsoTo6DbhSPU1VF1mZ1IDdclk2HhZJz7CwubJRHhdaxRaU+R4FVIgfGsgK56
 A9ng==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsQ/2lNiTOgsLFAQppa0iKPgZ75VXQKME3/bkw9uetK+oMe5USb8oMXlWvY50mop3+FiGFT4FIGZo9@nongnu.org
X-Gm-Message-State: AOJu0YyoamF7pkyAUc1QFVjhNZY29lGfJmHbMgAtH0U17lg9mPHF3lcL
 pMDCsbGMhwdHkRA7o8UCL+8RhBiWrajH8Elpk+CBRdLlaVflXxF4u/nNeoYjopRpvvc=
X-Gm-Gg: ASbGncux6s+VYa0tx1hPxsOL6BdkpYCb78zIb4ReKYI+9qMtF4pZM0n6JA4Ko6ZEhnT
 PqhVOzHUolFjkuOHWmczB8eaEFHN3XVZo+Sh4K9Z3YHv8sHM8dCIERuq9gYkd9R+bNam9uh2IBK
 yJ7sN1UjCWf1hgV8lS2zjAjm1cUW7MlXG9jTl8CsPOUatHCQct6Pj9/NjiiKYHBFx8qPcJRHIv+
 n5SfQN58ozRHSONhh+p9DRg8q2MdmyBcCgydYm/4PmkYqZ7BAWgt/5KPpe/OwQSqyTu1XvruTPP
 pNpbFB43BKOCj4T2rg17XsgC23XLzYC6z6s1RzJhrbGgIDb0y9lKbOBuG9/r6Trb3VlNYXRoX3S
 YO0CbTmBbKWhPmD0pMF/zjfo/oQ1eCKsZK7PraVSzPL0Jag==
X-Google-Smtp-Source: AGHT+IHmovPI0rn/kMuOj5rywMfr86d95Jpf2kMee9IDXP0oBtx3VvnLd4PzEbdNc9z/8MDI8Z+H7w==
X-Received: by 2002:a17:90b:2407:b0:31e:ec02:2297 with SMTP id
 98e67ed59e1d1-31f5de2d582mr8853340a91.19.1753990548272; 
 Thu, 31 Jul 2025 12:35:48 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207eca6eb1sm2703028a91.22.2025.07.31.12.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 12:35:47 -0700 (PDT)
Message-ID: <d87652ec-c0de-4d7c-9e2d-837b54ac2052@linaro.org>
Date: Thu, 31 Jul 2025 12:35:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 48/82] target/arm: Add syndrome data for EC_GCS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-49-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/syndrome.h | 35 +++++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


