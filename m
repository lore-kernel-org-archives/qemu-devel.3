Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5FDC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 19:49:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twRJ7-0003PW-6t; Sun, 23 Mar 2025 15:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRIw-0003Oa-1P
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:48:19 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1twRIu-0001PG-Bw
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 15:48:17 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2279915e06eso14548735ad.1
 for <qemu-devel@nongnu.org>; Sun, 23 Mar 2025 12:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742759295; x=1743364095; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sPEVhKH/q/YiDuR1n0MgtydSqyeu2nSJ5etPmOtkAlg=;
 b=C/LEptIvj5OJPv3/5sGUtHVqF7lBOpTz+fLheHhTUX3Vm/SLM+wGVtdwAa8lwimihA
 FovXrboIIdf5Srq7qbObA6UybNNeVAUTILZVeezhENC5Jiy+58VsVZ+fQ9oSVbocC9SN
 N498ca1Syhx/narQKKwMa7lnPTRQ/WeZOAlZN+bolpiAUsfe5/9njenQQT2BRQlvoHQx
 eDTUUhyDD4y+CBl2N0M7YFPw/ojfPSTaZMOlZ/Zoy5EQqlVbcKeW98FAxTCCOLOpERbY
 NOxwFCj1QUCw1/X8XKtGswehrZYWSY3KSuWj/+7Vrolx9iRsWIMBEUgxWEDFAp4sjdEP
 Ufpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742759295; x=1743364095;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sPEVhKH/q/YiDuR1n0MgtydSqyeu2nSJ5etPmOtkAlg=;
 b=HjttUnfRUza2UXuFd9YehnkPf2tIHEbOHsBk8OOfAPq7AgMg2qVlHME12Zt4FDB4J2
 fYspqyKeL1A+8sW3AkJ8vEDnJ3gYyqAG80Kmz173Npmu0I16nMd0ABsBM+BkhFMkwXo+
 4jyGcufmHzBoGkS68k8fTRy37qew1pNQqecjL50ymPZOnIjUwK+h7U0HewRaNsFT8SR6
 DcKeC1l9Bk7L8Y2H4LupRWPF1tfD49EU8bSD4Q3ypb3O8Brwv0D0TfC/gc+9A25wHjnK
 yLXI+5AV/B3lt9b32RrPFn+I++FhrTs0i/dIZQoxL6GL9vBc5BrTJE8oh5UGthsGX4if
 antw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKRhyJAMMe3rHR14QPAldoqUGqDyXMCuomic0HZ7onSvkFcZ42eKhQUI3U78E3p+nNy7dh64A7xJd8@nongnu.org
X-Gm-Message-State: AOJu0YzeCYtwbTzz0vtN8s1sYeUTQjzFAWors03OdgopdeYKD70n/qcY
 GAqDZSMZyB8rJVAiUsSPlhufZnI8G2VIWmBT/qfpvm9XWB0dK73vpmbVZe4lAvk=
X-Gm-Gg: ASbGncuacnKTSce2BCDOWOIAFQJqh250Jqp8Who+GdyaWi8l1fJ1WEJqFvN5JFUo7+1
 sUJ9q+rkiAy7eiLrBa2zGpiLi1lVfX/iX/mHSqRj7XSYfBmsKY4Vv4aLrPv449xu8bHVryLjIsn
 wM5MVV7NgKRAZcuiNS1vGMadbKjuyHCmLh4w+u+mt93qYLoaJcVNwJLxO6K+B/VRDboe9o9MtMF
 oMNaop0/WdVnW+2DK3fXeUS5D8f98SGx4DxybfxsdM3O7n3xfd20KwfDHn7DcWPKQQ2mKpmDNC2
 9cL9ImxHD3mn4j1eFZJapW1KmVcaNmdcI1PaZxf7srpEEKOLHh2Cha/dTPGDx/tG+6O0DtmGXso
 9+w8nL73o
X-Google-Smtp-Source: AGHT+IGS/XGShXsVnp9yePf8yBN/4F6cSRZ2vjCDtT3evXQqeQKUz31RxiGg0cYlDNvMmndLkLVSVw==
X-Received: by 2002:a05:6a20:430d:b0:1f5:8d8f:27aa with SMTP id
 adf61e73a8af0-1fe42f08eb7mr16397454637.8.1742759294672; 
 Sun, 23 Mar 2025 12:48:14 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af8a2a25dfcsm5566435a12.58.2025.03.23.12.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Mar 2025 12:48:14 -0700 (PDT)
Message-ID: <0c9055a3-2650-4802-a28c-e5d79052bc81@linaro.org>
Date: Sun, 23 Mar 2025 12:48:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/30] hw/arm/armv7m: prepare compilation unit to be
 common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
 <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250320223002.2915728-27-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/20/25 15:29, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/arm/armv7m.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index 98a69846119..c367c2dcb99 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -139,8 +139,9 @@ static MemTxResult v7m_sysreg_ns_write(void *opaque, hwaddr addr,
>       if (attrs.secure) {
>           /* S accesses to the alias act like NS accesses to the real region */
>           attrs.secure = 0;
> +        MemOp end = target_words_bigendian() ? MO_BE : MO_LE;
>           return memory_region_dispatch_write(mr, addr, value,
> -                                            size_memop(size) | MO_TE, attrs);
> +                                            size_memop(size) | end, attrs);

target_words_bigendian() is always false for arm system mode.
Just s/TE/LE/.


r~

