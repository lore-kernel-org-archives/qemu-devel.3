Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C4BC87FD3
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 01:38:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uheiO-0006yk-M0; Thu, 31 Jul 2025 21:37:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheXq-00082G-Vi
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:26:50 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uheXn-0006dO-Vn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 21:26:50 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2403df11a2aso8032745ad.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754011606; x=1754616406; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vAFLFveFnl9hEIcUUREBOvWx+i0TTO48OUICvMS7lZg=;
 b=RvZGkrZfJh6srUjqkdwMZ2UDFWmt6GcH/9H61EHwqqXMOZRdYmU3d88VvnYrzzyTdp
 fQlDiuSzmRvruMeDuQ5gvPEdzTwQzevXROL1M6gj87qOQn2KXx0TtEwesRWl1o4LZ4UB
 26xDho+sYrYJ3f926zAf67J4nSK1h4nrBLi+xcTVtC46GLOBQ6XgFaVyo1Icp4Daa/eF
 Z4SgtzF8gdwKbg3/gsH4Kjvgs7Seqon1dF8kG9Ri9ktBMVhY/C1X/+gDUzWW/ISRILfF
 0qLA0MzyJFyjo2xCy/grnSEHbIy/JSD8pdRezkHENpDhYyQSE9vnIZXp++tt7SpRXBdw
 UrkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754011606; x=1754616406;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vAFLFveFnl9hEIcUUREBOvWx+i0TTO48OUICvMS7lZg=;
 b=kowfbZwF3AuflKH4NUhAxeZP1TkbZutbrA/NhKcBVAzz8W9Ox1CXYpxn9//00FLTUy
 Yw1LJcU+kvqwhr6EKYHtFXbujxNt5pn5tSsudMEfEKoxpPKhItQqCcjg545VeDUUyrf5
 xjEGpx4vMeA47ZP3BdkMINNt1EdnxBwkSij8NrTrOJWorwOG5Pg/TCI1OxS8lOMJyRx+
 hM6o2vbmby8wMVykO9IpRsTOkT9BUOOLdxyAaKKPQG0tsfpj0v0+YP66Vn4ua4iPsiN+
 t0Xwql6AhyRKPfVfU3MWhYr4uk8z2LDbZBgqbKD1aaDS8Q9ByiWMrj973GiYifckEvmW
 JJtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyIKJNMw1ZBudUcIIuHHjbUTffWNQlacjBAR9epFvv2tc36/D/pc8ua161gqNByd9Qs9bpX8WOH03v@nongnu.org
X-Gm-Message-State: AOJu0Yzgs6kQowGbWSWa8NjbPuP7hqGCXSZqvFb9kpNu6eFTNhr0Ifpc
 vmDDN2Y4Wx6ASctFjqrgSYZ3gOY/9kgC6ig8RF0Ee8IhTPgOH+L9Re7zNWPt4fbdR6I=
X-Gm-Gg: ASbGncvUqCd6cDCJBuhwWg1C5FqJ0XzoB7uKe76BpI7cpzGYT0BJ/mUrhy7tU8FQAQ1
 5adiZk8NW3jM5l49zrtat+BINGwbRUBmDRgh8yAzeXqTz4/HnLuOa2PKfW9OlFQ/uGLcaTe/DKL
 +JRrM0A16rrJE8qEkiD5debyRdHO3DNVrBY6eEx0+1mV5PhcDSDbnT8Aj3ipkIRTVOrL3H0wy/Z
 YbvDQZ5kxglt/4cRQ9BaJCx9z6Rymq3VgS/oAkWIj8UjvmLSXrYLtVdK+5esvD+HTC8cr2I8hCP
 Y+ZTK0CJ/Ad8FA9RsTiUqZA3iyEGMu90SYlyfGNjaACQ3SzBy6NyJohUWHetN/Zk8TI9NLN1F0p
 trmhG6pqR4dpaiIMPpmo/njy3SsprVMQO+auxqFqm
X-Google-Smtp-Source: AGHT+IHk2SQ7+cvK7TCjbeCIpuNRqy0GS5UVCRvnaMUapBpXAhgmMJNtIoVoKFv9lmYP/H4sqBZkKw==
X-Received: by 2002:a17:903:1c5:b0:240:14c:c648 with SMTP id
 d9443c01a7336-2422a699bd0mr11855235ad.25.1754011606047; 
 Thu, 31 Jul 2025 18:26:46 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d21dsm28688075ad.139.2025.07.31.18.26.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 18:26:45 -0700 (PDT)
Message-ID: <855c4ee4-e997-42d7-bb2b-95929fd6184e@linaro.org>
Date: Fri, 1 Aug 2025 11:26:37 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] semihosting/arm-compat-semi: compile once in system
 and per target for user mode
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-11-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-11-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/31/25 08:06, Pierrick Bouvier wrote:
> We don't have any target dependency left in system mode, so we can
> compile once.
> 
> User mode depends on qemu.h, which is duplicated between linux and bsd,
> so we can't easily compile it once.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   semihosting/meson.build | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/semihosting/meson.build b/semihosting/meson.build
> index bb0db323937..99f10e2e2bb 100644
> --- a/semihosting/meson.build
> +++ b/semihosting/meson.build
> @@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
>     'stubs-system.c',
>   ))
>   system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
> +  if_true: files('arm-compat-semi.c'),
>     if_false: files('arm-compat-semi-stub.c'))
>   
>   specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
>                   if_true: files('syscalls.c'))
> -specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
> +specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
>   		if_true: files('arm-compat-semi.c'))

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

