Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87941D132A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7u0N-0007ow-Oq; Mon, 04 Nov 2024 05:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7u0L-0007on-Vy
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:08:14 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7u0H-00059f-BG
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:08:11 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43168d9c6c9so32710255e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 02:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730714887; x=1731319687; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CZu4EcxZo0GnJtGkRQ5rWXDU+d4jC4FCb3m99eJil3I=;
 b=RhT2S/MovnPUndK4RwDUsZwhoZRH3FIMxpDHfEpYafed6uwlhhF2RVtJ6U68VHpHcf
 kRcf2KOPH83VsD1iCFznR1Y3tZsKuLq4CXATYq5cAjvPtRTfM3McgRTADZgSFH80GVVV
 G9rqQTUeCvyTK/ICCrsptVios6SS+GLYKqRmkgCuMrjznyG+evXYTlmjlENFys9xbR3W
 4D1c8MzizcworqrogqZNC+ebBgt64/Jg+Ea8ty+v8vj918UiPIMZATz4WLSahFRCTwDV
 MHeu1K1Gf+93zvlC1j8SxuZ1pwPtOry+T4JhF5P1CKipE7pmOF5CXHmnnzVjjhJxEctm
 F53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730714887; x=1731319687;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CZu4EcxZo0GnJtGkRQ5rWXDU+d4jC4FCb3m99eJil3I=;
 b=vb6qVhic2kI2qezZpE046se12NuXl20DHYxZJsUrjgxJ7R59cuX5z3bkhFLkzyRqjC
 xChyFO3Aa+EfePm+5g6ENzmSM97Ev71mwoKzxeXmaHd8zPv4AZt/mqIz4mL4OCQpUQ5R
 OT92Vsisj7G8S2gaA1cudtGy6DboUzV34XfFm4WhkvkgLYFSCrZG/ZRqrsdCSXte/57z
 1AjjVIL/EZTkwiw3EJriTWu2wSaC10ot6kgDAj7/2IW6u2zNaqAw1Xhhg8Ew5ANdQG5f
 Qk1NXYX+auNYcqsdArODOLuZ89qn4Fjj5TmexrlhEf4yjblrfETn+1ZW62/e5jNtdq7L
 SFyQ==
X-Gm-Message-State: AOJu0Yz3Dm6jJVaxc9CRbZkkYuTRLCrO7vI/KEnrvTWPAylA3C45E+fd
 R81XjIuUfaRL4vnWPx0oG5UfLml9cngIjzAF0ByJ1I51xez7ak2dLcuu0HaQSS4=
X-Google-Smtp-Source: AGHT+IGHyY0aCVy18WieGrKtnUQMqHQ6g+0qBUlIFZ4AusatAQXqiG4NLrh13n+5P18dfUOg4y/j+A==
X-Received: by 2002:a05:600c:1911:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-4319acb2a0bmr275234165e9.19.1730714886936; 
 Mon, 04 Nov 2024 02:08:06 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c116ad6fsm12694159f8f.98.2024.11.04.02.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 02:08:06 -0800 (PST)
Message-ID: <b3f51e5b-baf9-46fc-bf35-5b6a52835189@linaro.org>
Date: Mon, 4 Nov 2024 11:08:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sysemu/os-win32.h: Windows clang-cl compiler fixes
To: Roque Arcudia Hernandez <roqueh@google.com>, jansene@google.com,
 sw@weilnetz.de, peterx@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20241101214101.3376595-1-roqueh@google.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241101214101.3376595-1-roqueh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Hi Roque,

On 1/11/24 18:41, Roque Arcudia Hernandez wrote:
> This contains a series of small compiler fixes to enable the compilation
> of qemu using clang-cl.
> 
> It mainly involves adding some missing header files and updating #ifdefs
> to handle clang-cl specific things.
> 
> Signed-off-by: Erwin Jansen <jansene@google.com>
> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> ---
>   include/qemu/compiler.h   | 3 ++-
>   include/sysemu/dma.h      | 2 ++
>   include/sysemu/os-win32.h | 2 +-
>   migration/savevm.c        | 2 ++
>   tests/qtest/libqtest.c    | 2 +-
>   5 files changed, 8 insertions(+), 3 deletions(-)


> diff --git a/include/sysemu/dma.h b/include/sysemu/dma.h
> index 5a49a30628..f53b751fe2 100644
> --- a/include/sysemu/dma.h
> +++ b/include/sysemu/dma.h
> @@ -14,6 +14,8 @@
>   #include "exec/address-spaces.h"
>   #include "block/block.h"
>   #include "block/accounting.h"
> +#include "block/aio.h"
> +#include "qemu/iov.h"

This change, ...

>   
>   typedef enum {
>       DMA_DIRECTION_TO_DEVICE = 0,


> diff --git a/migration/savevm.c b/migration/savevm.c
> index 7e1e27182a..c082015e84 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -54,6 +54,8 @@
>   #include "qemu/job.h"
>   #include "qemu/main-loop.h"
>   #include "block/snapshot.h"
> +#include "block/block-io.h"
> +#include "block/block-global-state.h"

... and this one look sane. But please commit them separately
(preferably justifying what declarations are missing), not hidden
behind "sysemu/os-win32.h" subject.

>   #include "qemu/cutils.h"
>   #include "io/channel-buffer.h"
>   #include "io/channel-file.h"

Could you post a series (including this patch) ending with a
patch exercising clang-cl in a job on our CI?

Thanks,

Phil.

