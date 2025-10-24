Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E30FCCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJHY-0006w7-Fl; Fri, 24 Oct 2025 11:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCJH2-0006qV-DV
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:00:13 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vCJH0-0005mO-3p
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:00:11 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47114a40161so22569955e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Oct 2025 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761318008; x=1761922808; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7MdeG1ML9g1LXVZlsg5SbwyGwdvZ+tytjVcJ+yLU230=;
 b=vRMfD56arZCivfqXMEIJug1nep9GDgZ0PiMs4BaqIhCEQzc7zDrXtYAJQUxOqmu29g
 DPc0mf+LbPGIoQqxVsbd5RDXz7+NdfBT7437WLYMGtW2i8Zi5y/ZfyeGgE8q69D00YnH
 WZopGamteeBpcWWS/t+46CAlo9mlbxQHFF9d3NcWym4RmCo1ySa8BOeLPI/KxWlxKPqi
 5u5SjjkD5j3AmXe4dxK16NqpryvN/0oNuOx6fgKAALp9pQkG1KThImgBoRh7lf6Ad1N6
 WiKtF0DTiEYeTnoLAQ5n/khVI+Rj4IALRdDKQPRIOeRtnmQlXM34BLgZiET63APpnKhA
 jRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761318008; x=1761922808;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7MdeG1ML9g1LXVZlsg5SbwyGwdvZ+tytjVcJ+yLU230=;
 b=rq6FgYHWw18dlNkrzMYQLTdhKohWFP6urao4ideAXG+dTTfDXKRcoqfHkHZ0rrgLMc
 GflYDWfu8UMdKG59Z2IQlhCleuivyzAPCvPCTUdimVcHlbqzvOLJNb5vIh34WXyQfJma
 OPTXemRJ0hMIrJQnyUuecisorqJuCL0+V+2Vc0feVnr8FSPEXj2m7PFiIhsBEhYu/6n/
 FsjeQhVahQw05MVfQbfgarJ1ssCYsK9KweipYw/5Oj9KqZZK2VnfUS7+mdFK3ez4tvEA
 i2HaJrswYZJzc8ZJbExx9Wa/pXTCyIezVMEiB/xPqKDJrbYrLUydMZF15nElqyQ+JOvy
 R+Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYjCml1BAYVWBXhe9asSc0B4zN8uESknsYVQLP3kwmcLr7Mh75LiNpMZFnVxUzocXKLKWObrCfyk33@nongnu.org
X-Gm-Message-State: AOJu0YxmSlfM+XczEijUltGMKLUXK+b7cFSMOLcTLlFd7hdDCKnfhlLE
 d0zarzodtrr962uoDN1O68Sws6kYgtTatr9I9B4n6wnekIluT/s0odowoBFMtlP5gmg=
X-Gm-Gg: ASbGncui+LwLnWD7Z7sI98wm8UOIISbS5YN/tZwozfhRY+Ji65opaYVS+GUgAvd5hSx
 nvCI0nMixryz1g56OnWkJgyguDMrQ+uLMKsF2XHYLn2atL/ifor5M0hk/m1n4xYwI/Tt+p6eRkU
 n+g8F8VIpVSwQ9470ijIwEfY4BJ/BFerpWDJ9nYFBs4rrWGjIR8VOH6FyKYVH4JTI9O/6qiMqMt
 Ous2T8mxzqqmAspTyvs+TtnNQ2NFA7C27/mk/Nqy0RCPnHzLMx02cLrMcM0L6CKnV5o+vodnv87
 HtgvvcqNW6ZTYGMrL75yYfN+9K1W3eiXmbQEkbIHcrcJk8do9dsdqCFDMfKoYKGogyHWXmrlSsB
 JPikGht+03Cb3VK/3XIwNlnus5lV6iHqYQsIH8auo9+uNK6e2NiYhOR3hPK8sgkHBGUJ3O+peLj
 nt6P1i924LdXTJlgueg6LD87AgPzJ62I9iXTs3Xq3ra9E4Sc4v3fE6McXWQijLTOBb
X-Google-Smtp-Source: AGHT+IErWOuQYYzr5ATYz1WNvXfjshl0tiH2/Va0b6RvY3Xpqs8AsuODee36cO1uoJdJnEvmBAcv2Q==
X-Received: by 2002:a05:600c:45c9:b0:46e:4b79:551 with SMTP id
 5b1f17b1804b1-47117913764mr217903095e9.31.1761318007890; 
 Fri, 24 Oct 2025 08:00:07 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475cae924a1sm121291775e9.2.2025.10.24.08.00.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Oct 2025 08:00:06 -0700 (PDT)
Message-ID: <51c72cfb-9402-42da-9dc9-ad3c68df77bf@linaro.org>
Date: Fri, 24 Oct 2025 17:00:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 13/25] target/riscv: Introduce mo_endian_env() helper
Content-Language: en-US
To: alistair23@gmail.com, qemu-devel@nongnu.org
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20251023234927.1864284-1-alistair.francis@wdc.com>
 <20251023234927.1864284-14-alistair.francis@wdc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251023234927.1864284-14-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 24/10/25 01:49, alistair23@gmail.com wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> mo_endian_env() returns the target endianness from CPUArchState.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-ID: <20251010155045.78220-14-philmd@linaro.org>
> [ Changes by AF:
>   - Only define mo_endian_env() for softmmu

Oops, thanks!

> ]
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   target/riscv/op_helper.c | 30 ++++++++++++++++++++++--------
>   1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index c486f771d3..6ccc127c30 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -28,6 +28,20 @@
>   #include "exec/tlb-flags.h"
>   #include "trace.h"
>   
> +#ifndef CONFIG_USER_ONLY
> +static inline MemOp mo_endian_env(CPURISCVState *env)
> +{
> +    /*
> +     * A couple of bits in MSTATUS set the endianness:
> +     *  - MSTATUS_UBE (User-mode),
> +     *  - MSTATUS_SBE (Supervisor-mode),
> +     *  - MSTATUS_MBE (Machine-mode)
> +     * but we don't implement that yet.
> +     */
> +    return MO_TE;
> +}
> +#endif


