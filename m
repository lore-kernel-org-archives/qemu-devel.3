Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B203C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9lCd-00082w-AQ; Thu, 24 Sep 2026 11:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9lCN-00082H-HE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:17:24 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9lCL-00085B-PT
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 11:17:23 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 d9443c01a7336-2d747eb79f7so10767625ad.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 08:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790263040; x=1790867840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZDyAbh2k4zuANURvukD7Ar/quf5F8yQoKNnpcLV2qsc=;
 b=KtfbH/BYuVNHxpIa6tnQklj962Jiu9ufGXjPqQaHKQxlA4ksLayClVJ4OdiHRlBpIX
 L9vbLm9tKJ+NiemM4HbY+XMHWs9HuYVbrRLwZzwFB2f0HtzhJX158oEGMzGatDTwqckv
 fLFfutn6ZtSygYRz1gI2vXbxj9/jqajj+oK1abshyjE55xUFUyOf4wD8mlzrflzqOxik
 +ytEF619fxrL0kyQ6rStWg6vWMwcXrDT09OxrX9lJMQKzn6Hhqu3KiX1KZFNDCGGjdYB
 HnIE7cw+zXQzZOzimxyTXWAUQERBWegeQLoIkNSFJ2Z0Uq3yuXyAT6/3FKZqPLD6a6pr
 DREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790263040; x=1790867840;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZDyAbh2k4zuANURvukD7Ar/quf5F8yQoKNnpcLV2qsc=;
 b=y4HnCG7SvaVioIYv14ryI/14Yf8NY/IIhG3jvArXRx/KSTGVnmMrkfa8l890yM8g6R
 KVDVn+xRKyfBqdJnWfu97ffnSLmDVnQpDZX7Ia1UBrQJxIDdrWiOJA0mU4bNRng1CFDg
 KV6hk0Q7lT1WcOWwBGoCjkzyTxYt0LTrfVQZ0RHiOncFdG8yZi8BDcYMOdX6ZE36SJQ6
 BuEZuLdcllIMVt00GQlLc5yLcTmE+VKEBRAUZdIusFxkUPqt/K4A1bp3xWaAr4w9kcgX
 Os97d5t8Cp/Al9efor4jNl/Mv7RLE6/77/qMxCZYvk2H+OfEVUBHKu0HfskmVuPYdlIW
 j5Ww==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKvOaTHyEpng3G1AHJbiIrdnGnAgtqPwS3Aehuis23szL2hnGdtcsiG0lto8NAYX0JvzQXZ/hlMG9v@nongnu.org
X-Gm-Message-State: AFuF++lHYRTdjTba6fhKtMqGtwHlj0vmHDWrhcvrntdNfINJkpmKPFei
 cM4kvdeojvy5pLJkDnwb5TP9Sje0WifVG0ovDP7GvsVhEl+xlwKEjEnIvt0WpWH4KkI=
X-Gm-Gg: AYBFou1+IgIBdbU1iXJ6l4erqqp7206ITQOKbmNRpy+K/JuLBocAjYQ0RAVoekC4Xv8
 zzO+j53ccZD5mQq/GPZmrYSDjCbRV1bVc4xIrDaYWC85hdBjzaXoFrgBrLcJ0R9xLTxLm8bQOV1
 7r/mOLfw5uN79vQQ+M7O29JlUWNALiyIu3p24eJYnadXM0jTEv4xtpzqLxLYowlgRBHVr1+4TYv
 vBJjv/UvG8KxuE3qQTzwmneIyzW/31fAI+y9aJkdV2UzXY2VyMhPdrlrRSUrTsFD5ZUUJ5neRQW
 wyhJM/xQd6YZAEr6JwJ5gWgdrBtYLq+8gHy4ut0fCeQU5wkZDSF/XjYDKjBDbrlL+j0L97pw0/R
 0fNWsfNODBjmdf6wLsKV7eeqxcIuRmiqVavyaKWPLG6GaaG0IRukrL+TAiMa92lvYWuGr6E7PX1
 Ls/ouxANaxQ0kUcf0POYvIw51OfBB7RG24icocFoyvp0JKGSIFCg8NEbAe71FW0+y3BFMuGA5Rt
 b8KuGzGl4oUuUk7F7gQY71icCeuRDIpu+uP9AiG
X-Received: by 2002:a17:902:db05:b0:2df:5f26:16dd with SMTP id
 d9443c01a7336-2df7dfd4646mr24333325ad.51.1790263039734; 
 Thu, 24 Sep 2026 08:17:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a6022ddsm29100705ad.76.2026.09.24.08.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 08:17:19 -0700 (PDT)
Message-ID: <58073b08-9f64-400c-b8a2-acd0baa4add5@linaro.org>
Date: Thu, 24 Sep 2026 08:17:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] target/i386/tcg: add decode functionality for APX
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com, zhao1.liu@intel.com
References: <20260923173021.317809-1-pbonzini@redhat.com>
 <20260923173021.317809-14-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260923173021.317809-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 9/23/26 10:30, Paolo Bonzini wrote:
> +    case X86_EVEX_APX:
> +    case X86_EVEX_APX_cmp:
> +    case X86_EVEX_APX_pp2:
> +    case X86_EVEX_APX_zu:
> +        /* Only reached through EVEX map 4.  */
> +        assert(!(s->prefix & PREFIX_VEX));
> +        if (s->vex_l) {
> +            goto illegal;
> +        }
> +        if ((s->prefix & PREFIX_EVEX) && !validate_evex_apx(s, decode)) {
> +            return false;
> +        }

They're only reached by map4, so surely

     assert(s->prefix & PREFIX_EVEX);

is more appropriate, and the subsequent test for evex moot.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

