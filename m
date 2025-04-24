Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A37A9C369D1
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7sWU-0001Jw-Gg; Thu, 24 Apr 2025 05:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7sWG-0001Gt-Vf
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:05:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7sWF-0006GL-39
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:05:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39ac9aea656so954671f8f.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745485516; x=1746090316; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kad9AgBt2raRN1OaqGVXm+qjoVjHqNUy6Qkffqk4Q/E=;
 b=sN44PIdp97T7tqW1m1TNs0JMR3g1Ji7vSuFiZ5bArgk3JEKxpE+STX6RsiVjit9/bC
 Qg0rXuvm7vAVdk66RLTPIHeD+IIiyUMNI09yutnHGiOD/QmCbJdEgLdNekeJZBjnlHVr
 9kAFpFTccT3EEq5F8IkPkzZnq1GQ8ZIjUMJHHC3L/yeedXwtjUmSSR/Hc+oQK9T4DmE+
 Z4BWuJS5jsr8RM6zTYsZ4IOkLs0Ky8p/dJOWZXyFce1v9eAht1s0UcSsfbwTyv6nW3wQ
 pHRGWPj8HQMyFhYD/tNFzYU+5oLm3eLsXR2ZLuIUL+GxwFwppM7cstayttZ/q4xuX4bY
 GzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745485516; x=1746090316;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kad9AgBt2raRN1OaqGVXm+qjoVjHqNUy6Qkffqk4Q/E=;
 b=IRKRlbw7pYVMX3bqeYOlWwlJIkeBilJelHwIG6o/764WPkVk+1ySyEghyItEHqs11P
 Hc1MSQE/7Atez9zJnXodxZlhtqcctIr5PhUQnKBnXwOgzg6mtgVWBse8hPi3WDBXKArt
 2jwflxsuVvrtHW4x0C8mpvOKq/uw0dbPVZpn+NL+Uf/8DC2x4AdX2tLrGz76cYTFEWOm
 mViOfm7Nfp2Cu/8DXxwgHIXmTX9WF6uMmYesqTtHClGIQ4Eb3KalRbMUQ/H1aXCaCud4
 fm7pWi+Zn5eHVV0ujQPZzqyyFOqelsLe1nyMhk50eN4X0iTgbsdOBkr2Y2+sx+TtrUtQ
 pguw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW50A9Wzvdir9cDFfC47gAzpKxByHZyHY3uJmY/Ie8kSuutcbEo9kRghJlT5EAmSSnOnAOzFcdR19lT@nongnu.org
X-Gm-Message-State: AOJu0Yw4QkBaHBSc1QKpKLjkqT8IOTT59Cn9QSkocGd+cqrmeLoNExEF
 kXKd6abtWzFcexvulAQ9/R27kfjbxG/86G6r/hjahAP7kKCfy+N4L0n05OnuiJY=
X-Gm-Gg: ASbGncsLTI984OvZUmzGlIIUOEUvvSPNF7TXI/lGePIJmHTYic9g6z7XGbC7WV1F+iR
 NVvjtQGFEOOJc1m/SasE3iS3ElPURc/KzIk+UQ9D/sRPvA0/oFKVn1tEHXF4FsCLT3/VUWrtcZQ
 5ANvpGcWYsXSJA7aA77H52YXvYqGOcwrFEl7E0ilzY0LDBzCyiJNHGWqTtFYaSJOgAnMSA2w53J
 GMZEUoipIWQ6HfMNACNDufy911QTxkwqpct8OeR2eR4a9rK+O9OztuYKAtfEbftMqDx7JLhgckS
 LEbh3K05SC+Xfg5A9Ghubm8TjApN4U2j91867s6tRwvYS82cAL9GmBmGB7kCPcmryia+uwXjORS
 3TU9LRy3999FJbg==
X-Google-Smtp-Source: AGHT+IGnfQ/ZaJWjAf+XEBNm2JyxNCWc2GR4dQEUH35DEc5tomlLnmaowIWVRGdii/QZ/xwTrDLu9w==
X-Received: by 2002:a5d:64c7:0:b0:39e:cbc7:ad45 with SMTP id
 ffacd0b85a97d-3a06cfb2495mr1239729f8f.52.1745485515845; 
 Thu, 24 Apr 2025 02:05:15 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d54f019sm1405155f8f.96.2025.04.24.02.05.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 02:05:15 -0700 (PDT)
Message-ID: <89d11d6d-af2a-4afe-a820-6b0d58810270@linaro.org>
Date: Thu, 24 Apr 2025 11:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] accel/tcg: Use vaddr for walk_memory_regions
 callback
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250424011918.599958-1-richard.henderson@linaro.org>
 <20250424011918.599958-13-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250424011918.599958-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 24/4/25 03:19, Richard Henderson wrote:
> Use vaddr instead of target_ulong.  At the same time,
> use int instead of unsigned long for flags, to match
> page_set_flags().
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/user/page-protection.h |  4 +---
>   accel/tcg/user-exec.c          | 10 +++++-----
>   linux-user/elfload.c           | 19 +++++++++----------
>   linux-user/syscall.c           |  8 ++++----
>   4 files changed, 19 insertions(+), 22 deletions(-)
> 
> diff --git a/include/user/page-protection.h b/include/user/page-protection.h
> index 1de72e31e6..55aa05ce24 100644
> --- a/include/user/page-protection.h
> +++ b/include/user/page-protection.h
> @@ -88,9 +88,7 @@ target_ulong page_find_range_empty(target_ulong min, target_ulong max,
>   __attribute__((returns_nonnull))
>   void *page_get_target_data(target_ulong address);
>   
> -typedef int (*walk_memory_regions_fn)(void *, target_ulong,
> -                                      target_ulong, unsigned long);
> -
> +typedef int (*walk_memory_regions_fn)(void *, vaddr, vaddr, int);
>   int walk_memory_regions(void *, walk_memory_regions_fn);

Noticed while bisecting another work based on your series, we need
to include "exec/vaddr.h" in this patch (not the following one).

