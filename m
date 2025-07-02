Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CECEC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWyk7-0004DS-8X; Wed, 02 Jul 2025 10:47:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyjx-00049A-Hj
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:47:14 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWyjs-0007r3-IL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 10:47:13 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-40af40aef06so4533178b6e.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 07:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751467623; x=1752072423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wE2NJhZzfHMjWPw6J95V0JJh24YtdRDgF779MCj/UlA=;
 b=G1z3/evPLZ5RsAS7dwnry6Fb3q1Lk/oqdXaAWeAGIqerMllEdSVSZaJgPUxAeJDRFi
 LdQKz3WtnypErMpX4K9TXWKceZRaGwoycEYCiNyOosh22KnbSO3iGtrlFPDfOvlfT5ha
 0sqwzBqXfi6IfF7hMqKU5os9hZy8m12BTgzRbh4BbOuOQm9m0VV4Pl+9RIRfD8yXK2IO
 dlE8gwBCNB8tnJ/fk5gARt13g8IEdGh9UA34+VbARYyqJt5OuBikXgM7wNEHM73NStTb
 uZwBPuFd78qFqbSGweMsDAxcaefO1lJ5ql7YP3nOkGwE5naCXvb93hSxCLhyfeS6YRyP
 rqXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751467623; x=1752072423;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wE2NJhZzfHMjWPw6J95V0JJh24YtdRDgF779MCj/UlA=;
 b=jfVmHOs6IvwvYAMsTeeZ0g+LnN1A99ptY9yeRcvKS0LbilSJSpU7aAusogq15T7UKl
 gEHA9vsV0M2G45LyDsoO/nBl3Uy3o9rLui2KgnDzTBRApd6R3F4cIpgQuVJqrj4oYzSK
 VTMz2wOk0wbD4JTs7Gu4nZP4DlbtoJMddGYkHZMs2DSB+emEqg551Uw3ATrY5BxybBHU
 +ZKf2SIB5KIMbjPHfaVFVGyiXMDLWt/fTA6NQ9Te2OtarSvu1ZOxCcRhrbQLvi6W9/h7
 S49hEZ8rrYv/PA38KYmEu21L5iRQqDWVomQdaXjH+1GXwOVbDzPVFVwfDVaI1At1IIjd
 4+bw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6lsn2yCU4oX2mTj7ISrMQKfVoRhP3Of3k4FsmrGOVbfKo7tHuPVuuy9iB8w0ZnznduxWSRhQw4pdc@nongnu.org
X-Gm-Message-State: AOJu0Yx5wTxYzH5tq0de8/TVERTg5SMhJM29NcuwrQ9TB+amftI7nZ7d
 XO74SxPSE7gnueYjOgNC1qIpvy9mA6bdRKdDE2btvuXJd9B73IzzrB5qEV3kEJvXFnY=
X-Gm-Gg: ASbGnctDMaSHxD4For/LWxKhkhwxRNmmBcWuozZKhUV9lcuoGyy0YO/0RDLEAr2RWG8
 CoVtCAFxjmE0yc5cT38LK/Kn0U22FnpuUXAm7oLWtMvoDMN/wlcetHSf2nQWJK10IuDfz8oZRIu
 VpMLpfah7aghKUN1CvFRlHSLvsKn0PykkMdDrA9yTNdhWRK090DQ9XyOeqerztSUecpDGXP6a9V
 LScsvLHxH7+f55XIq/OUJCJVmIE06wW2Dt16w9xEtMbgkkwOYng2kdiVg4rBB+DiHjdF8s64XyC
 zgjlk7D/Dzk1mlyBCFjCETBJrGtY2V4y7Zrg/zGh6B97xZBvBpFdeaX/hUKLr++VbyNsFng5IF3
 x
X-Google-Smtp-Source: AGHT+IEjB9wBw4qJ6iTIWRKxbICnlSFcKirktjKsfuSqfVPlwiPpny1NfxzdSfk+XlpOzFi3UyT3fg==
X-Received: by 2002:a05:6808:1b85:b0:408:fbed:c3a5 with SMTP id
 5614622812f47-40b8881836fmr2033959b6e.20.1751467623504; 
 Wed, 02 Jul 2025 07:47:03 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420a6bsm2569065b6e.40.2025.07.02.07.47.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 07:47:03 -0700 (PDT)
Message-ID: <25204232-47f4-430f-9e33-f564e76a9a31@linaro.org>
Date: Wed, 2 Jul 2025 08:47:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] target/arm: Fix VSTR_SG helper store alignment
 checks
To: William Kosasih <kosasihwilliam4@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250702111954.128563-1-kosasihwilliam4@gmail.com>
 <20250702111954.128563-8-kosasihwilliam4@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250702111954.128563-8-kosasihwilliam4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

On 7/2/25 05:19, William Kosasih wrote:
> This patch adds alignment checks in the store operations in the VSTR_SG
> instructions.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1154
> Signed-off-by: William Kosasih <kosasihwilliam4@gmail.com>
> ---
>   target/arm/tcg/mve_helper.c | 30 +++++++++++++++++-------------
>   1 file changed, 17 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

