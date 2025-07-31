Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557C9C87FD2
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 23:33:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhclw-0005N0-W2; Thu, 31 Jul 2025 19:33:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhclu-0005JD-KB
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:33:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uhcls-0001wt-V5
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 19:33:14 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso276418b3a.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 16:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754004791; x=1754609591; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cusbk8h4iXm2jR5tUfzKzP0NPQDw0lyh5JXYtf2oG1Q=;
 b=Ll0i/fv+PVOVuSpWwiYesNdhoMmYWcYf6cV8ltGHaDmiYW0aEcBU1cICAuS9bWbWWV
 /1NJp1BgEZguM6jWHfQ6JxFkQ5p4mvQAlMn0Y8PREeqVKAWNv3oQJX6QkxCen8Ei2+ik
 /HqwD3wGAwy9ZqSo5Sx+wuAowqp8BaxIRi6mZbneCH+Tgc8K4OMLpEyLMoxlfhhrTLSR
 By7i8TdhhZ/nHh3Oi3091L/q72FljAWOO2NbrEpqjSaQjZ/r/GxjYZ4cZQB6ZHhbKFrX
 F8PVKKiM3Ip/bZvcSudNQObR18FqDmN7VCYN3Eii/62bx95dNx7vQcbA2pNwFlF831lW
 COsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754004791; x=1754609591;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cusbk8h4iXm2jR5tUfzKzP0NPQDw0lyh5JXYtf2oG1Q=;
 b=PzO/QgJCb/HqjN8BuAvkymAFGbSg/B1YKyHn9p/TJEDiWY62qHOeqCIZiEKLX0J4hL
 OHvyaSA7Sgl5r2PNEU0OV+FmIOACx/RaDu/GAKcP4+kdRd2ICw+sxPin7p/iNF4YqkDK
 LgJQQeNeLDYpT0LimDuXCIb3vNQd+rvqVcQUk4TMsi/ZTXgWHEYBUkSYZjtbggYz6ejf
 getdJqHmWs+Sy8vsThWwjTs18DhGB6ffyIfl6ac9Fc59vBXmRg2ZqVM1fX2F783hPMtf
 MJUKKLgXTn+UrVtghApBQK0AXA8rm65PTRD17IHwHyj0BtZR6GrKe2F7iB6JOFgskHOk
 NBMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1sAPl11oRdMlVMs8Q86LS8VjlV4w25vANYRLu14NmOTI0K4XIBAyR4jbE6qLlrZ/P4pS5+UI5nCnC@nongnu.org
X-Gm-Message-State: AOJu0Yzkom/edI6Nc4/QFhsD8AhFgcHQjOBYV3okOWh3NrTVfRzBIrXs
 U8wMck3PA2T78JIWFFdlvLWquZY/mjuOOLDlj+FZPNPuObTvQul7Ge8g/eRAlrpQWKE=
X-Gm-Gg: ASbGncvOcvBZxIGGD4RqJQX4LYqfAGpYJygV6w60sNHv57vyKKxMmsLbqcgHH50puKN
 JNaSt8c4uE8BrzJxqyUrBlf4SZViex5axfWznqQOp2Ab4+qw1CzC7Gd5x5UejQwPgv/VyLokS7u
 DlU/edjTZr3pi/6VdqTgQF6TwsHYgKnB9orX/zgCjl9y/gNuhScBovURtKSKB+gUhFjWb8LXbcp
 9fpy5Jxa6tMyocovHR86TOP+Ex/fGGPBhVerEmlCQITdOshWZnoS0Y22JwTX5SlRaH0cIgbg4xy
 LsLhNw/abBIMlfHWysigxjNZnUojbwPjPRpDYjqTBkMXbt5YTK8cJIXraTiG8AKP+EiEEkSrwos
 dBZqk0NpXPX+XbXH7HyLt+1jy7937WEmSncCLPJYm
X-Google-Smtp-Source: AGHT+IE0faJ0bvCbjT88WZLV1nk3Sr71QsshSqen+buVnpZcVgDt4ETUiyf3r7lzcJeNZIXYqZH40A==
X-Received: by 2002:a05:6a20:a128:b0:23d:de52:a5f0 with SMTP id
 adf61e73a8af0-23dde52afe7mr4502206637.42.1754004791148; 
 Thu, 31 Jul 2025 16:33:11 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd8f8dsm2581563b3a.104.2025.07.31.16.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 16:33:10 -0700 (PDT)
Message-ID: <311fb2d2-b8b2-4b1d-aea6-429fe55f8217@linaro.org>
Date: Fri, 1 Aug 2025 09:33:02 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] semihosting/arm-compat-semi: replace target_ulong
 with uint64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, philmd@linaro.org,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20250730220621.1142496-1-pierrick.bouvier@linaro.org>
 <20250730220621.1142496-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250730220621.1142496-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   semihosting/arm-compat-semi.c | 24 ++++++++++++------------
>   1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
> index e5a665d604b..e3b520631b3 100644
> --- a/semihosting/arm-compat-semi.c
> +++ b/semihosting/arm-compat-semi.c
> @@ -123,7 +123,7 @@ GuestFD console_out_gf;
>    */
>   
>   typedef struct LayoutInfo {
> -    target_ulong rambase;
> +    uint64_t rambase;

vaddr.


> @@ -300,9 +300,9 @@ static void common_semi_seek_cb(CPUState *cs, uint64_t ret, int err)
>    * is defined by GDB's remote protocol and is not target-specific.)
>    * We put this on the guest's stack just below SP.
>    */
> -static target_ulong common_semi_flen_buf(CPUState *cs)
> +static uint64_t common_semi_flen_buf(CPUState *cs)
>   {
> -    target_ulong sp = common_semi_stack_bottom(cs);
> +    uint64_t sp = common_semi_stack_bottom(cs);
>       return sp - 64;
>   }
>   

vaddr.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

