Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCBEC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 23:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trPom-0001fB-R1; Sun, 09 Mar 2025 19:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trPok-0001eu-Cf
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:12:22 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1trPoi-0005KB-Gc
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 19:12:22 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff694d2d4dso4887329a91.0
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 16:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741561937; x=1742166737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PXRbHu8x90hukYnGU9wlOylN3H1Xir5LCrXpfAMg7Xw=;
 b=q3mZDYi/QuRN30i3gEEO7fKhKF6YSxW4Nv32g4K1xe3Z7ipYHJ/4v7t66KtTsmN9xb
 uyahM70IDc1I7g17PJI0TW+tqqKydzdKtnuxW3skeFjL8GKqdIMa08laeiqymvIXnI7g
 qEJArYiWphzv2TUB7HMYVOu5cpcZ5vhUu6mWDyB1JEKwoTFWD3WUQCt4IanWh6Gy11um
 TQHLK0RSmIwhWUe0EHkmmu1ZRsIMg7uiY7ABw4ieSuHZsoW8WUwIzPJ/ycXpaiCBTgXT
 yWQYOB3RQhtpl0CGQbBkhoikKvX4i8f8tlpv7t8rD0/yQRHGakRMASjLgTawfcI/Htay
 YWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741561937; x=1742166737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PXRbHu8x90hukYnGU9wlOylN3H1Xir5LCrXpfAMg7Xw=;
 b=hmaS9oBnBJloV3WjC8rRBUdweudZX67B+PYddCrCROY3QuG7j5mXZZ5vmnOVnM62P6
 j/HxEXqytNWsbT30ne1LNvX1+kTqecF7hhuMhcaEXGuPz8SJM6VtPhTbWRFizzIx1UAI
 T9yC2zjjJ5YoeuZlDZzm/8T0DTMRaeZiFkSBEG/TBs8Q2Ofn6so4MdbYiNjNKc9avhDo
 c3ZBJOG77+Wvx/NEwyo9egBs8Ozve1fgYnNVDIETdO66Omwi4FZAXFSDuBdbdDHuJYef
 SudN6BkBOHTg8pUnIDKXsO0Y3w3KiLHk/IwgSLI5BGv8itWr2IbaZIpf+h9o5AQUYHOl
 TBPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWND6YtqDUzsysklSPtfiz0FM7KFDBfkdsGv1V67lyEaAnCPmjXcggjLXe0CVEdshiW0BcQxAzfBXJm@nongnu.org
X-Gm-Message-State: AOJu0YxahjCHPCjENnOCy0ctmq2WH6Muhczkj2gCna3ZP0IxQxJkAcC4
 O2iISAvrs61+Pzv3c50o+sv/DwpjEBPlrHYRzZ/6wrq5u4+MVS0DunhpP2rro18=
X-Gm-Gg: ASbGncurzJySmjcrsefoLWzRb4S8vypT+bVvj928ReR8lEtPFSwxpLhekZ4XhgBiiOF
 p5xk8rB/1jXzFq+wENPPCc/WylLNd4AVNCjVoDQF9jrj6ty7dFZQNQP5OEQsUPeGZxYNkxbu8IR
 oPmS+sS9VWfEoQBvNXNo1pg1N0GiQ73bs+jTrSG2iSPfXSGenW7D+g+VKlbgQdfK+YgsbR69qDb
 5bgugxTaJHqSiUxwsKoQ7p/t6VsZgfmn12BzT5VinNw9Ow3f6YA1bmQG8BgNXAIgYUcLI6/Op0M
 JTY6BhEwgcKlTuTCiSGinWSBjcTcAPvxKnOtioC9qiERleSnYLH+WBsnFgY36vXPpE0gRF/NklU
 6JluBv3Dn
X-Google-Smtp-Source: AGHT+IFgK4ql2d39FjgruYYnfjUX2ZW5E2pzZhfQqufbW6AVOyWlIyfZOcm78p7Ei9SmJL5GVsYF8A==
X-Received: by 2002:a17:90b:380e:b0:2ff:682b:b759 with SMTP id
 98e67ed59e1d1-2ff7ce5805bmr19027860a91.7.1741561937490; 
 Sun, 09 Mar 2025 16:12:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693f991fsm7435793a91.48.2025.03.09.16.12.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 16:12:17 -0700 (PDT)
Message-ID: <172cb398-4859-4ed4-9e1b-9f05a88de6f4@linaro.org>
Date: Sun, 9 Mar 2025 16:12:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system: initialize target_page_bits as soon as possible
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250309193712.1405766-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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

On 3/9/25 12:37, Pierrick Bouvier wrote:
> Allow device init functions to use it, which can be convenient in some
> cases (like hw/hyperv/hyperv.c).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   system/physmem.c | 1 -
>   system/vl.c      | 3 +++
>   2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/physmem.c b/system/physmem.c
> index 8df9f30a0bb..c5fb784a9e1 100644
> --- a/system/physmem.c
> +++ b/system/physmem.c
> @@ -3281,7 +3281,6 @@ void cpu_exec_init_all(void)
>        * do this much later, rather than requiring board models to state
>        * up front what their requirements are.
>        */
> -    finalize_target_page_bits();
>       io_mem_init();
>       memory_map_init();
>   }
> diff --git a/system/vl.c b/system/vl.c
> index ec93988a03a..c64f8c8e808 100644
> --- a/system/vl.c
> +++ b/system/vl.c
> @@ -2848,6 +2848,9 @@ void qemu_init(int argc, char **argv)
>       bool userconfig = true;
>       FILE *vmstate_dump_file = NULL;
>   
> +    /* Set target page info before creating machine and associated devices */
> +    finalize_target_page_bits();

This is far too early, and therefore incorrect.

You have to wait until after all possible calls to set_preferred_target_page_bits(). The 
only relevant call is in arm_cpu_realizefn, invoked from the MachineClass.init, invoked 
from machine_run_board_init().


r~

