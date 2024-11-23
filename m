Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC59EE6ADFF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 13:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEqSD-0005MM-4M; Sat, 23 Nov 2024 08:45:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqSB-0005LQ-5S
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:45:39 -0500
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tEqS8-0001hL-Q9
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 08:45:38 -0500
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-5ee461f5dedso1636904eaf.0
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 05:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732369534; x=1732974334; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMEujV34bk6qujov70uRVE3pIW1OydilkhN9+3yJN2g=;
 b=oDbORvClVl4Ive9TQrGUqfNJLR8QpirJ/ejcNl4OFg/dnVF6t4Y764Tcm++gN12aZn
 pwW3piZHT3dNfccDaaFwI5ehyztSS2OuFWwu58NzMwMu3O7aEknzApSzPrkRghUzSjPL
 ge4fQ4ct7+CIM4ul4g3kW2MX9n4O6jeE/SON6y4w5Ba6Kmig7GONA2ayCu44bhtEWumj
 egeAV8WrpS7uTtcoqnDzeFVrV/kZ3Qs7Bp9+x09GP/d2xe0dIeomxqcYFCdwMtpgmvBl
 c07AEvsBcezWfSZwQvopzsSQ1UrdQ86TiKRD2WSgZME37lNZigVRcjpt5hTYjWZnC/4N
 1jZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732369534; x=1732974334;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kMEujV34bk6qujov70uRVE3pIW1OydilkhN9+3yJN2g=;
 b=iVYY34tGtAKpR0MxHMzgTf6JKhLxgoS2szraTxMKiHwzWqadRmkEJQcG3J4z9/c8ys
 H6IbLis3dEA+9YkE0j8oW1u1YykSQ8mEVRQ3lmhzyi/x4uKdKZrK95vv+HaL+9IoHzen
 TG82sLgq6hYu7itLe25CDZxqUA9wpJHPoEpDc9l8mo6lCUgjxv4NTxopbFhtOHC4DCR7
 2OLenC6k3sN5H3eIKqhuDo1db72S4wipHn+9xade2mld43xqjGY1cAcnZbYvMcrAlt4A
 Qrjag18xzbaQZWT5MO2Rf0XNtuT+i7jHVdX0wmW1PkiTRz2GE+X0qx99d2L7EFxZWubO
 IwYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4RF4yz+WhpcT4RV8W0q0dOFqTWQLLM8vLCDycTWrPaluUFovLlf6MhHqWekQzEpJvk2n1kStOgk7B@nongnu.org
X-Gm-Message-State: AOJu0YwvodbhEyNyvQD17AnXsBjuHaGzABzJzBwLzKDEj+EMUqMU3eIc
 dnbiUxeoNxCKW3kmr/7l4zG4MGDITX2xrU30FSjG/7+s9Bnxz06kabZdbvzjPdo=
X-Gm-Gg: ASbGnct4jYcqvzg9EayWlTWBP0b/Gi6s99fafz8qWi49Vo4QrH8rJPPxQWVr6XNwGpU
 I7e7MUDMrpehI8irBNWUqtSUcP8WxADz8qmpWhtqVxGsru97Bjxm/Sg5MJbYa0n2oGWnXJfH0bF
 sAM0kmjPEBh2j27uPUbGEj6FxofU+PZzH8QrT8scUgBYkdy7KCL9dKY3iC2Od2dyrPd83yHtNuH
 TT8f4kUql3Ds/8oWAXotV5mgpveAQofyuIHVjX4NV0eUBPu3Edf71t1mqtXch228Q==
X-Google-Smtp-Source: AGHT+IFYzNNKoF9QCJ1MczkI4Rrlfpxvv9z/x4S/rJC9cNwo/BsFU9/hIXCD2DBZT65tYgv5nuGURA==
X-Received: by 2002:a05:6808:1691:b0:3e7:bcab:8f0d with SMTP id
 5614622812f47-3e9158768dbmr6298599b6e.24.1732369534604; 
 Sat, 23 Nov 2024 05:45:34 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3e9150141aesm970797b6e.54.2024.11.23.05.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 23 Nov 2024 05:45:34 -0800 (PST)
Message-ID: <28fabc27-29e1-4692-870c-69c41b29b9fa@linaro.org>
Date: Sat, 23 Nov 2024 07:45:32 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/12] docs/system/arm/emulation: add FEAT_SSBS2
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241122225049.1617774-1-pierrick.bouvier@linaro.org>
 <20241122225049.1617774-4-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241122225049.1617774-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc33.google.com
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

On 11/22/24 16:50, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/system/arm/emulation.rst | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


> 
> diff --git a/docs/system/arm/emulation.rst b/docs/system/arm/emulation.rst
> index af613b9c8b8..50d0250b1eb 100644
> --- a/docs/system/arm/emulation.rst
> +++ b/docs/system/arm/emulation.rst
> @@ -137,6 +137,7 @@ the following architecture extensions:
>   - FEAT_SVE2 (Scalable Vector Extension version 2)
>   - FEAT_SPECRES (Speculation restriction instructions)
>   - FEAT_SSBS (Speculative Store Bypass Safe)
> +- FEAT_SSBS2 (MRS and MSR instructions for SSBS version 2)
>   - FEAT_TGran16K (Support for 16KB memory translation granule size at stage 1)
>   - FEAT_TGran4K (Support for 4KB memory translation granule size at stage 1)
>   - FEAT_TGran64K (Support for 64KB memory translation granule size at stage 1)


