Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700BBE93815
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8tr-0000Sk-Tc; Mon, 13 Apr 2026 00:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8tq-0000Sc-SF
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:27:50 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8tp-0007hU-Bk
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:27:50 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3590042fa8eso2863733a91.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776054467; x=1776659267; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=REp4o0nqNpm6oVcAHhXoywGLJri4wg4I16AMsv3bAWY=;
 b=mcSRmSV4hQ/Ru555oqzKlfKtLL9hKO2hcqzIYOj8BtNPUikphmQkkt6G7h7pPqI9PJ
 jjnvy3DvQb+knkdV+fatbjNy01nx7BbcjhDVzDm7WzStlko4w/wcgnR+nrFwdpWwH7mS
 4wBKH8fFEsxhGbCHskB6ANRXp6rGswvNZ+EsZ+NuCBWA16rFOPJY9OnLygtQrYlZMzUA
 pZw49aOwzHMfRp4QwOGU/rD5AsWbGLxFm0+7fXE6y1mmNesIee3YwxLxwenpVXO6zpZB
 JUhMnGVX+aUS95PQRni2fhMq64fuI1IIPx5wnBgwG3mUUfS878UobyeZs+QL5Gh/ERRD
 F9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776054467; x=1776659267;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=REp4o0nqNpm6oVcAHhXoywGLJri4wg4I16AMsv3bAWY=;
 b=PAUA0xKsYdLp9ciY/TVeDAN7kbTeI9mFNd8F2mcSYrsshSqKr1oZ2vSC29Xd+CsbiA
 VCJ4g5AUu4D4IJoq6xImyCyB6SFAUHLSIryQ0voGdBYrFqGwDI2LzBvzo6uDf9lOpDRn
 1jE5psMgUYvJXX3P8VgjPyGXEU5Udcf5aJPhnsrCmlzf1C3z+WiWhVigWSlJKpCb9Isx
 CY38AQUP0voHluVKWjobAhC3SeVUpX7Exv+7KScdCLORpvKi4Q4IYzVvwqQeOgBHdc24
 BkR9349GpwoLyhacH1m8Lut6H7BjQ392uFLlF28gxLWGhrFE6JcFX96qVUiLEFV6oQPd
 WlOQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8i97g4j8QaAvMXjZv7szA8ReXiqej3UvtqOGkeX5VuA6jAlVIm0rm7b/6v7s0Uo6Uo8nTSKx13iZ60@nongnu.org
X-Gm-Message-State: AOJu0YwzX/715G8C+xVS1yTrTH1MGCHaFKzSqQ4LUN/ePmHr+CGFBhpu
 2XYf+CZCf6ai00x6VEHn5mswAH/RLklqJw8/yLa1C9kiA5iIQ5MtuWb9+r8Sm5hkDCg=
X-Gm-Gg: AeBDiesJPsuMvK5BaZnhUNvRg0rBTg66g8bmVgG0uEwPqwnu9pipejiC683aUHsKIgl
 jf+DzXe9xbP+qQwtP6sw+k36OrY8JoRHsUXa1sKHDsiNHYZmmhyGUHchKnZznU+t00PuNIl3cGM
 haEzjziPSAHeqNgSJhQz6IoSep2+UnySfWAGvDPm0EY9wSbL8lnlXGOUulIhsbt6RCsv1rhr5Et
 lEnyXwztRsAzSg5x9/FW2CtX6ilVOmyUc8WcCCxUZivcZLD6IEE0M79JCBi4xt1H+2JyQlE11BI
 VD6txppn1fi8EBAq53CHIC92eRgwmWqftIziS3QQr/lx7sK34/SCMwCOib1XeVUcP45DoNzzP7w
 dx9LzcO7Wa3fqJL4l4FiDerKBmuqQ7t3EjLME0Kar34lY5N3wehgtg7Qqgdx1ndzwYovvnlHbUO
 7KtLfVXBxr5o5ZeKIFTs8k4epmQkaKfhNyrrslgC6uwRXAo9A/nXysYZeoLH0roD95pjxDzq6g6
 qeJFbqfbLMpQ4E2lxJ93bfcPd/QHbYwEW8KyhjR+DiTE9SW/hgRVX0=
X-Received: by 2002:a17:90b:3f0e:b0:35d:997c:8ebf with SMTP id
 98e67ed59e1d1-35e4285b69bmr11928923a91.21.1776054466879; 
 Sun, 12 Apr 2026 21:27:46 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35e42e84b8csm4467464a91.6.2026.04.12.21.27.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:27:46 -0700 (PDT)
Message-ID: <b2e14809-2f25-4f09-a8a8-e51facc49874@linaro.org>
Date: Mon, 13 Apr 2026 14:27:40 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/27] system: Expose 'arch_init.h' as
 'qemu/target-arch-defs.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> We already have a file unit outside of the local system'
> folder which include "system/arch_init.h". We want more files
> to use it, so make it official it is a generic header by moving
> it under include. Rename as "qemu/base-arch-defs.h" which is
> more descriptive.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   system/arch_init.h => include/qemu/base-arch-defs.h | 10 ++++++++--
>   hw/pci/pci.c                                        |  2 +-
>   system/arch_init.c                                  |  2 +-
>   system/qdev-monitor.c                               |  2 +-
>   system/vl.c                                         |  2 +-
>   5 files changed, 12 insertions(+), 6 deletions(-)
>   rename system/arch_init.h => include/qemu/base-arch-defs.h (92%)

$subject no longer matches patch.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

