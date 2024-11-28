Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E0ED70DEE
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 21:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGleX-0002T5-LX; Thu, 28 Nov 2024 16:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGleW-0002Sq-CH
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:02:20 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tGleU-0000kk-OV
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:02:20 -0500
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-71d54fc1944so549042a34.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 13:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732827737; x=1733432537; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wrp1FMfR3Ck+2oNteCaZhAzEHUvhfweRiMI3/rAKUt0=;
 b=t/UoYOjzEGrR50ysMu2VIoaE2lYcw0MVZR4mBjXW5k5jmYx9HV4vtAxesSBmqD8gOO
 /JPW2HUloFQ7GlcwnLfqz6IJPsIBVLOHipHcRn+euHUsLgzFvM0JTLR2ns3/GAo7pFXZ
 1MxDmczw1K/eM4Lp2UXURfoTJ+L6uaZ9B/UWU5ET2Y3vfOSZyTN7v3q7WjcPS5AW+CXy
 jBbrCJEGUZn1liU8iAH8YbKukEaUcUr3RlLY6TiJbSttDHZIHpBmkn4ekSqj4WepAPHI
 yPvEivi2AUG2z3jN6ZjmF0qI6QVT0YFeaArCmp5/B3xdw2KooAHwLTEstN4jMcKzCld5
 odUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732827737; x=1733432537;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wrp1FMfR3Ck+2oNteCaZhAzEHUvhfweRiMI3/rAKUt0=;
 b=pb9Ob7GL7xzxdBO4RG3cx/D56panWFiP3ppcA9Bl06IxdYeHS8rR9Zg7R/ptM/77I0
 YCnBYu5Ji4hrcIgodgotMXR2jOn1X2HeREFYHRNyC6tQXdU9BkmHdCkVbIpNVoPXhvV8
 W1ACjuN2QXj4NBBuI8M0NbRiXTIp264AzyXkPmW+0uS6VGX5wveh0bMdIhtJG3xKf9vw
 eQGB+v9pZssc2pMUCNgdr8jgb/UWiP1LgX+I7WbipthChnSn6x5fBcjUNwLiwU+ebNmq
 SjzJXmDZy6ZhWr48oB22CB+Bz0fJqrdMzzHOL8o0/B1HJrpiEWAAqRhiXLNsodHA1XcC
 7cqw==
X-Gm-Message-State: AOJu0YztGdrJN55emf6umE6fS0nE93C/DtjNjz6eypblCcXoYPc4Lr/q
 WSBEoPPAYaoRFCHbq2ziKRYEnz2wvmlHYPYCsLg4tZ+1TEfy7AIPFbKWy1ax43Cgp7Nr7fnq4Ah
 EPpw=
X-Gm-Gg: ASbGncte1xnRYL51mGhGLitfL1qVKtrLEEoUBxwcfww+mBCkQf9XV6a5UWdQO6/VCXu
 mySavu9DxbjyON+UrbvSIJocPwI5fML0YEgkSvoMSqhFgnQqif6Jx5iH/U9/3jQf0AOkieFirhT
 78Uw63ScLCGt9GYsRZbKbU3MHH6iMX2mkP/d00LDVK7CKb+BVmsPDBYgZrWsR/Jq7qKSjcx+48k
 IndjLp3kOOc/2AyiZod4K1PmEXGpEIrTaINckbt8scpIn1VQU1vNPjOC/9KH5D/ZKg=
X-Google-Smtp-Source: AGHT+IGXYB4GMfHUtctF33z53+PWwDPIqE8L7GUIYDnvPhZGbWxDlq16f89AUnx34zQeLj5v7W4Jjg==
X-Received: by 2002:a05:6830:44a5:b0:71d:5249:59ab with SMTP id
 46e09a7af769-71d65c7b0c1mr6479125a34.6.1732827737449; 
 Thu, 28 Nov 2024 13:02:17 -0800 (PST)
Received: from [172.20.3.167] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71d725d873esm465622a34.54.2024.11.28.13.02.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2024 13:02:16 -0800 (PST)
Message-ID: <65b86333-3d97-4149-a33d-53372fd50004@linaro.org>
Date: Thu, 28 Nov 2024 15:02:14 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
To: qemu-devel@nongnu.org
References: <20241128201510.869974-1-pierrick.bouvier@linaro.org>
 <20241128201510.869974-3-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241128201510.869974-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x332.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 11/28/24 14:15, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   docs/devel/style.rst | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

> 
> diff --git a/docs/devel/style.rst b/docs/devel/style.rst
> index 2f68b500798..2d73e6a8f7a 100644
> --- a/docs/devel/style.rst
> +++ b/docs/devel/style.rst
> @@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
>   avoids problems with duplicated typedefs and reduces the need to include
>   headers from other headers.
>   
> +Bitfields
> +---------
> +
> +C bitfields can be a cause of non-portability issues, especially under windows
> +where `MSVC has a different way to lay them out than gcc
> +<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, and on big and
> +little endian hosts.
> +
> +For this reason, we disallow usage of bitfields in packed structures and in any
> +structures which are supposed to exactly match a specific layout in guest
> +memory. Some existing code may use it, and we carefully ensured the layout was
> +the one expected.
> +
> +We also suggest avoiding bitfields even in structures where the exact
> +layout does not matter, unless you can show that they provide a significant
> +memory usage or usability benefit.
> +
> +We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
> +for bitfields.
> +
>   Reserved namespaces in C and POSIX
>   ----------------------------------
>   


