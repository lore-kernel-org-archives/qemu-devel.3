Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4490FCD4F3C
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2026 18:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOKCw-0004o0-O0; Sat, 16 May 2026 14:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKCv-0004nd-DF
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:57:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOKCt-000692-TC
 for qemu-devel@nongnu.org; Sat, 16 May 2026 14:57:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ba6485d219so6299205ad.3
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778957870; x=1779562670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C4b76RHkeCKrAET1xx2wAIeXsQm/RvqnBkx5ER1t8vg=;
 b=YrfZbPIzR3cngDfomk9chxiqCnzAXj9sJDmuB0BCcHiHoPP3kCsM8uvfKn5gGCrp2W
 zRoJOPpOzygRnSn2xCyP2IJBoPFAQS+epQnN2Gxz/2M2Aw98XAhzE6wFw1Wc53etcFjT
 3zYneJ35ZWe1Y2aRINgASpfQo2kfE7YzHdts6L4ZE7DVGEH+iRH5/ZAM4THhll/DF97Q
 nfshIDSqkS1FGtVIQ6Pdci3BLYI410Jrff1XLaK1yuLmstHeNTlrjaqiGiD8RMfs2ebO
 roeprn66ZZIz6oRvB4MG+Iz+qqFANOUxvaEtN1O95qcKCVnQ+jlTXXaO65I1sR4npw7Q
 xqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778957870; x=1779562670;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C4b76RHkeCKrAET1xx2wAIeXsQm/RvqnBkx5ER1t8vg=;
 b=strbYmTD4+YRtfABk+qr640auoIvQiwKYXWIDfZfmFcZe3hmYj5a6UunH49J8skQHF
 V7PSl3UwnBExCjpRPLO7PsSe1nndcp3lH5FqRfWTY8j2O1aJINkY5efmXjvR0nkS1C8O
 9ZFLt0tj2P4+f7gHIvnKIQD3mCmJbo0/+d5oiMqF2eDeHewEh3MwCSFVQ2bqSG/rIQlZ
 BEKW0UNNovWCUkaAfztwsRqNlRjTvTmocRj4dayBLQcPYQURMHdK83TCBK5Q3CAtGiCz
 fT8QfvhGYVWe4hJ9dLrffdfK/DkThoYnF6qeoIAi1SPhD8N4Pafhb9C2YcpRDnnp/35Y
 OoHw==
X-Gm-Message-State: AOJu0YyIZodqvPJDmhYNz4GFW5VdiAYgPP8iK8o+gh+5yyPPXw9RSkEf
 6w6FW4JqimxJ5O5H7dG2czhJkVa4SQSSmMNEbjKFFwlXqY+gFw9OQ3zKy7dD+ODBjjaZKUwbgu1
 KHdke
X-Gm-Gg: Acq92OFsXluJG1znPpXnHtzXIA8FwTkMF4GCVC5JpsXPO2hO+d2bnuDx8PR8YgorOc8
 0gt6GaLvVL1QPXPHZEJvwRWsB0AZlzvw4mAMzk5Ied0NVy6nezQJo/2ZtjNhKsCOwdxkwjXmAfE
 j+HN8KHQ7DfmtvWgMZN3XbzN3OPPii9G9O5M30b+I/I/SdZGz+kIDHCxaZO5ZGCO79q7zYq6hZm
 r3iODOdD5YvD8VajajgjXlsf+xXRHJ3sm16HTqW4JBtnWcq2/L7Zat/hqNWvH+gs5TWLdhzgouP
 qa9F0OXwzDRfy0GFhmv0Y2DtdQlP76GB4SGXS2xCt1hqEIKq/Uw0/rgHmfTv0LtRLGQYmyDskcD
 tfgJHtzl4HNDmEhHw146bAibM4CdqDxpU3FNRZRvGo6NzEIDj87u+cnFSxPoyveOeNaSpVkwNhU
 t8mEzf6GiC/5CnM/KjKSzt6yEGliq205ZfJVQcY1bSrbQKHfY=
X-Received: by 2002:a17:903:3d52:b0:2b9:f55e:1c1b with SMTP id
 d9443c01a7336-2bd7e85fcacmr72239515ad.5.1778957869923; 
 Sat, 16 May 2026 11:57:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm93072615ad.32.2026.05.16.11.57.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 May 2026 11:57:49 -0700 (PDT)
Message-ID: <a12046da-b077-47ea-a0a7-adcc473bd24e@linaro.org>
Date: Sat, 16 May 2026 11:57:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Set debug in attrs in translate_for_debug()
To: qemu-devel@nongnu.org
References: <20260515131245.366240-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260515131245.366240-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 5/15/26 06:12, Peter Maydell wrote:
> The translate_for_debug method is supposed to return attributes
> that include the debug flag being set. We forgot this when
> implementing the method for Arm.
> 
> Fixes: abefca8e7f957 ("target/arm: Implement translate_for_debug")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/ptw.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 8706dd59dd..0693d2867e 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -3961,6 +3961,7 @@ static bool arm_cpu_get_phys_addr(CPUARMState *env, vaddr addr,
>           /* translation succeeded */
>           result->physaddr = res.f.phys_addr;
>           result->attrs = res.f.attrs;
> +        result->attrs.debug = 1;
>           result->lg_page_size = res.f.lg_page_size;
>       }
>       return fault;

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

