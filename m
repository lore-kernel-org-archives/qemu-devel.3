Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4926FC282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDxJ-0001qo-If; Thu, 06 Mar 2025 11:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqDx1-0001lf-4o
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:19:59 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqDwz-0002A8-Fi
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 11:19:58 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-223378e2b0dso13143095ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 08:19:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741277995; x=1741882795; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YyTTslkGZl/g2Xh5c93BjxA1h20vhJ1AQm8u4TqCtoc=;
 b=ju7gENEUnoW7wW4ypDLXZYfi5sto3CCa4Y3RcIgHJNiOGvb3jtF2aOKGpD5HdKjBu2
 dOjaTXwh0qJmmmITeTn4oaUVfClkH0gNKQ5yJS3pGl00zAaIhjdhbHI5RojW63+XQT4a
 XlcqwIpI4727tW9pC1d72bsbkv5jcCybne4ArsLcuL2lpQYL9mnTd05j/eLjGru7zsp5
 lFW1dM6wbOYBtYUCpotoUzqL9ljjWDw/AcgRs2eWvVZNKco72SgH9+2LURGkcmqQOYZ6
 v9x5uXegj3k6aBmuNaLesQ4r8hm24EJ3v3g9UTmsrga9RwViYcDF+P/Rpv+R0z1kdCkT
 FZGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741277995; x=1741882795;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YyTTslkGZl/g2Xh5c93BjxA1h20vhJ1AQm8u4TqCtoc=;
 b=osTOtN7h8qJIlO21nolvxHqrpQIpePqR55hxKCqfeRZxVNbfr20g0OpZeY1h5vw0/X
 H3sPun8/D09lEJ5/UKrhnPYWBSxrvatLNx8yMMO9H+2mUMgLaWORoK0UK7xZGTUhMiDe
 XhN4RNKBOHZ+/buU6ceb5xyjFfo8161Ph3x1CP044JOWrvN0Ji3ncsyijFfDP0BUUBSB
 Y9rEqNNCiSgZoR4kjkDONOwMyGCtRYzuprr02E+bmfluHYq08UTdU6y8VCKQW/GLXwWR
 yFvNCg//yEvvPPbg0uvil6oKA6+eqav3F6Pu6EhWzU6OMlZ0lsKAHiZ/Qd4K+sSvh8Bq
 Y1qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3dBrCiyLYgG53NdAaz++6J9yLD3hl88Hnz9a8spTsB8yxCXvBjVXlZpArWVNnyxoGVG6+csUSEuO9@nongnu.org
X-Gm-Message-State: AOJu0YymsicrZ2Efz3zqtcrbz1JtD5pxHh1Mi8mmN7XbpoMQcOVzSM2b
 FXWZNqQKka9Z1U2Xg6e7rtczEP3hQaQujBRVfdNo8D7fQema32OFsmzG1vl+6PQ=
X-Gm-Gg: ASbGnctHLYpe/3OmYHN5F5yALHPrbEZP3nYJsqRFWrPcRM6ZcmlamnAWJy8YCtHgnov
 a8bQCnQKGYInWC9Nf5v37ludClaoWQRD1k7mglJpmtKdSmR/NO5rqiEqvho/0Ahd4uraYpz2gIt
 0xw60wpWETKu/vYt2fhSf1oHIhLk+mNOBFQk+NkWzNPEsXlr6dfhLKNQLq5yTsVL7RQserKvnYp
 kWRypxrbDQ9i6bJuEovm4DU1n8qJNUbldSLRZUD7bx6AVY96tPYYm5wAqzzGsOvUG3ONLP+N6uA
 seGJXT7sTo87sjxqQ7PEIbv81HJXotMU2DTbycwMjcZhRkzkIM8Hs9dgw/9xGNQJUkyQk75aEDA
 lMAtK1MQm
X-Google-Smtp-Source: AGHT+IH8cqQB1JFfHtiMgSr7M3xuAxg7M2IV0C6IViP0/skUuvFOVdV5zfYv+gm3L/lv7o9w6zE9+w==
X-Received: by 2002:a05:6a00:2e9f:b0:736:5486:7820 with SMTP id
 d2e1a72fcca58-73682be6ed9mr12077370b3a.13.1741277995216; 
 Thu, 06 Mar 2025 08:19:55 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73698244daesm1596751b3a.53.2025.03.06.08.19.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 08:19:54 -0800 (PST)
Message-ID: <353b36fd-2265-43c3-8072-3055e5bd7057@linaro.org>
Date: Thu, 6 Mar 2025 08:19:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] hw/hyperv/syndbg: common compilation unit
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
 <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306064118.3879213-6-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/5/25 22:41, Pierrick Bouvier wrote:
> Replace TARGET_PAGE.* by runtime calls
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   hw/hyperv/syndbg.c    | 7 ++++---
>   hw/hyperv/meson.build | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/hyperv/syndbg.c b/hw/hyperv/syndbg.c
> index d3e39170772..f9382202ed3 100644
> --- a/hw/hyperv/syndbg.c
> +++ b/hw/hyperv/syndbg.c
> @@ -14,7 +14,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/qdev-properties.h"
>   #include "hw/loader.h"
> -#include "cpu.h"
> +#include "exec/target_page.h"
>   #include "hw/hyperv/hyperv.h"
>   #include "hw/hyperv/vmbus-bridge.h"
>   #include "hw/hyperv/hyperv-proto.h"
> @@ -188,7 +188,8 @@ static uint16_t handle_recv_msg(HvSynDbg *syndbg, uint64_t outgpa,
>                                   uint64_t timeout, uint32_t *retrieved_count)
>   {
>       uint16_t ret;
> -    uint8_t data_buf[TARGET_PAGE_SIZE - UDP_PKT_HEADER_SIZE];
> +    const size_t buf_size = qemu_target_page_size() - UDP_PKT_HEADER_SIZE;
> +    uint8_t *data_buf = g_alloca(buf_size);
>       hwaddr out_len;
>       void *out_data;
>       ssize_t recv_byte_count;

We've purged the code base of VLAs, and those are preferable to alloca.
Just use g_malloc and g_autofree.


r~

