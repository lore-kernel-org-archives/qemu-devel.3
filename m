Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BB7CA1012
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Sep 2025 03:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuk1o-0004C9-UE; Fri, 05 Sep 2025 23:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuk1m-0004Bu-KL
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:55:50 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uuk1g-0004by-Cl
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 23:55:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45dcfecdc0fso22044985e9.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 20:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757130939; x=1757735739; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cMNbQdyvig1pWMnqCdPug6JCakAUrMnQwJfoArd5FKs=;
 b=iiE4oGchNqLt9megzPSDCyAMtDXUc8aPxLi1pKpzyqXA2GR8xVvBYPP7sTnMZaR6P2
 NQe4DRqhsGK4DNq1zd0imOaR0AlQ1s0ZzqpswhBM0Lew6BDL+K9L2vQskzwfhz9HiSQQ
 7810Cz/ct7u+gkyhb24ZHKU/kiM+vgbmUnOOu0QJT5KrYTCYYQIN1UbaaTLonPSrng/d
 h7BLs6AjxFzYPqaaObKlZ/RwXKqFjZAdWml4Gvq6Azy9E9R5RbMo7lM4+BLSQfCDylEF
 yMzDh7zJWc84QCp+5Q0XsUzR34UUuVamVQHI43PEXf8HnGmIKVUMCDLkMnqskU5yI2vl
 nXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757130939; x=1757735739;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cMNbQdyvig1pWMnqCdPug6JCakAUrMnQwJfoArd5FKs=;
 b=sVYIFDJMPwBg3E/QDXv+POk2+3nrgYB22P87MSkgoIEKl8dnqmV6M0BuOj/tCdkQZ/
 lAzFfjsI5xnP8JNkayr2FZAFPRzz2ukTVJPohigL8S2BQ0QFmm/WKNzU//ZnjOtEB7sD
 fKt7to3yWo5VQDWLMZ1vHvx9tOP8ylNov7qYj7XwRqQ1UWPBaAQ9s+J+DAQwjxjs6nEv
 Nq6FXkRcJGgGgC5BUQDtB7BIbDJWRw6wtqGautZgxTTcf86jR3a/tOqmOEpdQJ2N1gIS
 rQOeqCQ1spniLSoVOji4HqQnpoyoobSMNiOvg/R5qhLki/wAHp9Av9VAiblJ4+cdPJgS
 we/w==
X-Gm-Message-State: AOJu0Yz1OBmymHIL19gTgBp4r8nLqAsOC0CfwDA7E47fPwFRD/+WguSA
 MKeqq2RmN5gbNFLjTQs3kxmOXGeOosHJ1YSABDi6KVpMVrTWODguprH/A4A1MTc0RGFT9GqVtp2
 vjSssgSM=
X-Gm-Gg: ASbGncuCZM1SuVP3n//aeAqGHv9AflVfjHJ1gm64CND6O0axyUWk7LbwHKr3mGRCNz+
 FZnjSx8lS+6xvLphyua5iWGVft9MiixlckZP9sdO4vAeRuZtudzMPD1uodyg+RI8biOPG5HKBmG
 5mtU6ib96fCnto3+TTdQBzPhijLGRn8uvdjCDM+mjtl7+qlzEDDAx2rt2MffBjuT7sXBkQFCpQE
 FHQM9AhJG/EN8CXameMMfgiFmMJl97WmBei3ZJqRHZqOWgFPrzcvj4LcgbcnzvPH90i50dyFFT2
 2AGaGw3z8l4zLUqqheS+TU+SdhaWvJeoukkHfzKDvQGURoS/lwm/8FxMMhYg4Av242wvyx5pVCT
 R0QPoOJKvsutqRvCF5S1oznvd7+3wSLzvVhEISz57FDSrTHea6iwDyRPIA4dEaL2gbt1wbUv2GI
 3uzvfRoA==
X-Google-Smtp-Source: AGHT+IGpavGZckllj9nEoYODG/4YvTbSfcbnrKjNEdlx8DojVrkeXy3h2hk2KCk92n4n7U7EhVt/VQ==
X-Received: by 2002:a05:600c:3b8b:b0:458:a7b5:9f6c with SMTP id
 5b1f17b1804b1-45dddec2e09mr7413825e9.11.1757130938980; 
 Fri, 05 Sep 2025 20:55:38 -0700 (PDT)
Received: from [10.40.6.207] (93-51-222-138.ip268.fastwebnet.it.
 [93.51.222.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b98e77231sm178086815e9.12.2025.09.05.20.55.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Sep 2025 20:55:38 -0700 (PDT)
Message-ID: <1237bdeb-c98b-4ec6-8926-85c71f7331f5@linaro.org>
Date: Sat, 6 Sep 2025 05:55:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] 9pfs: Stop including gstrfuncs.h
To: qemu-devel@nongnu.org
References: <20250905-9p-v2-1-2ad31999684d@google.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250905-9p-v2-1-2ad31999684d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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

On 9/5/25 17:17, Peter Foley wrote:
> gstrfuncs.h is not intended to be included directly.
> In fact this only works because glib.h is already included by osdep.h.
> Just remove the include.
> 
> Signed-off-by: Peter Foley <pefoley@google.com>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

> ---
> Changes in v2:
> - Just remove the include entirely in favor of osdep.h
> - Link to v1: https://lore.kernel.org/qemu-devel/20250904-9p-v1-1-e634cb374c80@google.com
> ---
>   hw/9pfs/9p-util-generic.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/9pfs/9p-util-generic.c b/hw/9pfs/9p-util-generic.c
> index 4c1e9c887d00c44bc073bec00c07ed09d3868bf5..b71fa2cb3785349c6b4d2b9591f5ea4f917844d0 100644
> --- a/hw/9pfs/9p-util-generic.c
> +++ b/hw/9pfs/9p-util-generic.c
> @@ -2,7 +2,6 @@
>   
>   #include "qemu/osdep.h"
>   #include "9p-util.h"
> -#include <glib/gstrfuncs.h>
>   
>   char *qemu_open_flags_tostr(int flags)
>   {
> 
> ---
> base-commit: baa79455fa92984ff0f4b9ae94bed66823177a27
> change-id: 20250904-9p-11c0405ae7c5
> 
> Best regards,


