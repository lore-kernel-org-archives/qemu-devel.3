Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28CF8CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:22:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xM0-0007fX-Ns; Tue, 23 Sep 2025 03:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xLy-0007ez-IQ
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:22:22 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xLv-0001UA-R0
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:22:22 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e1bc8ffa1so7728945e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758612133; x=1759216933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pRHoFiF21YYNUgwcXfZf+IJqxkkjaynPoUIls2meqvo=;
 b=vWSCF6y4J3Yfplg4peb3p35U1Kh3BecGQUc+PDGLSO+deSli4wsejBbsARl6mEZhF+
 JF+gAOcrLIPrM+Mh6lsCEcvbIYPQgOS65mkqpl0n/vd0LADHDyOPoyy5eDlYrfnQ9ZMz
 h3zi+vDTXecoiDk2oPjGveTILf6l95K/Hji17RkUTvCeeXMZhRKA+Rf75H9y4btVGb2h
 QECcdZ48UDdpDnztD8/ISFA+lMtouilUdwPsfgxaljn0SYT5cDEo5iTd3ibPcfQprBWq
 xNJhsJxv2M2s6A9PGb9wxGXmmBrgiSTJAj3Ds5QKQkP3ivsgARwpqw2lHyslX/i8fv0S
 mX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758612133; x=1759216933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pRHoFiF21YYNUgwcXfZf+IJqxkkjaynPoUIls2meqvo=;
 b=C8bn6WqmJg09JRSUHTpz5XwZ0BPVFzKBhKUSp9+Ss+7H9P847L/4rfOkYiUNKAQO22
 Y8f54Wn0KRxhMkJNRqf76TcDDFNVRoqSpHwpyF+ZsY3dnoy0Bg0fn4wJ3TJaBjX2MGlV
 yJhYg/GDUc8mMo67j1PSbkQdEl7EHuXh+Sm4dzv5DaRBzes9hDNYNA3j9kBmhLIPPkv9
 xmsASIX0k5qnlpRC//VbA1txL0tkW+R5tp858FWvvlbJEKO6w+Ugv+1J1/tlcCPpMxx1
 k4ZZER+pzwWoM+w7xaz27WMoR0oC4qPGLRPMT9c56cNkv0E3C1VsJ4hwN3t4Qq59Gg5p
 EHeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4HyiX3/olHVsEBlPAi5fE/N/oPk8tnK4DgV/sJKvfNb+tg/duM6dWdLY5yuB5etB3RmxY16jNdIWr@nongnu.org
X-Gm-Message-State: AOJu0YzbNocvrWRc9jhkSfka2vlr1KIbNX+rYW7Ly0H5VXQZ5ZpM+4ej
 Msl+GbY9CK94DOWJGYRDkaSUjTH6PBxa8cBg8k+S+ywU5e8uehTSb9qXJJPqEpvWMnA=
X-Gm-Gg: ASbGncvtiBJegiZ2MLnCr6pVapRTB6gYlsWnsfGM1bm+VE19SXQncKrsAazwOJe95OU
 /giO8vli0BnRz0mc3yN4ccJj52ZUv2VQYHB32oehDaMsP8h2D0eUja7P+DIzjXMovCuUAbJNCZ8
 a+g2hh3mESlmjsUynnULv7z28GtuLewfaznbY/3i9ceoUrdKeIq82VG8wCPtSjBQKh/MnvSkzwL
 63YGdUZOO+bj6IdvrKHW/u3LpvN5cXq1ViyzrdQXbIFQr6YYT45iR6nHghz29lZ0YjNMBFoFlV+
 CuE3tk6g+7y0JrtZzm0qI7llDL7xRoSpdQHcmFPapMq9OaXo89ZK3bHdzfS+UFYYGG86TPceX2f
 mlni7H5aT9IO8movnCdOWiAELC2JidqDswGtAXhurJ+1BXMJYco6wWszdnYnIQpFQyDde03gxj9
 yb
X-Google-Smtp-Source: AGHT+IEDFohsxSHuG6SXSCbkLk3ywsTUEBFj7PYFpy9JIM/TG08eZrgL0yPQskSrk9/FklyyaSjorA==
X-Received: by 2002:a05:600c:4fd4:b0:45b:7d77:b592 with SMTP id
 5b1f17b1804b1-46e1d988d12mr15794725e9.12.1758612132630; 
 Tue, 23 Sep 2025 00:22:12 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46c9d5d52dcsm98443135e9.8.2025.09.23.00.22.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:22:12 -0700 (PDT)
Message-ID: <066df1aa-226f-4cc8-baa8-d7420cd37b72@linaro.org>
Date: Tue, 23 Sep 2025 09:22:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] accel/tcg: Move post-load tb_flush to
 vm_change_state hook
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-6-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 23/9/25 04:39, Richard Henderson wrote:
> We need not call tb_flush once per cpu, only once per vmload.
> 
> By moving the call from cpu_common_post_load to a tcg-specific
> vm_change_state_handler, we do even better than that: we only
> flush when called from HMP triggered loadvm, when we had old
> state to flush.

Nice!

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> Cc: Peter Xu <peterx@redhat.com>
> ---
>   accel/tcg/tcg-all.c  | 21 +++++++++++++++++++++
>   hw/core/cpu-system.c |  8 --------
>   2 files changed, 21 insertions(+), 8 deletions(-)


> diff --git a/hw/core/cpu-system.c b/hw/core/cpu-system.c
> index 09c928c1f9..1fd9571017 100644
> --- a/hw/core/cpu-system.c
> +++ b/hw/core/cpu-system.c
> @@ -207,14 +207,6 @@ static int cpu_common_post_load(void *opaque, int version_id)
>           cpu_reset_interrupt(cpu, 0x01);
>   
>           tlb_flush(cpu);
> -
> -        /*
> -         * loadvm has just updated the content of RAM, bypassing the
> -         * usual mechanisms that ensure we flush TBs for writes to
> -         * memory we've translated code from. So we must flush all TBs,
> -         * which will now be stale.
> -         */
> -        tb_flush(cpu);
>       }
>   

To squash:

-- >8 --
--- a/hw/core/cpu-system.c
+++ b/hw/core/cpu-system.c
@@ -25,3 +25,2 @@
  #include "system/memory.h"
-#include "exec/tb-flush.h"
  #include "qemu/target-info.h"---
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


