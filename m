Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13B6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 17:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfLTI-00032F-Jh; Thu, 02 Jul 2026 13:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLTH-00031f-3s
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:45:07 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wfLTE-00046N-D6
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 13:45:06 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-8454160043aso1790195b3a.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 10:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783014303; x=1783619103; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m0Nt2WiaEP1V9mcIUXbZ6ll0ZPkN2EnWIeSREWFGiUo=;
 b=kzFC/ofnrLxWBUBFZIEoksUErafC7mVOErfnvAvYtlMMGk9SwL4QY1JZ3uPbizH/ok
 ROUaWkOAcHKxewZtLcxyHS+MhmT8tNcYDKvOLVoLoiUej8/XdQWs9uTimcsU+j4P7a64
 xxydJ6pIKLORdC70X4cwiXP67wIUgZL+LIF2EvgJxQWyCdjQiUM9E8AX60ZyBD9CzjHW
 +jYpr5/JKJAXstdvq0Q3hGeO4GnsNM1RYGGF6uxReW14EyC/enhW0hs5Yx/MiECH+P0H
 hBaAPilJo3tGIB7y8bhcf7u+HYy1OYNxPMW5crs4aiFRQZ4R7l6IabXTQ8irPsWwh252
 w7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783014303; x=1783619103;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m0Nt2WiaEP1V9mcIUXbZ6ll0ZPkN2EnWIeSREWFGiUo=;
 b=NuvugfIpEmfvzSJ3YX8PQvCQwbj7dJO9ky8QXuPk3UQJ9xFkQogDMz3Jr7eesGTXFH
 HJdtmk9QcjXYsCaOAFArHB7s62l0YFFu5b3R8LMs3yexcpd5gEj1lZj6yo9a/xZQlp4t
 oaUqergW7HKFAMjgLOlAk1sq5HOpkAC/D7PHdSjjCpFQXQfAG5tpV3Un7vofXMbOjRSS
 WF+oimTXA9QTDMuEGEKVb8tblKLX4hx3BHbARfZqd7V0qqS+X3NXedLszAbmINO9eegV
 wC1l0b2AxPWYXX49I9kaXrBLN+CCGWAnAY6G3fSNRPiRQB/1cprfVf8nnjPVfTT10hNZ
 LUZw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrWkjuC/e9pKZ2oSuCJENJFlSmAYRoON9zYZ0SHkXJLcEIW0r42mlxU9KUz7SKneMTQIkPubSu6IbfA@nongnu.org
X-Gm-Message-State: AOJu0Yz+mCUNkhhZd9t9blG/9rfFn+K6C4Zw6R9/CF4dfjBngbIAtbc+
 eYXyM0fLEK2jUxrHrP1189PuUW3naF4ThxXKGx/6H0ZyOEU9gfE5alGeJum6/2PtSeA=
X-Gm-Gg: AfdE7clmTCG/OKoSNpXpwWkbXsGWNg8EhZ8pa2DTX8I1xW60apG9UCNMkIPZvzfZjS4
 8GgQ9280a0k2Nvm3cSFNtimKglEd5zGfFmTz7n+DMZ9L5WJ7uaKE3DWLyZVjm34iAHQ83juULSt
 GV88ZWDI7sPNylmeTOL5eHzdHJq45wwLkWTA+PZcCYfz99+b7fqQ9ziTIBemrk/nQ52z/QDhm4Z
 3y77MRsleJxjA0JRJ6MNvLnZyfP+djTS+b0dECq5fT//SGGjpFvUbjBG425GW2pjNrOlnYw4cL+
 Dvwc55OdtvvMzBLosCFTR6aEgVvok60n9AHGZ8a2Rwj27VCXFoW96s/8yRB4LqeCseivS7cH8ZK
 rovHgZUPs0EZw6PbWwRfOvWyOdeTWsl94v0kaqiWwpgZpllyQct4KkLec9BgqyAAnVz9v5leoMe
 NpR3nJRI07MPuYkwlupcimHNRE+94PoRklkRTdvxLyk44ckDHbL4FY/EoHWA==
X-Received: by 2002:a05:6a00:7610:b0:847:973b:3d04 with SMTP id
 d2e1a72fcca58-847c0753e4fmr5762522b3a.10.1783014302793; 
 Thu, 02 Jul 2026 10:45:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc1afsm1736685b3a.6.2026.07.02.10.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 10:45:02 -0700 (PDT)
Message-ID: <d2e8b64b-f268-405d-b053-55642106ca93@linaro.org>
Date: Thu, 2 Jul 2026 10:45:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/33] accel: Remove unnecessary 'inline' qualifier in
 remove_all_breakpoints
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
 <20260630220100.1289-20-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260630220100.1289-20-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/30/26 15:00, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   accel/tcg/tcg-accel-ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
> index 26d34c72d9a..c54acc770e3 100644
> --- a/accel/tcg/tcg-accel-ops.c
> +++ b/accel/tcg/tcg-accel-ops.c
> @@ -188,7 +188,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
>       }
>   }
>   
> -static inline void tcg_remove_all_breakpoints(CPUState *cpu)
> +static void tcg_remove_all_breakpoints(CPUState *cpu)
>   {
>       cpu_breakpoint_remove_all(cpu, BP_GDB);
>       cpu_watchpoint_remove_all(cpu, BP_GDB);

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

