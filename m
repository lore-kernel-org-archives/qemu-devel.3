Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 009B9C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAtG-0003Cw-9t; Sat, 21 Jun 2025 22:57:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAtE-00035C-9f
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:57:04 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAtC-0001eO-Th
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:57:04 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234f17910d8so27073565ad.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750561021; x=1751165821; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B5iGI/sw6p1w/PcWHSIU7m5gwcPBlfD8NDeb0X7ywZE=;
 b=bV/gwRSL8tZFUxbxx+3uN5OECcFNRo9nNM2UvNzxusEIb5GRWzqCBnjL8PtQl3N8iw
 IvIgSnsCLndB3rlnedxIwMFDcvlAcO6WD4eahCtAM53e5L12GOrYiN5dtBPgt0LtRarV
 IkoXekfbCEKQkNuo+2stWHJOUFHS0hhfF18+rVRM4op9d6nK+sObw0VTvKq+vMM/drEf
 LRLzU2/NnI4XPp0RppdpBwIfLcDGfPCSSydmx0SRawvjNCmoiFMIGrvdzegEfaH0PL3l
 NNcPeQbRCEBfooOLd0BEKqiAKakhbfAp9r2qUGUx/bSW0qTZb4MMiaybjgDjcIWuXwOn
 dTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750561021; x=1751165821;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=B5iGI/sw6p1w/PcWHSIU7m5gwcPBlfD8NDeb0X7ywZE=;
 b=CwqC1hyYbr16TynboRAC/a0bMSdM6o7/v19SRGel5Qtu0HDVuXxobVSO8RNKHWD4sQ
 /3owKnX4SFU48XeEqp3DZWk2jnqDHr+X/HyJL8Q5+YZu5LNPPe50ttuWhpeOD9dKwrO4
 PFk45jVvmjQRNk8KemcXkbVcaOByaHv47+om0F3OcEWBlf/qMj1SsevAa5+KKmlBpVTN
 tBEIn7kE0Snq89Z2ui/FoHaJS87/0rhnfx2W2LSltf3uJ9z7Inky4Z8MuKuhVDnzX/VJ
 If9mQcmrPh+Cy1gyMyeH2m+JD9Ih/MPZTg5q9e/ew4smYXViJLJdVR/KEQnvGcDF0Ym/
 7VrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8k2iQ+e8Cm9wpzSrPI49Wy75gQK5U1IfucQeHvutfUxXV5fMtc2sAVantXrW5tGXdDGYQLpAI29Ug@nongnu.org
X-Gm-Message-State: AOJu0YxjQonGdMMjFjLMFLvSsyjevjv4NPrv+yAezDWR5VOElhRTIrdF
 XLqNfd7S1np0Z2mr4L/W0fgZL6owf1GozoRta8h4daQyBEquOo54tg8gWW3lrqB+JGM=
X-Gm-Gg: ASbGncvYLq4PbuAix45b90BVu/4TOI0zrETDOrY1HXg++mOdE7RdYZ0ZZAC9C3lKhvz
 vqy5C7Gpgz9sEsn3ytyHRYVQLdaCQxIi6bUkbcVJqMUrciyU+K2GnaVhLSoC2EYpeUvr8Bvr0py
 CaSiAw8hNyzJe8M7ow4/AQyZE5R7aHy3JtyHHtJ47XoMzPjONWZCwLxArDDruFed5takLxakToi
 h6OAB2W8gT1gcj1oLYr96AhbI9rWS7t2P3s7zgOkcu8n9zUWEQ+zFIXw5ynhApybV9WGfxbNqsR
 3vVvJhpN+uHqSInGhayUc4cs+1S8ScHGPTiu8gDsTtTBliX51erIVRIT+nZJaoenWmjH78Q/yTf
 QpCdpXQujxdpvT5PPYWSGFpXhYq4+
X-Google-Smtp-Source: AGHT+IH3d1mWnCbDfhEQTpeSX0UHbeGxeg6zMoFJ5O6hGg1RL9//B8Sqc8VYomQ1WID8WqiV9eSWWA==
X-Received: by 2002:a17:902:ea04:b0:234:909b:3da9 with SMTP id
 d9443c01a7336-237d98f7360mr114358125ad.27.1750561021341; 
 Sat, 21 Jun 2025 19:57:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d868f878sm51938485ad.184.2025.06.21.19.57.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:57:01 -0700 (PDT)
Message-ID: <ecc96157-f5cc-421f-bd59-154ce180e454@linaro.org>
Date: Sat, 21 Jun 2025 19:56:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 20/42] accel/split: Implement
 cpu_common_realize()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 6/20/25 10:27, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-accel-ops.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
> index 63b6217f3fa..3278e01f18a 100644
> --- a/accel/split/split-accel-ops.c
> +++ b/accel/split/split-accel-ops.c
> @@ -15,6 +15,7 @@
>   #include "system/cpus.h"
>   #include "split-accel.h"
>   
> +#include "accel/accel-internal.h"
>   #include "accel/tcg/tcg-accel-ops-mttcg.h"
>   
>   static void *split_cpu_thread_routine(void *arg)
> @@ -112,7 +113,14 @@ static void split_ops_init(AccelClass *ac)
>   
>   static bool split_cpu_common_realize(CPUState *cpu, Error **errp)
>   {
> -    g_assert_not_reached();
> +    AccelState *as = current_accel();
> +    SplitAccelState *sas = SPLIT_ACCEL(as);
> +    bool success = false;
> +
> +    success |= accel_cpu_realize(sas->sw, cpu, errp);
> +    success |= accel_cpu_realize(sas->hw, cpu, errp);

&&

r~



