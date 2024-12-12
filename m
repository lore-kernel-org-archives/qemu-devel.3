Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40017E77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 00:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLWfN-0004yK-L2; Wed, 11 Dec 2024 19:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWfI-0004eU-MF
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:50 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tLWfG-000388-Fw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 19:02:48 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71ddc7325beso7770a34.3
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 16:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733961764; x=1734566564; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XD6rH8e4DcKBxo5nQAKAM3oIHGLg0tbYPGNozz874ic=;
 b=KIiW1idYOSIu2A8bNh9Xd/ahleJv2GXczmFAQhj7j6BnywsT4LXxrwq4qcaORRB/Ao
 +zW1eqo9/LvnpXS0IUGuo4WoIePuZPKguAL1vMUExjXrVi7GTXqXEpK2b/tBT7ekxbON
 O/nTavvkk1QpHnV/glnnEnOIvsfDmdSBRXa2Ya7y2y/2JGokmiSirj+aqgR/mIDYpRbf
 BnJJkPFaPHJW+hITZEWWtDtwCixUQDmRJMf2xxsYosOQExKarTdidZuEAU2lz8Rm5W75
 BeV7ZSt8TXy89Q6etgW8fC63nZ/ThLLB4ZYcWP32o+makUOuntS7Yp5XHS/5Q1ktWuFe
 whbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733961764; x=1734566564;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XD6rH8e4DcKBxo5nQAKAM3oIHGLg0tbYPGNozz874ic=;
 b=FGglP3xWhhVoh4kZVuOFlmXHiMXIV6aUuJ8otqy0MSes6V49jeobAZAlf2SSimjfi/
 k8uxvAkttXbj/T23kNRzxbTXCXmutC/czw50fbzdVNrBMIYb63Ck5kCRU60hzcuRTsEV
 eSgZVDAEjiQmlGsl69rTDrHrjOqBIqJQ5VbJyzd0LbxIrMwCsPu83yVOUfZIFkEA55R2
 u8l88kBtNXtrmaZYaiflQmnrFrg0Zk6MMsIZjoFMR+n77uMAOdvrv3MeUY/TfOa8fVTI
 9ZcKdQb9O7pE+3IAP32WO9m2Di4DBsE/YN2+0ZJS5Jw+FQZBwk1u7mlL0q5MUdPOHkA6
 6hkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp/LyZ2a1OamrTv+vdwFXx3wCMnN4q656ixM31JjmI/cLMqcR3dQfUSxsTciFpliZ82UiUJNy4CuEO@nongnu.org
X-Gm-Message-State: AOJu0YxIjqaT+q/jkfZfux1q6FA9YViEeDqHBfQVU1jkw1+3ddfoaIdL
 gGE1P5idAaXd816f41nla6aS9/uTkCHXQa0QmQFMymGPKEmMxbXQcc/z9AHXLIs=
X-Gm-Gg: ASbGnctBmkwNpSSqFvnEdRjaUaO9kZU+XA/JPEl9E2p6oafTRvbHR+lUGupufBM55/E
 RjeIzwpIdRWdXUVWEynAqrdhrcez1O9PIP7u+hftYhXcgQO8U+6phybtT3rQOEHFGeCtAvWXGRt
 FHge/VCDxkOiPMO92Ty/1deoVIq04H3mEID6RESzN2w5fYQLBlUk8ojYRRfB59DjkJfBocx+Bus
 eeniQAB8yrYHEB1ZHnmK6tt2GbaSVeusl6a1T68D5A4wnNlN4xZnWSjI6+3KG1ZK+VHoKED6FTs
 0aYHZcP9WbZomKDh/Rqy19U5vnhquJUq
X-Google-Smtp-Source: AGHT+IFtPkMoRBlUjntLV5QfDy+qqaPAq0d1LMVKQ2V33bGTnl1jN1b3/bbkdTuYzcuIXPKwmvZKBQ==
X-Received: by 2002:a05:6830:908:b0:71e:1fbe:db2a with SMTP id
 46e09a7af769-71e29bbcd30mr795534a34.12.1733961764292; 
 Wed, 11 Dec 2024 16:02:44 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f2bc5e42aesm1643560eaf.3.2024.12.11.16.02.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2024 16:02:43 -0800 (PST)
Message-ID: <1c8aa2b0-f6fb-420b-80a2-424c7c723280@linaro.org>
Date: Wed, 11 Dec 2024 18:02:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 9/9] exec/cpu-all: Do not include 'exec/tswap.h' header
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org
References: <20241211230357.97036-1-philmd@linaro.org>
 <20241211230357.97036-10-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241211230357.97036-10-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

On 12/11/24 17:03, Philippe Mathieu-Daudé wrote:
> Nothing in "exec/cpu-all.h" requires "exec/tswap.h" declarations.
> Remove it to reduce headers preprocessing and poisonned target
> definitions polution.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 45e66769380..b45defdbf43 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -22,7 +22,6 @@
>   #include "exec/page-protection.h"
>   #include "exec/cpu-common.h"
>   #include "exec/memory.h"
> -#include "exec/tswap.h"
>   #include "hw/core/cpu.h"
>   
>   /* some important defines:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

\o/

r~

