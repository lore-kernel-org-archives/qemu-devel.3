Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5F3C87FDA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 22:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhbMg-0001KC-Bq; Thu, 31 Jul 2025 18:03:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbEP-0002Yv-Q4
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:54:33 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhbEO-0003TS-0L
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 17:54:33 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-24031a3e05cso11639345ad.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 14:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753998870; x=1754603670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hRKZoqz8YUdjNU1GmsXYmXPiJbwUm3MiMGA9p34WREs=;
 b=boc3vwnVRcvHUD/bPJ9aSt1Wo1zzy3e9V1tDVQQAT+ypaE82xp3wbtSB1MylAkD9ZN
 Xz/tG0LOGK6QrxDu2IP5ajCLYUXAhaxTG+wFjm60Ah6ZK3VBsRHY1pNY6mxP3DyXda3v
 brLM2PcxUYnL+1sivhogT9JQfOzjPgo97J4EUB71CUG4ve6RxB5QQLUiogrp0FSSZdC+
 GRDYMW0o+R5bTXQ3TdQymnnIrQCmAdTqy40nQSJEV520J1bJeWq3p0fqc87qjOaQhg2d
 9eGPZZ6CAwbBtSsOWgG4bd11kpAyAAmXJojQx0YInE0sUsMrfzMxv5aRfcNBAOVadh24
 5Nsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753998870; x=1754603670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hRKZoqz8YUdjNU1GmsXYmXPiJbwUm3MiMGA9p34WREs=;
 b=IBl8T7s0LFwttFzqd0phT7mLfyk84e7C/BFQx96JQLCqDFWEHMLdC7ws0QT/Iw+BEA
 EIDBzj5mYGB71GlFV/Fl/ocin4VVG2kvedsl+u4ER+cGhCWbXGdUVt9T0djDsiB40uaR
 cEfcXGhFmskzQ8XDmE9VjVFlpllBrxRTBUAOrTDLM5QoJ/ioOkcgfrbPrapLz5paahxB
 Nhu9zenPB2IHBpuq9hasGSSuBbN5C59t5PeATeJzhH+V0YUYPPElpNmPt+4Pa2TTasDW
 VjDS5eUFaQHQlZjBJwEPdAWo7muNktN8TfzoBhPoM8qjpu7p30LCk05Bc25ElY/Ie4xe
 fqUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl6vVYmlL+tdB52Dkyd9sjChg9dGaqdOCz/NBYuxhJLFH7Mft1vtXfvNVlV/KXPldkoVTD2ZAXz0Lg@nongnu.org
X-Gm-Message-State: AOJu0YyXVRou581EXmxbntvFRlvk5wb6Y6ZrU5uWuMBGyLcWi5W+k81y
 8tKvHpJk2kUOS8ePuZIlc9b1QTh1E4k7xQ3A0l0ecpFnkyLgdWUtYko30ErsIsJ9aT0=
X-Gm-Gg: ASbGncszhm7U1tL/4IXH6YyosbsbrIsbTdsprpVg1K0W0SlBOmKjOsblv4d/hU88uoi
 PRtMuh40rjFhJ42skLs3IzYSDQpxH7Q8sDSpipjhDHkLDUfrvNNPocpLB9NRjXWvFPsC0NM0eBH
 QtVSC2kqJcS+40gEjdBEu3S5n4H/R4Z56Ewf2duIfnKzkfVBpgYnp/m1eOIaAKbo2kk9rYAVPcr
 Pbk7n0fOzTj6bVZhLKOk4k3AjJ307+UhoEiHTReRafliocMeTXuysJSbOqlONltP8H7hS6utLnL
 IUGD4r3dCdwbzs/41NnIyaAo4vj//fliGkGXOHoLjJzAMkTClldYLwcG3gSqKjE6t+Rxtxau8OH
 a2KaNRz/1P+I7XH1CTvRFNwtah167a4dtcVY=
X-Google-Smtp-Source: AGHT+IFJe7dsBOyPmrCuFVuMtqHrGDWLj6r8RrIe82ayEhIRx2n9VAEen7o+xqk3BQbSkkx1/EqsrA==
X-Received: by 2002:a17:902:d484:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-24200b07794mr70348815ad.13.1753998870368; 
 Thu, 31 Jul 2025 14:54:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63dc1880sm5578712a91.13.2025.07.31.14.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 14:54:29 -0700 (PDT)
Message-ID: <df8e1f72-a8fc-47ac-aa48-5cc78de041e1@linaro.org>
Date: Thu, 31 Jul 2025 14:54:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 72/82] linux-user/aarch64: Allocate new gcs stack on clone
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-73-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-73-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Allocate the new stack early, so that error reporting need
> not clean up other objects.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/syscall.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


