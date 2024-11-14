Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E904D6A226
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 18:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBene-00029y-9x; Thu, 14 Nov 2024 13:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBena-00027Z-2R
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:42:35 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBenX-0004ZH-2P
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 13:42:33 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20cdbe608b3so11035935ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 10:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731609748; x=1732214548; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mYvKfeZwSvOCLGHaePLaKvv3G49elL110USMSeKSzDI=;
 b=p+FFDyo1gve93WnWBWp7VBOLSHPCKfIlroPMDsUGEjVlsAYNx3C8P0TsQ8qy9odNJD
 XmS4DGuvLLo7X+tcoKVFf7mTAoF41sKXzspuYv0TltS6bqh7WtmydLOTb3YrKqwAZ7Cx
 beCA3isBxoX8m36yssBdLURcXPfV0RVyZpdZYbIWhmTnsTNXxffw0tsNzqbk+DJSzPrl
 Flhk6wJCedIgC1LLeD9q0mGbvNHuw8QLtK8EogOYE3c/yfBZXhEHNXj7jTsCEgVRisxS
 FBk7inaH5dFftLEAzmd+TLY9oB+20XR982dQt9HYxFH5DnRdxXKH6piuq2VGA9kI9lzJ
 9qEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731609748; x=1732214548;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mYvKfeZwSvOCLGHaePLaKvv3G49elL110USMSeKSzDI=;
 b=mG7FxATJp6mwJ2nuTmdiKe9gCeNTtjL4SRtwAWorq2odJnk8UKxqf6cfi6HHbRkQHZ
 cwfaR44KW/qo0Y6AiQaAgNiccMY0UeKXaoLp9+E39MnB79/wG2bFUZNYoTYHk04yeI6r
 +Zs8tMumcfCciIs6RCiQ/M2XShywjrcskAGchPYCIJ6Ta/2yifU3tC+5m3Y9iF3Ny8Z0
 ZnGgixh+c3P1AnvmtyUS5XaK/NmivcVyvRIqD2d7ytiwjd8N2+qo+bCWKViiQF2v2irp
 YbsWaEMBSJT2DP+dKeeDh4kr7rzZ2g7bd0MDKcIAHVBoPHo+YfG83lhANjnp1XaZhXmi
 JwtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoaRAwfj0Vg61Y/2iFQ8D7tiYmUGhgzLm7HQwWP5BKKwlU7I94i4VPXOJza7cvJkE78bIDuhPoPe2B@nongnu.org
X-Gm-Message-State: AOJu0YzjsUPR4gGpF97fZAClqLw7ixZNYvsj/Vk6bzq9tg4P0+OFb4ro
 WCNHgqZ2i2kwISueGyki3IkIsjhRsO9c4mQllFnvvpQRo6GQpW8u1ZqG23I481E=
X-Google-Smtp-Source: AGHT+IGw1Sbnt0gFZ0JHPvOouF17ekOpSrNi6lra9+PlpTGTkFZtyG4x1qPPZzz5tm+HZYnAsBe0Iw==
X-Received: by 2002:a17:902:ea05:b0:20c:f3be:2f8b with SMTP id
 d9443c01a7336-211abae69b4mr146667945ad.30.1731609748060; 
 Thu, 14 Nov 2024 10:42:28 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7ce9627sm13916465ad.161.2024.11.14.10.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 10:42:27 -0800 (PST)
Message-ID: <1f0c07f3-6306-4729-99b6-1b8607687711@linaro.org>
Date: Thu, 14 Nov 2024 10:42:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] target/i386/helper: Include missing
 'exec/translation-block.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 11/13/24 17:12, Philippe Mathieu-Daudé wrote:
> TB compile flags are defined in "exec/translation-block.h".
> Include it in order to avoid when refactoring:
> 
>    target/i386/helper.c:536:28: error: use of undeclared identifier 'CF_PCREL'
>      536 |     if (tcg_cflags_has(cs, CF_PCREL)) {
>          |                            ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/i386/helper.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/i386/helper.c b/target/i386/helper.c
> index 01a268a30b..75c52e2143 100644
> --- a/target/i386/helper.c
> +++ b/target/i386/helper.c
> @@ -21,6 +21,7 @@
>   #include "qapi/qapi-events-run-state.h"
>   #include "cpu.h"
>   #include "exec/exec-all.h"
> +#include "exec/translation-block.h"
>   #include "sysemu/runstate.h"
>   #ifndef CONFIG_USER_ONLY
>   #include "sysemu/hw_accel.h"

Hmm.  The usage there in get_memio_eip really ought to be using tb_cflags(tb) with the 
translation block found during unwinding.  But none of the interfaces we provide from 
translate-all.c provide that.

Currently, tcg_cflags_has() is in exec/cpu-common.h.  Perhaps we ought to have the include 
there, so that all uses of tcg_cflags_has are fixed at once, or perhaps tcg_cflags_has 
should be moved.

Anyway, just musing.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

