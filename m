Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E173CC87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 23:15:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhcUq-0003ex-5d; Thu, 31 Jul 2025 19:15:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhcUn-0003cI-Gn
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:15:33 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhcUl-0007Di-QE
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:15:33 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-23fc5aedaf0so8051855ad.2
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 16:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754003730; x=1754608530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lUgFfO4Unu7GcIzAf3QffqhUckDU7c1AbhrqiFNiVWk=;
 b=IxW49CW7mZJeIlaiWLNmSJc+jyLZlnL+omVzvPXFcomFix816esb6usQ/8Ltzk6pjV
 wJhzZThmPmGm7toYYtnQnUC8lLG1+nzWIPYF6BWqx4Px3wqlIwt67gTWwjCeD+QMt3M6
 VGY52brwZccQKanb9yegEoU+ZnisVSDBPjyZ3Ubb7T1Cx39I/hlaJcAwJqI4HTNoyiJW
 AcGgRx0Xc3emuGMk+1CHwsKpCKy6VzJDbR80b4aUM77LTWhJoebcjWKouLSw/491+Gze
 CeXt6bJ/70AFgffOMoywUnJAxe8eUi2zYwvzLTG+cUg7wREV4UCrk+gSTwYMfdEYq6vO
 3EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754003730; x=1754608530;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lUgFfO4Unu7GcIzAf3QffqhUckDU7c1AbhrqiFNiVWk=;
 b=hLhxbGjVLS6mEhAKqTbp09AkL2ySN6UPgjZ/id4TWFBSbbnr5zLZNePGOuuCTUmHel
 ioisZMWd4RiXf5whEDNGSJdPNmenyYFYSmMRImE1Er24iTlS5O0BrhRgvma0ynfCwaxM
 qEIsAONxrglsqZKZsoC9uHankCcbTv3+LsfrGMqYchlHlBvPDXP6l0rI1SpJrufiNfv8
 xNhivxxI3VZbdlbav5VLOKBnKGtfDrRRHzIYVtyEzxfB8qYUqkhWK5+IhbfTMLeVR/fJ
 IIXsRp35UwpBr9JrlHqmBWKrgE1uCquB40kCvaKo3KvgLKftRzt7yiP6qhTSs7N2lmE8
 8ENA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUC5f0jCC4c72fj9DVIA6zcGwXRn/knDcYCFbzovVfwOpRp2s5Uj3pbujE0wjUvfeuSUwfz165v4Rm0@nongnu.org
X-Gm-Message-State: AOJu0YwptvgdflnZjSZ0lHgv0BdbV034GSfVPwBqhlswnGHnKkS+fDlq
 ip8ffP5+A4xAs1sxFQUBp9uZ5fFGVOk5mzVu1DPweaqqRLjVQ7iB/870kNE2VwEA9oU=
X-Gm-Gg: ASbGncsQnb+F741ZkLkJD4Mi15C8RuOx8i/eQhmL6L/JmdcMjGNsIR8HhRTUK6cza7l
 z5akT7rtUGqmjh/iYn6wEL1lg9ZWtX3IFH1Y/Cf4yXVlghbwL9JefDJS01B6KJpO8eLA5fivxcu
 lMayGNQbAi66xctxDQ96i9JpO+zDTL/8w20bUpzFZ2akwH0hUT1OeWjlorLjG1OQq28+WjuToUu
 tKH74xGLde+ghntjW8XwOURJ5KQ/1PNKOTlKy6tCK7j5+D0n12Ppd+kCir/DjduRASrVMVGYBCh
 xaWdKgU2K8hVbaF3pCrQ/ZACGD3CJZX3QCEcqXcjJPgqg4jPzaZKomo7xFB4nDtQS2nhsG+gmRP
 JdNaIyz1uhQVaElafMLJYyCnoll4HrEpsWlneE0Ij
X-Google-Smtp-Source: AGHT+IGnqBoKe5ihThLFBAPFEaNU/O3HricZekqTvfln/4HW43bwcVnTZNhKAqYOY8FdFJaf6gm8cg==
X-Received: by 2002:a17:903:234f:b0:23f:f96d:7581 with SMTP id
 d9443c01a7336-2422a44b2fdmr5328745ad.20.1754003729936; 
 Thu, 31 Jul 2025 16:15:29 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f2193bsm27688625ad.70.2025.07.31.16.15.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 16:15:29 -0700 (PDT)
Message-ID: <d2084fe2-fec6-4fba-858b-2c5df5c36e39@linaro.org>
Date: Fri, 1 Aug 2025 09:15:21 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] semihosting/guestfd: compile once for system/user
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-3-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-3-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index 40dc778529d..33614108094 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -101,6 +101,13 @@ static int gdb_open_modeflags[12] = {
>       GDB_O_RDWR | GDB_O_CREAT | GDB_O_APPEND,
>   };
>   
> +/*
> + * For ARM semihosting, we have a separate structure for routing
> + * data for the console which is outside the guest fd address space.
> + */
> +GuestFD console_in_gf;
> +GuestFD console_out_gf;

These can now be static.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

