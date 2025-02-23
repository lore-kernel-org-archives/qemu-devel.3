Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013F4C021B2
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 18:04:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmGL2-0001c9-8C; Sun, 23 Feb 2025 13:04:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGKu-0001X2-V1
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:04:17 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmGKt-0002VK-Lj
 for qemu-devel@nongnu.org; Sun, 23 Feb 2025 13:04:16 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-221206dbd7eso72192145ad.2
 for <qemu-devel@nongnu.org>; Sun, 23 Feb 2025 10:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740333854; x=1740938654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vW3cLhyvFEFJS/qsxX3OaNtiSJRojmTiOw6rT07dETk=;
 b=vACO4cZsTxCq/RqHxai5b0v0eApPfzsP2wQj8mHRGeLaln1wvu0KXuCSCerlIV+qCX
 1StTYcEol3a8oFsn/n/pMyZ5l7dqIvTLvYmc9+cKYdZpGa9Dednc8QCyuzio8DoRkRAT
 AZs8+AJn9i8KxquHOLP9vCMYbBsjrwWBK+lYzMd0gwYDIIJHJQ0NrcAfLL6J9QqbAWwz
 +/rplneCFkTWhexJGq7ATkTxyOwHBPvBCd/QYPYUk2ee7p/pTPVWLriLGRKAIe6rGzF8
 bsQtOMTEg9mMFIE6Rgcui1RPiUzWaOOaGIscMCELw/sdChKEETq1qNTv6B+rhAYKTPN5
 q+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740333854; x=1740938654;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vW3cLhyvFEFJS/qsxX3OaNtiSJRojmTiOw6rT07dETk=;
 b=E53X08IbURzvUX4z9ZgJTTVY1zZHdzC672Ztya0yNx8JRA3zl/Ku51XNY0r/T06DGa
 DFAAfvsg9PZXRDkXkcgh55O7VF10O/+fjBhrhyR+5eWGxbccpogQ28uSZG7gz5jSLjWD
 XNvEkVatP4nIDjsCZdnOCwGloix/BfwX1crMSqAeu5sPnV4if5YNwNRdAaIhsvNP8Vrs
 74PosSqYp3//y/QVqMG7hErxQ7Nyb2wVP1ZnnfO+a3bduzuuNqWSGO5U9KLKC7XyDg4M
 v4MoZAC2NrfZCnAe0DMFOoM2sZLyVPKK2LANOaIUoWuQecH9qMqSMi+s064TA8TWJaO2
 9WBA==
X-Gm-Message-State: AOJu0YzTSaTrT3tZjfbRZJTHsmgOcw2KYd719gpmjos2aw2zl/Z/Fk65
 BIL0bmN1TVJeZUNSdpW75LxT6k8Uc5M+HxKO5pfvB26zUn4wSG3yCG9iDzWApU3ddpPeBIwgEGQ
 v
X-Gm-Gg: ASbGncv1GvZ0WRrJMZUa2q9+dJw794RUohil2mPq9/ESRpcRpN48C0uV76xQ0ZJY8/A
 SkayOnQUjRuTY3Gu7T5QnVyp6Vbshu1tjaRKOI8u+U6CHFPa3pp7PjCgYOwYV/ASXabsaqsK4gM
 Gw2bPpNbWHLovOWEk4PNqU1lmkY18fUl6zkk7XRGg1g6x7ITNlDTOvSEmPhTl+jnt8fv2qZaCb8
 kU7L20WJkT3zxNR/ELr7qtGnyq+LTECyCoEU+Mvf9YEacxaoq+l07r3LEzd4g5EhLqpt+VhMmDl
 FgVID8z1rgKttlmO5T21n04tl+6nqBqbiH7ZbiJfjKC2NxqN1pXddxwzV0/A7zeha2s/TQkzG2G
 m8wwy+jA=
X-Google-Smtp-Source: AGHT+IG9oeDjeCxs3ddRpHaOqkCr4RskW7jShjp48jsJ0X8WIKKpn+WQasqv1O536u99jS7naznlRQ==
X-Received: by 2002:a17:903:986:b0:220:ef79:aca9 with SMTP id
 d9443c01a7336-2219ffdfa35mr158392405ad.53.1740333854436; 
 Sun, 23 Feb 2025 10:04:14 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb12dc27sm4996158a91.45.2025.02.23.10.04.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 23 Feb 2025 10:04:14 -0800 (PST)
Message-ID: <50cb77e6-80c2-4375-bfb4-c085cbcb310d@linaro.org>
Date: Sun, 23 Feb 2025 10:04:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] hw/char/mcf_uart: Use FIFO_DEPTH definition
 instead of magic values
To: qemu-devel@nongnu.org
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-8-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220092903.3726-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 2/20/25 01:29, Philippe Mathieu-Daudé wrote:
> Defines FIFO_DEPTH and use it, fixing coding style.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>   hw/char/mcf_uart.c | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

