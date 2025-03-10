Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42354C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 17:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trglO-0000gK-9V; Mon, 10 Mar 2025 13:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trglM-0000fz-DY
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:18:00 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1trglK-0001sR-2r
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 13:17:59 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2fea47bcb51so9492396a91.2
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741627075; x=1742231875; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mPhW4dOJdZ5ztx7VFBtzML1SXnUA9GLdB5VdMELXtuI=;
 b=OZFEVVu4u/yhbHO1iAAruwTFbt9pAdk4dAFYFUn9YUYuacIR7FwsNDIalSZQJ6RXzq
 EHyvSk2tk7k7BM92Ox7Xhal2y6Epc51j6U142AUaX+OyigH0UIEBmqpx1A0+vAyqHyA+
 rZWoWjYtbL41Pea7SJXvrLLJhQapGHXHfiQXw7qOMg8CYePmSNJq7z3MdUTxe0JJGyMN
 tu4xLgP3akLX1MkBnFeDjOgUPzmGA7xeB8ztcJPgN7PNQ7jqV/raepFVxOMFfoLJxs42
 Xj+lHFFTv/GUZ0Lg9oljj23uOtQcCOF9h1suQQxMjm8XpCA4TrrBMeGoiXcBejUzZ9d7
 cTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741627075; x=1742231875;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mPhW4dOJdZ5ztx7VFBtzML1SXnUA9GLdB5VdMELXtuI=;
 b=TA1glqhsxz6Fd8MSrwUD5g9fdfEOG3ktbDirb/a58wqtCIR1H6KBVAsRBTvX8lWxph
 t15vkhhcMN46IADZsTukzL3R3jjNg0z/bvZUGvHyxdnCae9OAPPsdQlcgdb2mkDtC6K5
 v2KucmCuiz1RT0stnCR0QKmL6H98RvMal4FvwEHDyogEVQ3rCr4octLlINEQO9oa2X9o
 DTYjbugC7s0YEnz3oaSVbr32pegqFCdf6V48VDAN+Op4lCGJbrS5J1gJtsW8AAi0P1EE
 1DkGbKlxH2GFUXbGpfEWwx2imPA/yuy+Z3R7Nqwd5Ts3LBT7iocjuUXmuje+y82U58qZ
 W07A==
X-Gm-Message-State: AOJu0YxYrKHpZ1jDZCLSlYQL7CyJRyuyGCwETMQjN8Ct9AerZdkfqIk7
 0+xOkcwBf8Of/cSZCRi/PmOoK8yjbeQDnlqPdP0V77ByNCXI1UCpxd4C0ChlAhsX/6U6tCf00rq
 sGi4=
X-Gm-Gg: ASbGncs16IT3btgs5P29LlLb2FmBZ5M3hNTydR530PGG2C8A2WOsCw/wHvEsbO5EQnE
 UuJ04ZiwvRR0V0n9bFQeR4IhWd4L/llBrykbyMZQX+WNzCp6RLLHhUq4d8IvRG+Wcfs9LYG6Yoz
 MpfuJjnLTQ+XCe3hIMJruf4hYPH1uWqyl57AO4RdsfO4Hjjh+JtS2zI1I5ohGQQHi8wZvh/Ag+v
 v1AIvoFlu7IzTY7LcTgIlchmvL82BkxZ0M6Wp33YyTldyPissjZisT4tBzqyQG2Wr9Q0fH2luU8
 vdU7jRMOlwSmQeJl9OXyI71vupUN0ucJyLxzW6FJrj8neCLBz7/jHq0t2A==
X-Google-Smtp-Source: AGHT+IGwnjaRffMPLUKwoxuJ37OBEN4TJ6cPMKPFQ+kLcy5gphGkNcTQiTmS0+0BvmiHw+Ew6v+E9g==
X-Received: by 2002:a17:90b:2883:b0:2ff:52e1:c4a1 with SMTP id
 98e67ed59e1d1-2ff7cf128acmr23019602a91.24.1741627075396; 
 Mon, 10 Mar 2025 10:17:55 -0700 (PDT)
Received: from [192.168.1.67] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f7cebsm8261270a91.45.2025.03.10.10.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 10:17:54 -0700 (PDT)
Message-ID: <0227dd71-5c01-4bde-acf1-8c5c39b46d1e@linaro.org>
Date: Mon, 10 Mar 2025 10:17:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] trace/control-target: cleanup headers and make
 compilation unit common
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, alex.bennee@linaro.org,
 Stefan Hajnoczi <stefanha@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org, philmd@linaro.org
References: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250305050716.3460989-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 3/4/25 21:07, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   trace/control-target.c | 2 --
>   trace/meson.build      | 4 +---
>   2 files changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/trace/control-target.c b/trace/control-target.c
> index d58e84f6dd8..57ceac21084 100644
> --- a/trace/control-target.c
> +++ b/trace/control-target.c
> @@ -8,8 +8,6 @@
>    */
>   
>   #include "qemu/osdep.h"
> -#include "qemu/lockable.h"
> -#include "cpu.h"
>   #include "trace/control.h"
>   
>   
> diff --git a/trace/meson.build b/trace/meson.build
> index c3412dc0ba5..3df45493555 100644
> --- a/trace/meson.build
> +++ b/trace/meson.build
> @@ -1,6 +1,4 @@
> -system_ss.add(files('trace-hmp-cmds.c'))
> -
> -specific_ss.add(files('control-target.c'))
> +system_ss.add(files('control-target.c', 'trace-hmp-cmds.c'))
>   
>   trace_events_files = []
>   foreach item : [ '.' ] + trace_events_subdirs + qapi_trace_events

Hi folks,
gentle ping on this trivial change.

Regards,
Pierrick

