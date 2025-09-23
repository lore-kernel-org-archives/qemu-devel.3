Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81384CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:19:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xHh-00068k-Nq; Tue, 23 Sep 2025 03:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xHe-00067v-QV
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:17:55 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0xHW-0000x9-O3
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:17:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso4566422f8f.3
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758611858; x=1759216658; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJBcXyk+0pUNyVPq5wd8va3dRp8F7RSNKa/dyDt1szs=;
 b=EXUmEH+uudYM1XIJyjNMW9yFlovtUULqg+nXLe2waFoBHl0ng0nGfNolHOerWAYeAZ
 jZwcvCw85eepp1FC1fg43AtG/2/X+vxm9MZf8ZmU/t5saezTB0XWvjxTjiqk/qTf6wc0
 /CZ/nRyolFDvs5Sul/h83tS2281lYPn2/0o+waHWIawKn77t1x9D9azHF6/bT9fDKOuC
 Cc/OnJjLpJrZB3HUX23wxZWDx0WY+H7b3KZynyo/BAwMWzTw6NFN74wRwLgUyFfL5WpB
 XmDk8eK9vrBmz9YwxyW9dDqX4uBvUgTr9hNMfzDl8KLFsl3PozYHs9G1KHCyzSClWOv8
 5s5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758611858; x=1759216658;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cJBcXyk+0pUNyVPq5wd8va3dRp8F7RSNKa/dyDt1szs=;
 b=vHExS90W0lrQTkXx0f2CTCEtF0fXm1NdZAaPSbpfcmFmTfkfbK9Okg/9Pge+KTdmv/
 vo/4x8siMdWqFh9WKdo9tUhRmvaqHxPuVNolrmSjabTNM59136uekRQXTSBWFqYfyhoV
 vCjUKNiNgzY0c68dvtXqgbM0jiRf9x8MV2Jh3GZPA53DgzUOx3zGIkAb0Zl3x2XxmL3o
 wWtakIrh8jNxxiRjKrR+uhIaroS9T6wZJh+4KM0b/yPNC0MhWe8ZDURveWwTG4B7VT3L
 OAOft8qf2172SPAHyFKSNbnyktFG1ToCIPGcsboBkxeMsLzgyvYBMudxUp+4rGzDUp2W
 OU7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLJ44shyBI5ayCh+bkDEucL+vg1tRC0Mq1n2Ufuty+zoOLbtAdskUHvmhAH6Fu9BeP17Xi59AYLJQY@nongnu.org
X-Gm-Message-State: AOJu0Yxd0fnbL3vSVdeC68+U+rOp/pFXLzXHg2fvXZR9WaapQrejx3c6
 M0JYpSsjKzNYxo3XdRfCP0DRQnWo6ANwcY7Mm8oWeB/RPN6iWoeeITyn5wqL8rue+AA=
X-Gm-Gg: ASbGncuLQ9NU2BeJMNhnr8KFhmcXrNQTC/J+4i5NhkeG92vS/JHxoMAG/4dBzT4kmmR
 oXHOub4cXKdRmCIAdwDypnLgBjgUc4oLfuhX6OUFEoq35GdsUO2FRmTgD98P8+PihHtkSWYBsKf
 2ByFGjYGLjBJCGD08jyDPUcTQaiEK+eTVmNSpNeW0HH1hz3L1j1GGNz4sDxFRU9WMYLdy6kMW4S
 DDPQzg4SbchoD8dv2yUo6+5c5fchBMWPJZd7SHmpLMzx9f+nSKRKPfM2SwA11Q5mLOcF9Oy+DSh
 El/9QMm9Qesxp38B1sg+gMzF4lfgk1TGM1tZgUYDeTuFOoPznbLZgTVVsJre2eO8H1q25467P5a
 ptQYtXZqvvGteL7dglWQ8EqlmGpk3ADFlcrqxYB8vUmtFZNG0h7QPEM4l1A5Yj83/Sw==
X-Google-Smtp-Source: AGHT+IH+vtbKy3NEBEUxMioNAfLf9wlTMTz1CNqiqBHc+stYeXlZR7Jbs6rkk5Rd1RkFWjHFnJAG0w==
X-Received: by 2002:a05:6000:2c0b:b0:3ec:db0a:464c with SMTP id
 ffacd0b85a97d-405cba9c247mr1212879f8f.44.1758611858049; 
 Tue, 23 Sep 2025 00:17:38 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-464f1627140sm241226685e9.6.2025.09.23.00.17.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:17:37 -0700 (PDT)
Message-ID: <62f57339-1cd1-4428-a3b7-f82f98d1f4ca@linaro.org>
Date: Tue, 23 Sep 2025 09:17:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/12] accel/tcg: Split out tb_flush__exclusive
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20250923023922.3102471-1-richard.henderson@linaro.org>
 <20250923023922.3102471-3-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250923023922.3102471-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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
> Expose a routine to be called when no cpus are running.
> Simplify the do_tb_flush run_on_cpu callback, because
> that is explicitly called with start_exclusive; there
> is no need for the mmap_lock as well.
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/tb-flush.h | 13 +++++++++++++
>   accel/tcg/tb-maint.c    | 33 ++++++++++++++++++++-------------
>   2 files changed, 33 insertions(+), 13 deletions(-)


> diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
> index 0048316f99..71216fa75e 100644
> --- a/accel/tcg/tb-maint.c
> +++ b/accel/tcg/tb-maint.c
> @@ -36,6 +36,9 @@
>   #include "internal-common.h"
>   #ifdef CONFIG_USER_ONLY
>   #include "user/page-protection.h"
> +#define runstate_is_running()  true

Hmm, acceptable.

> +#else
> +#include "system/runstate.h"
>   #endif
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


