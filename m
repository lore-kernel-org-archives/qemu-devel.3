Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B317FC5DF67
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2026 20:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvKxE-0006eO-56; Sat, 15 Aug 2026 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKxB-0006dn-9s
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:26:05 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wvKx9-0006ZF-IA
 for qemu-devel@nongnu.org; Sat, 15 Aug 2026 16:26:05 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so2535632a91.3
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2026 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786825561; x=1787430361; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pBxM9m9s6Bz7E3+auaAPczbCUjWxZAbi7xgEGKG/HDE=;
 b=q4YV4tKp6JSmlMidOSvNC+0RixuWAY3Jkve+rL+S9Tel5aiqWQx+PCyV0wCIgI+sLj
 jqK9+uGlxMkbaAdOIMZ9tsrP7pkWAKTI5x6Cnq95k7fUmBkg3JxVf1iDQJS0QeMEaJg2
 bm0zIQS/TnlRVMDPc3OvCyas6YP4euUCGh7nXM2nnXb3PchxSP4uke+HoiU5R57toEDA
 rr86Hae1X/gmWltBT0z7BqCl2evnPBUyZDLLXyFetFpxs/2X09muBEg49UuWmPT5UWNX
 ilI4XnL3Lpk7YsWL4f16xMIdCt8vurSb2DJbHJ0A0vRb0k+yviYtMADRryiyEhcTnyIH
 XZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786825561; x=1787430361;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pBxM9m9s6Bz7E3+auaAPczbCUjWxZAbi7xgEGKG/HDE=;
 b=R6pMlgVFYkr4xkh/fHCoK8EKe5fdWOkg15aYq4DVdGzg3aKYK8ltqsoiAu22ObSZjy
 +l9r+40CJggE8uM7GwJS3vnfdqQFD58jVrw/msfKaLzoR/sQ6fCHoNvJ/Ws7PZt/3hj7
 idVjw1hlsFwujMnq1ervrH2KGRgk1oeZLGsriROuJMMGr+x6iaPbGq3ym6R1qF41uMFu
 9vLLDLE9mMiYZ4xKreRccZK7WI8oJ9j8yO69GELIc6duHMxUmfAqyOlQWMt8xT8/Aasn
 +u0dj2l1rKz3SrNdKPuFysmScOH7aIzs6P/UGkdXJLhAggTvof7SU0FBpwX+Ii9nBDWs
 05gw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqe0SyUbX0r0uUe84QKC3L22hsGDwrJhmUPPxQYLo9RUFsvY+5RBWIjYxA76sHjETGx0RYt3GkYAAqw@nongnu.org
X-Gm-Message-State: AOJu0YyPm+D5omIy5QBKEIJ1WRevRswkEOsNojy8iwDvucpPlNCokE7H
 QJ72pwwJlezIK58Uj6BOEFVUWCyKSIIOF3eFB1ksYMqEU9DEYiexf/YTMT87qwk2PMI=
X-Gm-Gg: AR+sD116pA2Zjd+e/dREYjTL30IOeDC2aNu2tNCFG2fXoikmCWFS+NTFXckDe6OyeWD
 m5I25wNrjDbBH5QTJ67BxDC256bLM7ydMzaSdq8j1pyN80leNTOqaH2J+NrzMv+6JL3Q9Umed25
 7xkjmkp3UubVjZPRuaasRpcShUgDJXpapoDmcou6t9H+lF4aNG4FIbLy7hqXQp8nxsJU7hAieuC
 nN0BbHbxNS6uh4tPIkII2w5yAJlqLl883FUiELil6p4BF+2vGRlM54iQOgNqRIr5PQ8fFLTBW4o
 xDHhoXGgPInMr0aSInxVRgDeWJH5nHhEjOfznuP//o5kkz6XSN+RnFMj2PpzERlrXgNsKM2urkz
 wpADzVo50iFVN2KOoCtTbKnrfuvdicG9yE1pGZVXIR58BZuqrwMoF0xiSz3R6Xjv8fRd5WbLVzZ
 hptM78B856u5dLcWjthX5kA8ZXt0ahNrD+D+D0QSMsCrxDFOy4GjbFS50AqRgqhG78XZnFQjzie
 lqqiuh1ojQeOgN4B4djU1vFs+j3
X-Received: by 2002:a17:90b:2e4c:b0:390:b41a:b92a with SMTP id
 98e67ed59e1d1-3933bd0d632mr17689188a91.4.1786825561529; 
 Sat, 15 Aug 2026 13:26:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-394ebc32b24sm7044790a91.17.2026.08.15.13.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2026 13:26:01 -0700 (PDT)
Message-ID: <93865ad4-3c26-45ca-b364-e656707e910d@linaro.org>
Date: Sat, 15 Aug 2026 13:25:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: Define ram_addr_t to be always uint64_t
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260814134035.2733355-1-peterx@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260814134035.2733355-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 8/14/26 06:40, Peter Xu wrote:
> QEMU's 32bit host support was deprecated since 10.0 and removed in 11.0, at
> least the system emulation part.  Now it's safe to move ram_addr_t
> completely over to uint64_t.
> 
> It should be almost the same as uintptr_t as before for !Xen, except that
> on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
> differently, causing unnecessary compiler warnings when use them in a
> mixture way.
> 
> Hopefully, this change also makes it clear that ram_addr_t is never used as
> a host pointer in any form, but only an internal QEMU integer based address
> space for allocating ramblocks.
> 
> [1]https://lore.kernel.org/r/d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com
> 
> Cc: Paolo Bonzini<pbonzini@redhat.com>
> Cc: Philippe Mathieu-Daudé<philmd@mailo.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> Signed-off-by: Peter Xu<peterx@redhat.com>
> ---
>   include/system/ram_addr.h | 6 ------
>   1 file changed, 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

