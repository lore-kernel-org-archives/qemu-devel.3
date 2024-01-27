Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E483C46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaJ8-0003ON-PL; Fri, 26 Jan 2024 23:28:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaJ2-0003NF-Uh
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:28:37 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaIy-0005zl-Bz
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:28:36 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5f69383e653so15964197b3.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329711; x=1706934511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z1UC8LTqK9RPAGisk5FapOhzk1j0Yi/QYQ6CVLLb5+k=;
 b=MVH2XoJrCFSZjz1HZTHwkgqUN77/OlpUAta09CoKc9S6wOILUMZ5Ew7PiHRAgH6dCR
 8yk2SsJYVniYS4KqQFUEIjxJjihbszAA9liRG9wUDIUWZ4pxKerDCMpehIkmicYU64Fy
 0OQOCjqsdzpchZphTJuKvelUuZ9s+SB8xY4c0u+b1C7cyVFwfIt349Cf+VJoFUIae6Z1
 oAkA0EBvGqomXel5yXjDR83qmFkW2ch1nDI6y+ABDIyL+7lRcR4wzEVRy4aGNbWPGgot
 e6cg+iSQ7cMsIQnSXhGEZmpkKsHXBdu6klOMAMalPM8iLPF7bqZBXj19vZUm8NaxaWTx
 loRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329711; x=1706934511;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z1UC8LTqK9RPAGisk5FapOhzk1j0Yi/QYQ6CVLLb5+k=;
 b=WBInNOJtyJMleIgyf7h5cSClUVvwKTmwA8u/84F8Z7E+GGfJWQIZuILYGXsVrwc2zO
 vjGr2DYgO7qnWkJg3k1r1K1eG4R7U3oLqtood4YERmqkjG/RLGBeht4O22zeOLwG/4KR
 kF4Nml0PX1J92hpp9nP1tqQ9TUUFIFPX5WptWEfefq70PtMpjQbTfL5yqPgubA57sbV2
 ocrYOaCJAk31ojnUTYaA/drb3t+josx6UV3MTt8voyzKbrqCcoy0km8P8UGSod5KBxK4
 vEONgMMeMLLt8Ji9eOmpcYOsjA67odYfv7jZuLbZhYKjLRe9SFfpTM4rijC8bS+0yawj
 4jTA==
X-Gm-Message-State: AOJu0Yz2sAsGPiQsDZKbcrV6nCPw5pIbY7AhyfR2eErRxKg43Xg3loZo
 0uYkBVeGfZ1fnztJ2BllgdokdA7973fkGxl2ZOxV0tKVo9iBAHafzATSVmRr65g=
X-Google-Smtp-Source: AGHT+IGrYnLKX183h6V45W/BGS/qS/uW66XtMYMQFVC9nC/px0lD9APYKDBrjtAeOQLsVgL+pdt5JQ==
X-Received: by 2002:a05:690c:c86:b0:5ff:9810:f089 with SMTP id
 cm6-20020a05690c0c8600b005ff9810f089mr1013237ywb.102.1706329711168; 
 Fri, 26 Jan 2024 20:28:31 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:28:30 -0800 (PST)
Message-ID: <501d848f-ea82-40ce-bdc6-d3ea27861b26@linaro.org>
Date: Sat, 27 Jan 2024 14:28:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/23] target/hppa: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-9-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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
>   target/hppa/cpu.c        | 8 ++------
>   target/hppa/int_helper.c | 8 ++------
>   target/hppa/mem_helper.c | 3 +--
>   3 files changed, 5 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

