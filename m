Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F392ECD343F
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 05:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPwHw-0001ro-QW; Thu, 21 May 2026 01:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwHv-0001rX-MS
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:49:43 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPwHu-0002u8-1c
 for qemu-devel@nongnu.org; Thu, 21 May 2026 01:49:43 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488b0046078so48851775e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779342580; x=1779947380; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B3vnb7oSNxTJwfe4owQDCQnJtBVDrM0Aa5oWs1NNK2o=;
 b=nRBwAZB/aDG8uYkL3Fe74jDECeuUCc5axiY39SAGuRbKYFvD6NuHnHQ5vaK0vDDkym
 uhCLK1VZn3zKAI07nLdt41hjeXmIVW6PM3c2OD8erMK3i6j/mGjVU+fdh/WkaxvW1RE0
 MAlxmLmaOe8etzUWGX29YK+O/PXe9UC2CI8glTAh4EYYUEgjgrKyN8+J7ghNzlire0V8
 RPk/nE2VoD0yw8l9iSdfJszeolnpnt/hDod7adm+rNPSaINAqZO7kdXegoFXQPPmYk2z
 g9VlswOhaQ2i+uYUNu0gRG787lMbMmSOP3imKPnGYoUN5nlhBm0LwQKWuvJVRzkvxQtD
 gTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779342580; x=1779947380;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3vnb7oSNxTJwfe4owQDCQnJtBVDrM0Aa5oWs1NNK2o=;
 b=H2JKwcQ3Z+Wqrcjqc/VqcB9HCuDDrbIpfu4r5hU7D8Dz/N8m43Sch9tCIk17+8dr+R
 J5pD5pKnRpIqibxNP+pETbZfRa2TucfB2kDSCV+ut+ZHctq6q5FtW+QaEyUlWuEEfQnQ
 F3q1mL1Qb8lXGJt9md8mw+O8Zj7o1LRSQUcCFCS1z5niRO1ErLavf8+Ikv6SjedKkjAK
 ujbniDj/7YKuuUV69wzN7gGsk9fVZZ/dt29fGjAR8i8G2fcCYKCypYi5oo+UigR6tPXy
 ahUD4SF3OHgcGD5szRv56a9Z1Qo6TkCqBb8AIcfQggQir/b+GFJYqv5V8yILHlxdA4Pj
 HUAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/aoslEq5kiOcNaoNBzEbP0XGR45+oq45ig51SDl4/OUfnojoUhl4UBwzEORA5RSKGHGckAHmKOKqt@nongnu.org
X-Gm-Message-State: AOJu0Yy5RqRBKW7ATT0TPtFWelejw1FBjEyjP9ArF5vlJpaMsWDWsbLW
 EkPY2KWFT6kAkF8bmsA1Rbl7UW/SWIiNW+3rsuo8Kkffu7/B0EHRaHfToat0WnSD4eo=
X-Gm-Gg: Acq92OE1MYnO3zmaaJK1XOCk3NEhBvNO/CmUYZykq7Bhj9pvmZOkrmCy9W7Dm7rozMO
 NF3yErAX6GQqAXY8+Ck8ZWYVd+hNgOvfOMFX5/O1OJ6tSYzOLjT4KDObws/l0w77R0L5vISek4n
 9W7d7Z8iWSOOsURiGdUP2pFMzhYk0cnEmpBYJQQcvyXqcXPsoG0Spai4hfq4TUG0T6+OVyCFxL+
 b/UIy8WYsjJhhDLMYYPIf8H1lMgueITJYNSXgC4GzxWy85pOyC3Bz/nQxbe1MRYkkO2hMSQvY5o
 k2mF/oP6jrA1bZyJhppeH/Xb+hH5GgXdRzYfsh7oc1lLeePl7UL71VN8GDxsLkTIa2ddpFSGOXn
 RMuvhFLZBcJAyXAYiTqpusjvXM9ebq97p0y5QKeJYOoy1mAzZotYC3NQj9rOqUTmstD9xaJKUO9
 shr51fKjtHx25c2cBwRz40zbrq53tFklHO/XgE9+jWMV6RMxuR0rypc9+JXP+M6p+EOiNUsfhW3
 Yr3
X-Received: by 2002:a05:600d:8:b0:490:778:4fe3 with SMTP id
 5b1f17b1804b1-490360ee151mr13934065e9.32.1779342579999; 
 Wed, 20 May 2026 22:49:39 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035ee5956sm8035275e9.28.2026.05.20.22.49.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 22:49:39 -0700 (PDT)
Message-ID: <c856e07c-0ab8-4043-a6b6-8a32f174f478@linaro.org>
Date: Thu, 21 May 2026 07:49:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/40] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
 <20260521-qemu-no-hmp-v1-4-d104f809e145@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260521-qemu-no-hmp-v1-4-d104f809e145@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 20/5/26 23:49, Marc-André Lureau wrote:
> Replace monitor_printf() error reporting with the standard **errp
> pattern. Drop the Monitor *mon parameter and return bool to indicate
> success, improving the function usage from non-HMP contexts. Update the
> KVM MCE injection path and hmp_mce() accordingly.
> 
> Notes:
>   - we may want to print the error in KVM path too
>   - multiple error prints are now accumulated with error hints
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/i386/cpu.h     |  4 ++--
>   target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
>   target/i386/kvm/kvm.c |  4 ++--
>   target/i386/monitor.c |  6 ++++--
>   4 files changed, 36 insertions(+), 27 deletions(-)


> diff --git a/target/i386/monitor.c b/target/i386/monitor.c
> index a536712c755..785a13dd710 100644
> --- a/target/i386/monitor.c
> +++ b/target/i386/monitor.c
> @@ -580,6 +580,7 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>       uint64_t addr = qdict_get_int(qdict, "addr");
>       uint64_t misc = qdict_get_int(qdict, "misc");
>       int flags = MCE_INJECT_UNCOND_AO;
> +    Error *err = NULL;
>   
>       if (qdict_get_try_bool(qdict, "broadcast", false)) {
>           flags |= MCE_INJECT_BROADCAST;
> @@ -587,7 +588,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
>       cs = qemu_get_cpu(cpu_index);


     if (!cs) {
         error_setg(errp, "Invalid CPU %d", cpu_index);
         return;
     }

?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       if (cs != NULL) {
>           cpu = X86_CPU(cs);
> -        cpu_x86_inject_mce(mon, cpu, bank, status, mcg_status, addr, misc,
> -                           flags);
> +        cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
> +                           flags, &err);
> +        hmp_handle_error(mon, err);
>       }
>   }
> 


