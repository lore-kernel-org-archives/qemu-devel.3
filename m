Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2723C282EC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 01:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq0Av-0001SC-UI; Wed, 05 Mar 2025 20:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0Ao-0001Gh-4c
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:37:19 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tq0Am-0007OB-31
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 20:37:17 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-223fb0f619dso1599245ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 17:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741225034; x=1741829834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MOAwoglHHW0+QyE2/h+qlNBEyyZ+PP7bqa04Rnq5OWI=;
 b=SqYO871IhwHjNpmVCGnf+B1hgBgZzHzelcjBONGhT/S3dIrulmRlLRSup0+4Hn5uwW
 qEaj/n9PbcLRG2L9wKegt1IOPR/Dhm3Ng2MlrxgHTDbMLhg+xHek1VJLjb5Ohn1eNfzP
 VH69suFqjXPO276+5cCzgnAYWqzaNHSi4VF8cWZ+XtgavXRU9i/KW70ECSZYaiwHMF2z
 K4J4sDalBrDOQzw1AMiWWDBi6HJ0FDVm520hZLYjt9P4hlgr0AxWMfEeaD2W6yzECK46
 SFw685Z19Dtd3QYJnSALPRmNIvhhaPo4dnExiRpKZsRnGXhz5C5zwlYTTqo0M91z/7bm
 hdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225034; x=1741829834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MOAwoglHHW0+QyE2/h+qlNBEyyZ+PP7bqa04Rnq5OWI=;
 b=TM4huqhE7VqCQS1FRHomoSnKBKGuhfy5/0HPUiVl5P2Sv2vscH2Hg6EvpQwPvhHUFv
 VM+u3SCszcDHV/5CaagY/KvQUPnbrkHxdbd9FB8TxCQNa6Y4rPrBItTdeKYbXomvkFx7
 YhKCOtRJbfbkGLbobsqFAh1P7NMpjy/cLaLzS89/BPDxmRlktjS+KL3+eDGX2IlJQIDr
 BQ5q8PxNup4tYGo7FCEA49WVL0CFRz0RXGlizlFbwKHHVGVbjspwuLGa/Jd7Ru/+072j
 19kIj4FBh8t+nyk3chkH8fJNMyNy3uVnq06p6f+IdPCk1EW6UIXuu+fs39WMBlHOlhZk
 kp3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhr+SKX9D6ChI9sypAVn34MV7IQbg1nUJSi0YR5Y45nHTzZ00V48yOFwn6gqk1QFUslm2OyapC6QsB@nongnu.org
X-Gm-Message-State: AOJu0YwZLRwU7uHVRnpCMXnSgv5CdO051uFFbiPQp6/gFgc41j/1/Bbu
 0NDKqzz4rJg5z2E972sdKL55v0fvAS3S3eWmtImqC5iQozE1+WfmihBKhFvmI7E=
X-Gm-Gg: ASbGnctR+z9lin28+sn9iUErOGYEsvG/uTiBHFoQDFLNaHsZQGXRar4MjbJDHixnGBN
 vdpkRtbJ50AhBMJOcXxGZOalJnPutLRBwIWkv17fTef6q2HmV2/oUSX2FsI3CB/gwYpZp+CrTrc
 ARNrDmqVANkAz41qsQjKM4K9HRZYfEpSEpUFt+uDNwt5HSH3gUyL2G/0PAq7qROHk2HXATL79uX
 FX6fpj2VpidsR/HxtWV8h+LyqqRy0XdOb6B8+AiAdL90OeOMGsjX93SOvAovXicVXNASzdr0phi
 Uw7m3birUOzmq5B0Czy83ifw8dSuefWV/JAqCr9D9SPue0hz0gcotKbDc2JD8tERz9WSQDfADuL
 sJBYGKwXY
X-Google-Smtp-Source: AGHT+IHY3PlDobdBzTSvEkKEzxJpLHvvEzLHUfYGGugTl235VFsibbW9ImKFh4qqH4z1KHpawOcG+A==
X-Received: by 2002:a17:903:1a24:b0:220:c911:3f60 with SMTP id
 d9443c01a7336-223f1d405f8mr89112785ad.47.1741225034310; 
 Wed, 05 Mar 2025 17:37:14 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109ddce7sm865635ad.3.2025.03.05.17.37.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 17:37:13 -0800 (PST)
Message-ID: <003fa605-09e6-4586-a177-019be38b3e4f@linaro.org>
Date: Wed, 5 Mar 2025 17:37:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 02/18] hw/vfio/common: Get target page size using
 runtime helpers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250305153929.43687-1-philmd@linaro.org>
 <20250305153929.43687-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250305153929.43687-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/5/25 07:39, Philippe Mathieu-Daudé wrote:
> Prefer runtime helpers to get target page size.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/vfio/common.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 7a4010ef4ee..d4c9e59173d 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -30,6 +30,7 @@
>   #include "exec/address-spaces.h"
>   #include "exec/memory.h"
>   #include "exec/ram_addr.h"
> +#include "exec/target_page.h"
>   #include "hw/hw.h"
>   #include "qemu/error-report.h"
>   #include "qemu/main-loop.h"
> @@ -395,10 +396,12 @@ static void vfio_register_ram_discard_listener(VFIOContainerBase *bcontainer,
>       VFIORamDiscardListener *vrdl;
>   
>       /* Ignore some corner cases not relevant in practice. */
> -    g_assert(QEMU_IS_ALIGNED(section->offset_within_region, TARGET_PAGE_SIZE));
> +    g_assert(QEMU_IS_ALIGNED(section->offset_within_region,
> +                             qemu_target_page_size()));
>       g_assert(QEMU_IS_ALIGNED(section->offset_within_address_space,
> -                             TARGET_PAGE_SIZE));
> -    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size), TARGET_PAGE_SIZE));
> +                             qemu_target_page_size()));
> +    g_assert(QEMU_IS_ALIGNED(int128_get64(section->size),
> +                             qemu_target_page_size()));

It would be worth storing this in a local variable, I think.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

