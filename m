Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64752CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 13:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1m1H-0002SP-Se; Thu, 25 Sep 2025 09:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0z-0002JU-Cy
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:28:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1m0m-000466-FE
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 09:28:03 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3ee64bc6b85so967991f8f.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758806864; x=1759411664; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=88Fwn5xnUx7tZ5ZPv6rLCrWD3/gCE81Etjuc84uHykY=;
 b=BzQQEXLk3is7MmXSyl6tT/8S1Cv4JpOlQXCfX4YjJsedG85gq/MECy0u0z+Xq2kvLI
 GjJmMLpA++y8X73VPVUL1ZSCztkPo+lAUueb+XuJ1i/kt9UopH3ZBNNsHXrBuP+4cx7n
 tZypj5aSVE9pGDiBIkOvfjvArl8T2NjFdpgR6/wN4nF8xfy0hnWMVPdWhuatUEbKkB5z
 hcy6pf4sSvlyXvD4ndMAB12ZKHHeqfZh7ZzrAMLRRQl94OS/ITCWC+9BSuMBSg6c97bV
 D7rZiLjscS/bsPFO5b5OPABQohj4mpHNxk+BW5epDPlUaUX9IvjqT8pWJd5feQkd6aHo
 W1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758806864; x=1759411664;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=88Fwn5xnUx7tZ5ZPv6rLCrWD3/gCE81Etjuc84uHykY=;
 b=w9VouNxSkk9GuF2aeWbTwbN2I7DVy7cFvwGZYGs2OwlhhTPcsIGIpsfPAHBAdPb3eS
 Jj0LReB8XmeLMFrRv55D4IbcDiEtVfSHrbwPGUhUYEk8SE3hiQ4J1cukhOpNfzMNBdbM
 6cvxqdXzPfy+8n6CKvnzVb8rMWJlBrx2yyjNpZ+qU+eVmauhiQj3f5kDicwL1Nds/yBw
 Y1LGjJRIRxV/MW1jFBublLYfaHRgKlEpBasndyWytqbBeBN0AuSHXTTt9JC0lbp8UPKW
 6IuSmo6R29tTrbwsKEG6HnmybAJe3NBgON1Pq2MuASeqiv/tZXRwjRPR5NHPEr3bZuCH
 P32Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPRbnU6LRgR7Rx30jDz+TrloNRpt5PaSMIVYupD7somScBjn+w6fdyX4sY9ZY775Y9kELS7VzGm7Uq@nongnu.org
X-Gm-Message-State: AOJu0YwdaTq8LZo4ij5dTaU6Xq43RNaVB7vRIrLx0yLkbbZLj1vj44Li
 CT2v9hodMsg94JU0rTYVN6pVM9/DSHoWRBAmABUp6k+G2fxwrzNotR+Uer/7Jz+QhHM=
X-Gm-Gg: ASbGncsqKSGL5c6IXd8KPc+rDJEBMs24mHchkwwePlV4lM3Lo1sFvutCPNL7UQPR+nR
 KPcYGjrB7ivK6UA6JqBcmS8L85PVsVeGn2TMiMz2zYCweaqVHcgdSe0Q2JwykNPxaRtXxT4D9Dq
 lVLsXlQeXmR89ApmB3eOX5VnOUhRP/tS4gETa+zPlnA/TZDLIS4isLR4RXztJjjqNNgnA1Y6EEx
 PVT1vOpgp9VE1EtIewom6QnmkGb3IYXeNESEKVxC18eumpc8E5BWLsYmYfay2edw+PuBefx+0X7
 Yk/ZZY+rG4hit9757gWMQgBc73d1yBvpu/eQtppmXgq3HBscrXy+xrHp+EN4TLfLjtMFAVNdAQ1
 fQhtRqZQlm9j70XIg9Ihu29LJa3ZaF8nfjvNerNAC3lKfvrp5ELhKHgqqZU8Njhgy9w==
X-Google-Smtp-Source: AGHT+IHEL9bb7cUgE/5XfaFDF1xrXw9BsuHzEguWwJBT1cKUhrxCCw3dQyQqiyK8xs9mYfklrX/N6g==
X-Received: by 2002:a05:6000:2503:b0:3ec:db87:e8a8 with SMTP id
 ffacd0b85a97d-40e481be826mr3422650f8f.37.1758806864403; 
 Thu, 25 Sep 2025 06:27:44 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb89fb19fsm3111464f8f.21.2025.09.25.06.27.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 06:27:43 -0700 (PDT)
Message-ID: <0e26bcc9-c4d2-4e45-bf30-f500f6b7a6db@linaro.org>
Date: Thu, 25 Sep 2025 15:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 34/36] target/arm: Redirect VHE FOO_EL12 to FOO_EL1
 during translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250916142238.664316-1-richard.henderson@linaro.org>
 <20250916142238.664316-35-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250916142238.664316-35-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 16/9/25 16:22, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/cpregs.h            | 22 ++++---------
>   target/arm/gdbstub.c           |  2 ++
>   target/arm/helper.c            | 57 +++-------------------------------
>   target/arm/tcg/translate-a64.c | 12 +++++++
>   4 files changed, 25 insertions(+), 68 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


