Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CB4D2F35C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 19:46:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfkKu-0005yj-SD; Tue, 13 Jan 2026 14:45:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkKt-0005vq-HY
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:45:51 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfkKr-0004d4-Ri
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 14:45:51 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2a0ac29fca1so51016235ad.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 11:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768333548; x=1768938348; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kJT5lHXqxqbcqHaVwXxBN7zSdsJOMgeRkZBGWkjLSJM=;
 b=JRO9QTr808FvjdY2aCuZdobq+UK6lfNDgq6ZdtJY07Pk/1HZ7vLMe9c2OCy16mQakF
 DIxLImy4wrtszZJ9aRp11bleah5hvBAALIHl6si0Wa5xVwk7KRJk+S8PWp0nVw0xXauV
 btatQhm/+2S4aIfuo4k1u0xjjzudoK7SDo30nwyIy3CAAjdE3tsWdikFK+atOJaO5LgX
 oU6hw+9qibd3Yr/py9LfMnA9qVckOqi7LgRDcSIC9fl6s/cdBRO7yrJVOZ5jCvgHrj4a
 eYXgJTmY//IdSIQMDhNFG9Lyy+cBN0BNOLZTZif1AyQLUPYnD53c1P3tPseQXHubmn28
 0c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768333548; x=1768938348;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kJT5lHXqxqbcqHaVwXxBN7zSdsJOMgeRkZBGWkjLSJM=;
 b=B1sAYBup5PVkGE6SQwSZQtHzrgOSbMPgWJZD/lD5VIQIq1jU2qUI0TAI2P5M727UB3
 5GHYClndXr0NL+pgHcFmtt9eMv5Btmer1b9535chxbuwttJyJPEGqzRGy4CWf4Zop2JP
 86oZ6xCIAsiiMnW8kYTfyiKqEVklTu7xJqTQ9CoF1pjiFp8FU43hn2BPj/qGNDoPAvl5
 561If8ski9eQX/hgHOpBysEOov3hN/tgtPlTpfVdlnBdXK3X6RspvZj7I5Rk+WalB5GB
 DxRfz14DkS9mZj5YfzHkSWCrid25wL7VSqqf/NUB+2XhklQzo8STC9+qf3kByE2zIZ9v
 +YvA==
X-Gm-Message-State: AOJu0YyqdywjTyzJBZ671wWkuEsyRcoQEe5P4s1lWrteQIM0JuWlQOUa
 QycvaKpB31P0zSQtv8TdQLVSUzMowSKj7Ow5bXW+1/9zeCGxOrjtP+qj35/QTALIPytLEC/HhfX
 gYwnkN0k=
X-Gm-Gg: AY/fxX7Jv/HFqP/pZTkyqbCbwZwRZ5l7vFKyZwKPRJfgpOqjkmPGHOZkhjF5ylE22Cs
 vIMKt/T+QGkZQnW0F4Db79KHOaG8WJjUYxNQ/Mrrv6mTY+mFYo03NlzfMdM1iIJ9ohZABhUDliJ
 0O3RnS3G4JStSU28MDmaPSDTlRsCvnMnNkZ6UaV0x3ZGj43yFnrX224TelcBFL7bdLi8a79SV3m
 DdKaEjRIR0UB8P7zTtBbPcwiRsCGQ4OhbSHU0HLB2u6JwJD8d4sLkk6iyZNEDQ/DW14fAav+htk
 0QsDmG2NVQFLswnJJdpE1fPZmBMnqc8nlH9OgqO/VCE2Ha6CQS2R7Q1YZdtoN475wCnk+yQTnk/
 hjmuloG25yvxHKLS1FqKel8NfpbiIZ7NGx0Br9idTr9y09+HI1uDdZlLfGXIYOWDgjjIbUdl+MD
 6ufF0rjEdKX8iLas8uKAWlF+1dzVgtnWMjqasK6J92sNkHLm8F3J1uw2Tn
X-Received: by 2002:a17:902:e783:b0:2a0:906b:ac35 with SMTP id
 d9443c01a7336-2a599e8f96bmr1102105ad.42.1768333548025; 
 Tue, 13 Jan 2026 11:45:48 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2ea0sm213089325ad.62.2026.01.13.11.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 11:45:47 -0800 (PST)
Message-ID: <d5902447-9ea3-4d4f-8769-70386620ff92@linaro.org>
Date: Tue, 13 Jan 2026 11:45:46 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user/aarch64/target_fcntl.h: add missing
 TARGET_O_LARGEFILE definition
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Phil_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, alex.bennee@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113194029.1691393-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 1/13/26 11:40 AM, Pierrick Bouvier wrote:
> This caused a failure with program using openat2, where O_LARGEFILE was
> replaced by O_NOFOLLOW.
> This issue is only visible when QEMU is compiled with musl libc, where
> O_LARGEFILE is different from 0 (vs glibc).
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3262
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   linux-user/aarch64/target_fcntl.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/aarch64/target_fcntl.h b/linux-user/aarch64/target_fcntl.h
> index efdf6e5f058..55ab788a7ce 100644
> --- a/linux-user/aarch64/target_fcntl.h
> +++ b/linux-user/aarch64/target_fcntl.h
> @@ -11,6 +11,7 @@
>   #define TARGET_O_DIRECTORY      040000 /* must be a directory */
>   #define TARGET_O_NOFOLLOW      0100000 /* don't follow links */
>   #define TARGET_O_DIRECT        0200000 /* direct disk access hint */
> +#define TARGET_O_LARGEFILE     0400000
>   
>   #include "../generic/fcntl.h"
>   #endif

As well, I double checked all the flags for all arch compared to 
upstream Linux headers, and it was the only mismatch.

