Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C80C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:33:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaNV-0006XN-FQ; Fri, 26 Jan 2024 23:33:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaNR-0006OS-DC
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:33:12 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaNP-0006hG-Re
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:33:09 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5cdf76cde78so725111a12.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329986; x=1706934786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wc0klF9EiqqByZocouJyZE4jBh/1GOxFBlQYgSJPns4=;
 b=YPdiNTeao2LWElyZzfe2cPr1whWD3rDGBSQ1gSDDJYDLgWgKWpykO+lFHFlx24EzCp
 74zjtL5RQY+EAqujDbOk1Rm2tpyy65g03Z/nxboQSK8X55YsaTeps9jqPpFHEYb2pkvG
 PrkkPpaYAO0fhqAQ3QsneCKM18VMnLb7T6hWmPJPA0xjTuMfkiB35f///HkJixKXV/lQ
 dMlb1u0aZbh2w1LjxreJAV1AnnWJ4YBtTkKxbdtFFkzLH3cm7LCL6kehkzu4aTsRHHgK
 A144gJmuZlSmvqt0XLrT7B+L+0B/1OkyH5oDBLM1nLpXHryRzExdFSGkufPrtz2qxkQ5
 RKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329986; x=1706934786;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wc0klF9EiqqByZocouJyZE4jBh/1GOxFBlQYgSJPns4=;
 b=MCmyxBe9tugdYJHTVcCvOAZN8WqwT3D3rP19Rd75ALTP7GNbzCz3xjqkic49LAypm4
 GTabuXN6n6AJOSqfuUCkgTKKz96hIv3vWie9GM0LhVkwSfuEmzE6VKXqUdpIzMj1hOiP
 PTAT+nnOFD4V2yFkfQlce4UalbLF8GU17WT5OHpSKUw0EZP7Ep92FH7MNxQDPuX3hKBU
 A4M1zNzGgeqYGIhCX9V8kiCrR/fBPkOMYn76yyxYuknEPzs6kYCVhpqYHrP/CMxL97ze
 UTJz3kDPjvCKpXD8mEzkw20sTfRwPFqCM2nLwpCJoMmOzbo9o0kt8DjSAE93htOS1Dby
 o/+w==
X-Gm-Message-State: AOJu0YyEYE+CpctZXGQH5T7j+YClnFp61l5CVX57E3lgoF4DYRg45A5c
 whz6lVmGpO7SjBpkWUccnjIz9srlWT8nBb4xfpdlPis1gB/L8dfAoqVYwTdsv2s=
X-Google-Smtp-Source: AGHT+IG6BxpNhMmELPnXzjEg2yNkGIwJt4XFW9Hb+jZRz2hzIO3FsWx3OTiD3eOTkuYnVnPBMC3Mpw==
X-Received: by 2002:a05:6a00:4b14:b0:6dd:ce43:8dec with SMTP id
 kq20-20020a056a004b1400b006ddce438decmr717131pfb.53.1706329986284; 
 Fri, 26 Jan 2024 20:33:06 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 s24-20020a056a00179800b006d9a6a9992dsm1864732pfg.123.2024.01.26.20.33.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:33:05 -0800 (PST)
Message-ID: <602c3324-9940-4c35-9c5e-a9a57e5b94e4@linaro.org>
Date: Sat, 27 Jan 2024 14:33:03 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/23] target/microblaze: Prefer fast cpu_env() over
 slower CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/microblaze/helper.c    | 3 +--
>   target/microblaze/translate.c | 3 +--
>   2 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

