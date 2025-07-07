Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192BEC71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 16:22:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYobS-0008D0-BK; Mon, 07 Jul 2025 12:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYoZ2-0007J1-BD
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:19:32 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uYoYz-0002JQ-I9
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 12:19:31 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3106086f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 09:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751905168; x=1752509968; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OwO3qgmplAmvTzJWzTqIwY5pWYcV09pZ61GL2KQwuXg=;
 b=JufPbg8C48IfU3Dsi/jE9FPDt2JIpxLhoo/XsoEDjemij3nl8UnIn5/WwrP1V5JH9H
 aTH5D9iOzr2l5lSFdQkE/bYDjQnlbo7xB8Hzo/nqSw7Q4xApMqlLoE/qfsX6y8bsbCsC
 kwnQjotX6Emq3wXNRD7HExoq/8ogoMYDJkQRDvaAOJUCJ9yEsf6lri9IjAYwca/ibUH3
 VQUO1FyLz7e5TuI1hYakRF4xjr1SJbeVMLQUtxtCX6ljWJRM2vrorKvar4ta18rsKM2n
 1cSes1ZYtbMYV5ahzpKAYBJoplLfHxZwPFGI6F4vYLFmH+jzMnzU9t1cIzr4FiIxlnly
 UYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751905168; x=1752509968;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OwO3qgmplAmvTzJWzTqIwY5pWYcV09pZ61GL2KQwuXg=;
 b=Ybe5OQv5hFp7iDEN9cBRzNA1wM2xoQWtmHP7K7pYZwRFR/A4cNw9Z3MMurG3ZKQuQe
 JjPTbue+ThBJgYja7PkWhCMCtSvC75w4yrExVbtK58pxcM9dW3aRcigOa92t2XwhOXCB
 vTQsZakO0MquIqu4IpBs8zPmqzPc7V4+5jKF8STJb2P85mPCg0MewSnsN55HASZI2+Xz
 Gf55QkFBeB3NW/wrREBor6XeNSUcTCV1bqU5EAbmBplXmmhy3g5FdmfVUZ6NBCVhH6HA
 UDcD/Kndpxu782z+wdr9ycVhaszgvBPdZFT/Vnt3v7xFoO6HRoGTY8MQxGujnHfKWBmE
 Wz1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6CXLMI6CyaXbTXmwZD7UwiuVYqpU6Ykm6Jmj4M27KeOLt9Pxc5zA9S7sYFyJoNRyJAOyXjXNDmaXz@nongnu.org
X-Gm-Message-State: AOJu0Yz22p9BYWzAjtxOjzHEHIvOHjU9AmHNH1pY58cZ6pbSJbFrr0u4
 9GoOwkAHyw+H2u6pie5U7wTizSjHTb4H9bwJR0H3EDiGBLdkFPR5zro61U6oGmUpKTodFaBNN5U
 dktQ+k8w=
X-Gm-Gg: ASbGnctn4k5Xex5jcfcT/mqTI6H0oIoNwyfUtYXJQ8RMLSCmcjyd6Y8jyKwDzJe4fNa
 8qpSVgacvrgBJWmn416M4FHiXgTQMWW9gdr/c0dVAWUHjuU0UgA9J3Xk5mAIBJhzM0+/vZFv1+J
 WwZ+V9mSSwEIUA8zuASrt5+/gR08WOBKL9GfjU5dd7JhOWlBM9yzPTY0gt5ANQ2A+omG79Dv9Te
 cEjVYj58Ie9rVs34xHC21keAhVWlFCW5y6Ym482hCwkfLUQL8tSySMxdkRo+KFVoueOofETKnpE
 BCyZJrHItBdVuIvP2bU3PbbAuRoE12wyfKXPgLUqrYAcHAMdWrFuDkwU5U+BHxRaPcnCbEelR4I
 8Q06HRc7why2VhvlPoSNfPRUxOOurEA==
X-Google-Smtp-Source: AGHT+IFHduTiAVqsyStHntDadHacKnmlpeIZF7cZ/BT/tCsLSbM/E/A0U+sZ9qGVicwsPuxNQiYPOw==
X-Received: by 2002:a05:6000:1886:b0:3a4:f8fa:8a3a with SMTP id
 ffacd0b85a97d-3b4964fdd22mr10398750f8f.18.1751905167582; 
 Mon, 07 Jul 2025 09:19:27 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b47285c6c9sm10534025f8f.89.2025.07.07.09.19.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 09:19:27 -0700 (PDT)
Message-ID: <3a8ccbda-8102-461c-b11f-fdfc3af81746@linaro.org>
Date: Mon, 7 Jul 2025 18:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/arm: Drop stub for define_tlb_insn_regs
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250707151547.196393-1-richard.henderson@linaro.org>
 <20250707151547.196393-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707151547.196393-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 7/7/25 17:15, Richard Henderson wrote:
> Allow the call to be compiled out by protecting it
> with tcg_enabled.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper.c    | 4 +++-
>   target/arm/tcg-stubs.c | 5 -----
>   2 files changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


