Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8E8C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 17:08:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ticgx-0005fy-Er; Thu, 13 Feb 2025 12:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticgl-0005b8-Ki
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:07:48 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ticgj-0007kD-1m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 12:07:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-21f5660c2fdso22578355ad.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 09:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739466463; x=1740071263; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hdethikXwyRz+mQEsAQ1E0OnS/aHytDFjG9V1yOug5I=;
 b=wXv6bgpcAezJVaxlbCm4HazamPphHuCYMftjbOw267Rw5Q8GdwXYtxp3LsDe/EeIEr
 X9bLc/WCyK61UwVCfuA3wF+lnp0ZlVoFtfC7DVi3uo7wKSO0wZ/3qbyZMdrlbf+jS/fT
 VcBZRqtp29oTX5pA9yXdj8ATc96I3CMnyd6OCKKvNpDHwmvNocdM/MN5ycjmgnT0wsXv
 pjJVLNlnmU7zWkK/Pm6V2xt/lInyoa2wSs75VN2n+AkznMhzoQc5GQmem79/48bZuD6l
 8SGubWF5v7SbZhC0ORZBNYg3xKlg0PYdNKTRoe9fxMxDu4YXePI7+3ToS0zYKT6758Qz
 8LXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739466463; x=1740071263;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hdethikXwyRz+mQEsAQ1E0OnS/aHytDFjG9V1yOug5I=;
 b=uo+7uKIAey6cStpbosxR4W9Hvn6NsUZz5llIjqzSk5aHQnb4FDeyC1MKZnboKtTewD
 nDcpyzYQmyCrd+nJ50jwQ2Z96A1tb013a3ztn04FnHo1pEMacNpInLpA7yxDn6mkXmBc
 hz0+GbDVyusoHadXrNGdHLSXFXVdzlQfcJqB0kKar0WOzZXB6TKizlxWkXlDK8u5j09h
 dwPT4tXe2HUElAerCBKJEtK95Zg8Vch8pRJkPLOcO30ksVZjURbPrthYVK+p/VY/v1cA
 GvPkvKk8bYnAakxIoe1UNgHrpMn9FHaSApQbI/p4xRt81eXSnQZ+IpzUNeJ7pGLMqvsY
 TPWw==
X-Gm-Message-State: AOJu0YzTflA8NIjGOLasoD5z6+fPCfXe5o1Vzx7Kz/Mi1D7YYu+komSP
 tn30KgjLu5BcmGGWgVc1bDHjb5iQClvfS3KMs28jr4X0QcqBGba1hgoLSP22myRuKSwF3keUEg7
 w
X-Gm-Gg: ASbGncuaAl+OOCbPvVicVm0Iu+8uO2zRaAG1IXj7PIiituAUR96uS3z+YBluTXg/JLw
 QiTBkedKli6R8HcO9WFMKN6zE6jfl0sTfS0+3ec6VBZH8P1B93bme6U1EQA5cVo1yOFNoHmeRmL
 L30pGv1wedbwmwagmP9RqfCycALKdHZ5y6mi0hwvIYr7L1gu/StONV/iZkAcDTxD4eZG4sZGeMX
 7+qL02cc5bPuRskWnGMKhQOpE8b23ZIgR2nQASTVPNfyn9+VlPfowFIHzulpCFQxcWqFU8w0zHE
 RdGwWQU1iLnZwS5B4PzjAonHWwxcKXub4Htmg/6CiZpYiB/lpd+T7FA=
X-Google-Smtp-Source: AGHT+IGIV+KmrljIcXGs41OICv1vGftVwHzQkvN+898BhCmeO+6IfhmUfZXpUA7bY2LEhc+qNVCDMg==
X-Received: by 2002:a05:6a21:394c:b0:1ee:6659:29ec with SMTP id
 adf61e73a8af0-1ee6b318bffmr7934410637.25.1739466463099; 
 Thu, 13 Feb 2025 09:07:43 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73242568a1asm1516514b3a.39.2025.02.13.09.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 09:07:42 -0800 (PST)
Message-ID: <740dbe39-6a4f-4c2f-bb00-d61f1563fc36@linaro.org>
Date: Thu, 13 Feb 2025 09:07:41 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] hw/ssi/xilinx_spi: Make device endianness
 configurable
To: qemu-devel@nongnu.org
References: <20250213122217.62654-1-philmd@linaro.org>
 <20250213122217.62654-7-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250213122217.62654-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

On 2/13/25 04:22, Philippe Mathieu-Daudé wrote:
> Replace the DEVICE_NATIVE_ENDIAN MemoryRegionOps by a pair of
> DEVICE_LITTLE_ENDIAN / DEVICE_BIG_ENDIAN.
> 
> Add the "endianness" property to select the device endianness.
> This property is unspecified by default, and machines need to
> make it explicit.
> 
> Set the proper endianness on the single machine using the
> device.
> 
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c |  1 +
>   hw/ssi/xilinx_spi.c                 | 32 +++++++++++++++++++++--------
>   2 files changed, 24 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

