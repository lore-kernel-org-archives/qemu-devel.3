Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D936BC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbMN-0000bH-CJ; Thu, 31 Jul 2025 18:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbGL-0007KA-FU
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:56:33 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbGJ-0003ro-US
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:56:33 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-31eb744f568so794218a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998990; x=1754603790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pIQkcJ5wW7mmEUJCk3oWoKkdfDjRjWtaO/LD7TIHLSY=;
 b=LLvvosPVRLAiyA6c634dtx5ZK2XlUq+yQCqQYcovymDRFyW7WB5eMnZscRpMb5E/RA
 Oq5iHiV8imsHczXegBhYEZE7EIiBq9cMec/rJ/z0qXpuIX3LyEykjpwo8c/WWHarcpp6
 +pLC/gHBIwW9BQeSPCH1kaZWPkhT12J2hp0dYa9R0yDTnM/XDkK5Ygf2XwAkbnen7sk/
 Eojee+wti5EV2hO7tcC++CJ40qTkLc5P9/dW+jTiHE2AREXIJkujLqS3EqsYOVGDGX1s
 chWp1YiQKVpJ+kOqdT5JbV/qmJeqETZpAjXmaoIGqo4SvtQVNCLTBSjOPCCMHZO9aVb5
 D4BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998990; x=1754603790;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pIQkcJ5wW7mmEUJCk3oWoKkdfDjRjWtaO/LD7TIHLSY=;
 b=wXLslvxW8CtNqMohwDqgmfjCPC9B52K5kP2m1RunZz4o0TdoLh3Bul/dWrPdLr/zhq
 twRLj0wk++vw6tP0t4etWzkyKJB8+MF2R8om4DZRiHoOEO5NSiqTH///J7gWkQBN9m+K
 pMbS1UjBn+xSUBmSbbWXIM7LN8/mLHUs6P/rfFxUx9dJnNXTiziyDtczaXuaNZUZcSw3
 xNUcngnHOfd2pbhCRmN/miFj5M2NVC8vHI35DbihJKJSND8d/oBrGwRkf1cSCP7NPQXn
 LPHAu9blqN9MH36fW5YoBxMtosbg5obOIrVAiGSY8p15uwVka5zaVgdswxDHspPlxsse
 ylBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPwIs2YWwdJnYm+3MCjchI4+3e18YGdJ3YOK5mJx1pR7ixdra+a9mXaTalrFjDFGmh2nlsS5gw7ozV@nongnu.org
X-Gm-Message-State: AOJu0YwCt9XPiFn8Qd2WetSa+myblu8P4KF8FQx3bDp3DQ8xt8LnGHTB
 moAtKUvGrgPax4d2M6ayxX7BH3+TiX2cxe0e8h+xqAeyYfkuXjQUG+2WcJidtnILuCA=
X-Gm-Gg: ASbGnct4usrIR8k+LuVDXHSiLXSB4JtxI+B1eLNFC+s3T36q86QEI0BCwFTAVlPR8Z8
 HHvB1+niwTaED0gz7wbnSbXATPAP6g6XKH7lZOnkmKhl8j+LKvwYeGHn9mrbW80lrFcObsJnqhx
 DI8u9mTQq0Z38t5snaARdxDGJOAR6Zt5ggSFAlIcOBsrEaPfGP/mxPeZxkCSnuTRqVSkquwErrt
 4ljYGl9eu9zr11558ZXhqDCAQuDeY1aVe2ZYli4K8qOrbhGlRYkCQLR6SA3remKk9bdSstQqYLE
 Mg05PO7cUijzd5EIWskjOBGxkDmMwSjR2erEIJHlMujg2lmjXmbw9z1LdbPLTgkFVHt4/zjgxFq
 qe21mqnOqvRIKAjqxDkYXEY1ZXyDhwqQSgHc=
X-Google-Smtp-Source: AGHT+IFE168oUPTinzs3iL6uD9tnefo8mJ8XCcohH5mJ2nj1C/9JSzBn/C+EgEK0HZx7xP2LOv7UTw==
X-Received: by 2002:a17:90b:1b06:b0:312:26d9:d5b2 with SMTP id
 98e67ed59e1d1-320fb58f639mr629528a91.0.1753998990543; 
 Thu, 31 Jul 2025 14:56:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dc1bb7sm5601050a91.10.2025.07.31.14.56.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:56:29 -0700 (PDT)
Message-ID: <dd5583ea-a349-4ef5-b89e-194d80009184@linaro.org>
Date: Thu, 31 Jul 2025 14:56:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 76/82] linux-user/aarch64: Inject SIGSEGV for GCS faults
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-77-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-77-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1035.google.com
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
>   linux-user/aarch64/target_signal.h | 1 +
>   linux-user/aarch64/cpu_loop.c      | 5 +++++
>   2 files changed, 6 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


