Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0DC9C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 16:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWHiQ-0007Fm-6Z; Mon, 30 Jun 2025 12:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHiH-00076a-24
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:50:39 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uWHiE-00014S-GU
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 12:50:36 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-311c95ddfb5so3506816a91.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 09:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751302231; x=1751907031; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LL0eqciu8eYqgzjq/IooTmEzUKZT4CFeFvkC21pTu3w=;
 b=lP3FMOiDH3iJipDLKEuUKmq/GHp/8+xwrAsVVmJScPjSXtXc4L6tva5XcspS0vrLdX
 JhzC80kokiDCfMsPTczWo5FNz14mwnXbl1AndjNLIYhM67Lh4N48t6EbgVARWUzEA2vh
 +LBgHTWQVEMUTLtogKRmZuPPn0T0WTmslmaGZlwoB1Z0UtkSPVztylPUsoDQon2+KnGZ
 Gv+H2WlmAWkXlxTOIBQomrRV8hIFHlh6/lY3+tYNfU4Iu6K93V1nLFo4JBg7C/oSaT0/
 D8SkiC7bSf+xYgI8QVpYY9FuqptuZryJh+n2ekXkN9vyPoo84rG1UA6V+4xrZUnfGYKO
 6g9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751302231; x=1751907031;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LL0eqciu8eYqgzjq/IooTmEzUKZT4CFeFvkC21pTu3w=;
 b=qMwMX+yRCQOJiJEWwaTBFL2rd1UKDDnGI4GmtAlepIbhUER6Z9AC5vmKajlASLDF90
 9SriV9NFi3NLs+6+Rdwwl8FBmEymORru6e5JFW/8Kl9WYQkGwUtb/Yqxq3I69VedB32n
 PWaJ9+Ci4+pCGRv2iP2ZaKdXicsjfNF2CIymieMX2mF0x3jPK7GQSD1LlrpAKxru3VYA
 hokyM8pKHzzfzAlFnYnf5ibd9NlctVNkknwkGbbijEXkdUos2dOLeZHmP0MZeA4KyizN
 Y2dC0JUTt/MEqNBooZl0U8Mj2u3W/fgbVExMmZ2uKCaEcdUX4e2AXL+bNVqsuOZD6vtl
 qCRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd9avNugwhTSDM/XKUI8eGDHFFnFd95qU3mmANn8xZ3w2BAxRk+tc8YlYAA9TY+7rRVa+zRt3XqgRP@nongnu.org
X-Gm-Message-State: AOJu0YxR9jy4oOo1asddqHcmwCDiHc/XHvF3RALx+u8loIu5iAbN9diA
 D6O3LkWilWT+vSuuTU8RTx1G4oB462PdOZXDXp1A0xuwOarb15Kzhu/TEhJn0mW0gWo=
X-Gm-Gg: ASbGncv9j7dXoGBzkKOAIj+TM8Rlads0ct3qHguqlK3XH49YTXsQa89NeXQ0P1iuuQJ
 W+Mx6yhnCpl6eSsNe5CGfTrj5yz24u93jWBmXPAFBplFaFu8e/yymYlojb+Q27GSKYeVbAXltsW
 7rNSYX+T6003aHlluRRamXZF3L1NE1QSrReRJOvfk8u2yWANqjpBQB/E1GqrBvW4gV7SPJDKNh3
 YX+Guap1UpzT5RxPP4gkNdOAjTEJWE+6Ia+gjnvhpqQqh9na82WleyunkFeG/adXCgA+JFJoMyN
 VmLqmrPUU4jXo8qP5/GI/lGi54wZhcWoz9U4QZmf7QU0XULsqIxnCr8yP8vvqRgTc/lIrX23qeA
 =
X-Google-Smtp-Source: AGHT+IFOZj+z1IUr10Ia7sUbajMVaEOJlgToWUG5ryPzPZpwHUkDVH6jeCanHqnJLAp5j6ncdGw69g==
X-Received: by 2002:a17:90b:3ccc:b0:313:db0b:75d8 with SMTP id
 98e67ed59e1d1-318c9305fc4mr17340195a91.32.1751302230779; 
 Mon, 30 Jun 2025 09:50:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-318c1392096sm9534535a91.8.2025.06.30.09.50.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Jun 2025 09:50:30 -0700 (PDT)
Message-ID: <78887cc7-a7d0-4681-b812-1dc34ed68c17@linaro.org>
Date: Mon, 30 Jun 2025 09:50:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] target/arm: Re-use arm_is_psci_call() in HVF
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org
References: <20250630130937.3487-1-philmd@linaro.org>
 <20250630130937.3487-5-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250630130937.3487-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1032.google.com
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

On 6/30/25 6:09 AM, Philippe Mathieu-Daudé wrote:
> Re-use arm_is_psci_call() instead of open-coding it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf/hvf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


