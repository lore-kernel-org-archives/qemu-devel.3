Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242FDC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKXyV-0003l9-Lm; Fri, 21 Jun 2024 02:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXyU-0003kx-B7
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:42:18 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXyS-0001JP-FJ
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:42:18 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4247f36f689so10304215e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718952134; x=1719556934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ve/AxcOTnVZVcP+UvtlEFUcp67tE1YdpL8kQ/Hy060=;
 b=fXLYwnDyz94gdlgfBG672Hz2g7t5aWQunqAV84+aeHe9Q/TpO5wreRSK64Ge478Ci4
 hx7WUKzG5g+wVSaSuKBjjiBENSIWzeTsDGAIbo5XL9sBYP5v0qdj9A0JynesMRgkjscQ
 NhlM19qiX5sy5nfaEvYP264zzPmdfcRAQLiSjH11i0GSaQEyRUzIVGDnHCLyx065YIek
 ZFUJxOJMUdT7ob5wTEwt3k+AeuMaDCCzeMh4CFsxQ4nJiTTM8xNCtkBLLlpy87/n4EN5
 DzzkZ1ut4nG+Ea3EHS2rGwRnXwUhlDcCN2FCyfB6RbVyCqzMFraGRrbP3kmxnQB6bUp+
 S14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718952134; x=1719556934;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ve/AxcOTnVZVcP+UvtlEFUcp67tE1YdpL8kQ/Hy060=;
 b=upgdl9elGCPkEGhvIYbeaPY8YhxR0C50sgnoXFBa0uelvW2K89ZLiUKL2dsGBVBNrw
 A98FrotFse/mQA3lMnuvHo0BO+pGShQvi5V8yFMLyi6cVAI33SucnvakGhIqx4EP+Pv4
 6d+Gzy/sdpHIl0nQFjBkxHeSfewMVyvqt3o00nszia+dL0SUlibwkJBZ5qFFPF9nZIIX
 cLtFhGVerDQHd33aJOFQQ+wTmp0IBDqRHex4ONdMYo8UUkt3A3N+SFgV8cJwqPnVciod
 HPBfgQ3mHH+Xg5lHfSQ00iWzVUV1SHuklEqjEIUQ92oidSy9anf2ErqdgHluIx5H5bq8
 mwfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMaUCqf7wvNeZGWENfV2YpRiNpwZCAZD+Jwxkx6ldlmVrsq5EMpL/VfcwsoXfDzuclzCbznAWYKtfI7k5jo2r36qjhTvE=
X-Gm-Message-State: AOJu0YysQeG0j1ZwpnRCM9WoKrzL8A3+dEeI7uvD8ZxIQ4Iw8H+tBwoh
 WxuVUqZZCHB5G509YqdRsMEJTl5C092uYA11kVl526Xqsfk0soL/y6FGupUiMvM=
X-Google-Smtp-Source: AGHT+IGvNRLluHn2q8UH+BlX6Gz9H8DfyRCiOKlplu/eRj7o5nrmt/ev1+bR0FUMbUTCT4M15SSMMg==
X-Received: by 2002:a05:600c:68c5:b0:422:6765:271c with SMTP id
 5b1f17b1804b1-4247517e003mr57431465e9.20.1718952134427; 
 Thu, 20 Jun 2024 23:42:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42481910fa7sm14723285e9.29.2024.06.20.23.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 23:42:13 -0700 (PDT)
Message-ID: <09b7e7e1-30a6-49d0-a5f8-9cfc62884c55@linaro.org>
Date: Fri, 21 Jun 2024 08:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] exec: don't use void* in pointer arithmetic in headers
To: Roman Kiryanov <rkir@google.com>, richard.henderson@linaro.org,
 peter.maydell@linaro.org, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: jansene@google.com, mett@google.com, jpcottin@google.com,
 alex.bennee@linaro.org, berrange@redhat.com
References: <20240620201654.598024-1-rkir@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620201654.598024-1-rkir@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Roman,

On 20/6/24 22:16, Roman Kiryanov wrote:
> void* pointer arithmetic is a GCC extentension
> which could not be available in other build
> tools (e.g. C++). This changes removes this
> assumption.
> 
> Google-Bug-Id: 331190993

Again [*] I'm trying to figure what this tag is, no hit on
https://issuetracker.google.com/issues?q=id:331190993; is
this useful to commit it in the mainstream repository? So
far it is confusing me.

[*] 
https://lore.kernel.org/qemu-devel/e865d8e3-e768-4b1f-86d3-aeabe8f1d511@linaro.org/

> Change-Id: I5a064853429f627c17a9213910811dea4ced6174

Ditto, not useful.

Per 
https://lore.kernel.org/qemu-devel/4b3d0472-8b06-403a-9ab8-553aa858fb7f@redhat.com/
I wonder if this deserves a:
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>

> Signed-off-by: Roman Kiryanov <rkir@google.com>
> ---
> v2: renamed from "use char* for pointer arithmetic"
>      and removed all explicit extra cast with
>      one typedef in memory.h.
> 
>   include/exec/memory.h | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index b1713f30b8..b616338f05 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -2795,8 +2795,10 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
>   #define ARG1_DECL    AddressSpace *as
>   #include "exec/memory_ldst_phys.h.inc"
>   
> +typedef uint8_t *MemoryRegionCachePtr;
> +

What about:

   typedef uint8_t UnstructuredData;

>   struct MemoryRegionCache {
> -    void *ptr;
> +    MemoryRegionCachePtr ptr;

and:

       UnstructuredData *ptr;

?

>       hwaddr xlat;
>       hwaddr len;
>       FlatView *fv;


