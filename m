Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 723BAC36000
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 15:18:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tve7t-00081a-5t; Fri, 21 Mar 2025 11:17:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve7k-0007za-QF
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:17:29 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tve7R-0007BA-5Q
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 11:17:23 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2241053582dso7601115ad.1
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 08:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742570213; x=1743175013; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cWiMsPOXjV4WZgBUXf6nP7v5mjOMkSg6fEMH2/fP9/M=;
 b=rbrqHktMbib1rrzBKT0IJyML43B8DLB+LgkoasjczcL8qLRxxOlHNVJe44jU4SkwaE
 GhUZ8xqE4tc/FE8BYocG8GivmHSs4AqCe0QQXIjmGMyWe5Up4AVOPKaEWxaV9EQTIeLP
 Gizd9JYqM9Fvm0Dcq2K21tpXOppQqK9uDHU0uxJ5upN7DTBjiANg22LaSgC1sbHPnHko
 eOPOsYl9XvIH1FlbsI0WbVi6P+vHwTxT7ZLKKO0tI/H+GVs4ZojGouGjUJGUiw/Tq3pj
 1xJnCmeT4FTNigx9pq4IYuO0NbqSdQkFEBMfZN8XyE07JHIeWTv625C4ipMFdah4wlNe
 HZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742570213; x=1743175013;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cWiMsPOXjV4WZgBUXf6nP7v5mjOMkSg6fEMH2/fP9/M=;
 b=wTuQXmcAunsmw0egBXI9NLA9UhfLaHkonFXwkpI6vCbSBM+wrp039I6wuQACYDh0yu
 36FjPO8u+EBI3Cbyg/wKfV8yCcNfg3MoYK+ktqR+/tpvcUzo1mF3do30rn+RBjawN0b1
 5ZwulR9DkkXr76qr2otldC19aUeqXLvw3vujgSz/dojaT0KORUDNYArdyHHDmhnCCeTE
 fEcmcdaGK/7hMrj44kqjXBQSJYsLczKMS+cv1e6KEsfP2rWPHAEelJMhgbvVapIeNkcg
 G0ePhXAm9L6FW+qlk8pwLCXSht8ZnPUYN1StqsnllTGu7PwoBe/otMkz4BsmXIxuKlCq
 9rig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU99amQKKS+mEGhaL9gPRve5ETG/M6ELVWShc6JIn1WZONckmGJz9LerxAmPt8z69lDHdnIl16p9xQE@nongnu.org
X-Gm-Message-State: AOJu0Yw8ar0mHnCjlGY/Hrb1iQusCX3Wk1MHtYl2niBWC/gHzhSr+1HY
 TDmzyQKPj/0YLGS/7j6htvxBDXCijAGLzEV4PlCgNu6g8a1OKpPY5AAmkOCBn7M=
X-Gm-Gg: ASbGncs+B1dLRYKzy3i/HHsmKt6Z2GXBbP4QQav23THnxr+N/oeYp6TzukILCS1eSp9
 HlsD89lcU5mz2lti5iwng0qSruLJcbCuKY8kELsH9AD4OGOpF+LuEJN7/kwQaCC7k2hHyTooJdg
 I4+ESMhPGQzc1YkWMN8pL2xVqYlruryq1HbcGHWxO/h/gNTtJURdBVz+nb7YBcQTghBr3n/gVIz
 WHX3ZWDL6M9rsBhPX1+wKhlzoeWGIlSHMY0DNMRPfnRFbXcXw4aCJBatKjxrOBAr1YswOeJhnuH
 SZFI7K1iMFv4JbAGdYM6ixPd7CxjUeM6yOIshmt1Ez6pg4ksuEcVvofjX6npptBuTeFdRUfiUic
 GNtd8GDGt
X-Google-Smtp-Source: AGHT+IGRL9so5AkWalZpe4dg1fRcQAfXShgzCVvIULoZ8U75rn/VCnjgYf9sXXYzi3/gMyRegNc5dw==
X-Received: by 2002:a17:902:d2d0:b0:21f:1202:f2f5 with SMTP id
 d9443c01a7336-22780c526acmr38016965ad.8.1742570213561; 
 Fri, 21 Mar 2025 08:16:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f45954sm17947915ad.62.2025.03.21.08.16.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 08:16:53 -0700 (PDT)
Message-ID: <5bf233ef-19e1-4d81-a7d3-5c081a555247@linaro.org>
Date: Fri, 21 Mar 2025 08:16:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 3/4] tcg: Have tcg_req_mo() use runtime
 TCGContext::guest_mo
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>
References: <20250321125737.72839-1-philmd@linaro.org>
 <20250321125737.72839-4-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250321125737.72839-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 3/21/25 05:57, Philippe Mathieu-Daudé wrote:
> In order to use TCG with multiple targets, replace the
> compile time use of TCG_GUEST_DEFAULT_MO by a runtime
> access to tcg_ctx->guest_mo.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/tcg/internal-target.h | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/accel/tcg/internal-target.h b/accel/tcg/internal-target.h
> index 1cb35dba99e..014ee756f9d 100644
> --- a/accel/tcg/internal-target.h
> +++ b/accel/tcg/internal-target.h
> @@ -49,11 +49,9 @@ G_NORETURN void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr);
>    * Filter @type to the barrier that is required for the guest
>    * memory ordering vs the host memory ordering.  A non-zero
>    * result indicates that some barrier is required.
> - *
> - * This is a macro so that it's constant even without optimization.
>    */
>   #define tcg_req_mo(type) \
> -    ((type) & TCG_GUEST_DEFAULT_MO & ~TCG_TARGET_DEFAULT_MO)
> +    ((type) & tcg_ctx->guest_mo & ~TCG_TARGET_DEFAULT_MO)


Incorrect.  The setting in tcg_ctx is only valid during compilation.

This macro is used during execution, in cpu_req_mo(),
from the cpu memory access routines.


r~

