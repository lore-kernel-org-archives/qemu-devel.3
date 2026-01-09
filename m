Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02E5D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve78p-0006sS-CZ; Fri, 09 Jan 2026 02:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve78l-0006pT-12
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:42:36 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve78i-0001dS-UI
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:42:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-477770019e4so31619795e9.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944549; x=1768549349; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hBpfBR/fKWAq2GEGZ2wzyp3b+bV8MVYMqEsaxsqTMGk=;
 b=UCXGmZJyTGx1nSeFW2yrZFyteDZphE2APFqM/7ygH5Py0G+MjQPSphWOq6n1Rlyj2L
 FpfuLA/7P95zgrXIQrn7bYlajcpjit/GRMz1488mwDZiDu7cOk04osQ6f760Arn7nBDh
 WV4NgCRLW/vzwr7Ks279trB8mh5+ahoU/6vlTPH5fTsKAYUnc7N1Jb7lvtAV6vs0lyNg
 TkimTIQfzFtTvoMF3fp5OxKa3jnIupiEf33WLLC9uPGONF0fUAQr/gLl0KN8q5YgZxj5
 5dRVMTilQF4aXeA/ywlgW9LSOxd3HrBM6AR1sGe5TQ2dZOp0MKrwu2T7qo/FQ+DUSKb1
 RV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944549; x=1768549349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hBpfBR/fKWAq2GEGZ2wzyp3b+bV8MVYMqEsaxsqTMGk=;
 b=v7N4xhuere71ku/Po+bVRpXL4nKqrQ/rCBOzIkW/OvZRX/J6R+jqAHSHgXd+Mq/5xq
 VigjmcHW9WDiVMd97XBa5E38k6ZbV+4aKS8td7fs5o/ZoUr84XzCfspnde/ShYRZM0yL
 qV3qffCU97baSyzDzwbgQXPP/OZEw5WxDHB+Arno7z/eT2AH2kVcHAWo2ToVMul7p5Cn
 h7b6pN92Wd8FVHhsQnUkCEqN0HSYwvhOYujejTJhYJBMjOObgz26KedQNKNSLIA79grG
 Th59gz0ZsIZK/LEOfhZU+09e3rGUoaud7SbLpIQFcIzv3wPJiuxTfa1i/V/tdaa9gxWI
 b6NQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZck1+Vj3pbr2ncwgDriSwBPVTvHnh/GLWrL1YJ42GB0DoP8iwTJIjY78zie5mWDgKH+R21Kvi1QK4@nongnu.org
X-Gm-Message-State: AOJu0Yy10SkWmmKprvCi9FxPvjt9Sz7nh35/yQqGuoZr1lYrUBtO4e2K
 tH2ouep+PLqZeDjgm1FB6p3FXm92JJP8dxf4X++EDVwWsy+KaArajsG3RIju+cUUGpSbkCOCaE2
 JP9yA9CE=
X-Gm-Gg: AY/fxX5lOgzfss1Z+Y46DckBally2fzWvSGQnBiA+ASyzeDXKbCmQKVBAaQ1ZqA2sbs
 FAPWpiKgq8ue66iVB0AtEaaWwAlAB3GNiYTJk//RRT90ob+tdhfgIdmo59os3DmrEaiYduMtlI/
 EtbZZhA6AYRwDAHtzosWnsoCSiTunXDodmJW4aRwwdIQ+MI+KO/zLUtN2pVYcHUksOwjHv6bdwz
 jgeq3jAaPybBS0LshUue4TPhfooLMcw88T+SMCQlOapMxxM6qnpfYT1KjP5cCUH2t/Z0PlY8bEo
 2CQKMi+/1AYsTePHh6+1i6PHwpIgcwr5TkhakCLtck7IIFHhulUkmKv6jdqgHcylkJK0+bLcLwg
 /KGGLTTu8FQgwB7XsXdiWqiRr758XZKMERL8V3d5NI6ITHysPD2lOkojdwKgn5+4b7gMYipzr1h
 pkBYYbh5YSv1+0lRrSfWrlFzcYAnuP3MDNV1NPYBT9XY+WqOv60J8wAA==
X-Google-Smtp-Source: AGHT+IGoQ7lj0cwfm8DWyjeVKUw4NAiL6lVZM9nz5gJn5kT40LV06koOHv34lz469KtYAqUHLwUqXQ==
X-Received: by 2002:a05:600c:a48:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-47d84b08652mr100538315e9.8.1767944549362; 
 Thu, 08 Jan 2026 23:42:29 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm201401515e9.14.2026.01.08.23.42.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:42:28 -0800 (PST)
Message-ID: <50a15b2e-dfb5-41d5-b7e8-ed0a74bdc9fd@linaro.org>
Date: Fri, 9 Jan 2026 08:42:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/29] include/gdbstub/helpers.h: allow header to be
 called from common code
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> Target specific variants can't be used in common code, thus limit their
> definition to COMPILING_PER_TARGET.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/gdbstub/helpers.h | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


