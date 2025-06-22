Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D389C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 02:26:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTAPH-0000VA-HM; Sat, 21 Jun 2025 22:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAPG-0000V2-GU
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:26:06 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTAPF-0003ZD-00
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 22:26:06 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-234b9dfb842so27145715ad.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 19:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750559163; x=1751163963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6f86rhvDmD9wTfVJoNO+KL9ABZ4kZeN43baMYmnQxb8=;
 b=rfIg4uy/hB7kIOxwP6TYHi33YPuS13QlWBkoTNG0FHok0HZGIizZYA0jcP9zqKUtOm
 65q3az04MfkvyyxAuWpqQjlr6bKtDqNGh31VoreqSmOabk/UEIbRCqNZsb1CvS0ZYW9K
 dsiAR9qc+Q5kwVQVfmXPxPM3G/IDSzJ67G+lwdc3Ledg0lK3HNeUOsgFE9/ifMSiUFR+
 A7TtrkiuwMk2IgXv80PXdB8zyF8kDHgUjEWnv7dr+ILksPv9Fa8TQMPfHosZi6zt8zyy
 8bOBEwA74eh8SdGAmKktxZ52JicMkjDNR1ysTsMAkgevIjn45zlpOnRYHUNmP1ydSOeJ
 wSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750559163; x=1751163963;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6f86rhvDmD9wTfVJoNO+KL9ABZ4kZeN43baMYmnQxb8=;
 b=Zp5yKj2JR8x9eI9jdWsTuKHuV7DYVfNkQuidUfRpQnkJTfQq/WFEz8NV9ZVtUEsZNB
 QwXV0PzC3YjthczWZCNWH0LQ60aP+c2gcMW7KQVKY8GBKe8NZ/NrotCDkhjxFXxfFJ5x
 9SLMSgleijaBVMwCyo/JkuqYAbydlbsZGfvGWcSzSf+Ys6HwTPJahxi7LzvytGI6nRCr
 xGGb1+IG8yd8N0fBZYaUzcY9qvqH9YARkjSugsLx7njuEQ2wO2lNVED1nlUgO6+y9pJ1
 r9E8bTYmjc4jeR5HCSGdyyN5pg1Yqnl3cI45wJe3ZQPT/c036YsNjBp79BC/5ush1kdy
 58mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgEbQ+9si2teTTsxzsn+l0JGMRMTdI/LCy3WFzKmcWMAyUsyhsZYFHFJSjhnU7CnDzMdQXHwl2BniZ@nongnu.org
X-Gm-Message-State: AOJu0YyHLIGJQpS+aw318LyS6tEgzq/TLe7U98FYgBvhplskhB0NbXm4
 n0tdIxtFAqF2aC8uExXl9Hf6GaKObkrE+OfPTIZcNklpfV+0CWnij8nVi8mMh8BFBBwVtrhtqAk
 gYlNxH0g=
X-Gm-Gg: ASbGncv7KBzN8lRG2y78B5HQLZZqmS54WpaM9XcHEunjj/Tjo2nn7XUcDfoFnjMJrkO
 sxikTbBwNWnBIb1MYZ+LLwQ/uR9bgkdx++h/Q6YmnYCP+HYgz8/1cIrFjd3IMdSFV/AtsNxHQ3L
 CL6BevoW7pVdtHqJXaqS8I3cyCPISJLOg9BYRZI+0k2OeYYa/txirRFvEUZ4kOO170mhk9uS0pV
 IGOiLboypOOBt1wfbc272J+xc0sG+vxAJ93YgpXsq675Ih+NDFf6oVq8IPj+OqeHG+VwpJvcRIW
 ug1q/7Mrwajlu/yduV8QYNKJCetD5eYj/NGv2rsFcj4qqwDBUNc/4lIszXujMuMsxlJF5wllNTv
 YFzBTncW17tADjhueFDTAGMsn7g3v
X-Google-Smtp-Source: AGHT+IGe+tDPaGGg2H72IUk/SDxsBQ7xVJ0ikx5etKw8vp28Pt2EQH54+P+e8dDjlwLkW5wUbZAE/Q==
X-Received: by 2002:a17:902:eb8a:b0:234:cc7c:d2e8 with SMTP id
 d9443c01a7336-237d9ac401amr106117465ad.37.1750559163486; 
 Sat, 21 Jun 2025 19:26:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d875a7b5sm50074425ad.256.2025.06.21.19.26.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Jun 2025 19:26:03 -0700 (PDT)
Message-ID: <289cdf16-291b-48c8-ab80-319963899629@linaro.org>
Date: Sat, 21 Jun 2025 19:26:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH RESEND 05/42] accel/split: Expose 'hw' and 'sw'
 properties
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20250620172751.94231-1-philmd@linaro.org>
 <20250620172751.94231-6-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250620172751.94231-6-philmd@linaro.org>
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
> In preparation of other accelerator (or potential emulator),
> expose the "hw" and "sw" keys. Only HVF and TCG allowed so far.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   accel/split/split-all.c | 46 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 46 insertions(+)
> 
> diff --git a/accel/split/split-all.c b/accel/split/split-all.c
> index 7cbe32ea768..28f626d0ff4 100644
> --- a/accel/split/split-all.c
> +++ b/accel/split/split-all.c
> @@ -8,6 +8,7 @@
>   
>   #include "qemu/osdep.h"
>   #include "qemu/accel.h"
> +#include "qapi/error.h"
>   #include "hw/boards.h"
>   #include "accel/accel-internal.h"
>   #include "split-accel.h"
> @@ -78,6 +79,42 @@ static void split_get_stats(AccelState *as, GString *buf)
>       g_assert_not_reached();
>   }
>   
> +static char *split_get_hw(Object *obj, Error **errp)
> +{
> +    SplitAccelState *s = SPLIT_ACCEL(obj);
> +
> +    return g_strdup(s->hw_name);
> +}
> +
> +static void split_set_hw(Object *obj, const char *value, Error **errp)
> +{
> +    SplitAccelState *s = SPLIT_ACCEL(obj);
> +
> +    if (strcmp(value, "hvf") == 0) {
> +        s->hw_name = g_strdup(value);

Since you've compared, you could assign the literal and not strdup.
I.e.

     if (strcmp(value, "hvf") == 0) {
         s->hw_name = "hvf";


> +    } else {
> +        error_setg(errp, "'%s' accelerator no supported", value);

not

> +static char *split_get_sw(Object *obj, Error **errp)
> +{
> +    SplitAccelState *s = SPLIT_ACCEL(obj);
> +
> +    return g_strdup(s->sw_name);
> +}
> +
> +static void split_set_sw(Object *obj, const char *value, Error **errp)
> +{
> +    SplitAccelState *s = SPLIT_ACCEL(obj);
> +
> +    if (strcmp(value, "tcg") == 0) {
> +        s->hw_name = g_strdup(value);
> +    } else {
> +        error_setg(errp, "'%s' emulator no supported", value);
> +    }
> +}

Maybe just skip this until such time as there really is a second sw emulator.


r~

