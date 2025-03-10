Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292BFC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 16:31:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trg1Q-0007Mj-CY; Mon, 10 Mar 2025 12:30:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trg1H-0007Kt-FJ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:30:30 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trg1A-00032b-9t
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 12:30:21 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2ff04f36fd2so7483909a91.1
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741624212; x=1742229012; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=f2ETP6WbxnfeK4YhNdEE8fL94aFKp73vbBTbozuSJZw=;
 b=vla43MyFDJkWlEEPC/1hfVHugc3H/lJbpa7eFowHkiGpamE68722VhGaD36ySsn3Ak
 mASaLBHLDcXE3Xj/fPDGiJ+IMqFB543HHzzu4EWsjHxCNxNQ+IXlONC1/scmkPgtoe8l
 8HxmHsi7Qy15FpxSAJFEpfLcTBE8+/Tr08Z4VksIFx5XGVmENSQTYIdVr/EuBnsHbp/m
 sHHaFp8UqmNkQEDpG2yJahbdp5ArpuGEJd7wqyA24onWv4oIkQv2wGcrv/LP5kkX/4bw
 rnZpPXGOuaNm96VyBuzQYYsU60gOMDq9keUMfq5ig+3Ti1cUkMUIuUmUAu4OiOanJTG4
 BFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741624212; x=1742229012;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f2ETP6WbxnfeK4YhNdEE8fL94aFKp73vbBTbozuSJZw=;
 b=DNixPtephlZk8Y8OVuxUTbr5mjsaZdNkgCGzGWpkkB+fDvynn9p2HFOGxuo+lzz9qr
 EQtvCB684O2EUvpWuKC1ZE11L1gbFfSrHCVxATheQEP9hnJ3PB+Cw6bDw5GN7Z1ZhFP6
 gAyzLay0HTr35Q0QcIi0I+JlVHQP1YqpbOSCTGj+h1JVrM/pPP+1LuivVOJXiftGdHvd
 YquJ43nEdciV+zEhhl3sOcsNdrPWkXYRk82vBYUC4fv56r4S63ipW0/0YXbDJnFGkt0d
 lUo7aEm6Ub7OPB0FMpyDMHEtfGTa0wVqhqgJd5bHMfjz1sSMT7HL+m3CQUOA/grFIkge
 aBKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXl7+QJUyaB7KEivhPQ3GbGfo6+aqUsXMTK+q80WatHUxijUXgK5jfugRWgiOBPkFnkSifLsMK/9xiD@nongnu.org
X-Gm-Message-State: AOJu0YwchsYrT87NwFBUYNOItQ82e69o9zjQTLaS6lQ6Uk+/XKW6SD7q
 +ENKlmOu2dzLG3fqRu5SDid7oHwICJhoX3/c0NU4A9oW0da6srGUY5T81J1h0y5hmPd69GH1/I0
 P
X-Gm-Gg: ASbGnctCtog3OdK+S5/3KKm/npuUEU0DH6xnZaxLJpo93zCzFH9Wa3FthJcBmm0I0YN
 DKSBLhq3J69q7hF5IWAbwFIFp1Y5JjkS+e3sa5ybJccLp3/ONejYGp+uliNzbr3HShPWwh01My6
 //NwOkFNyZMC8n6w+6HQ1JjDiVH8q60yD042/R3rU1hs3oBDxaOOcsEDuPRD8G1ILKPYJuZZp+u
 7VCEVD4JaV+NrEbeRhSx+XHqSlFCkgu63pei64x7HduDhk14FW2at2pI/AhdvKU7Yg3yJVyfoEQ
 jBCkNWfW3CKaMGN2vh0PUJlP98h4+8Sta6ROMtnuRo96ScK4hShAZd8qW3KllOUwOD8tOBVSGIU
 o1GXMyCSF
X-Google-Smtp-Source: AGHT+IGRryCiobWr4Aya6KaIMI/xXj69YIrqgfNPLMtmHWTc3n3lWNhFW9T/mjtSmOL1Hr34ADNwVQ==
X-Received: by 2002:a05:6a20:72a5:b0:1f3:3538:6e9 with SMTP id
 adf61e73a8af0-1f544ad830dmr27174859637.7.1741624210250; 
 Mon, 10 Mar 2025 09:30:10 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af2810930b3sm7838717a12.29.2025.03.10.09.30.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 09:30:09 -0700 (PDT)
Message-ID: <ad2229d3-cd42-47e0-bd96-4134fca9d950@linaro.org>
Date: Mon, 10 Mar 2025 09:30:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/16] exec/memory.h: make devend_memop target agnostic
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250310045842.2650784-5-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 3/9/25 21:58, Pierrick Bouvier wrote:
> Will allow to make system/memory.c common later.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/exec/memory.h | 12 +++++-------
>   1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 7c20f36a312..698179b26d2 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -3164,25 +3164,23 @@ address_space_write_cached(MemoryRegionCache *cache, hwaddr addr,
>   MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
>                                 uint8_t c, hwaddr len, MemTxAttrs attrs);
>   
> -#ifdef COMPILING_PER_TARGET
>   /* enum device_endian to MemOp.  */
>   static inline MemOp devend_memop(enum device_endian end)
>   {
>       QEMU_BUILD_BUG_ON(DEVICE_HOST_ENDIAN != DEVICE_LITTLE_ENDIAN &&
>                         DEVICE_HOST_ENDIAN != DEVICE_BIG_ENDIAN);
>   
> -#if HOST_BIG_ENDIAN != TARGET_BIG_ENDIAN
> -    /* Swap if non-host endianness or native (target) endianness */
> -    return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
> -#else
> +    if (HOST_BIG_ENDIAN != target_words_bigendian()) {
> +        /* Swap if non-host endianness or native (target) endianness */
> +        return (end == DEVICE_HOST_ENDIAN) ? 0 : MO_BSWAP;
> +    }
> +
>       const int non_host_endianness =
>           DEVICE_LITTLE_ENDIAN ^ DEVICE_BIG_ENDIAN ^ DEVICE_HOST_ENDIAN;
>   
>       /* In this case, native (target) endianness needs no swap.  */
>       return (end == non_host_endianness) ? MO_BSWAP : 0;
> -#endif
>   }
> -#endif /* COMPILING_PER_TARGET */

Someone (me?) was trying to be overly clever here.
We can simplify this function and conditionally avoid the function call:

     bool big_endian = (end == DEVICE_NATIVE_ENDIAN
                        ? target_words_bigendian()
                        : end == DEVICE_BIG_ENDIAN);
     return big_endian ? MO_BE : MO_LE;


r~

