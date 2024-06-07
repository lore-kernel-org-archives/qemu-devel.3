Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA885C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:28:23 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFbil-0006UZ-Ko; Fri, 07 Jun 2024 11:41:39 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbik-0006Tv-9o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:41:38 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFbii-0006yd-7f
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:41:38 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f6da06ba24so6123035ad.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717774894; x=1718379694; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=x1qv6IgBykZGIEulE6jXABhySKz9LjMJH1MzP+GCm8g=;
 b=rWZ9AvOYUcWqiEFxADwZyOY69YyN5OJzF6OQg33WdA5sjogpFodPDO1pCWrgtmsqr/
 AJukBpZfhJKnRhDLvm6rZnY76pNWqJAzWUY17ClD21uAqDzjj4JT3hMqRJCo2SUxn/OT
 yDKcNS33ePtlVGWp5NvubztMVbN9gDCcIxHOUSl9G7rcmCyshZbnOojLXQ/u10gEGjxQ
 6M5PQr5vSVRjR6gjbyjyvRxzaxD7Tgy3fI590q2dYBD0usFkX7PJzkxu8n0RRZJ/kiZf
 1PPn4PmPxcXLdifSvn2h67oVAclc6TDNXkIlFZdt23HOJ37vXajeAilqh5M9SbzUJ9WC
 l0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717774894; x=1718379694;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x1qv6IgBykZGIEulE6jXABhySKz9LjMJH1MzP+GCm8g=;
 b=aiiBnhwkiFIIQ/lUgtLnWKpCSnvQ0epIXCcXp5J9I6B3oWroZAEj4EduRDliSOKSTX
 R1bRjlQHtTQsmuHgKHOymIlvtMvDV1LedUPqdiun6CJlwxHLftnOyGX9nrOJ0vdebg6Z
 dyqcxIGr9q+h8yIV9c7EzuVHosLAtZQb1oMEadkTUYkcD1i29qJUDZASJ0AGrNzlU1/i
 a67ANTJftiEK7AskfORzyrMWxEEcZD0JkHon5PGatUupTkPrwidVhYGpux2Vb+jCztRo
 M2WX8T36l2yMEEtKhwLAfAUqs3hDahCoJ1kbc50C+XeuZcOzsh2WYw42yDVj5ZRoE3vg
 89jw==
X-Gm-Message-State: AOJu0YwcEW68lt+25lXH0yROOa7wG51KYHhwjgemhE7gGTu+SViChcBc
 nA1Byj+u07Bha987bPoaNIUFeM9wtmfJSqqF4Hv/tzTS1rg9pZdIE+v7fpFoAQY=
X-Google-Smtp-Source: AGHT+IEe5tamzQb1kxipIbJw6yoC3/5yJizrhvAxt3i6o7eOo0cRUEtsq+zC5yowfm3b9W7f0OkPnA==
X-Received: by 2002:a17:903:2306:b0:1f4:a233:c964 with SMTP id
 d9443c01a7336-1f6d0377894mr31365905ad.55.1717774894138; 
 Fri, 07 Jun 2024 08:41:34 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd770405sm35705615ad.108.2024.06.07.08.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 08:41:33 -0700 (PDT)
Message-ID: <91e78fa4-f844-4b79-ba09-46c722f35df8@linaro.org>
Date: Fri, 7 Jun 2024 08:41:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] target/ppc: Move VSX vector with length storage
 access insns to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240607144921.726730-1-rathc@linux.ibm.com>
 <20240607144921.726730-3-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607144921.726730-3-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 6/7/24 07:49, Chinmay Rath wrote:
> +static bool do_ld_st_vl(DisasContext *ctx, arg_X *a,
> +                        void (*helper)(TCGv_ptr, TCGv, TCGv_ptr, TCGv))
> +{
> +    TCGv EA;
> +    TCGv_ptr xt;
> +    if (a->rt < 32) {
> +        REQUIRE_VSX(ctx);
> +    } else {
> +        REQUIRE_VECTOR(ctx);
> +    }
> +    xt = gen_vsr_ptr(a->rt);
> +    gen_set_access_type(ctx, ACCESS_INT);
> +
> +    if (a->ra) {
> +        EA = tcg_temp_new();
> +        tcg_gen_mov_tl(EA, cpu_gpr[a->ra]);
> +    } else {
> +        EA = tcg_constant_tl(0);
> +    }
> +    if (NARROW_MODE(ctx)) {
> +        tcg_gen_ext32u_tl(EA, EA);

ra == 0, narrow mode, will crash, due to write into constant 0.
Obviously 0 does not need extending, so this could be

     if (!a->ra) {
         ea = constant 0;
     } else if (narrow mode) {
         ea = tcg_temp_new();
         tcg_gen_ext32u_tl(ea, cpu_gpr[a->ra]);
     } else {
         ra = cpu_gpr[a->ra];
     }


Aren't there existing helper functions for computing this address?
And if not, better to create one.


r~

