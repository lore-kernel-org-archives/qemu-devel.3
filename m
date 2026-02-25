Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97114FD3774
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHq4-0000KO-PA; Wed, 25 Feb 2026 11:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHq3-0000IT-41
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:34:15 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vvHq0-0007x9-Nj
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:34:14 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4836f363ad2so76041355e9.1
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 08:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772037250; x=1772642050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Ht7ciwueklP6Y6UGKKwAKgTRlo0IjPIrdrV0XGmEaM=;
 b=RPq8yQC2HVW9Q6TzVr8BQApiIj5412M+qnIcfaNl6RIIXPFmKko+406gc7pu+RU27H
 sa75XqRnjSZQ6nnuce8OggbaayjoKe0f+Kb6wkllmSpEM+FxGwguDRuVAEZtmQWDWj8B
 3yRC/rgY04RdEcGdtX2/drLezbH5JiKthD8aZCOGYGB3jOX/SzZJZFGRjFwZ3pVWI7f5
 G0USKI6blXWIAZ0nYLFKfstY7FOfyR1UX8XQxaDjGVoXgs+Tqbc2SVIHG2jHIpGbEX7v
 /PSBqx7KH8uBWyJlbNGkMRFOBLErnfGI0UzuCoGDoWtKGGPYF/nqkXJW7tzLKfszhdES
 ZXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772037250; x=1772642050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Ht7ciwueklP6Y6UGKKwAKgTRlo0IjPIrdrV0XGmEaM=;
 b=tRxrcUG92Rx0Y8+l51MooRhiwUvgqH5AD3JRhxyLSaMPRlKbLCDAj2rjfSqDvZBLJD
 /E0DQ/6/6bx4JxwapQeipTyvPZIY5Za83jD5zQcn4hipGEYgmE8KHBatmH+NNPNV55SV
 fFzrPZjoHhzp1rFkvqqJ4ljSxEAksMAaRMIGIk9O2gXZMYv2FnE5He0t7t9nT7IiU4V9
 1UslMsy9rkuo5kz9XRQKtKt0z+f+HqN2yQdstgForDBaJVv0RaMaB7CLRzAxjVFgpisd
 3de62YKvA/O9E+Yz0yzKxIsUCh1AGKgyJnj8/Wxz6HAg8zmRETSGW81I/uRs0eQeX1lT
 KsEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDhZQNGG1CRbqTztG/AT756H1Zup+7P3IEfUSgtYpvBdkA4xHWqcOzBHvxdeeK8WtPC33WJrdiovdn@nongnu.org
X-Gm-Message-State: AOJu0YzqqHzOiPxfqD9GYV44XkB8752ZvM3EkFxDqkDyIauDNPMw/M6l
 ct3Bng1mnzACfaQ/w22K4DeVlqsZHNlZjV6dfsm5iFguNCEEGzN6NKxeSBXKaKF38OOW0nIwSRC
 KXnVDTxQ=
X-Gm-Gg: ATEYQzxsbvjkgMQ7Y1PAtxV1TwWzNHG8C8Tlwrw0Q4dlbva4pfceBqc9MM8uKaNoeBo
 hJEWOLJ1vA5v1QMLCmWi92JNioQTAH+jO9GSkeE8yp6+97jm07+an03vLaTr877wF+YP+YKb0Ik
 nVbLwH2p+ZGKgZVnK9GvQDGMjzL8B1/iqIAfDTPHtYqTLBCD5G6Bz98LqmsSJY5PkVVSGzONF2w
 MjYxDOFSfecZ+itbrDafIpF6htcvNoQ7GzoHlzrsVdTUZ/ca3ZCUDcoJhAm8ywMzhxQI9l2nKfJ
 0j2t6IfFnrGDfg5WOYCliGf3R3YA2FkJcsRItGZWDgu4xVXlrD/WxMWhXCTIJc6WifXIqQdzqtk
 O6v/dRTq5eXerHfb+GxOvHx7tsm56mh6V+XTiUzb/iGkthvoAn3hLFlq2Lb2bqOVxx7c6chMpiX
 3RbXS9o+GRvfhvxaOqYRFZkTqCbDTzG1yLbPnlFTWCT4o+cp2eVB4M6YDTlSXLT7ZM2QG7FYfzQ
 EHw
X-Received: by 2002:a05:600c:a42:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-483a95f89e5mr319595355e9.31.1772037250367; 
 Wed, 25 Feb 2026 08:34:10 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4398bb96b90sm10671635f8f.9.2026.02.25.08.34.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Feb 2026 08:34:09 -0800 (PST)
Message-ID: <d80cd35d-be73-4b09-9db4-8d2ef07088b3@linaro.org>
Date: Wed, 25 Feb 2026 17:34:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add self as reviewer for PowerPC TCG
Content-Language: en-US
To: Glenn Miles <milesg@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: harshpb@linux.ibm.com, rathc@linux.ibm.com
References: <20260225162118.914008-1-milesg@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225162118.914008-1-milesg@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 25/2/26 17:21, Glenn Miles wrote:
> Added myself as a reviewer for PowerPC TCG
> 
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

