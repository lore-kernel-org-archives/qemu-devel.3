Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89702D78337
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 17:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI9uu-0003aS-5X; Mon, 02 Dec 2024 12:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9ut-0003aJ-8x
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:08:59 -0500
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tI9ur-0003t9-2G
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 12:08:58 -0500
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b66c60584eso284053185a.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733159335; x=1733764135; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Cl7P4u55IK2LK+ymoNMcBQwqim3Aw0u6bM3HYnyfKPE=;
 b=a/UdauviunoKEOTazu7q4/EITSloenAQ3BL0uwhBbI92iCyNHvSCsc/tEcJSv2Sbdg
 JgobMI3WmYm5HlrU7zeCeL8L9g846215wXllAtjq8xsCNaiXnfPpH5pmHioB92fFXiJI
 UhZ5HOSWnKKdoGjkumcksgzKcMniqOU4MxTDEvHZ3e5wiGzhPXHj9qBpy/cifJL3KnVP
 lwP0Eu3EFA1tOhScZtCHSChj21hKoKuqU8QlQ906Ipgjar5PTOFYQK0YpH/e1U3cx3nP
 g+Ks7JQq6V2QnwcIesvcJQH2HFM6hYB+dhsgVXpKbSqAzAMtoXIX0812kK2/RpI0Gn5s
 aFZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733159335; x=1733764135;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cl7P4u55IK2LK+ymoNMcBQwqim3Aw0u6bM3HYnyfKPE=;
 b=wh8qh8vSolzRAUZBikoRc2GUAUgHulBHI+2WrWx7nQB4FcIO0Q+RZPzmOJoTlsh48T
 A/Q4pfQNpfS8IgZl9BOz7QiMnrGP0xqrOf3/z9AF/y7wkdXKcF8EpagWgIRKxb1V2ZqF
 B6EoeO8mau1kMYYaoJun7mrmf/2Uoelvr/9cbTku4BcP1pQmWCHY5zhjbA3wuSQSvzsD
 F/uIbO6QKA/2y2qVxpSw0LowzDN+btbCpg3A3PuYrnZ9QucmuDaKzZbeXYa5TGZXNISB
 FsZFGn8cMpG6teXDSJRY3/mltFdc71wIX6KboRhx37f32PoUKD/omIIitwktcb7eFVxj
 3utg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNH6iOlSD1YYHk/mVWokBdK0vuRmiCC7BSn9tCVb6qRV7To+D0bAtwTLwgQ62toY+xsovTx0FykJL+@nongnu.org
X-Gm-Message-State: AOJu0YzLgyISISAmAfyhm6cpLDuBcG982QzierRShak0SY716E3cTt7d
 pGYBjbvkd4GtSL3nStjHkMJYs3raVLDtnPCM1perqjuNhcSgqfifU/sq8w9qsCwzrV/QGpzBc7H
 VzaU=
X-Gm-Gg: ASbGnctXIyw33X6qobju1NwQejKY0KawJFW47rxgTSs1iZ7ANQfbkXnVcTJeg11MFEQ
 0MjJBN3v2stpz/apkwqgrZSorJmJJ6BH+uLM4mhJE/xQB4z6NIdmw0/VqvQl6gT5ctvXqyyRYB6
 Xk3K4gEEO4592AUqei2izh2vuaTiyCTUUZvU4V8JlsqJ5YciONpjlo8nWRFgtfzZ9TmWJeC886K
 R7XllTC46MguzcquMYRvZp7t2V80192jnntTFYBEXw8vBXhoOww251De5YUstkoSZuJ86g=
X-Google-Smtp-Source: AGHT+IFfvh0Qe9DreIu67c9qC6zoZ3M4SHZpvVKs54GHt4IMCECsComz0xhnOCWiwmpQHO+IxorVKA==
X-Received: by 2002:a05:620a:2715:b0:7a4:d685:caa9 with SMTP id
 af79cd13be357-7b67c46384emr4250969485a.48.1733159335484; 
 Mon, 02 Dec 2024 09:08:55 -0800 (PST)
Received: from [192.168.170.227] ([187.217.227.247])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b68492e03bsm424415785a.38.2024.12.02.09.08.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 09:08:54 -0800 (PST)
Message-ID: <755dab4a-3dd3-45b5-964a-06b347156f5f@linaro.org>
Date: Mon, 2 Dec 2024 11:08:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 for-10.0 14/54] softfloat: Pass have_snan to
 pickNaNMulAdd
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20241202131347.498124-1-peter.maydell@linaro.org>
 <20241202131347.498124-15-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241202131347.498124-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x733.google.com
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

On 12/2/24 07:13, Peter Maydell wrote:
> The new implementation of pickNaNMulAdd() will find it convenient
> to know whether at least one of the three arguments to the muladd
> was a signaling NaN. We already calculate that in the caller,
> so pass it in as a new bool have_snan.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   fpu/softfloat-parts.c.inc      | 5 +++--
>   fpu/softfloat-specialize.c.inc | 2 +-
>   2 files changed, 4 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

