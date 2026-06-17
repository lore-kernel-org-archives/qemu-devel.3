Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6662CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrfr-0003DY-QY; Wed, 17 Jun 2026 10:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrfd-00035t-3a
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:55:13 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrfb-00015F-Hf
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:55:12 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-36b900f350fso5380779a91.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781708110; x=1782312910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Vr31cE65wQcSvBCEDLaZvQRwDoBszk6YE7jc98hWGk=;
 b=V4I16wfdt9GWEuTWQ7fbSWWHSlrIAH5QTFzknOnry/CkSapA3VAHWKtJqXpLzJxq7i
 LrJBLfIHHPtW0wkgGorG/EgYxVc2RqsKgjfHGzsyV9bRBmGtOD215n31qzmGcchrCGOJ
 hJTRl/hNaMZ+Y37oEMXieu4esODP2TZGWnfsl9O5gSB5tM1ZhJXY00xFXpioEbZo1y75
 0kWy3t8tazhuH6aNUV9b97dA2HXcy+EpFv9qhdRwP9q6ZOOQ5MpAOfNlMWCWOVGP0vcF
 HKktR4/NASgqRg2ARXe6aBkL59G77hI3GGszkS9wWYJGjjb2y/RmsjvIab1HH+UJkisu
 IPrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708110; x=1782312910;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Vr31cE65wQcSvBCEDLaZvQRwDoBszk6YE7jc98hWGk=;
 b=V6H+acN36VjHEzzJ5BF6gr3F7gj1Z7vB31ixZXO1JzxpcoWKfRXsJOrUG+fyh0WOpV
 dT4Z8c83KTouXeIjnYjvh6xVYqprSbZ2HLssk5yhN+lXnQWlX887lji6viu4lwBYeWmi
 wkdsOG3GURZAdGoo12v+DXpUruo+XlnmZBzIzRGJ2xcitsdE35i12PhD4aPMfgLR/94R
 RJ0IvN6+X5YxtxftSkaw/U+KmWJuuLvNfAWmJFYTHO1J8rz0LBrn0tEFFRostcMmfriK
 R/3LUEMAYANSGnDxBA0sZSkUlxY7kkWeL3jtaAnWR/gfu8D//9taLwvUmBPI2DXUnuFl
 6cJw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MSUxEBKeuwFnP9lNlPlx9sfR9xeabs7i0ZEoyBs6OwTvu2FICOpwFYpYGe2NLami47h8BVlUGsyXJ@nongnu.org
X-Gm-Message-State: AOJu0YwVNxaQGiLD8F50CTu+tv4Jw6RnPQAWYfc0O+5tJbd1zuHMuaVz
 bNRmrvvZWC3JfGRFp9KE8AUS1InT2JgmNfRuG8h0XgvBMbq+UKfy+BKh/u4u8L4wZGo=
X-Gm-Gg: AfdE7cl0xbxl+jF/Ec0Dzrl+dUkvXbrZcZm9RxyQv5sb5KgnKAoqHijeyePBqKuZUR8
 czzpzPOyDxdvsAHlBLM9AyTh5b3LoC+imaGofkAHq7flrjHeAShj9M9yUC5doGo3diSigx82BWU
 XEGriKBucsxU5J+fwLom7LZsf+SS3ctvz7pen7EcZ6IQMXIhIGnhQtLVFOgYm+rfvCiDg+oX6Vd
 JmlGQo+QQ6kUHsRIH650oBMAr8VLelUcg1S0VE6zdkjkpwjLPYiCkF0ri1gPAA2tznZcfRlGNQi
 hiBOnDA0MHg0uGPqFsvF5e/HGUWURpBMPZfQvd11wXQvn/j8OSWVTJlS7d2Drhp2hJYq7XD2LzZ
 A16aeDLdsVM8bE8WXXvYPTJNQ9XSVid4M2CYQdD1Ax641sP3QxbPDubRf1by9aPjVu+2qtCKpFw
 OFtBwFdZAdvYLkhY5VCXPY0Nob5e5rVGzv65fhWl3iQUyaC5cE5/zhbxjh8w==
X-Received: by 2002:a17:90b:3d83:b0:36b:a2cc:485b with SMTP id
 98e67ed59e1d1-37c93952336mr4773937a91.21.1781708109897; 
 Wed, 17 Jun 2026 07:55:09 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37ca1dbc8c9sm1935049a91.2.2026.06.17.07.55.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:55:09 -0700 (PDT)
Message-ID: <147c12fa-e38b-4f4c-8365-d1632bddd909@linaro.org>
Date: Wed, 17 Jun 2026 07:55:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] accel/tcg: Move cpu_unwind_state_data() out of
 'exec/cpu-common.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-7-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-7-philmd@oss.qualcomm.com>
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Move the TCG-specific cpu_unwind_state_data() declaration out
> of the generic "exec/cpu-common.h" header, to the recently
> created "accel/tcg/cpu-loop.h" one.
> 
> Include "accel/tcg/cpu-loop.h" where appropriate.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@oss.qualcomm.com>
> ---
>   include/accel/tcg/cpu-loop.h | 13 +++++++++++++
>   include/exec/cpu-common.h    | 13 -------------
>   accel/tcg/translate-all.c    |  1 +
>   target/i386/helper.c         |  1 +
>   target/or1k/sys_helper.c     |  1 +
>   target/riscv/csr.c           |  1 +
>   6 files changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

